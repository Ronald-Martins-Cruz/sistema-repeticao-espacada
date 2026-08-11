"""markdown -> HTML pronto para impressão.

O HTML sai num diretório temporário, com <base> apontando para a pasta do
markdown original, para que imagens em caminho relativo continuem resolvendo.
"""

from __future__ import annotations

import html as _html
from pathlib import Path

from markdown_it import MarkdownIt

RAIZ = Path(__file__).resolve().parent
CSS = (RAIZ / "estilo.css").read_text(encoding="utf-8")

_md = MarkdownIt("commonmark").enable(["table", "strikethrough"])


def titulo_de(md: Path, texto: str) -> str:
    """Primeiro `# título` do arquivo; se não houver, o nome do arquivo."""
    for linha in texto.splitlines():
        if linha.startswith("# "):
            return linha[2:].strip()
    return md.stem


def para_html(md: Path, destino_html: Path) -> str:
    texto = md.read_text(encoding="utf-8")
    titulo = titulo_de(md, texto)
    corpo = _md.render(texto)
    base = md.resolve().parent.as_uri() + "/"
    destino_html.parent.mkdir(parents=True, exist_ok=True)
    destino_html.write_text(
        "<!doctype html>\n"
        f'<meta charset="utf-8">\n'
        f'<base href="{base}">\n'
        f"<title>{_html.escape(titulo)}</title>\n"
        f"<style>\n{CSS}\n</style>\n"
        f"{corpo}\n",
        encoding="utf-8",
    )
    return titulo
