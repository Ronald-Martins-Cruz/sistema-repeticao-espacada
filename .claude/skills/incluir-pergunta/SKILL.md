---
name: incluir-pergunta
description: Protocolo para adicionar pergunta(s) nova(s) ao banco de estudo em estudo.db. Use quando o usuário quiser incluir, criar ou cadastrar uma pergunta nova (ou várias), vincular uma pergunta a uma prova real, ou desativar uma pergunta existente.
---

# Incluir pergunta nova — leia antes de inserir

Não existe mais pipeline de importação (`perguntas.md` → `importar.py`).
Pergunta nova entra **direto por SQL**, nesta conversa, sem passar por
markdown. `estudo.db` (SQLite, na raiz do projeto) é sempre com `PRAGMA
foreign_keys = ON;` nas escritas.

**Não escreva `ponto_chave` nesta conversa.** Gabarito se prepara em conversa
separada, pela seção "Preparar o gabarito de uma seção" da skill `estudo` — ver
regra 7 do `CLAUDE.md`. Gabarito escrito contaminado por ter visto a pergunta sendo
criada não é o problema aqui (a pergunta ainda não tem resposta), mas manter a
separação evita hábito de misturar as duas conversas.

## A escala de profundidade D0–D5

Cada nível é definido pela **família de distrator da FGV que a resposta
derruba**. É esse o teste que torna a etiqueta verificável: se a pergunta não
elimina o distrator daquele nível, ela não é daquele nível.

| Nível | Exige | Distrator que derruba | Exemplo na prova |
|---|---|---|---|
| **D0** | ligar nome a uma característica única | o nome trocado dentro de uma lista de nomes | Q48 (Flutter/Dart), Q58 |
| **D1** | enunciar o que o conceito é | a definição inventada ou deslocada de finalidade | Q59 (objetivo do ETL), Q70 |
| **D2** | separar o conceito do vizinho | **a troca de lugar entre dois conceitos irmãos** | Q41, Q44, Q50, Q65, Q67 |
| **D3** | pertinência a conjunto fechado, número, prazo | o item plausível que não pertence ao rol; o número alterado | Q63, Q64, Q56, Q38 |
| **D4** | decidir a partir de cenário ou código | a decisão correta na teoria, errada naquele caso | Q45, Q49, Q54, Q68, Q69 |
| **D5** | explicar o mecanismo, derivar a consequência | (a prova não usou — nível de reserva) | ausente |

Perfil medido da prova real (questões 36–70, DATAPREV/FGV 2024): D0 11% · D1
9% · **D2 34%** · **D3 26%** · D4 20% · D5 0%. Mediana D2/D3, centro de
gravidade em fronteira entre conceitos vizinhos e rol exato.

Cada seção deveria subir **D1 → D4**, cobrindo o nível que a prova usou
naquele conceito e passando um degrau além. Seções em que a FGV chegou ao D4
merecem também uma pergunta D5.

## A âncora híbrida

Toda pergunta nova é calibrada contra uma referência:

- **Conceito que caiu numa prova real** → contra a questão específica
  (registrada como `ancora`, ver protocolo abaixo). A profundidade diz se a
  pergunta está no nível daquela questão, abaixo ou acima.
- **Conceito que não caiu** → contra o perfil global da prova-alvo. O alvo é
  a mediana D2/D3, com escada até D4.

Perguntas nascidas de alternativa errada de uma prova real são as mais
valiosas justamente por isso: banca recicla distrator. Marque-as
`eh_distrator = 1`.

## Protocolo de inserção da pergunta

1. **Checar duplicidade** antes de inserir — busque em `v_catalogo`
   enunciados parecidos na mesma seção:

   ```sql
   SELECT codigo, enunciado FROM v_catalogo WHERE secao = '2.7';
   ```

2. **Próximo código:**

   ```sql
   SELECT COALESCE(MAX(numero),0)+1 FROM pergunta;
   ```

   O resultado é ao mesmo tempo o `numero` e, prefixado com `'Q'`, o
   `codigo` (`'Q243'`) da pergunta nova.

3. **Inserir:**

   ```sql
   INSERT INTO pergunta (codigo, numero, secao_id, enunciado, eh_distrator, eh_caso, profundidade)
   VALUES (
     'Q243', 243,
     (SELECT id FROM secao WHERE codigo = '2.7'),
     'Enunciado da pergunta...',
     0, 0, 'D2'
   );
   ```

   `secao_id` sempre vem de `SELECT id FROM secao WHERE codigo = 'n.n'` — os
   códigos de seção estão em `secoes.md`. `profundidade` deve respeitar o
   `CHECK` da tabela: `D0` a `D5`, ou `NULL` se ainda não classificada.

   Um `agendamento` é criado automaticamente por trigger — não insira nessa
   tabela.

## Vincular a uma prova real (âncora), quando aplicável

Só faça isso se a pergunta se origina de uma questão de prova real
específica (calibração ou distrator).

1. A prova já existe em `prova`? Confira:

   ```sql
   SELECT pv.id, b.nome, pv.orgao, pv.ano, et.id AS etapa_id, et.nome AS etapa
   FROM prova pv
   JOIN banca b ON b.id = pv.banca_id
   JOIN etapa et ON et.prova_id = pv.id
   WHERE pv.orgao = 'DATAPREV' AND pv.ano = 2024;
   ```

2. **Se não existir**, pergunte ao usuário banca, órgão, cargo, ano e status
   antes de criar — não presuma. Depois:

   ```sql
   -- só se a banca também não existir
   INSERT INTO banca (nome) VALUES ('Cebraspe');

   INSERT INTO prova (banca_id, orgao, cargo, ano, data_aplicacao, status, relevancia)
   VALUES (
     (SELECT id FROM banca WHERE nome = 'Cebraspe'),
     'BACEN', 'Analista - Área 2', 2024, '2024-11-24',
     'referencia', 'secundaria'
   );

   INSERT INTO etapa (prova_id, nome, formato, ordem)
   VALUES (
     (SELECT id FROM prova WHERE orgao = 'BACEN' AND ano = 2024),
     'objetiva', 'certo_errado', 1
   );
   ```

3. **Registrar a âncora:**

   ```sql
   INSERT INTO ancora (pergunta_id, etapa_id, numero_questao)
   VALUES (
     (SELECT id FROM pergunta WHERE codigo = 'Q243'),
     (SELECT et.id FROM etapa et JOIN prova pv ON pv.id = et.prova_id
      WHERE pv.orgao = 'DATAPREV' AND pv.ano = 2024 AND et.nome = 'objetiva'),
     44
   );
   ```

   **`ancora.numero_questao` é o número da questão *na prova real* — um
   espaço de numeração completamente diferente e independente de
   `pergunta.numero`/`codigo` (a numeração interna do banco).** Q243 do banco
   pode ancorar na questão 44 de uma prova; não confunda os dois números.

## Seção nova, quando necessário

30 seções fixas hoje — inserir uma nova é raro. Sem pipeline de import,
também é `INSERT` direto:

```sql
INSERT INTO secao (parte, codigo, titulo, ordem) VALUES ('II', '2.23', 'Título da seção', 23);
```

Atualize `secoes.md` à mão em seguida — esse arquivo é só leitura de
referência, não é importado por nada.

## Desativar uma pergunta

```sql
UPDATE pergunta SET ativa = 0 WHERE codigo = 'Q94';
```

Antes isso acontecia sozinho quando a pergunta sumia do `perguntas.md`; agora
é sempre uma ação explícita. Histórico (`resposta`, `avaliacao`,
`agendamento`) permanece intacto — a pergunta só sai de `v_fila`, `v_fila_fraquezas`
e das contagens de `v_progresso`/`v_cobertura`, que filtram `ativa = 1`.

## Ao terminar

Ofereça o commit do banco: `git commit -m "Q243–Q245: seção 2.7" estudo.db`
