---
name: pdf-estudo
description: Converte os textos de estudo em .md para PDF de leitura preservando os grifos, traços de caneta e notas feitos no Microsoft Edge. Use quando o usuário quiser ler/estudar/imprimir um texto em PDF, quando pedir para gerar ou atualizar os PDFs, quando tiver acabado de marcar um PDF no Edge, ou quando editar um .md que já tem PDF gerado.
---

# PDF de estudo com as marcações preservadas

O usuário estuda lendo PDF no Edge e grifando. Os textos-fonte são markdown.
Esta skill mantém os dois em dia: o markdown continua sendo a verdade, o PDF
continua sendo regerável, e **as marcações sobrevivem à regeração**.

Como: uma marcação não vale pelas coordenadas onde foi feita, e sim pelo texto
que ela cobre. Grifo guarda as palavras sob si; traço de caneta guarda a linha
de texto por baixo dele mais o traço em coordenadas relativas àquela linha.
Regerado o PDF, procura-se o texto de novo e redesenha-se a marcação onde ele
foi parar. As marcações vivem em `scripts/mdpdf/marcacoes/*.json`, versionado
no git — o `pdf/` é descartável e está no `.gitignore`.

## O ciclo

```
   marcar no Edge  ──►  colher  ──►  editar o .md  ──►  gerar  ──►  ler de novo
                          ▲                                │
                          └────────────────────────────────┘
```

**A regra que não pode ser quebrada: colher antes de editar o markdown.** Se o
usuário marcar no Edge e o PDF for regerado sem colher, as marcas se perderiam.
Existe uma trava para isso — `gerar` se recusa a passar por cima de marcação
que ainda não está no sidecar — mas não conte com ela: colha primeiro.

Lembre o usuário de que **o Edge só grava as marcações quando ele salva**
(Ctrl+S). Marcar e fechar a aba perde tudo antes mesmo de chegar aqui.

## Comandos

```sh
python -m scripts.mdpdf ciclo                     # colhe tudo e regera tudo
python -m scripts.mdpdf ciclo fontes-estudo/x.md  # só um arquivo (aceita pastas)
python -m scripts.mdpdf colher                    # só lê o que foi marcado no Edge
python -m scripts.mdpdf gerar                     # só regera e reaplica
python -m scripts.mdpdf status                    # o que mudou, o que tem marca por colher
```

`ciclo` é o comando do dia a dia — é `colher` seguido de `gerar`, na ordem
certa. Na dúvida, use `ciclo`.

O pacote mora em `scripts/mdpdf/`; **rode sempre a partir da raiz do
repositório**, que é de onde ele resolve os caminhos dos documentos.

Um `.md` em `fontes-estudo/x.md` vira `pdf/fontes-estudo/x.pdf` com as marcas
em `scripts/mdpdf/marcacoes/fontes-estudo/x.json`. A árvore é espelhada de
propósito: há dois arquivos chamados `fontes.md` no repositório e achatar tudo
numa pasta só faria um sobrescrever o outro.

## O que reportar ao usuário depois de gerar

Cada marcação termina num de três desfechos, e todos aparecem na saída:

| Desfecho | O que houve | O que dizer |
|---|---|---|
| **exata** | o texto foi reencontrado igual | nada, é o normal |
| **aproximada** | o trecho foi reescrito e casou por semelhança | peça para conferir; o grifo pode ter pegado uma palavra a mais ou a menos |
| **órfã** | o texto sumiu do documento | diga qual trecho; se ele apareceu noutro arquivo, o comando já avisa |

Órfãs **não são descartadas** — ficam no sidecar com `orfa_desde` e voltam
sozinhas se o trecho reaparecer. Nunca edite o JSON à mão para "limpar" órfãs
sem o usuário pedir: é material de estudo dele.

## Limites honestos, que valem dizer quando vierem à tona

- **Traço cortado por quebra de página nova** não tem como ficar inteiro. É
  reancorado pela linha de origem e pode ficar truncado.
- **Mexer no `scripts/mdpdf/estilo.css`** em qualquer coisa que altere métrica de texto
  (tamanho de fonte, entrelinha, margem) reflui o documento inteiro e obriga
  todas as marcações a serem reancoradas. Mudar só cor não reflui nada.
- **Grifo em trecho muito curto e repetido** ("OLAP", "3FN") pode reancorar na
  ocorrência errada. O desempate usa as palavras em volta e a página de origem,
  mas não é infalível.

## Custo

~0,9s por documento, mais ~0,6s para subir o Edge uma vez por lote. O
repositório inteiro sai em ~14s. Não há por que evitar regerar.
