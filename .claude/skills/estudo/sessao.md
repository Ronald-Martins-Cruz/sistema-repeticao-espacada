# Sessão de estudo

Perguntar, gravar, corrigir, revelar. Um ciclo por pergunta, **uma pergunta por
vez**. As regras invioláveis estão no `SKILL.md` — em especial a ordem
corrigir → gravar → perguntar confiança → revelar.

## Passo 0 — abrir a sessão

```sql
INSERT INTO sessao (modo, filtro) VALUES ('revisao', NULL);
SELECT last_insert_rowid();
```

`modo`: `revisao` (SM-2, o padrão), `fraquezas`, `secao`, `simulado` ou `livre`.

Mostre o panorama antes de começar: `SELECT * FROM v_progresso;`

## Passo 1 — escolher e enunciar a pergunta

```sql
SELECT codigo, secao_titulo, enunciado, pergunta_id FROM v_fila LIMIT 1;
-- ou, no modo fraquezas:
SELECT codigo, secao_titulo, enunciado, nota_media, pergunta_id
FROM v_fila_fraquezas LIMIT 1;
```

Enuncie o texto **exatamente como está**. Não adicione dica, não reformule, não
diga de que seção é se isso entregar a resposta, e não mencione se é distrator ou
caso. Anote o horário para preencher `segundos` depois.

## Passo 2 — gravar a resposta

Apóstrofo no texto vira `''`. Se a resposta for longa ou cheia de aspas, escreva
num arquivo e use `CAST(readfile('resp.txt') AS TEXT)`.

```sql
INSERT INTO resposta (pergunta_id, sessao_id, perguntada_em, texto, segundos)
VALUES ((SELECT id FROM pergunta WHERE codigo='Q2'), 1,
        '2026-07-22 15:00:00', 'texto integral da resposta, sem editar', 180);
SELECT last_insert_rowid();
```

## Passo 3 — corrigir, gravar, **sem mostrar**

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

A régua mede conteúdo, não prosa: forma, extensão e ortografia não entram na
nota. Número trocado ou termo confundido com o vizinho derruba a nota mesmo com o
resto impecável — numa prova objetiva, é o que decide a questão inteira.

Seja rigoroso. Uma nota inflada hoje custa a pergunta sumindo do cronograma por
40 dias.

```sql
INSERT INTO avaliacao (resposta_id, nota, veredito, feedback)
VALUES (12, 3, 'parcial', 'Acertou os tres graus, mas trocou o prazo do secreto.');

INSERT INTO avaliacao_ponto (avaliacao_id, ponto_chave_id, status) VALUES
  ((SELECT last_insert_rowid()), 4, 'citou'),
  ((SELECT last_insert_rowid()), 5, 'errou');
```

O trigger SM-2 reagenda a pergunta sozinho. Você não toca em `agendamento`.

Se o gabarito usado ainda estiver com `revisado = 0`, avise ao revelar.

## Passo 4 — perguntar a confiança

Só agora, e **sem ter dito a nota**:

> De 1 a 5, quanto você confia que acertou essa?

```sql
UPDATE resposta SET confianca = 4 WHERE id = 12;
```

Se o banco recusar, é porque a nota ainda não foi gravada — volte ao passo 3. A
ordem existe porque, se você souber a confiança antes de corrigir, você ancora:
"ele disse 5, deve estar certo". Com a nota já gravada e imutável, ancorar fica
impossível, não apenas desaconselhado.

## Passo 5 — revelar

Mostre, nesta ordem: a nota e o veredito; o que faltou, ponto a ponto, com a
`fonte` de cada omissão; e a resposta modelo. Se `confianca - nota >= 2`, diga
isso explicitamente — é onde o usuário perde ponto na prova sem perceber.

Feche traduzindo a falha para o formato da prova: **como esse ponto viraria
alternativa errada.** "Faltou o prazo do secreto" fica "a FGV escreve *15 anos*
onde é *5* e você marca sem piscar". É esse o elo entre o que o usuário escreveu
e o que vai ver na folha de respostas — sem ele, o exercício discursivo treina o
texto e não a escolha.

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

## Passo 6 — encerrar

```sql
UPDATE sessao SET encerrada_em = datetime('now','localtime') WHERE id = 1;
SELECT * FROM v_auditoria;   -- tem que vir vazia
```

Feche com o resumo da sessão e ofereça o dump:
`sqlite3 estudo.db .dump > estudo.sql`
