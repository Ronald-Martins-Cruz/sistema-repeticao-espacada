# Arquiteturas de Aplicação (Arquitetura Hexagonal e Microsserviços)

> Item **21** ("*Arquitetura hexagonal, microsserviços... e containers*") do bloco *Desenvolvimento de Sistemas*, Módulo II — Perfil 3, do Anexo I do edital DATAPREV 2026. Corresponde à **Seção 2.17** do banco de questões.

---

## 1. Arquitetura Hexagonal (*Ports and Adapters*)

Criada por **Alistair Cockburn** (2005), a **Arquitetura Hexagonal** (também conhecida como padrão **Portas e Adaptadores** / *Ports and Adapters*) é um padrão arquitetural de software cujo objetivo central é **isolar completamente o núcleo de regras de negócio (Domínio e Casos de Uso)** de preocupações de infraestrutura técnica, interfaces de usuário, bancos de dados e serviços externos.

O desenho em forma de hexágono é apenas uma metáfora visual para ilustrar que uma aplicação possui múltiplos lados através dos quais pode interagir com o mundo exterior.

```
                    ┌────────────────────────────────────────────────────────┐
                    │               MUNDO EXTERIOR / INFRAESTRUTURA          │
                    │                                                        │
                    │   ADAPTADORES PRIMÁRIOS (Driver)                       │
                    │   ┌───────────────────────────┐                        │
                    │   │  REST Controller (HTTP)   │                        │
                    │   │  CLI / Terminal           │                        │
                    │   │  Consumidor RabbitMQ/Kafka│                        │
                    │   └─────────────┬─────────────┘                        │
                    │                 │ (Chama a porta)                      │
                    │                 ▼                                      │
  ══════════════════╪════════════════════════════════════════════════════════╪══════════════════
  FRONTEIRA DO      │       PORTAS DE ENTRADA (Driver Ports)                 │
  NÚCLEO DE NEGÓCIO │       ┌───────────────────────────┐                    │
                    │       │ Interface: CriarPedidoUC  │                    │
                    │       └─────────────┬─────────────┘                    │
                    │                     ▼                                  │
                    │          ┌─────────────────────┐                       │
                    │          │  NÚCLEO DE DOMÍNIO  │                       │
                    │          │  • Entidades        │                       │
                    │          │  • Regras de Negócio│                       │
                    │          └──────────┬──────────┘                       │
                    │                     │                                  │
                    │                     ▼                                  │
                    │       PORTAS DE SAÍDA (Driven Ports)                   │
                    │       ┌───────────────────────────┐                    │
                    │       │ Interface: PedidoRepository                     │
                    │       └─────────────┬─────────────┘                    │
  ══════════════════╪═════════════════════╪══════════════════════════════════╪══════════════════
                    │                     │ (Implementada por)               │
                    │                     ▼                                  │
                    │   ADAPTADORES SECUNDÁRIOS (Driven)                     │
                    │   ┌───────────────────────────┐                        │
                    │   │  PostgreSQL (Spring Data) │                        │
                    │   │  Cliente Gateway Pagamento│                        │
                    │   │  Serviço de Envio E-mail  │                        │
                    │   └───────────────────────────┘                        │
                    │                                                        │
                    └────────────────────────────────────────────────────────┘
```

### 1.1 Distinção Fundamental: Portas vs Adaptadores

| Elemento | Pertence a quem? | O que é e qual o seu papel? | Exemplos |
|---|---|---|---|
| **Porta (*Port*)** | **Ao Núcleo de Negócio** (lado de dentro) | É uma **interface abstrata** de programação que define o contrato de comunicação entre o domínio e o mundo exterior. | Interfaces Java/TypeScript como `ProcessarPagamentoUseCase` ou `ContaRepository`. |
| **Adaptador (*Adapter*)** | **À Infraestrutura Externa** (lado de fora) | É o componente de código concreto que **converte** uma tecnologia externa específica para a linguagem da porta, ou que implementa a porta de saída. | Classes concretas como `PedidoRestController`, `ContaRepositoryPostgresJpa`, `SendGridEmailService`. |

### 1.2 Classificação de Portas e Adaptadores: Primários vs Secundários
1. **Lado Primário / Condutor (*Driver / Inbound*):**
   * Atores externos que iniciam ações contra a aplicação (usuários, navegadores, mensagens de fila).
   * **Adaptador Primário:** Recebe a requisição externa (ex.: JSON HTTP no Spring Controller) e invoca a **Porta Primária (Porta de Entrada)** do núcleo.
2. **Lado Secundário / Conduzido (*Driven / Outbound*):**
   * Tecnologias invocadas pelo núcleo de negócio para persistência ou integração (SGBDs, brokers de mensageria, gateways).
   * O núcleo de negócio declara a **Porta Secundária (Porta de Saída)** na forma de interface. O **Adaptador Secundário** implementa essa interface utilizando a tecnologia concreta (ex.: JPA/Hibernate para Postgres).

> **A Regra de Ouro das Dependências:** As dependências de código apontam **sempre para dentro**. O núcleo de domínio não importa nenhuma biblioteca de framework (nem Spring, nem JPA, nem React), garantindo testabilidade pura e independência de fornecedores.

---

## 2. Arquitetura de Microsserviços

A **Arquitetura de Microsserviços** é uma abordagem arquitetural na qual uma aplicação corporativa é estruturada como um **conjunto de pequenos serviços autônomos, fracamente acoplados e altamente coesos**, organizados em torno de **capacidades de negócio (*Bounded Contexts* do DDD)**.

### 2.1 Princípios Centrais
* **Alta Coesão Interna:** Cada microsserviço foca em uma única responsabilidade de negócio bem delimitada (ex.: Serviço de Catálogo, Serviço de Faturamento, Serviço de Entregas).
* **Baixo Acoplamento Externo:** Os serviços interagem entre si exclusivamente através de protocolos de rede leves e padronizados (APIs HTTP/REST, gRPC ou mensageria assíncrona com RabbitMQ/Kafka).
* **Implantação Independente (*Independent Deployability*):** É a característica mais decisiva dos microsserviços. Cada microsserviço pode ser alterado, testado e publicado em produção de forma isolada, sem exigir a recompilação ou a reimplantação de nenhum outro serviço.

### 2.2 A Regra da Propriedade dos Dados (*Database-per-Service*)
> **Atenção — Ponto Crítico de Prova:** Em uma arquitetura de microsserviços genuína, os serviços **NÃO compartilham o mesmo banco de dados ou esquema relacional**.

Cada microsserviço deve ser o **único proprietário de seus dados e de seu banco de dados**:
* Nenhum outro serviço pode executar consultas SQL diretas (`SELECT`, `INSERT`, `UPDATE`) nas tabelas de outro microsserviço.
* O acesso e a manipulação dos dados só podem ocorrer através da **interface pública de API** exposta pelo serviço proprietário ou via eventos de domínio.
* Essa segregação permite que cada serviço escolha a tecnologia de banco de dados mais adequada ao seu problema (**Persistência Poliglota**: relacional, NoSQL documental, grafo ou chave-valor).

---

## 3. O Antipadrão: Monólito Distribuído (*Distributed Monolith*)

Um dos maiores erros de engenharia e temas favoritos de concursos é o surgimento do **Monólito Distribuído**, considerado o **"pior dos dois mundos"**:

```
                                  O MONÓLITO DISTRIBUÍDO
              (Múltiplos serviços com dependência rígida e banco compartilhado)

┌────────────────┐   ┌────────────────┐   ┌────────────────┐   ┌────────────────┐
│  Serviço de    │   │  Serviço de    │   │  Serviço de    │   │  Serviço de    │
│  Usuários      │   │  Pedidos       │   │  Pagamentos    │   │  Estoque       │
└───────┬────────┘   └────────┬───────┘   └────────┬───────┘   └────────┬───────┘
        │                     │                    │                    │
        │                     │   (Chamadas RPC    │                    │
        │                     └── Síncronas em ────┘                    │
        │                         Cascata)                              │
        ▼                             ▼                    ▼            ▼
   ═══════════════════════════════════════════════════════════════════════════
                    BANCO DE DADOS RELACIONAL COMPARTILHADO ÚNICO
   ═══════════════════════════════════════════════════════════════════════════
```

### 3.1 Sintomas que Denunciam um Monólito Distribuído
1. **Banco de Dados Compartilhado:** Múltiplos serviços acessam e alteram o mesmo esquema relacional diretamente.
2. **Implantação em Cadeia Obrigatória (*Lockstep Releases*):** Os serviços não conseguem subir para produção isoladamente; uma release exige que os 8 serviços sejam implantados juntos em uma ordem exata.
3. **Alto Acoplamento Temporal e Falha em Cascata:** As requisições encadeiam chamadas HTTP síncronas entre serviços. Se um serviço cai ou sofre lentidão, todos os outros travam em efeito dominó.

### 3.2 Por que é o Pior dos Dois Mundos?
* **Perde as vantagens do Monólito Tradicional:** Perde a simplicidade operacional de uma única aplicação, a velocidade de chamadas de método em memória (sem overhead de rede) e as transações ACID imediatas com integridade referencial nativa.
* **Herda todas as dores dos Sistemas Distribuídos:** Ganha latência de rede, necessidade de tracing distribuído, complexidade de governança, custos de infraestrutura e múltiplos pontos de falha.

---

## 4. Comparativo de Arquiteturas de Aplicação

| Dimensão | Monólito Tradicional | Monólito Distribuído (Antipadrão) | Microsserviços Genuínos |
|---|---|---|---|
| **Base de Código** | Unificada (único repositório/projeto). | Múltiplos repositórios/projetos. | Múltiplos repositórios por contexto. |
| **Banco de Dados** | **Único e compartilhado** (esquema unificado). | **Único e compartilhado** (alto acoplamento no DB). | **Database-per-Service** (isolado por serviço). |
| **Processo de Implantação** | Uma única unidade de implantação (*deploy unit*). | Múltiplas unidades, mas **dependentes entre si**. | **Totalmente independente por serviço**. |
| **Comunicação Interna** | Chamadas de função em memória (latência zero). | Chamadas de rede síncronas com alto acoplamento. | APIs REST/gRPC e eventos assíncronos desacoplados. |
| **Consistência de Dados** | **Consistência Forte (ACID)** imediata no banco. | Falhas de transação em chamadas de rede sem ACID. | **Consistência Eventual** e Padrão Saga. |

> **Monólito pode ser distribuído?** Sim! Uma arquitetura monolítica tradicional pode ser executada de forma distribuída (ex.: rodando em 20 nós de servidores atrás de um balanceador de carga para escala). A diferença em relação aos microsserviços é que a aplicação monolítica distribuída compartilha o mesmo código e é implantada como uma unidade inteira, enquanto microsserviços são serviços desacoplados em ciclo de vida e tecnologia.

---

## 5. Consistência de Dados entre Serviços: O Padrão Saga

Como cada microsserviço possui seu próprio banco de dados isolado, transações que envolvem múltiplos serviços não podem utilizar transações ACID locais nem o protocolo tradicional de *Two-Phase Commit (2PC)* (que é extremamente lento, bloqueante e vulnerável em ambientes de nuvem conforme o Teorema CAP).

A solução padrão é adotar a **Consistência Eventual (*Eventual Consistency*)** por meio do **Padrão Saga (*Saga Pattern*)**:

```
TRANSAÇÃO DISTRIBUÍDA BEM-SUCEDIDA (Saga)
  (1) [Serviço Pedido] ──► (2) [Serviço Pagamento] ──► (3) [Serviço Estoque] ──► [Fim: Sucesso]
      Cria Pedido              Debita Cartão                Reserva Produto

CENÁRIO DE FALHA COM TRANSAÇÃO COMPENSATÓRIA (Rollback Semântico)
  (1) [Serviço Pedido] ──► (2) [Serviço Pagamento] ──► (3) [Serviço Estoque: SEM ESTOQUE!]
      Cria Pedido              Debita Cartão                             │ (Dispara Falha)
          ▲                            ▲                                 │
          │                            └──── Estorna Cartão ◄────────────┤
          └──────── Cancela Pedido ◄─────────────────────────────────────┘
```

* **Mecânica da Saga:** Uma saga é uma sequência de **transações locais**. Cada serviço executa sua transação no seu banco de dados local e emite um evento de sucesso. O próximo serviço escuta o evento e executa sua transação local.
* **Tratamento de Falhas (Transações Compensatórias):** Se uma etapa falhar (ex.: não há estoque para o produto), a saga dispara uma cadeia de **transações de compensação** em ordem inversa (estornar o débito no cartão e marcar o pedido como cancelado) para desfazer os efeitos de negócio, garantindo que o sistema convirja eventualmente para um estado consistente.
