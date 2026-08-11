---
name: estudo
description: Protocolo do sistema de estudo por perguntas discursivas em estudo.db (concurso FGV/DATAPREV). Use quando o usuário quiser estudar, revisar, responder perguntas, retomar a fila do dia, ver o progresso ou a calibração, e também quando quiser preparar os gabaritos (pontos-chave) de uma seção. Leia antes de enunciar qualquer pergunta.
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
é sua, contra um gabarito que já estava gravado antes da resposta.

## A prova é objetiva. O formato discursivo é método, não espelho

Múltipla escolha, banca FGV, 70 questões. **Não existe questão discursiva na
prova.** Escrever a resposta por extenso é escolha do usuário, por dois motivos:
produzir do zero fixa mais do que reconhecer alternativa, e resposta escrita
expõe o buraco que a alternativa certa taparia por reconhecimento.

O que isso muda na sua conduta:

- **Não dê feedback de redação.** Nada sobre estrutura, introdução, coesão,
  clareza ou tamanho do texto. Resposta telegráfica com todos os pontos-chave
  vale 5; parágrafo bem escrito sem os números vale 3.
- **Corrija o que a banca cobra:** número exato, prazo, percentual, rol completo,
  nome correto e — principalmente — a fronteira entre termos vizinhos. O padrão
  da FGV nesta prova é **trocar conceitos de lugar** (Spring Boot ↔ Spring Cloud,
  intranet ↔ extranet, OLTP ↔ OLAP, ETL ↔ ELT). Saber o que o termo **não** é
  elimina 3 ou 4 alternativas.
- **Perguntas `[distrator]` nasceram de alternativas erradas da prova** e são as
  mais valiosas justamente porque a prova é objetiva: bancas reciclam distrator.
  Erro em pergunta de distrator é erro caro.

## Regras que não se negociam

1. **Nunca mostre o gabarito antes da resposta.** Para enunciar uma pergunta, use
   `v_fila` ou `v_fila_fraquezas` — elas não expõem nenhuma coluna de
   `ponto_chave`. Só consulte `v_gabarito` depois que a resposta estiver gravada
   em `resposta`.
2. **Não revele a nota antes de perguntar a confiança.** A ordem é corrigir →
   gravar → perguntar confiança → revelar. O banco recusa gravar confiança em
   resposta que ainda não tem nota.
3. **Grave a resposta na íntegra**, sem resumir, corrigir ortografia ou
   reescrever. É o texto do usuário que vai ser reavaliado meses depois.
4. **"Não sei" é nota 0 registrada, nunca pergunta pulada.** Resposta em branco é
   o dado mais informativo do banco.
5. **Não invente pergunta.** Só use enunciado que veio do banco.
6. **Não reagende nada à mão.** Um trigger cuida do SM-2 sozinho ao inserir a
   avaliação. Se você escrever em `agendamento`, quebra o cronograma.
7. **Uma pergunta por vez.** Não enfileire três perguntas numa mensagem só.

## As duas atividades

| Atividade | Quando | Leia |
|---|---|---|
| **Sessão de estudo** — perguntar, corrigir, registrar | o usuário quer estudar/revisar | [`sessao.md`](sessao.md) |
| **Preparar gabarito** — escrever os pontos-chave de uma seção | o usuário quer liberar perguntas novas | [`gabarito.md`](gabarito.md) |

**Nunca faça as duas na mesma conversa.** Gabarito escrito depois de ler a
resposta do usuário se molda ao que ele escreveu, e a nota infla — `v_auditoria`
acusa isso como `gabarito_contaminado`. Se estiver numa sessão de estudo e faltar
gabarito, encerre a sessão e peça uma conversa nova para prepará-lo.

## Views disponíveis

Use as views em vez de montar SQL na mão.

| View | Para quê |
|---|---|
| `v_fila` | Perguntas devidas hoje, sem gabarito. Use para perguntar |
| `v_fila_fraquezas` | As que o usuário já erra, pior primeiro. Também sem gabarito |
| `v_gabarito` | Pontos-chave. **Só depois de gravar a resposta** |
| `v_calibracao` | Confiança × nota. `gap >= 2` = ilusão de saber |
| `v_pontos_falhados` | Conceitos derrubados em perguntas diferentes |
| `v_sugestao_ponto` | Pontos-chave com falha sistemática (≥3 avaliações, ≥60% de falha, ainda falhando na última tentativa): sugere pergunta dedicada ou remoção do ponto |
| `v_desempenho_secao` | Média e volume por seção, ordenado pela pior |
| `v_cobertura` | O que falta preparar e o que nunca caiu |
| `v_progresso` | Panorama geral e contagem regressiva da prova |
| `v_auditoria` | Quebras de protocolo. Deve viver vazia |
| `v_estatistica_pergunta` | Tentativas e média por pergunta |

## Manutenção

- O usuário editou `perguntas.md`? Rode `python importar.py`. É idempotente:
  histórico sobrevive a edição, reordenação e remoção.
- Data da prova: `INSERT INTO config VALUES ('data_prova','2026-10-18')
  ON CONFLICT(chave) DO UPDATE SET valor=excluded.valor;`
- `resposta` e `avaliacao` são imutáveis por trigger. Errou a nota? Insira uma
  **nova** avaliação — a antiga fica no histórico e a divergência aparece em
  `v_auditoria` como `reavaliacao`.
- Depois de mexer no banco, ofereça o dump: `sqlite3 estudo.db .dump > estudo.sql`
