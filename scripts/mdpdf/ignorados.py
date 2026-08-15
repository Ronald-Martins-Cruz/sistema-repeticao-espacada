"""Arquivos e diretórios ignorados pela descoberta automática de Markdown."""

from __future__ import annotations

from pathlib import Path


DIRETORIOS = {
    ".git",
    # `.agents/` só tem ponteiros para `.claude/skills/` — o conteúdo real das
    # skills está lá, e é de lá que os PDFs devem sair.
    ".agents",
    "pdf",
    "marcacoes",
    "__pycache__",
    "node_modules",
}

ARQUIVOS = {
    "AGENTS.md",
}


def deve_ignorar(caminho: Path, raiz: Path) -> bool:
    """Indica se um caminho deve ser omitido de uma descoberta recursiva."""
    relativo = caminho.resolve().relative_to(raiz.resolve())
    return bool(set(relativo.parts[:-1]) & DIRETORIOS) or caminho.name in ARQUIVOS
