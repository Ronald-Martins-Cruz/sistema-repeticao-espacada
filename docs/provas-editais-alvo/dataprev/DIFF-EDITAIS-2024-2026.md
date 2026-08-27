# Diff dos editais DATAPREV — 2024 × 2026 (Perfil 3)

Comparação do `edital-dataprev-2024.pdf` (61 páginas) com o
`edital-dataprev-2026.pdf` (63 páginas), pelo recorte do **Perfil 3 —
Desenvolvimento de Software**.

Método: extração do texto integral com PyMuPDF, recorte do Anexo I e do bloco
do Perfil 3 em cada PDF, normalização de espaços e quebras de página, e diff
palavra-a-palavra (`difflib.SequenceMatcher`) sobre os tokens.

## Resumo

**O Módulo II do Perfil 3 não perdeu nenhum tópico.** O diff acusou 15 blocos
de diferença no bloco do Perfil 3 e todos são cabeçalho, renumeração ou
caractere invisível — nenhum é remoção de conteúdo. O único acréscimo real é
**Mensageria**.

As remoções de verdade estão no **Módulo I**: Língua Portuguesa caiu de 26 para
6 itens e Raciocínio Lógico de 14 para 5, com quase toda a matemática cortada.

---

# 1. Módulo II — Perfil 3

As cinco disciplinas (Desenvolvimento de Sistemas, BI, Segurança da Informação,
Banco de Dados, Gestão e Governança de TI) têm o mesmo texto nos dois editais.

| Diferença | 2024 | 2026 |
|---|---|---|
| Cabeçalho | `CARGO: ANALISTA DE TI – PERFIL: 3.` | `PERFIL 3:` |
| Item 3 (arquitetura) | `Web services. API. Swagger.` | `Web services.` **`Mensageria.`** `API, Swagger.` |
| RPA | `7.3 RPA` | `7.1 RPA` |
| Segurança da Informação | numerava `3` duas vezes (Normas ISO **e** Confiabilidade), indo até 7 | renumerado 3–8, sem duplicata |

## 1.1 Tópicos só em 2024

**Nenhum.**

## 1.2 Tópicos só em 2026

- **Mensageria** — item 3 de Desenvolvimento de Sistemas, entre "Web services" e
  "API, Swagger". Em 2024 a palavra existia no Anexo I, mas no **Perfil 5**
  (Segurança Cibernética), item 4.4 — não no Perfil 3.

## 1.3 Anexo II (requisitos e atribuições)

Idêntico em conteúdo. Muda só a redação do requisito de escolaridade:
"Certificado de conclusão ou **diplona** de curso de graduação" (2024, com o
erro de digitação no original) → "Certificado ou diploma devidamente registrado
de conclusão de curso de graduação" (2026).

A Descrição Sumária e a Descrição Detalhada de Tarefas são iguais palavra por
palavra, incluindo "definição de padrões de desenvolvimento e reuso".

---

# 2. Módulo I — onde estão as remoções

## 2.1 Língua Portuguesa: 26 itens → 6 itens

O edital de 2024 trazia um programa de viés linguístico-literário; o de 2026
adotou o programa gramatical clássico (estilo CEBRASPE).

### Saíram sem substituto

- Organização estrutural dos textos
- **Coerência** e **intertextualidade** (coesão permaneceu, item 4)
- Modos de organização discursiva: descrição, narração, exposição, argumentação
  e injunção
- Tipos textuais nomeados: informativo, publicitário, propagandístico,
  normativo, didático e divinatório
- Textos literários e não literários
- Tipologia da frase portuguesa
- Problemas estruturais das frases
- Norma culta (como item próprio)
- Ordem direta e inversa
- Tipos de discurso
- Registros de linguagem — só sobrevive de raspão em "níveis de formalidade"
  (item 6.4)
- **Funções da linguagem**
- Elementos dos atos de comunicação
- Estrutura e formação de palavras
- Formas de abreviação
- **Modalizadores**
- Semântica: sentido próprio e figurado; antônimos, sinônimos, parônimos e
  hiperônimos — vira o genérico "Significação das palavras" (6.1)
- Polissemia e ambiguidade
- Os dicionários: tipos e organização de verbetes
- Vocabulário: neologismos, arcaísmos, estrangeirismos e latinismos

### Entraram em 2026

- Emprego de tempos e modos verbais (4.2)
- **Concordância verbal e nominal** (5.5)
- **Regência verbal e nominal** (5.6)
- **Colocação dos pronomes átonos** (5.8)
- Substituição de palavras ou trechos e reorganização de orações e períodos
  (6.2, 6.3)

### Permaneceram

Interpretação de texto, tipos e gêneros textuais, ortografia, coesão, classes
de palavras, coordenação e subordinação, pontuação, crase.

## 2.2 Raciocínio Lógico: 14 itens → 5 itens

Praticamente toda a matemática foi cortada.

### Saíram

- Conjuntos e suas operações, diagramas
- Números inteiros, racionais e reais e suas operações
- Proporcionalidade direta e inversa, **porcentagem e juros**
- Medidas de comprimento, área, volume, massa e tempo
- Compreensão de dados apresentados em gráficos e tabelas
- Problemas de contagem e noções de **probabilidade**
- **Geometria básica**: ângulos, triângulos, polígonos, distâncias, relações
  métricas no triângulo retângulo, perímetro e área
- **Noções de estatística**: média, moda, mediana e desvio padrão
- **Plano cartesiano**: sistema de coordenadas, distância
- Funções intelectuais: raciocínio verbal, matemático, sequencial, orientação
  espacial e temporal, formação de conceitos, discriminação de elementos
- Estrutura lógica de relações arbitrárias entre pessoas, lugares, objetos ou
  eventos fictícios — absorvido pelo genérico "Estruturas lógicas" (item 1)

### Entraram

- Lógica de argumentação: analogias, inferências, deduções e conclusões
- Tabelas-verdade
- **Lógica de primeira ordem**

### Permaneceram

Proposições e conectivos, equivalências, diagramas lógicos, e problemas
aritméticos, geométricos e matriciais.

## 2.3 Atualidades → "Atualidades e Inteligência Artificial"

Disciplina renomeada, com um item novo em 2026:

> 2 Inteligência Artificial: fundamentos e aplicações: conceitos de inteligência
> artificial; aprendizado da máquina; introdução aos modelos generativos e
> modelos de linguagem; ética, governança e privacidade em IA.

O item de tópicos atuais (segurança, transportes, política, economia, sociedade,
educação, saúde, cultura, tecnologia, energia, relações internacionais,
desenvolvimento sustentável e ecologia) continua idêntico.

## 2.4 Legislação de Segurança da Informação e Proteção de Dados

Igual em tudo — LAI (caps. I–V + Decretos 7.724 e 7.845), Delitos Informáticos
(art. 2º) e LGPD (caps. I, II, III, IV, VII, VIII e IX) — exceto o Marco Civil:

| | Texto |
|---|---|
| 2024 | Lei nº 12.965/2014: **capítulos II e III, Seções I e II** |
| 2026 | Lei nº 12.965/2014: **capítulos II, Seção I, e III, Seções I e II** |

O Capítulo II do Marco Civil ("Dos direitos e garantias dos usuários", arts. 7º
e 8º) **não tem seções**, então a redação de 2026 é ambígua e provavelmente é
erro de redação. Não convém estudar menos por causa dela.

---

# 3. Estrutura da prova

Igual nos dois: 70 questões, 40 no Módulo I (peso 1) e 30 no Módulo II
(peso 2,5), máximo de 115 pontos, das 13h às 17h. Mudou só o rateio interno do
Módulo I:

| Disciplina | 2024 | 2026 |
|---|:--:|:--:|
| Língua Portuguesa | 12 | 12 |
| Língua Inglesa | 12 | 12 |
| Raciocínio Lógico Matemático | 6 | **5** |
| Atualidades (e IA, em 2026) | 5 | **6** |
| Legislação de Seg. da Informação e Proteção de Dados | 5 | 5 |
| **Módulo I** | **40** | **40** |
| Conhecimentos Específicos | 30 | 30 |

---

# 4. Outras diferenças entre os PDFs

- **Anexo I encolheu.** O de 2026 vai só até o Perfil 13 (Analista de
  Processamento). Sumiram os cargos 14 a 17 de 2024: Engenheiro de Segurança do
  Trabalho, Médico do Trabalho, Auxiliar ou Técnico de Enfermagem do Trabalho e
  Técnico de Segurança do Trabalho.
- **Taxa de inscrição:** R$ 100,00 → R$ 110,00.
- **Cotas:** 2024 usava AC/PcD/PPP (3 colunas); 2026 usa AC/PCD/PP/PI/PQ
  (5 colunas — inclui indígenas e quilombolas).
- **Data da prova:** 17/11/2024 → 11/10/2026.

## 4.1 Vagas do Perfil 3

| | 2024 | 2026 |
|---|:--:|:--:|
| Vagas imediatas | 129 | **80** |
| Cadastro de reserva | 591 | 371 |
| **Total** | **720** | **451** |

Mudaram também as praças. Em 2024 havia vaga imediata em Brasília; em 2026 as
imediatas ficam só em Fortaleza, João Pessoa, Natal e Florianópolis (20 cada), e
Brasília, Rio de Janeiro e São Paulo entram apenas como cadastro de reserva
(17 cada).

---

# 5. O que isso muda para o banco de estudo

**Nada precisa ser retirado.** O `LACUNAS-EDITAL-2026.md` continua integralmente
válido: nenhum item que ele mapeou como lacuna saiu do edital, e o único
acréscimo de 2026 (Mensageria) já constava lá como descoberto (§1.3).

Duas observações que a comparação trouxe:

1. **A prova de 2024 calibra melhor do que se supunha.** Como o Módulo II do
   Perfil 3 não mudou uma linha, ela testou exatamente a mesma ementa — não só a
   mesma dificuldade. O papel que o `CLAUDE.md` dá a `docs/provas-editais-alvo/dataprev/dataprev-2024/prova-texto.md` (calibrar
   profundidade D0–D5) é conservador; ela também delimita escopo com fidelidade.

2. **X.800 não constava do edital de 2024 tampouco.** O `LACUNAS-EDITAL-2026.md`
   (§ "Por que existem lacunas") justifica a remoção da seção 2.25 por ela "não
   constar do edital de 2026", o que sugere que constava do de 2024. Não
   constava: a string `X.800` não aparece em nenhum dos dois PDFs. A FGV cobrou
   X.800 na Q64 de 2024 **fora da ementa** — isso é dado sobre o comportamento da
   banca, não sobre mudança de escopo, e serve de aviso de que uma questão em 35
   pode cair de fora do Anexo I.
