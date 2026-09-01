# ALEP 2024 × DATAPREV 2024 — comparação de ementas

Compara a ementa de **Analista Legislativo – Desenvolvedor de Sistemas** (ALEP,
Edital nº 02/2024, FGV) — [EMENTA.md](EMENTA.md) — com a ementa-alvo de estudo,
**Analista de TI / Perfil 3: Desenvolvimento de Software** (DATAPREV, Edital nº
01/2024, FGV) —
[dataprev-2024/EMENTA.md](../../../../provas-editais-alvo/dataprev/dataprev-2024/EMENTA.md).

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

**É a prova mais acadêmica do acervo — e a única com um bloco de banco de dados
de verdade.**

A ementa da ALEP é escrita como sumário de livro-texto: o item 4 (Sistemas de
Bancos de Dados) tem treze subitens e vai de arquitetura de SGBD e independência
de dados até processamento de transações, controle de concorrência, otimização
de consultas e bancos distribuídos. Nenhuma outra prova selecionada trata banco
de dados com essa profundidade, e boa parte disso **é mais fundo do que a sua
ementa pede** — mas é exatamente o fundamento de BD-11 (propriedades de banco de
dados) e de DS-18 (transações distribuídas), dois itens que quase ninguém mais
cobre.

O núcleo Java também casa bem: JSF, Spring (Boot, Core, MVC), JUnit, JPA,
Servlets/JSP, React, HTML5/CSS/JavaScript, REST, JSON — quase todos com os
mesmos nomes do seu edital.

O que falta é a metade "moderna" e a metade "corporativa" do seu edital. **Não
há DevOps, containers, microsserviços, arquitetura hexagonal, Git nomeado,
CI/CD, Swagger, XML/XSLT/UDDI, mobile, IA, blockchain, RPA nem UX/CMS.** E não
há **governança de TI nenhuma** — nem ITIL, nem COBIT, nem PMBOK, nem BPMN.

| | |
|---|---|
| Questões específicas | 40 (de 70) |
| Blocos da DATAPREV alcançados | 4 de 5 (**sem governança**) |
| Cobertura da ementa técnica da DATAPREV | ~50% |
| Aproveitamento estimado das 40 específicas | **~55–60% em N3 ou acima** |
| Posição no acervo | **1º em fundamentos de banco de dados e transações** |

---

## 🟩 N4 — Idêntico

### Engenharia de software

| Tópico na ALEP 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 1.1.3 Metodologias ágeis: **Scrum, XP, Kanbam** | DS-8 (8.1 Scrum, 8.2 Kanban, 8.3 XP) | **rol fechado idêntico** (`Kanbam` é a grafia do edital da ALEP) |
| 1.1.3 **TDD** | DS-7 (Test-driven development) | **literal** |
| 1.3 **Análise de pontos de função (APF)** | DS-11 (Metodologia de Ponto de Função) | **literal** |
| 1.4 **Arquiteturas de software. Padrões arquiteturais** | DS-3 (arquitetura de software) + DS-17 | igual |
| 1.5 **Testes de software** | DS-7 (bloco TESTES) | igual |
| 1.7 **Gerência de configuração de software** | DS-7 (Ferramenta de Gestão da configuração GIT) | mesmo conceito; a ALEP não nomeia o Git |
| 2.2.4 **Testes unitários (JUnit)** | DS-7 (testes unitários) + DS-1 (JUnit) | **literal**, e repetido em 2.3.5 |

### Pilha Java e frontend

| Tópico na ALEP 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 2.1.1 Linguagens: **Java** (JDK 17) e **Javascript** | DS-1 (Java versão 6 ou superior, Javascript) | mesma dupla, versão mais nova |
| 2.1.2 Arquitetura e padrões de projeto **JEE v8** | DS-1 (JavaEE versão 6 ou superior, JakartaEE) | igual |
| 2.2.2 **JSF 2.0** | DS-1 (JSF) | **literal** |
| 2.2.3 **Spring (Boot, Core, MVC)** | DS-1 (Spring, SpringBoot) | **literal** |
| 2.3.1 **HTML5 (HTML, CSS, JavaScript)** | DS-13 (HTML, CSS) | igual |
| 2.3.3 **React.JS** | DS-13 (frameworks VueJS, Angular e React) | **literal** |
| 2.4.1 **Rest API** | DS-5 (REST) + DS-3 (API) | **literal** |
| 2.5.1 **JSON** | DS-5 (JSON) | **literal** |
| 2.6.1 **JPA** | DS-1 (JPA versão 2 ou superior) | **literal** |

### Banco de dados e suporte à decisão

| Tópico na ALEP 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 4.4.3 **Modelo relacional** | BD-2 (abordagem relacional) | igual |
| 4.5.1 Modelagem conceitual usando **MER**, EER e modelo de classes da UML | BD-1 (modelagem conceitual) | igual |
| 4.5.2 **Projeto lógico** de bancos de dados relacionais; 4.5.3 **Projeto físico** | BD-1 (modelagem lógica e física) | **rol literal**: conceitual, lógica e física |
| 4.6 **Linguagem de consulta SQL:2003 (padrão ANSI)** | BD-7 (linguagem de consulta estruturada – SQL) | igual, com o padrão fixado |
| 4.8.1 **Propriedades ACID** | BD-11 (propriedades de banco de dados) | **literal** |
| 4.11 **Bancos de Dados NoSQL**; 4.11.2 modelos de dados NoSQL | BD-12 (banco de dados NoSQL) | igual |
| 5.1.1 **Extração, Transformação e Carga (ETL)**; 5.1.2 **Extração, Carga e Transformação (ELT)** | BD-17 (ETL/ELT) + BI-3 (ETL) | **literal**, com as siglas abertas |
| 5.3 **Modelagem multidimensional** | BD-6 (modelagem dimensional) + BD-2 (abordagem multidimensional) | **literal** |
| 5.4 **Data warehousing e Sistemas OLAP** | BI-3 (data warehouse com ETL e OLAP) + BI-4 | **literal** |
| 5.5 **Data lakes** e Data Lake Houses | BD-14 (data lakes e soluções para big data) | **literal** |
| 4.13.3 Processamento de transações, controle de concorrência e recuperação de falhas em bancos **distribuídos** | DS-18 (transações distribuídas) | **um dos poucos pares do acervo para DS-18** |

---

## 🟦 N3 — Equivalente

| Tópico na ALEP 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 1.1.1 Ciclo de vida do software; 1.1.2 Metodologia de desenvolvimento de softwares | DS-1 (desenvolvimento de sistemas) | abertura equivalente |
| 1.2 **Engenharia de requisitos: tipos de requisitos, levantamento**, modelagem e construção | DS-12.1 (classificação de requisitos) + DS-12.3 (elicitação) | mesmo conteúdo; "modelagem e construção" é extra |
| 1.4 **Padrões de projeto GoF** | DS-9 (padrões de desenvolvimento e reuso) | mesma matéria; a DATAPREV não nomeia o catálogo |
| 2.1.3 **Práticas de programação segura e revisão de código**; 2.1.4 Segurança no desenvolvimento | SEG-6 (SDL – Security Development Lifecycle) | mesmo território de desenvolvimento seguro |
| 2.1.5 Controles e testes de segurança para **aplicações web**; 2.1.6 para **Web Services** | SEG-6 (OWASP Top 10) + SEG-7 (SAST/DAST) | mesmo conteúdo; a ALEP não nomeia OWASP nem SAST/DAST |
| 2.1.7 **Páginas Web responsivas** | DS-13 + DS-13.1 (padrões de frontend) | responsividade é padrão de frontend |
| 2.1.8 **Soluções de integração entre sistemas** | DS-3 (interoperabilidade de sistemas) | igual em substância |
| 2.2.1 **Servlets e JSP** | DS-1 (JavaEE, JakartaEE) | a base do JavaEE web que sua ementa cobra |
| 4.1 Conceitos e arquitetura; 4.2 Arquitetura de **SGBDs** | BD-10 (SGBD) | mesmo conceito, com o detalhe arquitetural |
| 4.5.2.1 **Mapeamento Objeto-Relacional (ORM)** | DS-1 (JPA, Hibernate) | é o que JPA e Hibernate fazem |
| 4.12 Soluções para **gerência de dados em larga escala** | BD-14 (soluções para big data) | igual em substância |
| 5.2 Tratamento e **qualidade de dados** | BI-6 (mapeamento das fontes de dados) + BD-17 | etapa do ETL que a sua ementa pede por outro ângulo |
| 1.6 Manutenção de software | DS-1 + DS-16 | fase do ciclo que a sua ementa pressupõe |
| Língua Portuguesa (9 questões) | Módulo I — Língua Portuguesa | mesmo texto-base da FGV, condensado em 14 itens |
| Raciocínio Lógico Matemático (9 questões) | Módulo I — Raciocínio Lógico | **quase o mesmo texto, item a item** — a única diferença é que a DATAPREV acrescenta "relações métricas no triângulo retângulo" à geometria |

---

## 🟨 N2 — Parcial / adjacente

| Tópico na ALEP 2024 | Item da DATAPREV que encosta | Por que só parcial |
|---|---|---|
| 3.1 **UML**: mecanismos gerais, casos de uso, classes de análise e projeto, interações, atividades, estados | DS-3 (linguagem orientada a objetos) + DS-16 (design de software) | **a DATAPREV 2024 não lista UML** — a ALEP é a prova que mais cobra UML no acervo (seis subitens), e nada disso é item seu |
| 2.3.2 **jQuery**; 2.3.4 **Bootstrap** | DS-13 (frameworks VueJS, Angular e React) | mesma família de frontend, ferramentas fora do seu rol |
| 2.6.2 **QueryDSL** | DS-1 (JPA) | biblioteca de consulta sobre JPA, não cobrada |
| 2.7.1 **NPM**; 2.7.2 **Maven** — gerência de dependências e automação de build | DS-6 (DevOps) | toolchain de build; a sua ementa cobra DevOps em conceito, sem nomear ferramenta |
| 4.3 Independência de dados; 4.4.1 modelo hierárquico; 4.4.2 modelo em rede; 4.4.4 modelo relacional estendido | BD-2 (abordagem relacional) | fundamentos e modelos legados; só o relacional é seu |
| 4.4.3.1 **Álgebra Relacional** | BD-7 (SQL) | fundamento teórico do SQL, não cobrado |
| 4.5.3.1 Estruturas de arquivos e indexação. Hashing; 4.5.3.2 Projeto de índices | BD-1 (modelagem física) | é o conteúdo da modelagem física, mas a sua ementa não desce a esse nível |
| 4.7 Processamento e **otimização de consultas** em SGBDs relacionais | BD-7 + BD-10 | interno do SGBD, um nível abaixo do que sua ementa pede |
| 4.8.2 Serialização de escalas; 4.9 **Controle de concorrência e recuperação de falhas** | BD-11 (propriedades de banco de dados) + DS-18 | o mecanismo por trás do ACID; a sua ementa cobra as propriedades, não os algoritmos |
| 4.10 **Segurança em SGBDs relacionais** | SEG-4.1 (controle de acesso) | controle de acesso no recorte do banco |
| 4.11.1 **Teorema CAP**; 4.11.3 NoSQL e **NewSQL** | BD-12 (NoSQL) | fundamento clássico do NoSQL, não nomeado na sua ementa |
| 4.13 Sistemas de Bancos de Dados **Distribuídos**: conceitos, arquitetura, distribuição de dados e processamento | DS-18 (transações distribuídas) | só o subitem 4.13.3 casa direto (ver N4); o resto é contexto |
| 5.5 **Data Lake Houses** | BD-14 (data lakes) | evolução do data lake, não cobrada |
| 6 Programação com o uso das linguagens **C, R e Python** | DS-1 (Java, Javascript) | linguagens fora do seu rol; transferem paradigma, não sintaxe |

---

## 🟧 N1 — Tangencial

| Tópico na ALEP 2024 | Observação |
|---|---|
| Constituição do Estado do Paraná — Administração Pública, orçamento e finanças, meio ambiente | Sem correspondência técnica; entra aqui só porque a sua ementa também tem um bloco de legislação — mas de outra natureza (segurança da informação e proteção de dados) |

---

## ⬜ N0 — Sem relação

- **Regimento Interno da Assembleia Legislativa do Paraná** (4 questões)
- **Constituição do Estado do Paraná** (4 questões)
- **História e Geografia do Paraná** (4 questões) — tropeirismo, ciclo da madeira, Revolução Federalista, Serra do Mar, bacias hidrográficas
- A **prova discursiva** (redação dissertativo-argumentativa de até 30 linhas) — a DATAPREV 2024 **não tem discursiva**

---

## O que esta prova **não** cobre da sua ementa

**Governança e gestão — o bloco inteiro:**
- **Gerenciamento de projetos, áreas de conhecimento, portfólio, abordagens tradicional/híbrida/ágil, Guia Scrum** (GOV-1, GOV-2), **gestão de riscos** (GOV-3), **ITIL v4** (GOV-4), **COBIT 2019** (GOV-5), **BPMN e gestão de processos de negócio** (GOV-6) — **nada disso está na ALEP**

**Desenvolvimento moderno:**
- **DevOps** (DS-6) — ausente
- **Git nomeado, CI/CD** (DS-7) — ausentes (só "gerência de configuração")
- **Microsserviços, arquitetura hexagonal, containers, API gateway** (DS-17) — ausentes
- **Swagger** (DS-3), **servidor de aplicações e servidor web** (DS-3) — ausentes
- **Padrões XML, XSLT, UDDI** (DS-5) — ausentes (só REST e JSON)
- **Análise estática de código-fonte: clean code e SonarQube** (DS-2) — ausente
- **Ferramentas low-code e no-code** — ausentes
- **Desenvolvimento para dispositivos móveis (Android e iOS)** — ausente
- **Ambientes Internet, extranet, intranet e portal** (DS-4) — ausente
- **RPA** (DS-7.3), **story points** (DS-11), **blockchain** (DS-15), **HTTPS/SSL/TLS** (DS-14) — ausentes
- **Codificação de software (transacionais, analíticos, mobile e API)** (DS-10) — ausente
- **Ajax, Vue, Angular, SPA e PWA, padrões de frontend** (DS-13.1, 13.2) — ausentes
- **IA, análise de dados e Big Data** (DS-20) — ausentes

**Experiência do usuário e conteúdo — o bloco inteiro (DS-19):**
- **UX, sistemas de gestão de conteúdo, arquitetura de informação, portais corporativos, workflow, acessibilidade e usabilidade, desenho e planejamento de interação** — ausentes

**Segurança da informação — a parte normativa:**
- **Políticas de segurança da informação** (SEG-1), **procedimentos e gerenciamento** (SEG-2), **ISO 27001:2022 e 27002:2022** (SEG-3), **confiabilidade/integridade/disponibilidade** (SEG-3), **controle de acesso, OAuth2, SSO** (SEG-4.1), **gerência de riscos: ameaça, vulnerabilidade e impacto** (SEG-5), **OWASP Top 10** (SEG-6), **SAST e DAST** (SEG-7) — todos ausentes por nome

**Banco de dados e BI, itens pontuais:**
- **Normalização** (BD-3) — ausente como item explícito, apesar do bloco de BD ser o mais fundo do acervo
- **Integridade referencial** (BD-4), **metadados** (BD-5), **banco de dados em memória** (BD-13), **dados estruturados e não estruturados** (BD-15), **avaliação de modelos de dados** (BD-16) — ausentes
- **Data mining** (BI-4), **visualização de dados: BD individuais e cubos** (BI-5), **mapeamento das fontes de dados** (BI-6), **arquitetura de business intelligence** (BI-7), **sistemas de suporte a decisão e gestão de conteúdo** (BI-2) — ausentes

**Módulo I:**
- **Língua Inglesa** e **Atualidades** — ausentes
- Legislação inteira: **LAI**, **Decretos 7.724/7.845**, **Delitos Informáticos**, **Marco Civil**, **LGPD** — ausentes

---

## Veredito

**Use esta prova para fundamento — o que ela ensina, ela ensina fundo.** É a
prova do acervo que mais se parece com um curso: banco de dados tratado como
disciplina, com transações, concorrência, recuperação de falhas e bancos
distribuídos, e um bloco de suporte à decisão que cobre ETL/ELT, modelagem
multidimensional, DW, OLAP e data lakes com a mesma redação da sua ementa.

Vá atrás especificamente das questões de:

1. **Transações, ACID, controle de concorrência e bancos distribuídos** — é o
   melhor material do acervo para BD-11 e o par mais direto para **DS-18
   (transações distribuídas)**, item que quase nenhuma outra prova cobre.
2. **ETL/ELT, modelagem multidimensional, data warehousing, OLAP, data lakes** —
   cobre BD-6, BD-14, BD-17 e boa parte do seu bloco de BI.
3. **Projeto de banco de dados conceitual, lógico e físico + MER** — BD-1 com o
   rol literal.
4. **JSF, Spring (Boot, Core, MVC), JPA, JUnit, Servlets/JSP** — junto com o
   TJ-AP, é a melhor fonte para DS-1; e é a **única prova selecionada que cobra
   JSF**, item do seu edital.
5. **Scrum/XP/Kanban, TDD, APF, testes, padrões GoF** — DS-7, DS-8, DS-9, DS-11.
6. **Raciocínio Lógico** — as 9 questões são praticamente da sua ementa.

Ressalvas ao simular:

1. **Ela é mais funda do que a sua prova.** Otimização de consultas, serialização
   de escalas, hashing e álgebra relacional não caem na DATAPREV. Errar essas
   não é sinal de nada — mas acertá-las é lucro, porque blinda o fundamento.
2. **A ALEP cobra UML pesado, você não.** Seis subitens de diagrama; nenhum item
   correspondente no seu edital de 2024.
3. **Ela não te testa em nada de operação moderna.** Sem DevOps, containers,
   microsserviços, CI/CD, cloud ou UX, um bom resultado aqui não diz nada sobre
   metade do seu bloco de desenvolvimento.
4. **Descarte de saída** Regimento da ALEP, Constituição do Paraná e
   História/Geografia do Paraná — 12 das 30 questões de Conhecimentos Gerais.
