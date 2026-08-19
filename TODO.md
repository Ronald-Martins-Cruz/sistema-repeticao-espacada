# Certezas

## Crítico

- [X] Rever cálculo de dias após resposta
  (investigado: suspeita era que `intervalo_dias` usasse `facilidade`/`repeticoes` "antigos" por causa da semântica do `SET` em SQL avaliar contra a linha OLD. Confirmado que isso É o comportamento correto — o SM-2 canônico calcula I(n) com o EF e o n *anteriores à* rodada atual, só atualiza EF/n depois, para valerem na próxima revisão. Simulação manual da pergunta 77 [notas 0,0,5,2,2] bateu exatamente com o estado gravado em `agendamento`. Não é bug.). 
- [X] Ajustar documentação do `CLAUDE.md` de acordo com nova estrutura de arquivos.

## Não crítico

- [X] Remover ideia de "pegadinha" ou "como isso vira alternativa errada" das respostas
- [X] Rever uso de confiança (até se deve ser utilizado)
  (resolvido por remoção: custava um turno inteiro do usuário por pergunta e nunca mudou uma decisão de estudo — nem a `v_calibracao` nem o `gap_medio` foram usados para escolher o que revisar. Saíram `resposta.confianca` e `resposta.confianca_em`, os triggers `trg_confianca_depois_da_nota` e `trg_confianca_timestamp`, a view `v_calibracao` inteira, a coluna `gap_medio` de `v_desempenho_secao` e o ramo `confianca_antes_da_nota` de `v_auditoria`. A confiança declarada nas 124 respostas já gravadas foi junto — não é desativação reversível. O protocolo passou de quatro tempos para três: corrigir → gravar nota → revelar, e o Passo 4 da skill `estudo` deixou de existir.)
- [X] Criar método simples para incluir ou excluir ponto chave de resposta de pergunta
  (feito: `ponto_chave` ganhou soft delete — `ativo`, `motivo_desativacao`, `desativado_em`, `substitui_id` — mais `v_ponto_desativado` e os triggers `trg_ponto_chave_*`. Aplicar a sugestão agora é `UPDATE ponto_chave SET ativo = 0, motivo_desativacao = '...'` na própria sessão, depois da nota; o passo a passo está em "Corrigir um ponto-chave inadequado" na skill `estudo`. A regra 7 deixou de proibir mexer no gabarito durante a sessão e passou a proibir só a janela resposta-sem-nota, que o banco recusa sozinho.)
- [X] Registrar o motivo ao desativar uma pergunta, como já se faz no ponto-chave
  (feito: `pergunta` ganhou `tipo_desativacao` — `fora_de_foco` / `desatualizada` / `defeituosa` / `duplicada` — mais `desativada_para_prova_id`, `motivo_desativacao` e `desativada_em`, os triggers `trg_pergunta_*` e as views `v_pergunta_desativada` e `v_reativacao_sugerida`. O caso de uso não é o mesmo do ponto-chave: lá o motivo é atestado de óbito, aqui o caso principal é **arquivamento reversível** — pergunta boa que só não serve enquanto o alvo é a DATAPREV 2026. Por isso o motivo é um vocabulário fechado e consultável, não frase solta: a fronteira que importa é "volta sozinha × não volta". Só `fora_de_foco` volta, e é o único que exige o alvo — sem essa FK a pergunta ficaria arquivada e invisível para sempre. `v_reativacao_sugerida` levanta a mão no fim da sessão quando o alvo acaba, por status ou por data vencida; reativar continua sendo decisão do usuário, e virou a regra inviolável 8 porque é a única que o banco não consegue impor.)

# Incertezas

- [] Chat local sobre CLI de LLM (Claude Code/Codex) autenticada por plano, sem custo por token, só para uso local de um usuário
  (mínimo viável: terminal interativo mesmo — não headless — rodando `claude`/`codex` normal; resolve permissões de graça. Cara própria de UI fica pra outras partes do programa, não pro terminal)
- [] Há a ideia de troca para um algoritimo diferente como o `FSRS` ao invés do SM-2. De momento isso fica descartado, mas pode (e deve) ser reconsiderado após a prova. Trocar o algoritimo agora pode ser muito esforço em algo que não é o conteúdo da prova em si