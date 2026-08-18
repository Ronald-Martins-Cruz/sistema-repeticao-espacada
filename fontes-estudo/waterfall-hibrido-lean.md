# Waterfall, Ágil Híbrido e Lean — o básico

> Complemento da seção 2.13 (ver [agil.md](agil.md), sobretudo o item 7).
> Aqui o foco são as **três abordagens que não são Scrum nem Kanban**, do jeito
> que o edital as cita: *"tipos de abordagem: tradicional, híbrida e ágil
> (framework Scrum, metodologia Lean e método Kanban)"*.

---

## 0. O eixo que organiza as três

Toda essa parte do edital gira em torno de **um único eixo**: o quanto se define
no começo × o quanto se deixa emergir durante a execução.

| Abordagem | Requisitos | Entrega | Mudança |
|---|---|---|---|
| **Preditiva** (tradicional / cascata) | fixados **no início** | **uma vez**, no fim | tratada como **exceção** (controle de mudanças) |
| **Iterativa** | evoluem por **refinamento** | uma vez, no fim | esperada — refina-se o **entendimento** |
| **Incremental** | fixos por incremento | **em partes** utilizáveis | esperada entre incrementos |
| **Ágil** | **emergentes** | **frequente e em partes** | é a **regra**, bem-vinda |

**Híbrido** não é uma quinta caixa: é **misturar caixas** dentro do mesmo
projeto. E **Lean** não mora nesse eixo — é a **filosofia de fundo** (fluxo de
valor, eliminar desperdício) de onde saíram o ágil e o Kanban.

---

## 1. Waterfall (Cascata) — abordagem tradicional/preditiva

### Definição

Modelo em que o desenvolvimento avança em **fases sucessivas**: cada fase
**termina e é aprovada** antes de a próxima começar, e o software funcionando
só aparece **no fim**. É **dirigido a plano** (*plan-driven*): planeja-se muito
no começo para executar com previsibilidade depois.

### As fases (as sete de Royce, 1970)

```
Requisitos do sistema → Requisitos de software → Análise →
Projeto do programa → Codificação → Testes → Operação
```

A forma resumida, mais comum hoje, agrupa isso em
**requisitos → projeto/design → implementação → testes → implantação/manutenção**.
O que define o modelo é a **sequência linear com aprovação de fase**, não o
número de caixas.

### Características principais

- **Linear e sequencial**, com **marcos e aprovações formais** ("portões") entre
  fases.
- **Escopo definido e congelado no início**; mudança entra por **controle formal
  de mudanças**, e custa caro.
- **Documentação pesada** é o meio de comunicação e de transferência entre fases.
- **Uma entrega única** no final — o cliente vê o produto tarde.
- **Papéis especializados por fase** (analista, projetista, programador, testador).
- **Testes concentrados no fim** → é onde o risco de custo e prazo se acumula.
- **Rastreabilidade e previsibilidade altas** quando os requisitos realmente não
  mudam.

### Quando faz sentido

Requisitos **estáveis e bem conhecidos**, tecnologia dominada, forte exigência
de **conformidade/auditoria** ou de **contrato por escopo fechado** (obra,
sistema embarcado crítico, migração com regra conhecida).

### Limitações

Erro de requisito só aparece tarde; **feedback do cliente concentrado nos
extremos** (levantamento e entrega); baixa tolerância a mudança; e valor
entregue **todo de uma vez** — ou nenhum. Note que cascata **não significa
ausência** de teste ou de cliente: significa teste **no fim** e contato com o
cliente **nas pontas**.

### Nota histórica sobre Royce

Royce **descreveu** o modelo em 1970, mas **não defendeu a cascata pura** — no
mesmo artigo ele afirma que *"o desenvolvimento é iterativo"* e que os passos
**nunca são meramente sucessivos**. Suas cinco recomendações eram: **projetar o
programa primeiro**, **documentar o projeto**, **"fazer duas vezes"** (*do it
twice* — a primeira versão como simulação do produto final), **planejar,
controlar e monitorar os testes** e **envolver o cliente**. O termo "waterfall"
também **não é dele**; veio depois.

---

## 2. Ágil Híbrido — a abordagem híbrida do edital

### Definição

**Combinação, no mesmo projeto, de elementos ágeis e não ágeis.** Nem cascata
pura, nem ágil puro: usa-se planejamento/fases/documentação onde a
previsibilidade é exigida e ciclos iterativos onde a incerteza é alta.

### Formas comuns de combinar

| Arranjo | Como fica na prática |
|---|---|
| **Ágil dentro, preditivo fora** | O time trabalha em Sprints, mas o **programa/portfólio** tem fases, marcos e *gates* de aprovação. É o arranjo mais comum em órgão público. |
| **Preditivo antes, ágil depois** | Requisitos, arquitetura e contratação feitos de forma tradicional; **construção** iterativa e incremental. |
| **Ágil antes, preditivo depois** | Descoberta/prototipação ágil para reduzir incerteza; **implantação/rollout** planejado e sequencial. |
| **Por subprojeto** | Partes estáveis (integração com legado, infraestrutura) em cascata; partes voláteis (front-end, novas regras) em ágil. |

### Características principais

- **Escolha deliberada**, guiada pelo contexto — grau de incerteza, cultura,
  contrato, regulação, maturidade do time.
- Mantém **artefatos de gestão tradicional** (cronograma, EAP, linhas de base,
  gestão de riscos e de mudanças) **junto** com práticas ágeis (backlog
  priorizado, iterações, retrospectivas, entregas incrementais).
- **Governança e prestação de contas por marcos**; execução por **fluxo/iteração**.
- Bom para **transição**: organização que sai do tradicional e adota ágil por
  partes.
- Requer **atenção às fronteiras**: é onde nascem os atritos (time promete
  incremento, contrato cobra escopo fechado).

### Fronteiras com os conceitos vizinhos

- Híbrido **não** é o mesmo que **iterativo** ou **incremental**: esses são
  tipos de abordagem por si — iterativo **refina** o mesmo produto, incremental
  **entrega em partes**. Híbrido é a **mistura de abordagens**.
- Híbrido **precisa** ter uma parte não ágil. Se tudo é ágil, é ágil.
- Híbrido é decisão de **desenho do processo**, não o resultado de aplicar ágil
  pela metade.

---

## 3. Lean — a filosofia por trás

### Definição

**Maximizar valor para o cliente eliminando desperdício** — desperdício é tudo
que consome recurso **sem agregar valor**. Nasceu na manufatura, no **Sistema
Toyota de Produção (TPS)**, e foi levado ao software pelos **Poppendieck**.
É uma **filosofia/mentalidade de melhoria de fluxo**, não um processo de
desenvolvimento com papéis e eventos prescritos. O alvo é o **desperdício no
fluxo de trabalho**, não a redução de custo por corte de pessoal.

### Os 5 princípios do *Lean Thinking* (Womack & Jones)

1. **Valor** — definido pelo **cliente**, não pela área que produz.
2. **Fluxo de valor** — mapear todas as etapas e **expor as que não agregam valor**.
3. **Fluxo** — fazer o trabalho **correr sem paradas**, filas e retrabalho.
4. **Puxada** (*pull*) — produzir **quando há demanda**, não por empurrão de meta.
5. **Perfeição** — **melhoria contínua** (*kaizen*), sem fim.

### Os 7 princípios no software (Poppendieck)

| Princípio | Ideia central |
|---|---|
| **Eliminar desperdício** | Tudo que não agrega valor ao cliente sai. |
| **Ampliar o aprendizado** | Desenvolvimento é **aprendizado**: ciclos curtos, feedback, experimento. |
| **Decidir o mais tarde possível** | Adiar o compromisso até ter informação — o **último momento responsável**, o que é diferente de postergar por indecisão. |
| **Entregar o mais rápido possível** | Ciclos curtos reduzem risco e revelam o que o cliente quer de fato. |
| **Empoderar a equipe** | Quem faz decide o **como**; gestão remove obstáculos. |
| **Construir qualidade desde o início** (*build integrity in*) | Qualidade **embutida**, não inspecionada no fim. |
| **Ver o todo** (*otimizar o todo*) | Otimizar o **sistema inteiro**, não uma etapa: acelerar uma etapa isolada costuma só empurrar fila para a seguinte. |

### Os 7 desperdícios do software

| Desperdício | Exemplo típico |
|---|---|
| **Trabalho parcialmente feito** | Item iniciado e não concluído; código sem integrar; requisito escrito e nunca usado. |
| **Processos extras** | Papelada, aprovação, relatório que ninguém lê. |
| **Funcionalidades extras** | Recurso "que pode ser útil um dia" — carrega custo de teste e manutenção para sempre. |
| **Troca de tarefas** (*task switching*) | Pessoa em três frentes: perde-se tempo em cada troca de contexto. |
| **Espera** | Aguardar aprovação, ambiente, resposta, outro time. |
| **Movimentação** | Informação que precisa atravessar pessoas/documentos para chegar a quem decide. |
| **Defeitos** | Bug encontrado tarde — quanto mais tempo escondido, mais caro. |

### Características principais

- Foco em **fluxo e tempo de ciclo**, não em ocupação das pessoas.
- **Sistema puxado**, **lotes pequenos**, **entrega just-in-time**.
- **Melhoria contínua** com base em dados do próprio fluxo (*kaizen*).
- **Respeito pelas pessoas** e decisão próxima de quem executa.
- Ferramentas típicas: **mapa de fluxo de valor**, **limite de WIP**, **quadro
  visual**, **5 porquês / análise de causa raiz**.
- **Não prescreve** papéis, eventos nem cadência — por isso combina com Scrum,
  Kanban ou até com um processo tradicional.

### Relação com ágil, Scrum e Kanban

São três coisas de naturezas diferentes: **Lean** é a filosofia, **Kanban** é um
método que a aplica ao trabalho de conhecimento (puxada, WIP limitado, fluxo
contínuo) e **ágil** é um conjunto de valores e práticas influenciado por ela.

- O **Scrum Guide 2020** apoia o Scrum em **empirismo + *lean thinking***
  (reduzir desperdício, focar no essencial).
- Um item começado e não terminado no fim da Sprint: pelo Scrum, **não é
  Incremento**; pelo Lean, é **trabalho parcialmente feito** — desperdício.

---

## 4. As três lado a lado

| Critério | **Waterfall** | **Ágil Híbrido** | **Lean** |
|---|---|---|---|
| **Natureza** | Modelo de ciclo de vida | **Estratégia de combinação** de abordagens | **Filosofia** de gestão do fluxo de valor |
| **Traço que a distingue** | Fases sequenciais com aprovação | Ágil **e** não ágil no mesmo projeto | Eliminar desperdício / otimizar o todo |
| **Requisitos** | Fixados no início | Fixos onde dá, emergentes onde não dá | Puxados pela demanda de valor |
| **Entrega** | Única, no fim | Marcos tradicionais + incrementos | Contínua, em **lotes pequenos** |
| **Mudança** | Exceção controlada | Negociada por fronteira | Oportunidade de melhoria |
| **Prescreve papéis/eventos?** | Fases e especialidades | Herda de cada lado | **Não** |
| **Origem** | Royce (1970), engenharia | Prática organizacional / guias de gestão | **Toyota (TPS)**; software com os Poppendieck |

---

## Fontes

- **Royce (1970)** — *Managing the Development of Large Software Systems*.
  Extração em [md/fontes-gabaritos/agil/royce-1970-waterfall-slides.md](../md/fontes-gabaritos/agil/royce-1970-waterfall-slides.md).
- **Mary Poppendieck** — *Principles of Lean Thinking* (2002).
  https://www.leanessays.com/2002/ · e *Lean Software Development: An Agile
  Toolkit* (2003), de onde vêm os 7 princípios e os 7 desperdícios.
- **Womack & Jones** — *Lean Thinking* (1996): os cinco princípios.
- **Scrum Guide 2020** (ed. PT-BR v3.0) — empirismo + *lean thinking*.
  Extração em [md/fontes-gabaritos/agil/scrum-guide-2020-ptbr.md](../md/fontes-gabaritos/agil/scrum-guide-2020-ptbr.md).
- **The Kanban Guide** — puxada, WIP e métricas de fluxo.
  https://kanbanguides.org/the-kanban-guide/
- **Martin Fowler** — *The New Methodology* (ágil × dirigido a plano).
  https://www.martinfowler.com/articles/newMethodology.html
- **Edital DATAPREV 2026**, Anexo I — Gestão e Governança de TI, item 1
  (*"tipos de abordagem: tradicional, híbrida e ágil"*).
  [docs/editais/dataprev/EMENTA-DESENVOLVIMENTO-SOFTWARE-2026.md](../docs/editais/dataprev/EMENTA-DESENVOLVIMENTO-SOFTWARE-2026.md)

> Este arquivo é **texto de estudo gerado por IA** — não é fonte primária. Para
> escrever `ponto_chave` (gabarito), use as fontes acima em
> `fontes-gabaritos/`/`md/fontes-gabaritos/`.
