# Sessão em bloco + corretor registrado

**Status:** ✅ **implementado em 21/08/2026.** Banco migrado, skills escritas, regras trocadas.
**Aberto em:** 21/08/2026. **Decisões consolidadas em:** 21/08/2026.

> Este documento vira registro histórico: é o *porquê* de cada decisão. A
> operação do dia a dia mora na skill `estudo`; a régua, na skill `corretor`.
**Motivação:** o ciclo pergunta → espera → correção → espera consome tempo demais. A espera pela LLM é serial e bloqueia o usuário entre cada pergunta.

Duas mudanças independentes, que se compõem bem mas podem ser adotadas separadamente:

1. **Sessão em bloco** — enunciar 5 perguntas, colher 5 respostas, corrigir tudo depois.
2. **Corretor registrado** — gravar qual instrumento produziu cada nota (modelo, esforço, instruções, isolamento), em vez do atual `avaliador = 'ia'`.

Estado do banco em 21/08/2026: 253 perguntas, 59 com gabarito, 163 respostas avaliadas, nota média 3,38, 14 devidas no dia.

---

## Medições que fundamentam o plano

| Medição | Valor | Consequência |
|---|---|---|
| Custo de contexto por pergunta em bloco | ~1.100–1.300 tokens (enunciado 160 ch + resposta 492 ch + gabarito 842 ch + SQL + feedback) | **Contexto não é o gargalo.** Bloco de 15 caberia. O tamanho 5 foi escolhido por fluidez de leitura do feedback, não por limite técnico. |
| Pontos-chave por pergunta | 4,2 (média, ativos) | A nota é quase derivada da rubrica — é isso que torna correção isolada viável. |
| Deriva de nota intra-sessão | 3,35 (1ª metade) vs 3,41 (2ª metade), 138 avaliações, sessões de 6+ | **Não há abrandamento progressivo observado hoje.** Isolamento é seguro barato, não conserto de problema medido. |
| Uso de `resposta.segundos` | Nenhuma view, nenhum trigger, nada no SM-2. Já `NULL` nas sessões 16 e 17 | Perder o cronômetro por pergunta no modo bloco não custa nada. |
| `avaliacao.avaliador` | 163 linhas, valor único `'ia'`, média 3,38 | Linha de base limpa para comparar instrumentos depois. |
| Respostas com mais de uma avaliação | Zero. `v_auditoria` retorna 0 linhas | A dupla disparada do `trg_sm2` (R1) é **defeito latente**, nunca acionado. |

---

## Decisões tomadas

### Desenho da sessão

**D1. A sessão passa a operar em bloco.**

**D2. Bloco de tamanho fixo: 5 perguntas.** Escolhido por fluidez de leitura do feedback, não por limite de contexto.

**D3. Todo corretor é subagente isolado — sem exceção.** Não há corretor "principal" para perguntas fáceis, nem modo pergunta-a-pergunta preservado para `eh_caso = 1`. Custo: 5 spawns por bloco, 3 blocos para uma fila de 14.

**D4. Um efeito colateral do bloco é corrigir uma contaminação real do fluxo atual.** `v_fila` ordena por `dias_atraso`, distrator, peso da seção e `p.numero` — então perguntas vizinhas da mesma seção caem coladas por construção. Na fila de 21/08: Q168 ("Distinga **Entrega Contínua** de Implantação Contínua"), Q169 ("Distinga Integração Contínua de **Entrega Contínua**") e Q166 ("O que é **Integração Contínua**") saem em sequência.

No fluxo atual a resposta-modelo de Q168 é revelada **antes de Q169 ser enunciada**. Dentro de um bloco isso desaparece: nada é revelado até as 5 respostas estarem gravadas. Em troca, o usuário passa a ver os 5 enunciados antes de responder — vazamento real, porém muito mais fraco que entregar o gabarito.

**D4b. Perguntas parentes vão para o mesmo bloco.** Decorre de D4 e é contraintuitivo: como dentro de um bloco nada é revelado até as 5 respostas estarem gravadas, Q166+Q168+Q169 **no mesmo bloco não vazam nada entre si**; separadas em blocos diferentes, o feedback do bloco 1 vaza para o bloco 2. Agrupar é **protetivo**, não prejudicial — e ainda mantém o estudo coerente, com o bloco girando em torno de um assunto.

Custo: contraria em parte a ordem de `v_fila`, que prioriza `dias_atraso`. Na montagem do bloco, o agrupamento por seção pode promover uma pergunta que estaria logo fora do corte.

**D21. Bloco pode atravessar a meia-noite. A deriva de um dia é aceita.** Reverte a mitigação que R7 propunha. **Estudar tarde não é exceção a ser evitada** — é uma condição normal de uso, e uma regra que proíbe abrir bloco à noite restringe o comportamento certo (estudar) para proteger um número que quase não importa.

Magnitude real da deriva: no máximo **um dia**, e só quando a fase C cai depois da virada. Contra um intervalo SM-2 de 40 dias é ruído de 2,5%; contra o intervalo de 1 dia de uma pergunta derrubada, significa que ela volta depois de amanhã em vez de amanhã. Nenhum dos dois muda o resultado do estudo, e a meta de ementa (11/09/2026) tem folga muito maior que isso.

O que **não** acontece: a deriva não compõe erro no SM-2. `trg_sm2` multiplica `intervalo_dias`, não os dias efetivamente decorridos, então um dia a mais no calendário não contamina o cálculo seguinte. O que acontece é só o deslocamento da data daquela ocorrência.

Consequência prática: nenhuma. Não há regra nova a seguir, e a fase E não precisa checar horário.

### Arquivos da sessão

**D5. `sessoes/perguntas/` e `sessoes/feedbacks/`.** Ao abrir a sessão, gera-se um markdown em `sessoes/perguntas/` com as perguntas do bloco. Ao encerrar, gera-se o feedback em markdown e converte-se para PDF.

**D6. O arquivo de perguntas carrega o `codigo`** (`Q168`) em cada bloco, além do enunciado. Um arquivo por bloco. Sem o código, o mapeamento resposta→pergunta dependeria de casar texto de enunciado — e R3 torna erro de mapeamento permanente.

**D7. Confirmação obrigatória antes do `INSERT`.** O principal mostra a tabela `código → primeiros 60 chars da resposta` e espera "ok". Não é opcional — ver R3.

**D8. O agente não espera o `mdpdf` terminar.** Gera o markdown, dispara a conversão e responde informando que gerou e chamou — o script às vezes demora. Consistente com a regra 10 do `CLAUDE.md`.

Reforço de desempenho: `gerar` aceita alvo (`python -m scripts.mdpdf gerar sessoes/feedbacks/x.md`), bem mais rápido que o `ciclo` completo.

**D8b. O PDF do feedback cai no espelho de `pdf/`, e está tudo bem.** `mdpdf` escreve sempre em `pdf/<caminho relativo>.pdf`, então `sessoes/feedbacks/x.md` produz `pdf/sessoes/feedbacks/x.pdf` — não um PDF ao lado do markdown. Aceito como está, sem alterar o `mdpdf`.

Efeito colateral bom: grifo feito nesse PDF no Edge é salvo em `scripts/mdpdf/marcacoes/sessoes/feedbacks/x.json`, que **é versionado** — o que for marcado no feedback entra no backup.

**D8c. `sessoes/perguntas/` é ignorado pelo `mdpdf`.** ✅ **Feito** — `scripts/mdpdf/ignorados.py` ganhou um conjunto `PREFIXOS` de caminhos relativos à raiz, ignorados só naquele lugar, ao contrário de `DIRETORIOS`, que casa nome de pasta em qualquer nível. As folhas de resposta não são texto de leitura; o que vira PDF é o feedback. Um `docs/perguntas/` hipotético segue sendo convertido normalmente.

**D19. `sessoes/` inteiro fica fora do git.** Resolve o antigo A3. Uma regra só, para as duas subpastas — nada de versionar feedback e ignorar perguntas.

O `.md` de perguntas não perde nada: as respostas que ele carrega já vão para `resposta`, e o banco é versionado. O `.md` de feedback é saída de LLM e não é exatamente regerável, mas o que importa dele — nota, veredito e texto do feedback — também está em `avaliacao`, que é imutável; o markdown é a apresentação, não o registro.

O backup do que for **grifado** no feedback continua de pé por outro caminho: o PDF cai em `pdf/sessoes/feedbacks/` (D8b) e as marcações do Edge vão para `scripts/mdpdf/marcacoes/sessoes/feedbacks/*.json`, que é versionado. Então a única coisa que o usuário produz à mão sobre o feedback — o grifo — entra no git mesmo com `sessoes/` ignorado.

Cuidado na escrita da regra: `.gitignore` com `sessoes` casaria em qualquer nível, inclusive dentro de `marcacoes/`, o que mataria justamente o backup dos grifos. Ancorar na raiz — `/sessoes/`.

### Corretor

**D9. `avaliacao.avaliador` vira entidade modelada, com procedência de instrumento.** String solta não sustenta o uso pretendido: `'Opus 5.0 effort extra high'`, `'opus-5 xhigh'` e `'claude-opus-5/xhigh'` são a mesma configuração e três valores distintos, e o `GROUP BY` não fecha em seis meses. O projeto já fez exatamente essa migração uma vez — `ancora` substituiu `pergunta.tag_prova` —, então modelar é seguir o desenho existente.

Importa mais que estatística: nota inflada não distorce só a média, **move o cronograma** (`trg_sm2` transforma nota em `intervalo_dias`; um 4 vale ~40 dias de sumiço). Sem registrar o instrumento, não há como distinguir "eu melhorei" de "o corretor afrouxou".

Forma: tabela `corretor` (`modelo`, `esforco`, `provedor`, `isolamento`, versão das instruções, `parametros` JSON) + `avaliacao.corretor_id`, com `UNIQUE` sobre a tupla identificadora.

`isolamento` (`principal` / `subagente`) fica em coluna própria de propósito: é o eixo do contexto frio e não deve poluir o campo do modelo.

**D10. `corretor` é por avaliação**, não por sessão. É o que permite comparar instrumentos e trocar de configuração sem perder a procedência do que já foi corrigido.

**D11. `esforco` é texto livre, normalizado pela `UNIQUE`**, com o parâmetro bruto do fornecedor em `parametros`. `CHECK` envelheceria mal: cada fornecedor nomeia diferente e o Gemini usa orçamento numérico, não tier.

**D12. O agente lê a tabela `corretor` antes de inserir.** Esta é a decisão que torna texto livre viável. `UNIQUE` impede linha duplicada para uma tupla **idêntica**, e não faz nada contra `opus-5` vs `claude-opus-5` vs `Opus 5` — três strings, três linhas aceitas, uma configuração real. A `UNIQUE` garante ausência de duplicata exata; **só a leitura prévia produz normalização.** Protocolo: `SELECT` nas linhas existentes, reusar o `id` quando casar, e só inserir quando for genuinamente novo — mostrando ao usuário as opções existentes junto com o valor proposto.

**D13. Backfill das 163 avaliações existentes como desconhecido.** `'ia'` significa honestamente "algum modelo Claude, versão desconhecida, uma pergunta por vez, alguma versão da skill". Uma linha `corretor` com `modelo = 'desconhecido'`, `isolamento = 'principal'` e versão de instruções nula é a verdade. **Não retroagir procedência inventada.**

**D20. A coluna `avaliador` é dropada depois do backfill.** Resolve o antigo A4, que a supunha cara demais para mexer.

A premissa estava errada: **não é território de rebuild.** O SQLite deste ambiente é 3.53.4 e `ALTER TABLE ... DROP COLUMN` existe desde a 3.35; a coluna não é PK, não tem índice nem `UNIQUE`, e não aparece em nenhum `CHECK`, view ou trigger — que são exatamente as condições que o SQLite exige para permitir o drop. Além disso é DDL, então não dispara `trg_avaliacao_imutavel`, pela mesma isenção que o `ADD COLUMN` já tinha em R2. Uma instrução, não um rebuild.

Ordem obrigatória: criar `corretor` → `ADD COLUMN corretor_id` → derrubar o trigger de imutabilidade → backfill (D13) → recriar o trigger → `DROP COLUMN avaliador`. Só se dropa depois do backfill, mesmo sabendo que `'ia'` é valor único e quase sem informação — a procedência velha se traduz antes de sumir, não depois.

Motivo de não manter como peso morto: `avaliador` é `NOT NULL DEFAULT 'ia'`, então toda avaliação nova nasceria carimbada `'ia'` em silêncio, ao lado de um `corretor_id` correto. Duas fontes de procedência discordando é pior que uma só — é a mesma razão de D9.

### Instruções e skills

**D14. Skills separadas: o principal conhece a sessão, o subagente conhece o corretor.** Não duplicar a régua entre elas. No máximo uma skill pede a leitura da outra. Isso resolve de uma vez o risco de as duas cópias derivarem e o instrumento mudar em silêncio.

Consequência: o principal deixa de aplicar a régua e passa a fazer só a validação mecânica antes de gravar — nota ≥ 4 exige todos os `essencial = 1` como `citou`, que é a checagem que `v_auditoria` faria depois. Uma frase, não a tabela inteira.

**D14b. Corretor é definição de agente *e* skill — dois arquivos.** `.claude/agents/corretor.md` fixa o **instrumento** (modelo, esforço, ferramentas, no frontmatter); `.claude/skills/corretor/SKILL.md` carrega o **método** (a régua). Mais o ponteiro `.agents/corretor/SKILL.md`, pela convenção do `CLAUDE.md`.

O motivo não é descobribilidade, é **versionamento independente**: régua e instrumento mudam por razões diferentes e em ritmos diferentes. A régua muda quando se decide que 4 exige todos os essenciais; o modelo muda quando sai uma versão nova. Num arquivo só, os dois compartilham o mesmo hash — e quando as notas derivarem, o registro não sabe dizer se foi o modelo que trocou ou a régua que afrouxou. **É exatamente a discriminação que D9 existe para fazer.** Procedência trivial que confunde duas causas é procedência pior.

**D15. As instruções do corretor são versionadas — com um hash só.** Ao contrário do que parecia, dois arquivos não exigem dois hashes: as colunas `modelo` e `esforco` **já são a desnormalização do que o frontmatter da definição declara**, então a definição de agente não precisa de hash. `versao_instrucoes` guarda só o hash da skill. O que sobrar de configuração não coberto pelas colunas (por exemplo `tools`) vai em `parametros`.

| O que mudou | `modelo` | `esforco` | `versao_instrucoes` |
|---|---|---|---|
| Trocou o modelo | muda | — | igual |
| Editou a régua | igual | igual | muda |
| Os dois | muda | — | muda |

Instrução montada ad hoc pelo principal não é versionável e inviabiliza D9 pela metade — por isso a régua precisa morar em arquivo, não no prompt de spawn.

O conteúdo precisa carregar, no mínimo: a régua 0–5 na íntegra; a regra de que 4 ou 5 exige todos os `essencial = 1` como `citou`; a proibição de feedback de redação; a proibição de especular sobre pegadinhas da banca; o rigor sobre número, prazo, rol e fronteira entre vizinhos; e a instrução específica do isolamento — a resposta pode referenciar perguntas que ele não vê.

**D16. O subagente não escreve no banco.** Devolve veredito estruturado (`nota`, `veredito`, `feedback`, status por `ponto_chave_id`, texto da revelação); o principal valida e grava. Três razões: evita `SQLITE_BUSY` com N processos concorrentes (R4); `avaliacao` é imutável e indeletável, então nota errada de subagente vira lixo permanente sem desfazer; e subagente sem acesso ao banco não tem como violar a regra 7 mexendo em `ponto_chave`.

**D17. O principal lê os gabaritos e os passa no prompt.** Descartada a variante em que o subagente consulta `v_gabarito` sozinho: na fase C as respostas já estão gravadas e imutáveis, então o principal segurar os gabaritos não viola a regra 1 — ela protege o usuário, não o agente. A variante custaria acesso de escrita ao banco para resolver um problema que não existe.

Consequência de D14b sobre este ponto: **o subagente não pode ter `tools: []`**. Com a régua numa skill separada, um corretor sem ferramenta nenhuma não consegue carregar as próprias instruções. Ele precisa da superfície mínima para ler a skill — e só dela. O invariante de D16 continua de pé: sem `Bash`, sem `Write`, sem `Edit`, não há caminho de escrita para o banco. Ver A1 para a forma exata.

**D18. O corretor sinaliza ponto-chave ruim, mas não age.** Sem ferramentas ele corrige contra a rubrica gravada, e ponto — correção não é pesquisa. Mas um `ponto_chave` mal formulado produz nota errada, então o retorno inclui um sinal de "este ponto parece mal feito ou errado na fonte". O principal mostra esse sinal **depois** de gravar a nota, que é o fluxo de "corrigir um ponto-chave inadequado" já descrito na skill e preserva a regra 7.

---

## O desenho

Cinco fases, com portão duro entre B e C:

- **A — abrir e enunciar.** `INSERT INTO sessao`; monta o bloco a partir de `v_fila`, agrupando perguntas da mesma seção quando possível (D4b) em vez de cortar cru no `LIMIT 5`. Gera `sessoes/perguntas/<nome>.md` com código + enunciado + slot de resposta. Bloco = sessão: zero mudança de schema, e as sessões já são pequenas e baratas.
- **B — colher.** O usuário escreve as 5 respostas no arquivo. **Nenhum gabarito é lido aqui.** O principal lê o arquivo, mostra a tabela de conferência (D7) e só então grava.
- **C — corrigir.** Cinco subagentes, um por pergunta, em paralelo, cada um com contexto frio e sem ferramentas. O principal valida cada veredito e grava serialmente.
- **D — revelar.** Pode revelar por pergunta enquanto ainda corrige as seguintes: a resposta já está gravada e imutável, então revelar Q1 não contamina Q5.
- **E — fechar.** Feedback em `sessoes/feedbacks/<nome>.md`, chamada ao `mdpdf` sem esperar (D8), `v_auditoria` vazia, tabela de próximos agendamentos, `v_reativacao_sugerida`.

O invariante que substitui a regra 6: **nenhum `SELECT` em `v_gabarito` antes de a última resposta do bloco estar gravada.**

**Ganho de tempo — sem exagero.** O bloco não deixa a LLM mais rápida; o trabalho total é igual ou ligeiramente maior. O que muda é que N esperas intercaladas viram uma espera paralelizável. Os subagentes concorrentes comprimem a fase C ao tempo do mais lento, não à soma.

**Custo — honesto.** O material da correção é pequeno (~2k tokens por pergunta). O caro é que cada subagente nasce com system prompt e definições de ferramenta próprios. Com D3 (isolar tudo) e D2 (bloco de 5), são 5 spawns por bloco e ~15 para uma fila de 14 perguntas. O que justifica é o isolamento ser seguro barato sobre a única coisa do sistema que é imutável e mexe no cronograma: a nota.

---

## Pontos ainda em aberto

**A1. ✅ Resolvido. A superfície mínima de ferramentas do corretor.**

`tools: Read` — só isso. Basta para ler `.claude/skills/corretor/SKILL.md` (o
principal passa o caminho absoluto no prompt) e não abre caminho de escrita
nenhum: sem `Bash`, `Write` ou `Edit`, o invariante de D16 se sustenta no
instrumento, não na boa vontade do corretor.

A chave de frontmatter para esforço de raciocínio é **`effort:`**, confirmada
(não chutada) nas definições oficiais em
`~/.claude/plugins/marketplaces/claude-plugins-official/plugins/claude-security/agents/`,
que a usam com valores `medium` e `xhigh` ao lado de `model:`, `tools:`,
`name:`, `description:` e `color:`. O corretor ficou em `model: opus` +
`effort: xhigh`.

<details><summary>enunciado original</summary>
 Decorre de D14b + D17: o subagente precisa conseguir carregar a skill da régua, e nada além disso. Falta fixar quais ferramentas exatamente entram no frontmatter — o suficiente para ler a própria instrução, e nenhuma que abra caminho de escrita no banco (`Bash`, `Write`, `Edit` ficam de fora).

Junto disso, falta confirmar o **nome exato da chave de frontmatter para esforço de raciocínio**. `model` e `tools` são conhecidos; o esforço é configurável na definição, mas a grafia precisa ser verificada antes de escrever o arquivo, não chutada.

</details>

**A2. ✅ Resolvido. Convenção de nome dos arquivos de sessão.** `<AAAA-MM-DD>-s<id>.md` — `2026-08-21-s30.md`. O `bloco1` do rascunho caiu por ser redundante: bloco **é** sessão, então o `id` já identifica o bloco, e uma noite de três blocos vira `s30`, `s31`, `s32`. Inequívoco e ordena sozinho.

**A3 e A4 saíram daqui** — decididos em 21/08/2026 como D19 (`sessoes/` fora do git) e D20 (dropar `avaliador`). Os rótulos A1, A2 e A5 seguem os mesmos para não invalidar as referências cruzadas do documento.

**A5. ✅ Encaminhado. Guard no `trg_sm2` (era P6).** Entrada própria criada no `TODO.md`, com os três formatos de guard, a rotina `recalcular_agendamento` como conserto real e a nota de aproveitar a ocasião para ancorar a data em `resposta.respondida_em` (R7). Não foi implementado — segue sendo defeito latente com valor próprio, independente deste plano.

 Explicado em R1. **Não bloqueia a migração:** com uma única configuração de corretor em uso (D3), a comparação entre instrumentos é naturalmente antes/depois no tempo, isto é, entre perguntas diferentes — o que dispensa guard. Mas a dupla disparada na reavaliação é defeito latente com valor próprio, independente deste plano, e merece entrada separada no `TODO.md`.

---

## Restrições descobertas no banco

**R1. `trg_sm2` é `AFTER INSERT ON avaliacao` sem cláusula `WHEN`** — dispara em toda inserção, e **não é idempotente**. Se uma mesma resposta receber duas avaliações: `facilidade` recebe o ajuste do EF duas vezes; `repeticoes` incrementa duas vezes; e `intervalo_dias`, no ramo `ELSE MAX(1, ROUND(intervalo_dias * facilidade))`, multiplica o intervalo já atualizado pela facilidade já atualizada — duas passagens dão ~`intervalo × EF²`. Exemplo: intervalo 10, facilidade 2,5, `repeticoes` 3, nota 5 duas vezes → ~25 na primeira passagem, ~64 na segunda. A pergunta some por dois meses com base em uma resposta, sem erro nenhum.

Isso atinge dois caminhos: consertar nota errada (receita hoje documentada na skill) e calibrar corretores na mesma resposta. **Nunca aconteceu** — zero respostas com mais de uma avaliação. É defeito latente, não corrupção ativa.

Formatos de guard: **(A)** `WHEN (SELECT COUNT(*) FROM avaliacao WHERE resposta_id = NEW.resposta_id) = 1` — a segunda nota não agenda; resolve calibração, mas congela o cronograma na nota errada no caso de conserto. **(B)** coluna `agenda INTEGER NOT NULL DEFAULT 1` + `WHEN NEW.agenda = 1` — intenção declarada; aditivo e seguro, porque `ALTER TABLE ADD COLUMN` com `DEFAULT` é DDL e não dispara o trigger de `UPDATE`. **(C)** não guardar nada e comparar corretores só entre perguntas diferentes.

**O que nenhum guard resolve:** `agendamento` guarda só o estado atual, sem histórico. Um passo SM-2 aplicado errado não se desfaz por aritmética — seria preciso zerar a linha e reprocessar todas as avaliações da pergunta em ordem. É viável e determinístico: o `TODO.md` registra que a simulação manual da pergunta 77 com notas [0,0,5,2,2] bateu exatamente com o estado gravado. Uma rotina `recalcular_agendamento(pergunta_id)` é o conserto real desse caso.

**R2. `trg_avaliacao_imutavel` é `BEFORE UPDATE ON avaliacao` sem qualificar coluna** — qualquer `UPDATE` aborta. `ALTER TABLE ADD COLUMN` passa (é DDL), mas o **backfill** de `corretor_id` nas 163 linhas exige derrubar o trigger, migrar e recriá-lo, ou o rebuild completo de tabela do SQLite. Numa tabela deliberadamente imutável e versionada em git: **commit antes, obrigatoriamente.**

O `DROP COLUMN` de D20 também passa por ser DDL — o trigger só barra `UPDATE`. O que exige derrubá-lo é o backfill, e nada mais.

**R3. `resposta` é imutável e indeletável** (`trg_resposta_imutavel`, `trg_resposta_sem_delete`). Resposta gravada na pergunta errada é lixo **permanente** no histórico e ainda envenena o SM-2 de duas perguntas. Hoje o risco não existe porque há uma pergunta em voo por vez. É o risco novo mais grave do modo bloco, e o motivo de D6 e D7.

**R4. O CLI `sqlite3` tem busy timeout 0 por padrão** — escrita concorrente falha na hora com "database is locked". Motivo de D16.

**R5. A ferramenta de subagente só instancia modelos Claude.** A tabela `corretor` pode registrar qualquer fornecedor, mas um corretor Gemini exige caminho externo — a incerteza já aberta no `TODO.md` sobre CLI de LLM local. Modelar o campo agora é barato e correto; comparação multi-fornecedor depende daquele item.

**R6. `PRAGMA foreign_keys` nasce desligado** e não fica no arquivo. Sendo `avaliacao.corretor_id` uma FK nova, escrita por caminho que não seja o shell `sqlite3` precisa ligar na mão — foi assim que 7 linhas órfãs entraram em `avaliacao_ponto`.

**R7. Virada de meia-noite.** `proxima_revisao` sai de `date('now','localtime')` no momento do `INSERT` da **avaliação**, não da resposta. Bloco respondido às 23h50 e corrigido às 00h10 empurra todos os reagendamentos em um dia — e pega o bloco inteiro de uma vez, porque as 5 notas são gravadas juntas na fase C.

**Aceito como está** (D21): não há regra operacional contra atravessar a virada. Fica registrado por ser comportamento não óbvio do trigger, não por exigir cuidado.

Se algum dia se quiser eliminar de vez, o conserto é pequeno e existe: `resposta.respondida_em` é `NOT NULL` e guarda o instante da resposta, então `trg_sm2` poderia ancorar a data nela em vez de em `date('now')` — o que é, aliás, a base semanticamente correta para o SM-2, já que o intervalo conta a partir do momento em que você recuperou a informação, não de quando a nota foi lançada. **Não é para fazer agora.** Vale só se `trg_sm2` for reaberto para o guard de R1 (ver A5), quando o custo marginal seria perto de zero.

---

## Riscos de qualidade da correção isolada

- **Variância sobe.** Cinco juízes frios não derivam, mas também não são consistentes entre si; um juiz único ao menos é auto-consistente. O que segura isso é a rubrica: a nota é quase derivada dos status por ponto, e "4 ou 5 exige todos os essenciais" é determinístico. **Sem `ponto_chave` bem escrito, isolamento vira loteria.**
- **Resposta que referencia a anterior.** "como eu disse acima" — o corretor frio não resolve. A regra 3 manda gravar na íntegra, então a skill do corretor precisa instruir: avalie só o que é verificável contra estes pontos-chave, e sinalize se a referência impedir o julgamento.
- **Subagente que falha ou volta malformado.** Como nada foi escrito, o principal corrige aquela sozinho ou respawna. Custo baixo.
- **Feedback lido distraído é feedback não absorvido.** O bloco de correção chega enquanto o usuário faz outra coisa. Foi o argumento decisivo para D2 (bloco de 5).
- **Sequenciamento adaptativo congela.** Na prática perde-se pouco: `v_fila` já é ordem fixa e a skill não faz escolha adaptativa hoje.

---

## O que muda nas regras

**Regra 6 ("Uma pergunta por vez") cai** — e precisa de substituta, não só remoção. Ela guardava três coisas: que o gabarito não precede a resposta (a regra 1 já cobre), segurança mecânica contra misturar perguntas, e carga de atenção. Substituta: *um bloco de 5 por vez; nenhum gabarito é lido antes de a última resposta do bloco estar gravada; correção isolada, uma pergunta por subagente.*

**Regra 7 fica mais exigente na prática.** A janela "resposta sem nota" passa a cobrir 5 perguntas simultâneas, e nela nenhum `ponto_chave` pode ser tocado. Consertar ponto ruim — hoje permitido logo após a nota — migra para o fim do bloco inteiro. `v_auditoria` já vigia isso por resposta (`gabarito_contaminado`, `ponto_desativado_antes_da_nota`), então a rede de segurança escala sozinha, sem migração.

**Passo 5 ganha check explícito:** `v_auditoria` vazia agora significa também "nenhuma resposta do bloco ficou sem nota". Bloco começado se termina na mesma conversa.

**Regras 1, 2, 3, 4, 5, 8, 9, 10 ficam intactas.** A regra 2 (corrigir → gravar nota → revelar) passa a valer por pergunta dentro da fase C.

---

## Arquivos a tocar quando for implementar

| Arquivo | O que muda |
|---|---|
| `.claude/skills/estudo/SKILL.md` | ✅ Fases A–E; regra 6 substituída; regra 7 estendida ao bloco; a régua **sai** daqui (D14), fica só a validação mecânica |
| `.claude/skills/corretor/SKILL.md` | ✅ **Novo.** Só o método: a régua 0–5 e as instruções de correção (D14b) |
| `.claude/agents/corretor.md` | ✅ **Novo.** Só o instrumento: frontmatter com modelo/esforço/ferramentas, apontando para a skill (D14b) |
| `.agents/corretor/SKILL.md` | ✅ **Novo.** Ponteiro, pela convenção do `CLAUDE.md` |
| `CLAUDE.md` | ✅ Regra 6 na lista de invioláveis; tabela de arquivos (não lista `sessoes/` nem este plano); "Modelo de dados" ganha `corretor` |
| `estudo.db` | ✅ Tabela `corretor`; `avaliacao.corretor_id`; backfill com trigger derrubado (R2); `DROP COLUMN avaliador` ao final (D20); `v_desempenho_corretor`. Extra não previsto: `trg_avaliacao_corretor`, que recusa avaliação sem `corretor_id` — a coluna não pôde nascer `NOT NULL` sem rebuild, e sem o trigger toda nota nova poderia nascer sem procedência em silêncio, que é o problema que D20 resolveu do outro lado |
| `docs/doc-setup/schema.md` | ✅ Documentar `corretor` e a nova FK; retirar `avaliador` (D20) |
| `scripts/mdpdf/ignorados.py` | ✅ **Feito** — `PREFIXOS` ignora `sessoes/perguntas/` (D8c) |
| `.gitignore` | ✅ `/sessoes/` ancorado na raiz — não `sessoes`, que casaria dentro de `marcacoes/` (D19) |
| `TODO.md` | ✅ Entrada própria para o defeito latente do `trg_sm2` (R1); ligar o item de CLI de LLM local a R5 |
