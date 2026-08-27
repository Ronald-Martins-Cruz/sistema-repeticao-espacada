# Conceitos de Estudo — Desenvolvimento de Software

Esta é a lista de conceitos que quero utilizar como base para os meus estudos.

Cada item abaixo é um tema que devo dominar. Use esta lista como fonte para me
fazer perguntas, propor exercícios, cobrar definições, comparações e casos
práticos — sempre com foco em me preparar para responder questões de múltipla
escolha sobre estes assuntos.

---

## 1. Legislação Acerca de Segurança da Informação e Proteção de Dados

### 1.1 Lei de Acesso à Informação — Lei nº 12.527/2011 (LAI)
- Restrições de acesso à informação
- Classificação da informação: graus ultrassecreto, secreto e reservado
- Prazos de classificação e termo final (evento constituidor)
- Desclassificação, reavaliação e redução de prazo de sigilo
- Competência da autoridade classificadora e da autoridade superior
- Publicidade da decisão de classificação
- Informações sobre violação de direitos humanos praticadas por agentes públicos
  (vedação de restrição de acesso)

### 1.2 Lei de Crimes Cibernéticos — Lei nº 12.737/2012 (art. 154-A do Código Penal)
- Crime de invasão de dispositivo informático
- Elementares do tipo penal (violação de mecanismo de segurança, conexão à rede)
- Causas de aumento de pena e o sujeito passivo qualificado
  (Presidente da República, presidentes de Casas Legislativas, do STF, etc.)
- Natureza da ação penal: ação penal pública x ação penal privada (queixa-crime)
- Momento de consumação e tentativa

### 1.3 Marco Civil da Internet — Lei nº 12.965/2014
- Princípios, garantias, direitos e deveres para o uso da Internet no Brasil
- Proteção aos registros de conexão, registros de acesso a aplicações, dados
  pessoais e comunicações privadas
- Guarda de registros: prazos e responsáveis
- Sanções previstas: advertência, multa, suspensão temporária e proibição de
  exercício das atividades de coleta de dados
- Aplicação isolada ou cumulativa das sanções
- Cálculo da multa (percentual sobre o faturamento do grupo econômico no Brasil)
- Aplicabilidade da lei a empresas estrangeiras

### 1.4 Lei Geral de Proteção de Dados Pessoais — Lei nº 13.709/2018 (LGPD)
- Capítulo de fiscalização e sanções administrativas
- Espécies de sanção: advertência, multa simples, multa diária, publicização da
  infração, bloqueio e eliminação de dados pessoais, suspensão e proibição do
  tratamento
- Necessidade de processo administrativo prévio e direito de defesa
- Parâmetros e critérios de dosimetria da sanção (gravidade da infração, boa-fé
  do infrator, vantagem auferida, reincidência, cooperação, adoção de política
  de boas práticas, etc.)
- Aplicação de multa a órgãos e entidades públicas
- Destinação do produto da arrecadação das multas (Fundo de Direitos Difusos)
- Papéis da LGPD: controlador, operador, encarregado (DPO) e titular

### 1.5 Autoridade Nacional de Proteção de Dados (ANPD)
- Natureza jurídica e posição na administração pública federal
- Composição e atribuições do Conselho Diretor
- Competências fiscalizatórias, normativas e sancionatórias

### 1.6 Conselho Nacional de Proteção de Dados Pessoais e da Privacidade (CNPD)
- Natureza, composição e representantes que o integram
- Atribuições: propor diretrizes, sugerir ações à ANPD, disseminar conhecimento
  sobre proteção de dados pessoais e privacidade
- Distinção entre CNPD e ANPD

---

## 2. Conhecimentos Específicos

### 2.1 Frameworks e Plataforma Java
- Spring Framework: propósito, inversão de controle e injeção de dependência
- Spring Boot: autoconfiguração, servidor embarcado, starters
- Spring Cloud: sistemas distribuídos, configuração centralizada, service
  discovery, resiliência
- Hibernate: mapeamento objeto-relacional (ORM) e persistência
- JUnit: framework de testes unitários em Java
- Servidores de aplicação Java: Tomcat, JBoss/WildFly; modo standalone x embarcado

### 2.2 Formatos e Tecnologias de Dados/Marcação
- XML: estrutura, verbosidade, casos de uso
- XSLT: transformação de documentos XML em outros formatos (HTML, XML, texto)
- JSON: estrutura, leveza, uso em APIs e transporte cliente-servidor
- Comparação XML x JSON: expressividade, legibilidade, compactação

### 2.3 Design e Arquitetura de Software
- Diferença entre Design de Software e Arquitetura de Software
- Design de alto nível x design de baixo nível
- Definição de módulos, componentes e suas interações
- Abstração, modularização e decisões estruturais
- Aplicabilidade da arquitetura em projetos de diferentes portes

### 2.4 Princípios SOLID
- S — Single Responsibility Principle (Responsabilidade Única)
- O — Open/Closed Principle (Aberto/Fechado)
- L — Liskov Substitution Principle (Substituição de Liskov)
- I — Interface Segregation Principle (Segregação de Interfaces)
- D — Dependency Inversion Principle (Inversão de Dependência)
- Aplicação prática em herança, sobrescrita de métodos e polimorfismo
- Identificação de violações de LSP em código Java

### 2.5 Orientação a Objetos
- Herança, sobrescrita (override) e polimorfismo
- Substituibilidade de subtipos e contratos de classe
- Corretude do programa ao substituir a classe base pela derivada

### 2.6 Redes Corporativas e Ambiente Web
- Internet: rede pública global
- Intranet: rede interna restrita a funcionários da organização
- Extranet: acesso controlado a parceiros e usuários externos autorizados
- Portal corporativo: centralização de informações e serviços
- Servidor web x servidor de aplicações: funções, requisições HTTP, conteúdo
  estático x dinâmico, camada de lógica de negócios e integração com bancos de
  dados
- Balanceamento de carga

### 2.7 Integração de Sistemas, SOA e Web Services
- Arquitetura Orientada a Serviços (SOA)
- Web Services RESTful: características, statelessness, independência de
  plataforma
- SOAP: contratos formais, envelope, mensagens
- WSDL: definição de contrato de serviço
- RPC (Remote Procedure Call)
- Acoplamento (baixo x alto acoplamento) e interoperabilidade
- Integração via web services x arquitetura monolítica

### 2.8 Segurança em Comunicações Web
- Protocolo HTTP e HTTPS
- SSL: histórico e vulnerabilidades
- TLS: sucessor do SSL, correções e melhorias de segurança
- Handshake, autenticação e criptografia dos dados em trânsito
- Certificados digitais

### 2.9 Métricas, Estimativas e Mensuração de Software
- Análise de Pontos de Função (APF): mensuração objetiva, independente do time,
  uso em contratos formais e escopo fechado
- Story Points: estimativa relativa, subjetiva, dependente do contexto do time
- Comparabilidade de estimativas entre projetos e equipes
- Estimativa de tamanho x estimativa de esforço

### 2.10 Desenvolvimento Mobile
- Desenvolvimento nativo x multiplataforma (cross-platform)
- Flutter (linguagem Dart)
- React Native
- Xamarin
- Ionic
- SwiftUI
- Plataformas Android e iOS

### 2.11 Arquiteturas de Aplicações Front-end
- SPA (Single Page Application): carregamento único, navegação sem recarregar
  a página
- PWA (Progressive Web Application): instalação no dispositivo, experiência
  próxima ao aplicativo nativo
- Service Workers: cache, funcionamento offline e notificações push
- Dependência (ou não) de frameworks JavaScript

### 2.12 Testes de Software
- Testes unitários: verificação de unidades isoladas (funções e métodos)
- Testes de integração: interação entre módulos e componentes
- Testes de usabilidade: experiência do usuário e interface
- TDD (Test-Driven Development): escrever testes antes do código funcional
- Testes automatizados

### 2.13 Metodologias Ágeis e Gerenciamento de Projetos
- Manifesto Ágil: valor ao cliente, feedback contínuo, colaboração
- Scrum: sprints, entregas incrementais, revisões periódicas
- Papéis do Scrum: Product Owner, Scrum Master, Time de Desenvolvimento
- Eventos do Scrum: Sprint Planning, Daily Scrum, Sprint Review, Retrospectiva
- Sprint Backlog, Product Backlog, Sprint Goal e capacidade do time
- Postura do Scrum Master: facilitação, remoção de impedimentos e
  autogerenciamento da equipe (não comando e controle)
- Kanban: fluxo contínuo, sem ciclos fechados de tempo
- XP (Extreme Programming): programação em par, testes automatizados,
  integração contínua
- Lean: eliminação de desperdícios
- Waterfall (Cascata): modelo linear e sequencial
- Abordagem Ágil Híbrida: combinação de práticas ágeis com métodos tradicionais

### 2.14 Engenharia de Requisitos
- Requisitos funcionais x requisitos não funcionais
- Requisitos de desempenho (ex.: processamento em tempo real)
- Técnicas de elicitação: entrevista, brainstorming, questionários, observação,
  prototipação, workshops
- Posicionamento da engenharia de requisitos no ciclo de vida do software
- Validação e verificação de requisitos

### 2.15 DevOps
- Integração Contínua (CI)
- Entrega Contínua e Implantação Contínua (CD)
- Gerenciamento de configuração
- Monitoramento contínuo
- Controle de versão
- Publicação de novas versões em produção com mínima interrupção ao usuário

### 2.16 Blockchain
- Estrutura de um bloco: hash do bloco anterior, timestamp, dados das
  transações, assinaturas digitais, nonce, Merkle root
- Encadeamento de blocos e integridade
- Blockchains públicas: Bitcoin e Ethereum
- Modelo UTXO x modelo de contas (registro de saldo)
- Validação de transações e consenso

### 2.17 Arquiteturas de Aplicação
- Arquitetura Hexagonal (Portas e Adaptadores): separação da lógica de negócio
  das interfaces externas
- Microsserviços: serviços pequenos, autônomos, banco de dados por serviço,
  implantação independente
- Arquitetura monolítica e monolito distribuído
- Acoplamento, coesão e consistência de dados entre serviços

### 2.18 Inteligência Artificial
- Definição e escopo da IA
- Aprendizado de máquina (sistemas que aprendem com dados e melhoram com o tempo)
- Redes Neurais Artificiais
- Algoritmos Genéticos
- Busca Heurística
- Lógica Booleana
- Programação Linear

### 2.19 Data Warehouse, ETL e ELT
- Conceito de Data Warehouse
- Processo ETL: extração, transformação e carga
- Processo ELT: carga antes da transformação, aproveitando o poder de
  processamento do destino
- Comparação ETL x ELT: volume de dados, desempenho e cenários de uso
- Padronização e consistência dos dados

### 2.20 Business Intelligence (BI)
- Mapeamento de fontes de dados
- Qualidade, relevância e confiabilidade dos dados
- Elicitação de requisitos com usuários e stakeholders
- Análise de documentos e sistemas legados
- Documentação de fontes, formatos e relacionamentos
- Governança de dados e auditoria

### 2.21 Sistemas de Suporte à Decisão (SSD/DSS)
- Apoio à tomada de decisão gerencial
- Problemas estruturados, semiestruturados e não estruturados
- Papel da intuição e do julgamento humano
- Abrangência de aplicação nas áreas funcionais da organização

### 2.22 Bancos de Dados
- Abordagem relacional x abordagem multidimensional
- OLTP (processamento transacional online)
- OLAP (processamento analítico online), cubos, dimensões e métricas
- Agregações e cálculos analíticos
- Bancos NoSQL: tipos (chave-valor, documento, colunar, grafos)
- Propriedades ACID x BASE e o teorema CAP
- Alta disponibilidade e escalabilidade horizontal
- Adequação de NoSQL x relacional por tipo de sistema (ERP, CRM, etc.)

### 2.23 Controle de Acesso
- Controle de acesso discricionário (DAC)
- Controle de acesso mandatório (MAC): rótulos de segurança e autorizações
- Controle de acesso baseado em papéis (RBAC)
- Princípio do privilégio mínimo
- Autenticação x autorização

### 2.24 Segurança de Aplicações — OWASP
- OWASP (Open Web Application Security Project)
- OWASP Top 10:2021 e suas categorias, entre elas:
  - Broken Access Control (Quebra de controle de acesso)
  - Cryptographic Failures (Falhas criptográficas)
  - Injection (Injeção)
  - Insecure Design (Design inseguro)
  - Security Misconfiguration (Configuração incorreta de segurança)
  - Vulnerable and Outdated Components (Componentes vulneráveis e desatualizados)
  - Identification and Authentication Failures
  - Software and Data Integrity Failures
  - Security Logging and Monitoring Failures
  - Server-Side Request Forgery — SSRF (Falsificação de solicitação do lado do
    servidor)
- Desenvolvimento seguro e boas práticas
