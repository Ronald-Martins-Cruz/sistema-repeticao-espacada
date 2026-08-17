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
| `pergunta` | Chave natural `codigo` (`'Q94'`), estável — nunca reaproveitada mesmo se a pergunta for desativada. `numero` é a numeração interna sequencial do banco; não confundir com `ancora.numero_questao` (número da questão numa prova real — são dois espaços de numeração independentes). `profundidade` segue a escala D0–D5 (documentada na skill `incluir-pergunta`). `eh_distrator` marca pergunta nascida de alternativa errada de uma prova real; `eh_caso` marca enunciado baseado em cenário/código. `ativa = 0` tira a pergunta de circulação sem apagar histórico. |
| `ponto_chave` | O gabarito: exigências verificáveis de uma pergunta. `essencial = 1` significa que faltar esse ponto trava a nota em ≤ 2. `revisado = 1` significa que alguém conferiu a descrição contra a fonte primária (não contra a fonte gerada por IA). `fonte` torna o feedback acionável (`'LAI art. 24, §1º, I'`). **`ativo = 0` é o soft delete**: o ponto sai do gabarito sem sumir do histórico — `avaliacao_ponto` continua respondendo o que foi cobrado em cada correção passada, e por isso ponto já cobrado é imutável e indeletável por trigger. Desativar exige `motivo_desativacao`; `desativado_em` é carimbado sozinho. `substitui_id` liga o ponto reescrito ao que ele aposentou, o que torna visível (em `v_ponto_desativado`) o que ainda falta reescrever. |

### Prova / banca / etapa / âncora

Modelam de qual concurso, banca e fase uma pergunta se origina — substituem o
antigo `pergunta.tag_prova`, que era uma string solta (`'Q44'`) sem dizer *de
qual prova*.

| Tabela | Papel |
|---|---|
| `banca` | Only `nome` (`'FGV'`, `'Cebraspe'`...). Uma linha por banca examinadora. |
| `prova` | Um concurso específico: `orgao`, `cargo`, `ano`, `data_aplicacao`. `status` é o ciclo de vida (`alvo_atual` / `concluida` / `referencia`) — pode haver zero ou várias provas `alvo_atual` simultaneamente (é normal não ter nenhuma entre um concurso encerrado e a decisão do próximo). `relevancia` (`primaria` / `secundaria`, nulo até classificar) é um eixo **separado** de `status`: uma prova `concluida` pode ser referência primária de calibração sem deixar de estar encerrada. `fonte_dir` aponta para a pasta em `docs/provas/` correspondente, quando existir. |
| `etapa` | Uma fase de uma prova (`'objetiva'`, `'discursiva'`, `'titulos'`) — uma prova pode ter mais de uma, com formatos diferentes. `formato` é texto livre, sem `CHECK`: ao contrário da escala D0–D5 (conjunto fechado e conhecido), formatos de prova por aí não são enumeráveis hoje. |
| `ancora` | Tabela associativa `pergunta × etapa`. `numero_questao` é o número da questão **na prova real** — de novo, não confundir com `pergunta.numero`. Uma pergunta pode ancorar em mais de uma prova (várias linhas de `ancora`). |

### Histórico de estudo

| Tabela | Papel |
|---|---|
| `sessao` | Um bloco de estudo. `modo` diz o que estava sendo feito (`revisao`, `fraquezas`, `secao`, `simulado`, `livre`); `filtro` guarda o parâmetro (ex.: `'1.4'` quando `modo='secao'`). |
| `resposta` | O texto do usuário, na íntegra. **Imutável** por trigger (`trg_resposta_imutavel`) e **não deletável** (`trg_resposta_sem_delete`) — errou a resposta? Grave uma nova. `confianca` só pode ser preenchida depois que a nota já existe (`trg_confianca_depois_da_nota`); `confianca_em` é carimbado automaticamente na primeira gravação (`trg_confianca_timestamp`). |
| `avaliacao` | A nota (0–5) e o veredito (`branco`/`errado`/`vago`/`parcial`/`bom`/`completo`) de uma resposta. **Imutável** (`trg_avaliacao_imutavel`) e **não deletável** (`trg_avaliacao_sem_delete`) — reavaliação é uma linha nova, a antiga fica no histórico. |
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
| `v_calibracao` | Confiança declarada × nota recebida. `gap >= 2` é "ilusão de saber"; `gap <= -2` é "subestimou". |
| `v_pontos_falhados` | Pontos-chave agregados por quantas vezes falharam (`faltou`/`errou`) através de todas as perguntas que os cobram. |
| `v_sugestao_ponto` | Pontos-chave com falha sistemática (≥3 avaliações, ≥60% de falha, ainda falhando na tentativa mais recente): sugere se o caso pede pergunta dedicada (ponto essencial, concepção errada, ou distrator real da prova) ou se é candidato a remoção (nota não cai quando o ponto falha). |
| `v_desempenho_secao` | Média de nota e volume de respostas por seção, ordenado da pior média para a melhor. |
| `v_cobertura` | Por seção: quantas perguntas têm gabarito, quantas já foram respondidas ao menos uma vez, quantas nunca foram vistas. |
| `v_frequencia_notas_secao` | Por seção, a distribuição de notas (contagem de 0 a 5) — mostra se uma seção vai mal por notas médias ou por reprovações concentradas. |
| `v_progresso` | Panorama geral: total de perguntas ativas, quantas têm gabarito, quantas já foram respondidas, quantas estão devidas hoje, nota média geral. |
| `v_estatistica_pergunta` | Tentativas, nota média, pior nota e data da última resposta, por pergunta. |
| `v_auditoria` | Quebras de protocolo detectadas: reavaliação, confiança gravada antes da nota, ponto-chave criado (`gabarito_contaminado`) ou desativado (`ponto_desativado_antes_da_nota`) **dentro da janela** entre a resposta e a nota dela, resposta sem avaliação, nota alta incoerente com ponto essencial faltando. **Deve viver vazia.** A contaminação é medida pela janela, não pela data absoluta: mexer no gabarito com a resposta já lida e a nota ainda em aberto molda o critério ao que o usuário escreveu; depois da nota — imutável — não há o que inflar, e é assim que se conserta um ponto ruim. `nota_incoerente` não filtra `ativo`: desativar o ponto depois não lava a nota que foi dada contra ele. |
| `v_peso_secao` | Quanto cada seção pesou nas provas de referência: `COUNT(*)` de âncoras por seção, filtrado só pelas provas com `relevancia = 'primaria'`. Recalculada a cada consulta — não é coluna mantida à mão nem por trigger, porque o volume de dados não justifica a complexidade e uma coluna incrementada manualmente desalinha silenciosamente. Usada como subconsulta agregada dentro de `v_fila`, `v_fila_fraquezas`, `v_desempenho_secao`, `v_cobertura` e `v_frequencia_notas_secao` — nessas views o nome de coluna `peso_prova` continua existindo, só deixou de ser física em `secao`. |
| `v_alvos` | As provas com `status = 'alvo_atual'` (pode ser zero ou várias), com dias restantes até `data_aplicacao`. Substitui a antiga leitura de `config.data_prova`. |
| `v_catalogo` | Lista o banco inteiro sem expor gabarito (só um booleano `tem_gabarito`) — usada para checar duplicidade antes de inserir pergunta nova e para ter uma visão geral do banco. Inclui as âncoras de cada pergunta já formatadas (`'FGV DATAPREV 2024 Q44'`). |

## Triggers e os invariantes que protegem

| Trigger | Invariante |
|---|---|
| `trg_pergunta_agenda` | Toda pergunta nova ganha automaticamente uma linha em `agendamento`. Sem isso, `v_fila` nunca a incluiria. |
| `trg_sm2` | Reagenda uma pergunta ao inserir uma `avaliacao`, aplicando o algoritmo SM-2 (fator de facilidade, intervalo, contagem de repetições/lapsos). É o único caminho legítimo de escrita em `agendamento`. |
| `trg_confianca_depois_da_nota` | Impede gravar `resposta.confianca` antes de existir uma `avaliacao` para aquela resposta — a ordem correção → nota → confiança → revelação é imposta pelo próprio banco, não só por protocolo. |
| `trg_confianca_timestamp` | Carimba `confianca_em` automaticamente na primeira gravação de confiança, para `v_auditoria` conseguir detectar confiança lançada fora de ordem. |
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
`ix_resposta_data`, `ix_avaliacao_resposta`, `ix_avaliacao_ponto_pc`,
`ix_agendamento_proxima`, `ix_pergunta_secao`, `ix_prova_status`,
`ix_etapa_prova`, `ix_ancora_pergunta`, `ix_ancora_etapa` — todos apoiam
consultas que as views ou o fluxo de sessão fazem com frequência (busca por
pergunta, por sessão, por data, e a fila ordenada por `proxima_revisao`).
