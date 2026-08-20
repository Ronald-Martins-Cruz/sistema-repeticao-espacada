# Fontes — Seção 2.19 (Data Warehouse, ETL e ELT)

Fontes para escrever os pontos-chave de **Q197–Q204** (hoje as oito com zero
`ponto_chave`). PDFs arquivados nesta pasta; páginas web listadas por URL.
Todas as URLs foram verificadas em **30/07/2026**, e a fonte acrescentada em
**20/08/2026** (Vassiliadis 2023, no eixo ETL × ELT) na mesma data.

A seção tem **peso 2** na prova real e nasce de duas questões: **Q59** (objetivo
do ETL, com quatro distratores que são atividades de *outras* camadas) e **Q67**
(ETL × ELT, "assinale a incorreta"). As fontes se organizam em três eixos:
**ETL como camada de um DW/BI** (Q197, Q198), **ETL × ELT** (Q199–Q201, Q204) e
**DW, Data Mart e Data Lake** (Q202, Q203, Q204).

> Duas fontes já arquivadas em `fontes-gabaritos/bancodedados/` servem aqui
> também e **não foram duplicadas**: `kimball-dimensional-modeling-techniques.pdf`
> (fato, dimensão, grão, esquema estrela — o que o DW guarda) e
> `codd-1993-providing-olap.pdf` (a fronteira OLTP × OLAP, que é metade de Q202).

---

## Arquivados aqui

Sete PDFs e uma página HTML (`gartner.html`, salva à mão porque a Gartner
bloqueia acesso automatizado — descrita mais abaixo, junto das fontes web).

### Fonte canônica da seção inteira

- `chaudhuri-dayal-1997-dw-olap-overview.pdf` — **Chaudhuri, S.; Dayal, U., "An
  Overview of Data Warehousing and OLAP Technology"**, *ACM SIGMOD Record* 26(1),
  mar/1997, p. 65–74. **É a fonte mais importante desta pasta** e cobre sozinha
  seis das oito perguntas. Três coisas que só ela entrega juntas:
  1. **A definição de DW citada literalmente** (p. 1): *"A data warehouse is a
     'subject-oriented, integrated, time-varying, non-volatile collection of data
     that is used primarily in organizational decision making.'"* — é a definição
     de **Inmon**, aqui em fonte acadêmica revisada e de acesso livre (Q202).
  2. **A Figura 1** (p. 2), o diagrama de camadas ponta a ponta: *Data sources →
     Extract/Transform/Load/Refresh → Data Warehouse → Data Marts → OLAP Servers →
     Query/Reporting, Analysis, Data Mining*, mais *Metadata Repository* e
     *Monitoring & Administration Tools* como faixas transversais. **É o gabarito
     visual de Q198** — mostra que dashboard, análise estatística e administração
     são camadas *distintas* do ETL, sem precisar de fonte de fornecedor.
  3. A **seção 3, "Back End Tools and Utilities"**: extração, limpeza,
     transformação, carga e *refresh* como um processo só (Q197), e a discussão
     de *quando* e *como* atualizar o warehouse.
  Também define **Data Mart** (p. 2) como *"departmental subsets focused on
  selected subjects"*, com a ressalva de que aceleram a entrega mas *"may lead to
  complex integration problems in the long run"* (Q203).
  Origem (Microsoft Research): https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/sigrecord.pdf
  Registro oficial: https://sigmodrecord.org/1997/03/15/an-overview-of-data-warehousing-and-olap-technology/

### Eixo ETL como camada — Q197, Q198

- `kimball-etl-extract-subsystems.pdf` (E)
- `kimball-etl-transformation-subsystems.pdf` (T)
- `kimball-etl-load-subsystems.pdf` (L)
- `kimball-etl-manage-subsystems.pdf` (M)

  **Kimball Group — os 34 subsistemas de ETL**, um diagrama de uma página para
  cada um dos quatro grandes grupos (*extract* 3 subsistemas · *clean and conform*
  5 · *deliver* 13 · *manage* 13). Extraídos de *The Data Warehouse Toolkit*,
  3ª ed. (Wiley, 2013). Servem para **Q197** como antídoto contra o resumo
  ingênuo "ETL é copiar dado": mostram que a transformação inclui *data quality
  screens*, *deduplicating*, *conforming*, *surrogate key generator* e
  *slowly changing dimension manager*. O diagrama "L" é o que liga o ETL ao
  esquema dimensional (chave surrogada, gerenciador de dimensão, provedor de
  fato) — é a costura desta seção com a 2.22.
  Origem: https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/etl-architecture-34-subsystems/
  > Ressalva: são **diagramas**, não texto corrido. O texto que os explica está
  > no livro (pago). Para redigir `ponto_chave` em prosa, use Chaudhuri & Dayal
  > seção 3 ou Silberschatz cap. 11; os PDFs servem de checklist do rol.

### Eixo ETL × ELT — Q199, Q200, Q201, Q204

- `vassiliadis-2023-history-present-future-etl.pdf` — **Simitsis, A.;
  Skiadopoulos, S.; Vassiliadis, P., "The History, Present, and Future of ETL
  Technology"**, *DOLAP 2023* (Test-of-Time Award — Invited Talk), CEUR-WS.
  **Acrescentada em 20/08/2026 para tirar Q199 da dependência de fonte de
  fornecedor.** Até então, a única redação explícita de ETL × ELT nesta pasta
  era a do Microsoft Learn — correta, mas documentação de fabricante. Este é o
  equivalente **acadêmico e neutro**, escrito pelos três autores do artigo de
  modelagem conceitual de ETL premiado com o *test-of-time* do DOLAP, e diz a
  mesma coisa com mais precisão:
  > *"The ELT approach **moves the transformation phase from the integration
  > platform**, which now would simply collect and deliver the data, **to the
  > target data platform**. Hence, ELT **loads the data directly into the
  > eventual host system and performs the transformations in-situ**."*

  Isto entrega **as duas metades que Q199 pede de uma vez** — o *momento*
  (transforma depois de carregar, não antes) e o *local* (na plataforma de
  destino, não na de integração). Cobre ainda:
  - **Q200/Q201** — por que o ELT ganhou espaço: volume crescente,
    armazenamento e computação mais baratos, e motores distribuídos
    (Spark, Hadoop) capazes de transformar in loco.
  - **Q204** — a seção *"Cloud ELT"*, que descreve exatamente o cenário do
    caso: escalabilidade elástica, processamento massivamente paralelo,
    *pipelines serverless* e reequilíbrio dinâmico de trabalho como o que o
    "cloud native ELT" busca explorar.
  - Nota de rodapé útil para não engessar o gabarito: *"The ELT can also be
    met in various incarnations such as **ELTL, ETLT**, etc.; the main concept
    however does not change."*
  - De quebra, situa **CDC** (*change data capture*) como um tipo de solução
    ELT, e descreve *streaming ETL*, *reverse ETL* e a arquitetura *lakehouse*
    — o que dialoga com `armbrust-2021-lakehouse-cidr.pdf`.
  Origem (página do próprio Vassiliadis, Univ. de Ioannina):
  https://www.cs.uoi.gr/~pvassil/publications/TALKS/2023_03_dolap_tota/23DOLAP_TestOfTimeAward_CEUR-CR.pdf

### Eixo DW × Data Lake — Q203, Q204

- `armbrust-2021-lakehouse-cidr.pdf` — **Armbrust, M.; Ghodsi, A.; Xin, R.;
  Zaharia, M., "Lakehouse: A New Generation of Open Platforms that Unify Data
  Warehousing and Advanced Analytics"**, CIDR 2021 (Databricks / UC Berkeley /
  Stanford). Faz a **história em duas gerações** — DW relacional (1ª) → data lake
  + DW de duas camadas (2ª) → lakehouse (3ª) — e enumera os problemas concretos
  da arquitetura de duas camadas: *data staleness*, confiabilidade, custo total,
  *lock-in* e suporte limitado a ML. É a fonte de profundidade D4 para **Q204**
  (por que a nuvem elástica empurra o pipeline para ELT) e o contraponto histórico
  de **Q203**.
  Origem (página do próprio Zaharia, Berkeley): https://people.eecs.berkeley.edu/~matei/papers/2021/cidr_lakehouse.pdf
  > É um paper **de fornecedor** (Databricks defendendo Delta Lake). O diagnóstico
  > das duas camadas é sólido e citável; a conclusão ("o DW vai morrer") é tese,
  > não consenso. Não escrever `ponto_chave` que dependa dela.

---

## Páginas web (não arquivadas)

### A redação mais literal de Q199, Q200 e Q201

> A fonte **primária e neutra** desses três itens é o Vassiliadis 2023,
> arquivado acima. A página abaixo continua valendo pela redação — é a mais
> próxima do vocabulário de banca —, mas é documentação de fornecedor:
> use-a para calibrar a frase, não como autoridade isolada.

- **Microsoft Learn — "Extract, transform, load (ETL)"** (Azure Architecture
  Center). É a redação mais limpa e literal da fronteira ETL × ELT que existe em
  acesso livre, e responde **exatamente** aos três distratores da prova Q67:
  https://learn.microsoft.com/en-us/azure/architecture/data-guide/relational-data/etl
  | Frase literal | Serve a |
  |---|---|
  | *"ELT differs from ETL **solely in where the transformation takes place**. In the ELT pipeline, the transformation occurs in the target data store."* | **Q199** |
  | *"Typical use cases for ELT fall within the **big data** realm."* | **Q200** |
  | *"**ELT only works well when the target system is powerful enough** to transform the data efficiently."* | **Q200, Q201** |
  | *"Scaling the target data store also scales the ELT pipeline performance."* | **Q201** |
  | *"This approach **skips data copy steps present in ETL**, which often can be time consuming for large data sets."* | **Q201** |
  A página traz ainda uma lista *Choose ETL when / Choose ELT when* que é o
  esqueleto pronto de **Q204** — inclusive o critério regulatório
  (*"regulatory or compliance requirements mandate curated staging audits before
  loading"*), que é por onde entra o risco de governança.

### Camadas de uma solução DW/BI — Q198

- **Kimball Group — "Kimball Technical DW/BI System Architecture"**. Separa o
  sistema em **back room** (o sistema de ETL, com os 34 subsistemas) e **front
  room** (área de apresentação dimensional + aplicações de BI), esta última
  descrita como *"the public face of the DW/BI system"* — consultas ad hoc,
  relatórios padronizados, **dashboards** e aplicações analíticas. Trata
  **metadados** (técnico, de negócio e de processo) como componente à parte.
  É a fonte que sustenta a resposta de Q198: *dashboard* é front room,
  *modelagem preditiva* é aplicação analítica, e **segurança/controle de acesso
  não é nenhuma das duas** — é infraestrutura transversal.
  https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/technical-dw-bi-system-architecture/

- **Kimball Group — "Enterprise Data Warehouse Bus Architecture"**. Define
  **dimensões conformadas** como *"common, standardized, master dimensions that
  are managed once in the ETL system and then reused by multiple fact tables"*, e
  o data mart como recorte por **processo de negócio**, não por departamento
  ("agile bottom-up delivery occurs by focusing on a single business process at a
  time"). Necessário para **Q203** não errar o alvo do "escopo" do data mart.
  https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/kimball-data-warehouse-bus-architecture/

### DW × Data Lake e o momento do esquema — Q203, Q204

- **Microsoft Learn — "What Is a Data Lake?"** (Azure Architecture Center). A
  única fonte desta lista que dá, num lugar só, **os três eixos que Q203 pede**:
  https://learn.microsoft.com/en-us/azure/architecture/data-guide/scenarios/data-lake
  - *estrutura do dado*: lago guarda *"in its native, raw format"* — estruturado,
    semiestruturado e não estruturado; DW guarda estruturado e curado;
  - *momento do esquema*, com os dois termos nomeados: *"Data lakes store all data
    types in their original, untransformed state and apply transformation only
    when the data is needed. This approach is known as **schema-on-read**. In
    contrast, a data warehouse enforces structure and applies transformations as
    it ingests data. This approach is known as **schema-on-write**."*
  - uma **tabela comparativa** completa (tipo de dado, desempenho, latência,
    momento da transformação, escalabilidade, custo, caso de uso).
  A seção *Challenges of data lakes* lista, nesta ordem, **qualidade e
  governança**, **segurança e controle de acesso** e **descoberta** — *"without
  proper cataloging, lakes can devolve into **data swamps** where valuable
  information is present but inaccessible or misunderstood"* — que é a resposta
  de risco de **Q204**. Descreve também a **arquitetura medalhão**
  (bronze/prata/ouro), útil para "o que muda no pipeline".

- **Dixon, J., "Pentaho, Hadoop, and Data Lakes"** (14/10/2010) — **o post que
  cunhou o termo *data lake***. A analogia original, citável literalmente:
  *"If you think of a datamart as a store of bottled water – cleansed and
  packaged and structured for easy consumption – the data lake is a large body of
  water in a more natural state."* O argumento contra o data mart é o que importa
  para **Q203**: *"only a subset of the attributes are examined, so only
  pre-determined questions can be answered"* e *"the data is aggregated so
  visibility into the lowest levels is lost"*.
  https://jamesdixon.wordpress.com/2010/10/14/pentaho-hadoop-and-data-lakes/
- **Dixon, J., "Data Lakes Revisited"** (25/09/2014) — o autor corrigindo o uso
  do próprio termo: para ele um data lake é o dado bruto de **uma única fonte**;
  vários lagos formam um *water garden*, e "lago = tudo da empresa num balde" é
  deturpação de mercado. Vale como ressalva de honestidade, **não** como gabarito:
  a banca cobra o uso corrente, não o de Dixon.
  https://jamesdixon.wordpress.com/2014/09/25/data-lakes-revisited/

- **Gartner, "Gartner Says Beware of the Data Lake Fallacy"** (press release,
  28/07/2014), divulgando o relatório *The Data Lake Fallacy: All Water and
  Little Substance*, de **Andrew White** (*vice president and distinguished
  analyst*) e **Nick Heudecker** (*research director*). É a origem documentada do
  termo **"data swamp"** e o inventário dos riscos de governança que **Q204**
  cobra, nesta ordem: ausência de **metadados descritivos** e de mecanismo para
  mantê-los — sem eles cada novo uso do dado recomeça do zero; impossibilidade de
  aferir **qualidade** e **linhagem** de achados anteriores; **segurança e
  controle de acesso**, porque o dado entra no lago sem supervisão do conteúdo; e
  a constatação de que atender público além do analista especializado exige
  *"curated repositories with governance, semantic consistency and access
  controls"* — ou seja, exige de volta o que o DW já tinha.
  **Arquivado aqui como `gartner.html`** (página salva do navegador, 30/07/2026).
  https://www.gartner.com/en/newsroom/press-releases/2014-07-28-gartner-says-beware-of-the-data-lake-fallacy
  > ⚠️ O site da Gartner responde **403 a acesso automatizado** — foi por isso que
  > a página precisou ser salva à mão. O `gartner.html` traz o release completo,
  > mas embutido em ~290 KB de navegação e script do site; para ler o texto,
  > abra no navegador ou filtre as tags. Cobertura equivalente que abre sem
  > bloqueio:
  > https://siliconangle.com/2014/08/07/gartner-drowns-the-concept-of-data-lakes-in-new-report/

### ELT em plataforma de nuvem — Q204

- **Microsoft Learn — "Instead of ETL, Design ELT"** (Azure Synapse). O título já
  é a tese, e o texto dá o mecanismo: *"Traditional SMP dedicated SQL pools use an
  ETL process... Using an ELT process uses built-in **distributed query processing
  capabilities** and **eliminates the resources needed for data transformation
  before loading**."* Enumera os seis passos do ELT (extrair para arquivo →
  aterrissar no storage → preparar → carregar em **tabela de staging** →
  transformar → inserir na tabela de produção), que é o "o que muda no pipeline"
  de **Q204**.
  https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/design-elt-data-loading

### Livros-texto de referência (o que a FGV costuma seguir)

- **Silberschatz, Korth & Sudarshan — *Database System Concepts*, 7ª ed.**,
  **cap. 11 (Data Analytics)**: *data warehousing*, ETL, esquema estrela, OLAP.
  Slides completos e gratuitos: https://www.db-book.com/
  (o mesmo capítulo já está mapeado em `fontes-gabaritos/bancodedados/fontes.md`
  para Q218–Q221 — aqui interessa a parte de **ETL e arquitetura do DW**, não a
  de cubo).
- **Elmasri, R.; Navathe, S. — *Sistemas de Banco de Dados*, 7ª ed.**, **cap. 29
  — Overview of Data Warehousing and OLAP**: definição de DW pelas quatro
  características de Inmon, DW × data mart, e o processo de povoamento. É a
  bibliografia mais citada em concurso de TI no Brasil.
- **Inmon, W. H. — *Building the Data Warehouse*, 4ª ed.** (Wiley, 2005). A fonte
  primária da definição de Q202. **Não arquivada** — é livro sob copyright e as
  cópias que circulam em PDF são piratas. Para citar a definição em `fonte`, use
  *Chaudhuri & Dayal (1997), p. 65*, que a reproduz entre aspas e é de acesso
  legítimo. Ficha do editor (ISBN 978-0-7645-9944-6; o site da Wiley bloqueia
  acesso automatizado, mas abre no navegador):
  https://www.wiley.com/en-us/Building+the+Data+Warehouse,+4th+Edition-p-9780764599446

### Documentação de fornecedor (boa para vocabulário, não para citar como autoridade)

- **AWS — "What is a data lake?"** — define o lago como *"a centralized repository
  that allows you to store all your structured and unstructured data at any
  scale"* e compara com o DW em prosa. **Não usa** os termos *schema-on-read* /
  *schema-on-write* — para esses, a página da Microsoft acima.
  https://aws.amazon.com/what-is/data-lake/
- **Snowflake — "ELT (Extract, Load, Transform)"**:
  https://www.snowflake.com/guides/elt-extract-load-transform/
- **Google Cloud — BigQuery, pipelines de migração de dados**:
  https://cloud.google.com/bigquery/docs/migration/pipelines

---

## Mapa fonte → pergunta

| Pergunta | Assunto | Fonte principal | Fontes de apoio |
|:-:|---|---|---|
| **Q197** | Objetivo do ETL | **Chaudhuri & Dayal §3** | Kimball 34 subsistemas · Silberschatz cap. 11 |
| **Q198** | O que o ETL **não** é (dashboard, preditivo, segurança) | **Chaudhuri & Dayal, Figura 1** | Kimball Technical DW/BI Architecture (back room × front room) |
| **Q199** | ETL × ELT: onde e quando transforma | **Vassiliadis 2023** ("moves the transformation phase… to the target data platform", "in-situ") | MS Learn ETL ("solely in where the transformation takes place") · MS Learn Synapse ELT |
| **Q200** | ELT vence em volume **grande**, não pequeno | **MS Learn ETL** ("big data realm"; "powerful enough") | **Vassiliadis 2023** (por que o ELT cresceu) · MS Learn Synapse ELT · Armbrust 2021 |
| **Q201** | Quando o ETL é mais lento | **MS Learn ETL** ("scaling the target data store…"; "skips data copy steps") | **Vassiliadis 2023** · MS Learn Synapse ELT |
| **Q202** | O que é DW × banco transacional | **Chaudhuri & Dayal p. 65 (definição de Inmon)** | Codd 1993 (OLTP × OLAP, em `bancodedados/`) · Elmasri cap. 29 |
| **Q203** | DW × Data Mart × Data Lake | **MS Learn Data Lake** (schema-on-read/write) · **Dixon 2010** | Chaudhuri & Dayal (data mart) · Kimball Bus Architecture · AWS |
| **Q204** | Caso: migração para nuvem, 4 TB/dia de log | **MS Learn Synapse ELT** · **Gartner 2014 (data swamp)** | **Vassiliadis 2023 (*Cloud ELT*)** · MS Learn ETL (*Choose ELT when*) · MS Learn Data Lake (medalhão) · Armbrust 2021 |

---

## Fronteiras que as fontes resolvem (onde a FGV monta distrator)

Anotado a partir das alternativas de **Q59** e **Q67** da prova real. Isto **não
é gabarito** — é o alerta de onde a fonte precisa ser lida com atenção na hora de
escrever os `ponto_chave`.

1. **Os quatro distratores de Q59 são atividades reais — de outras camadas.**
   O erro que a banca quer é confundir *pipeline de dados* com *plataforma
   analítica*. A Figura 1 de Chaudhuri & Dayal resolve item a item: dashboard e
   relatório = *front end tools / query & reporting*; análise estatística
   preditiva = *data mining*; segurança e controle de acesso = *monitoring &
   administration*, faixa transversal. O ponto-chave de Q198 tem de **nomear a
   camada de cada uma**, não só dizer "não é ETL".

2. **A fronteira ETL × ELT é *onde*, não *o quê*.** Microsoft é literal:
   *"differs from ETL solely in where the transformation takes place"*, e
   Vassiliadis 2023 diz o mesmo em fonte acadêmica: a transformação **muda de
   plataforma** (da de integração para a de destino) e passa a rodar *in situ*.
   Um `ponto_chave` que diga "no ELT não há transformação" ou "o ELT dispensa
   modelagem" está errado — as três letras estão nos dois; muda a ordem e a
   máquina que executa. Fronteira D2, é o miolo de Q199.
   Vassiliadis acrescenta um cuidado: existem **ELTL e ETLT** na prática, e o
   conceito não muda — não escreva `ponto_chave` que exija as letras em
   exatamente três posições.

3. **Q67-D inverte duas coisas ao mesmo tempo** — o volume ("pequeno" quando é
   grande) **e** o local ("fora do sistema de destino" quando é dentro). Q200
   pede as duas correções; um gabarito que corrija só o volume aceita meia
   resposta. Vale marcar as duas como `essencial`.

4. **"ETL é mais lento" depende de uma condição, não é regra.** Q67-E é a
   alternativa *correta* da prova e o enunciado traz a condição embutida:
   *quando o sistema de destino tem alta capacidade de processamento*. O
   ponto-chave de Q201 precisa exigir a **condição** (capacidade do destino /
   escalabilidade elástica), mais o mecanismo — o ELT pula a cópia intermediária
   e o motor de transformação separado deixa de ser gargalo. Sem a condição, a
   afirmação é falsa.

5. **Data lake não é "DW sem esquema".** A diferença é *quando* o esquema é
   aplicado (*schema-on-read* × *schema-on-write*), não se existe esquema. E
   **data mart não é "DW pequeno"**: é recorte por assunto/processo de negócio
   (Chaudhuri & Dayal: *departmental subsets focused on selected subjects*;
   Kimball: um processo de negócio por vez, com dimensões conformadas). Q203
   cobra os três eixos separados — escopo, estrutura do dado, momento do esquema
   — e um deles sozinho não fecha a resposta.

6. **O risco de governança de Q204 é específico do ELT, não genérico.** Não basta
   dizer "risco de segurança". O que a mudança introduz é: o dado **bruto e não
   tratado aterrissa dentro do ambiente analítico antes de qualquer limpeza,
   mascaramento ou triagem** — some o *staging* curado que o ETL impunha, e com
   ele o ponto único onde se aplicava qualidade, linhagem e minimização. Daí os
   riscos que Gartner nomeia: metadado descritivo ausente → **data swamp**;
   linhagem irrastreável; e dado pessoal em log semiestruturado caindo no lago
   sem base legal declarada — que na prova brasileira encosta em **LGPD art. 6º
   (finalidade, adequação, necessidade)**. A própria Microsoft dá o gancho ao
   listar como razão para *escolher ETL*: *"regulatory or compliance requirements
   mandate curated staging audits before loading"*.

7. **Cuidado com a fronteira 2.19 × 2.20 × 2.22.** ETL/ELT é *esta* seção; cubo,
   dimensão e métrica são **2.22** (Q218–Q221); mapeamento de fontes e
   dashboards são **2.20** (Q205–Q211). Escrever `ponto_chave` de Q197/Q198 que
   entre em modelagem dimensional é invadir seção vizinha e inflar a correção.

---

## Ainda sem fonte porque ainda não há pergunta (edital 2026)

`docs/editais/LACUNAS-EDITAL-2026.md` registra que o item 17 (ETL/ELT) está
coberto e o 14 (data lake) só **parcialmente**, "sem soluções de big data". Os
vizinhos descobertos que puxariam perguntas novas para esta pasta — fontes
verificadas, **não arquivadas**:

- **Big data: volume/velocidade/variedade, Hadoop, Spark, lote × streaming**
  (item 20 de Desenvolvimento). Fontes de partida:
  - Dean, J.; Ghemawat, S., "MapReduce: Simplified Data Processing on Large
    Clusters", OSDI 2004 — a origem do processamento em lote distribuído.
    https://static.googleusercontent.com/media/research.google.com/en//archive/mapreduce-osdi04.pdf
  - Zaharia, M. et al., "Resilient Distributed Datasets", NSDI 2012 — a origem
    do Spark e do contraste com MapReduce.
    https://www.usenix.org/system/files/conference/nsdi12/nsdi12-final138.pdf
  - Silberschatz — db-book **cap. 10 (Big Data)**: https://www.db-book.com/
- **Data mining e CRISP-DM** (item 4 de BI, cobertura zero). Partida:
  Chapman, P. et al., *CRISP-DM 1.0 Step-by-step data mining guide* (2000) e
  Fayyad, U. et al., "From Data Mining to Knowledge Discovery in Databases",
  *AI Magazine* 17(3), 1996 —
  https://ojs.aaai.org/aimagazine/index.php/aimagazine/article/view/1230
- **Visualização de dados e construção de dashboards** (item 5 de BI). Hoje
  "dashboard" só aparece no banco como distrator, dentro de **Q198**. Partida:
  Few, S., *Information Dashboard Design*; Tufte, E., *The Visual Display of
  Quantitative Information*.
- **Dados estruturados × semiestruturados × não estruturados** (item 15 de Banco
  de Dados). Atenção à armadilha registrada no LACUNAS: Q213/Q214 falam de
  *problemas* estruturados/não estruturados (taxonomia de SSD, Gorry & Scott
  Morton), que é outro conceito com o mesmo vocabulário.
