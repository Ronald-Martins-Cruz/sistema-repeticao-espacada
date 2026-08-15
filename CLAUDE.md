# CLAUDE.md — Mapa do diretório

Este diretório é um **sistema de estudo por repetição espaçada** (SM-2), pensado para durar além de um único concurso: o schema modela banca, prova, etapa e âncora como entidades próprias, então o mesmo banco de perguntas atravessa vários concursos ao longo do tempo. O alvo **atual** é o concurso público **DATAPREV 2026** (cargo Analista de TI — Desenvolvimento de Software, banca **FGV**), e é em torno dele que a maior parte do conteúdo hoje gira — banco de perguntas, seções, editais, calendário.

O método é **perguntas discursivas** operadas direto em SQL sobre um banco SQLite (`estudo.db`): você enuncia uma pergunta, grava a resposta na íntegra, corrige contra um gabarito escrito de antemão e deixa um agendamento SM-2 reagendar sozinho. A ideia central: **quem responde não é quem corrige.** A nota é dada contra um gabarito gravado *antes* da resposta, o que impede a "ilusão de saber" do flashcard. A prova real é objetiva (múltipla escolha); o formato discursivo é método de fixação, não espelho da prova.

O repositório também acumula provas de **outras bancas e concursos** (BACEN, CEFET/RJ, TCE-RJ) em `docs/provas/`, guardadas ali só para o usuário conhecer o terreno. **Não use esse material** — para gerar perguntas, gabaritos ou qualquer conteúdo do banco de estudo — a menos que seja explicitamente pedido no prompt.

> **Antes de qualquer sessão de estudo, invoque a skill `estudo`** — é o manual operacional passo a passo (`.claude/skills/estudo/`). Este CLAUDE.md só dá o mapa e as regras que nunca podem ser quebradas.

## Arquivos

Na raiz ficam duas coisas: o **sistema de estudo** em si (banco, seções) e o **pipeline de leitura em PDF** (`fontes-estudo/`, `fontes-gabaritos/`, `pdf/`). O material de referência da banca mora em `docs/`, e o código auxiliar em `scripts/`.

| Arquivo | Papel |
|---|---|
| `.claude/skills/estudo/` | **Manual operacional.** Passo a passo das sessões, régua de notas, ordem correção→confiança→revelação. Leia primeiro. |
| `.claude/skills/incluir-pergunta/` | Protocolo para inserir pergunta nova (ou várias) direto por SQL, e para vincular perguntas a provas reais. |
| `.agents/` | Espelho manual de `.claude/skills/` (mesmo conteúdo, mantido sincronizado à mão) para ferramentas de IA que seguem a convenção `AGENTS.md`/`.agents/` em vez de `.claude/skills/`. |
| `estudo.db` | Banco SQLite. **Versionado** — é o estado vivo e o backup real, e carrega o **schema completo** junto com perguntas, gabaritos e histórico. Pergunta nova entra por `INSERT` direto (skill `incluir-pergunta`), não por um pipeline de importação. |
| `AGENTS.md` | Só aponta para este arquivo (`Leia @CLAUDE.md`). **Não alterar.** Não confundir com a pasta `.agents/` acima. |
| `TODO.md` | Pendências conhecidas do projeto — confira antes de assumir que algo já está resolvido. |
| `fontes-estudo/*.md` | Textos de estudo por seção, gerados por IA, que originam os PDFs de leitura. **Não é fonte primária** — não usar para escrever gabarito. |
| `fontes-gabaritos/*/` | Fontes primárias (PDFs, HTML) usadas para escrever os `ponto_chave` de cada seção, organizadas por conceito. Fluxo de montagem: (1) pedir a um agente fontes que ele consiga de fato acessar; (2) conferir esse acesso em uma nova janela de contexto; (3) nessa mesma janela, salvar as fontes confirmadas em `fontes-gabaritos/nome_do_conceito/`; (4) pedir a um agente para gerar os gabaritos, em outra janela de contexto nova — separada da sessão de estudo (ver regra 7). |
| `scripts/mdpdf/marcacoes/` | Grifos, traços de caneta e notas feitos nos PDFs pelo Microsoft Edge, capturados pelo `mdpdf`. **É o que vai para o git** — o backup real das marcações (ver `.gitignore`). |
| `pdf/` | PDFs de leitura, gerados a partir dos `.md` do repositório mais as marcações salvas em `marcacoes/`. **Não versionado** — regerável com `python -m scripts.mdpdf gerar` (ou `ciclo`, que primeiro recolhe grifos novos do Edge). |

### `docs/` — material da banca

| Arquivo | Papel |
|---|---|
| `docs/doc-setup/README.md` | Vazio por enquanto — a ideia é que sirva no futuro como instruções de uso do diretório. |
| `docs/doc-setup/requisitos.md` | Tudo que o projeto exige instalado (SQLite, Python, PyMuPDF, Edge…) e como conferir se está de pé. |
| `docs/doc-setup/schema.md` | Documentação de referência do schema completo de `estudo.db` — tabelas, views, triggers e o invariante que cada trigger protege. |
| `docs/editais/dataprev/edital-dataprev-2026.pdf` | Edital vigente — é o que manda no conteúdo. |
| `docs/editais/dataprev/edital-dataprev-2024.pdf` | Edital do concurso de 2024, o que gerou a prova real. |
| `docs/editais/dataprev/EMENTA-DESENVOLVIMENTO-SOFTWARE-2026.md` | Transcrição do Anexo I do edital de 2026, recortada para o Perfil 3 (Desenvolvimento de Software): Módulo I comum a todos os cargos + Conhecimentos Específicos. |
| `docs/editais/dataprev/DIFF-EDITAIS-2024-2026.md` | O que mudou de um edital para o outro. |
| `docs/editais/dataprev/LACUNAS-EDITAL-2026.md` | Conceitos do edital de 2026 ainda sem pergunta no banco. |

### `docs/provas/` — provas anteriores

| Pasta | Papel |
|---|---|
| `docs/provas/dataprev-2024/` | **A prova-alvo.** Prova real da DATAPREV/FGV aplicada em 17/11/2024: o caderno original (`ati-desenvolvimento-de-software-cns003-tipo-01.pdf`), o gabarito oficial pós-recursos (`gabarito-prova.md`), a prova extraída em texto (`prova-texto.md`), as respostas dadas ao simulá-la como treino (`minhas-respostas.md`) e a lista de conceitos que originou as perguntas do banco (`conceitos.md`). |
| `docs/provas/fgv/` | Outras provas da **mesma banca** (FGV), de outros concursos e cargos de TI — calibram dificuldade e estilo de enunciado além da prova-alvo. Tem `README.md` próprio com o detalhe de cada caderno. |
| `docs/provas/bacen/` | Prova do Banco Central de 2024 (banca **Cebraspe**, formato certo/errado — não é FGV). `README.md` próprio explica as diferenças de formato e o recorte de conteúdo que ainda aproveita. |
| `docs/provas/cefet/` | Provas do CEFET/RJ para Professor EBTT (banca própria, discursiva). `README.md` próprio. |
| `docs/provas/TCE-RJ/` | Provas do TCE-RJ (banca Cebraspe), em subpastas por concurso. `README.md` próprio. |

Estas quatro últimas pastas — `fgv/`, `bacen/`, `cefet/` e `TCE-RJ/` — estão aqui só para referência pessoal, para o usuário conhecer o terreno de outras bancas e concursos. **Não puxe conteúdo delas para perguntas, gabaritos ou qualquer parte do banco de estudo a menos que o prompt peça isso explicitamente.**

### `scripts/` — código auxiliar

| Arquivo | Papel |
|---|---|
| `scripts/mdpdf/` | Conversor markdown → PDF que **preserva as marcações feitas no Edge**: lê os `.md`, aplica o que está salvo em `marcacoes/` e escreve em `pdf/`. Ver a skill `pdf-estudo`. |
| `scripts/pdfmd/` | Conversor na direção contrária: PDF → markdown. Extrai texto, tabelas e imagens/diagramas dos PDFs de `docs/` (provas, editais) para `md/`, espelhando a mesma árvore de diretórios — serve para referenciar o conteúdo das provas em formato mais legível por LLM. Ignora `pdf/` (que já nasce de markdown). Uso: `python -m scripts.pdfmd gerar`. |

## Modelo de dados

Schema mora dentro do próprio `estudo.db` — leia com `sqlite3 estudo.db .schema`. Tudo é `STRICT` e `PRAGMA foreign_keys = ON`.

**Tabelas**

- `secao` — 30 seções em 2 partes (I: legislação; II: conhecimentos técnicos).
- `pergunta` — chave natural `codigo` (`Q94`), estável entre edições. Metadados: `eh_distrator`, `eh_caso`, `profundidade` (D0–D5), `ativa`.
- `ponto_chave` — exigências verificáveis do gabarito de cada pergunta (`essencial`, `fonte`, `revisado`).
- `banca` / `prova` / `etapa` / `ancora` — de qual banca, concurso e fase uma pergunta se origina. `ancora` é a associativa `pergunta × etapa`, com o número da questão na prova real; substitui a antiga `pergunta.tag_prova`.
- `sessao` / `resposta` / `avaliacao` / `avaliacao_ponto` — histórico de estudo.
- `agendamento` — estado SM-2 por pergunta (`facilidade`, `intervalo_dias`, `proxima_revisao`). **Nunca escrever à mão.**
- `config` — pares chave/valor de configuração solta, hoje sem uso ativo.

**Views** (use-as em vez de montar SQL na mão): `v_fila` e `v_fila_fraquezas` (perguntar — não expõem gabarito), `v_gabarito` (só após gravar a resposta), `v_calibracao`, `v_progresso`, `v_desempenho_secao`, `v_cobertura`, `v_pontos_falhados`, `v_estatistica_pergunta`, `v_auditoria` (deve viver vazia), `v_peso_secao` (peso de cada seção nas provas de referência), `v_alvos` (provas com `status = 'alvo_atual'` e dias restantes), `v_catalogo` (o banco inteiro, sem gabarito exposto). Detalhe de cada uma em `docs/doc-setup/schema.md`.

**Triggers** garantem os invariantes: `trg_sm2` reagenda ao inserir avaliação; `resposta` e `avaliacao` são imutáveis e não deletáveis; confiança só entra depois da nota; toda pergunta nova ganha um `agendamento`.

## Comandos

```sh
sqlite3 estudo.db "SELECT * FROM v_progresso;"   # panorama
sqlite3 estudo.db .schema                        # ler o schema completo
git commit -m "sessão 11/08" estudo.db           # gravar o banco no git após uma sessão
git restore estudo.db                            # restaurar o banco do último commit
python -m scripts.mdpdf ciclo                    # colher grifos do Edge e regerar os PDFs
```

Todos rodam **a partir da raiz do repositório** — o `mdpdf` se invoca como `scripts.mdpdf` porque o pacote mora dentro de `scripts/`.

Ambiente: Windows + PowerShell; `sqlite3` está no PATH (instalado pelo winget), então chama-se direto pelo nome — o banco não depende de Python. `mdpdf` depende de `pymupdf`, `markdown-it-py` e `websocket-client` (instalados), mais o Microsoft Edge, que ele usa headless como motor de impressão.

## Regras invioláveis

1. **Nunca mostre o gabarito antes da resposta** — enuncie a partir de `v_fila`.
2. **Ordem fixa:** corrigir → gravar nota → perguntar confiança → revelar.
3. **Grave a resposta na íntegra**, sem editar, resumir ou corrigir.
4. **"Não sei" é nota 0 registrada**, nunca pergunta pulada.
5. **Não invente perguntas** nem escreva em `agendamento` — o SM-2 é automático.
6. **Uma pergunta por vez.**
7. **Gabarito (`ponto_chave`) prepara-se em conversa separada** da sessão de estudo, para não se contaminar com a resposta já lida (`v_auditoria` acusa).

Correção mede **conteúdo, não redação**: número, prazo, rol exato e a fronteira entre conceitos vizinhos — nada de estrutura, coesão ou tamanho do texto.
