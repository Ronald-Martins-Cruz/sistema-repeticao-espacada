# Fontes — Seção 2.5 (Orientação a Objetos)

Fontes para escrever os pontos-chave de **Q82–Q88** (hoje as sete com zero
`ponto_chave`). O pedido que originou esta pasta era **Q82** (herança,
sobrescrita e polimorfismo, e como os três se articulam numa chamada em tempo
de execução); as fontes escolhidas cobrem a seção inteira porque Q83–Q88 são
o desdobramento dessa mesma articulação até a Substituição de Liskov.

PDFs e páginas HTML arquivados nesta pasta. Todas as URLs foram verificadas em
**20/08/2026**.

> Os cinco papers de SOLID (Robert C. Martin) **já estão arquivados em
> `fontes-gabaritos/solid/`** e **não foram duplicados aqui**. O `lsp.pdf` de
> lá é o artigo de Martin sobre o princípio da substituição — parceiro do
> Liskov & Wing arquivado nesta pasta, que é a formulação **original** e
> formal do mesmo princípio.

O critério aqui foi **especificação de linguagem antes de livro-texto**.
"Como os três se articulam em tempo de execução" é pergunta que só tem
resposta exata numa especificação: é a JLS que diz, palavra por palavra, o
que a JVM procura e onde começa a procurar.

---

## Arquivados aqui

### A fonte direta de Q82 — a articulação em tempo de execução

- `jls-se25-cap8-classes.html` — **The Java® Language Specification, Java SE
  25 Edition — Capítulo 8, "Classes"** (Oracle / Gosling, Joy, Steele, Bracha,
  Buckley, Smith, Bierman). A definição normativa de **herança** (§8.4.8,
  *Inheritance, Overriding, and Hiding*) e de **sobrescrita** (§8.4.8.1,
  *Overriding (by Instance Methods)*), com as condições exatas: o método da
  subclasse sobrescreve o da superclasse quando a assinatura é *subsignature*
  da assinatura herdada e o método herdado é acessível. Traz também §8.4.8.2
  (**hiding**, o que acontece com métodos `static` — não é sobrescrita, e é
  distrator clássico), §8.4.8.3 (requisitos: tipo de retorno covariante,
  não estreitar acesso, não lançar exceções verificadas mais amplas) e
  §8.4.9 (**overloading**, que é Q84).
  Origem: https://docs.oracle.com/javase/specs/jls/se25/html/jls-8.html

- `jls-se25-cap15-expressoes.html` — **JLS SE 25 — Capítulo 15,
  "Expressions"**. **É a fonte decisiva de Q82** e a única aqui que responde
  literalmente "como os três se articulam numa chamada de método em tempo de
  execução". A §15.12 separa as duas metades da chamada — **§15.12.1–3, em
  tempo de compilação**, escolhem a *assinatura* pelo **tipo declarado** da
  referência; **§15.12.4.4, em tempo de execução**, escolhe a *implementação*:
  > *"Otherwise, the invocation mode is interface or virtual (…) **overriding
  > may occur. A dynamic method lookup** (…) is used to locate the method to
  > invoke. **The lookup procedure starts from class R, the actual run-time
  > class of the target object.** (…) If class S contains a declaration for a
  > method that overrides method m of class or interface C from R (§8.4.8.1),
  > then **that overriding method is the method to be invoked**, and the
  > procedure terminates. Otherwise, if S has a superclass, then steps 1 and 2
  > of this lookup procedure are performed recursively using the **direct
  > superclass** of S in place of S."*

  Aí está a articulação inteira em duas frases: a **herança** monta a cadeia
  de superclasses que a busca percorre; a **sobrescrita** é a condição que
  interrompe a busca; e o **polimorfismo** é o fato de que a busca parte de
  `R`, a classe real do objeto, e não do tipo escrito no código.
  Origem: https://docs.oracle.com/javase/specs/jls/se25/html/jls-15.html
  (especificação completa em PDF: https://docs.oracle.com/javase/specs/jls/se25/jls25.pdf)

### O conceito de polimorfismo, fora de qualquer linguagem

- `cardelli-wegner-1985-types-polymorphism.pdf` — **Cardelli, L.; Wegner, P.,
  "On Understanding Types, Data Abstraction, and Polymorphism"**, *ACM
  Computing Surveys* 17(4), dez/1985, p. 471–522. **O artigo que fixou a
  taxonomia de polimorfismo** usada desde então, e a fonte a citar quando o
  gabarito precisar de precisão conceitual em vez de sintaxe Java:

  - **universal** — *paramétrico* (genéricos) e **de inclusão** (subtipagem:
    é o polimorfismo da herança, o de Q82);
  - **ad hoc** — *sobrecarga* (mesmo nome, implementações não relacionadas:
    é Q84) e *coerção*.

  Sem essa distinção, "polimorfismo" e "sobrecarga" se confundem — e é
  exatamente sobre essa confusão que **Q84** é construída.
  Origem (página do próprio Cardelli): http://lucacardelli.name/Papers/OnUnderstanding.A4.pdf

### Redação acessível (para calibrar o nível D1 de Q82)

- `oracle-tutorial-polymorphism.html` — **The Java™ Tutorials — "Polymorphism"**
  (Oracle). Define despacho dinâmico em uma frase, com o exemplo canônico
  `Bicycle`/`MountainBike`: *"the Java virtual machine (JVM) calls the
  appropriate method for the object that is referred to in each variable"*.
  É o registro do mesmo fato da JLS §15.12.4.4, em linguagem de aula — útil
  para escrever um `ponto_chave` de D1 sem exigir vocabulário de especificação.
  Origem: https://docs.oracle.com/javase/tutorial/java/IandI/polymorphism.html

- `oracle-tutorial-override-hide.html` — **The Java™ Tutorials — "Overriding
  and Hiding Methods"** (Oracle). A distinção **sobrescrita (instância,
  resolvida em tempo de execução) × ocultação (`static`, resolvida em tempo de
  compilação)**, com a tabela de qual versão é chamada em cada caso. Fonte de
  apoio para **Q84** e para o distrator de `static` em Q82.
  Origem: https://docs.oracle.com/javase/tutorial/java/IandI/override.html

### O limite do que a sobrescrita pode fazer — Q83, Q85, Q86, Q87, Q88

- `liskov-wing-1994-behavioral-subtyping.pdf` — **Liskov, B.; Wing, J. M.,
  "A Behavioral Notion of Subtyping"**, *ACM TOPLAS* 16(6), nov/1994,
  p. 1811–1841. A formulação **original e formal** do princípio da
  substituição, com a condição de subtipo comportamental: pré-condição não
  pode ser fortalecida, pós-condição não pode ser enfraquecida, e o
  **invariante** do supertipo tem de ser preservado. É a única fonte da pasta
  que responde **Q88** ("corretude aferida por quem, observada de onde") — a
  resposta está na noção de que a corretude é observada **pelo programa
  cliente**, escrito contra o supertipo.
  Origem (página da própria Jeannette Wing, CMU):
  https://www.cs.cmu.edu/~wing/publications/LiskovWing94.pdf

---

## Páginas web (não arquivadas)

- **The Java™ Tutorials — "Inheritance"**: o que é herdado e o que não é
  (construtores não são herdados; membros `private` não são herdados):
  https://docs.oracle.com/javase/tutorial/java/IandI/subclasses.html
- **JLS SE 25, §8.4.8.3 — "Requirements in Overriding and Hiding"** (âncora
  direta dentro do capítulo 8 já arquivado): as três restrições que o método
  sobrescrito tem de respeitar — retorno covariante, acesso não mais restrito,
  exceções verificadas não mais amplas. É a resposta técnica de **Q86**:
  https://docs.oracle.com/javase/specs/jls/se25/html/jls-8.html#jls-8.4.8.3
- **OMG — Unified Modeling Language (UML) 2.5.1**, §9.9 (*Generalization*) e
  §9.6.3 (*redefinition*): a semântica de herança e redefinição **independente
  de linguagem**, útil se o enunciado da banca vier em termos de modelagem em
  vez de código. Especificação gratuita: https://www.omg.org/spec/UML/2.5.1/
- **Meyer, B., "Applying 'Design by Contract'"**, *IEEE Computer* 25(10),
  out/1992 — origem da noção de **contrato** (pré-condição, pós-condição,
  invariante) que **Q85** cobra, e do argumento de que o contrato **não é
  verificável pelo compilador**:
  https://se.inf.ethz.ch/~meyer/publications/computer/contract.pdf
- **Robert C. Martin, "The Liskov Substitution Principle"** — já arquivado em
  `fontes-gabaritos/solid/lsp.pdf`. É a leitura de engenharia do mesmo
  princípio de Liskov & Wing, e a que a banca costuma parafrasear.

---

## Mapa fonte → pergunta

| Pergunta | Assunto | Fonte principal | Fontes de apoio |
|:-:|---|---|---|
| **Q82** | **Herança, sobrescrita, polimorfismo + despacho em runtime** | **JLS §15.12.4.4** (dynamic method lookup) · **JLS §8.4.8** | Cardelli & Wegner (polimorfismo de inclusão) · Tutorial Oracle (redação D1) |
| **Q83** | Quando especializar vira defeito | **Liskov & Wing 1994** | `solid/lsp.pdf` · Meyer 1992 |
| **Q84** | Sobrecarga × sobrescrita | **JLS §8.4.9 × §8.4.8.1** | **Cardelli & Wegner** (ad hoc × universal) · Tutorial Oracle (override/hide) |
| **Q85** | O contrato além das assinaturas | **Meyer 1992** | Liskov & Wing 1994 · JLS §8.4.8.3 |
| **Q86** | O sobrescrito precisa ser igual? Precisa lançar exceção? | **JLS §8.4.8.3** | Liskov & Wing 1994 · `solid/lsp.pdf` |
| **Q87** | Caso `Cachorro extends Animal` | **Liskov & Wing 1994** | JLS §15.12.4.4 · `solid/lsp.pdf` |
| **Q88** | Corretude preservada: por quem, de onde | **Liskov & Wing 1994** | Meyer 1992 |

---

## Fronteiras que as fontes resolvem (onde a FGV monta distrator)

Isto **não é gabarito** — é onde a fonte precisa ser lida devagar na hora de
escrever os `ponto_chave`.

1. **A chamada tem *dois* momentos, e é isso que Q82 cobra.** O compilador
   escolhe a **assinatura** pelo **tipo declarado** da referência (JLS
   §15.12.1–3); a JVM escolhe a **implementação** pela **classe real do
   objeto** (§15.12.4.4). Um `ponto_chave` que exija apenas "chama o método da
   classe do objeto" perde metade da resposta — e é justamente a metade que
   explica Q84 (sobrecarga se resolve no primeiro momento, sobrescrita no
   segundo).

2. **A busca começa em `R` e sobe.** JLS: *"the lookup procedure starts from
   class R, the actual run-time class of the target object"*, e sobe pela
   **superclasse direta** até achar quem sobrescreve. Escrever o ponto-chave
   com esse mecanismo — começa embaixo, sobe — é mais verificável que
   "polimorfismo faz o método certo ser chamado".

3. **Herança é a condição, não o efeito.** Sem cadeia de herança não há o que
   percorrer; sem sobrescrita a busca não para antes do topo; sem
   polimorfismo (referência de supertipo apontando para subtipo) a pergunta
   nem se coloca. Os três são **elos da mesma corrente**, e é essa articulação
   — não as três definições soltas — que Q82 pede.

4. **`static` não sobrescreve: oculta.** JLS §8.4.8.2 e o tutorial Oracle são
   explícitos, e o efeito é o oposto — método de classe resolve pelo **tipo
   declarado**, em tempo de compilação. Distrator de alto rendimento porque o
   código *parece* sobrescrita.

5. **Polimorfismo ⊃ herança.** Cardelli & Wegner mostram que o polimorfismo
   de inclusão (subtipagem) é **um** dos quatro tipos. Um `ponto_chave` que
   defina polimorfismo *como* "herdar e sobrescrever" está errado por
   estreiteza — mas exigir a taxonomia inteira numa pergunta D1 também
   desequilibra. O recorte defensável para Q82: nomear que se trata de
   polimorfismo **de inclusão / subtipo**, sem cobrar os outros três.

6. **Sobrecarga não é polimorfismo de subtipo.** É *ad hoc*, na taxonomia de
   Cardelli & Wegner, resolvida em tempo de compilação pela assinatura. Eixo
   de **Q84**, e o erro mais comum de quem estudou por resumo.

7. **"Sobrescrever exige assinatura idêntica" é meia verdade.** JLS §8.4.8.3
   admite **tipo de retorno covariante**, e exige apenas que o acesso não
   seja estreitado e que as exceções verificadas não sejam ampliadas. É a
   fonte técnica de **Q86** — e o gabarito precisa distinguir o que a
   *linguagem* permite (JLS) do que o *contrato* permite (Liskov & Wing):
   são duas réguas diferentes, e a segunda é mais estrita que a primeira.

8. **Fronteira 2.5 × SOLID.** Herança, sobrescrita e polimorfismo são *esta*
   seção; os cinco princípios são a seção de SOLID. LSP fica no meio — entra
   aqui como **limite semântico da sobrescrita** (Q83, Q86–Q88), e lá como
   princípio de projeto. As duas pastas se apoiam: `solid/lsp.pdf` e
   `liskov-wing-1994-behavioral-subtyping.pdf` são o mesmo princípio em dois
   registros, engenharia e formal.
