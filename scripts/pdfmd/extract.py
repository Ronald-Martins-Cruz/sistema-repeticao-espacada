"""PDF -> markdown: texto, tabelas e imagens (inclui gráficos vetoriais, ou
seja, diagramas desenhados com linhas/formas, não só figuras raster).

Usa o pymupdf4llm, que já resolve as três frentes:
  - texto corrido, com títulos inferidos pelo tamanho da fonte;
  - tabelas detectadas por linhas de grade viram tabela markdown;
  - imagens (raster e vetoriais) são recortadas em PNG à parte e referenciadas
    por link relativo no markdown.

O que ele não resolve sozinho é página em duas colunas com fio no meio, como em
caderno de prova: sem enxergar o fio, ele intercala as alternativas de uma
questão com as da outra — o enunciado sai partido e o conteúdo, misturado.

A saída para isso é não discutir ordem de leitura com o pymupdf4llm, e sim
entregar a ele uma página que só tenha uma ordem possível: antes de extrair,
`colunas` diz em que retângulos cada página se divide e em que ordem lê-los, e
o documento é reescrito com **uma página por retângulo**. Coluna vira página; a
ordem de leitura vira a ordem das páginas. O extrator continua fazendo o de
sempre — só que agora sobre um documento de coluna única.

Documento sem nenhuma página em duas colunas (edital, por exemplo) é extraído
direto, sem reescrita, e sai idêntico ao de antes.

Sem marcação para preservar (ao contrário do mdpdf) — regerar é sempre seguro,
não há sidecar nem risco de perda.
"""

from __future__ import annotations

import re
import shutil
import tempfile
from collections import Counter
from pathlib import Path

import pymupdf
import pymupdf4llm

from scripts.pdfmd import colunas

_LINK_IMAGEM = re.compile(r"!\[\]\((?P<caminho>[^)]+)\)")
_PAGINA_NO_NOME = re.compile(r"-(?P<pagina>\d+)-(?P<indice>\d+)\.\w+$")


def _por_regiao(doc: pymupdf.Document) -> tuple[pymupdf.Document, list[int]] | None:
    """Reescreve `doc` com uma página por região de leitura.

    Devolve `(documento, origem)`, onde `origem[i]` é o número (0-based) da
    página de `doc` que deu origem à página `i` do documento novo — é o que
    permite rotular as imagens com a página certa do PDF original. Devolve
    `None` quando nenhuma página é de duas colunas: aí não há o que reescrever.

    O retângulo é redesenhado na **posição e no tamanho de página originais**,
    não encolhido para o próprio tamanho. Parece detalhe, mas a régua de título
    do pymupdf4llm é a fonte comparada com a página: numa página estreitada, o
    corpo do texto passa por título e a hierarquia de `#` desanda.
    """
    regioes = [colunas.regioes(doc[pno]) for pno in range(doc.page_count)]
    if not any(regioes):
        return None

    novo = pymupdf.open()
    origem: list[int] = []
    for pno, recortes in enumerate(regioes):
        caixa = doc[pno].rect
        for recorte in recortes or [caixa]:
            pagina = novo.new_page(width=caixa.width, height=caixa.height)
            pagina.show_pdf_page(recorte, doc, pno, clip=recorte)
            origem.append(pno)
    return novo, origem


def _renomear(geradas: list[Path], origem: list[int]) -> dict[str, tuple[str, int]]:
    """`<nome do pymupdf4llm>` -> `(pag-0003-01.png, 3)`.

    Duas coisas de uma vez. O nome encurta porque o pymupdf4llm prefixa cada
    imagem com o nome do PDF de origem — que já é o nome da pasta `<stem>_imagens`
    que a contém; em pasta funda essa repetição estoura o limite de 260 do
    Windows, e a falha acontece lá dentro, ao gravar o PNG (`cannot open file
    ...: code=2`), derrubando a extração inteira do documento. E a página volta
    a ser a do PDF original: no nome que vem do pymupdf4llm ela é a página do
    documento reescrito, onde uma página de prova virou quatro.
    """

    def ordem(p: Path) -> tuple[int, int]:
        info = _PAGINA_NO_NOME.search(p.name)
        return (int(info["pagina"]), int(info["indice"])) if info else (0, 0)

    contador: Counter[int] = Counter()
    saida: dict[str, tuple[str, int]] = {}
    for p in sorted(geradas, key=ordem):
        # O pymupdf4llm numera a página 1-based no nome do arquivo.
        derivada, _ = ordem(p)
        pagina = origem[derivada - 1] + 1 if 1 <= derivada <= len(origem) else 0
        contador[pagina] += 1
        saida[p.name] = (f"pag-{pagina:04d}-{contador[pagina]:02d}{p.suffix}", pagina)
    return saida


def _reescrever_links(texto: str, pasta: str,
                      renomeadas: dict[str, tuple[str, int]]) -> str:
    """Reaponta cada link de imagem para o nome novo, relativo ao próprio `.md`,
    e injeta `pág. N` no alt text.

    O caminho que o pymupdf4llm escreve no markdown depende do diretório de
    trabalho (relativo a ele quando dá, absoluto quando não dá), então o que se
    aproveita do link original é só o nome do arquivo.
    """

    def sub(m: re.Match[str]) -> str:
        original = re.split(r"[\\/]", m["caminho"])[-1]
        achado = renomeadas.get(original)
        if achado is None:                    # link que não veio da extração
            return m.group(0)
        nome, pagina = achado
        alt = f"Imagem, pág. {pagina}" if pagina else "Imagem"
        return f"![{alt}]({pasta}/{nome})"

    return _LINK_IMAGEM.sub(sub, texto)


def para_markdown(pdf: Path, destino_md: Path, pasta_imagens: Path) -> int:
    """Extrai `pdf` para `destino_md`, gravando imagens em `pasta_imagens`.

    Retorna o número de imagens extraídas. `pasta_imagens` é refeita do zero a
    cada extração e só existe se o PDF tiver alguma imagem/gráfico grande o
    bastante para valer a pena extrair.
    """
    destino_md.parent.mkdir(parents=True, exist_ok=True)

    # As imagens saem primeiro num diretório temporário, de caminho curto, e só
    # depois vão renomeadas para o destino (ver `_renomear`).
    with tempfile.TemporaryDirectory(prefix="pdfmd-") as staging:
        doc = pymupdf.open(pdf)
        derivado = None
        try:
            # O to_markdown faria isso adiante; feito aqui, a detecção de
            # colunas enxerga exatamente a mesma página que ele vai extrair.
            if doc.is_form_pdf or (doc.is_pdf and doc.has_annots()):
                doc.bake()

            derivado = _por_regiao(doc)
            alvo, origem = derivado or (doc, list(range(doc.page_count)))
            texto = pymupdf4llm.to_markdown(
                alvo,
                write_images=True,
                image_path=staging,
                image_format="png",
            )
        finally:
            if derivado:
                derivado[0].close()
            doc.close()

        geradas = sorted(p for p in Path(staging).iterdir() if p.is_file())
        renomeadas = _renomear(geradas, origem)

        # Regerar é sempre seguro, então a pasta é refeita: senão sobra imagem
        # órfã de uma extração anterior (de um PDF antes de mudar, ou com o nome
        # comprido de antes desta correção).
        if pasta_imagens.exists():
            shutil.rmtree(pasta_imagens)
        if geradas:
            pasta_imagens.mkdir(parents=True, exist_ok=True)
            for p in geradas:
                shutil.move(str(p), str(pasta_imagens / renomeadas[p.name][0]))

    texto = _reescrever_links(texto, pasta_imagens.name, renomeadas)

    titulo = pdf.stem.replace("-", " ").replace("_", " ")
    destino_md.write_text(f"# {titulo}\n\n{texto}", encoding="utf-8")
    return len(geradas)
