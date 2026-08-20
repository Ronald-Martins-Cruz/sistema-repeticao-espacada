# Fontes — Seção 2.15 (DevOps)

Fontes para escrever os pontos-chave de **Q166–Q173** (hoje as oito com zero
`ponto_chave`). O pedido que originou esta pasta era **Q173** (classificar a
maturidade de uma esteira com aprovação manual antes da subida); as fontes
escolhidas cobrem a seção inteira porque a fronteira CI → Entrega Contínua →
Implantação Contínua é a mesma em seis das oito perguntas.

PDFs e páginas HTML arquivados nesta pasta. Todas as URLs foram verificadas em
**20/08/2026**.

O critério aqui foi **fonte de quem cunhou o termo**. CI, Entrega Contínua e
Implantação Contínua não vêm de norma: vêm de Fowler, de Humble e de Farley,
e é a redação deles que a banca parafraseia. Por isso três das quatro fontes
principais são textos assinados por esses autores — não são "blogs", são as
publicações primárias dos conceitos.

---

## Arquivados aqui

### A fonte direta de Q168, Q169 e Q173

- `fowler-continuous-delivery.html` — **Fowler, M., "ContinuousDelivery"**
  (bliki, martinfowler.com). **É a fonte mais importante desta pasta** e
  resolve Q173 quase por si só. Duas passagens literais:
  > *"Continuous Delivery is a software development discipline where you build
  > software in such a way that the software **can be released to production at
  > any time**."*

  > *"Continuous Delivery is sometimes confused with Continuous Deployment.
  > **Continuous Deployment means that every change goes through the pipeline
  > and automatically gets put into production**, resulting in many production
  > deployments every day. Continuous Delivery just means that you are **able**
  > to do frequent deployments but **may choose not to do it**, usually due to
  > businesses preferring a slower rate of deployment. **In order to do
  > Continuous Deployment you must be doing Continuous Delivery.**"*

  Traz ainda os quatro indicadores de que a equipe *está* fazendo entrega
  contínua (implantável ao longo de todo o ciclo; a equipe prioriza mantê-la
  implantável; qualquer um obtém *feedback* automatizado de prontidão; e
  *push-button deployment* de qualquer versão para qualquer ambiente) — que
  são exatamente o checklist para pontuar o caso de **Q173**.
  Origem: https://martinfowler.com/bliki/ContinuousDelivery.html

- `humble-cd-vs-continuous-deployment.html` — **Humble, J., "Continuous
  Delivery vs Continuous Deployment"** (continuousdelivery.com, ago/2010).
  O coautor do livro fazendo a mesma distinção com outra ênfase — a de
  **quem decide**, que é a chave do caso de Q173 (a aprovação do gerente não
  é defeito da esteira, é a esteira funcionando como projetada):
  > *"Continuous deployment is the practice of releasing every good build to
  > users — a more accurate name might have been 'continuous release'. While
  > continuous deployment implies continuous delivery **the converse is not
  > true**. Continuous delivery is about **putting the release schedule in the
  > hands of the business, not in the hands of IT** (…) that any build could
  > potentially be released to users **at the touch of a button**."*
  Origem: https://continuousdelivery.com/2010/08/continuous-delivery-vs-continuous-deployment/

### A fonte de Q166 e Q169

- `fowler-continuous-integration.html` — **Fowler, M., "Continuous
  Integration"** (artigo, revisão de 18/01/2024). O texto canônico do conceito,
  na redação mais recente do autor:
  > *"Continuous Integration is a software development practice where **each
  > member of a team merges their changes into a codebase together with their
  > colleagues changes at least daily**. Each of these integrations is
  > **verified by an automated build (including test)** to detect integration
  > errors as quickly as possible."*
  Enumera as práticas (mainline versionada, build automatizado, build
  autotestável, push diário para a mainline, build a cada push, conserto
  imediato de build quebrado) — o material de **Q166** e do "o que a CI
  automatiza" de **Q169**. Fowler é também explícito sobre o problema que a CI
  ataca: o *merge hell* da integração tardia.
  Origem: https://martinfowler.com/articles/continuousIntegration.html

- `fowler-deployment-pipeline.html` — **Fowler, M., "DeploymentPipeline"**
  (bliki). O artefato que liga CI a entrega: estágios de *commit*, testes
  automatizados, ambientes progressivamente parecidos com produção, e a
  ideia de que **cada estágio é um portão** que a build atravessa. Útil para
  situar onde exatamente o portão manual de **Q173** se encaixa.
  Origem: https://martinfowler.com/bliki/DeploymentPipeline.html

### O livro fundador

- `humble-farley-continuous-delivery-preview.pdf` — **Humble, J.; Farley, D.,
  *Continuous Delivery: Reliable Software Releases through Build, Test, and
  Deployment Automation*** (Addison-Wesley, 2010) — **prévia oficial da
  editora**, 50 páginas: prefácio, sumário completo e o **Capítulo 1, "The
  Problem of Delivering Software"**, inteiro. É o livro que Fowler indica como
  *"the foundation book on this topic"*. Traz a Figura 1.1 com o **deployment
  pipeline** canônico (commit stage → automated acceptance testing → manual
  testing → automated capacity testing → release) e o parágrafo que explica
  seu funcionamento — a espinha de **Q170** e **Q171**.
  Origem (prévia distribuída pela editora):
  https://api.pageplace.de/preview/DT0400.9780321670274_A23552386/preview-9780321670274_A23552386.pdf

### As fontes de Q171 (estratégias de publicação)

Atenção à autoria: os três verbetes abaixo estão **no site de Fowler, mas não
são dele**. Citar "Fowler" para qualquer um deles é erro de referência — caro
em recurso.

- `fowler-blue-green-deployment.html` — **Fowler, M., "BlueGreenDeployment"**
  (bliki, 01/03/2010). Este sim é de Fowler. O mecanismo na redação de origem:
  > *"The blue-green deployment approach does this by ensuring you have **two
  > production environments, as identical as possible**. At any time one of
  > them, let's say blue for the example, is live. As you prepare a new release
  > of your software you do your final stage of testing in the green
  > environment. Once the software is working in the green environment, you
  > **switch the router** so that all incoming requests go to the green
  > environment (…)"*

  Diz também *por que* a técnica existe — é o enunciado de Q167 e Q171 quase
  palavra por palavra: *"You usually need to do this quickly in order to
  **minimize downtime**."* E o efeito colateral que costuma virar `ponto_chave`:
  o ambiente azul, ocioso, é a rota de **rollback imediato** — *"if anything
  goes wrong you switch the router back to your blue environment"* —, com a
  ressalva honesta das transações perdidas na janela de troca.
  Origem: https://martinfowler.com/bliki/BlueGreenDeployment.html

- `fowler-canary-release.html` — **Sato, D., "CanaryRelease"** (bliki,
  25/06/2014).
  > *"Canary release is a technique to **reduce the risk** of introducing a new
  > software version in production by **slowly rolling out the change to a small
  > subset of users** before rolling it out to the entire infrastructure and
  > making it available to everybody."*

  O que separa *canary* de *blue-green*, e que é a fronteira fina de Q171: aqui
  a exposição é **gradual e por usuário** (amostra aleatória, funcionários
  primeiro, ou por perfil demográfico) e as duas versões **convivem em
  produção**; no blue-green a troca é atômica, de rota, e uma versão só está
  viva por vez.
  Origem: https://martinfowler.com/bliki/CanaryRelease.html

- `fowler-feature-toggles.html` — **Hodgson, P., "Feature Toggles (aka Feature
  Flags)"** (artigo, martinfowler.com, 09/10/2017). O texto que **desacopla
  *deploy* de *release***: o código novo sobe para produção desligado, e
  publicar vira mudança de configuração, sem novo deploy — mecanismo distinto
  dos dois anteriores, que operam em roteamento. Traz a taxonomia que dá
  substância ao `ponto_chave` (*release*, *experiment*, *ops* e *permissioning
  toggles*) e os eixos estático × dinâmico e transitório × longevo. Descreve
  ainda como implementar *canary release* e teste A/B **em cima** de toggles —
  útil para não tratar as três estratégias como mutuamente exclusivas.
  Origem: https://martinfowler.com/articles/feature-toggles.html

### A fonte de Q172

- `fowler-devops-culture.html` — **Wilsenach, R., "DevOpsCulture"** (bliki,
  09/07/2015). A passagem responde Q172 quase literalmente:
  > *"DevOps has become possible largely due to a combination of new operations
  > tools and established agile engineering practices, but **these are not
  > enough** to realize the benefits of DevOps. **Even with the best tools,
  > DevOps is just another buzzword if you don't have the right culture.**"*

  E enumera o que ferramenta nenhuma instala: colaboração entre os papéis de
  desenvolvimento e operação, times autônomos e multifuncionais,
  **responsabilidade compartilhada** pelo que roda em produção, o fim do
  repasse por cima do muro (o silo que o movimento nasceu para derrubar) e
  tratar falha como aprendizado em vez de culpa.
  Origem: https://martinfowler.com/bliki/DevOpsCulture.html

### Fonte institucional (para citar em recurso)

- `nist-sp-800-204c-devsecops.pdf` — **NIST Special Publication 800-204C,
  "Implementation of DevSecOps for a Microservices-based Application with
  Service Mesh"** (NIST, 2022). Documento de **agência governamental
  americana**, revisado publicamente — o registro mais formal desta pasta.
  Descreve CI, entrega contínua e implantação contínua como *primitivas* de
  uma esteira e detalha estágios, gatilhos e mecanismos de *feedback*. Serve
  quando for preciso uma fonte que não seja assinada por um consultor
  individual — em recurso, por exemplo.
  Origem: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204C.pdf

- `dora-capability-continuous-delivery.html` — **DORA (DevOps Research and
  Assessment / Google Cloud), "Continuous delivery" capability page.** A
  linhagem de pesquisa **empírica** (Forsgren, Humble e Kim; base do livro
  *Accelerate*) que mede o efeito das práticas. Define entrega contínua pelos
  mesmos critérios e a liga às **quatro métricas DORA** — *lead time*,
  frequência de implantação, tempo de restauração e taxa de falha em mudança.
  É o que dá lastro quantitativo a "maturidade da esteira" em **Q173**.
  Origem: https://dora.dev/capabilities/continuous-delivery/

---

## Páginas web (não arquivadas)

- **ISO/IEC/IEEE 32675:2022 — "Information technology — DevOps — Building
  reliable and secure systems including application build, package and
  deployment".** A única **norma internacional** de DevOps que existe. Define
  o vocabulário (incluindo CI/CD) com peso normativo. **Paga** — não
  arquivada; escopo livre em: https://www.iso.org/standard/83670.html ·
  https://standards.ieee.org/ieee/32675/10318/
- **DORA — demais capacidades e as quatro métricas:**
  https://dora.dev/capabilities/ · https://dora.dev/guides/dora-metrics-four-keys/
- **Relatórios anuais *State of DevOps* (DORA)** — grandes demais para
  arquivar (~39 MB cada), mas são a base empírica citável:
  https://dora.dev/research/

---

## Mapa fonte → pergunta

| Pergunta | Assunto | Fonte principal | Fontes de apoio |
|:-:|---|---|---|
| **Q166** | O que é CI e que problema ataca | **Fowler, "Continuous Integration"** | Humble & Farley cap. 1 · NIST SP 800-204C |
| **Q167** | Que conceito descreve "nova versão em produção com mínima interrupção" | **Fowler, "ContinuousDelivery"** | Humble (CD × CDep) · DORA |
| **Q168** | **Entrega Contínua × Implantação Contínua** | **Fowler, "ContinuousDelivery"** ("may choose not to") | Humble (CD × CDep) |
| **Q169** | CI × Entrega Contínua: o que automatiza, que artefato produz | **Fowler, "Continuous Integration"** + **"ContinuousDelivery"** | Fowler, "DeploymentPipeline" · Humble & Farley cap. 1 |
| **Q170** | Gerência de configuração, monitoramento, controle de versão | **Humble & Farley cap. 1** | NIST SP 800-204C · Fowler, "DeploymentPipeline" |
| **Q171** | Estratégias de publicação de baixa interrupção | **Fowler, "BlueGreenDeployment"** · **Sato, "CanaryRelease"** · **Hodgson, "Feature Toggles"** | Humble & Farley cap. 1 |
| **Q172** | DevOps é ferramenta ou cultura? | **Wilsenach, "DevOpsCulture"** | DORA capabilities · NIST SP 800-204C |
| **Q173** | **Caso: esteira com aprovação manual** | **Fowler, "ContinuousDelivery"** · **Humble, CD × CDep** | Fowler, "DeploymentPipeline" · DORA · Humble & Farley cap. 1 |

---

## Fronteiras que as fontes resolvem (onde a FGV monta distrator)

Isto **não é gabarito** — é onde a fonte precisa ser lida devagar na hora de
escrever os `ponto_chave`.

1. **A fronteira Entrega × Implantação Contínua é *quem aciona*, não *o que
   está automatizado*.** Fowler é literal: entrega contínua = *"able to do
   frequent deployments but **may choose not to** do it"*. O caso de **Q173**
   descreve uma esteira **plenamente** em entrega contínua: integra e testa a
   cada commit (CI ✓), gera artefato versionado e sempre pronto para produção
   (Entrega Contínua ✓). O portão do gerente **não a desqualifica** — é a
   definição em funcionamento. Um `ponto_chave` que trate a aprovação manual
   como "falha de maturidade" contraria a fonte.

2. **O que falta para o estágio seguinte é uma coisa só: remover o portão.**
   Implantação Contínua = *toda* build boa vai para produção automaticamente.
   Ir de uma para a outra não é adicionar automação de build — é **transferir
   a decisão de liberar** para a esteira. Fronteira D4, é o miolo de Q173.

3. **A relação é de continência, não de alternativa.** Fowler: *"In order to
   do Continuous Deployment you must be doing Continuous Delivery."* E Humble:
   *"while continuous deployment implies continuous delivery **the converse is
   not true**."* CI ⊂ Entrega Contínua ⊂ Implantação Contínua. O distrator
   típico apresenta as três como escolhas paralelas, ou inverte a implicação.

4. **"CD" é sigla ambígua — não use no `ponto_chave`.** Em inglês serve tanto
   para *continuous delivery* quanto para *continuous deployment*, e é
   exatamente aí que a banca constrói o erro. Escrever por extenso, em
   português, é o que torna o ponto verificável.

5. **CI é sobre integrar, não sobre publicar.** Fowler: *"Continuous
   Integration usually refers to integrating, building, and testing code
   **within the development environment**. Continuous Delivery builds on this,
   dealing with the final stages required for production deployment."* O
   artefato da CI é uma build verificada; o da entrega contínua é um
   **release candidate implantável**. É o eixo de **Q169**, e o que impede que
   **Q167** seja respondida com "integração contínua".

6. **Integração "diária" tem número.** Fowler exige *"at least daily"* de cada
   membro da equipe. É um critério objetivo — bom material de `ponto_chave`,
   melhor que "com frequência".

7. **Q170 pede o que as três coisas *não* são.** Gerência de configuração,
   monitoramento contínuo e controle de versão são **habilitadores** da
   esteira, não a prática que publica versão em produção. Humble & Farley
   tratam cada uma como pré-requisito no cap. 1 — a fonte deixa a hierarquia
   explícita, e é o que desarma a alternativa plausível.

8. **DevOps não é sinônimo de CI/CD.** Esteira é *técnica*; DevOps inclui a
   dimensão cultural (responsabilidade compartilhada pela produção) que
   nenhuma ferramenta instala. Fonte de **Q172**, e vale como fronteira geral
   da seção: nem toda equipe com pipeline faz DevOps.

9. **As três estratégias de Q171 diferem no *mecanismo*, não no efeito.**
   Todas reduzem interrupção, e por isso a alternativa errada troca uma pela
   outra. Blue-green: **dois ambientes**, troca **atômica de rota**, uma versão
   viva por vez. Canary: **uma exposição gradual**, as duas versões **convivem**,
   o corte é por subconjunto de usuários. Feature toggle: **um só deploy**, o
   código sobe desligado e a publicação é **mudança de configuração**. Um
   `ponto_chave` que só diga "reduz downtime" não distingue nenhuma das três —
   tem que nomear o mecanismo. E não são excludentes: Hodgson descreve canary e
   teste A/B implementados **em cima** de toggles.

10. **Fronteira 2.15 × 2.13.** Esteira, publicação e cultura DevOps são *esta*
   seção; Scrum, Kanban e gestão de projeto são a 2.13. "Entrega frequente"
   aparece nas duas com sentidos distintos — no Manifesto Ágil é princípio de
   negócio; aqui é propriedade técnica verificável da esteira.
