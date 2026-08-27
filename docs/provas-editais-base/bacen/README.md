# BACEN 2024 — Analista, Área: Tecnologia da Informação (Cebraspe)

Último concurso do **Banco Central** com vagas de TI: **Edital nº 1 – BCB, de
15/01/2024**, provas aplicadas em **04/08/2024**, banca **Cebraspe**.
Cargo 2: Analista — Área: Tecnologia da Informação.

> **A banca não é a FGV.** O Cebraspe cobra **itens certo/errado** (com desconto
> por erro), não múltipla escolha de cinco alternativas. Use por **conteúdo**;
> para calibrar estilo de enunciado valem as provas FGV de [../fgv/](../fgv/README.md).

> **"Analista" aqui é o cargo que hoje se chama "Auditor".** A Lei nº
> 15.141/2025 (conversão da MP nº 1.286/2024) renomeou o cargo de Analista do
> Banco Central, da Carreira de Especialista do BCB, para **Auditor do Banco
> Central do Brasil**, a partir de **1º/1/2025** — mesma carreira, mesmo nível
> superior, só mudou o nome. Logo, esta prova de 2024 é a antecessora direta da
> prova de Auditor do concurso autorizado em 2026. Não confundir com **Técnico
> do BCB**, que é carreira à parte, de nível intermediário.

Estrutura: 120 itens objetivos (50 de conhecimentos básicos, comuns às duas
áreas + 70 de específicos) e duas discursivas — P3 (dissertação, tema de
atualidades) e P4 (questão-problema da área; em 2024 caiu **DevOps**).

## Arquivos

| Peça | Arquivo |
|---|---|
| Edital de abertura (nº 1, 15/01/2024 — inclui o conteúdo programático) | [edital](edital-cebraspe-2024-bacen-analista.pdf) |
| Retificação (Edital nº 2, 23/01/2024 — renumerou os cargos) | [retificação](edital-cebraspe-2024-bacen-analista-ret-2.pdf) |
| Objetiva P1 — Conhecimentos Básicos (itens 1–50) | [caderno](cebraspe-2024-bacen-analista-conhecimentos-basicos.pdf) · [gabarito](gabarito-cebraspe-2024-bacen-conhecimentos-basicos.pdf) |
| Objetiva P2 — Conhecimentos Específicos, TI (itens 51–120) | [caderno](cebraspe-2024-bacen-analista-ti-conhecimentos-especificos.pdf) · [gabarito](gabarito-cebraspe-2024-bacen-analista-ti.pdf) |
| Discursivas P3 e P4 | [caderno](cebraspe-2024-bacen-analista-ti-discursiva.pdf) · [padrão de resposta](padrao-resposta-cebraspe-2024-bacen-analista-ti-discursiva.pdf) |

Os dois gabaritos são os **oficiais definitivos** (pós-recursos). Nos
específicos foram anulados 5 itens: 53, 55, 56, 61 e 101.

## As discursivas (P3 e P4)

Eliminatórias e classificatórias, 4 horas, aplicadas **na tarde do mesmo dia**
da objetiva. Manuscritas a caneta preta, sem qualquer marca que identifique o
candidato (item 9 do edital).

| Prova | O que é | Linhas | Pontos | Tema em 2024 |
|---|---|---|---|---|
| P3 | Dissertação sobre **atualidades** | até 40 | 30,00 | desperdício de alimentos |
| P4 | Questão dissertativa sobre **situação-problema** da área | até 80 | 50,00 | DevOps |

- Nota final NFPD = ND + NSP; **abaixo de 40,00 de 80,00 o candidato é
  eliminado**.
- **Só são corrigidas as discursivas dos mais bem classificados na objetiva**:
  em TI, 161 da ampla concorrência, 17 PcD e 162 negros. Quem ficar fora não
  tem classificação alguma.
- O conteúdo é avaliado por **pelo menos dois examinadores**, e a nota é a média
  de duas notas convergentes (que difiram em até 25% da nota máxima).
- A forma desconta da nota de conteúdo por erro gramatical, proporcionalmente
  ao tamanho do texto: `ND = NC − 6 × NE ÷ TL` (P3) e `NSP = NC − 5 × NE ÷ TL`
  (P4), em que NE é o número de erros e TL o de linhas escritas. Fuga ao tema
  ou texto ausente zera.
- "Atualidades" só existe no conteúdo programático **para a discursiva**.

## Peso das disciplinas (70 itens específicos)

| Disciplina | Itens | Faixa |
|---|---|---|
| Engenharia de Software | 24 | 72–95 |
| Infraestrutura em TI | 17 | 96–112 |
| Ciência de Dados | 14 | 51–64 |
| Segurança da Informação | 7 | 65–71 |
| Bancos de Dados | 4 | 113–116 |
| Gestão em TI | 4 | 117–120 |

### O rótulo engana: é mais infra que desenvolvimento

"Engenharia de Software" é o maior bloco (24 itens), mas **9 dos seus 24 itens
são infraestrutura**: WebSocket, balanceamento de carga, HTTP/2, gRPC (72–75) e
Kubernetes/serverless/BaaS/FaaS (82–86). Reclassificando os 70 itens pelo que
cada um realmente cobra:

| Recorte real | Itens | Quais |
|---|---|---|
| Infra, nuvem, redes, SO, observabilidade | **26** | 72–75, 82–86, 96–112 |
| Ciência de dados / ML | 14 | 51–64 |
| **Desenvolvimento propriamente dito** | **10** | 80, 81 (testes), 87–90 (assíncrono, UX/UI, REST, GraphQL), 91, 92 (GoF), 94, 95 (código Java e Python) |
| Segurança da informação | 9 | 65–71, 78, 79 |
| Banco de dados | 4 | 113–116 |
| Gestão (Scrum, Kanban, ITIL, governança) | 4 | 117–120 |
| DevOps/DevSecOps | 2 | 76, 77 |
| DLT/blockchain | 1 | 93 |

Ou seja: **infra vale 2,6× o que vale desenvolvimento**. Só 4 itens dos 70 (94,
95, mais 87 e 92) exigem ler código de verdade — dois trechos triviais de
Python (`len()`, três `print()`) e uma recursão em Java. A discursiva P4 também
puxou para esse lado: caiu **DevOps**.

Consequência para o estudo: a prova serve bem para **Ciência de Dados,
Segurança e a fronteira arquitetura/infra** (Kubernetes, serverless, HTTP/2,
observabilidade), e mal para desenvolvimento puro — aí continuam valendo as
provas FGV de [../fgv/](../fgv/README.md), que é o recorte do cargo-alvo.

## Notas de corte e taxa de acerto (Cargo 2 — TI)

Regra de pontuação: **acerto +1,00, erro −0,50, em branco 0,00**. P1 tem 50
itens, P2 tem 70; NFPO = P1 + P2, máximo 120,00. Elimina quem fizer menos de
10,00 em P1, menos de 21,00 em P2 ou menos de 36,00 no conjunto.
Vagas: 50 imediatas (37 AC + 3 PcD + 10 PP), teto de 150 aprovados.

Números extraídos do **Edital nº 10 – BCB, de 2/9/2024** (resultado final na
objetiva), que traz nota e nº de acertos dos 366 candidatos de TI que tiveram a
discursiva corrigida:

| | P1 (de 50) | P2 (de 70) | NFPO (de 120) |
|---|---|---|---|
| Mediana dos 366 corrigidos | 37 acertos (74%) | 55 acertos (79%) | 81,50 |
| Melhor da lista | 46 acertos (92%) | 66 acertos (94%) | 106,00 |
| Mediana dos 50 primeiros | 42 acertos (84%) | 58 acertos (83%) | 90,75 |
| Pior dos 50 primeiros | 37 acertos (74%) | 49 acertos (70%) | 84,00 |

Corte para sequer ter a discursiva corrigida (161º da ampla): **NFPO ≈ 82,50**,
ou seja, ~68% dos 120 itens.

Duas leituras que essas notas escondem:

- **Ninguém em branco.** A mediana de itens não marcados entre os 50 primeiros é
  **zero**. Faz sentido: com erro valendo −0,50 e acerto +1,00, o valor esperado
  de um chute aleatório é **+0,25** — deixar em branco é estratégia dominada.
  Os 50 primeiros erraram, em mediana, 11 dos 70 itens de P2.
- **84% no Cespe não é 84% na FGV.** Em item certo/errado o piso do acaso é 50%,
  não 20% como em múltipla escolha de cinco alternativas. Descontando o chute
  (`(p − 0,5) ÷ 0,5`), 84% de acerto equivale a dominar cerca de **68%** do
  conteúdo. Não dá para comparar percentual bruto entre as duas bancas.

## Ressalvas

- O **Edital nº 1** chama TI de "Cargo 1 – Área 1"; o **Edital nº 2** inverteu a
  numeração, e é por isso que os cadernos e gabaritos dizem **Cargo 2**. O
  Edital nº 3 (31/01/2024) mexeu só em regras de inscrição — o **conteúdo
  programático nunca foi retificado**.
- Cadernos e gabaritos vieram de `cdn.cebraspe.org.br/concursos/bcb_24/arquivos/`;
  só o caderno das discursivas e seu padrão de resposta vieram do acervo do
  QConcursos, por não estarem mais no CDN da banca.
- O concurso do BCB autorizado em **03/07/2026** (170 vagas: Auditor, Técnico e
  Procurador) **ainda não tem edital** — o prazo para publicá-lo vai até
  03/01/2027, e a banca não foi definida.
