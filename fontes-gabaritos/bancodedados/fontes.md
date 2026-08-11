# Fontes — Seção 2.22 (Bancos de Dados)

Fontes para escrever os pontos-chave de **Q218–Q227** (hoje com zero
`ponto_chave`). PDFs arquivados nesta pasta; páginas web listadas por URL.
Todas as URLs foram verificadas em **30/07/2026**.

A seção cobre banco de dados pelo **ângulo analítico e distribuído** — é o
recorte herdado das questões **Q65** (relacional × multidimensional) e **Q66**
(NoSQL) da prova real de 2024. Por isso as fontes se dividem em dois eixos:
**OLAP/multidimensional** (Q218–Q221) e **NoSQL/ACID/CAP** (Q222–Q227).

---

## Arquivados aqui (PDF)

### Eixo OLAP / multidimensional — Q218–Q221

- `codd-1993-providing-olap.pdf` — **Codd, E.F.; Codd, S.B.; Salley, C.T.,
  "Providing OLAP to User-Analysts: An IT Mandate" (1993)**. O paper que
  **cunhou o termo OLAP** e as 12 regras. Fonte primária para a fronteira
  OLTP × OLAP e para a *visão conceitual multidimensional* (regra 1) —
  exatamente o que Q218/Q219/Q220 cobram.
  Origem: https://www.softwaregems.com.au/Documents/Article/Database/Relational%20Model/Codd%20E%20F/Providing%20OLAP%20to%20User-Analysts.pdf
  > Ressalva de honestidade intelectual: o paper foi **patrocinado pela Arbor
  > Software** (Essbase), o que gerou controvérsia à época. Continua sendo a
  > fonte primária do termo, mas não é neutro. Para definição neutra, use
  > Kimball ou Silberschatz.

- `kimball-dimensional-modeling-techniques.pdf` — **Kimball Group, "Dimensional
  Modeling Techniques"** (extraído de *The Data Warehouse Toolkit*, 3ª ed.).
  Definições oficiais de **tabela fato**, **tabela dimensão**, **grão**,
  **esquema estrela** e **fatos aditivos / semiaditivos / não aditivos**.
  É a fonte canônica para **Q221** (dimensão, métrica, agregação).
  Origem: https://www.kimballgroup.com/wp-content/uploads/2013/08/2013.09-Kimball-Dimensional-Modeling-Techniques11.pdf

### Eixo ACID / BASE / CAP — Q222, Q225

- `harder-reuter-1983-acid.pdf` — **Härder, T.; Reuter, A., "Principles of
  Transaction-Oriented Database Recovery"**, *ACM Computing Surveys* 15(4),
  dez/1983. **O paper que cunhou o acrônimo ACID.** Fonte primária de Q225.
  Origem (espelho CMU): http://www.cs.cmu.edu/afs/cs.cmu.edu/academic/class/15712-s05/www/lectures/Haeder83lecture.pdf
  > ⚠️ É um **scan sem camada de texto** — dá para ler, mas não dá para buscar
  > nem copiar. Para o enunciado de ACID em texto pesquisável, use
  > Silberschatz cap. 17 (link abaixo).

- `gilbert-lynch-2002-cap-proof.pdf` — **Gilbert, S.; Lynch, N., "Brewer's
  Conjecture and the Feasibility of Consistent, Available, Partition-Tolerant
  Web Services"**, *ACM SIGACT News* 33(2), 2002. A **prova formal** do
  teorema CAP. Fonte primária de Q225.
  Origem (página do próprio Gilbert, NUS): https://www.comp.nus.edu.sg/~gilbert/pubs/BrewersConjecture-SigAct.pdf

- `brewer-2012-cap-twelve-years-later.pdf` — **Brewer, E., "CAP Twelve Years
  Later: How the 'Rules' Have Changed"**, *IEEE Computer*, fev/2012.
  **Fonte mais importante da seção para calibrar Q225 em profundidade D3.**
  É onde o próprio autor do teorema desmonta a leitura ingênua "escolha 2 de 3":
  a escolha entre C e A **só existe durante uma partição**; fora dela, dá para
  ter as duas. Texto literal: *"CAP prohibits only a tiny part of the design
  space: perfect availability and consistency in the presence of partitions,
  which are rare."*
  Origem: https://sites.cs.ucsb.edu/~rich/class/cs293b-cloud/papers/brewer-cap.pdf

- `gilbert-lynch-2012-perspectivas-cap.pdf` — **Gilbert, S.; Lynch, N.,
  "Perspectives on the CAP Theorem"** (2012). Os autores da prova revisitando-a
  e situando CAP na teoria de sistemas distribuídos. Complemento de Brewer 2012.
  Origem (MIT CSAIL): https://groups.csail.mit.edu/tds/papers/Gilbert/Brewer2.pdf

### Eixo NoSQL — Q223, Q224, Q226, Q227

- `fowler-sadalage-nosql-distilled-poster.pdf` — **Fowler, M.; Sadalage, P.,
  "The future is: NoSQL Databases / Polyglot Persistence"** (2012), o pôster que
  condensa *NoSQL Distilled*. Taxonomia dos **quatro tipos** (chave-valor,
  documento, família de colunas, grafo), a noção de **agregado** e o mapa de
  **persistência poliglota** — é praticamente o gabarito visual de **Q227**.
  Origem: https://martinfowler.com/articles/nosql-intro-original.pdf

---

## Páginas web (não arquivadas)

### Livros-texto de referência (o que a FGV costuma seguir)

- **Silberschatz, Korth & Sudarshan — *Database System Concepts*, 7ª ed.**
  Site oficial com **slides completos em PDF, gratuitos**: https://www.db-book.com/
  (espelho dos PDFs: https://codex.cs.yale.edu/avi/db-book/slides-dir/PDF-dir/chNN.pdf)
  Capítulos que interessam a esta seção — números conferidos nos próprios slides:
  | Cap. | Título | Cobre |
  |:-:|---|---|
  | **10** | Big Data | NoSQL, chave-valor, documento, *sharding*, replicação → Q222, Q223, Q226 |
  | **11** | Data Analytics | *Data warehousing*, OLAP, cubo, *roll-up*/*drill-down*, *slice and dice* → Q218–Q221 |
  | **17** | Transactions | **ACID em texto pesquisável** → Q225 |
  | **23** | Parallel and Distributed Transaction Processing | Partição de rede e CAP → Q225 |

- **Elmasri, R.; Navathe, S. — *Sistemas de Banco de Dados*, 7ª ed.** (Pearson;
  original *Fundamentals of Database Systems*). O livro mais citado em
  bibliografia de concurso de TI no Brasil.
  - **Cap. 24 — NOSQL Databases and Big Data Storage Systems:** classifica NoSQL
    em **quatro categorias** e compara **modelo de dados, operações e estratégia
    de replicação/distribuição/escalabilidade** de cada uma. Cobre Q222–Q224, Q226.
  - **Cap. 29 — Overview of Data Warehousing and OLAP.** Cobre Q218–Q221.

### Fontes primárias e canônicas (web)

- **Pritchett, D., "BASE: An Acid Alternative"**, *ACM Queue* 6(3), 2008 — a
  formulação canônica de **BASE** (*Basically Available, Soft state, Eventually
  consistent*) como contraponto explícito a ACID. Essencial para **Q222** e Q225.
  https://queue.acm.org/detail.cfm?id=1394128
  (espelho em HTML completo: https://dl.acm.org/doi/fullHtml/10.1145/1394127.1394128)

- **Vogels, W., "Eventually Consistent"** (2008/2009) — o CTO da Amazon
  definindo **consistência eventual** e suas variantes. Fecha o "E" de BASE.
  https://www.allthingsdistributed.com/2008/12/eventually_consistent.html

- **Fowler, M., "PolyglotPersistence"** (2011) — o argumento de escolher o banco
  pelo **padrão de uso dos dados**, não por padrão institucional. É o eixo
  argumentativo de **Q224** e **Q227**.
  https://martinfowler.com/bliki/PolyglotPersistence.html

- **Fowler, M.; Sadalage, P., "NoSQL Distilled — Key Points"** — os quatro tipos,
  a distinção **orientado a agregado × ignorante de agregado**, e a frase-chave
  para Q222: *"aggregates estabelecem a fronteira das operações ACID"*.
  https://martinfowler.com/articles/nosqlKeyPoints.html
  (índice geral: https://martinfowler.com/nosql.html)

- **DeCandia, G. et al., "Dynamo: Amazon's Highly Available Key-value Store"**,
  SOSP 2007 — origem do **chave-valor** com escala horizontal, replicação e
  consistência eventual. Caso de uso característico para Q223/Q226.
  https://www.allthingsdistributed.com/files/amazon-dynamo-sosp2007.pdf

- **Chang, F. et al., "Bigtable: A Distributed Storage System for Structured
  Data"**, OSDI 2006 — origem da **família de colunas** (linhagem de
  Cassandra/HBase). Caso de uso característico para Q223.
  https://static.googleusercontent.com/media/research.google.com/en//archive/bigtable-osdi06.pdf

- **Neo4j — "What is a graph database?"** — o tipo **grafo** e o caso de uso de
  relacionamentos (recomendação), que é o item (iii) de **Q227**.
  https://neo4j.com/docs/getting-started/get-started-with-neo4j/graph-database/

### Documentação de fornecedor (boa para vocabulário, não para citar como autoridade)

- **Microsoft Learn — "Online Analytical Processing"** — define OLTP × OLAP,
  **cubo, dimensão e medida**, e traz uma tabela de traços típicos (schema on
  write, *heavy reads*, esquema estrela ou floco de neve). Redação limpa e
  atual, útil para calibrar Q218–Q221.
  https://learn.microsoft.com/en-us/azure/architecture/data-guide/relational-data/online-analytical-processing
- **Microsoft Learn — Multidimensional Models (SSAS)** — o cubo como artefato
  concreto. https://learn.microsoft.com/en-us/analysis-services/multidimensional-models/multidimensional-models-ssas
- **MongoDB — "NoSQL Explained"**: https://www.mongodb.com/resources/basics/databases/nosql-explained
- **AWS — "What is NoSQL?"**: https://aws.amazon.com/nosql/

---

## Mapa fonte → pergunta

| Pergunta | Assunto | Fonte principal | Fontes de apoio |
|:-:|---|---|---|
| **Q218** | OLTP × OLAP | Codd 1993 | Silberschatz cap. 11 · MS Learn OLAP · Elmasri cap. 29 |
| **Q219** | Relacional (OLTP) × multidimensional (OLAP) | Codd 1993 | Kimball · MS Learn OLAP |
| **Q220** | Cubo × tabelas | Silberschatz cap. 11 | Codd 1993 (regra 1) · MS Learn SSAS |
| **Q221** | Dimensão, métrica, agregação | **Kimball** | Silberschatz cap. 11 (roll-up/drill-down) |
| **Q222** | NoSQL segue ACID? | **Pritchett (BASE)** | NoSQL Distilled Key Points · Elmasri cap. 24 |
| **Q223** | Tipos de NoSQL + caso de uso | **Fowler/Sadalage (pôster)** | Elmasri cap. 24 · Dynamo · Bigtable · Neo4j |
| **Q224** | NoSQL para ERP/CRM? | **Fowler, PolyglotPersistence** | Elmasri cap. 24 · Härder & Reuter (ACID) |
| **Q225** | ACID + BASE + CAP | **Härder & Reuter · Gilbert & Lynch 2002 · Brewer 2012** | Pritchett · Vogels · Silberschatz cap. 17 e 23 |
| **Q226** | Escala horizontal × vertical | Silberschatz cap. 10 | Fowler/Sadalage · Dynamo · Elmasri cap. 24 |
| **Q227** | Caso marketplace (poliglota) | **Fowler, PolyglotPersistence** | Pôster NoSQL Distilled · Neo4j · Dynamo |

---

## Fronteiras que as fontes resolvem (onde a FGV monta distrator)

Anotado a partir das alternativas erradas de **Q65** e **Q66** da prova real.
Isto **não é gabarito** — é o alerta de onde a fonte precisa ser lida com
atenção na hora de escrever os `ponto_chave`.

1. **Cubo pertence ao multidimensional, não ao relacional** (prova Q65-D
   inverte). Mas cuidado com a leitura simplista: **Kimball mostra que esquema
   estrela (relacional/ROLAP) e cubo OLAP são realizações diferentes do mesmo
   modelo dimensional**. A fronteira é de *organização física/lógica*, não de
   "um analisa e o outro não". Fronteira D3.

2. **Multidimensional não "não suporta agregação"** (prova Q65-E) — agregação é
   a **finalidade** da abordagem. Kimball trata fatos como aditivos,
   semiaditivos ou não aditivos; o alvo do distrator é a inversão total.

3. **"NoSQL não segue ACID" precisa de ressalva temporal.** A afirmação vale
   como generalização histórica (Pritchett, 2008) e é o que a banca espera. Mas
   **hoje vários NoSQL oferecem ACID** (MongoDB tem transação multidocumento
   desde a 4.0; Neo4j é ACID). A formulação defensável é: *a maioria troca ACID
   por BASE, e mesmo os que oferecem ACID normalmente o fazem dentro da
   fronteira do agregado* (NoSQL Distilled). Escrever o ponto-chave com essa
   fronteira, não com um "nunca".

4. **CAP não é "escolha 2 de 3".** Brewer 2012 é explícito: a escolha entre C e
   A **só se coloca quando há partição**. Um ponto-chave que diga "escolha duas
   das três" está desatualizado *pelo próprio autor* — e o enunciado de Q225 já
   pede corretamente "sujeito a partição". Fronteira D3, é o miolo da questão.

5. **Escala horizontal não é só "mais máquinas".** É **particionamento
   (sharding) + replicação**, com o custo de consistência que vem junto
   (Silberschatz cap. 10; Dynamo). O contraste com vertical (mais recurso na
   mesma máquina, teto físico, ponto único de falha) é o que Q226 pede.

6. **ERP/CRM ≠ NoSQL** (prova Q66-E) — o argumento correto é o **perfil dos
   dados e das transações**: esquema estável e altamente relacionado, e
   necessidade de **transação multi-entidade com integridade forte**, que é
   justamente onde o agregado do NoSQL deixa de servir de fronteira
   transacional. Fowler (PolyglotPersistence) sustenta a inversão da carga da
   prova: escolhe-se pelo padrão de uso, e para ERP/CRM esse padrão é relacional.

---

## Ainda sem fonte porque ainda não há pergunta (edital 2026)

`docs/editais/LACUNAS-EDITAL-2026.md` aponta **Banco de Dados** como a maior lacuna isolada
do banco (5 de 17 subitens cobertos) e coloca **SQL/DDL/DML, normalização,
integridade referencial e modelagem** como prioridade nº 1. Nenhuma das
perguntas Q218–Q227 toca nesses temas — quando elas forem escritas, estas são
as fontes de partida (verificadas, mas **não arquivadas** nesta pasta):

- **Codd, E.F., "A Relational Model of Data for Large Shared Data Banks"** (1970)
  — a fundação do modelo relacional.
  https://www.seas.upenn.edu/~zives/03f/cis550/codd.pdf
- **Kent, W., "A Simple Guide to Five Normal Forms in Relational Database
  Theory"**, *CACM* 26(2), 1983 — a explicação canônica de 1FN–5FN.
  http://www.bkent.net/Doc/simple5.htm
- **Silberschatz — db-book**, caps. 2–7 (modelo relacional, SQL, modelo E-R,
  projeto relacional e normalização). Slides gratuitos: https://www.db-book.com/
- **Elmasri & Navathe**, caps. 3–9 (E-R, mapeamento, SQL) e 14–15 (dependência
  funcional e normalização).
- **Documentação do PostgreSQL** — DDL, restrições e ações referenciais
  (CASCADE/RESTRICT/SET NULL) com precisão de rol exato.
  https://www.postgresql.org/docs/current/ddl.html
