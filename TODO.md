# Certezas

## Crítico

- [X] Rever cálculo de dias após resposta
  (investigado: suspeita era que `intervalo_dias` usasse `facilidade`/`repeticoes` "antigos" por causa da semântica do `SET` em SQL avaliar contra a linha OLD. Confirmado que isso É o comportamento correto — o SM-2 canônico calcula I(n) com o EF e o n *anteriores à* rodada atual, só atualiza EF/n depois, para valerem na próxima revisão. Simulação manual da pergunta 77 [notas 0,0,5,2,2] bateu exatamente com o estado gravado em `agendamento`. Não é bug.). 
- [X] Ajustar documentação do `CLAUDE.md` de acordo com nova estrutura de arquivos.

## Não crítico

- [X] Remover ideia de "pegadinha" ou "como isso vira alternativa errada" das respostas
- [] Rever uso de confiança (até se deve ser utilizado)
- [X] Criar método simples para incluir ou excluir ponto chave de resposta de pergunta
  (feito: `ponto_chave` ganhou soft delete — `ativo`, `motivo_desativacao`, `desativado_em`, `substitui_id` — mais `v_ponto_desativado` e os triggers `trg_ponto_chave_*`. Aplicar a sugestão agora é `UPDATE ponto_chave SET ativo = 0, motivo_desativacao = '...'` na própria sessão, depois da nota; o passo a passo está em "Corrigir um ponto-chave inadequado" na skill `estudo`. A regra 7 deixou de proibir mexer no gabarito durante a sessão e passou a proibir só a janela resposta-sem-nota, que o banco recusa sozinho.)

# Incertezas

- [] Chat local sobre CLI de LLM (Claude Code/Codex) autenticada por plano, sem custo por token, só para uso local de um usuário
  (mínimo viável: terminal interativo mesmo — não headless — rodando `claude`/`codex` normal; resolve permissões de graça. Cara própria de UI fica pra outras partes do programa, não pro terminal)
- [] Há a ideia de troca para um algoritimo diferente como o `FSRS` ao invés do SM-2. De momento isso fica descartado, mas pode (e deve) ser reconsiderado após a prova. Trocar o algoritimo agora pode ser muito esforço em algo que não é o conteúdo da prova em si