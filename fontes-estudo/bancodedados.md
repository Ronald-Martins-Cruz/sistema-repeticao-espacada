# Bancos de Dados — Analítico e Distribuído — texto de estudo

> Seção 2.22. Cobre Q218–Q227. Fontes primárias: Codd/Codd/Salley (1993),
> Kimball Group — *Dimensional Modeling Techniques*, Härder & Reuter (1983),
> Gilbert & Lynch (2002), Brewer (2012), Pritchett (2008) e Fowler & Sadalage —
> *NoSQL Distilled* / *Polyglot Persistence*.
>
> A seção tem **dois eixos**, e vale enxergá-los como uma coisa só: os dois
> nascem da mesma pergunta — *o banco relacional monolítico com ACID serve para
> tudo?* O eixo **OLAP** responde "não, para analisar"; o eixo **NoSQL**
> responde "não, para escalar". O modelo relacional continua de pé nos dois
> casos; o que muda é o critério de escolha.

---

## Parte I — O eixo analítico

## 1. Dois perfis de carga: OLTP e OLAP `Q218`

Um banco não é usado de um jeito só. **Codd, Codd & Salley (1993)** cunharam o
termo *OLAP* justamente para nomear um perfil de uso que já existia mas não
tinha nome — e para separá-lo do perfil transacional, o **OLTP**.

| Critério | **OLTP** (*Online Transaction Processing*) | **OLAP** (*Online Analytical Processing*) |
|---|---|---|
| **Objetivo** | **Operar** o negócio — registrar os fatos à medida que acontecem. | **Entender** o negócio — sintetizar informação para decidir. |
| **Perfil da carga** | Muitas transações **curtas** e **concorrentes**; mistura de leitura e escrita (INSERT/UPDATE/DELETE). | Poucas consultas **longas e complexas**, predominantemente **leitura**. |
| **Volume por consulta** | **Poucas linhas** por operação — normalmente localizadas por chave (um pedido, um cliente). | **Milhões de linhas** varridas e condensadas em poucas linhas de resultado. |
| **Estado dos dados** | Dados **correntes**, exatos no instante da operação. | Dados **históricos**, tidos por exatos num ponto no tempo (o início da análise). |
| **Duração** | Segundos ou frações de segundo. | Codd fala em transações que duram **horas, dias ou semanas** — a sessão de análise inteira. |
| **Usuário típico** | Operador, sistema, cliente final. | Analista, gestor. |
| **Métrica de sucesso** | **Vazão** (transações por segundo) e integridade. | **Tempo de resposta** de agregações e liberdade de exploração. |
| **Modelagem típica** | **Normalizada** (3FN) — sem redundância. | **Dimensional** — desnormalizada, organizada por perspectivas de análise. |

A frase de Codd que resume a diferença de natureza: OLTP trabalha com dados
**instantaneamente exatos**; OLAP trabalha quase exclusivamente com **dados
históricos**, tomados como exatos a partir de um marco temporal. E o OLAP é
feito de cenários **"e se…"** e **"por quê…"** — análise especulativa e
exploratória, não consulta pontual.

> **Ponto de atenção útil:** Codd não propôs abandonar o relacional. O texto
> dele diz o contrário — *"bancos relacionais foram, são hoje e continuarão a
> ser a tecnologia mais apropriada para bases corporativas"*. O que ele defende
> é acrescentar **ferramentas de análise** com uma visão conceitual diferente
> por cima do dado corporativo.

---

## 2. Modelagem relacional × modelagem multidimensional `Q219`

Onde cada uma é usada, e **por quê**:

| | **Relacional (normalizada)** | **Multidimensional (dimensional)** |
|---|---|---|
| **Usada em** | Sistemas **transacionais** (OLTP). | Sistemas de **apoio à decisão** (OLAP, BI, *data warehouse*). |
| **Unidade lógica** | Tabelas em **3FN**, uma entidade por tabela, relações por chave estrangeira. | **Fatos** (medidas numéricas) cercados de **dimensões** (contexto descritivo). |
| **O que otimiza** | **Escrita e integridade.** Cada dado vive em um lugar só → atualizar é barato, contradição é impossível por construção. | **Leitura agregada e legibilidade.** Menos junções, atributos descritivos prontos para filtrar e agrupar. |
| **Redundância** | Eliminada — é o objetivo da normalização. | **Aceita de propósito** nas dimensões (desnormalização), trocando espaço por velocidade e clareza. |

O raciocínio de fundo: **a normalização otimiza exatamente o que o OLTP
precisa** (escrever pouco, escrever certo, sem anomalia de atualização) e
**cobra exatamente onde o OLAP dói** (uma pergunta analítica simples vira uma
junção de dez tabelas). O modelo dimensional inverte a troca.

### 2.1 Como se constrói um modelo dimensional (Kimball)

Kimball formaliza o projeto em **quatro passos, nesta ordem**:

1. **Selecionar o processo de negócio** — a atividade operacional que gera as
   medidas (registrar um pedido, processar um sinistro, tirar um retrato mensal
   de cada conta).
2. **Declarar o grão** — *o que exatamente uma linha da tabela fato
   representa.* É o passo pivô: Kimball chama a declaração de grão de **contrato
   vinculante** do projeto, porque toda dimensão e toda medida candidata precisa
   ser consistente com ele. Grãos diferentes → tabelas fato diferentes.
3. **Identificar as dimensões** — o contexto descritivo compatível com o grão.
4. **Identificar os fatos** — as medidas numéricas compatíveis com o grão.

**Grão atômico** é o nível mais baixo em que o processo captura dado. Kimball
recomenda começar por ele porque é o único que **resiste a perguntas
imprevistas**; grãos resumidos são bons para desempenho, mas já pressupõem
quais perguntas serão feitas.

### 2.2 Esquema estrela

O arranjo canônico: uma **tabela fato** central ligada por chave
primária/estrangeira a várias **tabelas dimensão** ao redor.

- **Tabela fato** — contém as **medidas numéricas** do evento, mais uma chave
  estrangeira para cada dimensão associada. Uma linha ↔ um evento de medição.
- **Tabela dimensão** — contém os **atributos descritivos** usados para filtrar
  e agrupar. Kimball as chama de *"a alma do data warehouse"*, porque são elas
  que dão os rótulos com que o usuário navega.
- **Floco de neve (*snowflake*)** — variante em que as hierarquias da dimensão
  são normalizadas em tabelas auxiliares. Economiza espaço e perde legibilidade
  e desempenho de junção.

> **Distinção que vale fixar:** *esquema estrela* e *cubo OLAP* são **duas
> realizações do mesmo modelo dimensional**. Kimball é explícito: o esquema
> estrela é a estrutura dimensional **implantada num SGBD relacional**; o cubo é
> a mesma estrutura **implantada num banco multidimensional**, "equivalente em
> conteúdo a — ou, mais comumente, derivada de — um esquema estrela relacional".
> Ou seja: a fronteira relacional × multidimensional é de **organização física e
> de linguagem de acesso**, não de "um analisa e o outro não".

---

## 3. O cubo `Q220`

**O cubo pertence à abordagem multidimensional.** É a estrutura em que os dados
são organizados por **coordenadas de dimensão**: cada célula é endereçada pela
combinação (Produto = *X*, Tempo = *2026-Q2*, Região = *Sudeste*), e guarda os
valores das medidas naquele cruzamento.

**O que o cubo acrescenta em relação a tabelas:**

- **A combinação vira endereço.** Em tabelas, cruzar três perspectivas é montar
  junções e um `GROUP BY` para cada recorte. No cubo, o cruzamento **é** a forma
  natural de identificar o dado — a consulta deixa de ser navegação por chaves e
  vira navegação por coordenadas.
- **Hierarquias são de primeira classe.** Dia → mês → trimestre → ano, ou
  produto → linha → categoria, ficam declaradas na dimensão. Subir e descer o
  nível é uma operação, não um novo SQL.
- **Agregações pré-consolidadas.** O cubo materializa (total ou parcialmente) os
  totais em cada nível de hierarquia. Uma soma que varreria milhões de linhas
  passa a ser leitura de célula.
- **Linguagem com mais poder analítico que SQL.** Kimball registra que o cubo é
  acessado por linguagens **com mais capacidade analítica que SQL** (MDX/XMLA):
  comparação com o mesmo período do ano anterior, participação sobre o total,
  acumulado no ano — expressões que em SQL puro exigem subconsultas e funções
  de janela.

**Operações clássicas sobre o cubo** — o vocabulário que descreve a navegação:

| Operação | O que faz |
|---|---|
| ***Roll-up*** (consolidação) | Sobe na hierarquia da dimensão, agregando: dia → mês → ano. |
| ***Drill-down*** | Desce na hierarquia, abrindo o detalhe: ano → mês → dia. Codd define os dois como movimento entre **níveis de consolidação**. |
| ***Slice*** (fatia) | Fixa **um valor** de uma dimensão, reduzindo a dimensionalidade do cubo: "só 2026". |
| ***Dice*** (recorte) | Restringe **faixas** de valores em **várias** dimensões ao mesmo tempo: "2025–2026, região Sul e Sudeste, categoria eletrônicos". |
| ***Pivot*** (rotação) | Troca os eixos de apresentação — a mesma medida vista por outra combinação de perspectivas. |

**Formas de implantação:**

- **MOLAP** — cubo em banco multidimensional próprio. Agregação pré-calculada,
  resposta muito rápida, volume mais limitado.
- **ROLAP** — modelo dimensional (esquema estrela) sobre SGBD relacional; a
  ferramenta traduz a navegação em SQL. Escala melhor em volume.
- **HOLAP** — híbrido: detalhe no relacional, agregados no multidimensional.

---

## 4. Dimensão, métrica e agregação `Q221`

Os três conceitos que sustentam tudo o que veio acima:

**Dimensão** — o **contexto descritivo** do evento medido: *quem, o quê, onde,
quando, por quê e como*. Seus atributos servem para **filtrar** e **agrupar** as
medidas, e costumam se organizar em **hierarquias** de consolidação. Exemplos:
Tempo, Produto, Cliente, Loja, Canal de venda.

**Métrica (fato / medida)** — o **valor numérico** que resulta do evento de
negócio. Kimball: *"fatos são as medições que resultam de um evento de processo
de negócio, e são quase sempre numéricos"*. Uma linha da tabela fato corresponde
a **um evento de medição**, no grão declarado. Exemplos: quantidade vendida,
valor faturado, saldo, tempo de atendimento.

> Só entra na tabela fato o que é **consistente com o grão**. No exemplo do
> próprio Kimball, numa venda de varejo a quantidade e o valor estendido do
> produto são fatos legítimos; o **salário do gerente da loja não é** — ele não
> é uma medida daquele evento.

**Agregação** — a **consolidação** das métricas ao longo das hierarquias das
dimensões: soma, média, contagem, mínimo, máximo. Codd chama isso de
*consolidação* e define **dimensão** como o nível mais alto de um caminho de
consolidação. É a **finalidade** da abordagem multidimensional: a pergunta
analítica é quase sempre "qual o total de *X* por *Y*".

### 4.1 Comportamento das métricas na agregação

Kimball classifica os fatos por **como se comportam ao serem somados**:

| Tipo | Definição | Exemplo |
|---|---|---|
| **Aditivo** | Pode ser somado **em todas** as dimensões. É o mais flexível e útil. | Quantidade vendida, valor faturado. |
| **Semiaditivo** | Pode ser somado em **algumas** dimensões, mas não em todas — tipicamente **não no tempo**. | **Saldo** de conta: somar saldos de várias contas faz sentido; somar o saldo do mesmo cliente ao longo de 12 meses, não (o correto ali é a média ou o último valor). |
| **Não aditivo** | Não pode ser somado em dimensão alguma. | **Razões e percentuais** (margem %, taxa de conversão). A boa prática é guardar os **componentes aditivos** (numerador e denominador), somá-los e só então calcular a razão no resultado final. |

> Note o que isso diz sobre a abordagem multidimensional: ela não apenas suporta
> somas e médias — ela é **construída em torno delas**, a ponto de classificar
> cada métrica pelo modo como pode ser agregada. Agregação é a razão de ser do
> modelo, e o grão existe justamente para dizer a partir de que nível se agrega.

---

## Parte II — O eixo distribuído

## 5. Transações e ACID `Q225`

O acrônimo **ACID** foi cunhado por **Härder & Reuter (1983)** para nomear as
garantias que uma transação oferece. Uma **transação** é uma unidade lógica de
trabalho — várias operações que o banco trata como uma só.

| Propriedade | O que garante |
|---|---|
| **A — Atomicidade** | **Tudo ou nada.** As operações da transação são aplicadas integralmente ou nenhuma delas fica; em caso de falha ou `ROLLBACK`, o banco desfaz os efeitos parciais. |
| **C — Consistência** | A transação leva o banco de **um estado válido a outro estado válido**, preservando **todas as regras declaradas**: chaves primárias e únicas, integridade referencial, `CHECK`, restrições de domínio. |
| **I — Isolamento** | Transações concorrentes **não interferem** entre si; o resultado é equivalente a alguma execução **serial** delas. Na prática, é regulado por **níveis de isolamento** (*read uncommitted*, *read committed*, *repeatable read*, *serializable*), que trocam rigor por concorrência. |
| **D — Durabilidade** | Uma vez confirmada (`COMMIT`), a transação **sobrevive a falhas** — queda de energia, *crash* do processo. Implementada por log de escrita antecipada (*write-ahead log*) e recuperação na reinicialização. |

O exemplo canônico é a transferência: debitar a conta A e creditar a conta B são
duas escritas que **só fazem sentido juntas**. Atomicidade impede que só o
débito aconteça; consistência garante que a soma dos saldos e as restrições
continuem válidas; isolamento impede que outra transação leia o estado
intermediário; durabilidade garante que, confirmada, ela não se perca.

---

## 6. NoSQL: o que é e de onde veio `Q222` `Q226`

Fowler & Sadalage registram que **não existe definição formal** de NoSQL — o
termo saiu de um *workshop* de 2009. O que existe são **características
comuns**:

- **não usam o modelo relacional** e, portanto, não usam SQL como linguagem
  central;
- são **projetados para rodar em cluster**;
- costumam ser **código aberto**;
- **não têm esquema fixo** — cada registro pode guardar um conjunto diferente
  de campos.

**Por que surgiram.** O argumento de Fowler é de arquitetura: bancos relacionais
foram **projetados para rodar numa máquina só**, então crescer significa
**comprar uma máquina maior**. Mas é mais barato e mais eficaz crescer
**horizontalmente**, comprando muitas máquinas. As máquinas de um cluster grande
são individualmente pouco confiáveis, mas o cluster como um todo continua
funcionando à medida que máquinas morrem — e é exatamente esse o formato da
nuvem. Google (**Bigtable**) e Amazon (**Dynamo**) foram os primeiros a operar
nessa escala e abandonaram o relacional; os dois trabalhos são a inspiração
direta do movimento NoSQL.

### 6.1 Escalabilidade vertical e horizontal `Q226`

| | **Vertical** (*scale up*) | **Horizontal** (*scale out*) |
|---|---|---|
| **O que se faz** | Aumentar os recursos da **mesma máquina**: mais CPU, mais memória, disco mais rápido. | Acrescentar **mais máquinas** ao cluster, distribuindo dados e carga entre elas. |
| **Como se distribui a carga** | Não se distribui — a máquina inteira fica maior. | **Particionamento (*sharding*)** — o conjunto de dados é dividido por uma chave, e cada nó guarda uma parte. **Replicação** — cada partição é copiada em vários nós. |
| **Efeito na aplicação** | Transparente: nada muda no modelo de dados nem no código. | Exige decidir a **chave de partição**, e conviver com a distribuição. |
| **Limite** | **Teto físico e econômico** — existe uma máquina maior até certo ponto, e o preço cresce muito mais que a capacidade. | Capacidade cresce de forma **próxima ao linear** com hardware comum. |
| **Disponibilidade** | A máquina é **ponto único de falha**; o *upgrade* costuma exigir parada. | As **réplicas** absorvem a perda de nós; dá para distribuir geograficamente. |
| **Custo trazido** | Custo de aquisição. | **Custo de consistência** — manter réplicas de acordo é o problema que CAP descreve. |

**Por que a escala horizontal é apontada como ponto forte do NoSQL:** os bancos
NoSQL foram **desenhados para o cluster desde a origem**, e o modelo de dados
colabora com isso. Como os dados que se leem e escrevem juntos ficam **no mesmo
agregado**, o agregado vira a **unidade natural de distribuição**: ele inteiro
mora num nó, e a maioria das operações se resolve **num nó só** — sem junção
distribuída, sem transação distribuída, sem coordenação entre máquinas. Num
modelo relacional normalizado, a mesma operação tende a tocar várias tabelas que
podem estar em nós diferentes, e aí a coordenação come o ganho de escala.

### 6.2 O agregado e a fronteira transacional `Q222`

Este é o conceito que amarra o eixo inteiro. **Agregado** é o conjunto de dados
que a aplicação trata como uma unidade — o pedido com seus itens, o produto com
seus atributos, o carrinho com seu conteúdo. Nos bancos **orientados a
agregado** (chave-valor, documento, família de colunas), o agregado é
simultaneamente a unidade de **armazenamento**, de **distribuição** e de
**atomicidade**. A formulação de Fowler & Sadalage: *os agregados estabelecem a
fronteira das operações ACID.*

**Bancos NoSQL seguem estritamente ACID?** Como regra geral, **não** — e é uma
consequência direta da escolha de rodar em cluster. Manter atomicidade,
isolamento serializável e consistência forte **através de vários nós** exige
coordenação (confirmação em duas fases, consenso), que custa latência e derruba
a disponibilidade quando a rede falha. A maioria dos NoSQL troca isso por
**BASE**.

**BASE** — formulado por **Pritchett (2008)** como contraponto explícito a ACID
(o próprio Brewer conta que criou o termo no fim dos anos 1990 para tornar
explícita a escolha e o espectro entre os dois):

| Letra | Significado |
|---|---|
| **BA — *Basically Available*** | O sistema **sempre responde** a uma requisição, mesmo que a resposta seja um dado desatualizado ou um serviço degradado. Disponibilidade em primeiro lugar. |
| **S — *Soft state*** | O estado **pode mudar ao longo do tempo sem entrada nova**, pela convergência entre réplicas. Não se supõe um estado global estável a cada instante. |
| **E — *Eventually consistent*** | Cessadas as escritas, as réplicas **convergem** para o mesmo valor. A consistência é uma garantia sobre o **futuro**, não sobre o instante da leitura. |

> **Ponto de atenção com precisão temporal:** a afirmação vale como
> **generalização** — a maioria dos NoSQL adota BASE. Mas hoje vários oferecem
> ACID: o **MongoDB** tem transação multidocumento desde a versão 4.0, e o
> **Neo4j** é ACID desde sempre. A formulação exata e defensável é: *a maioria
> troca ACID por BASE, e mesmo os que oferecem ACID normalmente o fazem dentro
> da fronteira do agregado.*

---

## 7. O teorema CAP `Q225`

Enunciado por **Brewer** (1998–2000) e provado por **Gilbert & Lynch (2002)**.
Vale para qualquer *sistema distribuído de dados compartilhados* e trata de três
propriedades:

| | Propriedade | Definição (na formulação de Brewer, 2012) |
|---|---|---|
| **C** | **Consistência** | Equivale a haver **uma única cópia atualizada** do dado — toda leitura enxerga a escrita mais recente. |
| **A** | **Disponibilidade** | Toda requisição a um nó em funcionamento **recebe resposta** (inclusive de atualização). |
| **P** | **Tolerância a partição** | O sistema **continua operando** mesmo que mensagens entre nós se percam ou a rede se divida em grupos incomunicáveis. |

**O que o teorema obriga a escolher, num sistema sujeito a partição.** Pense em
dois nós em lados opostos de uma partição:

- se **permitir** que ao menos um lado atualize o estado, os dois divergem →
  **abre-se mão de C**;
- se **preservar** a consistência, um dos lados precisa **agir como
  indisponível** (recusar ou bloquear a operação) → **abre-se mão de A**.

Só quando os nós **conseguem se comunicar** é possível preservar C e A ao mesmo
tempo. Como numa rede de larga escala a partição é um evento que **acontece** e
não se pode "desligar", **P não é uma opção de projeto** — e a escolha real
recai sobre **C ou A durante a partição**.

### 7.1 A leitura moderna: a escolha só existe durante a partição

Este é o miolo de Brewer (2012), e é o que ele mesmo diz sobre a formulação
"escolha 2 de 3": ela era **enganosa** porque simplificava demais a tensão entre
as propriedades. As razões que ele dá:

1. **Partições são raras** — não há motivo para abrir mão de C ou A quando o
   sistema **não** está particionado.
2. **A escolha se repete em granularidade fina** — subsistemas diferentes podem
   escolher diferente, e a escolha pode variar por operação, por dado ou por
   usuário.
3. **As três propriedades são contínuas, não binárias** — disponibilidade varia
   de 0 a 100%, há vários níveis de consistência, e até a própria existência de
   uma partição pode ser objeto de desacordo dentro do sistema.

Texto literal, que vale guardar: *"CAP proíbe apenas uma parte minúscula do
espaço de projeto: disponibilidade e consistência perfeitas na presença de
partições, que são raras."* A meta moderna, diz ele, é **maximizar as
combinações de C e A que fazem sentido para a aplicação**.

**Como isso vira projeto** — a estratégia em três passos que Brewer propõe:

1. **Detectar** a partição;
2. entrar num **modo de partição explícito**, que pode **limitar** algumas
   operações (por exemplo: aceitar leituras e adições ao carrinho, recusar a
   finalização da compra);
3. iniciar a **recuperação**, restaurando a consistência e **compensando** os
   erros cometidos durante a partição.

### 7.2 A conexão com latência

Operacionalmente, **a essência do CAP acontece num *timeout***. Passado o prazo
de espera por comunicação, o programa é obrigado a decidir:

- **cancelar** a operação → diminui a disponibilidade; ou
- **prosseguir** com a operação → arrisca a inconsistência.

Insistir na comunicação — via Paxos, via *two-phase commit* — apenas **adia** a
decisão; e insistir indefinidamente **é**, na prática, escolher C em vez de A.
Na prática, uma partição é **um limite de tempo sobre a comunicação**.

### 7.3 O C de CAP não é o C de ACID

Distinção que Brewer faz questão de registrar, e que evita confusão real:

- **C do ACID** = a transação **preserva as regras do banco** (chaves únicas,
  integridade referencial, invariantes de negócio).
- **C do CAP** = **consistência de cópia única** — todas as réplicas enxergam o
  mesmo valor. É um **subconjunto estrito** da consistência do ACID.

E o efeito da partição sobre cada letra do ACID não é uniforme:

- **Atomicidade** e **durabilidade** **não precisam ser abandonadas** — ambos os
  lados da partição podem continuar usando operações atômicas e duráveis, e isso
  na verdade **facilita a recuperação** depois.
- **Isolamento** é o que está no **núcleo** do CAP: serializabilidade exige
  comunicação, então, sob partição, um sistema que exige isolamento ACID só pode
  operar **de um lado**.

---

## 8. Os tipos de banco NoSQL `Q223`

Quatro tipos, na taxonomia de Fowler & Sadalage (a mesma de Elmasri & Navathe):

| Tipo | Modelo de dados | Como se acessa | Caso de uso característico |
|---|---|---|---|
| **Chave-valor** | Par **chave → valor**, com o valor **opaco** para o banco (um *blob*). | **Só pela chave.** Não se consulta o conteúdo. | **Sessão de usuário** e **carrinho de compras**: acesso rapidíssimo por identificador, leitura e escrita constantes, sem necessidade de consultar por dentro. Também *cache*. Ex.: Redis, Riak, DynamoDB. |
| **Documento** | Valor é um **documento estruturado** (JSON/BSON/XML), com campos aninhados e **esquema flexível por documento**. | Pela chave **e pelo conteúdo** — dá para consultar e indexar campos internos. | **Catálogo de produtos** e **gestão de conteúdo**: cada categoria tem atributos diferentes, e o produto é um agregado natural, com muitas leituras e poucas escritas. Ex.: MongoDB, CouchDB. |
| **Família de colunas** (*wide-column*) | Linha identificada por chave, com colunas agrupadas em **famílias**; a linha é **esparsa** e cada uma pode ter colunas diferentes. | Pela chave da linha, com leitura seletiva de famílias/colunas. | **Registros de atividade, telemetria e séries temporais**: volume altíssimo de escrita distribuída em muitos nós, e leitura analítica por faixas. Ex.: Cassandra, HBase (linhagem do Bigtable). |
| **Grafo** | **Nós** e **arestas**, ambos com propriedades; o **relacionamento é cidadão de primeira classe**, armazenado explicitamente. | **Travessia** — percorrer caminhos a partir de um nó. | **Recomendação, redes sociais e detecção de fraude**: percorrer rapidamente as ligações entre amigos, compras e avaliações, em profundidade arbitrária. Ex.: Neo4j. |

**A divisão que organiza a lista:** os três primeiros são **orientados a
agregado** — guardam blocos que se leem e escrevem juntos, e por isso se
distribuem bem em cluster. O **grafo é ignorante de agregado**: seu valor está
justamente em atravessar as fronteiras entre entidades, o que o torna mais
difícil de particionar — e é também o tipo que mais frequentemente **mantém
ACID**.

---

## 9. Escolher o banco pelo uso: persistência poliglota `Q224` `Q227`

O argumento de Fowler em *PolyglotPersistence*: escolhe-se a tecnologia de
armazenamento **pelo modo como os dados são usados** por cada aplicação — e não
por padrão institucional. Ele é direto ao dizer que encontra projetos usando
relacional *"porque é o padrão, não porque é a melhor escolha para o
trabalho"*, pagando em tempo de desenvolvimento e desempenho por recursos que
não usam.

A poliglossia acontece **entre aplicações** de uma empresa e também **dentro de
uma mesma aplicação**, quando partes diferentes dos dados têm características de
acesso diferentes.

**O relacional continua sendo a escolha certa** quando (as próprias razões que
Fowler lista):

- o **modelo tabular serve ao dado** — sobretudo quando é preciso decompor os
  dados e recombiná-los de formas diferentes para propósitos diferentes;
- há necessidade de **transações ACID** — para rodar bem em cluster, a maioria
  dos NoSQL tem capacidade transacional limitada; muitas vezes basta, mas nem
  sempre;
- pesam **familiaridade** e **ferramental** — décadas de domínio do SQL
  produziram um ecossistema de ferramentas (relatórios, BI, integração) que o
  lado NoSQL ainda não iguala.

### 9.1 ERP e CRM `Q224`

**Não, NoSQL não é a melhor escolha para ERP e CRM** — e a fundamentação vem do
**perfil dos dados e das transações** desses sistemas:

**Perfil dos dados**

- **Esquema estável e conhecido de antemão.** Cliente, pedido, nota fiscal,
  produto, plano de contas, contrato: entidades bem definidas, que mudam pouco.
  A flexibilidade de esquema do NoSQL resolve um problema que ali não existe.
- **Alto grau de inter-relação.** As entidades se cruzam em todas as direções, e
  o valor do sistema está justamente em navegar essas relações de formas
  imprevistas — que é onde o modelo tabular brilha: decompor e recombinar.
- **Consulta e relatório *ad hoc* atravessando muitas entidades**, com
  ferramental de relatório que fala SQL.

**Perfil das transações**

- As operações são **multi-entidade por natureza**: emitir uma nota fiscal
  movimenta estoque, contas a receber, tributos e razão contábil — tudo ou nada.
- Exigem **integridade forte e imediata**: saldo, crédito e estoque não podem
  ficar temporariamente divergentes.
- **Não existe um agregado natural** que envolva essas operações. Como o
  agregado é a fronteira transacional do NoSQL, uma operação que atravessa
  entidades atravessa também a fronteira da garantia — e é precisamente essa
  garantia que ACID entrega e que o ERP/CRM não pode dispensar.

### 9.2 Caso aplicado: o marketplace `Q227`

Três necessidades, três perfis de acesso, três escolhas — é o exemplo que Fowler
& Sadalage desenham no pôster de persistência poliglota.

| Necessidade | Escolha | Justificativa |
|---|---|---|
| **(i) Registro de pedidos com garantia transacional entre estoque e pagamento** | **Relacional (SGBD com ACID)** | A operação é **multi-entidade e indivisível**: baixar estoque, registrar pagamento e criar o pedido só fazem sentido juntos. **Atomicidade** impede a baixa de estoque sem pagamento; **consistência** mantém as restrições (estoque não negativo, chave estrangeira do pedido); **isolamento** impede que duas compras simultâneas vendam a mesma última unidade; **durabilidade** garante que o pedido confirmado não se perca. Nenhum agregado único envolve estoque *e* pagamento. |
| **(ii) Catálogo com atributos variáveis por categoria e leitura massiva** | **Documento** (MongoDB) | O **esquema flexível** acomodra o fato de que livro, geladeira e camiseta têm atributos completamente diferentes, sem tabela esparsa nem EAV. O produto é um **agregado natural** — tudo que se lê junto está no mesmo documento, servido numa leitura só. O perfil é de **muitas leituras e escritas raras**, e o agregado distribui bem em cluster, permitindo escalar a leitura horizontalmente. |
| **(iii) Recomendação por relações entre usuários e produtos** | **Grafo** (Neo4j) | A pergunta é sobre **caminhos**, não sobre registros: "quem comprou isto também comprou o quê", "produtos avaliados por pessoas com gosto parecido". No grafo, o relacionamento é armazenado explicitamente e a **travessia** de profundidade arbitrária é a operação nativa e barata. No relacional, a mesma pergunta vira uma cadeia de autojunções cujo custo cresce a cada nível de profundidade. |

> Fowler acrescenta uma ressalva honesta ao próprio exemplo: *"este é um exemplo
> muito hipotético; não faríamos recomendações de tecnologia sem mais informação
> de contexto."* A poliglossia também traz custos reais — mais decisões a tomar,
> imaturidade de ferramental, mudança organizacional e a necessidade de lidar
> com o paradigma da consistência eventual. Ela se justifica em projetos
> **estratégicos**, com **necessidade de time-to-market** ou **intensivos em
> dados**, não em projetos utilitários.

---

## 10. Revisão relâmpago

**Eixo analítico**

- **OLTP** opera o negócio: transações curtas, poucas linhas, dados correntes,
  esquema normalizado. **OLAP** entende o negócio: consultas longas, milhões de
  linhas, dados históricos, modelo dimensional.
- **Normalizado → transacional; dimensional → apoio à decisão.** A normalização
  otimiza escrita e integridade; a dimensional otimiza leitura agregada.
- **Modelo dimensional em 4 passos:** processo → **grão** → dimensões → fatos.
  O grão é contrato vinculante e vem antes de tudo.
- **Fato** = medida numérica do evento. **Dimensão** = contexto descritivo
  (*quem, o quê, onde, quando, por quê, como*) para filtrar e agrupar.
- **Cubo** é a estrutura da abordagem **multidimensional**; **esquema estrela** é
  o mesmo modelo dimensional implantado no **relacional**. Cubo acrescenta:
  endereçamento por coordenadas, hierarquias declaradas, agregações
  pré-consolidadas e linguagem mais analítica que SQL.
- ***Roll-up*** sobe na hierarquia, ***drill-down*** desce, ***slice*** fixa um
  valor, ***dice*** recorta faixas em várias dimensões, ***pivot*** rotaciona.
- **Fatos são aditivos, semiaditivos** (saldo — não soma no tempo) **ou não
  aditivos** (razões — guarde os componentes aditivos).

**Eixo distribuído**

- **ACID** = Atomicidade, Consistência, Isolamento, Durabilidade
  (Härder & Reuter, 1983).
- **BASE** = *Basically Available*, *Soft state*, *Eventually consistent*
  (Pritchett, 2008). É a troca que a maioria dos NoSQL faz para rodar em cluster.
- **Agregado** é a unidade de armazenamento, distribuição **e atomicidade** nos
  NoSQL orientados a agregado — é ele que estabelece a fronteira ACID.
- **CAP:** C = cópia única atualizada; A = todo pedido recebe resposta;
  P = opera apesar de partição. **A escolha entre C e A só se coloca durante a
  partição**; fora dela, dá para ter as duas. Operacionalmente, a decisão
  acontece **num timeout**: cancelar (perde A) ou prosseguir (arrisca C).
- **C do CAP** = consistência de cópia única, subconjunto estrito do **C do
  ACID** = preservação das regras do banco.
- **Escala vertical** = mais recurso na mesma máquina (teto físico, ponto único
  de falha). **Escala horizontal** = mais máquinas, com **particionamento +
  replicação**; é ponto forte do NoSQL porque o agregado inteiro cabe num nó.
- **Quatro tipos:** chave-valor (sessão, carrinho) · documento (catálogo,
  conteúdo) · família de colunas (logs, telemetria) · grafo (recomendação,
  rede social). Os três primeiros são orientados a agregado; o grafo não é.
- **Escolha pelo uso do dado** (persistência poliglota). ERP/CRM ficam no
  relacional pelo **esquema estável, dados muito inter-relacionados e transação
  multi-entidade com integridade forte**.

---

## Fontes

**Eixo analítico**

- **Codd, E.F.; Codd, S.B.; Salley, C.T. — *Providing OLAP to User-Analysts: An
  IT Mandate*** (1993). O paper que cunhou o termo OLAP e as 12 regras; fonte da
  fronteira OLTP × OLAP, da *visão conceitual multidimensional* e das definições
  de consolidação, *drill-down* e *roll-up*.
  → `fontes-gabaritos/bancodedados/codd-1993-providing-olap.pdf`
  *(Ressalva: patrocinado pela Arbor Software; para definição neutra, use
  Kimball ou Silberschatz.)*
- **Kimball Group — *Dimensional Modeling Techniques*** (extraído de *The Data
  Warehouse Toolkit*, 3ª ed., Kimball & Ross, 2013). Fonte canônica de tabela
  fato, tabela dimensão, grão, esquema estrela, cubo OLAP e fatos
  aditivos/semiaditivos/não aditivos.
  → `fontes-gabaritos/bancodedados/kimball-dimensional-modeling-techniques.pdf`
- **Silberschatz, Korth & Sudarshan — *Database System Concepts*, 7ª ed.**,
  cap. 11 (*Data Analytics*). Slides gratuitos: https://www.db-book.com/
- **Elmasri & Navathe — *Sistemas de Banco de Dados*, 7ª ed.**, cap. 29
  (*Data Warehousing e OLAP*).
- **Microsoft Learn — *Online Analytical Processing*** — cubo, dimensão e medida
  com redação atual.
  https://learn.microsoft.com/en-us/azure/architecture/data-guide/relational-data/online-analytical-processing

**Eixo distribuído**

- **Härder, T.; Reuter, A. — *Principles of Transaction-Oriented Database
  Recovery***, *ACM Computing Surveys* 15(4), 1983. O paper que cunhou ACID.
  → `fontes-gabaritos/bancodedados/harder-reuter-1983-acid.pdf`
  *(scan sem camada de texto; para ACID em texto pesquisável, Silberschatz cap. 17.)*
- **Gilbert, S.; Lynch, N. — *Brewer's Conjecture and the Feasibility of
  Consistent, Available, Partition-Tolerant Web Services***, *ACM SIGACT News*
  33(2), 2002. A prova formal do teorema CAP.
  → `fontes-gabaritos/bancodedados/gilbert-lynch-2002-cap-proof.pdf`
- **Brewer, E. — *CAP Twelve Years Later: How the "Rules" Have Changed***,
  *IEEE Computer*, fev/2012. A leitura moderna do CAP pelo próprio autor, o
  quadro-resumo ACID/BASE/CAP e a conexão CAP–latência.
  → `fontes-gabaritos/bancodedados/brewer-2012-cap-twelve-years-later.pdf`
- **Gilbert, S.; Lynch, N. — *Perspectives on the CAP Theorem*** (2012).
  → `fontes-gabaritos/bancodedados/gilbert-lynch-2012-perspectivas-cap.pdf`
- **Pritchett, D. — *BASE: An Acid Alternative***, *ACM Queue* 6(3), 2008. A
  formulação canônica de BASE. https://queue.acm.org/detail.cfm?id=1394128
- **Vogels, W. — *Eventually Consistent*** (2008).
  https://www.allthingsdistributed.com/2008/12/eventually_consistent.html
- **Fowler, M.; Sadalage, P. — *NoSQL Databases / Polyglot Persistence*** (2012),
  o pôster que condensa *NoSQL Distilled*. Taxonomia dos quatro tipos, noção de
  agregado e o mapa de persistência poliglota.
  → `fontes-gabaritos/bancodedados/fowler-sadalage-nosql-distilled-poster.pdf`
- **Fowler, M. — *PolyglotPersistence*** (2011).
  https://martinfowler.com/bliki/PolyglotPersistence.html
- **Fowler, M.; Sadalage, P. — *NoSQL Distilled — Key Points***.
  https://martinfowler.com/articles/nosqlKeyPoints.html
- **DeCandia, G. et al. — *Dynamo: Amazon's Highly Available Key-value Store***,
  SOSP 2007. https://www.allthingsdistributed.com/files/amazon-dynamo-sosp2007.pdf
- **Chang, F. et al. — *Bigtable: A Distributed Storage System for Structured
  Data***, OSDI 2006.
  https://static.googleusercontent.com/media/research.google.com/en//archive/bigtable-osdi06.pdf
- **Elmasri & Navathe**, cap. 24 (*NOSQL Databases and Big Data Storage
  Systems*); **Silberschatz**, cap. 10 (*Big Data*), 17 (*Transactions*) e 23
  (*Parallel and Distributed Transaction Processing*).
