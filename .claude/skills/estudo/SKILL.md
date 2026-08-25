---
name: estudo
description: Protocolo do sistema de estudo por perguntas discursivas em estudo.db (concurso FGV/DATAPREV). Use quando o usuário quiser estudar, revisar, responder perguntas, retomar a fila do dia, ver o progresso, e também quando quiser preparar os gabaritos (pontos-chave) de uma seção. A sessão roda em blocos de 5 perguntas, com correção por subagente isolado. Leia antes de enunciar qualquer pergunta.
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
é feita contra um gabarito que já estava gravado antes da resposta, e por um
**subagente isolado**, que não viu nada além daquela pergunta.

Duas atividades cabem aqui, e **nunca na mesma conversa**: a **sessão de
estudo** — perguntar, corrigir, registrar — e o **preparo de gabarito** —
escrever os pontos-chave de uma seção, que é o que coloca perguntas novas em
circulação. Consertar um ponto-chave específico que se mostrou ruim durante a
correção é exceção: isso se faz na própria sessão, no fim do bloco (regra 7).

## A divisão de trabalho: você não corrige

Você é o agente **principal**. Você monta o bloco, enuncia, grava, despacha,
valida e revela. **Você não aplica a régua de correção** — quem faz isso é o
subagente `corretor`, e a régua vive em `.claude/skills/corretor/SKILL.md`, não
aqui. Isso é deliberado: a régua e o instrumento que a executa são versionados
separadamente, para que a tabela `corretor` do banco consiga distinguir "o
modelo mudou" de "a régua afrouxou".

O que sobra para você, na hora de gravar a nota que o corretor devolveu, é a
**validação mecânica**, não o julgamento:

- nota **4 ou 5** exige **todos** os pontos `essencial = 1` com status `citou`;
- todo ponto-chave ativo da pergunta voltou com um status;
- `nota` e `veredito` são coerentes entre si (0 `branco`, 1 `errado`,
  2 `vago`, 3 `parcial`, 4 `bom`, 5 `completo`).

Falhou a validação? **Não grave.** Devolva ao corretor apontando a
inconsistência, ou respawne. Nada foi escrito ainda, então corrigir é barato —
depois de gravada, a avaliação é imutável.

## A prova é objetiva. O formato discursivo é método, não espelho

Múltipla escolha, banca FGV, 70 questões. **Não existe questão discursiva na
prova.** Escrever a resposta por extenso é escolha do usuário, por dois motivos:
produzir do zero fixa mais do que reconhecer alternativa, e resposta escrita
expõe o buraco que a alternativa certa taparia por reconhecimento.

Isso vale para **tudo que você escreve para o usuário** — enunciado, revelação,
feedback, explicação avulsa:

- **Não dê feedback de redação.** Nada sobre estrutura, introdução, coesão,
  clareza ou tamanho do texto. Resposta telegráfica com todos os pontos-chave
  vale 5; parágrafo bem escrito sem os números vale 3.
- **Seja rigoroso no conteúdo técnico:** número exato, prazo, percentual,
  rol completo, nome correto e a fronteira precisa entre conceitos vizinhos.
- **Não procure nem inclua "erros clássicos da banca" ou "como a banca pode
  cobrar isso":** ao responder, corrigir ou explicar, seja estritamente
  objetivo. Nada de especulação sobre pegadinhas hipotéticas, "atenção para a
  banca" ou comentários sobre o estilo de cobrança. O foco é a precisão do
  conteúdo, os pontos-chave cadastrados e as fontes.

## Regras que não se negociam

1. **Nunca mostre o gabarito antes da resposta.** Para enunciar uma pergunta, use
   `v_fila` ou `v_fila_fraquezas` — elas não expõem nenhuma coluna de
   `ponto_chave`. Só consulte `v_gabarito` depois que a resposta estiver gravada
   em `resposta`.
2. **Ordem fixa: corrigir → gravar nota → revelar.** Vale por pergunta, dentro
   da fase C. A nota se grava antes de revelar porque a avaliação é imutável:
   uma vez no banco, ela não pode ser ajustada depois de ver a reação do
   usuário.
3. **Grave a resposta na íntegra**, sem resumir, corrigir ortografia ou
   reescrever. É o texto do usuário que vai ser reavaliado meses depois.
4. **"Não sei" é nota 0 registrada, nunca pergunta pulada.** Resposta em branco é
   o dado mais informativo do banco.
5. **Não invente pergunta nem escreva em `agendamento`.** Só use enunciado que
   veio do banco. Um trigger cuida do SM-2 sozinho ao inserir a avaliação; se
   você escrever em `agendamento`, quebra o cronograma.
6. **Um bloco de 5 por vez. Nenhum gabarito é lido antes de a última resposta
   do bloco estar gravada. Correção isolada, uma pergunta por subagente.** As
   cinco vão juntas para o usuário e voltam juntas; entre enunciar e gravar,
   nenhum `SELECT` em `v_gabarito` — é esse o invariante que substituiu o
   antigo "uma pergunta por vez".
7. **Não mexa no gabarito de uma pergunta que está com resposta sem nota.** Essa
   janela — resposta já lida, nota ainda não gravada — é onde o critério se
   molda ao que o usuário escreveu e a nota infla; `v_auditoria` acusa como
   `gabarito_contaminado` e o banco recusa o `INSERT`/`UPDATE`. **No modo bloco
   a janela cobre as 5 perguntas ao mesmo tempo**, então consertar um ponto
   ruim — que antes vinha logo depois da nota — migra para o fim do bloco
   inteiro, na fase E. **Depois da nota gravada, consertar é permitido e
   desejável** — ver "Corrigir um ponto-chave inadequado". Escrever gabarito
   **novo** de uma seção continua sendo conversa separada. Se faltar gabarito
   no meio de uma sessão, encerre e peça uma conversa nova para prepará-lo.
8. **Nunca reative pergunta por conta própria** — apresente
   `v_reativacao_sugerida` e espere aprovação explícita.
9. **Só inclua, exclua, desative ou edite pergunta e ponto-chave se o usuário
   pedir explicitamente.**

## Sessão de estudo — cinco fases

Um bloco de **5 perguntas**. Bloco = sessão: cada bloco abre a sua própria
linha em `sessao`, então uma noite de estudo com 14 perguntas devidas são três
blocos e três sessões.

O portão duro é entre **B** e **C**: nada de gabarito antes de a quinta
resposta estar gravada.

Os arquivos do bloco se chamam `<AAAA-MM-DD>-s<id da sessão>.md` — o `id` sai
do `INSERT` da fase A, então o nome é inequívoco e ordena sozinho:

```
sessoes/perguntas/2026-08-21-s30.md    <- folha de resposta, o usuário escreve
sessoes/feedbacks/2026-08-21-s30.md    <- o retorno, gerado na fase E
```

`sessoes/` inteiro fica fora do git (o banco é que é o backup) e
`sessoes/perguntas/` é ignorado pelo `mdpdf` — o que vira PDF é o feedback.

### Fase A — abrir e enunciar

```sql
INSERT INTO sessao (modo, filtro) VALUES ('revisao', NULL);
SELECT last_insert_rowid();
```

`modo`: `revisao` (SM-2, o padrão), `fraquezas`, `secao`, `simulado` ou `livre`.

Mostre o panorama antes de começar: `SELECT * FROM v_progresso;`

Puxe **mais** que cinco da fila, para enxergar os parentes antes de cortar:

```sql
SELECT codigo, secao, secao_titulo, enunciado, dias_atraso, pergunta_id
FROM v_fila LIMIT 12;
-- ou, no modo fraquezas:
SELECT codigo, secao, secao_titulo, enunciado, nota_media, pergunta_id
FROM v_fila_fraquezas LIMIT 12;
```

**Monte o bloco agrupando por seção, não cortando cru no `LIMIT 5`.** Pegue a
primeira da fila e puxe junto as da mesma `secao` que aparecerem nessas 12;
complete o que faltar com as seguintes na ordem da fila.

Isso é contraintuitivo mas é **protetivo**. `v_fila` ordena por atraso e peso
de seção, então perguntas vizinhas caem coladas por construção — Q166 ("O que é
Integração Contínua"), Q168 ("Distinga Entrega Contínua de Implantação
Contínua") e Q169 ("Distinga Integração Contínua de Entrega Contínua") saem em
sequência. Dentro de um mesmo bloco elas **não vazam nada entre si**, porque
nada é revelado até as 5 respostas estarem gravadas. Separadas em blocos
diferentes, o feedback do bloco 1 entregaria o bloco 2. O custo é contrariar em
parte a ordem por `dias_atraso`, promovendo uma pergunta que ficaria logo fora
do corte — é um custo aceito.

Escreva a folha de resposta, com o **`codigo` em cada bloco** (é por ele que a
resposta volta para a pergunta certa — e resposta gravada na pergunta errada é
lixo permanente, porque `resposta` é imutável e indeletável):

```markdown
# Bloco — sessão 30 — 21/08/2026

Escreva cada resposta abaixo da linha `**Resposta:**`. Não mexa nos títulos:
é o código (`Q166`) que liga a resposta à pergunta.

---

### Q166 · seção 2.11 — Integração e entrega contínuas

O que é Integração Contínua?

**Resposta:**


---

### Q168 · seção 2.11 — Integração e entrega contínuas

...
```

Enuncie o texto **exatamente como está** no banco. Não adicione dica, não
reformule, não diga de que seção é se isso entregar a resposta, e não mencione
se é distrator ou caso.

Avise o usuário do caminho do arquivo e **pare**. Não enuncie no chat nada que
não esteja na folha.

> `resposta.segundos` fica `NULL` no modo bloco — não há cronômetro por
> pergunta, e a coluna não é lida por nenhuma view, trigger nem pelo SM-2.
> `perguntada_em` recebe o instante em que a folha foi gerada.

### Fase B — colher (o portão)

O usuário escreve as 5 respostas no arquivo e avisa. **Nenhum gabarito é lido
nesta fase.**

Leia a folha e grave direto. **Não pergunte se o texto foi capturado certo, e
não mostre tabela de conferência nenhuma** — ler qual trecho da folha é a
resposta de qual pergunta é tarefa que a LLM faz bem, e o `codigo` no título de
cada bloco já amarra resposta e pergunta sem ambiguidade. Resposta vazia **não
é pergunta pulada**: grave o texto como está e ela vira nota 0 na fase C
(regra 4).

```sql
PRAGMA foreign_keys = ON;
INSERT INTO resposta (pergunta_id, sessao_id, perguntada_em, texto) VALUES
  ((SELECT id FROM pergunta WHERE codigo='Q166'), 30, '2026-08-21 21:40:00',
   'texto integral da resposta, sem editar'),
  ((SELECT id FROM pergunta WHERE codigo='Q168'), 30, '2026-08-21 21:40:00',
   'texto integral da resposta, sem editar');

SELECT r.id, p.codigo FROM resposta r
JOIN pergunta p ON p.id = r.pergunta_id WHERE r.sessao_id = 30;
```

Apóstrofo no texto vira `''`. Resposta longa ou cheia de aspas: escreva num
arquivo e use `CAST(readfile('resp.txt') AS TEXT)`.

Guarde o `resposta.id` de cada código — é o que a fase C precisa.

### Fase C — corrigir (cinco subagentes, em paralelo)

Só agora o gabarito pode ser lido. Puxe os cinco de uma vez:

```sql
SELECT pergunta, ponto_chave_id, ordem, descricao, fonte, essencial, revisado
FROM v_gabarito
WHERE pergunta IN ('Q166','Q168','Q169','Q170','Q171')
ORDER BY pergunta, ordem;
```

Despache **cinco subagentes `corretor` numa só mensagem**, um por pergunta, para
que rodem em paralelo. Cada prompt carrega **só a pergunta dele**:

- o caminho absoluto de `.claude/skills/corretor/SKILL.md` (ele lê a régua de lá
  — é a única ferramenta que tem);
- `codigo` e enunciado da pergunta;
- o texto integral da resposta;
- os pontos-chave: `ponto_chave_id`, `ordem`, `descricao`, `fonte`, `essencial`.

Nada além disso. Ele não vê as outras perguntas, não vê as outras respostas,
não tem histórico do usuário e **não tem acesso ao banco** — quem grava é você.
Isso é o desenho, não uma limitação: sem `Bash`, `Write` ou `Edit`, não existe
caminho pelo qual um corretor escreva uma nota errada e imutável, ou toque num
`ponto_chave` dentro da janela da regra 7.

Cada um devolve `NOTA`, `VEREDITO`, `PONTOS` (status por `ponto_chave_id`),
`FEEDBACK`, `REVELACAO` e, quando houver, `SINAL_PONTO` e `BLOQUEIO`. Rode a
**validação mecânica** descrita lá em cima e grave, **serialmente** — uma
transação por vez, nunca cinco processos `sqlite3` concorrentes, porque o CLI
tem busy timeout 0 e a escrita concorrente falha na hora com "database is
locked".

```sql
PRAGMA foreign_keys = ON;
BEGIN;
INSERT INTO avaliacao (resposta_id, nota, veredito, feedback, corretor_id)
VALUES (312, 3, 'parcial', 'Acertou os tres graus, mas trocou o prazo do secreto.',
        (SELECT id FROM corretor WHERE modelo='claude-opus-5'
           AND esforco='xhigh' AND isolamento='subagente'
           AND versao_instrucoes='<hash da regua>'));

INSERT INTO avaliacao_ponto (avaliacao_id, ponto_chave_id, status) VALUES
  ((SELECT MAX(id) FROM avaliacao), 4, 'citou'),
  ((SELECT MAX(id) FROM avaliacao), 5, 'errou');
COMMIT;
```

`corretor_id` é **obrigatório** — o banco recusa a avaliação sem ele. Como
descobrir qual usar está em "Registrar o corretor", logo abaixo.

O trigger SM-2 reagenda a pergunta sozinho. Você não toca em `agendamento`.

> Se um subagente falhar ou voltar malformado, nada foi escrito: respawne
> aquele, ou corrija você mesmo aquela pergunta — e nesse caso registre o
> corretor com `isolamento = 'principal'`, porque foi você quem deu a nota.

> Se o gabarito usado estiver com `revisado = 0`, avise ao revelar.

> Veio `BLOQUEIO` (a resposta referenciava outra pergunta que o corretor não
> viu)? Grave a nota assim mesmo e mostre a observação ao usuário junto da
> revelação. Não "conserte" a nota com o que você sabe das outras respostas —
> isso reintroduziria exatamente a contaminação que o isolamento remove.

### Fase D — revelar

Pode revelar **por pergunta, enquanto as seguintes ainda estão sendo
corrigidas**: a resposta já está gravada e imutável, então revelar Q166 não
contamina Q171. Para cada uma, nesta ordem:

1. A nota e o veredito;
2. O que faltou ou errou, ponto a ponto, com a `fonte` de cada omissão;
3. A resposta modelo.

O texto vem do campo `REVELACAO` do corretor. Você pode reformatar, nunca
abrandar. **Sem divagações sobre a banca.**

Depois de revelar as cinco, cheque se algum ponto-chave cruzou o limiar de
falha sistemática:

```sql
SELECT pergunta, descricao, sugestao, vezes_avaliado, pct_falha, status_mais_recente
FROM v_sugestao_ponto WHERE pergunta IN ('Q166','Q168','Q169','Q170','Q171');
```

Se vier alguma linha, mostre como nota informativa. `v_sugestao_ponto` só
sugere — a decisão é do usuário. Se a sugestão for "pergunta dedicada", isso é
escrever pergunta nova: skill `incluir-pergunta`, em outra conversa.

Mostre também, aqui, os `SINAL_PONTO` que os corretores tiverem devolvido — é o
insumo do conserto de gabarito da fase E.

### Fase E — fechar

```sql
UPDATE sessao SET encerrada_em = datetime('now','localtime') WHERE id = 30;
SELECT * FROM v_auditoria;   -- tem que vir vazia
```

`v_auditoria` vazia agora significa também **"nenhuma resposta do bloco ficou
sem nota"** — o ramo `sem_avaliacao` acusa a resposta gravada e esquecida.
**Bloco começado se termina na mesma conversa.**

É aqui, com as cinco notas já gravadas e imutáveis, que se conserta ponto-chave
ruim — ver "Corrigir um ponto-chave inadequado".

Escreva o feedback em `sessoes/feedbacks/<AAAA-MM-DD>-s<id>.md`: por pergunta,
o enunciado, a resposta dada, a nota e o veredito, o que faltou ponto a ponto
com a fonte, e a resposta modelo. Depois **dispare a conversão e não espere**:

```sh
python -m scripts.mdpdf gerar sessoes/feedbacks/2026-08-21-s30.md
```

Responda informando que gerou e chamou — o script às vezes demora, e o alvo
único é bem mais rápido que o `ciclo` completo. O PDF cai em
`pdf/sessoes/feedbacks/2026-08-21-s30.pdf`; o que o usuário grifar nele no Edge
é salvo em `scripts/mdpdf/marcacoes/sessoes/feedbacks/`, que **vai para o git**.

**Sempre informe os próximos agendamentos ao fechar**, em tabela — uma linha por
data, com a quantidade de revisões daquele dia:

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
gabarito, que é a que vai de fato ser servida.

| Data | Revisões |
|---|---|
| 2026-08-18 | 6 |
| 2026-08-23 | 2 |
| 2026-08-29 | 8 |

Ainda no fechamento, confira se há pergunta arquivada pedindo para voltar:

```sql
SELECT * FROM v_reativacao_sugerida;
```

Vazia → silêncio, não comente. Com linhas → apresente a tabela e **pergunte**.
São perguntas boas arquivadas como `fora_de_foco` por serem de outro concurso,
e cujo alvo já acabou. **Nunca reative por conta própria — regra 8.** Aprovado,
reative uma seção por vez (o `UPDATE` está na skill `incluir-pergunta`).

Se ainda houver fila, ofereça o **próximo bloco** — sessão nova, arquivo novo.
Feche com o resumo e ofereça o commit do banco:
`git commit -m "sessão 21/08" estudo.db`

> **A virada da meia-noite desloca os reagendamentos em um dia**, porque
> `proxima_revisao` sai de `date('now','localtime')` no instante do `INSERT` da
> avaliação, não da resposta — e no bloco as 5 notas caem juntas. Isso é aceito:
> estudar tarde é uso normal, e um dia contra um intervalo de 40 dias é ruído.
> A deriva **não** compõe erro no SM-2 (`trg_sm2` multiplica `intervalo_dias`,
> não os dias decorridos). Não há regra a seguir aqui, nem horário a checar.

## Registrar o corretor

Toda avaliação registra **qual instrumento produziu aquela nota** — modelo,
esforço, isolamento e a versão da régua. Sem isso não há como distinguir "eu
melhorei" de "o corretor afrouxou", e a diferença importa: a nota não move só a
média, move o cronograma (um 4 tira a pergunta de circulação por ~40 dias).

**Leia a tabela antes de inserir.** A `UNIQUE` impede duplicata de uma tupla
*idêntica* e não faz nada contra `opus-5` vs `claude-opus-5` vs `Opus 5` — três
strings, três linhas, uma configuração real. **Só a leitura prévia normaliza.**

```sql
SELECT id, modelo, esforco, provedor, isolamento,
       substr(versao_instrucoes,1,12) AS regua, parametros
FROM corretor ORDER BY id;
```

Reuse o `id` que casar. Só insira quando for **genuinamente** novo — e, antes
de inserir, mostre ao usuário as linhas existentes ao lado do valor que você
propõe.

`versao_instrucoes` é o SHA-256 de `.claude/skills/corretor/SKILL.md`:

```sh
sha256sum .claude/skills/corretor/SKILL.md          # bash
Get-FileHash .claude\skills\corretor\SKILL.md       # powershell
```

| O que mudou | `modelo` | `esforco` | `versao_instrucoes` |
|---|---|---|---|
| Trocou o modelo | muda | — | igual |
| Editou a régua | igual | igual | muda |
| Os dois | muda | — | muda |

`modelo` guarda o modelo que **de fato** rodou (`claude-opus-5`), não o apelido
do frontmatter (`opus`) — quando o apelido passar a resolver para outra versão,
é linha nova. `esforco` é texto livre (cada fornecedor nomeia diferente, e há
quem use orçamento numérico em vez de tier); o parâmetro bruto vai em
`parametros`, que é JSON validado. `isolamento` é `subagente` ou `principal`.

`SELECT * FROM v_desempenho_corretor;` compara os instrumentos.

> A linha `modelo = 'desconhecido'` / `isolamento = 'principal'` é o backfill
> das 177 avaliações anteriores a 21/08/2026, quando a coluna era a string
> solta `avaliador = 'ia'`. Ela significa honestamente "algum modelo Claude,
> versão desconhecida, uma pergunta por vez". **Não use para nota nova.**

## Corrigir um ponto-chave inadequado

Ler a resposta contra o gabarito é justamente quando se enxerga que um
ponto-chave está mal feito: cobra o que o enunciado não pede, empacota dois
fatos numa frase só, está errado na fonte ou repete outro ponto. É o que o
campo `SINAL_PONTO` do corretor levanta.

**Conserte na fase E, com todas as notas do bloco já gravadas** — nunca antes
(regra 7). Com a nota gravada e imutável, mexer no gabarito não infla nada.

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
- inserir ou desativar ponto de pergunta com resposta **sem nota** é recusado —
  e no modo bloco isso vale para as cinco ao mesmo tempo.

Se todos os pontos de uma pergunta forem desativados, ela sai de `v_fila` até
ganhar gabarito novo. É o comportamento certo: não há contra o que corrigir.

## Preparar o gabarito de uma seção

Escrever os `ponto_chave` das perguntas que ainda não têm gabarito. Conversa
separada, nunca no meio de uma sessão de estudo — regra 7.

Vale um lembrete que a correção isolada torna mais forte: **sem `ponto_chave`
bem escrito, isolamento vira loteria.** Cinco juízes frios não derivam ao longo
da sessão, mas também não são consistentes entre si — o que os alinha é a
rubrica, porque a nota é quase derivada dos status por ponto (média de 4,2
pontos por pergunta) e "4 ou 5 exige todos os essenciais" é determinístico.

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
| `v_fila` | Perguntas devidas hoje, sem gabarito. Use para montar o bloco |
| `v_fila_fraquezas` | As que o usuário já erra, pior primeiro. Também sem gabarito |
| `v_gabarito` | Pontos-chave ativos. **Só depois de a última resposta do bloco estar gravada** |
| `v_ponto_desativado` | Pontos tirados de circulação: motivo, quantas vezes já foram cobrados e se já ganharam substituto |
| `v_reativacao_sugerida` | Perguntas arquivadas como `fora_de_foco` cujo alvo já acabou, por seção. Consulte na fase E — **sugira, nunca reative** |
| `v_pergunta_desativada` | O arquivo de perguntas: tipo, motivo, alvo e o histórico que cada uma levou junto |
| `v_pontos_falhados` | Conceitos derrubados em perguntas diferentes |
| `v_sugestao_ponto` | Pontos-chave com falha sistemática (≥3 avaliações, ≥60% de falha, ainda falhando na última tentativa): sugere pergunta dedicada ou remoção do ponto |
| `v_desempenho_secao` | Média e volume por seção, ordenado pela pior |
| `v_desempenho_corretor` | Média, volume e distribuição de notas **por instrumento de correção** — modelo, esforço, isolamento e versão da régua |
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
  `v_auditoria` como `reavaliacao`. **Atenção:** `trg_sm2` dispara em toda
  inserção e não é idempotente, então a segunda avaliação da mesma resposta
  aplica o passo SM-2 duas vezes (intervalo ≈ × facilidade²). Está registrado
  no `TODO.md` e ainda não tem guard — reavalie sabendo disso.
- `ponto_chave` já cobrado numa avaliação também é imutável, e não se apaga:
  soft delete (`ativo = 0`) com motivo, mais substituto quando for o caso —
  ver "Corrigir um ponto-chave inadequado".
- A régua de correção **não mora aqui**: `.claude/skills/corretor/SKILL.md`
  (método) e `.claude/agents/corretor.md` (instrumento). Editar a régua muda o
  hash e, portanto, exige linha nova em `corretor` — é assim que se sabe depois
  se as notas mudaram porque a régua mudou.
