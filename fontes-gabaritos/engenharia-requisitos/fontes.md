# Fontes — Seção 2.14 (Engenharia de Requisitos)

Fontes para escrever os pontos-chave de **Q157–Q165** (hoje as nove com zero
`ponto_chave`). O pedido que originou esta pasta era **Q157** (requisito
funcional × não funcional, com exemplo num sistema bancário); as fontes
escolhidas cobrem a seção inteira porque o mesmo capítulo do SWEBOK responde
elicitação, verificação × validação e posição no ciclo de vida.

PDFs arquivados nesta pasta; páginas web listadas por URL. Todas as URLs foram
verificadas em **20/08/2026**.

Todo o material aqui é **em inglês e de acesso livre e legítimo** — norma de
corpo profissional (IEEE Computer Society) e artigos revisados por pares
hospedados pelas próprias universidades dos autores. Nada de apostila, blog
ou cópia pirata de livro.

---

## Arquivados aqui (PDF)

### A fonte canônica da seção inteira

- `swebok-v4-2024.pdf` — **Guide to the Software Engineering Body of Knowledge,
  v4.0a** (IEEE Computer Society, 2024). **É a fonte mais importante desta
  pasta.** O *Knowledge Area* 1, "Software Requirements", cobre sozinho sete
  das nove perguntas: definição de requisito (§1.1), categorias (§1.2),
  funcionais (§1.4), não funcionais (§1.5), elicitação e suas técnicas (§2),
  análise (§3), especificação (§4) e validação (§5).

  Para **Q157** o texto é quase literal — e, por sorte, o SWEBOK **usa
  justamente exemplos bancários**:
  > *"Functional requirements specify observable behaviors that the software is
  > to provide — policies to be enforced and processes to be carried out.
  > Example policies in banking software might be 'an account shall always have
  > at least one customer as its owner,' and 'the balance of an account shall
  > never be negative.'"* (§1.4)

  > *"Nonfunctional requirements in some way constrain the technologies to be
  > used in the implementation: What computing platform(s)? What database
  > engine(s)? How accurate do results need to be? How quickly must results be
  > presented? How many records of a certain type need to be stored?"* (§1.5)

  Origem (download oficial e gratuito da IEEE CS):
  https://ieeecs-media.computer.org/media/education/swebok/swebok-v4.pdf
  (página do programa: https://www.computer.org/education/bodies-of-knowledge/software-engineering)

  > **Ressalva importante — leia antes de escrever o gabarito de Q157.** A v4
  > **subdivide** os não funcionais em *technology constraints* (§1.6) e
  > *quality of service constraints* (§1.7). Essa subdivisão é **inovação da
  > v4** e **não** é o que a FGV cobra. Para a taxonomia clássica, use a v3
  > abaixo. A v4 serve para redação precisa e exemplos; a v3, para o recorte
  > que a banca espera.

- `swebok-v3-2014.pdf` — **SWEBOK Guide v3.0** (IEEE Computer Society, 2014).
  A edição que a bibliografia de concurso de TI no Brasil cita há uma década,
  e a que traz a **definição clássica**, sem a subdivisão da v4:
  > *"Functional requirements describe the functions that the software is to
  > execute (…). They are sometimes known as capabilities or features. A
  > functional requirement can also be described as one for which a **finite
  > set of test steps can be written to validate its behavior**. Nonfunctional
  > requirements are the ones that **act to constrain the solution**. (…)
  > sometimes known as **constraints or quality requirements**. They can be
  > further classified according to whether they are performance,
  > maintainability, safety, reliability, security, interoperability
  > requirements…"* (KA 1, §1.3)

  Traz ainda §1.5 *Quantifiable Requirements* — a exigência de que o requisito
  seja enunciado quantitativamente e de forma verificável, que é o eixo
  argumentativo de **Q164**.
  Origem: https://ieeecs-media.computer.org/media/education/swebok/swebok-v3.pdf

### O eixo "a fronteira funcional × não funcional é escorregadia" — Q158, Q165

- `glinz-2007-on-non-functional-requirements.pdf` — **Glinz, M., "On
  Non-Functional Requirements"**, *15th IEEE International Requirements
  Engineering Conference (RE'07)*, Delhi, out/2007, p. 21–26. **A fonte
  decisiva para Q158 e Q165**, e a única que explica *por que* a classificação
  dá errado tantas vezes. Abre reconhecendo que, mesmo após 20 anos de uso,
  *"there is still no consensus in the requirements engineering community about
  what non-functional requirements are"*, mapeia as definições concorrentes,
  mostra que a mesma exigência muda de categoria conforme a **representação**
  escolhida, e propõe uma taxonomia própria (requisitos funcionais, de
  desempenho, específicos de qualidade e restrições).
  Origem (espelho de curso da Pace University; o repositório ZORA da UZH,
  origem primária, bloqueia download automatizado):
  https://csis.pace.edu/~marchese/CS775/Papers/glinz_nonfunc_req.pdf
  Registro primário: https://www.zora.uzh.ch/id/eprint/205149/

- `eckhardt-2016-distincao-funcional-qualidade.pdf` — **Eckhardt, J.;
  Vogelsang, A.; Méndez Fernández, D., "On the Distinction of Functional and
  Quality Requirements in Practice"** (TU München / TU Berlin). O contraponto
  **empírico** de Glinz: os autores analisam requisitos reais de 11
  especificações industriais e concluem que a maioria dos ditos "requisitos de
  qualidade" **descreve comportamento observável do sistema** — isto é, na
  prática a fronteira quase não existe do jeito que os livros dizem.
  Fonte para o "por que sai caro" de **Q165** e para a decomposição de **Q164**.
  Origem: https://arxiv.org/abs/1611.08830

### Panorama da disciplina — Q159, Q162, Q163

- `nuseibeh-easterbrook-2000-re-roadmap.pdf` — **Nuseibeh, B.; Easterbrook, S.,
  "Requirements Engineering: A Roadmap"**, *ICSE 2000 — The Future of Software
  Engineering*. O artigo de referência que organiza a disciplina inteira:
  elicitação, modelagem, análise, comunicação, **validação e verificação**
  (§2.5 — a distinção exata que **Q163** cobra) e gestão da evolução. É também
  a melhor fonte curta para **Q162**: situa a RE como atividade que **atravessa**
  o ciclo de vida em vez de ocupar uma fase inicial isolada, e insiste que os
  requisitos descrevem **o problema no domínio da aplicação**, não a solução.
  Origem (página do próprio Easterbrook, Univ. de Toronto):
  https://www.cs.toronto.edu/~sme/papers/2000/ICSE2000.pdf

---

## Páginas web (não arquivadas)

### Normas (pagas — citar como autoridade, ler a ementa livre)

- **ISO/IEC/IEEE 29148:2018 — "Systems and software engineering — Life cycle
  processes — Requirements engineering".** *A* norma internacional de
  engenharia de requisitos: define requisito, os atributos de um bom requisito
  (verificável, não ambíguo, rastreável, único, viável), a estrutura
  gramatical do enunciado ([condition] [subject] [action] [object] [constraint])
  e os modelos de StRS/SyRS/SRS. Substituiu a IEEE Std 830-1998. **Paga** —
  não arquivada. Escopo e ementa livres em:
  https://www.iso.org/standard/72089.html · https://standards.ieee.org/ieee/29148/6937/
- **ISO/IEC 25010:2023 — SQuaRE, modelo de qualidade de produto.** É o
  catálogo canônico das características de qualidade que viram requisitos não
  funcionais (desempenho, segurança, manutenibilidade, usabilidade…). O SWEBOK
  v4 remete a ela explicitamente em §1.7. **Paga**:
  https://www.iso.org/standard/78176.html

### Livros-texto que a FGV costuma seguir (consultar, não arquivados)

- **Sommerville, I. — *Engenharia de Software*, 10ª ed.** Cap. 4 (Engenharia
  de Requisitos): a definição de FR/NFR mais reproduzida em português, a
  classificação dos NFR em **de produto, organizacionais e externos**, e o
  processo de elicitação/especificação/validação. É a redação que mais se
  parece com o enunciado de banca.
- **Pressman, R.; Maxim, B. — *Engenharia de Software: uma abordagem
  profissional*, 8ª ed.** Cap. 8 (Compreendendo os requisitos): o inventário
  de técnicas de elicitação (entrevista, questionário, workshop/JAD,
  observação, análise de documentos, prototipação, casos de uso) que **Q159**
  pede enumerado e **Q160**/**Q161** cobram por contraste.
- **IIBA — *BABOK Guide* v3**, cap. 6 e 10: o catálogo mais completo de
  técnicas de elicitação, com a distinção entre **colaborativa**,
  **experimental** e **de pesquisa** — útil para justificar a escolha de
  técnica em **Q164**. Pago: https://www.iiba.org/business-analysis-body-of-knowledge/

---

## Mapa fonte → pergunta

| Pergunta | Assunto | Fonte principal | Fontes de apoio |
|:-:|---|---|---|
| **Q157** | **FR × NFR + exemplo bancário** | **SWEBOK v3 §1.3** (definição clássica) · **SWEBOK v4 §1.4–1.5** (exemplos bancários literais) | Sommerville cap. 4 · ISO/IEC/IEEE 29148 |
| **Q158** | "Saldo em tempo real" é FR ou NFR? | **Glinz 2007** | SWEBOK v3 §1.3 · Eckhardt 2016 |
| **Q159** | Técnicas de elicitação | **SWEBOK v4 §2.2** | Pressman cap. 8 · BABOK cap. 10 |
| **Q160** | Entrevista × prototipação | **SWEBOK v4 §2.2** | Pressman cap. 8 · Nuseibeh & Easterbrook §2.1 |
| **Q161** | Brainstorming sem usuário final é inadequado? | **SWEBOK v4 §2.1** (fontes de requisitos) | Nuseibeh & Easterbrook §2.1 · BABOK |
| **Q162** | Posição no ciclo de vida | **Nuseibeh & Easterbrook** | SWEBOK v4 §1.11 · Sommerville cap. 4 |
| **Q163** | Verificação × validação de requisitos | **Nuseibeh & Easterbrook §2.5** | SWEBOK v4 §5 · ISO/IEC/IEEE 29148 |
| **Q164** | Caso: "relatório que abra rápido" | **SWEBOK v3 §1.5** (requisitos quantificáveis) | Eckhardt 2016 · Glinz 2007 · BABOK (escolha da técnica) |
| **Q165** | Por que classificar errado sai caro | **Glinz 2007** · **Eckhardt 2016** | SWEBOK v4 §1.8 ("Why Categorize Requirements This Way?") |

---

## Fronteiras que as fontes resolvem (onde a FGV monta distrator)

Isto **não é gabarito** — é onde a fonte precisa ser lida devagar na hora de
escrever os `ponto_chave`.

1. **O critério que separa FR de NFR é "o quê" × "o quão bem", não
   "importante" × "acessório".** SWEBOK v3 é o mais econômico: funcional =
   *função que o software executa*; não funcional = *o que restringe a
   solução*. O distrator clássico trata NFR como requisito secundário ou
   "desejável" — nada nas fontes autoriza isso.

2. **O teste operacional da v3 é mais útil que a definição.** *"A functional
   requirement can also be described as one for which a finite set of test
   steps can be written to validate its behavior."* Isso dá um critério
   aplicável em **Q158** e **Q164**, no lugar de uma intuição.

3. **Não escreva o ponto-chave de Q157 com a taxonomia da SWEBOK v4.** A
   subdivisão *technology constraints* × *quality of service constraints* é
   correta e recente, mas **não é o recorte da banca** — e um `ponto_chave`
   que a exija reprovaria uma resposta certa pelo padrão Sommerville/Pressman.
   Use a v4 pela redação e pelos exemplos; a v3 pela taxonomia.

4. **"Tempo real" (Q158) é a armadilha calibrada.** A resposta comum é
   "não funcional, porque fala de desempenho". Glinz mostra que depende de
   como a exigência é **representada**: se o enunciado descreve *comportamento
   observável* ("a tela deve refletir o saldo após cada transação"), há um
   requisito funcional embutido; a *latência tolerada* é que é não funcional.
   Eckhardt confirma empiricamente que essa mistura é a regra, não a exceção.
   Fronteira D2 — o `ponto_chave` deve exigir o **critério**, não o rótulo.

5. **Requisito não funcional sem número não é requisito.** SWEBOK v3 §1.5 é
   explícito contra "o software deve ser confiável" e "deve ser amigável".
   É o miolo de **Q164**: tornar cada item verificável é parte da resposta,
   não um adorno.

6. **Elicitação ≠ apenas ouvir o usuário.** SWEBOK v4 §2.1 lista como fontes
   de requisitos, além dos usuários: objetivos de negócio, domínio de
   aplicação, regulação, sistemas legados e **os próprios especialistas**.
   É o que desarma **Q161** — brainstorming interno é técnica legítima; o
   defeito seria pará-la aí.

7. **Verificação × validação: as duas perguntas.** Verificação = *"estamos
   construindo o produto **certo do jeito certo**?"* (o requisito está bem
   escrito, consistente, completo, rastreável). Validação = *"é **este** o
   produto certo?"* (o requisito corresponde à necessidade real do
   interessado). Nuseibeh & Easterbrook §2.5 traça essa linha; o distrator
   habitual é inverter as duas.

8. **Fronteira 2.14 × 2.13 × 2.15.** Engenharia de requisitos é *esta* seção;
   Scrum/Kanban e gestão de projeto são a 2.13, e esteira/entrega é a 2.15.
   Prototipação aparece nas duas primeiras com sentidos diferentes — em 2.14
   é **técnica de elicitação** (produz entendimento), não incremento entregável.
