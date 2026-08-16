"""PDF -> markdown: texto, tabelas e imagens (inclui gráficos vetoriais, ou
seja, diagramas desenhados com linhas/formas, não só figuras raster).

Usa o pymupdf4llm, que já resolve as três frentes:
  - texto corrido, com títulos inferidos pelo tamanho da fonte;
  - tabelas detectadas por linhas de grade viram tabela markdown;
  - imagens (raster e vetoriais) são recortadas em PNG à parte e referenciadas
    por link relativo no markdown.

Sem marcação para preservar (ao contrário do mdpdf) — regerar é sempre seguro,
não há sidecar nem risco de perda.
"""

from __future__ import annotations

import re
import shutil
import tempfile
from pathlib import Path

import pymupdf
import pymupdf4llm

_LINK_IMAGEM = re.compile(r"!\[\]\((?P<caminho>[^)]+)\)")
_PAGINA_NO_NOME = re.compile(r"-(?P<pagina>\d+)-(?P<indice>\d+)\.(?P<ext>\w+)$")


def _nome_curto(nome: str) -> str:
    """`gabarito-x.pdf-0001-02.png` -> `pag-0001-02.png`.

    O pymupdf4llm prefixa cada imagem com o nome do PDF de origem — que já é o
    nome da pasta `<stem>_imagens` que a contém. Essa repetição custa dezenas de
    caracteres e, em pastas fundas, estoura o limite de 260 do Windows: a falha
    acontece dentro da biblioteca, ao gravar o PNG (`cannot open file ...:
    code=2`), e derruba a extração inteira do documento.
    """
    info = _PAGINA_NO_NOME.search(nome)
    if not info:
        return nome
    return f"pag-{info['pagina']}-{info['indice']}.{info['ext']}"


def _reescrever_links(texto: str, pasta: str, renomeadas: dict[str, str]) -> str:
    """Reaponta cada link de imagem para o nome novo, relativo ao próprio `.md`,
    e injeta `pág. N` no alt text.

    O caminho que o pymupdf4llm escreve no markdown depende do diretório de
    trabalho (relativo a ele quando dá, absoluto quando não dá), então o que se
    aproveita do link original é só o nome do arquivo. A página sai do próprio
    nome — o pymupdf4llm já a grava 1-indexed — e não custa nada, não depende de
    descrever a imagem em si.
    """

    def sub(m: re.Match[str]) -> str:
        original = re.split(r"[\\/]", m["caminho"])[-1]
        nome = renomeadas.get(original)
        if nome is None:                      # link que não veio da extração
            return m.group(0)
        info = _PAGINA_NO_NOME.search(nome)
        alt = f"Imagem, pág. {int(info['pagina'])}" if info else "Imagem"
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
    # depois vão renomeadas para o destino: o nome que o pymupdf4llm dá a elas é
    # longo demais para gravar direto em pasta funda (ver `_nome_curto`).
    with tempfile.TemporaryDirectory(prefix="pdfmd-") as staging:
        doc = pymupdf.open(pdf)
        try:
            texto = pymupdf4llm.to_markdown(
                doc,
                write_images=True,
                image_path=staging,
                image_format="png",
            )
        finally:
            doc.close()

        geradas = sorted(p for p in Path(staging).iterdir() if p.is_file())
        renomeadas = {p.name: _nome_curto(p.name) for p in geradas}

        # Regerar é sempre seguro, então a pasta é refeita: senão sobra imagem
        # órfã de uma extração anterior (de um PDF antes de mudar, ou com o nome
        # comprido de antes desta correção).
        if pasta_imagens.exists():
            shutil.rmtree(pasta_imagens)
        if geradas:
            pasta_imagens.mkdir(parents=True, exist_ok=True)
            for p in geradas:
                shutil.move(str(p), str(pasta_imagens / renomeadas[p.name]))

    texto = _reescrever_links(texto, pasta_imagens.name, renomeadas)

    titulo = pdf.stem.replace("-", " ").replace("_", " ")
    destino_md.write_text(f"# {titulo}\n\n{texto}", encoding="utf-8")
    return len(geradas)
