Used tool: read_url_content
Used tool: read_url_content
Used tool: read_url_content
Used tool: read_url_content
Viewed content.md:1-800
Viewed content.md:700-1499
Viewed content.md:700-1480
Viewed content.md:700-1499

Com base nos princípios, desafios e padrões arquiteturais abordados nos artigos — abstraindo os produtos específicos de nuvem e focando estritamente em **conceitos, distinções e decisões de engenharia e arquitetura de dados** —, segue um conjunto estruturado de perguntas para revisão e estudo aprofundado.

---

# 📚 Questionário de Revisão Arquitetural

---

## Módulo 1: OLTP (Processamento de Transações Online)

### 1.1 Fundamentos e Características
1. **Definição e Carga de Trabalho:** O que caracteriza essencialmente um sistema OLTP em termos do padrão de operações (*write-heavy* vs. *read-heavy*), granularidade das transações e latência esperada?
2. **Garantias ACID:** Explique o significado de cada uma das propriedades ACID no contexto OLTP. Por que a *Atomicidade* e a *Consistência* são cruciais para operações financeiras ou de controle de estoque?
3. **Estratégias de Concorrência:** Qual é a diferença fundamental entre estratégias de bloqueio *pessimista* e *otimista* em bancos de dados transacionais e em quais cenários cada uma é preferível?

### 1.2 Modelagem e Armazenamento
4. **Normalização:** Por que os bancos de dados OLTP costumam adotar formas normais elevadas (ex: 3ª Forma Normal)? Quais são os benefícios dessa escolha para a integridade e custo de gravação?
5. **Esquema na Gravação (*Schema-on-Write*):** O que significa ter um esquema rigidamente imposto na gravação e que impacto isso traz para a confiabilidade dos dados da aplicação?

### 1.3 Limitações e Desafios
6. **Degradação por Agregações:** Por que a execução de consultas analíticas pesadas (com agregações sobre milhões de linhas) em uma base OLTP pode prejudicar as operações diárias da aplicação?
7. **Gestão de Histórico e Ciclo de Vida:** Por que reter o histórico transacional completo por anos em um banco OLTP torna-se um gargalo de desempenho e qual é a estratégia recomendada para mitigar esse problema?

---

## Módulo 2: OLAP (Processamento Analítico Online) & Modelagem Semântica

### 2.1 Fundamentos e Estruturas Analíticas
8. **Propósito e Carga de Trabalho:** Em contraste com o OLTP, qual é o objetivo principal de um sistema OLAP e por que sua carga de trabalho é caracterizada como *read-heavy* e de baixa frequência de escrita individual?
9. **Esquema Estrela vs. Floco de Neve (*Star Schema* vs. *Snowflake Schema*):** Como a modelagem dimensional difere da modelagem normalizada relacional? Quais são os papéis das tabelas de **Fato** e das tabelas de **Dimensão**?
10. **Armazenamento Colunar (*Columnstore*):** Por que o formato de armazenamento orientado a colunas é significativamente mais rápido para consultas OLAP do que o armazenamento tradicional orientado a linhas (*rowstore*)?

### 2.2 Camada Semântica
11. **Abstração e Fonte Única da Verdade:** Qual é o propósito de uma *camada semântica* entre os dados analíticos brutos/estruturados e as ferramentas de relatório? Que problemas de governança ela resolve?
12. **Modelos Tabulares vs. Multidimensionais:** Quais são as semelhanças e distinções conceituais entre modelos de dados tabulares e os tradicionais cubos multidimensionais?
13. **Operações Analíticas (*Slicing & Dicing*):** O que significam os conceitos de *slice*, *dice*, *drill-down* e *drill-up* na exploração de dados analíticos?

### 2.3 Desafios e Paradigmas Híbridos
14. **Latência de Atualização:** Por que os dados em sistemas OLAP geralmente não são atualizados em tempo real transacional, operando em lotes ou intervalos definidos?
15. **Conceito de HTAP (*Hybrid Transactional/Analytical Processing*):** O que é o processamento híbrido transacional/analítico, qual problema ele se propõe a resolver e quais os compromissos (*trade-offs*) envolvidos?

---

## Módulo 3: Integração de Dados — ETL, ELT, ETL Reverso e Streaming

### 3.1 ETL vs. ELT
16. **Diferença Estrutural:** Qual é a distinção central entre os fluxos de **ETL** (*Extract, Transform, Load*) e **ELT** (*Extract, Load, Transform*) no que diz respeito ao local e momento onde o processamento computacional ocorre?
17. **Critérios de Decisão (ETL vs. ELT):**
    * Em que circunstâncias (ex.: capacidade de processamento do destino, conformidade/mascaramento de dados, evolução de esquemas) o **ETL** ainda é a melhor opção?
    * Por que o advento do *Big Data* e de mecanismos distribuídos com escalabilidade elástica favoreceu a transição massiva para **ELT**?
18. **Tabelas de *Staging* vs. Consultas Pushdown:** Qual o papel das áreas de *staging* intermediárias no ETL tradicional em comparação com o uso de formatos otimizados (como Parquet) e *pushdown de predicados* no ELT moderno?

### 3.2 Orquestração e Pipelines
19. **Fluxo de Controle (*Control Flow*) vs. Fluxo de Dados (*Data Flow*):** Como esses dois conceitos se relacionam dentro de um pipeline de orquestração? Como restrições de precedência e contêineres de repetição são utilizados?
20. **Paralelização e Idempotência:** Por que pipelines de dados devem ser projetados em torno de limites de partição (ex.: data, locatário, *shard*) e garantir execuções idempotentes?

### 3.3 Novos Paradigmas: ETL Reverso e Streaming
21. **ETL Reverso (*Reverse ETL*):** O que é ETL Reverso, qual o fluxo de dados que ele estabelece (origem e destino) e como ele difere do objetivo do ETL analítico tradicional? Dê exemplos práticos de uso (ex.: CRM, automação).
22. **Streaming e Caminho Ativo (*Hot Path*):** Como os paradigmas de arquitetura Lambda e Kappa tratam o fluxo de dados contínuo? Quais tipos de transformações (*em movimento*) são aplicadas antes da persistência?
23. **Confiabilidade no Streaming:** Explique a importância e o funcionamento de:
    * *Checkpointing* e semântica de entrega (*at-least-once* / *exactly-once*).
    * *Watermarking* (marcas d'água para eventos atrasados).
    * Filas de mensagens mortas (*Dead-Letter Queues* - DLQ).

---

## Módulo 4: Data Lake, Arquitetura Medalhão e Lakehouse

### 4.1 Conceitos e Fundamentos
24. **Data Lake vs. Data Warehouse:** Compare esses dois conceitos nos seguintes eixos:
    * Tipos de dados suportados (estruturados, semiestruturados, não estruturados).
    * Momento de aplicação do esquema (*Schema-on-Read* vs. *Schema-on-Write*).
    * Custo e desacoplamento de armazenamento vs. computação.
    * Casos de uso típicos.
25. **Arquitetura de Medalhão:** Descreva a finalidade e as características dos dados em cada uma das camadas da arquitetura medalhão:
    * Camada **Bronze** (Bruta / *Raw*)
    * Camada **Prata** (Purificada / *Cleansed* / *Enriched*)
    * Camada **Ouro** (Curada / *Aggregated* / Pronta para consumo)
26. **O Conceito de Lakehouse:** O que é a arquitetura *Lakehouse* e como ela tenta unificar as vantagens de escalabilidade/baixo custo do Data Lake com o controle transacional (ACID) e velocidade de consulta do Data Warehouse?

### 4.2 Desafios e Governança
27. **O Risco do Pântano de Dados (*Data Swamp*):** O que torna um Data Lake um *Data Swamp* e quais mecanismos de governança, metadados e catalogação são indispensáveis para evitar esse cenário?
28. **Desempenho e Otimização em Escala:** Em sistemas distribuídos que consultam arquivos brutos ou colunares em Data Lakes, quais técnicas (ex.: particionamento, indexação de metadados, compactação de pequenos arquivos) são críticas para garantir consultas rápidas?

---

## Módulo 5: Cenários Arquiteturais e Análise Comparativa (Prática e Trade-offs)

### Cenário A: E-commerce de Alto Volume
> **Situação:** Uma plataforma de comércio eletrônico precisa processar milhares de pedidos por segundo, garantindo que o estoque nunca fique negativo. Simultaneamente, o time de marketing precisa de relatórios com vendas consolidadas por categoria e região a cada hora, e os cientistas de dados precisam treinar modelos de recomendação usando o comportamento de cliques brutos em tempo real dos usuários.
* **Pergunta:** Como você organizaria os componentes de dados para essa empresa? Onde se aplicaria OLTP, Data Lake, ELT/ETL e OLAP/Camada Semântica para atender aos três públicos sem interferência mútua?

### Cenário B: Migração de ETL Legado para ELT em Nuvem
> **Situação:** Uma empresa possui um servidor central de ETL que leva 6 horas toda noite para processar transformações complexas antes de carregar os dados no banco de relatórios. Conforme o volume aumentou, a janela noturna de processamento estourou.
* **Pergunta:** Qual mudança conceitual (de ETL para ELT com computação distribuída) resolveria o problema? Quais requisitos o sistema de destino precisa ter para que essa migração seja bem-sucedida?

### Cenário C: Schema-on-Read vs. Schema-on-Write
> **Situação:** Uma empresa coleta logs de telemetria de dispositivos IoT em formato JSON que mudam frequentemente de estrutura com novas atualizações de firmware.
* **Pergunta:** Por que salvar esses logs diretamente em um Data Lake (*Schema-on-Read*) é mais viável do que tentar inseri-los diretamente em uma tabela relacional estruturada (*Schema-on-Write*)? Qual é o custo/desafio dessa escolha no momento em que esses dados forem consumidos?

---

## 🎯 Quadro Resumo para Autoavaliação

Para validar seu entendimento após responder às perguntas, verifique se você domina as seguintes distinções-chave:

| Conceito | Foco Principal | Esquema | Carga Típica | Estrutura de Dados |
| :--- | :--- | :--- | :--- | :--- |
| **OLTP** | Operação diária, integridade transacional | *Schema-on-Write* rígido | *Write-heavy* / pontual | Altamente Normalizada (3NF) |
| **OLAP** | Análise histórica, BI, agregação | *Schema-on-Write* / Semântico | *Read-heavy* / volumosa | Desnormalizada (Estrela/Snowflake/Cubos) |
| **Data Lake** | Armazenamento universal, exploração, IA/ML | *Schema-on-Read* | Ingestão contínua em massa | Bruta (Estruturada, Semiestruturada e Não-estruturada) |
| **Data Warehouse**| Relatórios corporativos e métricas consolidadas | *Schema-on-Write* | Cargas periódicas (Batch) e leituras | Tabular Relacional / Modelagem Dimensional |
| **ETL vs. ELT** | Onde ocorre o custo computacional da transformação | Depende do destino | Batch ou Streaming | *ETL:* Staging/Engine próprio; *ELT:* No próprio storage/warehouse destino |
| **Reverse ETL** | Ativação operacional de métricas analíticas | Conforme sistema de destino | Batch / Micro-batch | Dos repositórios analíticos para CRMs e Apps |


Inclua as questões 1,3,4,5,6,7,8,10,11,12,13, 14, 15, 17, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28

e os cenários

Cenário A
Cenário B
Cenário C

A 9 fica de fora por enquanto, não porque é ruim, mas porque preciso entender melhor.
18 vale a pena cadastrar, mas como fora de foco no momento

Nas questões 25 e 28 parte do gabarito está na própria questão, isso precisa ser alterado.

