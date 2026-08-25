# Modelo do arquivo de feedback

Formato fixo de `sessoes/feedbacks/<AAAA-MM-DD>-s<id>.md`, escrito na fase E da
skill `estudo`. Existe porque o formato derivou entre sessões quando não estava
escrito em lugar nenhum.

O princípio: **o diagnóstico é texto corrido e se lê sozinho.** Quem lê nunca
precisa cruzar um número com uma linha de tabela para entender o que errou. O
`ponto_chave_id` aparece uma vez por ponto, na **última** coluna da tabela, e em
nenhum outro lugar do arquivo.

O corpo de cada pergunta vem do campo `REVELACAO` do corretor, que já sai nesta
forma — ver "A forma da `REVELACAO`" em `.claude/skills/corretor/SKILL.md`. Aqui
se acrescenta só a moldura: cabeçalho, enunciado e resposta dada.

## Esqueleto

````markdown
# Feedback — sessão <id> — <DD/MM/AAAA>

<Uma ou duas linhas de contexto: qual bloco do dia, que famílias de assunto
caíram, média do bloco. Corretor: `<modelo>` / `<esforço>` / `<isolamento>`
(régua `<12 primeiros hex do hash>`).>

> <Aviso de gabarito com `revisado = 0`, quando houver. Omita a linha se não houver.>

| Pergunta | Nota | Veredito |
|---|---|---|
| Q199 | 3 | parcial |
| Q200 | 3 | parcial |

---

## <código> · seção <n> — <título da seção>

**Enunciado.** <exatamente como está no banco>

**Resposta dada.**

> <o texto integral do usuário, em citação, sem editar nada>

**Nota <n> — <veredito>.**

<Diagnóstico em texto corrido. Um parágrafo por erro. Sem lista, sem manchete,
sem citar número de ponto.>

*Onde ler: <fontes do que faltou ou errou, sem repetir>.*

| Ponto-chave | Essencial | Status | id |
|---|---|---|---|
| <descrição> | sim | **faltou** | 300 |

**Resposta modelo.** <prosa contínua montada a partir dos pontos-chave>

---
````

Fecho do arquivo, depois da última pergunta: os `SINAL_PONTO` e `BLOQUEIO` que
os corretores tiverem devolvido, as linhas de `v_sugestao_ponto` que aparecerem,
e a tabela dos próximos agendamentos.

## Exemplo preenchido

---

## Q201 · seção 2.19 — Data Warehouse, ETL e ELT

**Enunciado.** Em que situação o ETL pode ser mais lento que o ELT? Explique
qual característica do sistema de destino determina essa comparação.

**Resposta dada.**

> A grande diferença na velocidade de um ETL e de um ELT está na capacidade de
> processamento do sistema de origem e do sistema de destino. Caso o sistema de
> destino possua uma capacidade de processamento inferior ao de origem, o ETL é
> mais rápido.

**Nota 2 — vago.**

A comparação foi posta entre a capacidade da origem e a do destino, mas no ETL a
origem apenas fornece os dados — quem transforma é um **servidor/motor de
integração intermediário**, sobre área de staging, fora tanto da origem quanto
do destino. É ele que se torna gargalo, de processamento e de transferência
(**I/O**), quando o volume é muito grande: tudo precisa sair da origem, ser
materializado e transformado nessa camada, e só então trafegar até o destino.
Era essa a situação que o enunciado pedia, e ela não aparece. Sobre o destino a
direção está certa — é a capacidade dele que decide a comparação —, mas
"capacidade de processamento superior" é genérico demais para o que se cobra:
**processamento paralelo, massivo e escalável**, isto é, arquitetura MPP,
distribuída ou data warehouse em nuvem. Ficou fora, ainda, um segundo motivo da
vantagem do ELT: ele **elimina as etapas intermediárias de cópia e serialização
em staging externo**, carregando os dados brutos direto no destino e
transformando ali.

*Onde ler: Microsoft Learn — ETL e Synapse ELT; Vassiliadis et al. (2023); FGV
DATAPREV 2024 Q67.*

| Ponto-chave | Essencial | Status | id |
|---|---|---|---|
| a situação: volume muito grande, servidor intermediário vira gargalo de processamento e I/O | sim | **faltou** | 300 |
| destino com processamento paralelo massivo e escalável (MPP / distribuído / nuvem) | sim | **parcial** | 301 |
| ELT elimina cópia e serialização em staging externo | não | **faltou** | 302 |

**Resposta modelo.** O ETL pode ser mais lento que o ELT quando o volume de
dados é muito grande e o servidor de integração intermediário, onde as
transformações ocorrem antes da carga, se torna gargalo de processamento e de
transferência (I/O) — todos os dados têm de passar por ele, ser transformados e
só depois seguir para o destino. A característica do sistema de destino que
determina essa comparação é a alta capacidade de processamento computacional
paralelo e escalável: arquiteturas MPP, distribuídas ou de data warehouse em
nuvem.

---

## O que não fazer

- **Não escreva `Ponto 300` no corpo do texto.** Nem `*Ponto 300.*`, nem
  `300 — a situação`, nem "conforme o ponto acima". O texto nomeia o conceito.
- **Não transforme o diagnóstico em lista de pontos-chave.** Um erro que
  atravessa dois pontos é um parágrafo só; a tabela é que guarda a granularidade
  ponto a ponto.
- **Não repita a mesma fonte em cada frase.** Ela vai uma vez, na linha
  `*Onde ler:*`.
- **Não abra parágrafo para ponto `citou`.** A tabela já registra o acerto.
- **Não comente redação** — estrutura, coesão, clareza, tamanho do texto — nem
  especule sobre a banca. Vale aqui a mesma proibição da régua.
- **Não abrande o que o corretor escreveu.** Reformatar é permitido; suavizar,
  não.
