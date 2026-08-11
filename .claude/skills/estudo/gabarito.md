# Preparar o gabarito de uma seção

Escrever os `ponto_chave` das perguntas que ainda não têm gabarito.

**Faça isso numa conversa separada, nunca no meio de uma sessão de estudo.** O
motivo é direto: gabarito escrito depois de ler a resposta do usuário se molda ao
que ele escreveu, e a nota infla. A view `v_auditoria` acusa isso como
`gabarito_contaminado`.

## Ver o que falta preparar

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

## Escrever os pontos-chave

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

## Revisão

O gabarito nasce com `revisado = 0`. Quando o usuário conferir na lei seca ou na
documentação, marque `revisado = 1`. Vale avisar quando um gabarito ainda não
revisado for usado numa correção.

**O gabarito é o que coloca a pergunta em circulação** — `v_fila` só serve
pergunta preparada. É assim que o banco se libera por seção, no ritmo do usuário,
em vez de despejar 258 perguntas de uma vez no primeiro dia.

Ao terminar, ofereça o commit do banco: `git commit -m "gabaritos da seção 7" estudo.db`
