# TJ-AP 2024 × DATAPREV 2024 — comparação de ementas

Compara a ementa de **Analista Judiciário – Apoio Especializado – TI –
Desenvolvimento de Sistemas** (TJ-AP, Edital nº 01/2023, FGV) —
[EMENTA.md](EMENTA.md) — com a ementa-alvo de estudo, **Analista de TI / Perfil
3: Desenvolvimento de Software** (DATAPREV, Edital nº 01/2024, FGV) —
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

**É a prova mais próxima da sua na pilha tecnológica concreta — e a que mais
dispersa em conteúdo que você não estuda.**

O TJ-AP acerta o núcleo Java/Spring/JPA/Hibernate/JUnit com nomes idênticos aos
do seu edital, e traz um par literal raro: o rol **"Padrões XML, XSLT, UDDI,
WSDL, SOAP e REST"** é o mesmo item DS-5 da DATAPREV, só com WSDL e SOAP a mais.
Também é forte em interoperabilidade, microsserviços, API Gateway, Swagger,
OAuth2/SSO e OWASP.

Em troca, uma parte substancial das 40 questões cai em terreno que não é seu:
**fundamentos de computação, estruturas de dados e algoritmos, sistemas
operacionais (Windows/CentOS/Ubuntu), redes, firewalls e VPN**. E o edital tem
**dois blocos de conteúdo repetido** — a lista da arquitetura PDPJ (Spring
Cloud, Eureka, Zuul, Keycloak, Rancher, RabbitMQ…) aparece duas vezes, o que dá
uma pista clara de onde a banca concentrou as questões.

Buraco maior: **não há Business Intelligence nem NoSQL** — nem DW, nem OLAP, nem
data mining, nem ETL.

| | |
|---|---|
| Questões específicas | 40 (de 80) |
| Blocos da DATAPREV alcançados | 4 de 5 (**sem BI**) |
| Cobertura da ementa técnica da DATAPREV | ~60% |
| Aproveitamento estimado das 40 específicas | **~55–60% em N3 ou acima** |
| Posição no acervo | **1º na pilha Java/Spring e em padrões de web services** |

---

## 🟩 N4 — Idêntico

### Pilha de desenvolvimento e integração

| Tópico no TJ-AP 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| **Padrões XML, XSLT, UDDI, WSDL, SOAP e REST** | DS-5 (Padrões XML, XSLT, UDDI, REST e JSON) | **rol literal**, com WSDL e SOAP a mais |
| **JSON** | DS-5 | **literal** |
| Programação: **Java**, **JavaScript**, HTML 5, CSS3 e **Git** | DS-1 + DS-13 + DS-7 | interseção direta |
| Frameworks e toolkits: **Angular, React, Spring, Spring Boot, Hibernate, JPA, JUnit** | DS-1 + DS-13 | **todos os sete estão na sua ementa**, com os mesmos nomes |
| Framework **Spring**; **Spring Cloud**; **Spring Boot**; **Swagger**; **API Gateway**; Persistência; **JPA 2.0**; **Hibernate** 4.3 ou superior | DS-1 + DS-3 + DS-17 | mesma pilha, com versões fixadas |
| Interoperabilidade de sistemas: **Arquitetura Orientada a Serviços (SOA)** e **Web Services** | DS-3 (interoperabilidade, arquitetura e linguagem orientada a serviços, web services) | **literal** |
| **Arquitetura distribuída de microsserviços**; **API RESTful** | DS-17 (microsserviços, API gateway) + DS-5 (REST) | igual |
| **Análise e projeto orientados a objetos** | DS-3 (arquitetura e linguagem orientada a objetos) | igual |
| **Metodologias ágeis** | DS-8 | igual (o TJ-AP não abre em Scrum/Kanban/XP) |
| **Análise de Pontos de Função** | DS-11 (Metodologia de Ponto de Função) | **literal** |
| **Engenharia de requisitos. Técnicas de elicitação de requisitos.** Gerenciamento de requisitos. Especificação. Técnicas de validação. Prototipação | DS-12 (12.1–12.3) | **rol literal**, com validação e prototipação a mais |
| **Técnicas de testes de software** | DS-7 (bloco TESTES) | igual |
| **Padrões de projeto** | DS-9 (padrões de desenvolvimento e reuso) | igual em substância |
| **Ferramenta e protocolo de versionamento Git** | DS-7 (Ferramenta de Gestão da configuração GIT) | **literal** |

### Segurança

| Tópico no TJ-AP 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Principais vulnerabilidades e remediações (**OWASP Top Ten**). OWASP | SEG-6 (OWASP Top 10) | **literal** |
| Serviços de autenticação: **SSO Single Sign-On**; **Protocolo OAuth2 (RFC 6749)** | SEG-4.1 (Controle de acesso. Protocolo OAuth2. SSO) | **literal**, inclusive a RFC |
| **Gerência de Riscos** | SEG-5 | **literal** |
| **Controles de acesso** físico e lógico | SEG-4.1 (controle de acesso) | igual (a parte física é extra) |
| **Segurança da Informação** (bloco) | SEG (bloco) | mesma disciplina |
| **Lei Geral de Proteção de Dados Pessoais: conceitos básicos** | Módulo I — Legislação, item 4 | igual, sem o recorte de capítulos |

### Banco de dados

| Tópico no TJ-AP 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| **Modelagem de dados, conceitual e semântica. Modelo de Entidades e Relacionamentos** | BD-1 | igual |
| Sistema relacional: teoria, estrutura, linguagens, operações, **normalização, integridade** | BD-2 + BD-3 + BD-4 | igual |
| Projeto de bancos de dados: teoria. Dependências funcionais. **Normalização** | BD-3 | igual |
| **Linguagem SQL. Consultas e subconsultas. Comandos de consulta, inserção, alteração e remoção de registros** | BD-7 + BD-8 + BD-9 | igual |
| **Gerenciadores de bancos de dados** | BD-10 (SGBD) | igual |

---

## 🟦 N3 — Equivalente

| Tópico no TJ-AP 2024 | Item na DATAPREV 2024 | Observação |
|---|---|---|
| Princípios de **DevOps**, DevSecOps | DS-6 (DevOps) | igual, com DevSecOps a mais |
| Deploy de aplicações: **Continuous Delivery e Continuous Integration (CI/CD)** | DS-6 | prática do DevOps que a sua ementa cobra em conceito |
| Ambiente de clusters, **Kubernetes**. Ferramenta de orquestração de contêineres, **Rancher** | DS-17 (containers) | a DATAPREV diz "containers"; o TJ-AP nomeia os produtos |
| Segurança no desenvolvimento: práticas de programação segura e revisão de código; controles e testes de segurança para aplicações web e para Web Services | SEG-6 (SDL) + SEG-7 (SAST/DAST) | mesmo território de desenvolvimento seguro; o TJ-AP não nomeia SAST/DAST |
| Classificação e controle dos ativos de informação; gestão de incidentes de segurança; Plano de Continuidade de Negócio (contingência, recuperação de desastres) | SEG-3 (ISO 27001:2022 e 27002:2022) | são exatamente controles da ISO 27002 — a sua ementa cobra a norma, o TJ-AP cobra os controles sem citá-la |
| **Engenharia de usabilidade** | DS-19 (UX) + DS-19.1.6 (usabilidade) | igual em substância |
| **Aplicações Web** | DS-3 (arquitetura de aplicações para ambiente web) | igual |
| Frameworks de arquitetura – Conceitos | DS-3 (arquitetura de software) | igual em substância |
| Camadas de persistência; ODBC | DS-1 (JPA, Hibernate) | a camada que JPA/Hibernate implementam |
| **GESTÃO DE TI: Gerenciamento de projetos (PMBOK 7ª Edição)** | GOV-1 + GOV-2 | a DATAPREV pede conceitos, áreas de conhecimento e grupos de processos sem nomear o PMBOK; o conteúdo é o mesmo |
| Metodologias de desenvolvimento de software; qualidade de software | DS-1 + DS-8 | abertura genérica equivalente |
| Língua Portuguesa (25 questões) | Módulo I — Língua Portuguesa | mesmo texto-base da FGV; o TJ-AP troca "Norma culta" por "Norma padrão" e "Registros de linguagem" por "Variação linguística" |

---

## 🟨 N2 — Parcial / adjacente

| Tópico no TJ-AP 2024 | Item da DATAPREV que encosta | Por que só parcial |
|---|---|---|
| **Mensageria e Webhooks; Message Broker; RabbitMQ; Webhook; APIs reversas; Evento negocial** | DS-3 (interoperabilidade) | a DATAPREV **2024** não cobra mensageria — a **de 2026 passou a cobrar** ("Web services. Mensageria. API, Swagger."), então este conteúdo sobe de nível para o alvo real. Cobrado duas vezes no edital do TJ-AP |
| **Spring Eureka, Zuul; Map Struct; Service Discovery**; Hibernate Envers; Biblioteca Flyway | DS-17 (orquestração de serviços e API gateway) | Service Discovery e API Gateway são conceitos seus; os produtos específicos do PDPJ, não |
| **Keycloak** | SEG-4.1 (SSO, OAuth2) | implementação do que a sua ementa cobra em protocolo |
| **C#, Python, NodeJS, JQuery, Django** | DS-1 + DS-13 | mesma família (linguagem/framework), fora do seu rol |
| PostgreSQL 9.2; H2 Database; Oracle 11g, MS SQL Server 2019, MySQL 5.x | BD-10 (SGBD) | produto e versão; o conceito de SGBD é seu, a versão não |
| Processo unificado: disciplinas, fases, papéis e atividades (**RUP**) | DS-1 | processo clássico não cobrado na sua ementa |
| Métricas e estimativas de software; **SNAP** (Processo de Avaliação não Funcional) | DS-11 (ponto de função) | complemento não funcional da APF, fora da sua ementa |
| **UML 2.5.1**: visão geral, modelos e diagramas | DS-3 (linguagem OO) + DS-16 (design de software) | **a DATAPREV 2024 não lista UML** — exercita modelagem OO sem ser item cobrado |
| **Criptografia simétrica e assimétrica. Assinatura e certificação digital** | DS-14 (HTTPS, SSL/TLS) | é o substrato do TLS; a sua ementa cobra o protocolo, não a criptografia |
| **IaC (Infrastructure as Code)** | DS-6 (DevOps) | prática de DevOps não nomeada na sua ementa |
| Noções de computação distribuída: clusters, balanceamento de carga e tolerância a falhas | DS-17 + DS-18 (transações distribuídas) | vizinho direto de microsserviços e transações distribuídas |
| Tipos de ataques e proteções relativos a **aplicações e bancos de dados** | SEG-6 (OWASP) | a parte de aplicação/BD aproveita; a de hardware, SO, redes e ambiente físico não |
| **Notação IDEF1X** | BD-1 (modelagem conceitual) | notação de modelagem alternativa ao MER, não cobrada |
| Algoritmos de busca e indexação: sequenciais, árvores, hashing, bitmaps | BD-10 (SGBD) | estrutura interna de índices, um nível abaixo do que sua ementa pede |
| Interfaces de utilização: propriedades e características das bibliotecas mais difundidas | DS-13 | genérico demais para casar com item específico |

---

## 🟧 N1 — Tangencial

| Tópico no TJ-AP 2024 | Observação |
|---|---|
| Fundamentos de Computação: conhecimentos de linguagens de programação, compiladores e interpretadores; noções de linguagens procedurais; tipos de dados elementares e estruturados; funções e procedimentos | Base conceitual de DS-1, mas a sua ementa nunca cobra compilador nem tipo elementar |
| Estruturas de dados e algoritmos: listas, filas, pilhas, árvores; busca, inserção e ordenação; complexidade de algoritmos | Sua ementa não cobra algoritmos. Encosta em DS-10 (codificação de software) e só |
| Representação de dados numéricos, textuais e estruturados; aritmética computacional | Idem |
| Monitoramento e Auditoria de tráfego de Informação | Operação de segurança, fora do seu recorte |

---

## ⬜ N0 — Sem relação

- **Organização básica de computadores. Componentes de um computador (hardware e software)**
- **Sistemas operacionais**: Windows 10, Windows 11, Linux CentOS 7, CentOS 8, Ubuntu 20.04 LTS
- **Arquiteturas e dispositivos de segurança: firewalls, VPN e outros**; ataques a hardware, sistemas operacionais, redes, pessoas e ambiente físico
- Legislação Específica (Constituição do Amapá; Regime Jurídico dos Servidores do Amapá; Lei de Organização Judiciária; Regimento Interno do TJ-AP)
- Noções de Direito Constitucional e Administrativo (15 questões)
- Resoluções e Portarias do CNJ (nº 91/2009, nº 335/2020, nº 252/2020, nº 253/2020, nº 131/2021, nº 396/2021, nº 162/2021)

---

## O que esta prova **não** cobre da sua ementa

**Business Intelligence — o bloco inteiro:**
- Conceitos e arquitetura de BI, sistemas de suporte a decisão, **Data Warehouse**, **OLAP**, **data mining**, **modelagem multidimensional**, **ETL**, visualização de dados, mapeamento de fontes — **nada disso está no TJ-AP**

**Banco de dados:**
- **NoSQL** (BD-12) — ausente, apesar da ementa de BD ser longa
- **Banco de dados em memória** (BD-13), **data lakes e big data** (BD-14), **metadados** (BD-5), **modelagem dimensional** (BD-6), **abordagem multidimensional** (BD-2), **dados estruturados e não estruturados** (BD-15), **avaliação de modelos de dados** (BD-16), **ETL/ELT e ingestão** (BD-17) — ausentes

**Desenvolvimento:**
- **JavaEE, JakartaEE, JSF, Primefaces** — ausentes (o TJ-AP fica em Java 8 + Spring)
- **Vue** — ausente do rol de frameworks frontend
- **Análise estática de código-fonte: clean code e SonarQube** (DS-2) — ausente
- **SAST e DAST** nomeados (SEG-7) — ausentes
- **Ferramentas low-code e no-code** — ausentes
- **Desenvolvimento para dispositivos móveis (Android e iOS)** — ausente
- **Ambientes Internet, extranet, intranet e portal** (DS-4) — ausente
- **Servidor de aplicações e servidor web** (DS-3) — ausentes como item
- **RPA** (DS-7.3) — ausente
- **Story points** (DS-11) — ausente (só APF)
- **SPA e PWA**, **padrões de frontend**, **Ajax**, **UX como item** (DS-13, DS-13.1, DS-13.2) — ausentes
- **Blockchain** (DS-15) — ausente
- **Arquitetura hexagonal** (DS-17) — ausente
- **Transações distribuídas** (DS-18) — ausente
- **CMS, arquitetura de informação, portais corporativos, workflow, desenho de interação** (DS-19.1) — ausentes
- **IA, análise de dados e Big Data** (DS-20) — ausentes

**Segurança e governança:**
- **ISO 27001:2022 e 27002:2022** nomeadas (SEG-3) — ausentes
- **Políticas de segurança da informação** (SEG-1) — ausente
- **ITIL v4** (GOV-4), **COBIT 2019** (GOV-5), **BPMN e gestão de processos de negócio** (GOV-6), **gestão de riscos** (GOV-3), **abordagens tradicional/híbrida/ágil e Guia Scrum** (GOV-1) — ausentes. Só o PMBOK sobrevive

**Módulo I:**
- **Língua Inglesa**, **Raciocínio Lógico**, **Atualidades** — ausentes
- Legislação: **LAI**, **Decretos 7.724/7.845**, **Delitos Informáticos**, **Marco Civil** — ausentes

---

## Veredito

**Use esta prova para calibrar a pilha Java e os padrões de web services.** É a
prova do acervo cuja lista de frameworks mais se parece com a sua — Spring,
Spring Boot, Spring Cloud, Hibernate, JPA, JUnit, Angular, React, todos com os
mesmos nomes do seu edital — e traz o único par literal do acervo para o item
DS-5 (XML, XSLT, UDDI, REST, JSON).

Vá atrás especificamente das questões de:

1. **Padrões XML/XSLT/UDDI/WSDL/SOAP/REST e JSON** — casam item a item com DS-5.
2. **SOA, web services, microsserviços, API RESTful, API Gateway, Swagger** —
   DS-3 e DS-17 com boa profundidade.
3. **Spring, Spring Boot, JPA, Hibernate, JUnit** — DS-1, com a ressalva de que o
   TJ-AP não cobra JSF nem Primefaces.
4. **OWASP Top Ten, OAuth2 (RFC 6749), SSO, gerência de riscos** — quatro pares
   literais com o seu bloco de segurança.
5. **Engenharia de requisitos** — o rol do TJ-AP é mais completo que o seu e
   cobre DS-12 inteiro.

Ressalvas ao simular:

1. **Descarte de saída** as questões de fundamentos de computação, estruturas de
   dados, algoritmos, sistemas operacionais, redes, firewall e VPN — é uma fatia
   grande das 40 e nada disso é item seu.
2. **Ela não te testa em dados analíticos.** Sem BI e sem NoSQL, um bom resultado
   aqui não diz nada sobre dois blocos inteiros do seu edital.
3. **A repetição da lista PDPJ no edital não é erro de transcrição** — o bloco
   Spring Cloud / Eureka / Zuul / Keycloak / RabbitMQ / Rancher / CI-CD aparece
   duas vezes de propósito. Trate essas questões como N2: o conceito
   (service discovery, API gateway, mensageria, orquestração) vale; a ferramenta
   nomeada, não.
