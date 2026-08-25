Aqui está o guia completo e estruturado com todos os elementos, mantendo o foco em **propósito**, **palavras-chave de concurso** e **resumo mental**.

---

### 1. Java
* **O que é / Propósito:** É a linguagem de programação base, orientada a objetos e fortemente tipada. O código Java é compilado para um formato intermediário chamado **bytecode**, que é executado pela **JVM (*Java Virtual Machine*)**.
* **Palavras-chave para concurso:**
  * **WORA (*Write Once, Run Anywhere*):** Portabilidade multiplataforma viabilizada pela JVM.
  * **Pilar da OO:** Encapsulamento, Herança, Polimorfismo e Abstração.
  * **Garbage Collector (GC):** Gerenciamento automático de memória (desaloca objetos sem referência).
  * **JDK vs. JRE vs. JVM:** JVM executa o bytecode; JRE é o ambiente de execução (JVM + bibliotecas); JDK é o kit completo de desenvolvimento (JRE + compilador `javac` + ferramentas).
* **Resumo mental:** *A linguagem de programação e sua máquina virtual que tornam tudo possível.*

---

### 2. Java EE (Java Platform, Enterprise Edition / J2EE)
* **O que é / Propósito:** Um conjunto de **especificações e padrões corporativos** criados originalmente pela Sun/Oracle para desenvolvimento de aplicações corporativas robustas, escaláveis e em multicamadas.
* **Palavras-chave para concurso:**
  * **Especificação (não é um produto):** Define regras e interfaces; fornecedores criam implementações em **Servidores de Aplicação** (ex: WildFly, GlassFish, WebLogic).
  * **Tecnologias clássicas:** Servlets, JSP, EJB (*Enterprise JavaBeans*), JMS (mensageria), JTA (transações).
* **Resumo mental:** *O antigo padrão oficial da Oracle para sistemas corporativos pesados em Java.*

---

### 3. Jakarta EE
* **O que é / Propósito:** É a **evolução oficial do Java EE**. A Oracle doou o Java EE para a **Eclipse Foundation**, que o renomeou para Jakarta EE por questões de direitos de marca.
* **Palavras-chave para concurso:**
  * **Eclipse Foundation:** Nova organização responsável pela governança.
  * **Mudança de Pacotes (`javax.*` $\rightarrow$ `jakarta.*`):** A partir do Jakarta EE 9, os pacotes mudaram de nome (ex: `javax.persistence` virou `jakarta.persistence`). Bancas adoram cobrar essa transição!
  * **Foco Moderno:** Voltado para arquiteturas em nuvem (*Cloud-Native Java*).
* **Resumo mental:** *É o mesmo Java EE, apenas com novo nome, governança aberta e pacotes `jakarta.*`.*

---

### 4. JPA (Jakarta / Java Persistence API)
* **O que é / Propósito:** É a **especificação padrão** do ecossistema Java para Mapeamento Objeto-Relacional (ORM) e persistência de dados.
* **Palavras-chave para concurso:**
  * **Apenas Interfaces:** A JPA define *o que* deve ser feito (anotações e interfaces), mas não implementa a lógica de banco diretamente.
  * **Componentes principais:** `EntityManager`, `EntityManagerFactory`, anotações (`@Entity`, `@Table`, `@Id`, `@Column`), linguagem de consulta **JPQL**.
  * **Relação com Hibernate:** O Hibernate é a implementação concreta da JPA mais utilizada no mercado.
* **Resumo mental:** *O "manual de regras" oficial do Java para salvar objetos no banco de dados.*

---

### 5. JSF (JavaServer Faces)
* **O que é / Propósito:** Framework MVC oficial (do Java EE / Jakarta EE) **baseado em componentes** para construção de interfaces de usuário (UI) renderizadas no servidor (*Server-Side Rendering*).
* **Palavras-chave para concurso:**
  * **Ciclo de Vida de 6 Fases:** *Restore View*, *Apply Request Values*, *Process Validations*, *Update Model Values*, *Invoke Application*, *Render Response*. (Bancas adoram a ordem dessas fases!).
  * **Facelets (`.xhtml`):** Tecnologia de visão padrão do JSF.
  * **Orientado a Componentes e a Eventos:** A tela é composta por uma árvore de componentes gerenciada no servidor.
* **Resumo mental:** *Framework para criar telas web usando tags e componentes Java no servidor, sem precisar escrever HTML/JS do zero.*

---

### 6. PrimeFaces
* **O que é / Propósito:** É uma **suíte/biblioteca de componentes visuais ricos** desenvolvida para rodar sobre o **JSF**.
* **Palavras-chave para concurso:**
  * **Extensão do JSF:** Adiciona mais de 100 componentes prontos e estilizados (tabelas avançadas com paginação e ordenação, modais, gráficos, calendários, upload de arquivos).
  * **Suporte AJAX Transparente:** Permite atualizar pedaços da tela de forma assíncrona sem recarregar a página inteira e sem exigir que o programador escreva JavaScript manualmente.
* **Resumo mental:** *O pacote de "peças visuais bonitas e prontas" que você pluga no JSF.*

---

### 7. Hibernate
* **O que é / Propósito:** Framework de **ORM (Mapeamento Objeto-Relacional)** que atua como a implementação mais popular da especificação **JPA**.
* **Palavras-chave para concurso:**
  * **ORM & Implementação JPA:** Faz o mapeamento entre classes Java e tabelas SQL.
  * **Recursos internos:** Cache de 1º nível (na sessão) e 2º nível (compartilhado), *Dirty Checking* (atualização automática de estado), *Lazy Loading* (carregamento sob demanda), linguagem **HQL**.
* **Resumo mental:** *O motor que realmente executa as operações de banco de dados definidas pela JPA.*

---

### 8. JUnit
* **O que é / Propósito:** Framework padrão para escrita e execução de **testes automatizados de unidade (*unit tests*)**.
* **Palavras-chave para concurso:**
  * **Testes de Unidade:** Foco em validar pequenas partes do código (métodos isolados).
  * **Anotações (JUnit 5 / Jupiter):** `@Test`, `@BeforeEach`, `@AfterEach`, `@BeforeAll`, `@AfterAll`, `@Disabled`.
  * **Asserções:** Métodos para conferir resultados (`assertEquals`, `assertTrue`, `assertThrows`).
  * **TDD:** Prática de escrever testes antes da funcionalidade.
* **Resumo mental:** *O validador automático que garante que cada função do seu código funciona como esperado.*

---

### 9. Spring Framework (Core)
* **O que é / Propósito:** Framework base para desenvolvimento corporativo que organiza o sistema através do desacoplamento de componentes.
* **Palavras-chave para concurso:**
  * **IoC (Inversão de Controle) e DI (Injeção de Dependências):** Gerenciamento do ciclo de vida dos objetos (*Beans*).
  * **AOP (Programação Orientada a Aspectos):** Tratamento transversal de transações (`@Transactional`), logs e segurança.
  * **Ecossistema Modular:** Spring MVC (web), Spring Security (autenticação), Spring Data (persistência).
* **Resumo mental:** *A espinha dorsal que conecta e gerencia todos os componentes da aplicação.*

---

### 10. Spring Boot
* **O que é / Propósito:** Camada de produtividade sobre o Spring que elimina configurações manuais e permite subir aplicações autônomas e prontas para produção rapidamente.
* **Palavras-chave para concurso:**
  * **Convenção sobre Configuração (*Convention over Configuration*):** Autoconfigurações inteligentes padrão.
  * **Servidor Embutido:** Gera um `.jar` executável contendo o Tomcat/Jetty dentro.
  * **Starters:** Pacotes de dependências pré-configurados (`spring-boot-starter-web`, etc.).
  * **Actuator:** Monitoramento de saúde, métricas e auditoria da aplicação.
* **Resumo mental:** *O facilitador que faz o Spring rodar com o mínimo de configuração possível.*

---

### 11. Spring Cloud
* **O que é / Propósito:** Conjunto de ferramentas para gerenciar os desafios de **sistemas distribuídos e arquiteturas de microsserviços** na nuvem.
* **Palavras-chave para concurso:**
  * **Service Discovery:** Descoberta e registro dinâmico de serviços (Eureka, Consul).
  * **API Gateway:** Roteador e ponto de entrada central das requisições externas (Spring Cloud Gateway).
  * **Circuit Breaker:** Padrão de tolerância a falhas para evitar colapso em cadeia (Resilience4j).
  * **Config Server:** Centralização de arquivos de configuração para dezenas de microsserviços.
* **Resumo mental:** *O kit de ferramentas que organiza o tráfego, a resiliência e as conexões entre vários microsserviços.*

---

### Tabela Comparativa (Super Cheat Sheet)

| Tecnologia | Tipo / Categoria | Papel Principal | Relação Direta Com |
| :--- | :--- | :--- | :--- |
| **Java** | Linguagem de Programação | Base de todo o ecossistema (Bytecode / JVM) | JVM / JDK |
| **Java EE** | Especificação Corporativa | Antigo padrão de arquitetura empresarial | Servidores de Aplicação |
| **Jakarta EE** | Especificação Corporativa | Novo nome e evolução do Java EE (Eclipse Foundation) | Java EE (sucessor) |
| **JPA** | Especificação de Persistência | Regras e anotações para ORM (`@Entity`, `EntityManager`) | Hibernate (implementação) |
| **Hibernate** | Framework ORM | Implementa a JPA e gerencia persistência SQL | JPA / Bancos Relacionais |
| **JSF** | Framework Web / UI | Criação de telas orientadas a componentes no servidor | PrimeFaces / Jakarta EE |
| **PrimeFaces** | Suíte de Componentes UI | Componentes visuais ricos e AJAX para o JSF | JSF (roda em cima dele) |
| **Spring** | Framework Corporativo Core | Injeção de Dependências (DI) e Inversão de Controle (IoC) | Spring Boot |
| **Spring Boot** | Framework de Produtividade | Criação rápida de apps Spring com servidor embutido | Spring Framework |
| **Spring Cloud** | Framework de Infraestrutura | Padrões para microsserviços e sistemas em nuvem | Microsserviços / Spring Boot |
| **JUnit** | Framework de Testes | Execução de testes de unidade automatizados | TDD / Qualidade |

---

### 🚨 As 4 Maiores Pegadinhas de Concurso deste Grupo:

1. **JPA vs. Hibernate:** JPA é apenas a **especificação (interface)**; o Hibernate é a **implementação (código executável)**.
2. **Java EE vs. Jakarta EE:** É a mesma linhagem; o nome mudou após a doação para a Eclipse Foundation e a mudança do pacote `javax.*` para `jakarta.*`.
3. **JSF vs. PrimeFaces:** JSF é o framework/especificação base de UI; o PrimeFaces é uma biblioteca de componentes avançados que roda dentro do JSF.
4. **Spring vs. Spring Boot:** O Spring Boot **não substitui** o Spring; ele apenas automatiza as configurações para facilitar o uso do Spring.