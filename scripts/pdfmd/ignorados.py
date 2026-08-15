"""Diretórios ignorados pela descoberta automática de PDF."""

from __future__ import annotations

from pathlib import Path


DIRETORIOS = {
    ".git",
    ".claude",
    "pdf",   # PDFs de leitura gerados pelo mdpdf a partir do markdown — regeráveis, não é fonte.
    "md",    # saída deste próprio script — nunca há PDF fonte aí dentro.
    "marcacoes",
    "__pycache__",
    "node_modules",
}


def deve_ignorar(caminho: Path, raiz: Path) -> bool:
    """Indica se um caminho deve ser omitido de uma descoberta recursiva."""
    relativo = caminho.resolve().relative_to(raiz.resolve())
    return bool(set(relativo.parts[:-1]) & DIRETORIOS)
