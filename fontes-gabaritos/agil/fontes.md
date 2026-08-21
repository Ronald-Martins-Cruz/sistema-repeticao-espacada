# Fontes — Seção 2.13 (Metodologias Ágeis e Gerenciamento de Projetos)

Fontes usadas para escrever os pontos-chave de Q145–Q156 e de Q257/Q260/Q261/Q262
(Waterfall, Ágil Híbrido e Lean). PDFs e páginas arquivadas nesta pasta; o resto
listado por URL (calibrar sempre pela data da prova).

## Arquivados aqui (PDF)
- `scrum-guide-2020-ptbr.pdf` — **Scrum Guide 2020, ed. PT-BR v3.0** (Schwaber & Sutherland, nov/2020).
  Fonte de papéis, eventos, artefatos, timeboxes e postura do Scrum Master.
  Origem: https://scrumguides.org/docs/scrumguide/v2020/2020-Scrum-Guide-PortugueseBR-3.0.pdf
- `kanban-guide-2020-12.pdf` — **The Kanban Guide (dez/2020)**. Fluxo contínuo, limites de WIP, ausência de timeboxes/papéis prescritos.
  Origem: https://kanbanguides.org/the-kanban-guide/2020.12/pdf/kanban-guide.v2020.12.en.pdf
- `royce-1970-original.pdf` — **Royce (1970), "Managing the Development of Large Software Systems"**,
  o artigo original (reimpressão de *Proc. IEEE WESCON*, ago/1970, p. 328–338; © 1970 IEEE, publicado originalmente pela TRW).
  **Fonte primária de Q257**: as sete fases, "Step 1: Program Design Comes First", "Step 2: Document the Design"
  (a comparação 30 páginas de spec de hardware × 1500 de software), "Step 3: Do It Twice",
  "Step 4: Plan, Control and Monitor Testing", "Step 5: Involve the Customer", e as Figuras 3 e 4 —
  onde Royce diz que a iteração *deveria* ficar entre passos sucessivos mas **nunca fica**.
  Origem: https://raw.githubusercontent.com/tpn/pdfs/master/Managing%20the%20Development%20of%20Large%20Software%20Systems%20-%201970%20(waterfall).pdf
- `royce-1970-waterfall-slides.pdf` — Slides sobre o mesmo artigo (espelho HUJI). Apoio didático; prefira o original acima.
  Origem: https://www.cs.huji.ac.il/w~feit/sem/se09/Waterfall.pdf
- `poppendieck-2002-principles-lean-thinking.pdf` — **Mary Poppendieck, "Principles of Lean Thinking" (2002)**.
  Origem do Lean no **Sistema Toyota de Produção**, a definição de *lean thinking* pela cadeia de valor
  ("How can things be structured so that the enterprise does nothing but add value, and does that as rapidly as possible?"),
  e a passagem produção artesanal → em massa → enxuta via *The Machine That Changed the World* (1990).
  Apoio de **Q261**.
  Origem: https://sel.unsl.edu.ar/ApuntesMaes/Anteriores/MetodologiasAgiles/LeanThinking.pdf (espelho de https://www.leanessays.com/2002/)

## Arquivados aqui (HTML) — Lean Enterprise Institute

O **LEI** foi fundado por James P. Womack, coautor de *Lean Thinking* (1996); o Lexicon
é a redação canônica dos cinco princípios, com a citação de página do próprio livro.
São páginas salvas — o texto está no HTML, sem extração em `md/`.

- `lei-lexicon-lean-thinking-and-practice.html` — **os cinco princípios, verbatim**, com a nota
  *"(Adapted from Womack and Jones 1996, p. 10.)"*, mais a releitura de 2007 em **Purpose, Process, People**.
  Fonte primária de **Q262**. Origem: https://www.lean.org/lexicon-terms/lean-thinking-and-practice/
- `lei-lexicon-value.html` — `value`, `value-creating` e `nonvalue-creating` ("adds cost but no value ... as seen through the eyes of the customer").
  Origem: https://www.lean.org/lexicon-terms/value/
- `lei-lexicon-value-stream.html` — fluxo de valor: **todas** as ações, agreguem valor ou não, de conceito a lançamento e de pedido a entrega.
  Origem: https://www.lean.org/lexicon-terms/value-stream/
- `lei-lexicon-muda-mura-muri.html` — os **três Ms**. `muda` = "any activity that consumes resources without creating value for the customer",
  com os tipos 1 (não removível de imediato) e 2 (removível por kaizen); `mura` = irregularidade; `muri` = sobrecarga.
  Fonte primária do conceito de desperdício em **Q261**. Origem: https://www.lean.org/lexicon-terms/muda-mura-muri/
- `lei-lexicon-toyota-production-system.html` — **TPS**: "best quality, lowest cost, and shortest lead time through the elimination of waste",
  os dois pilares **just-in-time** e **jidoka**, Taiichi Ohno, e a cunhagem de *lean production* pelo MIT em *The Machine That Changed the World* (1990).
  Fonte primária da origem em **Q261**. Origem: https://www.lean.org/lexicon-terms/toyota-production-system/
- `lei-lexicon-pull-production.html` — produção puxada. Origem: https://www.lean.org/lexicon-terms/pull-production/
- `lei-what-is-lean.html` — "What is Lean?": criar valor **com menos recursos e menos desperdício**, começando sempre pelo cliente.
  Origem: https://www.lean.org/explore-lean/what-is-lean/

## Local, fora do git (licença restrita)

- `agile-practice-guide-pmi.pdf` — **Agile Practice Guide** (PMI + Agile Alliance, 2017).
  **Fonte primária de Q260** (§3.1.6 a §3.1.11: *Characteristics of Hybrid Life Cycles*,
  *Combined Agile and Predictive Approaches*, *Hybrid Life Cycles as Fit-For-Purpose*,
  *Hybrid Life Cycles as Transition Strategy*) e apoio de Q257 (§3.1.1, *Characteristics of Predictive Life Cycles*).
  O arquivo traz a marca **"For Agile Alliance Members Only. Not for distribution, sale, or reproduction."**
  e este repositório é público — por isso ele está no `.gitignore` e **não é versionado**.
  Baixar de novo quando preciso: https://www.agilealliance.org/wp-content/uploads/2021/02/AgilePracticeGuide.pdf

## Páginas web (não arquivadas)
- **Manifesto Ágil — valores (PT-BR):** https://agilemanifesto.org/iso/ptbr/manifesto.html
- **Manifesto Ágil — 12 princípios (PT-BR):** https://agilemanifesto.org/iso/ptbr/principles.html
- **XP — Ron Jeffries:** https://ronjeffries.com/xprog/what-is-extreme-programming/
- **XP — Agile Alliance (glossário):** https://agilealliance.org/glossary/xp/
- **Lean — Mary Poppendieck, "Principles of Lean Thinking" (2002):** https://www.leanessays.com/2002/
  (backup PDF: https://sel.unsl.edu.ar/ApuntesMaes/Anteriores/MetodologiasAgiles/LeanThinking.pdf)
- **Ágil x dirigido a plano / híbrido — Martin Fowler, "The New Methodology":** https://www.martinfowler.com/articles/newMethodology.html
