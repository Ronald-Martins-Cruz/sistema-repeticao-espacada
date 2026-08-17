---
name: estudo
description: Protocolo do sistema de estudo por perguntas discursivas em estudo.db (concurso FGV/DATAPREV). Use quando o usuário quiser estudar, revisar, responder perguntas, retomar a fila do dia, ver o progresso ou a calibração, e também quando quiser preparar os gabaritos (pontos-chave) de uma seção. Leia antes de enunciar qualquer pergunta.
---

# Protocolo de estudo — leia antes de fazer qualquer pergunta

Sistema de estudo por perguntas discursivas. O banco é `estudo.db` (SQLite, na
raiz do projeto). Você opera direto por SQL:

```sh
sqlite3 estudo.db "SELECT * FROM v_progresso;"
```

Sempre com `PRAGMA foreign_keys = ON;` quando a instrução envolver escrita.

O ponto do sistema: **quem responde não é quem corrige.** Em flashcard a própria
pessoa julga se acertou, e é exatamente aí que a ilusão de saber se instala — o
usuário lê o gabarito, reconhece o conteúdo e conclui "eu sabia". Aqui a correção
é sua, contra um gabarito que já estava gravado antes da resposta.

Duas atividades cabem aqui, e **nunca na mesma conversa**: a **sessão de
estudo** — perguntar, corrigir, registrar — e o **preparo de gabarito** —
escrever os pontos-chave de uma seção, que é o que coloca perguntas novas em
circulação. Consertar um ponto-chave específico que se mostrou ruim durante a
correção é exceção: isso se faz na própria sessão, depois da nota (regra 7).

## A prova é objetiva. O formato discursivo é método, não espelho

Múltipla escolha, banca FGV, 70 questões. **Não existe questão discursiva na
prova.** Escrever a resposta por extenso é escolha do usuário, por dois motivos:
produzir do zero fixa mais do que reconhecer alternativa, e resposta escrita
expõe o buraco que a alternativa certa taparia por reconhecimento.

O que isso muda na sua conduta:

- **Não dê feedback de redação.** Nada sobre estrutura, introdução, coesão,
  clareza ou tamanho do texto. Resposta telegráfica com todos os pontos-chave
  vale 5; parágrafo bem escrito sem os números vale 3.
- **Corrija o que a banca cobra:** número exato, prazo, percentual, rol completo,
  nome correto e — principalmente — a fronteira entre termos vizinhos. O padrão
  da FGV nesta prova é **trocar conceitos de lugar** (Spring Boot ↔ Spring Cloud,
  intranet ↔ extranet, OLTP ↔ OLAP, ETL ↔ ELT). Saber o que o termo **não** é
  elimina 3 ou 4 alternativas.
- **Perguntas `[distrator]` nasceram de alternativas erradas da prova** e são as
  mais valiosas justamente porque a prova é objetiva: bancas reciclam distrator.
  Erro em pergunta de distrator é erro caro.

## Regras que não se negociam

1. **Nunca mostre o gabarito antes da resposta.** Para enunciar uma pergunta, use
   `v_fila` ou `v_fila_fraquezas` — elas não expõem nenhuma coluna de
   `ponto_chave`. Só consulte `v_gabarito` depois que a resposta estiver gravada
   em `resposta`.
2. **Ordem fixa: corrigir → gravar nota → perguntar confiança → revelar.** Não
   revele a nota antes de perguntar a confiança. O banco recusa gravar confiança
   em resposta que ainda não tem nota.
3. **Grave a resposta na íntegra**, sem resumir, corrigir ortografia ou
   reescrever. É o texto do usuário que vai ser reavaliado meses depois.
4. **"Não sei" é nota 0 registrada, nunca pergunta pulada.** Resposta em branco é
   o dado mais informativo do banco.
5. **Não invente pergunta nem escreva em `agendamento`.** Só use enunciado que
   veio do banco. Um trigger cuida do SM-2 sozinho ao inserir a avaliação; se
   você escrever em `agendamento`, quebra o cronograma.
6. **Uma pergunta por vez.** Não enfileire três perguntas numa mensagem só.
7. **Não mexa no gabarito de uma pergunta que está com resposta sem nota.** Essa
   janela — resposta já lida, nota ainda não gravada — é onde o critério se
   molda ao que o usuário escreveu e a nota infla; `v_auditoria` acusa como
   `gabarito_contaminado` e o banco recusa o `INSERT`/`UPDATE`. **Depois da nota
   gravada, consertar um ponto ruim é permitido e desejável** — ver "Corrigir um
   ponto-chave inadequado". A nota já é imutável: não há o que inflar.
   Escrever gabarito **novo** de uma seção continua sendo conversa separada — é
   outra atividade, não conserto. Se faltar gabarito no meio de uma sessão,
   encerre e peça uma conversa nova para prepará-lo.

## Sessão de estudo

Perguntar, gravar, corrigir, revelar. Um ciclo por pergunta.

### Passo 0 — abrir a sessão

```sql
INSERT INTO sessao (modo, filtro) VALUES ('revisao', NULL);
SELECT last_insert_rowid();
```

`modo`: `revisao` (SM-2, o padrão), `fraquezas`, `secao`, `simulado` ou `livre`.

Mostre o panorama antes de começar: `SELECT * FROM v_progresso;`

### Passo 1 — escolher e enunciar a pergunta

```sql
SELECT codigo, secao_titulo, enunciado, pergunta_id FROM v_fila LIMIT 1;
-- ou, no modo fraquezas:
SELECT codigo, secao_titulo, enunciado, nota_media, pergunta_id
FROM v_fila_fraquezas LIMIT 1;
```

Enuncie o texto **exatamente como está**. Não adicione dica, não reformule, não
diga de que seção é se isso entregar a resposta, e não mencione se é distrator ou
caso. Anote o horário para preencher `segundos` depois.

### Passo 2 — gravar a resposta

Apóstrofo no texto vira `''`. Se a resposta for longa ou cheia de aspas, escreva
num arquivo e use `CAST(readfile('resp.txt') AS TEXT)`.

```sql
INSERT INTO resposta (pergunta_id, sessao_id, perguntada_em, texto, segundos)
VALUES ((SELECT id FROM pergunta WHERE codigo='Q2'), 1,
        '2026-07-22 15:00:00', 'texto integral da resposta, sem editar', 180);
SELECT last_insert_rowid();
```

### Passo 3 — corrigir, gravar, **sem mostrar**

Agora sim leia o gabarito:

```sql
SELECT ponto_chave_id, ordem, descricao, fonte, essencial
FROM v_gabarito WHERE pergunta = 'Q2';
```

Confronte ponto a ponto e aplique a régua:

| nota | veredito | critério |
|---|---|---|
| 0 | `branco` | não respondeu, ou "não sei" |
| 1 | `errado` | o núcleo da resposta está conceitualmente errado |
| 2 | `vago` | reconhece o tema mas não sustenta nenhum ponto-chave |
| 3 | `parcial` | acertou pontos, mas faltou ao menos um essencial |
| 4 | `bom` | todos os essenciais presentes; faltou acessório ou precisão |
| 5 | `completo` | todos os pontos-chave, com os números e nomes corretos |

Nota 4 ou 5 exige **todos** os `essencial = 1` marcados como `citou` —
`v_auditoria` acusa violação como `nota_incoerente`.

Número trocado ou termo confundido com o vizinho derruba a nota mesmo com o resto
impecável — numa prova objetiva, é o que decide a questão inteira. Seja rigoroso:
uma nota inflada hoje custa a pergunta sumindo do cronograma por 40 dias.

```sql
INSERT INTO avaliacao (resposta_id, nota, veredito, feedback)
VALUES (12, 3, 'parcial', 'Acertou os tres graus, mas trocou o prazo do secreto.');

INSERT INTO avaliacao_ponto (avaliacao_id, ponto_chave_id, status) VALUES
  ((SELECT last_insert_rowid()), 4, 'citou'),
  ((SELECT last_insert_rowid()), 5, 'errou');
```

O trigger SM-2 reagenda a pergunta sozinho. Você não toca em `agendamento`.

Se o gabarito usado ainda estiver com `revisado = 0`, avise ao revelar.

### Passo 4 — perguntar a confiança

Só agora, e **sem ter dito a nota**:

> De 1 a 5, quanto você confia que acertou essa?

```sql
UPDATE resposta SET confianca = 4 WHERE id = 12;
```

Se o banco recusar, é porque a nota ainda não foi gravada — volte ao passo 3. A
ordem existe porque, se você souber a confiança antes de corrigir, você ancora:
"ele disse 5, deve estar certo". Com a nota já gravada e imutável, ancorar fica
impossível, não apenas desaconselhado.

### Passo 5 — revelar

Mostre, nesta ordem: a nota e o veredito; o que faltou, ponto a ponto, com a
`fonte` de cada omissão; e a resposta modelo. Se `confianca - nota >= 2`, diga
isso explicitamente — é onde o usuário perde ponto na prova sem perceber.

Depois, cheque se algum ponto-chave dessa pergunta acabou de cruzar o limiar de
falha sistemática:

```sql
SELECT descricao, sugestao, vezes_avaliado, pct_falha, status_mais_recente
FROM v_sugestao_ponto WHERE pergunta = 'Q2';
```

Se vier alguma linha, mostre como nota informativa. `v_sugestao_ponto` só
sugere — a decisão é do usuário. Se ele decidir tirar o ponto, faça na hora
(logo abaixo); se a sugestão for "pergunta dedicada", isso é escrever pergunta
nova — trabalho da skill `incluir-pergunta`, em outra conversa.

### Corrigir um ponto-chave inadequado

Ler a resposta contra o gabarito é justamente quando se enxerga que um
ponto-chave está mal feito: cobra o que o enunciado não pede, empacota dois
fatos numa frase só, está errado na fonte ou repete outro ponto. **Conserte
aqui mesmo, depois de gravar a nota** — nunca antes (regra 7). Com a nota já
gravada e imutável, mexer no gabarito não infla nada.

Ponto-chave não se apaga nem se reescreve: **desativa-se, com motivo**, e o
substituto entra apontando para ele. Assim `avaliacao_ponto` continua
respondendo o que foi cobrado em cada correção passada.

```sql
-- 1. desativar o inadequado (motivo é obrigatório — o banco recusa sem ele)
UPDATE ponto_chave
SET ativo = 0,
    motivo_desativacao = 'cobrava dois fatos na mesma frase: prazo e autoridade'
WHERE id = 42;

-- 2. substituto, quando houver. Ordem nova: a antiga fica com o desativado
INSERT INTO ponto_chave (pergunta_id, ordem, descricao, fonte, essencial, substitui_id)
SELECT p.id,
       (SELECT MAX(ordem) + 1 FROM ponto_chave WHERE pergunta_id = p.id),
       'cita que o prazo do ultrassecreto e de 25 anos',
       'LAI art. 24, §1º, I', 1, 42
FROM pergunta p WHERE p.codigo = 'Q2';
```

O substituto pode ficar para a conversa de gabarito — desativar sozinho já
tira o ponto ruim de circulação. `v_ponto_desativado` lista o que foi
desativado e, com `substituto_id IS NULL`, o que ainda falta reescrever:

```sql
SELECT pergunta, descricao, motivo_desativacao, vezes_cobrado, substituto_id
FROM v_ponto_desativado WHERE substituto_id IS NULL;
```

O que o banco impõe sozinho, sem depender do seu protocolo:

- `DELETE`, e `UPDATE` de `descricao`/`fonte`/`essencial`/`peso`, são bloqueados
  em ponto já cobrado numa avaliação — a nota foi dada contra aquele texto.
  `revisado` e `ordem` seguem editáveis.
- desativar sem `motivo_desativacao` é recusado; `desativado_em` é carimbado
  sozinho. Reativar (`ativo = 1`) limpa os dois — é o desfazer de um engano.
- inserir ou desativar ponto de pergunta com resposta **sem nota** é recusado.

Se todos os pontos de uma pergunta forem desativados, ela sai de `v_fila` até
ganhar gabarito novo. É o comportamento certo: não há contra o que corrigir.

### Passo 6 — encerrar

```sql
UPDATE sessao SET encerrada_em = datetime('now','localtime') WHERE id = 1;
SELECT * FROM v_auditoria;   -- tem que vir vazia
```

**Sempre informe os próximos agendamentos ao fechar a sessão**, em tabela — uma
linha por data, com a quantidade de revisões daquele dia. É o que o SM-2 acabou
de reagendar; sem isso o usuário não sabe qual é a carga dos próximos dias.

```sql
SELECT a.proxima_revisao AS data, COUNT(*) AS revisoes
FROM agendamento a
JOIN pergunta p ON p.id = a.pergunta_id
WHERE p.ativa = 1
  AND a.proxima_revisao >= date('now','localtime')
  AND EXISTS (SELECT 1 FROM ponto_chave pc
              WHERE pc.pergunta_id = p.id AND pc.ativo = 1)
GROUP BY a.proxima_revisao
ORDER BY a.proxima_revisao;
```

O filtro repete o de `v_fila` de propósito: só conta pergunta ativa e com
gabarito, que é a que vai de fato ser servida. `>= hoje` inclui o que ainda
sobrou para hoje.

| Data | Revisões |
|---|---|
| 2026-08-18 | 6 |
| 2026-08-23 | 2 |
| 2026-08-29 | 8 |

Ainda no fechamento, confira se há pergunta arquivada pedindo para voltar:

```sql
SELECT * FROM v_reativacao_sugerida;
```

Vazia → silêncio, não comente. Com linhas → apresente a tabela e **pergunte**:

| Seção | Título | Perguntas |
|---|---|---|
| 2.16 | Blockchain | 6 |
| 2.18 | Inteligência Artificial | 4 |

São perguntas boas que foram arquivadas como `fora_de_foco` por serem de outro
concurso, e cujo alvo já acabou. **Nunca reative por conta própria — regra 8.**
Aprovado, reative uma seção por vez (o `UPDATE` está na skill
`incluir-pergunta`): elas voltam ao topo da fila, porque ficaram atrasadas
durante o arquivamento, e uma seção por vez controla o tamanho do lote que fura
a fila.

Feche com o resumo da sessão, essa tabela, e ofereça o commit do banco:
`git commit -m "sessão 11/08" estudo.db`

## Preparar o gabarito de uma seção

Escrever os `ponto_chave` das perguntas que ainda não têm gabarito. Conversa
separada, nunca no meio de uma sessão de estudo — regra 7.

### Ver o que falta preparar

```sql
SELECT * FROM v_cobertura WHERE com_gabarito < perguntas;
```

Pegar os enunciados de uma seção:

```sql
SELECT p.codigo, p.enunciado
FROM pergunta p JOIN secao s ON s.id = p.secao_id
WHERE s.codigo = '1.1' AND p.ativa = 1
  AND NOT EXISTS (SELECT 1 FROM ponto_chave pc
                  WHERE pc.pergunta_id = p.id AND pc.ativo = 1)
ORDER BY p.numero;
```

Esta conversa é também onde se reescreve o que foi desativado numa sessão. O
motivo registrado diz o que consertar:

```sql
SELECT pergunta, secao, descricao, motivo_desativacao
FROM v_ponto_desativado WHERE substituto_id IS NULL;
```

### Escrever os pontos-chave

Para cada pergunta, de **3 a 6 pontos-chave**. Um ponto-chave é uma exigência
verificável, não um resumo da matéria:

- ✅ `cita que o prazo do ultrassecreto e de 25 anos`
- ✅ `distingue desclassificacao de reavaliacao`
- ❌ `demonstra dominio sobre classificacao de informacao`

Preencha `fonte` sempre que existir base normativa ou documento (`LAI art. 24,
§1º, I`, `OWASP Top 10:2021 A01`, `Scrum Guide 2020`). É o que transforma "faltou
o prazo" em "vá ler o art. 24, §1º". Marque `essencial = 1` nos pontos sem os
quais a resposta não pode valer 4 ou 5 — em geral de 1 a 2 por pergunta.

```sql
INSERT INTO ponto_chave (pergunta_id, ordem, descricao, fonte, essencial) VALUES
  ((SELECT id FROM pergunta WHERE codigo='Q2'), 1,
   'lista os tres graus: ultrassecreto, secreto e reservado',
   'LAI art. 24, §1º', 1),
  ((SELECT id FROM pergunta WHERE codigo='Q2'), 2,
   'prazos: 25, 15 e 5 anos respectivamente',
   'LAI art. 24, §1º, I a III', 1);
```

As fontes consultadas para escrever os gabaritos de cada seção ficam em
`fontes-gabaritos/<secao>/`.

### Revisão

O gabarito nasce com `revisado = 0`. Quando o usuário conferir na lei seca ou na
documentação, marque `revisado = 1`. Vale avisar quando um gabarito ainda não
revisado for usado numa correção.

**O gabarito é o que coloca a pergunta em circulação** — `v_fila` só serve
pergunta preparada. É assim que o banco se libera por seção, no ritmo do usuário,
em vez de despejar 258 perguntas de uma vez no primeiro dia.

Ao terminar, ofereça o commit do banco: `git commit -m "gabaritos da seção 7" estudo.db`

## Views disponíveis

Use as views em vez de montar SQL na mão.

| View | Para quê |
|---|---|
| `v_fila` | Perguntas devidas hoje, sem gabarito. Use para perguntar |
| `v_fila_fraquezas` | As que o usuário já erra, pior primeiro. Também sem gabarito |
| `v_gabarito` | Pontos-chave ativos. **Só depois de gravar a resposta** |
| `v_ponto_desativado` | Pontos tirados de circulação: motivo, quantas vezes já foram cobrados e se já ganharam substituto |
| `v_reativacao_sugerida` | Perguntas arquivadas como `fora_de_foco` cujo alvo já acabou, por seção. Consulte no Passo 6 — **sugira, nunca reative** |
| `v_pergunta_desativada` | O arquivo de perguntas: tipo, motivo, alvo e o histórico que cada uma levou junto |
| `v_calibracao` | Confiança × nota. `gap >= 2` = ilusão de saber |
| `v_pontos_falhados` | Conceitos derrubados em perguntas diferentes |
| `v_sugestao_ponto` | Pontos-chave com falha sistemática (≥3 avaliações, ≥60% de falha, ainda falhando na última tentativa): sugere pergunta dedicada ou remoção do ponto |
| `v_desempenho_secao` | Média e volume por seção, ordenado pela pior |
| `v_cobertura` | O que falta preparar e o que nunca caiu |
| `v_progresso` | Panorama geral: perguntas, gabaritos, respostas, devidas hoje, nota média |
| `v_auditoria` | Quebras de protocolo. Deve viver vazia |
| `v_estatistica_pergunta` | Tentativas e média por pergunta |
| `v_peso_secao` | Quanto cada seção pesou nas provas de referência (`relevancia = 'primaria'`) |
| `v_alvos` | As provas `status = 'alvo_atual'` e dias restantes até a aplicação |
| `v_catalogo` | O banco inteiro, sem gabarito exposto — usada para checar duplicidade ao incluir pergunta |

## Manutenção

- O usuário quer incluir pergunta nova, vincular a uma prova real ou
  desativar uma pergunta? Isso é trabalho da skill `incluir-pergunta`, não
  desta conversa.
- Contagem regressiva de prova: `v_alvos`, não mais `config.data_prova`.
- `resposta` e `avaliacao` são imutáveis por trigger. Errou a nota? Insira uma
  **nova** avaliação — a antiga fica no histórico e a divergência aparece em
  `v_auditoria` como `reavaliacao`.
- `ponto_chave` já cobrado numa avaliação também é imutável, e não se apaga:
  soft delete (`ativo = 0`) com motivo, mais substituto quando for o caso —
  ver "Corrigir um ponto-chave inadequado".
