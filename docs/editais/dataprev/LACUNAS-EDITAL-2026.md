# Lacunas de cobertura — Edital DATAPREV 2026 vs. `perguntas.md`

Relatório dos conceitos exigidos pelo **Anexo I do `edital-dataprev-2026.pdf`**
(Perfil 3 — Desenvolvimento de Software, e Módulo I) que **não têm nenhuma
pergunta** no banco atual de 242.

## Por que existem lacunas

O banco foi construído por engenharia reversa da prova de 2024: as perguntas
ancoravam em **exatamente as 35 questões** do módulo específico daquela prova
(Q36–Q70), sem sobra nem falta. Isso calibra muito bem a *dificuldade*, mas o
*escopo* ficou preso ao que aquela prova sorteou. A FGV escreve para o edital,
não para a prova anterior.

A seção 2.25 (X.800), que cobria a questão Q64 da prova de 2024, foi removida do
repositório por não constar do edital de 2026 — as 242 perguntas restantes
ancoram em 34 das 35 questões.

## Método

Cada subitem do Anexo I foi testado por busca de termos em `perguntas.md`, e
todo positivo foi conferido no contexto da frase. Menções incidentais foram
descartadas — por exemplo, `redis` casou com "**redis**tribuir" (Q150),
`metadado` com a nota de formato do cabeçalho do arquivo, e `consentimento`
apenas com o enunciado de um caso de Marco Civil (Q25), não com as bases legais
da LGPD.

Contagem por **subitem de ementa**, não por questão de prova.

## Resumo

| Disciplina (Perfil 3) | Subitens cobertos | Cobertura |
|---|:--:|:--:|
| Inteligência de Negócios (BI) | 7 / 10 | 70% |
| Desenvolvimento de Sistemas | 19 / 43 | 44% |
| Banco de Dados | 5 / 17 | 29% |
| Segurança da Informação | 2 / 10 | 20% |
| Gestão e Governança de TI | 2 / 10 | 20% |
| **Total** | **35 / 90** | **~39%** |

O Módulo II vale 30 questões × 2,5 = **75 dos 115 pontos** da prova (65% da
nota). É onde a classificação se decide, e é onde a cobertura é menor.

---

# 1. Desenvolvimento de Sistemas

## 1.1 Não coberto — item 1 (linguagens e frameworks)

- **JavaEE / JakartaEE / JPA** — o edital pede Java EE 6+, JakartaEE e JPA 2+.
  O banco tem Spring, Boot, Cloud, Hibernate e JUnit, mas nada da plataforma
  corporativa em si.
- **JSF e Primefaces** — nomeados no edital, ausentes no banco.
- **JavaScript como linguagem** — só aparece como "frameworks JavaScript" num
  distrator de PWA (Q133).
- **Ferramentas low-code e no-code** — nenhuma menção.

## 1.2 Não coberto — item 2 (análise estática)

- **Clean code** — princípios, nomeação, funções, code smells.
- **SonarQube** — nomeado explicitamente no edital.

Item inteiro sem cobertura. Reaparece no item 8 de Segurança (SAST/DAST).

## 1.3 Não coberto — item 3 (arquitetura e interoperabilidade)

- **Mensageria** — filas, tópicos, publish/subscribe, entrega garantida.
- **API e Swagger/OpenAPI** — especificação e documentação de contrato de API.

Coberto neste item: web services, SOA, REST, SOAP, OO, servidor web x servidor
de aplicações.

## 1.4 Não coberto — item 5 (padrões)

- **UDDI** — registro e descoberta de serviços. O banco cobre XML, XSLT, JSON e
  REST, e cobre WSDL (Q101), mas não UDDI, que o edital nomeia.

## 1.5 Não coberto — item 7 (GIT e testes)

- **GIT** — o edital nomeia a ferramenta de gestão de configuração. O banco tem
  "controle de versão" só como conceito genérico dentro de DevOps (Q170), e a
  palavra "commit" aparece uma vez, num caso de esteira CI (Q173). Nada de
  branching, merge, rebase, conflitos ou fluxos de trabalho.
- **Testes ágeis** — quadrantes de Agile Testing, papel do teste no Sprint.
- **Gestão do ciclo de vida de testes** — plano de teste, caso de teste, suíte,
  rastreabilidade, gestão de defeitos.
- **Tipos de testes** — o banco cobre unitário, integração e usabilidade; faltam
  sistema, aceitação, regressão, fumaça, carga, estresse, caixa-branca/preta.
- **RPA (item 7.1)** — automação robótica de processos, sem nenhuma menção.

## 1.6 Não coberto — item 9 (padrões de desenvolvimento e reuso)

Item inteiro. Nenhuma pergunta sobre **padrões de projeto** — nem GoF
(Singleton, Factory, Observer, Strategy, Facade…), nem a classificação
criacional/estrutural/comportamental, nem **reuso** como disciplina.

Vale notar que "definição de padrões de desenvolvimento e reuso" está na
descrição de atribuições do cargo (Anexo II, p. 46 do edital).

## 1.7 Não coberto — item 10 (codificação de software)

Codificação de software **transacional, analítico, mobile e de API** como
categorias com características próprias. Mobile está coberto pela seção 2.10;
as outras três não.

## 1.8 Não coberto — item 13 (frontend web)

- **HTML** e **CSS** — nenhuma menção.
- **Ajax** — requisição assíncrona, XMLHttpRequest/fetch.
- **VueJS, Angular e React** (web) — "React" só aparece como *React Native*, em
  contexto mobile (Q124, Q126).
- **Padrões de frontend (13.1)** — componentização, gerenciamento de estado,
  renderização no cliente x no servidor (CSR/SSR).

Coberto neste item: apenas 13.2 (SPA e PWA), que tem 8 perguntas.

## 1.9 Não coberto — item 17 (parcial)

- **Orquestração de serviços** e **API Gateway** — nenhuma menção.
- **Containers** — Docker, Kubernetes, imagem x contêiner, orquestração.

Coberto: arquitetura hexagonal e microsserviços (seção 2.17).

## 1.10 Não coberto — item 18 (transações distribuídas)

Item inteiro. Padrão **SAGA**, coreografia x orquestração, **two-phase commit**,
compensação, idempotência. A Q188 pergunta como manter consistência entre
serviços sem banco compartilhado, mas sem nomear nenhum desses mecanismos.

## 1.11 Não coberto — item 19 (UX e gestão de conteúdo)

Bloco quase inteiro:

- **User Experience (UX)** como disciplina.
- **Sistemas de gestão de conteúdo (CMS)** — 19.1, conceitos e aplicações.
- **Arquitetura da informação** — 19.1.2.
- **Workflow** — 19.1.5.
- **Acessibilidade e usabilidade** — 19.1.6. A palavra "usabilidade" aparece uma
  única vez no banco, em *teste* de usabilidade (Q139), que é outra coisa: ali é
  técnica de verificação, aqui é requisito de projeto (WCAG, e-MAG, heurísticas
  de Nielsen).
- **Desenho e planejamento de interação em aplicações web** — 19.1.7.

Coberto: apenas **portais corporativos** (19.1.3), via Q91.

## 1.12 Não coberto — item 20 (parcial)

- **Análise de Dados** e **Big Data** — volume/velocidade/variedade, Hadoop,
  Spark, processamento em lote x streaming.

Coberto: conceitos de IA (seção 2.18).

---

# 2. Inteligência de Negócios (BI)

A área mais bem coberta do banco. Faltam três pontos:

- **Gestão de conteúdo** (item 2) — o edital acopla "sistemas de suporte a
  decisão **e gestão de conteúdo**". O SSD está coberto (seção 2.21); gestão de
  conteúdo não, e reaparece no item 19.1 de Desenvolvimento.
- **Data mining** (item 4) — nenhuma menção. Nem o conceito, nem as tarefas
  (classificação, agrupamento, associação, regressão), nem CRISP-DM.
- **Visualização de dados** (item 5) — cubos estão cobertos (Q220, Q221), mas
  "visualização de dados" e construção de dashboards não. A palavra "dashboard"
  aparece só como distrator do que o ETL **não** faz (Q198).

---

# 3. Segurança da Informação

A disciplina mais descoberta em proporção. Coberto: apenas controle de acesso
(seção 2.23) e OWASP Top 10 (seção 2.24).

## 3.1 Não coberto — item 1

**Políticas de segurança da informação** — estrutura, PSI, normas e
procedimentos, papéis e responsabilidades.

## 3.2 Não coberto — item 2

**Procedimentos de segurança e conceitos gerais de gerenciamento** — SGSI, ciclo
de melhoria, controles.

## 3.3 Não coberto — item 3

**ABNT NBR ISO/IEC 27001:2022** e **ABNT NBR ISO/IEC 27002:2022** — item inteiro.
Estrutura da norma, requisitos do SGSI, os 93 controles da 27002:2022 e seus
4 temas (organizacional, pessoas, físico, tecnológico), atributos de controle.

Este é o item que substituiu, na prática, a arquitetura X.800 cobrada em 2024 e
já retirada do repositório.

## 3.4 Não coberto — item 4

**Confidencialidade, integridade e disponibilidade** — a tríade CID e seus
desdobramentos (autenticidade, irretratabilidade, legalidade).

## 3.5 Não coberto — item 5.1 (parcial)

- **Protocolo OAuth2** — fluxos (authorization code, client credentials),
  papéis, tokens.
- **SSO (Single sign-on)** — e por tabela SAML, OpenID Connect, federação.

Coberto: DAC, MAC, RBAC, ABAC e privilégio mínimo.

## 3.6 Não coberto — item 6

**Gerência de riscos** — ameaça, vulnerabilidade e impacto (6.1), probabilidade,
risco residual, tratamento (aceitar/mitigar/transferir/evitar).

## 3.7 Não coberto — item 7 (parcial)

**SDL — Security Development Lifecycle** — ciclo de vida de desenvolvimento
seguro, modelagem de ameaças, security gates.

Coberto: OWASP Top 10:2021 (8 perguntas).

## 3.8 Não coberto — item 8

**SAST** e **DAST** — análise estática e dinâmica de código, o que cada uma
detecta e em que fase da esteira entra. Conecta com o item 2 de Desenvolvimento
(SonarQube).

---

# 4. Banco de Dados

O item mais extenso do edital (17 subitens) e um dos menos cobertos. O banco
trata banco de dados quase só pelo ângulo analítico (OLAP, NoSQL, ACID/CAP),
herdado das questões Q65 e Q66 de 2024. O ângulo **relacional** está vazio.

## 4.1 Não coberto — item 1

**Modelagem de dados conceitual, lógica e física** — MER, diagrama
entidade-relacionamento, cardinalidade, entidade fraca, generalização, mapeamento
para o modelo relacional.

## 4.2 Não coberto — item 3

**Normalização** — dependência funcional, 1FN, 2FN, 3FN, BCNF, anomalias de
inserção/atualização/exclusão, desnormalização e quando ela se justifica.

Assunto clássico de FGV. Zero perguntas.

## 4.3 Não coberto — item 4

**Integridade referencial** — chave primária, chave estrangeira, chave candidata,
restrições, ações referenciais (CASCADE, RESTRICT, SET NULL), integridade de
entidade e de domínio.

## 4.4 Não coberto — item 5

**Metadados** — dicionário de dados, catálogo do SGBD, metadados técnicos x de
negócio, linhagem.

## 4.5 Não coberto — item 6

**Modelagem dimensional** — esquema estrela, floco de neve, tabela fato x tabela
dimensão, granularidade, slowly changing dimensions.

O banco define dimensão, métrica e agregação (Q221) no plano conceitual, mas não
a modelagem em si.

## 4.6 Não coberto — itens 7, 8 e 9

- **SQL** — a palavra só aparece dentro de "NoSQL". Nenhuma pergunta sobre
  SELECT, JOIN (inner/left/right/full), GROUP BY, HAVING, subconsultas, funções
  de agregação, window functions.
- **DDL** — CREATE, ALTER, DROP, TRUNCATE.
- **DML** — INSERT, UPDATE, DELETE, e a fronteira DML/DDL/DCL/TCL.

Três subitens do edital, cobertura nula. Provavelmente a maior lacuna isolada do
banco inteiro.

## 4.7 Não coberto — item 10

**SGBD** — arquitetura, independência de dados, esquemas (interno/conceitual/
externo), controle de concorrência, transações, índices, otimizador.

## 4.8 Não coberto — item 13

**Banco de dados em memória** — Redis, Memcached, persistência, casos de uso.

## 4.9 Não coberto — item 15

**Dados estruturados x não estruturados**. Atenção à armadilha: as Q213 e Q214
falam de **problemas** estruturados/semiestruturados/não estruturados, que é
taxonomia de SSD (Gorry & Scott Morton) — conceito diferente, que compartilha o
vocabulário. Não serve de cobertura.

## 4.10 Não coberto — item 16

**Avaliação de modelos de dados** — critérios de qualidade, revisão, aderência
aos requisitos.

## 4.11 Coberto (para referência)

Item 2 (relacional x multidimensional), 11 (ACID/BASE/CAP), 12 (NoSQL e seus
tipos), 14 (data lake, via Q203 — parcial, sem soluções de big data), 17
(ETL/ELT).

---

# 5. Gestão e Governança de TI

Disciplina inteira do Perfil 3 que o banco não previa. O que existe hoje é a
seção 2.13, que cobre metodologias ágeis pelo ângulo de *desenvolvimento*
(Scrum, Kanban, XP, Lean, Waterfall, Ágil Híbrida) — o suficiente para o item 8
de Desenvolvimento, mas não para esta disciplina.

## 5.1 Não coberto — item 1

- **Gerenciamento de projetos: conceitos e áreas de conhecimento** — a expressão
  "Gerenciamento de Projetos" só aparece no banco como parte do *título* da
  seção 2.13. Nenhuma pergunta sobre escopo, cronograma, custos, qualidade,
  recursos, comunicações, riscos, aquisições, partes interessadas, integração.
- **Projeto, programa e portfólio** — a distinção entre os três.
- **Guia Scrum de prática ágil para gerenciamento de projetos** (PMI/Scrum.org)
  — o edital cita o guia nominalmente.

## 5.2 Não coberto — item 2

**Processos, grupos de processos e áreas de conhecimento** — os cinco grupos
(iniciação, planejamento, execução, monitoramento e controle, encerramento) e a
matriz grupos × áreas.

## 5.3 Não coberto — item 3

**Gestão de riscos** de projeto — identificação, análise qualitativa e
quantitativa, respostas, matriz probabilidade × impacto.

## 5.4 Não coberto — item 4

**ITIL v4** — item inteiro. Sistema de Valor de Serviço, cadeia de valor, as 34
práticas, os 7 princípios orientadores, as quatro dimensões.

## 5.5 Não coberto — item 5

**COBIT 2019** — item inteiro. Objetivos de governança e gestão, os 40 objetivos,
os domínios (EDM, APO, BAI, DSS, MEA), fatores de design, princípios.

## 5.6 Não coberto — item 6

**BPMN e gestão de processos de negócio** — notação, eventos, gateways, pools e
raias, modelagem de processos.

---

# 6. Módulo I

Fora do escopo de "conhecimentos específicos", mas listado porque o banco
*parece* cobrir legislação e cobre só uma fatia. São 5 questões de Legislação e
6 de Atualidades e IA, todas de peso 1.

## 6.1 LAI — Lei 12.527/2011

O edital pede **capítulos I, II, III, IV e V, mais os Decretos nº 7.724 e
nº 7.845**. O banco cobre apenas o Capítulo IV.

| Capítulo | Assunto | Situação |
|---|---|---|
| I | Disposições gerais, conceitos, diretrizes (art. 1º–5º) | ✗ |
| II | Acesso a informações e sua divulgação — transparência ativa, rol mínimo do site (art. 6º–9º) | ✗ |
| III | Procedimento de acesso — prazos (20 + 10 dias), recursos, instâncias (art. 10–20) | ✗ |
| IV | Restrições de acesso e classificação (art. 21–31) | ✓ Q1–Q8 |
| V | Responsabilidades e condutas ilícitas (art. 32–34) | ✗ |
| — | Decreto nº 7.724/2012 e Decreto nº 7.845/2012 | ✗ |

## 6.2 Marco Civil — Lei 12.965/2014

O edital pede **capítulo II e capítulo III, Seções I e II**.

| Trecho | Assunto | Situação |
|---|---|---|
| Cap. II | Direitos e garantias dos usuários (art. 7º–8º) — inviolabilidade, não suspensão da conexão, contratos | ✗ |
| Cap. III, Seç. I | **Neutralidade de rede** (art. 9º) | ✗ |
| Cap. III, Seç. II | Registros, dados pessoais, comunicações privadas, guarda e sanções (art. 10–17) | ✓ Q18–Q25 |

Neutralidade de rede e direitos dos usuários são os dois assuntos mais cobrados
do Marco Civil, e são justamente os ausentes.

## 6.3 LGPD — Lei 13.709/2018

O edital pede **capítulos I, II, III, IV, VII, VIII e IX**. O banco cobre VIII e
IX.

| Capítulo | Assunto | Situação |
|---|---|---|
| I | Fundamentos, aplicação territorial, conceitos, dado sensível, anonimização (art. 1º–6º) | ✗ |
| II | **Bases legais do tratamento (art. 7º e 11)**, dados sensíveis, crianças, término | ✗ |
| III | Direitos do titular (art. 17–22) — acesso, correção, portabilidade, eliminação | ✗ |
| IV | Tratamento pelo Poder Público (art. 23–32) | ✗ |
| VII | Segurança e boas práticas — incidentes, RIPD, governança (art. 46–51) | ✗ |
| VIII | Fiscalização e sanções (art. 52–54) | ✓ Q26–Q35 |
| IX | ANPD e CNPD (art. 55-A–59) | ✓ Q36–Q47 |

A ausência do **Capítulo II (bases legais)** é a lacuna mais séria do Módulo I:
é o assunto mais cobrado de LGPD em qualquer banca. As palavras "consentimento"
e "anonimização" aparecem no banco uma vez cada, como cenário de casos que
tratam de outra coisa (Q25, sobre sanções do Marco Civil; Q47, sobre a divisão
de competências entre ANPD e CNPD).

O único diploma integralmente coberto é a Lei 12.737/2012, porque o edital pede
só o art. 2º — que é exatamente o que insere os arts. 154-A e 154-B no CP.

## 6.4 Atualidades e Inteligência Artificial (disciplina nova, 6 questões)

| Subitem | Situação |
|---|---|
| Conceitos de inteligência artificial | ✓ seção 2.18 |
| Aprendizado de máquina | ✓ seção 2.18 |
| **Modelos generativos e modelos de linguagem** | ✗ |
| **Ética, governança e privacidade em IA** | ✗ |
| Tópicos atuais (segurança, economia, sociedade, energia…) | ✗ (fora do formato do banco) |

"Governança" aparece no banco só como *governança de dados*, em contexto de BI
e ETL (Q204, Q209).

---

# 7. Prioridade sugerida

Ordenado por retorno esperado. A distribuição das 30 questões entre as cinco
disciplinas não está no edital; a estimativa abaixo é proporcional ao tamanho da
ementa de cada uma.

| # | Frente | Por quê |
|:-:|---|---|
| 1 | **SQL, DDL, DML, normalização, integridade referencial, modelagem** | Maior lacuna isolada. 6+ subitens do edital com cobertura zero, em assunto que a FGV cobra com frequência e em profundidade D3/D4 |
| 2 | **ITIL v4 e COBIT 2019** | Dois itens inteiros, decoráveis, alto retorno por hora. Disciplina que o banco não previa |
| 3 | **ISO/IEC 27001 e 27002:2022** | Item inteiro. Rol exato de controles = perfil D3, o centro de gravidade da banca |
| 4 | **Padrões de projeto (GoF) e reuso** | Item 9, cobertura zero, e consta das atribuições do cargo |
| 5 | **PMBOK: áreas, grupos de processos, portfólio/programa** | Complementa a frente 2; o banco só tem o lado ágil |
| 6 | **LGPD Cap. II (bases legais) + Cap. III (direitos do titular)** | Módulo I, mas é o assunto mais cobrado de LGPD. Baixo custo, alto retorno |
| 7 | **Modelagem dimensional (estrela, floco de neve, fato/dimensão)** | Aproveita a base de BI/DW já sólida do banco |
| 8 | **BPMN** | Item 6 de Governança, notação objetiva e fechada |
| 9 | **Containers, API Gateway, orquestração, transações distribuídas (SAGA)** | Estende a seção 2.17, que já existe e é boa |
| 10 | **UX, acessibilidade, arquitetura da informação, CMS, workflow** | Bloco grande (item 19), mas conceitual e de fronteira difusa |
| 11 | **Frontend web: HTML, CSS, Ajax, Angular/Vue/React, CSR/SSR** | Item 13, hoje coberto só na parte SPA/PWA |
| 12 | **SAST/DAST, clean code, SonarQube, SDL, OAuth2/SSO** | Itens curtos, atravessam Desenvolvimento e Segurança |
| 13 | **Marco Civil: neutralidade de rede e direitos dos usuários** | Módulo I, dois artigos, muito cobrados |
| 14 | **LAI Caps. I, II, III, V + Decretos 7.724 e 7.845** | Módulo I, volume grande de texto para 5 questões de peso 1 |
| 15 | **GIT, testes ágeis, ciclo de vida de testes, RPA, data mining, big data, JavaEE/JPA/JSF, low-code, UDDI, mensageria, Swagger** | Itens pontuais, alto custo de dispersão. Deixar por último |

## Observação sobre o método de estudo

Nada disso é crítica ao protocolo da skill `estudo`. Gabarito antes da
resposta, escada D1→D4, nota registrada e SM-2 continuam válidos — as 242
perguntas existentes são boas. O que precisa mudar é a **fonte do escopo**:
reescrever `conceitos.md` a partir do Anexo I do edital de 2026, e manter a prova
de 2024 no papel que ela faz bem — calibrar profundidade D0–D5, não delimitar
conteúdo.
