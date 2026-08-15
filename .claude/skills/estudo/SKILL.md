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

Duas atividades cabem aqui, e **nunca na mesma conversa** (regra 7): a **sessão
de estudo** — perguntar, corrigir, registrar — e o **preparo de gabarito** —
escrever os pontos-chave de uma seção, que é o que coloca perguntas novas em
circulação.

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
7. **Gabarito prepara-se em conversa separada da sessão de estudo.** Gabarito
   escrito depois de ler a resposta do usuário se molda ao que ele escreveu, e a
   nota infla — `v_auditoria` acusa isso como `gabarito_contaminado`. Se estiver
   numa sessão de estudo e faltar gabarito, encerre a sessão e peça uma conversa
   nova para prepará-lo.

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

Se vier alguma linha, avise como nota informativa — **não decida nada agora.**
`v_sugestao_ponto` só sugere; excluir o ponto ou escrever pergunta dedicada é
decisão do usuário, e só se concretiza na conversa de gabarito (regra 7), nunca
no meio da sessão de estudo.

### Passo 6 — encerrar

```sql
UPDATE sessao SET encerrada_em = datetime('now','localtime') WHERE id = 1;
SELECT * FROM v_auditoria;   -- tem que vir vazia
```

Feche com o resumo da sessão e ofereça o commit do banco:
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
  AND NOT EXISTS (SELECT 1 FROM ponto_chave pc WHERE pc.pergunta_id = p.id)
ORDER BY p.numero;
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
| `v_gabarito` | Pontos-chave. **Só depois de gravar a resposta** |
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
