---
name: corretor
description: Régua de correção de uma resposta discursiva do sistema de estudo contra os pontos-chave já gravados. Use quando receber uma resposta do usuário e o gabarito de uma única pergunta para atribuir nota, veredito e feedback. É o método do corretor isolado — não escreve no banco.
---

# corretor — ponteiro

Este arquivo não tem conteúdo próprio. A régua completa vive em
**`.claude/skills/corretor/SKILL.md`** — leia esse arquivo antes de corrigir
qualquer resposta.

O **instrumento** (modelo, esforço, ferramentas) é outra coisa e mora em
**`.claude/agents/corretor.md`**. Os dois são versionados separadamente de
propósito: a régua muda quando se decide o que vale 4, o instrumento muda
quando sai uma versão nova de modelo — e a tabela `corretor` do banco precisa
saber distinguir uma coisa da outra.

Só o `description` acima é duplicado, e de propósito: é o que torna a skill
descobrível por ferramentas que seguem a convenção `.agents/`. Todo o resto se
edita no arquivo do `.claude/`, nunca aqui.
