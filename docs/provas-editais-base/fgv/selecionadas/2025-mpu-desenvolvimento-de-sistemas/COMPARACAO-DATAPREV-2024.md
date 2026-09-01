# MPU 2025 × DATAPREV 2024 — comparação de ementas

Compara a ementa de **A06 – Analista do MPU / Desenvolvimento de Sistemas**
(MPU, Edital nº 01/2025, FGV) — [EMENTA.md](EMENTA.md) — com a ementa-alvo de
estudo, **Analista de TI / Perfil 3: Desenvolvimento de Software** (DATAPREV,
Edital nº 01/2024, FGV) —
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

**É a prova de maior cobertura do acervo.** Onde o DPE-RO clona um bloco só, o
MPU alcança **os cinco blocos técnicos da DATAPREV 2024** — desenvolvimento,
banco de dados, BI, segurança da informação e governança — e em vários pontos
com redação literalmente igual. É a única prova selecionada que devolve questões
de ITIL v4, COBIT 2019, PMBOK, ponto de função *e* story points, DW/ETL/OLAP,
ISO 27001/27002 e metadados no mesmo caderno.

O preço é a profundidade: o MPU vai muito além da DATAPREV em ferramenta
nomeada (Kafka, MinIO, QlikView, Power BI, Jackrabbit, Oracle APEX, SQL
Navigator) e em governança de dados (DAMA/DMBOK, CRISP-DM). Boa parte disso é
N2 — conceito aproveitável, detalhe descartável.

| | |
|---|---|
| Questões específicas | 40 (de 80) |
| Blocos da DATAPREV alcançados | **5 de 5** |
| Cobertura da ementa técnica da DATAPREV | ~75% |
| Aproveitamento estimado das 40 específicas | **~75–80% em N3 ou acima** |
| Posição no acervo | **1º em amplitude** (maior número de itens da sua ementa tocados) |

---

## 🟩 N4 — Idêntico

Pares com redação literal ou rol fechado igual — o núcleo do valor desta prova.

### Gestão e governança

| Tópico no MPU 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Gestão de projetos (PMBOK 7ª Edição). Gerenciamento de projetos. Conceitos; áreas de conhecimento; projetos; programas; portfólio. Tipos de abordagem: tradicional, híbrida e ágil | GOV-1 | **frase quase literal** — a DATAPREV escreve "conceitos; áreas de conhecimento, projetos, programas, portfólio, Tipos de Abordagem: tradicional, hibrida e ágil" |
| Biblioteca ITIL versão 4 | GOV-4 | igual |
| COBIT 2019 framework | GOV-5 | igual |
| Gerenciamento de processos de negócio: modelagem, análise, desenho, transformação de processos. Notação BPMN. BPMS. Automação de processos | GOV-6 | igual em substância |
| Metodologia de ponto de função e story points | DS-11 | **literal** |
| Gestão de processos: conceitos, fundamentos, técnicas de mapeamento, análise e melhoria de processos (Módulo I — Noções de Administração Pública) | GOV-6 | reforço do mesmo conteúdo por outra disciplina |

### Desenvolvimento

| Tópico no MPU 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Engenharia de requisitos: tipificação, especificação, elicitação, análise, validação e gerenciamento | DS-12 (12.1 classificação, 12.2 processo, 12.3 elicitação) | mesmo rol |
| Processos e métodos ágeis Extreme Programming – XP, SCRUM, Kanban | DS-8 (8.1 Scrum, 8.2 Kanban, 8.3 XP) | mesmo rol fechado |
| Testes de software: planejamento, estratégias, métodos e técnicas; testes automatizados. Test Driven Development (TDD) | DS-7 (bloco TESTES) | mesmo conteúdo |
| Gerência de Configuração: controle de versão, controle de mudança, integração e entrega contínua (CI/CD), protocolo Git | DS-6 + DS-7 | igual |
| Gerenciamento de contêineres: Docker, Kubernetes e Rancher | DS-17 (containers) | a DATAPREV diz "containers"; o MPU nomeia os produtos |
| Arquitetura Hexagonal | DS-17 | **literal** |
| Padrões arquiteturais: REST, SOAP, SOA, microsserviços, webservices, API, interoperabilidade de sistemas | DS-3 + DS-5 + DS-17 | mesmo rol |
| Recomendações W3C: HTML5, CSS3, UX, Ajax, frameworks (ExtJS, Angular, Angular JS, Ionic e React) | DS-13 (HTML, CSS, UX, Ajax, frameworks VueJS/Angular/React) | **quase literal** — mesma estrutura de frase, rol de frameworks parcialmente diferente |
| Java, JEE, Spring, SpringBoot, Spring Cloud, Hibernate, JPA, JUnit, JavaScript, Swagger | DS-1 + DS-3 | interseção direta da pilha |
| Padrões XML, UDDI, WSDL, SOAP e JSON | DS-5 (XML, XSLT, UDDI, REST e JSON) | mesmo rol, sem XSLT e com WSDL/SOAP a mais |
| Robotic Process Automation (RPA) | DS-7.3 | **literal** |
| Desenvolvimento para dispositivos móveis - Android e IOS | DS-1 (final) | **literal** |
| Conhecimento de servidores web: Nginx e Apache. Servidores de aplicação JEE: WebLogic, JBoss, Tomcat, Node.js, Wildfly | DS-3 ("Servidor de aplicações. Servidor web.") | mesmo conceito, com produtos nomeados |
| Usabilidade de software: User Experience (UX), design de User Interface (UI) e métodos para avaliação de usabilidade | DS-19 + DS-19.1.6 | mesmo conteúdo |

### Banco de dados e BI

| Tópico no MPU 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Modelagem de dados (conceitual, lógica e física) | BD-1 | **literal** |
| Normalização das estruturas de dados | BD-3 | **literal** |
| Integridade referencial | BD-4 | **literal** |
| Metadados | BD-5 | **literal** |
| Linguagem de consulta estruturada (SQL). Linguagens de definição (DDL), manipulação (DML), controle (DCL) e transação (DTL) de dados | BD-7, BD-8, BD-9 | igual, com DCL/DTL a mais |
| SGBDs Oracle, MySQL e PostgreSQL | BD-10 | mesmo conceito, com produtos |
| Bancos de dados NoSQL. MongoDB. GraphDB | BD-12 | igual |
| Data lakes e soluções para big data | BD-14 | **literal** |
| Técnicas de integração e ingestão de dados (ETL/ELT, transferência de arquivos e integração via Base de Dados) | BD-17 | **literal, frase inteira** |
| Modelo e Diagrama Entidade Relacionamento | BD-1 | igual |
| Soluções de suporte à decisão. Conceitos, fundamentos, características, técnicas. Business Intelligence (BI) | BI-1 + BI-2 | **quase literal** — a DATAPREV escreve "Conceitos, fundamentos, características, técnicas e métodos de business intelligence (BI)" |
| Data Warehouse, Data Mart, ODS, Data Mining, Data Lake, ETL, OLAP e Repositório de Metadados | BI-3 + BI-4 | mesmo rol |
| Modelagem multidimensional: básica e avançada | BD-6 + BI | igual |

### Segurança da informação

| Tópico no MPU 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Políticas de segurança da informação | SEG-1 | **literal** |
| Confiabilidade, integridade e disponibilidade | SEG-3 (segundo item 3) | **literal** |
| Normas ABNT NBR ISO/IEC 27001-2022 e ABNT NBR ISO/IEC 27002-2022 | SEG-3 (primeiro item 3) | **literal**, só muda o separador do ano |
| Serviços de autenticação; SSO Single Sign-On; Protocolo OAuth2 (RFC 6749) | SEG-4.1 | **literal** |
| Princípios de desenvolvimento seguro de aplicações | SEG-6 (SDL) | igual em substância |

---

## 🟦 N3 — Equivalente

| Tópico no MPU 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| DevSecOps | DS-6 (DevOps) | superconjunto: DevOps com o eixo de segurança embutido |
| Inteligência artificial: conceitos e tecnologias, engenharia de prompts, aprendizado de máquina, deep learning, chatbots, LLMs, RAG | DS-20 | a DATAPREV pede só "Conceitos de Inteligência Artificial, Análise de Dados e Big Data"; o MPU aprofunda bem além |
| Transformação Digital na Administração Pública. Inteligência Artificial. Blockchain e Algoritmos (Módulo I) | DS-15 + DS-20 | é onde o MPU cobra blockchain — em disciplina de administração, não de TI |
| Engenharia de software: ciclo de vida de sistemas, modelos, metodologias, técnicas e ferramentas de análise e projeto (paradigma estruturado e OO). Desenho de arquitetura de soluções | DS-3 + DS-16 | mesmo território, redação mais clássica |
| Processos de software: atividades, reutilização, prototipação | DS-9 (padrões de desenvolvimento e reuso) | reuso é o ponto de contato |
| WCAG, eMAG | DS-19.1.6 (acessibilidade e usabilidade) | a DATAPREV pede o conceito; o MPU pede os modelos nomeados |
| Ferramentas Git, Gitlab, Jenkins, Jira, Confluence; pipelines Gitlab CI/CD | DS-6 + DS-7 | ferramentas concretas do que a DATAPREV pede como conceito |
| Padrões arquiteturais: MVC, três camadas (three-tier), multicamadas (multi-tier), cliente-servidor | DS-3 (arquitetura de aplicações para ambiente web) | arquiteturas em camadas estão implícitas no item da DATAPREV, sem serem nomeadas |
| PL/SQL: conceitos e comandos; linguagens procedurais de SGBDs | BD-9 (DML) + BD-10 | um passo além do DML puro |
| Notação Crow's foot (Pé de Galinha) | BD-1 (modelagem conceitual) | notação específica do MER |
| Lei nº 12.527/2011 (LAI) e Lei nº 13.709/2018 (LGPD), em Noções de Direito Administrativo | Módulo I — Legislação, itens 1 e 4 | a DATAPREV recorta capítulos e decretos; o MPU cobra a lei em bloco |
| Língua Portuguesa (15 questões) | Módulo I — Língua Portuguesa | mesmo texto-base da FGV; a DATAPREV numera em 26 itens, o MPU em texto corrido — conteúdo idêntico |

---

## 🟨 N2 — Parcial / adjacente

| Tópico no MPU 2025 | Item da DATAPREV que encosta | Por que só parcial |
|---|---|---|
| Computação em nuvem: fundamentos, características, modelos de serviços e de implantação | DS-17 (containers, microsserviços), DS-3 (servidor de aplicações) | a DATAPREV 2024 **não cobra nuvem**; o que transfere é a parte de arquitetura distribuída |
| Governança de Dados. DAMA/DMBOK 2ª edição | BD-5 (metadados), BD-16 (avaliação de modelos de dados) | framework não cobrado; os domínios de qualidade e metadados encostam |
| Planejamento estratégico de TI. PDTI: implantação, estrutura e acompanhamento | GOV-5 (governança de TI) | vizinho de COBIT, mas não é item da sua ementa |
| Qualidade de software: CMMI v3 e MPS.BR; métricas de qualidade | DS-11 (métricas), GOV | modelos de maturidade não estão na sua ementa |
| SNAP (Software Non-Functional Assessment Process) | DS-11 (ponto de função) | complemento não funcional da APF; a DATAPREV só pede APF e story points |
| UML 2.5.1 | DS-3 (linguagem orientada a objetos), DS-16 (design de software) | **a DATAPREV 2024 não lista UML** — os diagramas exercitam modelagem OO, mas não são item cobrado |
| Abordagem Domain-Driven Design (DDD); Clean Architecture | DS-16 + DS-17 (arquitetura hexagonal) | mesma família de arquitetura, itens não nomeados na sua ementa |
| SOLID; orientação a eventos; pipes-and-filters; P2P | DS-9, DS-16 | princípios e estilos vizinhos de "padrões de desenvolvimento e reuso" |
| Protocolo Subversion (SVN) | DS-7 (GIT) | mesma função, ferramenta não cobrada |
| Apache Kafka, RabbitMQ, mensageria, Message Broker | DS-3 (interoperabilidade) | a DATAPREV **2024** não cobra mensageria — mas a **de 2026 passou a cobrar** ("Web services. Mensageria. API, Swagger."), então este item sobe de nível para o alvo real |
| Elastic Stack, MinIO, Jackrabbit (JCR), servidores de armazenamento de objetos | — | infraestrutura de apoio, sem item correspondente |
| TypeScript, jQuery, Bootstrap, npm, Maven, ReactNative, Laravel, Django, JDBC, JBossSeam, GraphQL, Python, PHP, Oracle APEX | DS-1 + DS-13 | mesma família (linguagem/framework/build), fora do rol da sua ementa |
| Ferramentas de wireframe: Balsamiq, Figma, Pencil | DS-19.1.7 (desenho e planejamento de interação) | ferramenta do que a DATAPREV pede como prática |
| QlikView, Power BI, Microstrategy, Pentaho, Powercenter, Powerdesigner, Flyway, SQL Navigator | BI-5 (visualização), BD-17 (ETL) | ferramentas de um conteúdo que a sua ementa pede em conceito |
| Metodologia CRISP-DM | BI-4 (data mining) | processo de mineração, não nomeado na sua ementa |
| Álgebra relacional | BD-2 (abordagem relacional), BD-7 (SQL) | fundamento teórico do SQL, não cobrado explicitamente |
| Tratamento de Dados Pessoais no Poder Público (ANPD); Guia do Framework de Privacidade e SI da SGD; privacy by design | SEG-6 (SDL), Legislação (LGPD) | governo federal específico; o princípio de privacy by design encosta no SDL |
| RUP / Processo Unificado; processo incremental | DS-1 (desenvolvimento de sistemas) | processos clássicos que a sua ementa não nomeia |
| Metodologia de indicadores: BSC, OKR, KPI | GOV | gestão de desempenho, sem item correspondente |

---

## 🟧 N1 — Tangencial

| Tópico no MPU 2025 | Observação |
|---|---|
| Noções de Administração Pública — funções da administração, comportamento organizacional, gestão por competências, modelos patrimonialista/burocrático/gerencial | Só o trecho de gestão de processos e o de transformação digital aproveitam (ver N3/N4); o resto é administração pura |
| Noções de Direitos Humanos e de Acessibilidade (Lei nº 10.098/2000, Lei nº 13.146/2015) | Acessibilidade **jurídica**, não a acessibilidade **técnica** de DS-19.1.6. Compartilham a palavra, não o conteúdo |
| Resolução CNMP nº 276/2023 (MP Digital) | Normativo de transformação digital de outro órgão |

---

## ⬜ N0 — Sem relação

- Noções de Sustentabilidade (5 questões) — Art. 225 da CF, Relatório Brundtland, A3P, PNMC, PNRS, Lei de Crimes Ambientais, SNUC, LC nº 140/2011
- Legislação Institucional (LC nº 75/1993; Lei nº 13.316/2016; Portarias PGR/MPU nº 98/2017 e nº 247/2023)
- Noções de Direito Administrativo — atos, poderes, licitações, Lei nº 8.112/1990, LINDB, responsabilidade civil do Estado, improbidade
- Direitos Humanos e Fundamentais (teoria geral, Declaração Universal, Pacto de São José, Agenda 2030, Estatuto da Igualdade Racial)

---

## O que esta prova **não** cobre da sua ementa

Mesmo sendo a mais ampla, o MPU deixa buracos — e alguns são grandes:

**Segurança da informação (o furo mais sério):**
- **OWASP Top 10** — ausente. O MPU fala de desenvolvimento seguro, mas não cobra o Top 10
- **SAST e DAST** — ausentes
- **Gerência de riscos: ameaça, vulnerabilidade e impacto** (SEG-5) — ausente
- **SDL (Security Development Lifecycle)** nomeado — ausente

**Desenvolvimento:**
- **Análise estática de código-fonte: clean code e SonarQube** (DS-2) — ausente
- **JSF e Primefaces** — ausentes da pilha Java do MPU
- **Ferramentas low-code e no-code** — ausentes
- **SPA e PWA**, **padrões de frontend** (DS-13.1, 13.2) — ausentes
- **Ambientes Internet, extranet, intranet e portal** (DS-4) — ausente
- **Transações distribuídas** (DS-18) — ausente
- **XSLT** — ausente do rol de padrões
- **Blockchain** — só aparece de raspão, em Administração Pública

**Conteúdo e interação:**
- **Sistemas de gestão de conteúdo (CMS), portais corporativos, arquitetura de informação, workflow** (DS-19.1.1 a 19.1.5) — ausentes por inteiro

**Banco de dados e BI:**
- **Banco de dados em memória** (BD-13) — ausente
- **Dados estruturados e não estruturados** (BD-15) — ausente
- **Avaliação de modelos de dados** (BD-16) — ausente
- **Visualização de dados: BD individuais e cubos** (BI-5) — ausente
- **Mapeamento das fontes de dados: técnicas para coleta** (BI-6) — ausente

**Módulo I:**
- **Língua Inglesa**, **Raciocínio Lógico**, **Atualidades** — ausentes
- Legislação: **Marco Civil da Internet (12.965)**, **Delitos Informáticos (12.737)**, **Decretos 7.724 e 7.845** — ausentes

---

## Veredito

**Use esta prova como a segunda do seu ciclo, depois do DPE-RO — e use-a para
exatamente o que o DPE-RO não dá.** As 40 específicas do MPU são o melhor
material do acervo para:

- **Governança e gestão** (ITIL v4, COBIT 2019, PMBOK 7, BPM/BPMN, ponto de função e story points) — nenhuma outra prova entrega os cinco no mesmo caderno
- **Banco de dados** — cobre BD-1 a BD-12, BD-14 e BD-17 com redação praticamente igual à sua
- **Business Intelligence** — o bloco de suporte à decisão do MPU é o espelho mais fiel do seu bloco de BI
- **ISO 27001/27002 e OAuth2/SSO**

Ressalvas ao simular:

1. **Descarte por ferramenta, não por assunto.** Muita questão do MPU é sobre
   produto nomeado (QlikView, Kafka, MinIO, Oracle APEX). Erre-a sem culpa; o
   que importa é se você acertou o conceito por trás.
2. **Ela não te testa em segurança de aplicação.** Sem OWASP Top 10, sem
   SAST/DAST, sem gerência de riscos — para SEG-5, SEG-6 e SEG-7 procure
   TCE-RR 2025, que é forte justamente aí.
3. **O item de mensageria vale mais do que parece.** Contra a ementa de 2024 é
   N2, mas o edital de 2026 incluiu "Mensageria" no item de web services — se
   você estuda para 2026, promova esse conteúdo.
