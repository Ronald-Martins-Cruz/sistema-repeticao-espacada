# DPE-RO 2025 × DATAPREV 2024 — comparação de ementas

Compara a ementa de **Analista Programador – Classe B** (DPE-RO, Edital nº
01/2025, FGV) — [EMENTA.md](EMENTA.md) — com a ementa-alvo de estudo,
**Analista de TI / Perfil 3: Desenvolvimento de Software** (DATAPREV, Edital nº
01/2024, FGV) — [dataprev-2024/EMENTA.md](../../../../provas-editais-alvo/dataprev/dataprev-2024/EMENTA.md).

> A comparação é contra a ementa de **2024**, que é a base de estudo. O alvo
> real é o edital de 2026; o que mudou está em
> [DIFF-EDITAIS-2024-2026.md](../../../../provas-editais-alvo/dataprev/DIFF-EDITAIS-2024-2026.md).

## Régua de similaridade

| Nível | Nome | O que significa | Valor |
|:--:|---|---|---|
| 🟩 **N4** | **Idêntico** | Mesmo tópico, mesma redação (ou mesmo rol fechado). A questão funciona como se fosse da sua prova. | Máximo |
| 🟦 **N3** | **Equivalente** | Mesmo conteúdo, redação ou recorte diferente. Aproveitamento quase total. | Alto |
| 🟨 **N2** | **Parcial / adjacente** | Interseção real mas incompleta: um pedaço do seu tópico, ou a mesma ideia em outra tecnologia/versão. Aproveita o conceito, não o detalhe. | Médio |
| 🟧 **N1** | **Tangencial** | Encosta na sua ementa só de longe — pré-requisito, contexto ou vizinho conceitual. | Baixo |
| ⬜ **N0** | **Sem relação** | Não cai na sua prova. Ignorar. | Nenhum |

## Resumo

**Esta é, de longe, a prova mais próxima do acervo — e por um motivo estrutural:
o bloco de Conhecimentos Específicos do DPE-RO é o bloco `DESENVOLVIMENTO DE
SISTEMAS` da DATAPREV 2024 reaproveitado quase palavra por palavra.**

A FGV recortou o mesmo texto, retirou o item 2 (análise estática / SonarQube),
trocou a pilha de linguagens do item 1 (Java → Python/PHP) e renumerou tudo com
um deslocamento de 1. Do item 2 em diante, os 18 itens do DPE-RO são os itens 3
a 20 da DATAPREV, na mesma ordem e com a mesma redação:

| DATAPREV 2024 | DPE-RO 2025 | Correspondência |
|---|---|---|
| DS-1 Java, JavaEE, JPA, JS, JUnit, Hibernate, JSF, Primefaces, Spring… + mobile + low-code | 1 Python, PHP, JS, Django, Laravel, React + mobile | pilha trocada |
| DS-2 Análise estática (clean code, SonarQube) | — | **removido no DPE-RO** |
| DS-3 a DS-20 | 2 a 19 | **texto idêntico, renumerado** |

Contrapartida: o DPE-RO **só** tem esse bloco. Não há Banco de Dados, Business
Intelligence, Segurança da Informação nem Gestão/Governança de TI — quatro dos
cinco blocos da sua ementa ficam de fora.

| | |
|---|---|
| Questões específicas | 30 (de 70) |
| Cobertura do bloco `Desenvolvimento de Sistemas` da DATAPREV | ~95% (19 de 20 itens, quase todos em N4) |
| Cobertura da ementa técnica da DATAPREV como um todo | ~35% |
| Aproveitamento estimado das 30 específicas | **~85–90% em N3 ou acima** |
| Posição no acervo | **1º em densidade** (maior taxa de acerto por questão) |

---

## 🟩 N4 — Idêntico

Todos os pares abaixo são **texto literal repetido** entre os dois editais.

| Tópico no DPE-RO 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 2 Arquitetura de software. Interoperabilidade de sistemas. Arquitetura e linguagem orientada a serviços. Web services. API. Swagger. Arquitetura e linguagem orientada a objetos. Arquitetura de aplicações para ambiente web. Servidor de aplicações. Servidor web. | DS-3 | frase inteira igual |
| 3 Ambientes Internet, extranet, intranet e portal: finalidades, características físicas e lógicas, aplicações e serviços | DS-4 | igual |
| 4 Padrões XML, XSLT, UDDI, REST e JSON | DS-5 | igual |
| 5 DevOps | DS-6 | igual |
| 6 Ferramenta de Gestão da configuração GIT | DS-7 | igual |
| 6 TESTES: conceitos básicos, unitários, integração, ágeis, usabilidade, automatizados, tipos de testes, TDD, gestão do ciclo de vida de testes | DS-7 (bloco TESTES) | igual, inclusive o encaixe estranho dentro do item do Git |
| 6 RPA (robotic process automation) | DS-7.3 | igual |
| 7 Metodologias Ágeis: 7.1 Scrum, 7.2 Kanban, 7.3 XP | DS-8, 8.1–8.3 | igual |
| 8 Padrões de desenvolvimento e reuso | DS-9 | igual |
| 9 Codificação de software (transacionais, analíticos, mobile e API) | DS-10 | igual |
| 10 Metodologia de Ponto de Função e Story Points | DS-11 | igual |
| 11 Engenharia de Requisitos: 11.1 Classificação, 11.2 Processo, 11.3 Técnicas de Elicitação | DS-12, 12.1–12.3 | igual |
| 12 Frontend web: HTML, CSS, UX, Ajax, frameworks (VueJS, Angular e React); 12.1 Padrões de frontend; 12.2 SPA e PWA | DS-13, 13.1–13.2 | igual |
| 13 Protocolos HTTPS, SSL/TLS | DS-14 | igual |
| 14 Blockchain | DS-15 | igual |
| 15 Design de software | DS-16 | igual |
| 16 Arquitetura hexagonal, microsserviços (orquestração de serviços e API gateway) e containers | DS-17 | igual |
| 17 Transações distribuídas | DS-18 | igual |
| 18 User Experience (UX); 18.1 Sistemas de gestão de conteúdo, arquitetura de informação, portais corporativos, workflow, acessibilidade e usabilidade, desenho e planejamento de interação em aplicações web | DS-19, 19.1.1–19.1.7 | igual, inclusive a duplicação de "Conceitos básicos e aplicações" |
| 19 Conceitos de Inteligência Artificial, Análise de Dados e Big Data | DS-20 | igual |
| 1 Desenvolvimento para dispositivos móveis (Android e iOs) | DS-1 (final) | igual, com a mesma grafia `iOs` do original |

---

## 🟦 N3 — Equivalente

| Tópico no DPE-RO 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 1 Desenvolvimento de sistemas | DS-1 (abertura) | mesma abertura genérica |
| Língua Portuguesa (15 questões) | Módulo I — Língua Portuguesa | mesmo texto-base da FGV, condensado (14 itens no DPE-RO, 26 na DATAPREV); o conteúdo é o mesmo |
| Legislação Institucional, item 5: Lei nº 13.709/2018 (LGPD) | Módulo I — Legislação, item 4 | a DATAPREV recorta capítulos (I, II, III, IV, VII, VIII e IX); o DPE-RO cobra a lei inteira |

---

## 🟨 N2 — Parcial / adjacente

| Tópico no DPE-RO 2025 | Item na DATAPREV 2024 | Por que só parcial |
|---|---|---|
| 1 Python 3.9+, PHP 7+ | DS-1 (Java, JavaEE, JakartaEE) | mesma posição na ementa, pilha diferente. Sintaxe e API não transferem; OO, exceções, coleções, escopo e paradigma transferem |
| 1 Frameworks Django 4+, Laravel 9+ | DS-1 (Spring, SpringBoot, Hibernate, JSF) | mesmo papel (framework MVC/ORM de backend). ORM, injeção de dependência, roteamento e ciclo de request transferem; anotação e configuração não |
| 1 Javascript (ECMAScript 2021+) | DS-1 (Javascript) | linguagem igual; o DPE-RO fixa versão |
| 1 React 18+ | DS-13 (frameworks VueJS, Angular e React) | React está nos dois; o DPE-RO o move para o item de linguagens e fixa versão |

---

## 🟧 N1 — Tangencial

| Tópico no DPE-RO 2025 | Observação |
|---|---|
| Noções de Direito — Improbidade, Licitações (Lei 14.133/2021), Responsabilidade civil do Estado | Sem correspondência técnica. Só aparece aqui porque a DATAPREV também cobra legislação — mas de outra natureza (segurança da informação e proteção de dados) |

---

## ⬜ N0 — Sem relação

- Legislação Institucional (Constituição de Rondônia; LC nº 117/1994; LC nº 703/2013; LC nº 68/1992)
- Noções de Direito Constitucional, Administrativo e Penal
- História, Geografia e Atualidades de Rondônia (10 questões)

---

## O que esta prova **não** cobre da sua ementa

Quatro dos cinco blocos técnicos da DATAPREV 2024 não têm equivalente algum no
DPE-RO. Se usar esta prova, use-a sabendo que ela **treina um quinto do seu
edital com precisão cirúrgica e ignora o resto**.

| Bloco da DATAPREV 2024 | Situação no DPE-RO |
|---|---|
| `DESENVOLVIMENTO DE SISTEMAS` (20 itens) | **19 de 20 cobertos** — falta só o item 2 |
| `BANCO DE DADOS` (17 itens) | **ausente por inteiro** — nem SQL, nem modelagem, nem NoSQL |
| `INTELIGÊNCIA DE NEGÓCIOS (BI)` (7 itens) | **ausente por inteiro** — nem DW, nem OLAP, nem ETL |
| `SEGURANÇA DA INFORMAÇÃO` (7 itens) | **ausente por inteiro** — nem ISO 27001/27002, nem OWASP, nem OAuth2/SSO, nem SAST/DAST |
| `GESTÃO E GOVERNANÇA DE TI` (6 itens) | **ausente por inteiro** — nem ITIL v4, nem COBIT 2019, nem PMBOK, nem BPMN |

Itens pontuais também ausentes:

- **DS-2** Análise estática de código-fonte (clean code e SonarQube) — o único item do bloco de desenvolvimento que a FGV cortou ao reaproveitar o texto
- Toda a pilha **Java** (JavaEE, JakartaEE, JPA, JSF, Primefaces, Spring, SpringCloud, SpringBoot, Hibernate, JUnit)
- Desenvolvimento em ferramentas **low-code e no-code**
- Módulo I: **Língua Inglesa**, **Raciocínio Lógico**, **Atualidades**
- Legislação: **LAI (12.527)**, **Decretos 7.724 e 7.845**, **Delitos Informáticos (12.737)**, **Marco Civil (12.965)**

---

## Veredito

**Use esta prova primeiro, e use as 30 questões inteiras.** Nenhuma outra do
acervo tem essa relação com a sua ementa: 19 itens em correspondência literal
significa que o estilo de enunciado, o recorte de profundidade e o que a banca
considera "cobrável" dentro de cada item são diretamente observáveis aqui.

Duas ressalvas:

1. **As questões do item 1 (linguagens) não servem** — Python, PHP, Django e
   Laravel não estão na sua ementa. Separe-as antes de simular.
2. **Cobertura não é suficiência.** Acertar 30/30 aqui indica domínio de um bloco
   que vale 20 dos ~57 itens técnicos do seu edital. Para os outros quatro
   blocos a referência é outra: MPU 2025 para governança, BI e dados; TJ-RR 2024
   para BI, BPM e portais.
