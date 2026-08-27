# Diff dos editais TRANSPETRO — 2023 × 2026 (Análise de Sistemas – Processos de Negócios)

Comparação do `transpetro-superior-2023.pdf` (Edital nº 02 –
TRANSPETRO/PSP/TERRA/NÍVELSUPERIOR-2023.2, 53 páginas) com o
`transpetro-superior-2026.pdf` (Edital nº 04 – TRANSPETRO/PSP/TERRA/NÍVEL
SUPERIOR – 2026.4, 83 páginas), pelo recorte da ênfase **Análise de Sistemas –
Processos de Negócios**. Banca é a **Fundação Cesgranrio** nos dois.

Método: extração do texto integral com PyMuPDF, recorte do Anexo IV (Conteúdos
Programáticos) e do bloco da ênfase em cada PDF, normalização de espaços e
quebras de página, e diff palavra-a-palavra (`difflib.SequenceMatcher`) sobre os
tokens.

## Resumo

**O conteúdo programático da ênfase é praticamente o mesmo.** O diff acusou
4 blocos de diferença em 716/731 palavras (`ratio` 0,984) e só **dois** são
mudança de conteúdo: **PMBOK 6ª → 7ª edição** e a **LGPD, que passou a vir com
lei e artigo explícitos**. Os outros dois são o plural do título e um ponto na
numeração. Nenhum tópico entrou; nenhum saiu.

**O que mudou de verdade foi a mecânica do certame.** Em 2023, Conhecimentos
Básicos era só eliminatório e a classificação saía apenas de Conhecimentos
Específicos. Em 2026, as duas fases são classificatórias e a nota final é a
**soma algébrica** das duas — Português e Inglês passaram a valer ponto.

E o mercado apertou: a ênfase caiu de **2 vagas + 14 de cadastro de reserva**
para **1 vaga (reservada a PcD) + 10 de cadastro de reserva**.

---

# 1. Conteúdo programático da ênfase

## 1.1 Tópicos só em 2023

**Nenhum.**

## 1.2 Tópicos só em 2026

**Nenhum tópico novo.** As duas únicas alterações de conteúdo são atualizações
de referência dentro de itens que já existiam:

| Item | 2023 | 2026 |
|---|---|---|
| 2.4 (Gerenciamento de Projetos e Produtos) | `PMBOK 6ª edição` | **`PMBOK 7ª edição`** |
| 4.6 (Gestão e governança em TI) | `Lei Geral de Proteção de Dados.` | `Lei Geral de Proteção de Dados Pessoais - LGPD` **`(Lei nº 13.709, de 14 de agosto de 2018, e suas alterações)`** |

A troca do PMBOK é a que muda estudo de verdade: da 6ª para a 7ª edição o guia
abandona a organização por **grupos de processos e áreas de conhecimento** e
adota **12 princípios e 8 domínios de desempenho**. Note que o **item 3
continua sendo "Processos, grupos de processos e área de conhecimento"**, que é
vocabulário da 6ª — o edital cobra a 7ª edição no item 2.4 e o léxico da 6ª no
item 3, sem harmonizar os dois.

A explicitação da LGPD não amplia escopo formalmente, mas fecha a brecha de
interpretação: agora é a Lei nº 13.709/2018 nomeada, "e suas alterações".

## 1.3 Diferenças cosméticas (as outras duas do diff)

| Diferença | 2023 | 2026 |
|---|---|---|
| Título da ênfase | `PROCESSOS DE NEGÓCIO` (singular) | `PROCESSOS DE NEGÓCIOS` (plural) |
| Numeração do item 8 | `8 Lógica Matemática` | `8. Lógica Matemática` |

## 1.4 O que continua ausente nos dois

Nenhum dos dois editais cita **BPMN, BPM, cadeia de valor, notação de processos
ou modelagem de processos de negócio** no bloco desta ênfase, apesar do nome. Em
cada edital a string `BPMN` aparece **uma única vez no documento inteiro**, e
sempre na ênfase de **SAP** — a 7 em 2023, a 6 em 2026. "Processos", aqui, é o
item 3 — vocabulário de PMBOK.

## 1.5 Conhecimentos Básicos

**Idênticos palavra por palavra.** Língua Portuguesa (12 itens) e Língua Inglesa
(2 itens) não mudaram; o diff só acusa a troca do separador de numeração
(`1-` → `1.`).

---

# 2. Numeração da ênfase — atenção ao procurar prova antiga

Em **2023 o edital se contradizia**: o Anexo I (quadro de vagas) listava
`ÊNFASE 5: ANÁLISE DE SISTEMAS - SEGURANÇA CIBERNÉTICA E DA INFORMAÇÃO` e
`ÊNFASE 6: ANÁLISE DE SISTEMAS - PROCESSOS DE NEGÓCIOS`, enquanto os Anexos III
e IV invertiam os dois — lá, `1.5 - ÊNFASE 5` era Processos de Negócio e a 6 era
Segurança Cibernética.

**Quem valeu foi o Anexo I:** o caderno aplicado em 10/12/2023 saiu rotulado
como **"Ênfase 6: Processos de Negócios"**. É por esse nome que a prova de 2023
está catalogada nos bancos de questões — procurar por "ênfase 5" leva à prova de
Segurança Cibernética, que é outro conteúdo.

Em **2026 não há ambiguidade**: Processos de Negócios é a **Ênfase 5** nos
Anexos I, III e IV.

Mudou também o vizinho de numeração: em 2023 a ênfase 7 era `SAP - FINANÇAS E
CONTABILIDADE`; em 2026 a 6 é só `SAP`, e a **Ênfase 8 – Ciência de Dados** é
nova. O edital passou de 28 para 33 ênfases.

---

# 3. Estrutura e mecânica da prova

Igual nos dois: **70 questões objetivas** (20 de Conhecimentos Básicos/Gerais +
50 de Conhecimentos Específicos), 5 alternativas, 1 ponto cada, **4h30** de
duração, caderno único.

O que mudou é como esses 70 pontos viram classificação:

| | 2023 | 2026 |
|---|---|---|
| Nome das fases | Conhecimentos Básicos / Conhecimentos Específicos, em "Etapa Única" | Fase 1 (Conhecimentos Específicos) e Fase 2 (Conhecimentos Gerais), na 1ª Etapa |
| Caráter dos Básicos/Gerais | eliminatório e, **apenas para desempate**, classificatório | **eliminatório e classificatório** |
| Nota que classifica | **só** Conhecimentos Específicos (subitem 7.1.1.1) | **soma algébrica** Fase 1 + Fase 2 (subitem 7.1.4.1) |
| Corte de habilitação | classificados conforme limites do Anexo I | ranqueados pela Fase 1 até **2× (vagas + cadastro de reserva)** por ênfase/polo/modalidade (subitem 7.1.2 "d") |
| Equiparação de gênero | não existia | **subitem 7.1.3** — classifica mulheres e pessoas travestis, transexuais ou transgênero feminino adicionais para a Fase 2 quando o percentual delas ficar abaixo de 50% |
| Modalidades de concorrência | AC, CN (candidato negro), PCD | AC, **PCD, PN, PI, PQ** (inclui indígenas e quilombolas) |
| Etapa de verificação | heteroidentificação + avaliação multiprofissional | + verificação documental para PI e PQ (IN Conjunta MGI/MIR/MPI nº 261/2025) |

**Critério de eliminação: idêntico.** Menos de 50% nos Específicos, ou menos de
50% nos Básicos/Gerais, ou grau **zero** em qualquer das matérias de
Básicos/Gerais isoladamente (Português ou Inglês).

**Desempate:** 2023 usava idade ≥60 → maior nota em Básicos → maior nota em
Português → mais idoso → jurado. 2026 encurtou para idade ≥60 → jurado → mais
idoso; **caíram os critérios de maior nota em Básicos e em Português**, que
perderam sentido porque essas notas já entram na soma.

## 3.1 O que isso muda no estudo

Em 2023 dava para tratar Português e Inglês como pedágio: bastava não zerar e
passar dos 50%. Em 2026 cada uma das 20 questões vale exatamente o mesmo ponto
que uma de Arquitetura de Dados na classificação final — só que **depois** de
passar pelo corte da Fase 1, que ainda é decidido apenas pelos Específicos.

A leitura prática: **Conhecimentos Específicos define se você entra na lista;
Conhecimentos Gerais define a posição dentro dela.** Com 1 vaga e 10 de cadastro
de reserva, posição é tudo.

---

# 4. Vagas, remuneração e datas

## 4.1 Vagas da ênfase (polo Rio de Janeiro, o único nos dois editais)

| | 2023 (Ênfase 6) | 2026 (Ênfase 5) |
|---|:--:|:--:|
| Vagas imediatas | **2** (AC) | **1** (PCD) |
| Cadastro de reserva | 14 (9 AC, 3 CN, 2 PCD) | 10 |
| **Vagas + CR** | **16** | **11** (5 AC, 3 PCD, 3 PN) |

Em 2023 a ampla concorrência tinha 2 vagas imediatas; em 2026 a única vaga
imediata é reservada a pessoa com deficiência, e a ampla concorrência disputa
cadastro de reserva. O corte de habilitação de 2026 (2× vagas + CR, aplicado
**por modalidade**) leva adiante **22** pessoas ao todo: 10 na ampla
concorrência, 6 em PCD e 6 em PN.

## 4.2 Dinheiro e datas

| | 2023 | 2026 |
|---|---|---|
| Salário básico | R$ 7.543,07 | **R$ 8.647,34** (+14,6%) |
| Remuneração mínima garantida | R$ 12.739,70 | **R$ 14.973,62** (+17,5%) |
| Taxa de inscrição | R$ 100,00 | **R$ 117,00** |
| Inscrições | 29/09 a 30/10/2023 | 12/08 a 14/09/2026 |
| Aplicação das provas | 10/12/2023 | **29/11/2026** |
| Resultado preliminar | 25/01/2024 | 14/01/2027 |

## 4.3 Finalidade da ênfase (Anexo III)

Reescrita por inteiro, e o eixo mudou de **prospecção** para **entrega e
fiscalização**:

| | Texto |
|---|---|
| 2023 | "executar e participar da **prospecção e testes de novas tecnologias e serviços**, identificando oportunidades de Tecnologia da Informação, propondo soluções e otimizações aderentes aos processos de negócio." |
| 2026 | "atuar no **desenvolvimento, implementação e customização** de soluções de Tecnologia da Informação, assim como prestar **suporte técnico, consultorias e estudos**, visando otimizar os processos, atender as necessidades da companhia e garantir a operacionalidade dos sistemas. **Executar a fiscalização técnica e administrativa dos contratos de bens e serviços.**" |

A escolaridade exigida é a mesma lista de cursos nos dois (graduação em
Computação e Informática, Administração, Engenharia, Estatística e afins, ou
tecnólogo de 2.000h em ADS, Banco de Dados, GTI, Redes, Segurança da Informação
ou Sistemas para Internet). Muda só a redação: 2026 fala em "curso superior,
bacharelado ou licenciatura", sem o "certificado de conclusão ou diploma,
devidamente registrado" de 2023.

---

# 5. Procedência dos PDFs

- **2026:** `transpetro-superior-2026.pdf` — versão consolidada, com as
  alterações do DOU de 13/08/2026 (o próprio PDF declara isso na primeira
  linha).
- **2023:** `transpetro-superior-2023.pdf` — **edital de abertura como
  publicado**, sem retificações consolidadas. A página do PSP 2023 na Fundação
  Cesgranrio já não serve o arquivo (o portal do certame retorna 404), então o
  PDF veio de espelho público. Confere com os dados conhecidos do certame:
  edital nº 02/2023.2, 53 páginas, prova em 10/12/2023 e a ênfase de Processos
  de Negócios numerada como 6 no Anexo I — igual ao rótulo do caderno aplicado.

Se aparecer uma retificação de 2023 que tenha mexido no Anexo IV, este diff
precisa ser refeito. Nada indica que tenha havido.

---

# 6. O que isso muda para o banco de estudo

**A prova de 2023 (Ênfase 6 – Processos de Negócios, aplicada em 10/12/2023)
calibra esta ênfase com fidelidade quase total.** Como o conteúdo programático
não perdeu nem ganhou tópico, ela testou a mesma ementa — não só o mesmo estilo
de banca. As duas ressalvas:

1. **Questões de PMBOK 6ª edição de 2023 estão desatualizadas** como gabarito.
   O que a prova de 2023 cobrou sobre grupos de processos/áreas de conhecimento
   segue válido pelo item 3, mas o item 2.4 agora pede a 7ª edição (princípios e
   domínios de desempenho). É o único ponto em que uma questão antiga pode
   induzir erro.
2. **Peso de Português e Inglês subiu.** Se o banco vier a cobrir Conhecimentos
   Gerais, a justificativa mudou: em 2026 essas 20 questões entram na nota final,
   não são mais só barreira.

Vale notar que esta é **outra banca** (Cesgranrio) e **outro formato** (50
questões objetivas de Específicos, sem módulos com peso) em relação ao alvo
DATAPREV/FGV — ver `CLAUDE.md` sobre não misturar material de bancas diferentes
sem pedido explícito.
