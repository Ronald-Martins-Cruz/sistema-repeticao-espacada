# Schema do banco — referência

Documentação de leitura da estrutura completa de `estudo.db`. A fonte de
verdade é sempre o banco em si:

```sh
sqlite3 estudo.db .schema
```

Este arquivo existe para não obrigar a releitura do `.schema` bruto toda vez
que se precisa lembrar o que uma tabela, view ou trigger faz — e para explicar
o *porquê* de decisões que o SQL sozinho não conta. Tudo é `STRICT`, e todo
comando de escrita deve rodar com `PRAGMA foreign_keys = ON;`.

## Tabelas

### Núcleo do banco de perguntas

| Tabela | Papel |
|---|---|
| `secao` | As 30 seções do edital, em 2 partes (`I`: legislação; `II`: conhecimentos técnicos). `codigo` (`'1.1'`, `'2.22'`) é a chave usada nas outras tabelas e no `secoes.md`. |
| `pergunta` | Chave natural `codigo` (`'Q94'`), estável — nunca reaproveitada mesmo se a pergunta for desativada. `numero` é a numeração interna sequencial do banco; não confundir com `ancora.numero_questao` (número da questão numa prova real — são dois espaços de numeração independentes). `profundidade` segue a escala D0–D5 (documentada na skill `incluir-pergunta`). `eh_distrator` marca pergunta nascida de alternativa errada de uma prova real; `eh_caso` marca enunciado baseado em cenário/código. `resposta_modelo` guarda a resposta modelo/padrão da pergunta (texto opcional). **`ativa = 0` tira a pergunta de circulação sem apagar histórico, e não é um booleano nu**: desativar exige `tipo_desativacao` (`fora_de_foco` / `desatualizada` / `defeituosa` / `duplicada`), imposto por trigger. A fronteira que esse vocabulário compra é a única que importa na hora de trazer de volta — **volta sozinha × não volta**. Só `fora_de_foco` é arquivamento reversível (pergunta boa que não serve ao alvo atual), e por isso é o único que também exige `desativada_para_prova_id`: sem dizer *foco de quê*, a pergunta ficaria arquivada e invisível para sempre. Nos outros três a FK fica nula — não há alvo associado a "esta pergunta está errada". `motivo_desativacao` é texto livre opcional, para o que o tipo não conta; `desativada_em` é carimbado sozinho. Reativar (`ativa = 1`) limpa os quatro campos: eles descrevem o estado atual, não histórico. |
| `ponto_chave` | O gabarito: exigências verificáveis de uma pergunta. `essencial = 1` significa que faltar esse ponto trava a nota em ≤ 2. `revisado = 1` significa que alguém conferiu a descrição contra a fonte primária (não contra a fonte gerada por IA). `fonte` torna o feedback acionável (`'LAI art. 24, §1º, I'`). **`ativo = 0` é o soft delete**: o ponto sai do gabarito sem sumir do histórico — `avaliacao_ponto` continua respondendo o que foi cobrado em cada correção passada, e por isso ponto já cobrado é imutável e indeletável por trigger. Desativar exige `motivo_desativacao`; `desativado_em` é carimbado sozinho. `substitui_id` liga o ponto reescrito ao que ele aposentou, o que torna visível (em `v_ponto_desativado`) o que ainda falta reescrever. |

### Prova / banca / etapa / âncora

Modelam de qual concurso, banca e fase uma pergunta se origina — substituem o
antigo `pergunta.tag_prova`, que era uma string solta (`'Q44'`) sem dizer *de
qual prova*.

| Tabela | Papel |
|---|---|
| `banca` | Only `nome` (`'FGV'`, `'Cebraspe'`...). Uma linha por banca examinadora. |
| `prova` | Um concurso específico: `orgao`, `cargo`, `ano`, `data_aplicacao`. `status` é o ciclo de vida (`alvo_atual` / `concluida` / `referencia`) — pode haver zero ou várias provas `alvo_atual` simultaneamente (é normal não ter nenhuma entre um concurso encerrado e a decisão do próximo). `relevancia` (`primaria` / `secundaria`, nulo até classificar) é um eixo **separado** de `status`: uma prova `concluida` pode ser referência primária de calibração sem deixar de estar encerrada. `fonte_dir` aponta para a pasta correspondente em `docs/` (`provas-editais-alvo/` para o concurso-alvo, `provas-editais-base/` para as de referência), quando existir. |
| `etapa` | Uma fase de uma prova (`'objetiva'`, `'discursiva'`, `'titulos'`) — uma prova pode ter mais de uma, com formatos diferentes. `formato` é texto livre, sem `CHECK`: ao contrário da escala D0–D5 (conjunto fechado e conhecido), formatos de prova por aí não são enumeráveis hoje. |
| `ancora` | Tabela associativa `pergunta × etapa`. `numero_questao` é o número da questão **na prova real** — de novo, não confundir com `pergunta.numero`. Uma pergunta pode ancorar em mais de uma prova (várias linhas de `ancora`). |

### Histórico de estudo

| Tabela | Papel |
|---|---|
| `sessao` | Um bloco de estudo — hoje, literalmente **um bloco de 5 perguntas**: a sessão em bloco abre uma linha aqui por bloco, então uma noite com 14 perguntas devidas são três sessões. `modo` diz o que estava sendo feito (`revisao`, `fraquezas`, `secao`, `simulado`, `livre`); `filtro` guarda o parâmetro (ex.: `'1.4'` quando `modo='secao'`). |
| `resposta` | O texto do usuário, na íntegra. **Imutável** por trigger (`trg_resposta_imutavel`) e **não deletável** (`trg_resposta_sem_delete`) — errou a resposta? Grave uma nova. Isso torna **resposta gravada na pergunta errada um lixo permanente**, que ainda envenena o SM-2 de duas perguntas: é o risco que a folha de resposta com o `codigo` em cada bloco e a tabela de conferência antes do `INSERT` existem para eliminar. `segundos` fica `NULL` no modo bloco — não há cronômetro por pergunta, e a coluna não é lida por nenhuma view, trigger ou pelo SM-2. |
| `avaliacao` | A nota (0–5) e o veredito (`branco`/`errado`/`vago`/`parcial`/`bom`/`completo`) de uma resposta, mais `corretor_id` — **qual instrumento deu essa nota**. **Imutável** (`trg_avaliacao_imutavel`) e **não deletável** (`trg_avaliacao_sem_delete`) — reavaliação é uma linha nova, a antiga fica no histórico. A coluna `avaliador` (texto livre, `'ia'` em todas as 177 linhas) foi substituída por `corretor_id` e dropada em 21/08/2026: manter as duas seria ter duas fontes de procedência discordando, já que `avaliador` era `NOT NULL DEFAULT 'ia'` e carimbaria toda avaliação nova em silêncio. |
| `corretor` | O instrumento que produz uma nota: `modelo`, `esforco`, `provedor`, `isolamento` (`principal`/`subagente`), `versao_instrucoes` e `parametros` (JSON, validado por `CHECK json_valid`). Existe porque nota inflada não distorce só a média — **move o cronograma** (`trg_sm2` converte nota em `intervalo_dias`; um 4 tira a pergunta de circulação por ~40 dias), e sem registrar o instrumento não há como distinguir "eu melhorei" de "o corretor afrouxou". `isolamento` é coluna própria de propósito: é o eixo do contexto frio e não deve poluir o campo do modelo. `esforco` é texto livre, sem `CHECK` — cada fornecedor nomeia o tier diferente e há quem use orçamento numérico —, com o parâmetro bruto em `parametros`. **`versao_instrucoes` é o SHA-256 de `.claude/skills/corretor/SKILL.md`**, a régua; a definição do agente (`.claude/agents/corretor.md`) não precisa de hash próprio porque `modelo` e `esforco` já são a desnormalização do que o frontmatter dela declara. Trocou o modelo → muda `modelo`; editou a régua → muda `versao_instrucoes`; é assim que se descobre depois qual das duas causas moveu as notas. A linha `modelo = 'desconhecido'`, `isolamento = 'principal'` é o backfill honesto das avaliações anteriores a 21/08/2026 — "algum modelo Claude, versão desconhecida, uma pergunta por vez"; não se retroage procedência inventada. |
| `avaliacao_ponto` | Por avaliação, o status de cada `ponto_chave` cobrado (`citou`/`parcial`/`faltou`/`errou`). É o que alimenta `v_pontos_falhados` e `v_sugestao_ponto`. |
| `agendamento` | Estado SM-2 por pergunta: `facilidade` (fator de facilidade, piso 1.3), `intervalo_dias`, `repeticoes` (acertos consecutivos), `lapsos`, `proxima_revisao`. **Nunca escrever à mão** — `trg_sm2` reagenda sozinho ao inserir uma avaliação, e toda pergunta nova já ganha uma linha aqui via `trg_pergunta_agenda`. |
| `config` | Pares chave/valor de configuração solta. Hoje sem uso ativo — a contagem regressiva de prova, que antes morava aqui (`data_prova`), virou a view `v_alvos`, derivada de `prova.status = 'alvo_atual'`. |

## Views

Use-as em vez de montar SQL na mão — cada uma já encapsula a regra de negócio
certa (não expor gabarito antes da hora, filtrar só o que está ativo, etc.).

| View | Para quê |
|---|---|
| `v_fila` | Perguntas devidas hoje, sem gabarito. Ordena por atraso, depois por prioridade (distrator e âncora em prova primária pesam mais), depois pelo peso da seção na prova real. Use para enunciar. |
| `v_fila_fraquezas` | As perguntas que o usuário já erra (nota média < 4, pelo menos uma tentativa), pior primeiro. Também sem gabarito. |
| `v_gabarito` | Os pontos-chave **ativos** de cada pergunta. **Só consultar depois que a resposta já estiver gravada** — ver regra 1 do `CLAUDE.md`. |
| `v_ponto_desativado` | O outro lado de `v_gabarito`: os pontos com `ativo = 0`, com motivo, data, quantas vezes já foram cobrados e qual ponto ativo os substituiu. `substituto_id IS NULL` é a fila de trabalho da conversa de gabarito — ponto tirado de circulação que ninguém reescreveu ainda. |
| `v_pontos_falhados` | Pontos-chave agregados por quantas vezes falharam (`faltou`/`errou`) através de todas as perguntas que os cobram. |
| `v_sugestao_ponto` | Pontos-chave com falha sistemática (≥3 avaliações, ≥60% de falha, ainda falhando na tentativa mais recente): sugere se o caso pede pergunta dedicada (ponto essencial, concepção errada, ou distrator real da prova) ou se é candidato a remoção (nota não cai quando o ponto falha). |
| `v_desempenho_secao` | Média de nota e volume de respostas por seção, ordenado da pior média para a melhor. |
| `v_desempenho_corretor` | O mesmo eixo, mas por **instrumento de correção**: modelo, esforço, isolamento, os 12 primeiros caracteres do hash da régua, volume, nota média e quantas notas caíram em ≥4 e em ≤2. É a view que responde "as notas subiram porque eu melhorei ou porque o corretor afrouxou?" — desde que o instrumento tenha sido registrado a cada avaliação, que é o que `corretor_id` obrigatório garante. |
| `v_cobertura` | Por seção: quantas perguntas têm gabarito, quantas já foram respondidas ao menos uma vez, quantas nunca foram vistas. |
| `v_frequencia_notas_secao` | Por seção, a distribuição de notas (contagem de 0 a 5) — mostra se uma seção vai mal por notas médias ou por reprovações concentradas. |
| `v_progresso` | Panorama geral: total de perguntas ativas, quantas têm gabarito, quantas já foram respondidas, quantas estão devidas hoje, nota média geral. |
| `v_estatistica_pergunta` | Tentativas, nota média, pior nota e data da última resposta, por pergunta. |
| `v_auditoria` | Quebras de protocolo detectadas: reavaliação, ponto-chave criado (`gabarito_contaminado`) ou desativado (`ponto_desativado_antes_da_nota`) **dentro da janela** entre a resposta e a nota dela, resposta sem avaliação, nota alta incoerente com ponto essencial faltando. **Deve viver vazia.** A contaminação é medida pela janela, não pela data absoluta: mexer no gabarito com a resposta já lida e a nota ainda em aberto molda o critério ao que o usuário escreveu; depois da nota — imutável — não há o que inflar, e é assim que se conserta um ponto ruim. `nota_incoerente` não filtra `ativo`: desativar o ponto depois não lava a nota que foi dada contra ele. |
| `v_peso_secao` | Quanto cada seção pesou nas provas de referência: `COUNT(*)` de âncoras por seção, filtrado só pelas provas com `relevancia = 'primaria'`. Recalculada a cada consulta — não é coluna mantida à mão nem por trigger, porque o volume de dados não justifica a complexidade e uma coluna incrementada manualmente desalinha silenciosamente. Usada como subconsulta agregada dentro de `v_fila`, `v_fila_fraquezas`, `v_desempenho_secao`, `v_cobertura` e `v_frequencia_notas_secao` — nessas views o nome de coluna `peso_prova` continua existindo, só deixou de ser física em `secao`. |
| `v_alvos` | As provas com `status = 'alvo_atual'` (pode ser zero ou várias), com dias restantes até `data_aplicacao`. Substitui a antiga leitura de `config.data_prova`. `dias_restantes` conta **dias de calendário**: compara `date('now','localtime')` com a data da prova, e não o instante atual — comparar com o instante truncava a fração e devolvia um dia a menos em toda hora que não fosse a meia-noite (26/08 → 11/10 saía 45 em vez de 46). É a contagem regressiva que fecha o feedback de cada sessão. |
| `v_pergunta_desativada` | O arquivo: as perguntas com `ativa = 0`, com tipo, motivo, data, o alvo contra o qual foram arquivadas (e o status dele) mais o histórico que levaram junto — tentativas e última nota. É o `v_ponto_desativado` um nível acima, na pergunta em vez do ponto. |
| `v_reativacao_sugerida` | As perguntas `fora_de_foco` cujo alvo já acabou, **agrupadas por seção** — a tabela de fim de sessão. "Acabou" tem dois caminhos independentes: a prova deixou de ser `alvo_atual`, **ou** a `data_aplicacao` simplesmente passou (a sugestão aparece sozinha mesmo que ninguém tenha tocado no `status`). Os outros três tipos de desativação nunca entram aqui — é para isso que o vocabulário é fechado. Vem quebrada por seção para permitir reativar um lote por vez, em vez de despejar o arquivo inteiro no topo da fila no mesmo dia. **Sugere, nunca reativa** — regra 8 do `CLAUDE.md`. |
| `v_catalogo` | Lista o banco inteiro sem expor gabarito (só um booleano `tem_gabarito`) — usada para checar duplicidade antes de inserir pergunta nova e para ter uma visão geral do banco. Inclui as âncoras de cada pergunta já formatadas (`'FGV DATAPREV 2024 Q44'`) e, ao lado de `ativa`, o `tipo_desativacao` de quem está fora de circulação. |

## Triggers e os invariantes que protegem

| Trigger | Invariante |
|---|---|
| `trg_pergunta_agenda` | Toda pergunta nova ganha automaticamente uma linha em `agendamento`. Sem isso, `v_fila` nunca a incluiria. |
| `trg_pergunta_tipo` | Recusa `ativa = 0` sem `tipo_desativacao`. É o `trg_ponto_chave_motivo` da pergunta: soft delete sem a razão guarda a linha e perde a informação que justificava guardá-la. Escuta `UPDATE OF ativa, tipo_desativacao` — não só `ativa` — para também barrar quem zere o tipo depois, numa pergunta já arquivada. |
| `trg_pergunta_alvo` | Recusa `tipo_desativacao = 'fora_de_foco'` sem `desativada_para_prova_id`. "Fora do foco" não significa nada sem dizer foco de quê, e `v_reativacao_sugerida` só enxerga a pergunta através dessa FK: nula, a pergunta some para sempre — exatamente o fracasso que a sugestão existe para evitar. Trigger separado do anterior porque `RAISE(ABORT, …)` só aceita string literal, então uma mensagem por campo faltante exige um trigger por campo. |
| `trg_pergunta_janela` | Recusa arquivar pergunta que tem resposta **sem nota**. O ramo `sem_avaliacao` de `v_auditoria` não filtra `ativa`: a pergunta arquivada nesse estado acusaria ali para sempre, e essa view só serve enquanto vive vazia. Bloquear na entrada sai mais barato que ensinar a view a ignorar. |
| `trg_pergunta_desativada_em` | Carimba `desativada_em` na desativação. |
| `trg_pergunta_reativada` | Reativar (`ativa = 1`) limpa `desativada_em`, `motivo_desativacao`, `tipo_desativacao` e `desativada_para_prova_id` — os quatro descrevem o estado atual, e ficariam mentindo sobre uma pergunta em uso. Mesma mecânica do `trg_ponto_chave_reativado`. |
| `trg_sm2` | Reagenda uma pergunta ao inserir uma `avaliacao`, aplicando o algoritmo SM-2 (fator de facilidade, intervalo, contagem de repetições/lapsos). É o único caminho legítimo de escrita em `agendamento`. **Não é idempotente e não tem cláusula `WHEN`**: uma segunda avaliação da mesma resposta aplica o passo duas vezes — `facilidade` recebe o ajuste do EF duplicado, `repeticoes` incrementa duas vezes, e o intervalo sai ≈ `intervalo × facilidade²`. Nunca aconteceu (zero respostas com mais de uma avaliação), mas é defeito latente e atinge dois caminhos reais: consertar nota errada e calibrar corretores sobre a mesma resposta. Registrado no `TODO.md`; ver lá os formatos de guard. |
| `trg_avaliacao_corretor` | Recusa `avaliacao` sem `corretor_id`. É a versão em schema do invariante de procedência: a coluna não pôde nascer `NOT NULL` (a tabela já tinha 177 linhas e isso exigiria rebuild), então o trigger impõe o mesmo na entrada. `BEFORE INSERT`, então não atrapalhou o backfill, que foi `UPDATE`. Sem ele, toda avaliação nova poderia nascer com procedência nula em silêncio — exatamente o problema que dropar `avaliador` resolveu. |
| `trg_resposta_imutavel` | Bloqueia `UPDATE` em `resposta.texto`/`pergunta_id`/`respondida_em`. A resposta é o dado bruto; reavaliar é inserir, nunca editar. |
| `trg_resposta_sem_delete` | Bloqueia `DELETE` em `resposta`. Histórico de resposta nunca desaparece. |
| `trg_avaliacao_imutavel` | Bloqueia `UPDATE` em `avaliacao`. Nota errada vira uma **nova** linha, a antiga permanece — `v_auditoria` acusa como `reavaliacao`. |
| `trg_avaliacao_sem_delete` | Bloqueia `DELETE` em `avaliacao`. Mesmo raciocínio: histórico de nota nunca desaparece. |
| `trg_ponto_chave_imutavel` | Bloqueia `UPDATE` de `descricao`/`fonte`/`essencial`/`peso` em ponto que já apareceu em alguma `avaliacao_ponto` — a nota foi dada contra aquele texto, reescrevê-lo falsificaria o histórico. Corrigir é desativar e inserir substituto. `revisado` e `ordem` continuam editáveis. |
| `trg_ponto_chave_sem_delete` | Bloqueia `DELETE` de ponto já cobrado. Ponto nunca cobrado ainda pode ser apagado — não há histórico a perder. |
| `trg_ponto_chave_janela_insert` / `trg_ponto_chave_janela_update` | Recusam inserir ou desativar ponto de uma pergunta que tem resposta **sem nota**. É a regra 7 imposta pelo banco: essa é a janela em que o gabarito se molda à resposta já lida. Fechada a janela (nota gravada, e nota é imutável), consertar o gabarito é livre. |
| `trg_ponto_chave_motivo` | Recusa `ativo = 0` sem `motivo_desativacao`. Soft delete sem o motivo guarda a linha e perde a informação que justificava guardá-la. |
| `trg_ponto_chave_desativado_em` | Carimba `desativado_em` na desativação — é o que permite a `v_auditoria` detectar desativação dentro da janela. |
| `trg_ponto_chave_reativado` | Reativar (`ativo = 1`) limpa `desativado_em` e `motivo_desativacao`, que ficariam mentindo sobre um ponto em uso. É o desfazer de um engano. |

## Índices

`ix_ponto_chave_pergunta`, `ix_ponto_chave_ativo`, `ix_resposta_pergunta`, `ix_resposta_sessao`,
`ix_resposta_data`, `ix_avaliacao_resposta`, `ix_avaliacao_corretor`, `ix_avaliacao_ponto_pc`,
`ix_agendamento_proxima`, `ix_pergunta_secao`, `ix_prova_status`,
`ix_etapa_prova`, `ix_ancora_pergunta`, `ix_ancora_etapa` — todos apoiam
consultas que as views ou o fluxo de sessão fazem com frequência (busca por
pergunta, por sessão, por data, e a fila ordenada por `proxima_revisao`).

Fora deles há um índice que não é otimização, e sim **constraint**:

- `ux_corretor` — `UNIQUE` sobre `(modelo, provedor, isolamento,
  COALESCE(esforco,''), COALESCE(versao_instrucoes,''))`. É índice de expressão,
  e não uma constraint `UNIQUE` de tabela, por um motivo específico: em SQLite
  dois `NULL` são distintos num `UNIQUE`, então a constraint nua deixaria passar
  duas linhas com `esforco` nulo e todo o resto igual — que é exatamente a forma
  da linha de backfill. O `COALESCE` fecha esse buraco.

  Ele garante **ausência de duplicata exata, e só isso**. Contra `opus-5` vs
  `claude-opus-5` vs `Opus 5` — três strings, uma configuração real — ele não
  faz nada: são três linhas legítimas aos olhos do índice. A normalização é
  protocolo, não schema, e mora na skill `estudo` ("Registrar o corretor"):
  ler a tabela antes de inserir, reusar o `id` que casar.
