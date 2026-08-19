# Requisitos do projeto

O que precisa estar instalado para operar este repositório. Não há
`requirements.txt`, `pyproject.toml`, venv nem passo de build: são quatro
pacotes Python, o `sqlite3` e o Edge que já veio com o Windows.

> Todos os comandos deste documento rodam **a partir da raiz do repositório**,
> não desta pasta.

O projeto tem **duas metades independentes**, e vale saber disso antes de
instalar qualquer coisa:

| Metade | O que faz | Do que depende |
|---|---|---|
| **Banco de estudo** | `estudo.db` | `sqlite3`. **Nada mais — nem Python.** |
| **PDF de leitura** | `scripts/mdpdf/` (código e marcações), `pdf/` | 4 pacotes do PyPI + Microsoft Edge |

Quem só quer estudar (enunciar, responder, corrigir) precisa da primeira metade
apenas. A segunda só entra quando se quer ler o material em PDF e grifar.

---

## Panorama

Números da coluna "testado com" são os desta máquina, em 11/08/2026 — foi
neles que a coisa rodou.

| Ferramenta | Testado com | Para quê | Metade |
|---|---|---|---|
| **Python** | 3.12.10 | Roda o `mdpdf` e o `pdfmd`. | pdf |
| **SQLite (CLI `sqlite3`)** | 3.53.4 | Opera `estudo.db` direto por SQL. | banco |
| **git** | 2.50.0 | Versiona `estudo.db` e `scripts/mdpdf/marcacoes/` — é o backup real. | fluxo |
| **PyMuPDF** (`pymupdf`) | 1.28.2 | Lê e escreve as anotações do PDF — colhe os grifos e os redesenha no PDF regerado. | pdf |
| **markdown-it-py** | 4.2.0 | Converte o markdown em HTML, com tabelas. | pdf |
| **websocket-client** | 1.9.0 | Fala com o Edge pelo DevTools Protocol. | pdf |
| **Microsoft Edge** | 151.0.4129.72 | Motor de impressão do PDF, em modo headless. | pdf |
| **pymupdf4llm** | 0.0.27 | Extrai texto, tabelas e imagens/diagramas do PDF para markdown — usado só pelo `pdfmd`. | pdf |

---

## O banco (SQLite)

Sem dependência nenhuma além do próprio `sqlite3` — não há ORM, nem
ferramenta de migração, nem script de importação. O schema mora dentro do
próprio `estudo.db`, versionado junto com os dados, e se lê com
`sqlite3 estudo.db .schema`. Pergunta nova entra por `INSERT` direto (skill
`incluir-pergunta`), não por edição de arquivo seguida de reimportação.

### Piso mínimo: SQLite 3.37

Todas as tabelas do schema são `STRICT`, e `STRICT` só existe a partir do
**SQLite 3.37.0** (nov/2021). Esse é o requisito duro do binário `sqlite3`
usado nas sessões de estudo — confira a versão na seção "Conferir se está
tudo de pé".

Fora o `STRICT`, o schema não pede nada exótico: `INSERT ... ON CONFLICT DO
UPDATE` (3.24+), `julianday()`, views, triggers e `PRAGMA foreign_keys` são
todos bem mais antigos que o piso.

### `~/.sqliterc` — as chaves estrangeiras dependem dele

Fora do repositório, e por isso fácil de esquecer numa máquina nova. `STRICT`
está no schema e vale sempre; `foreign_keys` **não** — é pragma de conexão,
nasce desligado e não fica gravado no arquivo. Sem ele, um `INSERT` apontando
para um pai inexistente entra calado. Foi assim que 7 linhas órfãs entraram em
`avaliacao_ponto` (corrigidas em 19/08/2026).

O arquivo mora em `C:\Users\<voce>\.sqliterc` e tem uma linha útil:

```sql
PRAGMA foreign_keys = ON;
```

Cobre **só o shell `sqlite3`**. Script em Python, GUI ou qualquer outro cliente
ignora o `.sqliterc` e precisa ligar o pragma na mão. Conferir:

```sh
sqlite3 estudo.db "PRAGMA foreign_keys;"   # tem que devolver 1
sqlite3 estudo.db "PRAGMA foreign_key_check;"   # tem que sair vazio
```

### Como o `sqlite3` chegou aqui

Nesta máquina veio pelo winget e está no PATH:

```sh
winget install SQLite.SQLite
```

O binário fica em `%LOCALAPPDATA%\Microsoft\WinGet\Packages\SQLite.SQLite_Microsoft.Winget.Source_8wekyb3d8bbwe\`,
e é o próprio winget que põe essa pasta no PATH. Chame sempre pelo nome
(`sqlite3`), não pelo caminho completo.

---

## O conversor de PDF (`mdpdf`)

Transforma os textos de estudo em PDF de leitura **preservando os grifos,
traços de caneta e notas feitos no Microsoft Edge**. O pacote mora em
`scripts/mdpdf/` e se invoca como `python -m scripts.mdpdf`. O manual de uso é
a skill [`pdf-estudo`](../../.claude/skills/pdf-estudo/SKILL.md); aqui trata-se
só de *o que precisa estar instalado*.

Fora os três pacotes do PyPI, o `mdpdf` usa só biblioteca padrão (`argparse`,
`base64`, `dataclasses`, `difflib`, `hashlib`, `json`, `os`, `pathlib`, `re`,
`shutil`, `socket`, `subprocess`, `tempfile`, `time`, `urllib.request`).

### Pisos mínimos

Estimativa pela API usada, não foram testados:

- **Python 3.9+** pela sintaxe — o código usa anotações adiadas
  (`from __future__ import annotations`) e genéricos embutidos (`list[dict]`).
- **PyMuPDF 1.23+** — precisa de `search_for(..., quads=True)`, `add_ink_annot`
  e `Rect.quad`.
- **markdown-it-py 2.0+**, **websocket-client 1.0+** — APIs antigas e estáveis.
- **Edge 111+** — a flag `--remote-allow-origins` só existe a partir do
  Chromium 111.

### Fontes

`scripts/mdpdf/estilo.css` pede **Georgia**, **Segoe UI** e **Cascadia Mono**, que já
vêm com o Windows. Se alguma faltar, o Edge substitui e o documento **reflui** —
o PDF sai, mas todas as marcações precisam ser reancoradas, como se você
tivesse mexido no CSS. Não é erro; é retrabalho silencioso.

---

## Instalação

```sh
python -m pip install pymupdf markdown-it-py websocket-client pymupdf4llm
```

O Edge já vem com o Windows 11; não há o que instalar. **Não é preciso baixar
navegador nenhum** — nada de Playwright, Puppeteer ou Chrome à parte.

---

## Conferir se está tudo de pé

```sh
python -c "import sys; print('Python', sys.version.split()[0])"
sqlite3 -version
sqlite3 estudo.db "PRAGMA integrity_check;"
sqlite3 estudo.db "SELECT COUNT(*) FROM v_auditoria;"
python -c "import pymupdf, markdown_it, websocket; print('pymupdf', pymupdf.__version__, '| markdown-it-py', markdown_it.__version__, '| websocket-client', websocket.__version__)"
python -m scripts.mdpdf status
```

O que se espera de cada linha:

| Comando | Saída boa |
|---|---|
| `sqlite3 -version` | ≥ 3.37 |
| `PRAGMA integrity_check` | `ok` |
| `SELECT COUNT(*) FROM v_auditoria` | `0` — a view de auditoria deve viver vazia |
| `import pymupdf, …` | uma linha com as três versões, sem traceback |
| `python -m scripts.mdpdf status` | a tabela de documentos, sem erro |

`python -m scripts.mdpdf status` é o teste de ponta a ponta mais barato do lado do PDF:
ele abre os PDFs existentes, o que já exercita o PyMuPDF. Do lado do banco, o
equivalente é o `v_progresso`:

```sh
sqlite3 -header estudo.db "SELECT * FROM v_progresso;"
```

Se ele responder com o panorama de perguntas e respostas, o banco está de pé.

---

## O que NÃO é preciso

Vale registrar, porque é a primeira coisa que se pensa em instalar para
converter markdown em PDF, e nesta máquina seria trabalho perdido:

| Descartado | Por quê |
|---|---|
| **pandoc** | Resolveria a conversão, mas o PDF ainda precisaria de um motor de impressão. |
| **LaTeX / MiKTeX / Tectonic** | Instalação de gigabytes para ganhar tipografia que estes textos não pedem. |
| **Typst** | Rápido, mas exigiria reescrever o estilo numa linguagem à parte. |
| **WeasyPrint** | No Windows depende do runtime GTK, que é chato de instalar. |
| **wkhtmltopdf** | Motor antigo, sem o CSS moderno que as tabelas usam. |
| **Playwright / Puppeteer** | Baixariam um navegador de ~150 MB só para fazer o que o Edge já instalado faz. |
| **ORM / Alembic / Django** | O schema é um arquivo `.sql` aplicado com `<`. Não há migração a versionar além do próprio dump. |
| **venv / requirements.txt** | Três pacotes, instalação global, uma máquina só. |

Além do custo, há uma razão de fundo para ficar no Edge: **é o mesmo motor que
vai exibir o PDF depois**. O que ele imprime é exatamente o que se vê lendo.
Trocar de renderizador reflui o documento inteiro de uma vez e obriga todas as
marcações já feitas a serem reancoradas.

---

## Quando falta alguma coisa

| Sintoma | Falta |
|---|---|
| `unable to open database file` ao abrir `estudo.db` | O banco não existe ou está fora da raiz do repositório. Restaure do git: `git restore estudo.db`. |
| `near "STRICT": syntax error` ao abrir o banco | SQLite anterior ao 3.37. Atualize o `sqlite3`. |
| `FOREIGN KEY constraint failed` em escrita que parecia certa | O pragma está ligado e a escrita aponta para um pai que não existe. Conserte o id — **não** desligue o pragma para o erro sumir. |
| Escrita com id de pai errado **não** dá erro nenhum | O contrário do caso acima, e o perigoso: `PRAGMA foreign_keys` está em 0 e a linha órfã entrou calada. Confira com `PRAGMA foreign_key_check;` e veja a seção do `~/.sqliterc`. |
| `ModuleNotFoundError: No module named 'pymupdf'` (ou `markdown_it`, ou `websocket`) | O pacote correspondente — rode o `pip install` acima. |
| `RuntimeError: msedge.exe não encontrado. Procurei em: ...` | O Edge não está nos caminhos esperados. |
| `RuntimeError: o Edge não subiu em 30s` | O Edge existe mas não abriu a porta de depuração; costuma ser antivírus ou política corporativa bloqueando. |

---

## Notas de portabilidade

O código assume Windows em dois pontos:

1. A lista `CAMINHOS_EDGE`, no topo de
   [`scripts/mdpdf/edge.py`](../../scripts/mdpdf/edge.py). Numa máquina Linux ou
   macOS basta apontar essa lista para o binário do Edge ou de qualquer
   Chromium — o resto do DevTools Protocol é igual.
2. As fontes do `scripts/mdpdf/estilo.css` (ver acima). Fora do Windows elas serão
   substituídas e o documento reflui.

O banco não assume nada: `estudo.db` roda igual em qualquer sistema com
SQLite 3.37+.

O Edge é sempre lançado com um perfil temporário e descartável, em `--headless`.
Ele **não** toca no seu perfil de navegação, nas suas abas abertas nem nas suas
sessões — e uma instância já aberta do Edge não atrapalha a geração.
