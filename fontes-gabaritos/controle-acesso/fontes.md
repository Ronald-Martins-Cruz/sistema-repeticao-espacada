# Fontes — Seção 2.23 (Controle de Acesso)

Fontes para escrever os pontos-chave da seção — hoje **Q228–Q234 estão todas com
zero `ponto_chave`**. Esta primeira rodada foi montada para **Q232** ("Distinga
autenticação de autorização, indicando a pergunta que cada uma responde e a ordem
em que ocorrem", D2). Todos os PDFs estão arquivados nesta pasta e todas as URLs
foram verificadas em **20/08/2026**, com o texto conferido dentro do próprio PDF
baixado — não só na página de catálogo.

A seção nasce do item **1 do Módulo II do edital de 2026** ("Controle de acesso.
Protocolo OAuth2. SSO (Single sign-on)").

> **Atenção à vigência.** A definição clássica de autenticação circula em muitos
> textos citando a **NIST SP 800-63-3**, que foi **retirada (withdrawn) em
> 01/08/2025** e substituída *na íntegra* pela **SP 800-63-4**. A 800-63-4 mudou
> a definição de `authentication` para uma redação centrada em autenticador, que
> já **não** traz o "verifying the identity ... as a prerequisite to allowing
> access". Por isso a definição clássica aqui é ancorada na **FIPS 200**, que
> continua vigente e é a origem de onde o próprio glossário do NIST a atribui.

---

## Arquivados aqui

### Fonte principal da Q232

- `nist-sp-800-162-2014-abac.pdf` — **NIST SP 800-162, "Guide to Attribute Based
  Access Control (ABAC) Definition and Considerations"**, Hu, Ferraiolo, Kuhn,
  Schnitzer, Sandlin, Miller e Scarfone, jan/2014, com atualizações até
  **02/08/2019** (`upd2`). Status **Final / vigente** (conferido em csrc.nist.gov).
  47 páginas. É a **única das três que entrega sozinha as três exigências da
  Q232** — a distinção, o que cada uma decide e a ordem:

  1. **A distinção e o que a autorização decide** — §1.4 *Notes on Terminology*
     (p. 2 do documento, p. 12 do PDF):
     > "Authentication is not the same as access control or authorization.
     > Authentication is the act of verifying that the subject has been authorized
     > to use the presented identifier by a trusted identity provider organization.
     > Access control or authorization, on the other hand, is the decision to
     > permit or deny a subject access to system objects (network, data,
     > application, service, etc.)"

     O mesmo parágrafo fecha com uma equivalência que vale registrar, porque
     desfaz uma confusão frequente:
     > "The terms access control and authorization are used synonymously
     > throughout this document."

  2. **A ordem — o ponto mais difícil de ancorar** — §3.2.2.2 *Identity Management
     Integration* (p. 27 do documento, p. 37 do PDF):
     > "A request for access to an object must be authenticated as originating
     > from a unique subject. Authentication is achieved through use of identity
     > credentials, and **must occur before an access decision can be made**."

     É a frase que sustenta o "ordem em que ocorrem" do enunciado: autenticação
     **antes**, decisão de acesso **depois**. Sem ela, a ordem ficaria apoiada
     apenas no "often as a prerequisite" da FIPS 200, que é mais frouxo.

  **Ressalva de uso:** a definição de *authentication* da 800-162 é atípica —
  fala em "verificar que o sujeito foi autorizado a usar o identificador
  apresentado por um provedor de identidade confiável", e não no clássico
  "verificar a identidade". Ela serve muito bem para a **distinção** e para a
  **ordem**, mas **não** é a melhor redação para a metade "quem é você" da
  pergunta — para isso, use a FIPS 200 abaixo.

### Complemento — a definição clássica de autenticação

- `fips-200-2006-minimum-security-requirements.pdf` — **FIPS PUB 200, "Minimum
  Security Requirements for Federal Information and Information Systems"**, NIST,
  **março/2006**. 17 páginas, sem aviso de retirada. **Apêndice A — Terms and
  Definitions** (p. 12 do PDF):
  > "AUTHENTICATION: Verifying the identity of a user, process, or device, often
  > as a prerequisite to allowing access to resources in an information system."

  É a **fonte canônica da metade "quem é você"** e ainda repete a ordem em
  ("often as a prerequisite to allowing access"). O glossário do CSRC/NIST
  atribui essa exata redação à FIPS 200 (e a replica em SP 800-30 Rev. 1,
  SP 800-39, SP 800-128, SP 800-137, entre outras) — ou seja, é a definição mais
  reusada do acervo NIST, e não uma redação isolada.

  Cuidado: a FIPS 200 **não** define `AUTHORIZATION`. O verbete vizinho é
  `AUTHORIZING OFFICIAL`, que é outra coisa (papel de aceitação de risco, sinônimo
  de *Accreditation Authority*) e **não** serve para esta pergunta.

### Complemento — a definição vigente de autorizar

- `nist-sp-800-63-4-2025-digital-identity.pdf` — **NIST SP 800-63-4, "Digital
  Identity Guidelines"**, Temoshok, Proud-Madruga, Choong, Galluzzo, Gupta,
  LaSalle, Lefkovitz e Regenscheid, **julho/2025** (aprovada pelo NIST Editorial
  Review Board em 28/04/2025). 96 páginas. **Substitui a SP 800-63-3 na íntegra.**
  Glossário (p. 76 do PDF):
  > "**authorize** — A decision to grant access, typically automated by evaluating
  > a subject's attributes."

  Redação curta e vigente, que casa com a da 800-162 ("decision to permit or
  deny"). Útil se você quiser um `ponto_chave` que cobre "autorização é uma
  **decisão**" sem depender do texto mais longo da 800-162.

  A definição de `authentication` desta mesma publicação (p. 75 do PDF) é
  **estreita demais para a Q232** — "The process by which a claimant proves
  possession and control of one or more authenticators bound to a subscriber
  account..." — fala de posse de autenticador, não de identidade. Não use.

---

## O que ainda falta para o resto da seção

A 800-162 **não** cobre com profundidade Q228–Q231 e Q233–Q234 (DAC, MAC, RBAC,
privilégio mínimo, ABAC aplicado). Ela só faz um apanhado histórico em §2.1
(p. 14 do PDF), e ali mesmo remete a outras duas fontes:

- **DoD TCSEC ("Orange Book")** — origem das definições de DAC e MAC.
- **NIST SP 800-53** — onde a 800-162 diz que DAC e MAC também estão definidos.

Para RBAC, a própria bibliografia da 800-162 aponta o artigo seminal:
**Sandhu, Coyne, Feinstein & Youman, "Role-Based Access Control Models"**,
*IEEE Computer* 29(2), p. 38–47, fev/1996 (DOI 10.1109/2.485845).

Nenhuma dessas três foi baixada ainda — são a próxima rodada desta pasta.
