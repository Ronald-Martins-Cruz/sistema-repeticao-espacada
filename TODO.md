# Certezas

## Crítico

- [X] Rever cálculo de dias após resposta
  (investigado: suspeita era que `intervalo_dias` usasse `facilidade`/`repeticoes` "antigos" por causa da semântica do `SET` em SQL avaliar contra a linha OLD. Confirmado que isso É o comportamento correto — o SM-2 canônico calcula I(n) com o EF e o n *anteriores à* rodada atual, só atualiza EF/n depois, para valerem na próxima revisão. Simulação manual da pergunta 77 [notas 0,0,5,2,2] bateu exatamente com o estado gravado em `agendamento`. Não é bug.)
- [X] Ajustar documentação do `CLAUDE.md` de acordo com nova estrutura de arquivos.

## Não crítico

- [X] Remover ideia de "pegadinha" ou "como isso vira alternativa errada" das respostas
- [] Rever uso de confiança (até se deve ser utilizado)
- [] Criar método simples para incluir ou excluir ponto chave de resposta de pergunta
  (diagnóstico pronto: `v_sugestao_ponto` já aponta os candidatos; falta o método de aplicar a sugestão)
- [] Chat local sobre CLI de LLM (Claude Code/Codex) autenticada por plano, sem custo por token, só para uso local de um usuário
  (mínimo viável: terminal interativo mesmo — não headless — rodando `claude`/`codex` normal; resolve permissões de graça. Cara própria de UI fica pra outras partes do programa, não pro terminal)

# Incertezas