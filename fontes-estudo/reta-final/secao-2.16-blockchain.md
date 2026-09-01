# Blockchain (Arquitetura, Consenso e Criptografia)

> Item **19** ("*Blockchain*") do bloco *Desenvolvimento de Sistemas*, Módulo II — Perfil 3, do Anexo I do edital DATAPREV 2026. Corresponde à **Seção 2.16** do banco de questões.

---

## 1. O que é um Bloco e o Encadeamento Criptográfico

A **Blockchain** é um livro-razão distribuído (*Distributed Ledger Technology* - DLT), imutável e descentralizado, estruturado como uma sequência linear de **blocos de dados encadeados criptograficamente**.

Cada bloco agrupa um conjunto de transações financeiras ou de contratos inteligentes que foram validadas pelos nós da rede. O encadeamento ocorre porque **cada novo bloco contém em seu cabeçalho o hash criptográfico exato do bloco que o antecedeu (*Previous Block Hash*)**. Essa referência cria uma cadeia temporal contínua que remonta até o primeiro bloco da rede (o **Bloco Gênese** ou Bloco 0).

```
BLOCO N-1                           BLOCO N                             BLOCO N+1
┌──────────────────────────┐        ┌──────────────────────────┐        ┌──────────────────────────┐
│ Cabeçalho do Bloco N-1   │        │ Cabeçalho do Bloco N     │        │ Cabeçalho do Bloco N+1   │
│ • Hash Anterior: 000...  │        │ • Hash Anterior: ab4f... ├───────►│ • Hash Anterior: 7c1e... │
│ • Merkle Root: 91a2...   │        │ • Merkle Root: 3f8b...   │        │ • Merkle Root: e40a...   │
│ • Nonce: 849204          │        │ • Nonce: 104857          │        │ • Nonce: 938112          │
├──────────────────────────┤        ├──────────────────────────┤        ├──────────────────────────┤
│ Corpo (Transações)       │        │ Corpo (Transações)       │        │ Corpo (Transações)       │
│ • Tx Coinbase            │        │ • Tx Coinbase            │        │ • Tx Coinbase            │
│ • Tx 1, Tx 2, Tx 3...    │        │ • Tx 1, Tx 2, Tx 3...    │        │ • Tx 1, Tx 2, Tx 3...    │
└────────────┬─────────────┘        └────────────┬─────────────┘        └──────────────────────────┘
             │                                   │
             └────── Hash do Bloco N-1 ──────────┘
                     (ex: ab4f...)
```

---

## 2. Anatomia Interna de um Bloco

Um bloco em uma blockchain pública (como o Bitcoin) é estritamente dividido em duas partes: **Cabeçalho** e **Corpo**.

### 2.1 O Cabeçalho do Bloco (*Block Header*)
O cabeçalho concentra todos os metadados de controle necessários para o encadeamento e para o mecanismo de consenso. No protocolo Bitcoin, possui tamanho fixo de **80 bytes** e contém 6 campos:

1. **Versão do Bloco (*Version*):** Número que indica as regras e atualizações do protocolo em vigor.
2. **Hash do Bloco Anterior (*Previous Block Hash*):** Hash SHA-256 de 256 bits do cabeçalho do bloco precedente. É o elo que garante a integridade da ordem temporal.
3. **Raiz de Merkle (*Merkle Root*):** Hash criptográfico único que resume e autentica matematicamente **todas as transações contidas no corpo do bloco**.
4. **Carimbo de Tempo (*Timestamp*):** Hora universal aproximada em que o bloco foi minerado.
5. **Alvo de Dificuldade (*Bits / Difficulty Target*):** Valor numérico que define o limiar de dificuldade para a mineração (o hash do bloco deve ser menor que esse alvo).
6. **`Nonce` (*Number used ONCE*):** Contador numérico inteiro arbitrário que os mineradores incrementam continuamente durante o *Proof of Work* até encontrarem um hash de cabeçalho válido.

### 2.2 O Corpo do Bloco (*Block Body*)
Contém a lista sequencial de todas as transações confirmadas naquele bloco. A primeira transação é sempre a **Transação Coinbase**, que gera novas moedas para premiar o minerador que encontrou o bloco.

---

## 3. O Registro de Saldos: Onde Vive o Dinheiro?

> **Atenção — Ponto Crítico de Prova:** O saldo das contas/carteiras dos participantes **NÃO é gravado como um número estático diretamente dentro dos blocos**.

Não existe no bloco do Bitcoin uma "tabela de saldos" como `Conta do Ronald = 5 BTC`. A forma de representar a riqueza varia fundamentalmente conforme o modelo de estado adotado pela blockchain:

```
MODELO UTXO (Bitcoin)                             MODELO DE CONTAS (Ethereum)
Transações consomem e geram saídas não gastas      Mantém balancete explícito de saldos

  [ UTXO 1: 3 BTC ] ──┐                             Conta A (Saldo: 10 ETH)
                      ├──► [ Transação: 5 BTC ] ──►          │
  [ UTXO 2: 2 BTC ] ──┘     • Destino: 4.5 BTC               │ (Transfere 4 ETH)
                            • Troco:   0.5 BTC               ▼
                                                    Conta B (Saldo: 4 ETH)
```

### 3.1 Modelo UTXO (*Unspent Transaction Output*) — Adotado pelo Bitcoin
* O Bitcoin funciona como um livro-caixa de **cédulas eletrônicas indivisíveis chamadas UTXOs**.
* Uma transação não "subtrai de um saldo"; ela **consome integralmente uma ou mais UTXOs existentes** como entradas (*inputs*) e **cria novas UTXOs** como saídas (*outputs*). A diferença entre entradas e saídas que sobra é o "troco" (que retorna para o próprio remetente) ou a taxa paga aos mineradores.
* **O Saldo de um usuário é dinâmico:** É calculado pelos softwares de carteira somando o valor de todas as UTXOs não gastas existentes em toda a blockchain cuja chave pública corresponda à chave privada daquele usuário.

### 3.2 Modelo Baseado em Contas (*Account-Based Model*) — Adotado pela Ethereum
* Funciona de maneira análoga a um sistema de contas bancárias tradicional.
* O protocolo mantém um **Estado Global (*World State*)**, onde cada endereço possui um registro explícito contendo seu **saldo atual de moedas**, seu código (em contratos inteligentes) e um contador sequencial de transações (*nonce* de conta para evitar ataques de repetição).
* Cada transação simplesmente debita o saldo da conta de origem e credita o saldo da conta de destino.

---

## 4. Árvore de Merkle e Raiz de Merkle (*Merkle Root*)

A **Árvore de Merkle** é uma árvore binária de hashes criptográficos que permite resumir um grande volume de transações em um único hash representativo de 32 bytes (a **Merkle Root**), armazenado no cabeçalho do bloco:

```
                            RAIZ DE MERKLE (Merkle Root)
                                   Hash(H_AB + H_CD)
                                          │
                    ┌─────────────────────┴─────────────────────┐
                    ▼                                           ▼
                  H_AB                                        H_CD
              Hash(H_A + H_B)                             Hash(H_C + H_D)
                    │                                           │
          ┌─────────┴─────────┐                       ┌─────────┴─────────┐
          ▼                   ▼                       ▼                   ▼
         H_A                 H_B                     H_C                 H_D
      Hash(Tx A)          Hash(Tx B)              Hash(Tx C)          Hash(Tx D)
          │                   │                       │                   │
          ▼                   ▼                       ▼                   ▼
     Transação A         Transação B             Transação C         Transação D
```

### 4.1 Prova de Merkle (*Merkle Proof*) e Clientes Leves (SPV)
A grande vantagem da Árvore de Merkle é habilitar a **Verificação Simplificada de Pagamentos (SPV — *Simplified Payment Verification*)**:
* Um auditor, nó leve de smartphone ou sistema parceiro **não precisa baixar os gigabytes do bloco inteiro** para provar que uma transação específica (ex.: `Tx A`) está inclusa no bloco.
* Para verificar a `Tx A`, o nó leve precisa apenas de:
  1. O **cabeçalho do bloco** (que contém a `Merkle Root` oficial).
  2. A **Prova de Merkle (o caminho de autenticação)**: apenas os hashes irmãos no caminho até o topo (no exemplo acima, bastam o `Hash(Tx A)`, o `H_B` e o `H_CD`).
* Com apenas $\log_2(N)$ operações de hash, o auditor calcula a raiz e compara com a `Merkle Root` do cabeçalho. Se coincidirem, a inclusão da transação está matematicamente provada.

---

## 5. A Imutabilidade e a Inviabilidade Econômica da Fraude

Por que a blockchain é considerada praticamente impossível de ser adulterada retroativamente?

1. **O Efeito Avalanche do Hash:** Se um invasor alterar um único caractere de uma transação antiga no Bloco 100, o hash daquela transação muda, o que altera a `Merkle Root`, que por sua vez altera completamente o hash do Bloco 100.
2. **Quebra da Cadeia:** Como o Bloco 101 guarda em seu cabeçalho o hash antigo do Bloco 100, o elo de ligação entre eles é imediatamente quebrado. Todos os nós da rede descentralizada rejeitarão o Bloco 100 adulterado.
3. **Custo Econômico Proibitivo:** Para que a fraude fosse aceita, o atacante teria que recalcular o *Proof of Work* (encontrar novos nonces) do Bloco 100 e de **todos os blocos subsequentes (101, 102, 103...) mais rápido do que todos os mineradores honestos do mundo somados** (a chamada regra da cadeia mais longa).
4. O poder computacional massivo e o custo financeiro colossal de energia exigidos para executar um "Ataque de 51%" superam em muito qualquer ganho financeiro obtido com a fraude, tornando a adulteração **economicamente irracional e inviável**.

---

## 6. Validação de Transações vs Mecanismos de Consenso

É crucial não confundir o processo de validação de uma transação isolada com o mecanismo de consenso da rede:

* **Validação de Transação (Verificação Local):**
  * É uma operação **determinística, isolada e barata** executada individualmente por qualquer nó da rede.
  * Verifica regras lógicas: a assinatura digital ECDSA confere com a chave pública? As UTXOs de entrada existem e não foram gastas anteriormente (*prevenção de double spending*)? O valor das saídas não supera o das entradas?
* **Mecanismo de Consenso (Acordo Distribuído Global):**
  * É o **algoritmo distribuído de governança** que garante que todos os nós independentes da rede concordem sobre qual é a única versão cronológica oficial e verdadeira da cadeia de blocos, mesmo na presença de nós desconhecidos, falhas de rede ou atacantes maliciosos.

---

## 7. Comparativo de Consenso: Proof of Work (PoW) vs Proof of Stake (PoS)

| Critério | Proof of Work (PoW — Prova de Trabalho) | Proof of Stake (PoS — Prova de Participação) |
|---|---|---|
| **Recurso Exigido do Validador** | **Poder Computacional e Energia Elétrica:** Processadores especializados (ASICs/GPUs) realizando trilhões de cálculos de hash por segundo. | **Capital Financeiro / Criptomoedas em Custódia:** Tokens travados como garantia (*stake*) no contrato da rede. |
| **Papel do Validador** | **Minerador:** Compete para resolver um quebra-cabeça criptográfico probabilístico (encontrar um `nonce` cujo hash seja menor que o alvo). | **Forjador / Validador:** É selecionado de forma pseudo-aleatória (ponderada pelo volume de *stake*) para propor e validar novos blocos. |
| **Punição para Fraude** | **Custo Irrecuperável:** Desperdício de energia elétrica e tempo computacional sem receber recompensas. | **Slashing:** Perda financeira direta e confisco automático de parte ou da totalidade das moedas travadas em *stake*. |
| **Consumo de Energia** | Extremamente alto (comparável ao consumo de países inteiros). | Praticamente nulo (redução superior a 99.9% em relação ao PoW). |
| **Exemplos Canônicos** | Bitcoin, Litecoin, Dogecoin. | Ethereum (pós-*The Merge*), Cardano, Solana, Polkadot. |
