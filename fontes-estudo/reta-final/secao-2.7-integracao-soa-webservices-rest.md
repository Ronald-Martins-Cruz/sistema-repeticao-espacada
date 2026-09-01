# Integração de Sistemas, SOA e Web Services

> Itens **7** ("*Arquitetura de software. Interoperabilidade de sistemas. Arquitetura e linguagem orientada a serviços. Web services. API, Swagger*") e **9** ("*Padrões XML, XSLT, UDDI, REST e JSON*") do bloco *Desenvolvimento de Sistemas*, Módulo II — Perfil 3, do Anexo I do edital DATAPREV 2026. Corresponde à **Seção 2.7** do banco de questões.

---

## 1. Arquitetura Orientada a Serviços (SOA — *Service-Oriented Architecture*)

A **SOA** é um estilo de arquitetura de software corporativo no qual as funcionalidades de negócio são estruturadas na forma de **serviços autônomos, reutilizáveis e interoperáveis**, disponibilizados através de uma rede por meio de interfaces e contratos bem definidos.

Em uma organização que adota SOA, os sistemas legados e novas aplicações não se comunicam por conexões diretas ponto a ponto ou por compartilhamento direto de tabelas de banco de dados; em vez disso, expõem e consomem serviços.

```
┌─────────────────────────────────────────────────────────┐
│              Aplicações Consumidoras                    │
│      (Portal Web, Aplicativo Mobile, Sistema ERP)       │
└───────────────────────────┬─────────────────────────────┘
                            │ (Chamadas padronizadas)
                            ▼
┌─────────────────────────────────────────────────────────┐
│     Barramento de Serviços Corporativo (ESB)            │
│   • Roteamento   • Transformação de Mensagens           │
│   • Segurança    • Orquestração e Mediação              │
└───────┬───────────────────┬───────────────────┬─────────┘
        │                   │                   │
        ▼                   ▼                   ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│  Serviço de   │   │  Serviço de   │   │  Serviço de   │
│   Clientes    │   │   Cobrança    │   │   Contratos   │
└───────────────┘   └───────────────┘   └───────────────┘
```

### 1.1 Os Dois Objetivos Declarados da SOA
As bancas de concurso cobram reiteradamente os dois pilares que justificam a adoção de SOA:

1. **Baixo Acoplamento (*Loose Coupling*):**
   * Os serviços devem minimizar as dependências diretas entre si.
   * O consumidor do serviço conhece apenas a sua **interface pública (contrato)** e não os detalhes internos de implementação (qual linguagem foi usada, qual banco de dados armazena as tabelas ou em qual servidor o código roda).
   * Mudanças internas na implementação do serviço **não devem impactar nem exigir alterações** nos sistemas que o consomem.

2. **Alta Interoperabilidade (*High Interoperability*):**
   * Capacidade de sistemas heterogêneos (construídos em diferentes linguagens de programação, sistemas operacionais e plataformas de hardware) trocarem dados e executarem processos conjuntos de forma transparente, utilizando protocolos e formatos de comunicação universais e abertos (como HTTP, XML, JSON e SOAP/REST).

---

## 2. Acoplamento e Coesão na Integração de Sistemas

* **Alto Acoplamento (*Tight Coupling*):** Ocorre quando um componente ou serviço depende intimamente da estrutura interna, da linguagem, do estado em memória ou do banco de dados de outro. Qualquer modificação em um dos lados gera um efeito dominó, exigindo a alteração, recompilação ou reimplantação do outro.
* **Baixo Acoplamento (*Loose Coupling*):** Ocorre quando os componentes interagem exclusivamente através de contratos abstratos estáveis, com independência de ciclo de vida e tecnologia. **É o estado que a SOA e as boas práticas de arquitetura buscam.**

> **Cenário de Integração Externa:** Adotar uma abordagem monolítica, na qual múltiplos parceiros externos (como quatro provedores de pagamento com tecnologias e ritmos de evolução distintos) são integrados diretamente ao código central do sistema, **aumenta perigosamente o acoplamento**. Qualquer instabilidade ou alteração na biblioteca de um provedor pode derrubar a aplicação inteira. A utilização de serviços com interfaces desacopladas (Web Services / APIs REST) isola as mudanças de cada fornecedor e garante a estabilidade do ecossistema.

---

## 3. Web Services Tradicionais (SOAP) e seus Padrões

Um **Web Service** é uma solução de software projetada para apoiar a interação interoperável entre computadores através de uma rede, baseando-se em padrões abertos. No modelo clássico corporativo, os Web Services baseiam-se na pilha de protocolos XML:

```
┌────────────────────────────────────────────────────────┐
│                        UDDI                            │
│           (Registro e Descoberta de Serviços)          │
└───────────────────────────▲────────────────────────────┘
                            │ Publica / Descobre
┌───────────────────────────┴────────────────────────────┐
│                        WSDL                            │
│              (Descrição Formal do Contrato)            │
└───────────────────────────▲────────────────────────────┘
                            │ Descreve
┌───────────────────────────┴────────────────────────────┐
│                        SOAP                            │
│           (Protocolo de Troca de Mensagens XML)        │
└───────────────────────────▲────────────────────────────┘
                            │ Trafega sobre
┌───────────────────────────┴────────────────────────────┐
│              Protocolos de Transporte                  │
│                (HTTP, HTTPS, SMTP, TCP)                │
└────────────────────────────────────────────────────────┘
```

### 3.1 SOAP (*Simple Object Access Protocol*)
* É um **protocolo formal padronizado pelo W3C** para troca de informações estruturadas em ambiente descentralizado e distribuído.
* As mensagens SOAP são escritas **exclusivamente em formato XML** e possuem uma estrutura rígida dividida em quatro partes:
  * `<soap:Envelope>`: Elemento raiz obrigatório que identifica o documento XML como uma mensagem SOAP.
  * `<soap:Header>`: Elemento opcional para metadados de controle (autenticação, roteamento, assinaturas de segurança WS-Security).
  * `<soap:Body>`: Elemento obrigatório contendo os dados reais da chamada ou da resposta da operação.
  * `<soap:Fault>`: Elemento padronizado (dentro do Body) para relato de erros e exceções de processamento.
* Pode trafegar sobre múltiplos protocolos de transporte da camada de aplicação (HTTP/HTTPS, SMTP, JMS, TCP).

### 3.2 WSDL (*Web Services Description Language*)
* É uma linguagem baseada em XML utilizada para **descrever formalmente o contrato de um Web Service**.
* O documento WSDL funciona como uma especificação pública e inequívoca que descreve:
  * **O que o serviço faz:** As operações/métodos disponibilizados (`portType` / `interface`).
  * **A estrutura dos dados:** O formato e tipos de dados exatos das mensagens de entrada, saída e falhas (definidos via esquemas XML Schema / XSD em `types` e `message`).
  * **Como acessar:** O protocolo de comunicação e formato de codificação (`binding`, como SOAP sobre HTTP).
  * **Onde acessar:** O endereço de rede (URI/URL do *endpoint*) onde o serviço está hospedado (`service` e `port`).

### 3.3 UDDI (*Universal Description, Discovery and Integration*)
* Padrão baseado em XML para a criação de **registros e diretórios de serviços** (análogo às páginas amarelas e brancas corporativas).
* Permite que organizações publiquem a existência de seus Web Services (e seus respectivos WSDLs) e que clientes localizem e vinculem-se a esses serviços dinamicamente.

### 3.4 O Mito da "Flexibilidade sem Contrato" no SOAP
> **Atenção — Ponto Crítico de Prova:** Afirmar que *"implementar serviços SOAP sem definição de contratos formais aumenta a flexibilidade"* é um **erro conceitual grave**. O SOAP foi concebido em torno do princípio do **contrato formal rígido (WSDL)**. Tentar usar SOAP sem contrato quebra a interoperabilidade entre plataformas, impede a geração automatizada de clientes (*stubs*) e elimina a garantia de conformidade que justifica a existência do protocolo.

---

## 4. O Estilo Arquitetural REST (*Representational State Transfer*)

Formulado por **Roy Fielding** em sua tese de doutorado no ano 2000, o **REST** não é um protocolo nem um padrão de organização de mercado, mas sim um **estilo arquitetural de software** projetado para guiar o desenho de sistemas hipermídia distribuídos e escaláveis (como a própria World Wide Web).

### 4.1 As 6 Restrições Arquiteturais do REST
Para que uma arquitetura seja classificada como estritamente **RESTful**, ela deve aderir obrigatoriamente a cinco restrições fundamentais (e opcionalmente à sexta):

1. **Cliente-Servidor (*Client-Server*):**
   * Separação estrita de responsabilidades: o cliente cuida da interface de usuário e da experiência do usuário, enquanto o servidor gerencia o armazenamento de dados, regras de negócio e segurança.
   * Permite que clientes (web, mobile, desktop) e servidores evoluam de maneira independente.

2. **Sem Estado (*Statelessness*):**
   * Cada requisição enviada pelo cliente ao servidor deve conter **todas as informações necessárias** para que o servidor possa compreendê-la e processá-la.
   * O servidor **não deve armazenar nenhum contexto de sessão do cliente** na sua memória entre requisições subsequentes.

3. **Cacheabilidade (*Cacheable*):**
   * As respostas às requisições devem ser explicitamente ou implicitamente rotuladas como passíveis ou não de armazenamento em cache (`Cache-Control`, `ETag`).
   * Evita que requisições repetidas sobrecarreguem o servidor e reduz a latência de rede.

4. **Interface Uniforme (*Uniform Interface*):**
   * É o elemento central que simplifica e desacopla a arquitetura. É dividida em 4 sub-regras:
     * **Identificação de Recursos:** Cada recurso possui um identificador único estável (URI, ex.: `https://api.banco.com/contas/123`).
     * **Manipulação de Recursos através de Representações:** O cliente interage com os recursos através de representações (JSON, XML, HTML) enviadas com verbos padrão HTTP (`GET`, `POST`, `PUT`, `PATCH`, `DELETE`).
     * **Mensagens Autodescritivas:** Cada mensagem contém informações suficientes para descrever como processá-la (cabeçalhos de mídia como `Content-Type: application/json` e códigos de status HTTP como `200 OK`, `201 Created`, `404 Not Found`).
     * **HATEOAS (*Hypermedia as the Engine of Application State*):** A resposta do servidor fornece links de hipermídia que guiam o cliente dinamicamente sobre quais são as próximas ações possíveis a partir daquele estado.

5. **Sistema em Camadas (*Layered System*):**
   * O cliente não é capaz de discernir se está conectado diretamente ao servidor de aplicação final ou a componentes intermediários na rota (proxies reversos, balanceadores de carga, firewalls, gateways de API ou servidores de cache).
   * Habilita escalabilidade, segurança e redundância transparentes.

6. **Código sob Demanda (*Code on Demand* — Opcional):**
   * Permite que o servidor estenda temporariamente a funcionalidade do cliente transmitindo código executável (como scripts JavaScript ou applets). É a única restrição opcional do modelo.

---

## 5. O Princípio de *Statelessness* em Detalhes

A ausência de estado no servidor é uma das decisões arquiteturais mais impactantes do REST:

### 5.1 Como Habilita Escalabilidade Horizontal e Baixo Acoplamento
* Como o servidor não guarda sessão na memória local, **qualquer instância de servidor** em um cluster (atrás de um balanceador de carga) pode atender a qualquer requisição de qualquer cliente a qualquer momento.
* Se um nó de servidor falhar, o cliente pode simplesmente reenviar a requisição para outro nó sem perder o progresso.
* O balanceador de carga não precisa manter tabelas de afinidade de sessão (*sticky sessions*), facilitando o escalonamento automático (*auto-scaling*).

### 5.2 O Custo Transferido ao Cliente
* Como o servidor não lembra quem é o cliente entre uma chamada e outra, o **cliente assume a responsabilidade de gerenciar seu próprio estado**.
* Em cada requisição, o cliente deve reenviar suas credenciais de autenticação (geralmente via cabeçalho `Authorization: Bearer <token_JWT>`) e todo o contexto da transação, gerando um ligeiro aumento no volume de dados trafegados por cabeçalho (*overhead* de rede).

---

## 6. Comparativo Aprofundado: RESTful Web Services vs SOAP

| Dimensão | SOAP (*Simple Object Access Protocol*) | REST (*Representational State Transfer*) |
|---|---|---|
| **Natureza** | **Protocolo formal** estrito com especificações fechadas (W3C / OASIS). | **Estilo arquitetural** flexível fundamentado em padrões abertos da web (HTTP/URI). |
| **Formato das Mensagens** | **Exclusivamente XML** envelopado. | **Múltiplos formatos**, com amplo predomínio de **JSON** (suporta XML, HTML, texto). |
| **Definição de Contrato** | **Formal e rígido via WSDL** (obrigatório para operações e tipos). | **Implícito / Aberto**, documentado por especificações OpenAPI (Swagger) ou HATEOAS. |
| **Operações e Verbos** | As operações são funções personalizadas no corpo XML (foco em verbos/ações: `consultarSaldo`, `efetuarPagamento`). | Foco em **substantivos (Recursos)** manipulados pelos métodos universais do HTTP (`GET`, `POST`, `PUT`, `DELETE`). |
| **Grau de Acoplamento** | **Médio a Alto:** Mudanças de tipos no WSDL frequentemente exigem regerar stubs no cliente. | **Baixo:** Evolução de representações (adicionar campos no JSON) raramente quebra clientes existentes. |
| **Transporte** | Neutro: HTTP, HTTPS, SMTP, TCP, JMS. | Projetado primariamente sobre a infraestrutura do **HTTP / HTTPS**. |
| **Desempenho e Sobrecarga** | Mais pesado devido ao parsing de XML e headers do Envelope SOAP. | Mais leve e rápido, com menor consumo de largura de banda e parsing nativo. |
| **Segurança e Transações** | Padrões corporativos maduros integrados: **WS-Security**, **WS-ReliableMessaging**, **WS-AtomicTransaction**. | Baseado na segurança da camada de transporte (**HTTPS/TLS**) e padrões web de tokens (**OAuth 2.0 / JWT**). |

---

## 7. RPC (*Remote Procedure Call*) vs REST

* **RPC (Chamada de Procedimento Remoto):** Modela a comunicação em rede como a invocação de uma função ou método em uma máquina remota (ex.: `cliente.calcularImposto(dados)` via gRPC, RMI ou XML-RPC). Foca em **ações e comandos**, exigindo acoplamento temporal e de tipos com stubs gerados.
* **REST:** Modela a comunicação em torno de **recursos e seus estados**. Em vez de expor procedimentos remotos com dependência de tipos de linguagem, expõe recursos identificados por URIs e operados por verbos padrão da web.
* **Por que RPC com contrato rígido é inadequado para múltiplos parceiros externos heterogêneos:** Obriga todos os parceiros a adotarem os mesmos compiladores/stubs de interface, e qualquer adição de parâmetro ou método exige a atualização coordenada de todos os consumidores, quebrando a autonomia das partes.
