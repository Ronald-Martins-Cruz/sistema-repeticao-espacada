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
    "md"
}

ARQUIVOS = {
    "AGENTS.md",
}

# Caminhos relativos à raiz, ignorados só naquele lugar — ao contrário de
# DIRETORIOS, que casa o nome em qualquer nível.
PREFIXOS = {
    # As folhas de resposta de cada bloco de estudo, preenchidas no editor.
    # Não são texto de leitura: o que vira PDF é o feedback, em
    # `sessoes/feedbacks/`.
    ("sessoes", "perguntas"),
}


def deve_ignorar(caminho: Path, raiz: Path) -> bool:
    """Indica se um caminho deve ser omitido de uma descoberta recursiva."""
    relativo = caminho.resolve().relative_to(raiz.resolve())
    partes = relativo.parts[:-1]
    return (
        bool(set(partes) & DIRETORIOS)
        or any(partes[:len(p)] == p for p in PREFIXOS)
        or caminho.name in ARQUIVOS
    )
