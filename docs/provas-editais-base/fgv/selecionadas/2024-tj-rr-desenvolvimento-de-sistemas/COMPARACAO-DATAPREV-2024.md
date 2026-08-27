# TJ-RR 2024 × DATAPREV 2024 — comparação de ementas

Compara a ementa de **Analista Judiciário – Desenvolvimento de Sistemas**
(TJ-RR, Edital nº 01/2024, FGV) — [EMENTA.md](EMENTA.md) — com a ementa-alvo de
estudo, **Analista de TI / Perfil 3: Desenvolvimento de Software** (DATAPREV,
Edital nº 01/2024, FGV) —
[../../../../provas-editais-alvo/dataprev/dataprev-2024/EMENTA.md](../../../../provas-editais-alvo/dataprev/dataprev-2024/EMENTA.md).

> As duas provas foram aplicadas **no mesmo dia — 17/11/2024** — pela mesma
> banca. A comparação é contra a ementa de **2024**, que é a base de estudo; o
> alvo real é o edital de 2026, e o que mudou está em
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

**É a prova do acervo mais forte nos blocos que você tende a negligenciar — e a
mais fraca justamente onde você programa.**

O TJ-RR cobre com precisão os dois pedaços da sua ementa que quase nenhuma outra
prova selecionada alcança:

- **Business Intelligence completo** — DW, Data Mart, Data Mining, OLAP, ETL e
  modelagem multidimensional em um só item, com o mesmo rol da DATAPREV
- **BPM, BPMN 2.0, workflow e portais corporativos** — cobre GOV-6 e todo o
  DS-19.1 (CMS, arquitetura de informação, portais corporativos, workflow,
  acessibilidade), o bloco de gestão de conteúdo que o MPU e o TCE-RR ignoram

E é a única do acervo que traz **arquitetura hexagonal nomeada** ao lado de
Clean Architecture, DDD e microsserviços.

O buraco é frontal: **o TJ-RR não cobra nenhuma linguagem de programação e
nenhum framework.** Nem Java, nem JavaScript, nem Spring, nem HTML/CSS, nem
React/Angular/Vue. O item de desenvolvimento de software é conceitual
("Implementação e manutenção de software"). Também não há JSON, XML nem
governança de TI (nada de ITIL, COBIT ou PMBOK).

| | |
|---|---|
| Questões específicas | 40 (de 70), das quais parte é Noções de Direito |
| Blocos da DATAPREV alcançados | 5 de 5, mas com o de desenvolvimento amputado |
| Cobertura da ementa técnica da DATAPREV | ~55% |
| Aproveitamento estimado das 40 específicas | **~50–55% em N3 ou acima** |
| Posição no acervo | **1º em BI, BPM e gestão de conteúdo**; último em linguagens e frameworks |

---

## 🟩 N4 — Idêntico

### Business Intelligence e dados — o ponto forte

| Tópico no TJ-RR 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Banco de dados NoSQL, Big Data, **Business Intelligence** | BD-12 + BD-14 + BI-1 | mesmo rol |
| Conceitos de **Data Warehouse**, Tipos de **Data Mart**, **Data Mining**, **OLAP** e **ETL**, **Modelagem Multidimensional de Dados** | BI-3 + BI-4 + BD-6 + BD-17 | **rol praticamente idêntico** ao bloco de BI da DATAPREV |
| Transação, Commit, Conceito **ACID**, Serialização; Bloqueios/Locks | BD-11 (propriedades de banco de dados) | igual |
| **SQL/PL-SQL, DDL, DML, DQL, DTL e DCL** | BD-7 + BD-8 + BD-9 | igual, com DQL/DTL/DCL a mais |
| **Modelo de entidades e relacionamentos. Modelo relacional** | BD-1 + BD-2 | igual |

### Processos, conteúdo e interação

| Tópico no TJ-RR 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Modelagem de Processos de Negócio; identificação e delimitação; mapeamento (AS-IS); análise e simulação; modelagem (TO-BE); indicadores de processos | GOV-6 (gestão de processos e modelagem de processos de negócio) | mesmo conteúdo, muito mais detalhado |
| Gerenciamento de processos de negócio (BPM) com sistema/suite (BPMS). **Notação BPMN 2.0** | GOV-6 (modelagem de processos de negócio usando BPMN) | **literal** |
| **Automação de processos de trabalho (Workflow)** | DS-19.1.5 (Workflow) | **literal** |
| **Portais Corporativos.** Conceitos básicos: colaboração, personalização, gestão do conhecimento, **gestão de conteúdo**, taxonomia, web 2.0, governança | DS-19.1 (sistemas de gestão de conteúdo) + DS-19.1.3 (portais corporativos) | mesmo território, item por item |
| Gestão de Processos. Conceito. Mapeamento de processos. Análise e melhoria de processos (bloco Normas aplicadas ao Poder Judiciário) | GOV-6 | reforço do mesmo conteúdo por outra disciplina |

### Engenharia de software e arquitetura

| Tópico no TJ-RR 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Metodologias ágeis aplicadas a projetos de desenvolvimento de software (**SCRUM, XP, KANBAN**) | DS-8 (8.1 Scrum, 8.2 Kanban, 8.3 XP) | **rol fechado idêntico** |
| Engenharia de Requisitos: **Elicitação, Especificação e Gerenciamento** de requisitos. Prototipação | DS-12 (12.1–12.3) | mesmo rol |
| Testes de Software: Estratégias de testes. Técnicas de testes, Verificação e Validação. Gestão de defeitos. Rastreabilidade dos cenários de teste. **Métodos de automatização de testes. Testes em processos ágeis** | DS-7 (bloco TESTES: automatizados, ágeis, tipos, ciclo de vida) | mesmo rol, com gestão de defeitos a mais |
| **Desenvolvimento orientado a testes (TDD)** | DS-7 (Test-driven development) | **literal** |
| Estimativa de Esforço: **Análise de pontos de função (APF)** — conceitos básicos e aplicações | DS-11 (Metodologia de Ponto de Função) | igual |
| **Gerência de configuração, Integração contínua, Entrega Contínua. Protocolo Git** | DS-6 (DevOps) + DS-7 (Ferramenta de Gestão da configuração GIT) | igual |
| **Arquitetura Hexagonal.** Arquitetura Orientada a Serviços. **Microsserviços.** Padrão arquitetural **SOAP e REST** | DS-17 (arquitetura hexagonal, microsserviços) + DS-3 (SOA) + DS-5 (REST) | **arquitetura hexagonal literal** — raro no acervo |
| **Conteinerização e orquestração de Contêiners** | DS-17 (containers) | igual |
| **Integração de sistemas** | DS-3 (interoperabilidade de sistemas) | igual |
| Conceitos de desenvolvimento seguro. Segurança de aplicações baseada na **OWASP Top Ten 2021** | SEG-6 (SDL, OWASP Top 10) | **literal**, com a versão fixada |
| **OAuth 2.0** | SEG-4.1 (Protocolo OAuth2) | **literal** |
| Usabilidade | DS-19.1.6 (conceitos de acessibilidade e usabilidade) | igual |

---

## 🟦 N3 — Equivalente

| Tópico no TJ-RR 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Desenvolvimento de Software: Implementação e manutenção de software | DS-1 (abertura) + DS-10 (codificação de software) | é tudo o que o TJ-RR diz sobre codificar — sem citar uma linguagem |
| Padrões de projeto (Design Patterns) | DS-9 (padrões de desenvolvimento e reuso) | mesma matéria; a DATAPREV não nomeia o catálogo GoF |
| Arquitetura multicamadas | DS-3 (arquitetura de aplicações para ambiente web) | camadas implícitas no item da sua ementa |
| SSL (Secure Sockets Layer): **HTTPS**, FTPS e SFTP | DS-14 (Protocolos HTTPS, SSL/TLS) | HTTPS e SSL literais; FTPS/SFTP são extras |
| Privacy & Security by design | SEG-6 (SDL) | princípio central do ciclo de desenvolvimento seguro |
| Consultas, procedures, packages, funções, **triggers e views** | BD-8 (DDL) + BD-9 (DML) | objetos de banco definidos por DDL, um passo além do comando puro |
| Acessibilidade: recomendações para conteúdo do governo brasileiro na internet. Modelo **e-MAG** | DS-19.1.6 | a DATAPREV pede o conceito; o TJ-RR pede o modelo brasileiro nomeado |
| Refatoração de software | DS-2 (clean code) | refatoração é a prática que o clean code exige — mas a DATAPREV pede análise estática, não refatoração |
| Linguagem de modelagem UML 2.5.1 (na parte de Engenharia de Software) | DS-3 (arquitetura e linguagem orientada a objetos) | ver ressalva em N2 |

---

## 🟨 N2 — Parcial / adjacente

| Tópico no TJ-RR 2024 | Item da DATAPREV que encosta | Por que só parcial |
|---|---|---|
| **UML 2.5.1** (modelagem de casos de uso, classes, sequência) | DS-3 (linguagem OO) + DS-16 (design de software) | **a DATAPREV 2024 não lista UML** — exercita modelagem OO sem ser item cobrado |
| Domain Driven Design (DDD); Clean Architecture; Serverless; Arquitetura de sistemas baseada em nuvem | DS-16 (design de software) + DS-17 | mesma família arquitetural; itens não nomeados na sua ementa, e a DATAPREV 2024 não cobra nuvem |
| Inversão de controle; Injeção de dependências; Programação por contrato | DS-9 (padrões e reuso) + DS-16 | princípios que a sua ementa pressupõe (é o que o Spring faz) sem cobrar por nome |
| Qualidade de software: **CMMI, MPS.BR**; indicadores/métricas de qualidade | DS-11 (métricas) | modelos de maturidade fora da sua ementa |
| Contagem em projetos de desenvolvimento e manutenção: **IFPUG e NESMA**, uso de deflatores | DS-11 (ponto de função) | detalhe de contagem além do que a DATAPREV pede |
| Medição não funcional: **SNAP** | DS-11 | complemento não funcional da APF, não cobrado |
| **SAML 2.0**; **MFA** | SEG-4.1 (controle de acesso, OAuth2, SSO) | mesma família de autenticação federada; SAML e MFA não estão na sua ementa |
| Padrões de Interoperabilidade de Governo Eletrônico – **ePING** | DS-3 (interoperabilidade de sistemas) | é interoperabilidade, mas na versão normativa do governo federal |
| Noções de sistemas de busca e indexação de conteúdo; análise das estatísticas de site | DS-19.1.2 (arquitetura de informação) | funcionalidade de portal, não item próprio |
| Apoio ao desenvolvimento de software: IDEs | DS-1 | ferramenta de trabalho, sem item correspondente |
| Fundamentos de BD: organização de arquivos e métodos de acesso | BD-10 (SGBD) | interno do SGBD, um nível abaixo do que sua ementa pede |
| Noções de Redes: Arquitetura OSI da ISO; TCP/IP; Redes P2P, WAN, LAN, WLAN | DS-4 (ambientes internet/intranet) + DS-14 (HTTPS/SSL) | base de rede sob os protocolos que você cobra; não é item seu |
| Design System do Governo Federal | DS-19.1.7 (desenho e planejamento de interação) | padrão visual de governo, vizinho de UX |
| Norma ISO 9001: princípios de gestão da qualidade, abordagem de processo, ciclo PDCA, mentalidade de risco | GOV-3 (gestão de riscos) + GOV-6 (gestão de processos) | qualidade de gestão, não de software |

---

## 🟧 N1 — Tangencial

| Tópico no TJ-RR 2024 | Observação |
|---|---|
| Arquitetura de computadores: processadores, memória, armazenamento, E/S, execução de instruções, paralelismo, multiprocessamento | Fora da sua ementa por completo; só serve como base conceitual distante |
| Sistemas operacionais: processos, threads, escalonamento, sincronização, deadlocks, starvation, memória virtual, paginação, segmentação, sistemas de arquivos | Idem. Concorrência e sincronização encostam de longe em transações distribuídas (DS-18) |
| Estratégia Nacional do Poder Judiciário; política de sustentabilidade (Resolução CNJ 400/2021) | Planejamento estratégico de órgão, sem correspondência |

---

## ⬜ N0 — Sem relação

- Noções de Legislação: Regime Jurídico dos Servidores de Roraima (LC 53/2001), COJERR, Regimento Interno do TJRR, Código de Ética, Política de Gestão de Desempenho
- Noções de Direito Constitucional e Administrativo (o bloco inteiro, dentro dos Conhecimentos Específicos)
- Lei de Licitações (14.133/2021), Estatuto da Pessoa com Deficiência (13.146/2015)
- Resoluções e Portarias do CNJ (nº 522/2023, nº 335/2020, nº 252/2020, nº 253/2020, nº 131/2021)

---

## O que esta prova **não** cobre da sua ementa

**Linguagens e frameworks — nada, em absoluto:**
- **Java, JavaEE, JakartaEE, JPA, JavaScript** — ausentes
- **JUnit, Hibernate, JSF, Primefaces, Spring, SpringCloud, SpringBoot** — ausentes
- **Ferramentas low-code e no-code** — ausentes
- **Desenvolvimento para dispositivos móveis (Android e iOS)** — ausente

**Frontend — o bloco inteiro (DS-13):**
- **HTML, CSS, Ajax**, frameworks **VueJS/Angular/React**, **padrões de frontend**, **SPA e PWA** — nada disso está no TJ-RR

**Interoperabilidade e formatos:**
- **Padrões XML, XSLT, UDDI e JSON** (DS-5) — ausentes; só SOAP e REST aparecem
- **Swagger** (DS-3) — ausente
- **Servidor de aplicações e servidor web** (DS-3) — ausentes
- **Ambientes Internet, extranet, intranet e portal** (DS-4) — ausente

**Governança de TI — o bloco quase inteiro:**
- **ITIL v4** (GOV-4), **COBIT 2019** (GOV-5), **gerenciamento de projetos / PMBOK / Guia Scrum / abordagens tradicional-híbrida-ágil** (GOV-1, GOV-2), **gestão de riscos** (GOV-3) — ausentes. Só BPM/BPMN sobrevive

**Segurança da informação — a parte normativa:**
- **Políticas de segurança da informação** (SEG-1), **procedimentos e gerenciamento** (SEG-2), **ISO 27001:2022 e 27002:2022** (SEG-3), **confiabilidade/integridade/disponibilidade** (SEG-3), **gerência de riscos: ameaça, vulnerabilidade e impacto** (SEG-5), **SAST e DAST** (SEG-7) — ausentes
- **SSO** aparece? Não — só OAuth 2.0, SAML e MFA

**Desenvolvimento e dados, itens pontuais:**
- **Análise estática de código-fonte: clean code e SonarQube** (DS-2) — ausente
- **RPA** (DS-7.3) — ausente
- **Story points** (DS-11) — ausente (só APF)
- **Blockchain** (DS-15) — ausente
- **Transações distribuídas** (DS-18) — ausente
- **IA, análise de dados** (DS-20) — ausentes (Big Data aparece, IA não)
- **Data lakes** (BD-14), **banco de dados em memória** (BD-13), **metadados** (BD-5), **integridade referencial** (BD-4), **normalização** (BD-3), **dados estruturados e não estruturados** (BD-15), **avaliação de modelos de dados** (BD-16), **ETL/ELT e ingestão** (BD-17) — ausentes
- **Visualização de dados: BD individuais e cubos** (BI-5), **mapeamento das fontes de dados** (BI-6), **arquitetura de BI** (BI-7) — ausentes

**Módulo I:**
- **Língua Inglesa**, **Raciocínio Lógico**, **Atualidades** — ausentes
- Legislação inteira: **LAI**, **Decretos 7.724/7.845**, **Delitos Informáticos**, **Marco Civil**, **LGPD** — ausentes

---

## Veredito

**Use esta prova como o contrapeso do DPE-RO.** As duas se completam quase
perfeitamente: o DPE-RO clona o bloco de desenvolvimento e ignora o resto; o
TJ-RR ignora linguagens e frameworks e entrega tudo o que vem depois.

Vá atrás especificamente das questões de:

1. **Business Intelligence** — DW, Data Mart, data mining, OLAP, ETL e
   modelagem multidimensional. Junto com o MPU 2025, é a melhor fonte do acervo
   para o seu bloco de BI.
2. **BPM, BPMN 2.0, BPMS, AS-IS/TO-BE e workflow** — cobre GOV-6 com muito mais
   profundidade do que a sua própria ementa pede, e é a única do acervo que trata
   workflow como item próprio.
3. **Portais corporativos, gestão de conteúdo, taxonomia, acessibilidade e
   e-MAG** — o bloco DS-19.1 inteiro, que MPU e TCE-RR não cobrem.
4. **Arquitetura hexagonal, microsserviços, contêineres e SOA** — DS-17
   completo, com arquitetura hexagonal nomeada.
5. **Transações e ACID** — BD-11 com o detalhe de serialização e locks.

Ressalvas ao simular:

1. **Ela não te testa em programação.** Zero questões de Java, JavaScript,
   Spring ou frontend. Um bom resultado aqui não diz nada sobre DS-1 e DS-13.
2. **Descarte de saída** as questões de arquitetura de computadores, sistemas
   operacionais, redes e todo o bloco de Direito — são um pedaço grande das 40
   e nenhum item da sua ementa depende deles.
3. **Cuidado com CMMI, MPS.BR, SNAP, IFPUG/NESMA e SAML** — parecem seus, não
   são. Errar essas não é sinal de nada.
