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
from pathlib import Path

import pymupdf
import pymupdf4llm

_LINK_IMAGEM = re.compile(r"!\[\]\((?P<caminho>[^)]+)\)")
_PAGINA_NO_NOME = re.compile(r"-(?P<pagina>\d+)-(?P<indice>\d+)\.\w+$")


def _rotular_imagens(texto: str) -> str:
    """Injeta `pág. N` no alt text de cada imagem, lido do próprio nome do
    arquivo (`{stem}-{pagina}-{indice}.png`, página 0-indexed) — sem custo,
    não depende de descrever a imagem em si."""

    def rotular(m: re.Match[str]) -> str:
        caminho = m.group("caminho")
        info = _PAGINA_NO_NOME.search(caminho)
        if not info:
            return m.group(0)
        pagina = int(info.group("pagina")) + 1
        return f"![Imagem, pág. {pagina}]({caminho})"

    return _LINK_IMAGEM.sub(rotular, texto)


def para_markdown(pdf: Path, destino_md: Path, pasta_imagens: Path) -> int:
    """Extrai `pdf` para `destino_md`, gravando imagens em `pasta_imagens`.

    Retorna o número de imagens extraídas. `pasta_imagens` é removida se
    ficar vazia (PDF sem nenhuma imagem/gráfico grande o bastante para valer
    a pena extrair).
    """
    destino_md.parent.mkdir(parents=True, exist_ok=True)
    pasta_imagens.mkdir(parents=True, exist_ok=True)

    doc = pymupdf.open(pdf)
    try:
        texto = pymupdf4llm.to_markdown(
            doc,
            write_images=True,
            image_path=str(pasta_imagens),
            image_format="png",
            filename=pdf.stem,
        )
    finally:
        doc.close()

    # pymupdf4llm grava o caminho absoluto de IMG_PATH dentro dos links de
    # imagem do markdown; troca pelo caminho relativo (pasta ao lado do .md).
    prefixo_abs = str(pasta_imagens.resolve()).replace("\\", "/")
    texto = texto.replace(prefixo_abs + "/", pasta_imagens.name + "/")
    texto = _rotular_imagens(texto)

    n_imagens = sum(1 for _ in pasta_imagens.iterdir())
    if n_imagens == 0:
        pasta_imagens.rmdir()

    titulo = pdf.stem.replace("-", " ").replace("_", " ")
    destino_md.write_text(f"# {titulo}\n\n{texto}", encoding="utf-8")
    return n_imagens
