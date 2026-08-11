# Metodologias Ágeis e Gerenciamento de Projetos — texto de estudo

> Seção 2.13. Cobre Q145–Q156. Fontes: Scrum Guide 2020 (ed. PT-BR v3.0),
> The Kanban Guide (mai/2025), Manifesto Ágil (2001), Poppendieck — *Principles
> of Lean Thinking* (2002), Royce (1970) e Fowler — *The New Methodology*.
> A prova é **objetiva** (FGV/DATAPREV); este texto foca no que a banca
> transforma em alternativa — sobretudo nas **fronteiras entre conceitos
> vizinhos**, que é onde ela monta os distratores.

---

## 1. Manifesto Ágil — os quatro valores `Q145`

ii>pf
sf>da
cc>nc
rm>sp

Estamos descobrindo maneiras melhores de desenvolver software. Através desse
trabalho, passamos a valorizar:

| Valorizamos… | …mais que… | Para memorizar |
|---|---|---|
| **Indivíduos e interações** | processos e ferramentas | ii>pf |
| **Software em funcionamento** | documentação abrangente | sf>da |
| **Colaboração com o cliente** | negociação de contratos | cc>nc |
| **Responder a mudanças** | seguir um plano | rm>sp |

**A pegadinha central (é o coração de Q145):** a frase *"mais que"* **não
abole o lado direito**. O próprio Manifesto encerra dizendo: *"ou seja, mesmo
havendo valor nos itens à direita, valorizamos mais os itens à esquerda."*

Os **12 princípios** por trás dos valores giram em torno de: satisfazer o
cliente com **entregas contínuas e frequentes** de software funcionando,
**aceitar mudanças** mesmo tardias, **colaboração diária** entre negócio e
desenvolvimento, **indivíduos motivados** e confiança, **conversa face a face**,
software funcionando como **medida primária de progresso**, **ritmo sustentável**,
excelência técnica, **simplicidade**, times **auto-organizados** e **reflexão
periódica** para se ajustar. (Fonte completa: agilemanifesto.org/iso/ptbr.)

---

## 2. Scrum — a espinha dorsal da seção

Scrum é um **framework leve** para gerar valor em problemas **complexos e
adaptativos**, baseado em **empirismo** (conhecimento vem da experiência) e
**pensamento enxuto** (reduzir desperdício). Funciona por **inspeção e
adaptação** em ciclos curtos.

**Três pilares empíricos:** Transparência · Inspeção · Adaptação.
**Cinco valores:** Compromisso · Foco · Abertura · Respeito · Coragem.

### 2.1 Papéis / responsabilidades (accountabilities) `Q147`

Um único **Scrum Team**, sem sub-times nem hierarquia; multifuncional,
autogerenciado, normalmente **10 pessoas ou menos**. Três responsabilidades:

| Responsabilidade | Responsabilidade central |
|---|---|
| **Product Owner (PO)** | **Maximizar o valor** do produto; gerencia e ordena o Product Backlog. É **uma pessoa**, não um comitê. |
| **Scrum Master (SM)** | Estabelecer o Scrum e a **eficácia** do time. **Líder servidor** — provoca a remoção de impedimentos; **não é chefe**. |
| **Developers** | Comprometidos em criar um **Incremento utilizável a cada Sprint**. Criam o Sprint Backlog, aderem à Definição de Pronto, **autogerenciam-se**. |

**Product Owner — o quê e por quê (valor)**

- Desenvolve e comunica a **Meta do Produto**.
- **Cria e ordena** os itens do Product Backlog, deixando-o **transparente e
  compreendido** por todos.
- Pode **delegar** a execução, mas continua sendo o **responsável**.
- Suas decisões precisam ser **respeitadas pela organização**.

**Scrum Master — a eficácia do time e do Scrum**

- Ao **time**: treina em **autogerenciamento e multifuncionalidade**, provoca a
  **remoção de impedimentos**, garante que os **eventos ocorram** dentro do
  timebox.
- Ao **PO**: ajuda em técnicas de **definição da Meta do Produto** e de
  **gestão do Product Backlog**; facilita a colaboração com stakeholders.
- À **organização**: lidera e treina a **adoção do Scrum**, remove barreiras
  entre stakeholders e o time.

**Developers — o como (e a qualidade)**

- Criam o plano da Sprint: o **Sprint Backlog**.
- **Instilam qualidade** aderindo à **Definição de Pronto**.
- **Adaptam o plano diariamente** rumo à Meta da Sprint.
- Cobram-se **mutuamente** como profissionais.

> No Guia 2020 não existe mais "Time de Desenvolvimento" como sub-time
> separado: são os **Developers**, dentro do único Scrum Team.

### 2.2 Eventos `Q148`

A **Sprint** é o **contêiner** de todos os demais eventos: duração **fixa de um
mês ou menos**, e uma nova começa **logo após** o fim da anterior (sem intervalos).

| Evento | Propósito | Quem conduz | Timebox (Sprint de 1 mês) |
|---|---|---|---|
| **Sprint Planning** | Define o **porquê** (Meta da Sprint), o **quê** e o **como** (Sprint Backlog). | Todo o Scrum Team, colaborativo | até **8 h** |
| **Daily Scrum** | Inspecionar o progresso rumo à Meta e **adaptar o plano do dia**. | Os **Developers** (PO/SM só participam se trabalham no Sprint Backlog) | **15 min**, diário |
| **Sprint Review** | Inspecionar o **resultado** com os stakeholders e ajustar o Product Backlog. **Sessão de trabalho**, não mera apresentação. | Scrum Team + stakeholders | até **4 h** |
| **Sprint Retrospective** | Planejar **melhorias** de qualidade/eficácia (pessoas, processos, ferramentas, Definição de Pronto). **Encerra a Sprint**. | Só o **Scrum Team** | até **3 h** |

> **Mudança-chave do Guia 2020:** os eventos **pertencem ao Scrum Team**. O SM
> **garante** que ocorram e respeitem o timebox, mas **não os "comanda"**. Não
> existe mais a figura do SM que preside cada reunião.

### 2.3 Artefatos e seus compromissos `Q149`

Cada artefato tem **um compromisso** que lhe dá foco e mede o progresso:

| Artefato | O que é | Responsável | Compromisso |
|---|---|---|---|
| **Product Backlog** | Lista **ordenada e emergente** de tudo que o produto precisa; **única fonte de trabalho** do time. | **Product Owner** (ordena e gerencia) | **Meta do Produto** |
| **Sprint Backlog** | **Meta da Sprint** (porquê) + itens selecionados (o quê) + plano (como). Plano **feito por e para os Developers**. | **Developers** | **Meta da Sprint** |
| **Incremento** | Passo concreto rumo à Meta do Produto; soma-se aos anteriores. | Scrum Team | **Definição de Pronto** |

- **Sprint Goal / Meta da Sprint** **não é um artefato à parte**: é o
  **compromisso do Sprint Backlog**. É criada por **todo o Scrum Team** na
  Planning e é **compromisso dos Developers** ao longo da Sprint.

---

## 3. Postura do Scrum Master — líder servidor `Q150` `Q156`

Esta é a ideia que a FGV mais cobra na seção (aparece em Q68 da prova real).

Diante de um **impedimento** ou **atraso** levantado no Daily, o SM deve
**facilitar para que o próprio time encontre a solução** e **provocar a remoção
do impedimento**. Ele **não** deve:

- ❌ **Redistribuir as tarefas por conta própria** → viola o **autogerenciamento**
  (são os Developers que decidem *quem faz o quê, quando e como*).
- ❌ **Assumir a tarefa do desenvolvedor** → tira o SM do papel de remover
  impedimentos e **não resolve a causa** do problema.

> As duas opções "gerenciais" (mandar ou executar no lugar) são os
> **distratores clássicos** da banca. A resposta certa é sempre a de
> **facilitação sem comando e controle**.

**Por que a decisão de reorganizar o trabalho é do time, e não do SM `Q156`:**

1. O Scrum Team é **autogerenciado** — decide internamente; o Sprint Backlog é
   um plano **por e para os Developers**.
2. O SM é **líder servidor, não gerente** — treina o time no autogerenciamento
   e remove impedimentos; não decide no lugar dele.
3. **O que se perde** quando o SM decide sozinho:
   - Quem conhece o trabalho técnico são os **Developers** → a decisão do SM
     tende a ser **pior** e **reduz transparência** e adaptação empírica.
   - Perde-se **responsabilidade mútua e comprometimento**: time que não decide
     não se responsabiliza pela Meta → volta ao **comando e controle** que o
     Scrum justamente substitui por **empoderamento**.

---

## 4. Sprint Planning — quem decide o quê `Q151`

**O PO decide sozinho o que entra na Sprint? Não.** A decisão é dividida:

| Quem | Decide |
|---|---|
| **Product Owner** | Propõe o **valor/porquê** e a **ordem (prioridade)** do Product Backlog. |
| **Developers** | Definem **o quanto cabe** (capacidade) e **o como** realizar. Selecionam os itens que entram, em discussão com o PO. |
| **Todo o Scrum Team** | Define a **Meta da Sprint**. |

> O **"como"** transformar itens do backlog em Incremento é **critério
> exclusivo dos Developers** — ninguém lhes diz como fazer. (Na prova Q69, a
> alternativa "o PO decide sozinho" é distrator.)

---

## 5. Capacidade do time e WIP `Q152`

- **WIP (*Work in Progress*, trabalho em andamento)** = **quantidade de itens
  de trabalho que já cruzaram o ponto definido como início, mas ainda não
  cruzaram o ponto definido como término** do fluxo. Portanto, item **bloqueado
  ou em espera continua no WIP**: ter sido iniciado, e não estar sendo
  trabalhado neste instante, não o torna concluído.
- **WIP não é limite de WIP:** WIP é a **contagem real** dos itens iniciados e
  não terminados; o **limite/controle de WIP** é a política que restringe essa
  quantidade. No Kanban, só se puxa novo item quando há sinal de capacidade,
  favorecendo foco, colaboração e fluxo.
- **Capacidade** = quanto de trabalho os Developers conseguem **concluir (com
  Definição de Pronto)** numa Sprint, previsto a partir do **desempenho
  anterior**. É base para uma **previsão realista**, não uma **meta a estourar**.
- **Sobrecarregar o Sprint quebra a previsibilidade e ameaça a Meta:** um
  Sprint Backlog inflado já **nasce como previsão falsa** e o compromisso perde
  o sentido.
- **O erro de raciocínio "sobra para o próximo Sprint":** itens **começados e
  não concluídos não viram Incremento** (não atendem à Definição de Pronto).
  São **trabalho parcialmente feito** — **desperdício, não valor** (conexão com
  o Lean).
- **WIP alto** aumenta **troca de contexto** e derruba o foco; mais itens em
  paralelo **não aceleram** a entrega e contrariam o **ritmo sustentável** e a
  qualidade, que não deve diminuir na Sprint.

---

## 6. Scrum × Kanban `Q146`

O distrator mais comum: dizer que **Kanban tem sprints** ou que **Scrum não tem
timebox**. Ambos são errados.

| Critério | **Scrum** | **Kanban** |
|---|---|---|
| **Ciclos de tempo** | Iterações de **duração fixa** (Sprints ≤ 1 mês, timeboxed). | **Fluxo contínuo**, sem timeboxes/iterações prescritas. |
| **Limite de WIP** | **Indireto** — pela capacidade refletida no Sprint Backlog. | **Explícito** — limita o trabalho em andamento **por estágio** do fluxo (*pull*). |
| **Momento da entrega** | Um **Incremento a cada Sprint** (cadência; mostrado na Review). | **Item a item**, continuamente, conforme cada um fica pronto. |
| **Papéis e eventos** | **Prescreve** papéis e eventos. | **Não prescreve** papéis nem eventos fixos. |

---

## 7. XP, Lean, Waterfall e Ágil Híbrida `Q153`

Caracterize cada uma pelo **traço que a distingue das demais**:

| Abordagem | Traço distintivo | O que é |
|---|---|---|
| **XP (Extreme Programming)** | **Excelência técnica no código** | Método **ágil** de **práticas de engenharia**: programação em par, **TDD**/testes automatizados, integração contínua, refatoração, pequenas entregas. |
| **Lean** | **Otimizar o fluxo de valor** (não um processo de código) | Origem no **Sistema Toyota de Produção**. Princípio central: **eliminar desperdício** — tudo que não agrega valor ao cliente. |
| **Waterfall (Cascata)** | **Grande planejamento antecipado**, fases sucessivas | Modelo **linear e sequencial**: requisitos → design → codificação → testes → operação. **Dirigido a plano, não ágil.** |
| **Ágil Híbrida** | **Mistura os dois mundos** | Combina práticas **ágeis** (entregas iterativas) com métodos **tradicionais/dirigidos a plano** (fases, documentação). Nem puro ágil, nem pura cascata. |

> **Pegadinha do Royce (distrator D0/D5):** Royce (1970) **não defendeu a
> cascata pura**. Ele a descreveu e **alertou que "o desenvolvimento é
> iterativo"** e que os passos não são meramente sucessivos. Atribuir a ele a
> cascata rígida **como ideal** é o erro comum.

---

## 8. Casos aplicados

### 8.1 Qual metodologia para complexidade + requisitos mutáveis + entregas incrementais? `Q154` (prova Q53)

**Resposta: Scrum.** É o framework ágil de **entregas incrementais em Sprints**
com **inspeção e adaptação a cada ciclo** — feito justamente para problemas
**complexos com requisitos que mudam**. O enunciado descreve **Sprint**
(ciclos incrementais fixos), **Sprint Review** (revisão periódica com feedback
dos stakeholders) e **Product Backlog ordenado pelo PO** (valor priorizado).

Por que as outras ágeis **não** são a melhor resposta a *este* enunciado:

- **Kanban** → fluxo contínuo, **sem ciclos/timeboxes** nem papéis/eventos
  prescritos; não entrega a **cadência de ciclos incrementais com revisão
  periódica** que o enunciado pede.
- **XP** → foca **práticas de engenharia** (par, TDD, CI); **complementa** o
  Scrum, mas não é o **framework de gestão** das entregas e da priorização.
- **Lean** → filosofia de **eliminar desperdício**/otimizar fluxo; responde
  *"como enxugar"*, não *"como organizar as entregas iterativas com papéis e
  eventos"*.
- **Waterfall** → nem é ágil; linear e dirigido a plano, o oposto do enunciado.

> Lição de prova: quando várias alternativas são "ágeis", escolha a que **casa
> termo a termo com o enunciado**. "Ciclos incrementais + revisão periódica +
> priorização de valor" = vocabulário do **Scrum**.

### 8.2 Desenvolvedor avisa no Daily que não terminará a tarefa `Q155` (prova Q68)

**Sequência correta:** o time **inspeciona na Daily** e **se auto-organiza** —
replaneja o Sprint Backlog e **renegocia o escopo com o PO mantendo a Meta da
Sprint**. O SM **facilita e remove impedimentos**, sem assumir nem mandar. O
foco é **preservar a Meta da Sprint**, não salvar a tarefa individual.

O que aconteceria em cada alternativa **errada**:

| Alternativa errada | Por que está errada |
|---|---|
| **SM assume a tarefa** | Viola líder servidor e autogerenciamento; a **causa do atraso permanece** e a Meta fica refém de **heroísmo pontual**. |
| **Escalar ao PO para redistribuir** | O PO cuida de **valor e ordem**, não redistribui trabalho interno; o **"como" é dos Developers** → decisão jogada no papel errado. |
| **Encerrar o Sprint mais cedo** | Só o **PO** pode **cancelar** a Sprint, e **apenas se a Meta se tornar obsoleta**. Um item atrasado **não** torna a Meta obsoleta; encerrar **joga fora o Incremento** ainda possível. |

---

## 9. Armadilhas recorrentes da FGV (revisão relâmpago)

- ⚠️ **"Mais que" ≠ "em vez de".** O lado direito do Manifesto tem valor.
- ⚠️ **Não inverter os pares** do Manifesto (maior valor sempre à esquerda).
- ⚠️ **Kanban não tem sprints; Scrum sempre tem timebox.**
- ⚠️ **SM não manda nem executa** — facilita e remove impedimentos.
- ⚠️ **PO não decide sozinho** o que entra na Sprint; **Developers** definem o
  *quanto* e o *como*.
- ⚠️ **Item não concluído não é Incremento** — é desperdício, não "adiantamento".
- ⚠️ **Só o PO cancela a Sprint**, e apenas se a **Meta ficou obsoleta**.
- ⚠️ **Meta da Sprint** é compromisso do **Sprint Backlog**, não artefato à parte.
- ⚠️ **Royce não pregou a cascata pura** — ele já apontava a iteração.

---

## Fontes

- **Scrum Guide 2020** (ed. PT-BR v3.0) — Schwaber & Sutherland.
  https://scrumguides.org/docs/scrumguide/v2020/2020-Scrum-Guide-PortugueseBR-3.0.pdf
- **The Kanban Guide** (mai/2025) — definição canônica de WIP, controle de WIP
  e métricas de fluxo. https://kanbanguides.org/the-kanban-guide/
- **Kanban Guide for Scrum Teams** — Scrum.org; aplicação de WIP no contexto
  do Scrum. https://www.scrum.org/resources/kanban-guide-scrum-teams
- **Manifesto Ágil** — valores e princípios (PT-BR).
  https://agilemanifesto.org/iso/ptbr/manifesto.html ·
  https://agilemanifesto.org/iso/ptbr/principles.html
- **XP** — Ron Jeffries (https://ronjeffries.com/xprog/what-is-extreme-programming/)
  e Agile Alliance (https://agilealliance.org/glossary/xp/).
- **Lean** — Mary Poppendieck, *Principles of Lean Thinking* (2002).
  https://www.leanessays.com/2002/
- **Waterfall** — Royce (1970), *Managing the Development of Large Software Systems*.
- **Ágil x dirigido a plano / híbrido** — Martin Fowler, *The New Methodology*.
  https://www.martinfowler.com/articles/newMethodology.html
