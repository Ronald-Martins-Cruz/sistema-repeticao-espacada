# TJ-RJ 2026 × DATAPREV 2024 — comparação de ementas

Compara a ementa de **Analista Judiciário – TI – Analista de Sistemas** (TJ-RJ,
Edital nº 01/2025, FGV) — [EMENTA.md](EMENTA.md) — com a ementa-alvo de estudo,
**Analista de TI / Perfil 3: Desenvolvimento de Software** (DATAPREV, Edital nº
01/2024, FGV) —
[dataprev-2024/EMENTA.md](../../../../provas-editais-alvo/dataprev/dataprev-2024/EMENTA.md).

> Prova aplicada em **01/02/2026** — é a mais recente do acervo, e a que melhor
> mostra como a banca está escrevendo enunciado hoje. A comparação é contra a
> ementa de **2024**, que é a base de estudo; o alvo real é o edital de 2026, e
> o que mudou está em
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

**Vale mais pela data do que pelo conteúdo.** Aplicada em fevereiro de 2026, é a
amostra mais fresca de como a FGV está formulando questão de TI — e isso, para
quem faz prova em outubro de 2026, é informação que nenhuma outra prova do
acervo dá.

O conteúdo, porém, é o de um **analista de sistemas**, não de um desenvolvedor.
A ementa é larga e rasa: cobre nuvem, redes, sistemas operacionais, governança,
processos de desenvolvimento, OO, banco de dados e a arquitetura PDPJ, mas
quase nada com profundidade de codificação. Os acertos mais valiosos são
**COBIT 2019 e ITIL 4 literais**, **modelagem relacional e dimensional com
operações OLAP**, **OLTP × OLAP**, **PMBOK 7 + Scrum + Kanban** e o bloco PDPJ
(microsserviços, API RESTful, JSON, Spring, Swagger, API Gateway, JPA,
Hibernate, OAuth2, SSO, Git, containers, CI/CD).

Dois furos chamam atenção pelo tamanho: **não há testes de software** — nem
unitários, nem TDD, nem automação, nada — e **não há frontend nenhum**: sem
HTML, CSS, JavaScript, Ajax, React, Angular, Vue, SPA ou PWA.

Some-se que os "40 de Conhecimentos Específicos" incluem **Direito
Constitucional, Direito Administrativo, normativos do CNJ e Código Penal** — o
caderno técnico real é bem menor que 40.

| | |
|---|---|
| Questões específicas | 40 (de 70), com blocos de Direito dentro |
| Blocos da DATAPREV alcançados | 4 de 5 (BI só parcialmente, via OLAP) |
| Cobertura da ementa técnica da DATAPREV | ~45% |
| Aproveitamento estimado das 40 específicas | **~50–55% em N3 ou acima** |
| Posição no acervo | **1º em atualidade da banca**; penúltimo em cobertura |

---

## 🟩 N4 — Idêntico

### Governança — o par mais limpo desta prova

| Tópico no TJ-RJ 2026 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 18 **COBIT 2019** | GOV-5 (Governança de TI – COBIT 2019) | **literal, com versão** |
| 19 **ITIL 4** | GOV-4 (Gerenciamento de serviços – ITIL v4) | **literal, com versão** |
| 1.4 Governança, Metodologias e Gerência de Projetos: **PMBOK 7ª edição, Scrum, Kanban**, ciclo de vida de projetos | GOV-1 (gerenciamento de projetos; abordagem tradicional, híbrida e ágil; Scrum e Kanban) | mesmo rol |
| 17 Mensuração de sistemas em **Pontos de Função** segundo o CPM 4.3.1 do IFPUG | DS-11 (Metodologia de Ponto de Função) | igual, com o manual fixado |

### Banco de dados e análise

| Tópico no TJ-RJ 2026 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 13 **Bancos de dados transacionais (OLTP) e analíticos (OLAP)** | BI-3 (OLAP) + DS-10 (codificação de software: transacionais, analíticos) | par direto com dois itens seus |
| 14 **Modelagem de dados relacional e dimensional. Operações OLAP** | BD-2 (abordagem relacional e multidimensional) + BD-6 (modelagem dimensional) | **literal** |
| 15 **Linguagem SQL** | BD-7 (linguagem de consulta estruturada) | **literal** |
| 16 **Conceitos sobre sistemas gerenciadores de banco de dados**; MySQL, SQL Server, PostgreSQL, Oracle | BD-10 (SGBD) | igual, com produtos |

### Desenvolvimento e arquitetura

| Tópico no TJ-RJ 2026 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 4 **Orientação a objetos.** Conceitos fundamentais, análise, modelagem e **padrões de projeto** | DS-3 (arquitetura e linguagem orientada a objetos) + DS-9 (padrões de desenvolvimento e reuso) | igual |
| 7 **Arquitetura de software.** 7.1 Cliente/servidor, Internet e dispositivos móveis | DS-3 + DS-4 + DS-1 (mobile) | igual |
| 8 **Engenharia de requisitos** | DS-12 | igual |
| 11 **Web Services.** 11.1 Padrões **SOAP e REST** | DS-3 (web services) + DS-5 (REST) | igual |
| 12 Ferramentas de controle de versão. 12.1 **GIT** | DS-7 (Ferramenta de Gestão da configuração GIT) | igual |
| 10 Conceitos de linguagem de programação **Java (versão 17 ou superior)** | DS-1 (Java versão 6 ou superior) | mesma linguagem, versão mais nova |
| 1.5 Segurança da Informação – Fundamentos: **confidencialidade, integridade, disponibilidade**, autenticação e autorização | SEG-3 (confiabilidade, integridade e disponibilidade) + SEG-4 (mecanismos de segurança) | **literal** |
| 22 Arquitetura PDPJ: **microsserviços; API RESTful; JSON; Framework Spring; Spring Cloud; Spring Boot; Swagger; API Gateway; JPA 2.0; Hibernate; Git; Kubernetes; CI/CD** | DS-1 + DS-3 + DS-5 + DS-7 + DS-17 | o bloco mais denso da prova: cada um destes é item seu |
| 22 **SSO Single Sign-On; Protocolo OAuth2 (RFC 6749)** | SEG-4.1 (Controle de acesso. Protocolo OAuth2. SSO) | **literal**, inclusive a RFC |
| 3.1 **Scrum**, Metodologia Ágil | DS-8.1 | igual |

---

## 🟦 N3 — Equivalente

| Tópico no TJ-RJ 2026 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| 2 Conceitos de engenharia de software | DS-1 + DS-16 (design de software) | abertura equivalente |
| 3 Processos de desenvolvimento de software | DS-1 | igual em substância |
| 20 **Desenvolvimento para VMs/Containers e para nuvem** | DS-17 (containers) | containers é seu; VMs e nuvem, não |
| 21 **Práticas DevSecOps** | DS-6 (DevOps) | superconjunto: DevOps com o eixo de segurança |
| 1.6 **LGPD** (Lei nº 13.709/2018 e suas alterações) | Módulo I — Legislação, item 4 | a DATAPREV recorta capítulos; o TJ-RJ cobra a lei inteira |
| 17 Roteiro de Métricas de Software do SISP (versão 2.0) | DS-11 (ponto de função) | roteiro de aplicação da APF no governo federal |
| 1.1 Arquitetura de TI: noções de infraestrutura, banco de dados e aplicações | DS-3 (arquitetura de software) | mais raso e mais largo que o seu item |

---

## 🟨 N2 — Parcial / adjacente

| Tópico no TJ-RJ 2026 | Item da DATAPREV que encosta | Por que só parcial |
|---|---|---|
| 1 **Fundamentos de Computação em Nuvem**: características, modelos, tipos, arquitetura, serviços e aplicações | DS-17 (containers, microsserviços) | a DATAPREV **2024 não cobra nuvem**; só a parte de arquitetura distribuída transfere |
| 5 Padrões de arquitetura **MVC** e **DDD** | DS-3 + DS-16 + DS-17 | mesma família arquitetural, nomes que a sua ementa não usa |
| 6 Ferramentas CASE e **linguagem UML (versão 2.1)** | DS-3 (linguagem OO) + DS-16 | **a DATAPREV 2024 não lista UML** — exercita modelagem OO sem ser item cobrado |
| 3.1 **CMMI-DEV v2.0**, Guia Geral MPS de Software (2024), **RUP** | DS-1 | modelos de maturidade e processo clássico fora da sua ementa |
| 9 Análise de negócios | DS-12 (engenharia de requisitos) + GOV-6 | vizinho de requisitos e de processos, sem item próprio |
| 10 **Microsoft.NET 8+**, **PHP 8+** | DS-1 (Java, JavaEE) | mesma função, pilha fora do seu rol |
| 12.1 **SVN** | DS-7 (GIT) | mesma função, ferramenta não cobrada |
| 22 **Spring Eureka, Zuul; Map Struct; Service Discovery; Hibernate Envers; Flyway; H2 Database; Rancher; GitLab CI/CD** | DS-17 (orquestração de serviços e API gateway) + DS-6 | os conceitos (service discovery, API gateway, CI/CD, orquestração) são seus; os produtos do PDPJ, não |
| 22 **Keycloak; OpenID Connect (OIDC)** | SEG-4.1 (OAuth2, SSO) | implementação e protocolo irmão do que a sua ementa cobra |
| 22 **Mensageria e Webhooks; Message Broker; RabbitMQ; Webhook; APIs reversas; Evento negocial** | DS-3 (interoperabilidade) | a DATAPREV **2024** não cobra mensageria — a **de 2026 passou a cobrar** ("Web services. Mensageria. API, Swagger."), então este conteúdo sobe de nível para o alvo real |
| 22 **Docker** | DS-17 (containers) | produto do conceito que a sua ementa cobra |
| 16.1 Versões de SGBD: SQL Server 2019, PostgreSQL 17+, Enterprise Manager 13c, Oracle 23ai | BD-10 | versão e produto, não conceito |

---

## 🟧 N1 — Tangencial

| Tópico no TJ-RJ 2026 | Observação |
|---|---|
| 1.2 **Redes de Computadores** – Noções: modelo OSI e protocolo TCP/IP | Base de rede sob DS-4 (ambientes internet/intranet) e DS-14 (HTTPS/SSL), mas não é item seu |
| 1.3 **Sistemas Operacionais** – Noções: processos, memória, entrada e saída | Fora da sua ementa; só serve como fundo conceitual |

---

## ⬜ N0 — Sem relação

- **Legislação Especial** (Lei Estadual nº 10.633/2024; Decreto-Lei nº 220/1975; Decreto nº 2.479/1979; Lei Estadual nº 9.748/2022; Código de Normas da CGJ; Regimento Interno do TJRJ; Resolução Órgão Especial nº 3/2025)
- **Noções dos Direitos das Pessoas com Deficiência** (Leis nº 13.146/2015, nº 10.098/2000, nº 10.048/2000)
- **Ética no Serviço Público** (Lei nº 8.429/1992; Lei nº 12.846/2013; Resolução Órgão Especial nº 15/2023)
- **Noções de Direito Constitucional** e **Noções de Direito Administrativo** — dentro dos 40 de Conhecimentos Específicos
- **Legislação: normativos PDPJ-Br** (Resoluções CNJ nº 522/2023, nº 335/2020, nº 396/2021; Portarias CNJ nº 252/2020, nº 253/2020, nº 131/2021, nº 162/2021) e **Código Penal**
- Língua Portuguesa (20 questões) — **atenção: esta é a exceção do acervo.** O TJ-RJ abandonou o texto-base histórico da FGV e adotou uma ementa de Português no estilo Cebraspe (ortografia, coesão, morfossintaxe, concordância, colocação pronominal, reescritura). **Não serve** como simulado do seu Módulo I, que segue o modelo antigo

---

## O que esta prova **não** cobre da sua ementa

**Testes de software — o bloco inteiro (DS-7):**
- **Testes unitários, de integração, ágeis, de usabilidade, automatizados**, tipos de testes, **TDD**, gestão do ciclo de vida de testes — **nada disso está no TJ-RJ**. É o furo mais grave

**Frontend — o bloco inteiro (DS-13):**
- **HTML, CSS, JavaScript, Ajax**, frameworks **VueJS/Angular/React**, **padrões de frontend**, **SPA e PWA**, **UX** — ausentes

**Desenvolvimento:**
- **JavaEE, JakartaEE, JSF, Primefaces, JUnit** — ausentes (só Java + o Spring do PDPJ)
- **Análise estática de código-fonte: clean code e SonarQube** (DS-2) — ausente
- **Ferramentas low-code e no-code** — ausentes
- **Ambientes Internet, extranet, intranet e portal** (DS-4) — ausente
- **Padrões XML, XSLT e UDDI** (DS-5) — ausentes (só JSON, SOAP e REST)
- **DevOps puro** (DS-6) — só DevSecOps
- **XP e Kanban como rol de ágeis** (DS-8.2, 8.3) — Kanban aparece em gerência de projetos; XP, não
- **RPA** (DS-7.3), **story points** (DS-11), **blockchain** (DS-15), **arquitetura hexagonal** (DS-17), **transações distribuídas** (DS-18) — ausentes
- **Servidor de aplicações e servidor web** (DS-3) — ausentes como item
- **UX, CMS, arquitetura de informação, portais corporativos, workflow, acessibilidade e usabilidade, desenho de interação** (DS-19 inteiro) — ausentes
- **IA, análise de dados e Big Data** (DS-20) — ausentes

**Banco de dados — a ementa do TJ-RJ é surpreendentemente magra:**
- **Normalização** (BD-3), **integridade referencial** (BD-4), **metadados** (BD-5), **DDL e DML** como itens (BD-8, BD-9), **propriedades ACID** (BD-11), **NoSQL** (BD-12), **banco de dados em memória** (BD-13), **data lakes e big data** (BD-14), **dados estruturados e não estruturados** (BD-15), **avaliação de modelos de dados** (BD-16), **ETL/ELT e ingestão** (BD-17) — todos ausentes

**Business Intelligence — quase tudo:**
- Sobrevivem OLAP e modelagem dimensional (ver N4). Ausentes: **conceitos e fundamentos de BI** (BI-1), **sistemas de suporte a decisão e gestão de conteúdo** (BI-2), **data warehouse e ETL** (BI-3), **data mining** (BI-4), **visualização de dados: BD individuais e cubos** (BI-5), **mapeamento das fontes de dados** (BI-6), **arquitetura de BI** (BI-7)

**Segurança da informação:**
- **Políticas de SI** (SEG-1), **procedimentos e gerenciamento** (SEG-2), **ISO 27001:2022 e 27002:2022** (SEG-3), **gerência de riscos: ameaça, vulnerabilidade e impacto** (SEG-5), **SDL e OWASP Top 10** (SEG-6), **SAST e DAST** (SEG-7) — ausentes. Sobrou só o tripé CID e OAuth2/SSO
- **Protocolos HTTPS, SSL/TLS** (DS-14) — ausentes

**Governança:**
- **BPMN e gestão/modelagem de processos de negócio** (GOV-6) — ausente
- **Gestão de riscos** (GOV-3) — ausente

**Módulo I:**
- **Língua Inglesa**, **Raciocínio Lógico**, **Atualidades** — ausentes
- Legislação: **LAI**, **Decretos 7.724/7.845**, **Delitos Informáticos**, **Marco Civil** — ausentes
- **Língua Portuguesa** existe, mas em outro modelo de ementa (ver N0)

---

## Veredito

**Use esta prova por último, e use-a como termômetro de estilo, não como
simulado de conteúdo.** É a prova mais recente do acervo — 01/02/2026, oito
meses antes da sua — e a única que mostra o formato de enunciado que a FGV está
usando agora. Esse é o seu valor principal.

Vá atrás especificamente das questões de:

1. **COBIT 2019 e ITIL 4** — os dois pares mais limpos do acervo para GOV-4 e
   GOV-5, com a versão exata da sua ementa.
2. **OLTP × OLAP, modelagem relacional e dimensional, operações OLAP** — casam
   com BD-2, BD-6 e BI-3.
3. **O bloco 22 (arquitetura PDPJ)** — microsserviços, API RESTful, JSON,
   Spring/Cloud/Boot, Swagger, API Gateway, JPA, Hibernate, OAuth2, SSO, Git,
   Kubernetes, CI/CD. É onde estão as questões mais parecidas com a sua prova.
4. **Pontos de função (CPM 4.3.1 do IFPUG)** — DS-11 com o manual nomeado.
5. **PMBOK 7 + Scrum + Kanban** — GOV-1.

Ressalvas ao simular:

1. **Não use as 20 de Língua Portuguesa.** O TJ-RJ trocou o texto-base histórico
   da FGV por uma ementa de outro estilo. Suas 12 questões de Português seguem o
   modelo antigo, que está preservado em ALEP, TJ-AP, TJ-RR, DPE-RO, MPU e
   TCE-RR — use qualquer uma dessas.
2. **Ela não te testa em teste nem em frontend.** Dois blocos inteiros do seu
   edital passam em branco.
3. **Descarte de saída** Direito Constitucional, Direito Administrativo, os
   normativos do CNJ e o Código Penal — estão dentro dos "40 específicos", mas
   não são TI.
