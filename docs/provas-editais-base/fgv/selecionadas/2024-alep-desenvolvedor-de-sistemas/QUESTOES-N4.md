# ALEP 2024 — questões atreladas a tópicos 🟩 N4

Recorte das **40 questões de Conhecimentos Específicos** (31 a 70) da prova de
**Analista Legislativo – Desenvolvedor de Sistemas** (ALEP, FGV, 07/04/2024,
tipo 1 / branca), filtrado pelos tópicos classificados como **N4 — Idêntico** em
[COMPARACAO-DATAPREV-2024.md](COMPARACAO-DATAPREV-2024.md).

**N4 = mesmo tópico, mesma redação (ou mesmo rol fechado)** — a questão funciona
como se fosse da prova-alvo (DATAPREV, Perfil 3: Desenvolvimento de Software).

- **21 das 40** questões específicas caem em tópico N4 (52,5%).
- Fonte do enunciado: `md/docs/provas-editais-base/fgv/selecionadas/2024-alep-desenvolvedor-de-sistemas/fgv-2024-alep-analista-legislativo-desenvolvedor-de-sistemas-tipo-1.md`
- Gabarito: `gabarito-fgv-2024-alep-preliminar.pdf` — **preliminar**, anterior aos
  recursos. Confira antes de tratar qualquer letra como definitiva.
- ⚠️ = enunciado depende de imagem (código ou diagrama) que a extração não
  carrega; abra o PDF na página indicada.

---

## Índice

| Q | Tópico na ALEP | Item DATAPREV | Bloco |
|:--:|---|---|---|
| 31 | 1.1.3 Scrum/XP/Kanbam + TDD; 1.3 APF | DS-8, DS-7, DS-11 | Eng. de software |
| 32 | 1.4 Arquiteturas de software. Padrões arquiteturais | DS-3, DS-17 | Eng. de software |
| 33 | 1.4 Padrões arquiteturais; 2.1.2 JEE v8 | DS-3, DS-1 | Eng. de software |
| 34 ⚠️ | 2.1.1 Java (JDK 17); 2.1.2 JEE v8 | DS-1 | Java |
| 39 | 2.5.1 JSON; 2.1.1 JavaScript | DS-5, DS-1 | Java/frontend |
| 40 | 2.3.3 React.JS | DS-13 | Frontend |
| 41 | 2.4.1 Rest API | DS-5, DS-3 | Integração |
| 42 | 2.3.1 HTML5 (HTML, CSS, JavaScript) | DS-13 | Frontend |
| 44 | 1.5 Testes de software; 2.2.4 testes unitários | DS-7 | Testes |
| 45 | 1.7 Gerência de configuração de software | DS-7 (GIT) | Eng. de software |
| 50 | 4.8.1 Propriedades ACID | BD-11 | Banco de dados |
| 53 | 5.4 Data warehousing | BI-3, BI-4 | BI |
| 54 | 5.4 Sistemas OLAP | BI-3, BI-4 | BI |
| 55 ⚠️ | 2.2.4 Testes unitários (JUnit) | DS-7, DS-1 | Testes |
| 62 | 4.4.3 Modelo relacional; 4.5.2 projeto lógico | BD-2, BD-1 | Banco de dados |
| 63 ⚠️ | 4.5.1/4.5.2 conceitual → lógico | BD-1 | Banco de dados |
| 64 ⚠️ | 4.5.1/4.5.2 conceitual → lógico | BD-1 | Banco de dados |
| 65 | 4.6 SQL:2003 | BD-7 | Banco de dados |
| 66 | 4.6 SQL:2003 | BD-7 | Banco de dados |
| 69 ⚠️ | 4.5.1 modelo de classes da UML | BD-1 | Modelagem |
| 70 ⚠️ | 5.3 Modelagem multidimensional | BD-6, BD-2 | BI |

---

## Engenharia de software

### 31 — Metodologias ágeis, TDD e pontos de função

Uma empresa deseja construir uma aplicação para usuários de impressão 3D, como
venda de impressoras e filamentos. A interface com o usuário precisa permitir que
ele navegue entre diferentes produtos.

Assinale a opção que descreve corretamente a aplicação de metodologias de
engenharia de *software* no desenvolvimento deste projeto.

- (A) A aplicação de metodologias ágeis por meio de pontos de função por meio de FDD (*Feature Driven Development*). A codificação deve utilizar TDD (*Test Driven Development*).
- (B) O modelo FDD proporcionará estimativas precisas, enquanto a aplicação de TDD reduzirá custos significativamente.
- (C) Utilizando *Scrum* e Pontos de Função o desenvolvimento ágil será eficiente e o uso de TDD, junto com a implementação de SOA, simplificará a integração com serviços externos, otimizando o projeto.
- (D) A integração de Kanbam e Pontos de Função é um ponto chave para aplicação da metodologia ágil.
- (E) Implementar *Scrum* e TDD resultará em uma metodologia ágil robusta, permitindo estimativas precisas e desenvolvimento eficiente, enquanto a integração de SOA otimizará o acesso a serviços externos.

### 32 — Padrão arquitetural para um MVP

Uma empresa deseja lançar uma primeira versão de um aplicativo de vendas de
produtos não muito comuns e, portanto, precisa saber qual será a melhor forma de
aceitação dos usuários. Neste cenário, assinale a opção que indica o padrão
arquitetural e metodologias corretas a serem aplicadas no desenvolvimento deste
sistema.

- (A) A arquitetura baseada em *Peer-to-Peer*, pois facilita o gerenciamento de mudanças e torna o controle de versão mais intuitivo, reduzindo a necessidade de ferramentas especializadas.
- (B) Uma arquitetura de 3 camadas com padrão arquitetural Modelo-Visão-Controlador (MVC), facilitando o gerenciamento de mudanças e dependências. Contudo, não impactando diretamente o controle de versão, nem a integração contínua.
- (C) O padrão MVC não pode ser aplicado nesse caso; ao invés disso, usar a arquitetura de camadas irá facilitar o controle de versão.
- (D) Optar pela arquitetura baseada em componentes com padrão MVC, já que simplifica o gerenciamento de mudanças e torna o controle de versão desnecessário, devido à independência dos componentes.
- (E) A adoção do padrão de arquitetura Monolítica utilizando padrões *Factory*, já que concentra todos os componentes em um único módulo, simplificando o gerenciamento de mudanças.

### 33 — MVC em aplicação Java web de três camadas

Queremos construir uma aplicação WEB em JAVA em três camadas.

Sobre a utilização do padrão de projeto MVC nesta aplicação, assinale a
afirmativa correta.

- (A) A primeira camada, ou camada de apresentação, e a segunda camada, ou camada de negócios, ambas implementam uma versão do MVC.
- (B) A camada de apresentação corresponde a *View* do MVC além de implementar as classes do *Model*.
- (C) A camada de apresentação corresponde a *View* do padrão MVC, o *Controler* é implementado na segunda camada utilizando o *Model* que é implementado na terceira camada.
- (D) A primeira camada corresponde a *View* do padrão MVC e a terceira camada implementa o *Controler* e o *Model* do padrão MVC.
- (E) A camada de apresentação corresponde ao *frontend* e o *backend* corresponde unicamente a *View* e o *Controler* do padrão MVC.

### 44 — Testes de unidade

No contexto da Engenharia de Software, os testes de software desempenham um papel
consideravelmente importante no âmbito do processo de desenvolvimento.

Nesse contexto, os testes de unidade caracterizam-se por

- (A) dependerem do sucesso do teste de integração descendente (*top-down*).
- (B) representarem validações em componentes que representam programas independentes.
- (C) serem responsáveis pela verificação na menor unidade do componente ou módulo de software.
- (D) substituírem paulatinamente a abordagem de teste por fumaça na verificação do software.
- (E) utilizarem como metodologia de base a abordagem de testes de regressão.

### 45 — Repositório de gestão de configuração

Uma das ferramentas mais importantes no processo de desenvolvimento de *software*
é o repositório de gestão de configuração de *software* utilizado. Ele oferece um
conjunto de estruturas e mecanismos que auxiliam a equipe de desenvolvimento a
gerenciar as modificações experimentadas por um *software*.

Em termos de características, em um repositório de gestão de configuração é
fundamental

- (A) acompanhar e manter as dependências entre os elementos de dados sob sua guarda.
- (B) compatibilizar as estruturas de padrões de projetos GoF e GRASP ao longo do desenvolvimento do *software*.
- (C) demandar um sistema de banco de dados externo para salvar documentos relacionados ao *software*.
- (D) implantar métodos ágeis de levantamento de requisitos, como o QFD (*Quality Function Deployement*).
- (E) reprogramar o *software* baseado no histórico de mudanças a partir da última versão salva.

---

## Java, frontend e integração

### 34 ⚠️ — Saída de script Java (JEE v8 & JDK 17)

> Depende do código na imagem: `..._imagens/pag-0011-01.png` (PDF, pág. 11).

Analise o script Java a seguir. Ao executar o script acima, a saída no console
será

- (A) `JEE v8 & JDK 17: 5.`
- (B) `JEE v8 & JDK 17: 3.`
- (C) `JEE v8 & JDK 17: 8.`
- (D) `JEE v8 & JDK 17.`
- (E) Erro de compilação.

### 39 — JSON.parse em JavaScript

Analise o código Javascript a seguir.

```html
<!DOCTYPE html>
<html>
<body>
<p id="demo"></p>
<script>
let text = '{"Funcionarios":['
  + '{"Nome":"J.","Sobrenome":"Junior" },'
  + '{"Nome":"A.","Sobrenome":"Filho" },'
  + '{"Nome":"P.","Sobrenome":"Neto" },'
  + '{"Nome":"L.","Sobrenome":"Bisneto" },'
  + '{"Nome":"P.","Sobrenome":"Filha" }]}';
const obj = JSON.parse(text);
document.getElementById("demo").innerHTML =
  obj.Funcionarios[2].Nome + " " + obj.Funcionarios[2].Sobrenome;
</script>
</body>
</html>
```

O resultado exibido ao rodar esse código será

- (A) `A. Filho`
- (B) `P. Filha`
- (C) `L. Bisneto`
- (D) `P. Neto`
- (E) `J. Junior`

### 40 — React (assinale a INCORRETA)

Sobre a biblioteca de Javascript *React*, assinale a afirmativa **incorreta**.

- (A) *React* permite que a interface do usuário seja construída por meio de componentes reutilizáveis.
- (B) *React* manipula os objetos DOM reais do navegador diretamente, melhorando o desempenho das atualizações na interface do usuário.
- (C) *React Props* são como argumentos de função em JavaScript e atributos em HTML.
- (D) JSX facilita a escrita e a adição de HTML no *React*.
- (E) O *React* renderiza HTML para a página da *web* usando uma função chamada *createRoot*() e seu método *render*().

### 41 — Princípio arquitetural do REST

Pensando em uma implementação comum da API REST, assinale a opção que indica o
principal princípio associado ao seu estilo arquitetural.

- (A) Comunicação bidirecional entre clientes e servidores.
- (B) Transferência de representações de recursos por meio de operações padrão (como GET, POST, PUT e DELETE).
- (C) Transferência direta somente de objetos Javascript entre clientes e servidores.
- (D) Utilização de mensagens SOAP para comunicação entre sistemas.
- (E) Utilização de um modelo de solicitação com estado.

### 42 — Box Model CSS

O Box Model CSS é essencialmente uma caixa que envolve cada elemento HTML.

Ele é formado por

- (A) *height*, *width*, *border* e *padding*.
- (B) *width*, *border*, *padding* e *margin*.
- (C) *content*, *padding*, *border*s e *margins*.
- (D) *height*, *border*, *content* e *margin*.
- (E) *height*, *width*, *border* e *content*.

### 55 ⚠️ — Testes unitários com JUnit

> Depende do código na imagem: `..._imagens/pag-0015-01.png` (PDF, pág. 15).

O trecho de código a seguir mostra um trecho de um sistema de biblioteca digital
feito em JAVA e também o código de testes unitários com JUnit para as funções de
inserção e remoção.

Considerando que a lista de livros da biblioteca esteja vazia, o código de
execução de testes unitários *testLista* garante que a lista de livros

- (A) fica vazia mesmo após inserção.
- (B) volta a ser vazia após inserção e remoção.
- (C) não gera erro ao remover um livro que não existe.
- (D) não remove o livro após ser inserido.
- (E) tem um conteúdo incerto que não pode ser determinado.

---

## Banco de dados

### 50 — Propriedades ACID e escalas serializáveis

No contexto de processamento de transações em sistemas de bancos de dados
relacionais, definimos uma *escala (ou schedule) concorrente* a uma execução
intercalada das operações (ou instruções) das transações envolvidas na escala.

Da mesma maneira, uma *execução serial* é aquela na qual todas as operações de
uma transação são realizadas, sem alternância com operações de outras transações.
O processo se repete até que todas as transações da escala tenham sido
completadas.

Ainda, uma escala é dita *serializável* se o resultado de sua execução produz o
mesmo resultado de alguma execução serial das transações envolvidas.

Dados os conceitos anteriormente apresentados, e considerando-se as propriedades
ACID de transações, assinale a opção que indica a propriedade ACID que guarda
relação direta com o conceito de escalas concorrentes serializáveis.

- (A) Atomicidade.
- (B) Consistência.
- (C) Corretude.
- (D) Durabilidade.
- (E) Isolamento.

### 62 — Atributo com valores únicos no modelo relacional

> Contexto compartilhado com as questões 63 e 64 — modelo conceitual de classes
> de uma Casa Legislativa (imagem `..._imagens/pag-0020-01.png`, PDF pág. 20),
> mapeado para:
>
> ```
> Proposição ( {cod_proposicao} <PK>, identificacao, ementa, indexacao, tipo )
> ```

Seja o atributo "identificacao" aquele que necessita, para implementar a
semântica do caso, a demanda de não permissão de valores repetidos – ou seja,
somente aceita valores únicos.

No contexto do modelo relacional de banco de dados, ele é considerado um(a)

- (A) atributo alternativo.
- (B) atributo multivalorado.
- (C) chave estrangeira.
- (D) chave secundária.
- (E) superchave mínima.

### 63 ⚠️ — Mapeamento conceitual → lógico (Tramitação / Despacho)

> Depende do modelo de classes: `..._imagens/pag-0020-01.png` (PDF, pág. 20).

Considerando, nas relações apresentadas, os atributos indicados como chaves
primárias `<PK>` ou estrangeiras `<FK>` entre chaves, assinale a opção que
representa um mapeamento ORM possível para as classes "Tramitação" e "Despacho",
mantendo-se a completa semântica do modelo conceitual.

- (A) `Tramitação ( {cod_tramitacao} <PK>, forma, regime )` / `Despacho ( {cod_despacho} <PK>, data, andamento )`
- (B) `Tramitação ( {cod_tramitacao} <PK>, forma, regime )` / `Despacho ( {cod_tramitacao <FK>, cod_despacho} <PK>, data, andamento )` — Restrição da tabela Despacho: `cod_tramitacao REFERENCIA Tramitação(cod_tramitacao)`
- (C) `Tramitação ( {cod_tramitacao, cod_despacho <FK>} <PK>, forma, regime )` / `Despacho ( {cod_despacho} <PK>, data, andamento )` — Restrição da tabela Tramitação: `cod_despacho REFERENCIA Despacho(cod_despacho)`
- (D) `Tramitação ( {cod_proposicao <FK>, cod_tramitacao} <PK>, forma, regime )` / `Despacho ( { {cod_proposicao, cod_tramitacao} <FK>, cod_despacho} <PK>, data, andamento )` — Restrição da tabela Tramitação: `cod_proposicao REFERENCIA Proposição(cod_proposicao)`; Restrição da tabela Despacho: `{cod_proposicao, cod_tramitacao} REFERENCIA Tramitação(cod_proposicao, cod_tramitacao)`
- (E) `Tramitação ( {cod_proposicao <FK>, cod_tramitacao} <PK>, forma, regime )` / `Despacho ( {cod_proposicao <FK>, cod_tramitacao <FK>, cod_despacho} <PK>, data, andamento )` — Restrição da tabela Tramitação: `cod_proposicao REFERENCIA Proposição(cod_proposicao)`; Restrições da tabela Despacho: `cod_proposicao REFERENCIA Proposição(cod_proposicao)` e `cod_tramitacao REFERENCIA Tramitação(cod_tramitacao)`

### 64 ⚠️ — Mapeamento de associação (classe "Submissão")

> Depende do modelo de classes: `..._imagens/pag-0020-01.png` (PDF, pág. 20).

Considerando a abordagem de mapeamento objeto-relacional (ORM), seja o mapeamento
da classe "Parlamentar" realizado da forma que segue:

```
Parlamentar ( {cod_parlamentar} <PK>, nome, partido, email, telefone,
              endereco, data_nascimento, naturalidade, foto )
```

A fim de manter, no modelo lógico de banco de dados relacional, a semântica
expressa na classe "Submissão" do modelo conceitual, e considerando que

- I. o atributo `id_parlamentar<FK>` indica uma chave estrangeira para a chave primária da tabela "Parlamentar";
- II. o atributo `id_proposicao<FK>` indica uma chave estrangeira para a chave primária da tabela "Proposição".

Nesse caso, uma abordagem correta seria

- (A) adicionar na tabela "Parlamentar" a chave estrangeira "cod_proposicao", referenciando a chave primária da tabela "Proposição".
- (B) alterar a cardinalidade máxima da associação entre "Parlamentar" e "Proposição", com vistas a torná-la com conectividade muitos-para-muitos.
- (C) criar a tabela "Submissão" com o seguinte esquema: `Submissão ({id_parlamentar<FK>, id_proposicao<FK>} <PK>, data, id_parlamentar, id_proposicao)`.
- (D) criar a tabela "Submissão" com o seguinte esquema: `Submissão (id_submissao <PK>, data, id_parlamentar<FK>)`.
- (E) criar a tabela "Submissão" com o seguinte esquema: `Submissão (id_submissao <PK>, data, id_parlamentar<FK>, id_proposicao<FK>)`.

### 65 e 66 — SQL

> Esquema comum às duas questões:
>
> ```sql
> create table recurso (
>   id integer primary key,
>   nome varchar(20) not null,
>   valor real
> );
> create table projeto (
>   id integer primary key,
>   nome varchar(20) not null,
>   verba real
> );
> create table alocacao (
>   id_recurso integer,
>   id_projeto integer,
>   primary key(id_recurso, id_projeto),
>   foreign key(id_recurso) references recurso,
>   foreign key(id_projeto) references projeto
> );
> ```

**65.** Assinale a opção que apresenta a consulta que gera como resultado de
execução uma lista com o nome dos recursos alocados em **todos** os projetos
cadastrados.

- (A) `select r.nome from recurso r`
- (B) `select r.nome from recurso r where not exists (select 1 from alocacao a where a.id_recurso=r.id)`
- (C) `select r.nome from recurso r where r.valor>(select avg(valor) from recurso)`
- (D) `select r.nome from recurso r where not exists (select 1 from projeto p where not exists (select 0 from alocacao a where a.id_recurso=r.id and a.id_projeto=p.id))`
- (E) `select r.nome from recurso r where exists (select 1 from alocacao a where a.id_recurso=r.id)`

**66.** A saída gerada pela consulta

```sql
select r.nome from recurso r
left join alocacao a on a.id_recurso = r.id
where a.id_projeto is null
```

apresenta o nome dos recursos

- (A) alocados a nenhum projeto.
- (B) designados a projetos com verba alocada.
- (C) distribuídos à esquerda de projetos.
- (D) reservados a projetos com identificação nula.
- (E) vinculados a projetos sem nomes cadastrados.

---

## Modelagem e BI

### 53 — Data warehouse × OLTP

O processo de tomada de decisão conta com ferramentas computacionais que otimizam
e auxiliam gestores em diferentes níveis de atuação organizacional. No que se
refere ao suporte de dados, os armazéns de dados (ou *data warehouses*)
representam uma importante alternativa para o armazenamento de dados por conta de
suas características estruturais.

Assinale a opção que apresenta uma característica que diferencia um *data
warehouse* de uma base de dados com suporte ao processamento OLTP.

- (A) Dimensões e níveis de agregação ilimitados.
- (B) Operações restritas em dimensões.
- (C) Tratamento estático da matriz esparsa.
- (D) Visão conceitual unidimensional.
- (E) Volatilidade dos dados armazenados.

### 54 — Operações OLAP

Os sistemas OLAP, com vistas a auxiliar o processo de tomada de decisão,
geralmente oferecem um conjunto de operações pré-programadas.

A operação que consiste em níveis cada vez maiores de detalhamento na análise de
uma determinada dimensão é conhecida como

- (A) *drill-down*.
- (B) *pivoting*.
- (C) *rolap*.
- (D) *slice* e *dice*.
- (E) SMP.

### 69 ⚠️ — Semântica de modelo de classes (UML)

> Depende do diagrama: `..._imagens/pag-0023-01.png` (PDF, pág. 23).

O modelo de classes de análise a seguir, especificado utilizando a UML, possui a
seguinte configuração. Assinale a opção que reflete uma interpretação correta da
semântica de leitura do diagrama.

- (A) A classe "Imagem" possui um total de seis atributos.
- (B) Existe um relacionamento de composição entre as classes "Preparo" e "Imagem".
- (C) Existe uma classe associativa entre as classes "Paciente" e "Exame".
- (D) O modelo carece de multiplicidades entre as classes "Exame" e "Imagem".
- (E) Um paciente pode não estar associado a um objeto "Exame".

### 70 ⚠️ — Modelagem multidimensional

> Depende do modelo: `..._imagens/pag-0023-02.png` (PDF, pág. 23).

Seja o modelo multidimensional representado a seguir, refletindo uma dinâmica de
vendas de produtos por vendedores e por região. Considere que

- I. os campos indicados como `<PK>` são os identificadores de suas respectivas tabelas;
- II. na tabela "Vendas", o atributo "cod_vendedor" referencia o identificador `cod_vendedor` da tabela "Vendedor";
- III. na tabela "Vendas", o atributo "cod_regiao" referencia o identificador `cod_regiao` da tabela "Região";
- IV. na tabela "Vendas", o atributo "cod_produto" referencia o identificador `cod_produto` da tabela "Produto";
- V. na tabela "Região", o atributo "cod_cidade" referencia o identificador `cod_cidade` da tabela "Cidade".

Ao analisar a semântica do modelo, é correto inferir que

- (A) a dimensão tempo está representada como tabela oculta.
- (B) a menor granularidade de tempo é data da venda.
- (C) existem quatro tabelas fato e uma tabela dimensão.
- (D) implementa o esquema multidimensional estrela.
- (E) um registro específico de venda pode se relacionar a várias cidades.

---

## Fronteira — quase N4

Quatro questões ficaram de fora por um fio. Valem como treino, mas o ponto
central de cada uma é um tópico N3/N2 da comparação:

| Q | Assunto | Por que não entrou |
|:--:|---|---|
| 36 | JavaScript puro × jQuery | JavaScript é N4, mas o que a questão cobra são características do **jQuery** (2.3.2, N2) |
| 46 | Modelos de processo especializados (métodos formais, espiral, modelo V…) | É 1.1.1 *ciclo de vida do software* → DS-1, classificado **N3** |
| 51 | Classe de SGBD com HTAP (NewSQL, NoSQL, Polystores) | NoSQL é N4, mas a resposta depende de **NewSQL** (4.11.3, N2) |
| 68 | `GRANT` / `REVOKE` e segurança discricionária | Sintaxe SQL é N4, porém o assunto é 4.10 *Segurança em SGBDs* → SEG-4.1, **N2** |

## Fora do recorte (19 questões)

| Q | Assunto | Nível |
|:--:|---|:--:|
| 35 | NPM × Maven (gerência de dependências e build) | N2 |
| 37 | Python — média de preços de estoque | N2 |
| 38 | Python — captura de sintaxe de frases | N2 |
| 43 | Bootstrap — classe `d-none` | N2 |
| 47 | Linguagem R — `as.matrix`, `dim`, `is.matrix` | N2 |
| 48 | Independência de dados em SGBD | N2 |
| 49 | Álgebra relacional — equivalência da projeção | N2 |
| 52 | Limpeza de dados — mecanismo MAR | N3 |
| 56 | UML — diagrama de casos de uso (reembolso) | N2 |
| 57 | UML — diagrama de sequência | N2 |
| 58 | UML — diagrama de atividades | N2 |
| 59 | UML — semântica de casos de uso (include/extend) | N2 |
| 60 | Python — repetição de lista e operador `in` | N2 |
| 61 | Linguagem C — `++i<<2` dentro do `for` | N2 |
| 67 | Fragmentação horizontal derivada (BD distribuído) | N2 |

*(36, 46, 51 e 68 estão na tabela de fronteira acima.)*

---

## Gabarito preliminar — questões N4

> ⚠️ Extraído de `gabarito-fgv-2024-alep-preliminar.pdf`, **Analista Legislativo
> – Desenvolvedor de Sistemas, prova tipo 1**. É a versão **anterior aos
> recursos**; a definitiva não está no acervo.

| Q | 31 | 32 | 33 | 34 | 39 | 40 | 41 | 42 | 44 | 45 | 50 |
|---|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| **Resp.** | E | B | B | C | D | B | B | C | C | A | E |

| Q | 53 | 54 | 55 | 62 | 63 | 64 | 65 | 66 | 69 | 70 |
|---|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| **Resp.** | A | A | B | E | D | C | D | A | A | B |
