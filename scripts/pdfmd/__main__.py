"""Linha de comando do pdfmd.

    python -m scripts.pdfmd gerar [alvos]     # extrai PDF(s) para markdown
    python -m scripts.pdfmd status [alvos]    # o que já foi extraído e o que está desatualizado

Cada PDF do repositório vira um `.md` dentro de `md/`, no mesmo caminho
relativo que ocupa hoje (espelhando a estrutura de `pdf/` que o mdpdf gera a
partir do markdown, só que na direção contrária). A pasta `pdf/` — PDF de
leitura já gerado a partir de markdown — é ignorada: extrair markdown de um
PDF que já nasceu de markdown seria dar a volta no próprio pipeline.
"""

from __future__ import annotations

import argparse
import os
import sys
import time
from concurrent.futures import ProcessPoolExecutor, as_completed
from pathlib import Path

if __package__ in (None, ""):                      # permite rodar o arquivo solto
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from scripts.pdfmd import extract
from scripts.pdfmd.ignorados import deve_ignorar

# O pacote mora em scripts/pdfmd/; a raiz do repositório é dois níveis acima.
RAIZ = Path(__file__).resolve().parents[2]
DIR_MD = RAIZ / "md"


# ──────────────────────────────────────────────────────────────── caminhos

def relativo(pdf: Path) -> Path:
    return pdf.resolve().relative_to(RAIZ)


def md_de(pdf: Path) -> Path:
    return DIR_MD / relativo(pdf).with_suffix(".md")


def pasta_imagens_de(pdf: Path) -> Path:
    md = md_de(pdf)
    return md.with_name(md.stem + "_imagens")


def descobrir(alvos: list[str]) -> list[Path]:
    if not alvos:
        return [p for p in sorted(RAIZ.rglob("*.pdf")) if not deve_ignorar(p, RAIZ)]
    saida = []
    for a in alvos:
        p = Path(a)
        if not p.is_absolute():
            p = RAIZ / p
        if p.is_dir():
            saida += [q for q in sorted(p.rglob("*.pdf")) if not deve_ignorar(q, RAIZ)]
        elif p.suffix.lower() == ".pdf" and p.exists():
            saida.append(p)
        else:
            print(f"  ! ignorado (não é .pdf existente): {a}")
    return saida


# ──────────────────────────────────────────────────────────────── comandos

def cmd_gerar(alvos: list[Path], forcar: bool, jobs: int | None) -> int:
    t0 = time.perf_counter()
    pendentes = alvos if forcar else [p for p in alvos if not _atualizado(p)]
    ignorados = len(alvos) - len(pendentes)

    total_imagens = 0
    erros = 0

    def _reportar(pdf: Path, n: int) -> None:
        nonlocal total_imagens
        total_imagens += n
        extra = f", {n} imagem(ns)" if n else ""
        print(f"  {relativo(pdf)} -> {md_de(pdf).relative_to(RAIZ)}{extra}")

    def _reportar_erro(pdf: Path, e: Exception) -> None:
        nonlocal erros
        erros += 1
        print(f"  ! erro em {relativo(pdf)}: {e}")

    if len(pendentes) > 1:
        n_jobs = jobs or min(len(pendentes), os.cpu_count() or 4)
        with ProcessPoolExecutor(max_workers=n_jobs) as ex:
            futuros = {
                ex.submit(extract.para_markdown, pdf, md_de(pdf), pasta_imagens_de(pdf)): pdf
                for pdf in pendentes
            }
            for fut in as_completed(futuros):
                pdf = futuros[fut]
                try:
                    n = fut.result()
                except Exception as e:
                    _reportar_erro(pdf, e)
                    continue
                _reportar(pdf, n)
    else:
        for pdf in pendentes:
            try:
                n = extract.para_markdown(pdf, md_de(pdf), pasta_imagens_de(pdf))
            except Exception as e:
                _reportar_erro(pdf, e)
                continue
            _reportar(pdf, n)

    print(f"{len(pendentes)} processado(s), {ignorados} em dia (pulado(s)), "
          f"{total_imagens} imagem(ns), {erros} erro(s) em "
          f"{time.perf_counter() - t0:.1f}s  ->  {DIR_MD}")
    return 1 if erros else 0


def _atualizado(pdf: Path) -> bool:
    md = md_de(pdf)
    return md.exists() and pdf.stat().st_mtime <= md.stat().st_mtime + 1


def _estado(pdf: Path) -> str:
    if not md_de(pdf).exists():
        return "sem md"
    return "em dia" if _atualizado(pdf) else "pdf mudou"


def cmd_status(alvos: list[Path]) -> int:
    print(f"{'documento':60s} {'md':>5s} {'estado':>10s}")
    print("-" * 78)
    for pdf in alvos:
        md = md_de(pdf)
        print(f"{str(relativo(pdf)):60s} {'sim' if md.exists() else '—':>5s} "
              f"{_estado(pdf):>10s}")
    return 0


# ──────────────────────────────────────────────────────────────────── main

def main(argv=None) -> int:
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    p = argparse.ArgumentParser(
        prog="python -m scripts.pdfmd",
        description="PDF -> markdown (texto, tabelas e imagens/diagramas).")
    sub = p.add_subparsers(dest="comando", required=True)

    s_gerar = sub.add_parser("gerar", help="extrai o(s) PDF(s) para markdown em md/")
    s_gerar.add_argument("alvos", nargs="*", help="arquivos .pdf ou pastas (padrão: todos)")
    s_gerar.add_argument("--forcar", action="store_true",
                          help="reprocessa mesmo os PDFs já em dia")
    s_gerar.add_argument("--jobs", type=int, default=None,
                          help="processos paralelos (padrão: nº de núcleos)")

    s_status = sub.add_parser("status", help="o que já foi extraído e o que está desatualizado")
    s_status.add_argument("alvos", nargs="*", help="arquivos .pdf ou pastas (padrão: todos)")

    a = p.parse_args(argv)

    alvos = descobrir(a.alvos)
    if not alvos:
        print("nenhum .pdf encontrado")
        return 1

    if a.comando == "status":
        return cmd_status(alvos)
    return cmd_gerar(alvos, forcar=a.forcar, jobs=a.jobs)


if __name__ == "__main__":
    raise SystemExit(main())
