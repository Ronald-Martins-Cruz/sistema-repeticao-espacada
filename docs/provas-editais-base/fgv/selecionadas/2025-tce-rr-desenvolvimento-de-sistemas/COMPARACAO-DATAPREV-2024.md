# TCE-RR 2025 × DATAPREV 2024 — comparação de ementas

Compara a ementa de **Analista Administrativo – TI, especialidade Desenvolvimento
de Sistemas** (TCE-RR, Edital nº 001/2024, FGV) — [EMENTA.md](EMENTA.md) — com a
ementa-alvo de estudo, **Analista de TI / Perfil 3: Desenvolvimento de Software**
(DATAPREV, Edital nº 01/2024, FGV) —
[../../../../provas-editais-alvo/dataprev/dataprev-2024/EMENTA.md](../../../../provas-editais-alvo/dataprev/dataprev-2024/EMENTA.md).

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

**É a melhor prova do acervo para segurança de aplicação — e a que mais
desperdiça questões.**

A ementa técnica do TCE-RR é organizada em oito eixos didáticos (engenharia de
software, backend/frontend, banco de dados, auditoria, arquitetura, segurança,
testes, governança) e acerta em cheio três coisas que o resto do acervo cobre
mal: **SonarQube e clean code** (DS-2, que só o DPE-RO teria e foi justamente o
item removido lá), **SDLC seguro com OWASP ZAP, SQL injection, XSS e CSRF**
(SEG-6/SEG-7) e **SPA/PWA** (DS-13.2).

O problema é a diluição. Das 80 questões, só **30 são de TI** — a menor
proporção do acervo — e dessas 30, os dez primeiros itens do Módulo III são
**Tribunais de Contas e auditoria do setor público**, sem qualquer relação com a
sua ementa. O caderno útil é pequeno.

| | |
|---|---|
| Questões específicas de TI | 30 (de 80) |
| Parte do Módulo III que é auditoria de TCs (N0) | ~1/3 dos itens |
| Blocos da DATAPREV alcançados | 4 de 5 (**sem BI**) |
| Cobertura da ementa técnica da DATAPREV | ~55% |
| Aproveitamento estimado das 30 específicas | **~55–60% em N3 ou acima** |
| Posição no acervo | **1º em segurança de aplicação**, último em densidade útil por caderno |

---

## 🟩 N4 — Idêntico

### Segurança — o ponto forte desta prova

| Tópico no TCE-RR 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 6.1 Segurança no ciclo de vida de desenvolvimento de software (SDLC) | SEG-6 (SDL – Security Development Lifecycle) | mesmo conteúdo |
| 6.1 Proteção contra vulnerabilidades comuns: injeção de SQL, Cross-Site Scripting (XSS), Cross-Site Request Forgery (CSRF) | SEG-6 (OWASP Top 10) | as vulnerabilidades canônicas do Top 10, item a item |
| 6.1 Ferramentas de análise de segurança de código: **SonarQube**, OWASP ZAP | DS-2 (clean code e ferramenta SonarQube) + SEG-7 (SAST/DAST) | **SonarQube literal** — SonarQube estático (SAST) e ZAP dinâmico (DAST) |
| 6.2 Protocolo HTTPS, SSL/TLS | DS-14 | **literal** |
| 6.2 Implementação de autenticação e autorização: SSO, OAuth 2.0, OpenID Connect | SEG-4.1 (controle de acesso, OAuth2, SSO) | mesmo rol |
| 1.1 Boas práticas de desenvolvimento: **Clean Code**, SOLID, DRY | DS-2 (clean code) | clean code literal; SOLID e DRY como reforço |

### Desenvolvimento

| Tópico no TCE-RR 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 1.2 Levantamento de requisitos funcionais e não funcionais; técnicas de análise: entrevistas, questionários, prototipação | DS-12.1 (classificação) + DS-12.3 (elicitação) | mesmo conteúdo, mesma decomposição |
| 1.3 Metodologias ágeis: Manifesto Ágil; Scrum (papéis, artefatos, cerimônias); Kanban (fluxo contínuo, WIP) | DS-8.1, DS-8.2 + GOV-1 (Guia Scrum) | mesmo rol, com o detalhe de papéis/artefatos/cerimônias que a DATAPREV também exige via Guia Scrum |
| 8.1 Metodologias ágeis: Scrum, Kanban, XP | DS-8 (8.1–8.3) | **rol fechado idêntico** |
| 2.1 Java: orientação a objetos, frameworks (Spring Boot, Hibernate) | DS-1 | interseção direta da pilha |
| 2.1 Serviços web e APIs REST: criação e consumo de APIs RESTful | DS-3 (web services, API) + DS-5 (REST) | igual |
| 2.1 Controle de versionamento: Git, GitHub/GitLab | DS-7 (Ferramenta de Gestão da configuração GIT) | igual |
| 2.2 HTML5, CSS3 e JavaScript; frameworks Angular, React, Vue.js; Ajax | DS-13 (HTML, CSS, Ajax, frameworks VueJS/Angular/React) | **rol de frameworks idêntico** |
| 2.3 Single Page Applications (SPA) e Progressive Web Apps (PWA) | DS-13.2 | **literal** |
| 5.1 Arquitetura monolítica e baseada em microsserviços; padrões RESTful e SOAP | DS-17 + DS-5 | igual |
| 5.2 SOA: princípios e padrões; web services e interoperabilidade entre sistemas; SOAP vs. REST | DS-3 (arquitetura e linguagem orientada a serviços, interoperabilidade, web services) | mesmo conteúdo |
| 5.3 Microsserviços: API Gateway; Docker, Kubernetes | DS-17 (microsserviços, orquestração de serviços e API gateway, containers) | mesmo rol |
| 5.4 Continuous Integration e Continuous Delivery (CI/CD); DevOps e DevSecOps | DS-6 (DevOps) | igual |
| 7.1 Testes unitários, testes de integração, testes funcionais e de regressão; automação (Selenium, JUnit, PyTest) | DS-7 (bloco TESTES) + DS-1 (JUnit) | mesmo rol, com JUnit nomeado nos dois |
| 5.1 Padrões de design de software | DS-9 (padrões de desenvolvimento e reuso) | igual em substância |

### Banco de dados e governança

| Tópico no TCE-RR 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 3.1 Modelo entidade-relacionamento, normalização, cardinalidade; DER; modelagem lógica e física | BD-1 + BD-3 | igual |
| 3.2 Comandos de criação e manipulação de dados (DDL e DML) | BD-8 + BD-9 | **literal** |
| 3.2 Consultas avançadas: JOIN, agregações, subconsultas | BD-7 (SQL) | igual |
| 3.2 Transações e controle de concorrência | BD-11 (propriedades de banco de dados) | igual |
| 3.3 Relacionais: MySQL, PostgreSQL, Oracle | BD-10 (SGBD) | mesmo conceito, com produtos |
| 3.3 NoSQL: MongoDB, **Redis**; cenários de uso | BD-12 (NoSQL) + BD-13 (banco de dados em memória) | Redis é o exemplo canônico de BD em memória — **um dos raros pontos do acervo que cobre BD-13** |
| 3.2 Segurança de banco de dados: permissões de usuários, controle de acesso | SEG-4.1 | igual |
| 8.2 Governança de TI: COBIT, ITIL; gestão de serviços de TI: SLA, incidentes, mudanças, problemas | GOV-4 + GOV-5 | mesmo conteúdo (sem versão nomeada — ver N3) |
| 8.1 Planejamento e controle de projetos: cronograma, escopo, custo, qualidade | GOV-1 + GOV-2 | áreas de conhecimento do gerenciamento de projetos |

---

## 🟦 N3 — Equivalente

| Tópico no TCE-RR 2025 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 1.1 Ciclo de vida do desenvolvimento de software: requisitos, análise, design, implementação, testes e manutenção | DS-1 + DS-16 (design de software) | mesma matéria, redação de livro-texto |
| 1.1 Modelos de desenvolvimento: Cascata, Iterativo, Incremental, Ágil | DS-8 | a DATAPREV só cobra o ramo ágil; o resto é contraste |
| 1.2 Documentação de requisitos: caso de uso, histórias de usuários | DS-12.2 (processo de engenharia de requisitos) + DS-11 (story points) | histórias de usuário ligam direto a story points |
| 2.3 Integração entre frontend e backend: comunicação entre camadas | DS-3 (arquitetura de aplicações para ambiente web) | igual em substância |
| 2.2 Responsividade e design mobile-first; media queries; Bootstrap | DS-13 + DS-13.1 (padrões de frontend) | responsividade é padrão de frontend; Bootstrap é a ferramenta |
| 4.1 Normas de controle: COSO, **COBIT** | GOV-5 (COBIT 2019) | o TCE-RR não fixa versão; a DATAPREV pede a 2019 |
| 8.2 Princípios de governança de TI: COBIT, **ITIL** | GOV-4 (ITIL v4) | mesma ressalva de versão |
| 6.3 LGPD: princípios aplicados ao desenvolvimento; coleta, armazenamento e processamento de dados pessoais; auditoria e conformidade | Módulo I — Legislação, item 4 | a DATAPREV recorta capítulos da lei; o TCE-RR cobra a aplicação prática |
| Lei nº 12.527/2011 (LAI) e Lei nº 13.709/2018 (LGPD), em Noções de Direito | Módulo I — Legislação, itens 1 e 4 | reforço, sem os decretos 7.724/7.845 |
| 6.2 Conceitos de criptografia simétrica e assimétrica | DS-14 (HTTPS, SSL/TLS) | é o substrato do TLS — a DATAPREV cobra o protocolo, não a criptografia em si |
| 4.1 Controles automatizados: validações, logs de auditoria, permissões e autenticação | SEG-2 (procedimentos de segurança) + SEG-4 (mecanismos de segurança) | mesmo território de controles |
| Raciocínio Lógico Matemático (10 questões) | Módulo I — Raciocínio Lógico | quase o mesmo texto; o TCE-RR tem 13 itens contra 14 da DATAPREV — **falta "Noções de estatística: média, moda, mediana e desvio padrão"**, que na sua prova cai |
| Língua Portuguesa (10 questões) | Módulo I — Língua Portuguesa | mesmo texto-base da FGV, condensado em 14 itens |

---

## 🟨 N2 — Parcial / adjacente

| Tópico no TCE-RR 2025 | Item da DATAPREV que encosta | Por que só parcial |
|---|---|---|
| 2.1 PHP (Laravel, CodeIgniter, Symfony), Python (Django, Flask), C# (.NET) | DS-1 (Java, JavaEE) | mesma função, pilha fora do seu rol. O que transfere é OO, MVC e integração com BD |
| 2.1 JWT (JSON Web Token) | SEG-4.1 (OAuth2, SSO) | formato de token do fluxo que a sua ementa cobra |
| 2.3 Ferramentas de build e automação: Webpack, Babel, NPM | DS-6 (DevOps), DS-13 | toolchain de frontend, sem item correspondente |
| 5.1 Padrões Singleton, Factory, Observer | DS-9 (padrões de desenvolvimento e reuso) | são GoF; a sua ementa pede padrões sem nomear o catálogo |
| 5.3 Service mesh; mensageria (RabbitMQ, Kafka) | DS-3 (interoperabilidade) | a DATAPREV **2024** não cobra mensageria — a **de 2026 passou a cobrar** ("Web services. Mensageria. API, Swagger."), então este item sobe de nível para o alvo real |
| 5.4 Jenkins; Maven | DS-6 (DevOps) | ferramentas do conceito que a sua ementa pede |
| 7.1 Testes de desempenho e carga: JMeter, Locust | DS-7 (tipos de testes) | tipo de teste que a DATAPREV cobre sob "tipos de testes", sem nomear ferramenta |
| 7.2 Testes de invasão (pentests); OWASP ZAP, Burp Suite | SEG-7 (DAST) | pentest é vizinho do DAST, não o mesmo |
| 8.1 Ferramentas de gestão de projetos: Microsoft Project, Jira, Trello | GOV-1 | ferramenta, não conceito |
| 4.1 Conceitos de controle interno em sistemas de informação | SEG-2 | controle interno organizacional, mais amplo que o item da sua ementa |
| 1.2 Diagramas UML (casos de uso, classes, sequência, atividades) | DS-3 (linguagem orientada a objetos), DS-16 | **a DATAPREV 2024 não lista UML** — os diagramas exercitam modelagem OO sem ser item cobrado |
| Administração Pública: PDCA; SWOT, matriz GUT; indicadores de desempenho | GOV-1, GOV-3 | ferramentas de gestão vizinhas de gerenciamento de projetos e riscos |

---

## 🟧 N1 — Tangencial

| Tópico no TCE-RR 2025 | Observação |
|---|---|
| 4.2 Auditoria de sistemas: escopo, objetivos, planejamento e execução; auditoria em ambientes de TI (segurança, disponibilidade, integridade, confidencialidade) | O tripé CID aparece (SEG-3), mas embutido em auditoria — matéria que a sua ementa não cobra |
| 4.2 Ferramentas de auditoria e logs: Splunk, ELK Stack (Elasticsearch, Logstash, Kibana) | Observabilidade não está na sua ementa |
| 4.3 Gestão de logs e monitoramento: Zabbix, Nagios, Prometheus; detecção e mitigação de incidentes com base em logs | Idem — só a gestão de incidentes encosta, via ISO 27002 |
| Administração Pública: Governo eletrônico, transparência, accountability | Encosta em DS-4 (portal) e nas leis de acesso, mas por outro caminho |

---

## ⬜ N0 — Sem relação

- **Tribunais de Contas** (itens 1 a 10 do Módulo III): independência, valores e benefícios, transparência e accountability dos TCs, controle da qualidade de auditorias, princípios fundamentais de auditoria do setor público / financeira / de conformidade / operacional, normas de auditoria — **é o maior bloco perdido, e ele está dentro das 30 questões técnicas**
- Legislação Específica (Constituição do Estado de Roraima; Lei Orgânica do TCE-RR; Regimento Interno)
- Noções de Direito Constitucional e Administrativo (exceto LAI e LGPD, ver N3)
- Administração Pública: políticas públicas, gestão participativa, governabilidade, corrupção, mudanças institucionais

---

## O que esta prova **não** cobre da sua ementa

**Business Intelligence — o bloco inteiro:**
- Conceitos e arquitetura de BI, sistemas de suporte a decisão, **Data Warehouse**, **OLAP**, **ETL**, **data mining**, **modelagem multidimensional**, visualização de dados, mapeamento de fontes — **nada disso está no TCE-RR**. É o furo mais grave desta prova.

**Segurança da informação — a parte normativa:**
- **ISO 27001:2022 e ISO 27002:2022** — ausentes
- **Políticas de segurança da informação** (SEG-1) — ausente
- **Gerência de riscos: ameaça, vulnerabilidade e impacto** (SEG-5) — ausente

**Desenvolvimento:**
- **Ponto de função e story points** (DS-11) — ausentes; o TCE-RR não cobra métrica de software
- **JavaEE, JakartaEE, JPA, JSF, Primefaces, Spring Cloud** — ausentes (só Java + Spring Boot + Hibernate)
- **Ferramentas low-code e no-code** — ausentes
- **Padrões XML, XSLT, UDDI, JSON** (DS-5) — ausentes; só REST e SOAP aparecem
- **Swagger** — ausente
- **Ambientes Internet, extranet, intranet e portal** (DS-4) — ausente
- **RPA** (DS-7.3) — ausente
- **Blockchain** (DS-15) — ausente
- **Arquitetura hexagonal** (DS-17) — ausente (só monolito × microsserviços)
- **Transações distribuídas** (DS-18) — ausente
- **Mobile Android/iOS** (DS-1) — ausente (mobile-first é responsividade web, não é a mesma coisa)
- **UX, CMS, arquitetura de informação, portais corporativos, workflow, acessibilidade e usabilidade, desenho de interação** (DS-19 inteiro) — ausentes
- **IA, análise de dados e Big Data** (DS-20) — ausentes
- **Data lakes** (BD-14) — ausente

**Banco de dados:**
- **Integridade referencial** (BD-4), **metadados** (BD-5), **modelagem dimensional** (BD-6), **dados estruturados e não estruturados** (BD-15), **avaliação de modelos de dados** (BD-16), **ETL/ELT e técnicas de ingestão** (BD-17) — ausentes

**Governança:**
- **BPMN e gestão/modelagem de processos de negócio** (GOV-6) — ausentes
- **Gestão de riscos** (GOV-3) — ausente

**Módulo I:**
- **Língua Inglesa** e **Atualidades** — ausentes
- **Noções de estatística** dentro de Raciocínio Lógico — ausente
- Legislação: **Marco Civil (12.965)**, **Delitos Informáticos (12.737)**, **Decretos 7.724 e 7.845** — ausentes

---

## Veredito

**Use esta prova de forma cirúrgica, não como simulado.** A relação
sinal/ruído do caderno é a pior do acervo — 50 das 80 questões são de
Português, Raciocínio Lógico, Direito e Administração Pública, e mais um terço
das 30 técnicas é auditoria de Tribunais de Contas.

Mas o que sobra é insubstituível. Vá atrás especificamente das questões de:

1. **Segurança no desenvolvimento** — SDLC seguro, SQL injection, XSS, CSRF,
   SonarQube, OWASP ZAP. É o único caderno do acervo que cobre DS-2 e SEG-7
   juntos, e o DPE-RO — a prova mais parecida com a sua — é justamente a que
   teve o item do SonarQube removido.
2. **Criptografia e autenticação** — HTTPS/SSL/TLS, SSO, OAuth 2.0, OIDC, JWT.
3. **SPA e PWA** — DS-13.2, que quase nenhuma outra prova selecionada cobre.
4. **Redis / NoSQL** — o gancho mais direto do acervo para BD-13 (banco de dados
   em memória).
5. **Raciocínio Lógico** — as 10 questões do Módulo I são quase da sua ementa;
   só não treinam estatística descritiva.

Aproveite também as 10 de Português e as 10 de RL como simulado de Módulo I —
nesse recorte o TCE-RR é tão útil quanto qualquer outra prova FGV do acervo.
