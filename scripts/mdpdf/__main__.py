"""Linha de comando do mdpdf.

    python -m scripts.mdpdf ciclo             # o comando do dia a dia: colhe e regera
    python -m scripts.mdpdf colher [alvos]    # lê o que você marcou no Edge
    python -m scripts.mdpdf gerar  [alvos]    # regera o PDF e reaplica as marcações
    python -m scripts.mdpdf status            # o que está desatualizado, o que tem marca

Ordem que importa: **colher antes de editar o markdown**. Se você marcar no
Edge e mandar gerar sem colher, o PDF seria sobrescrito e as marcas se
perderiam — por isso `gerar` se recusa a passar por cima de marcação que ainda
não está no sidecar.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
import tempfile
import time
from datetime import datetime
from pathlib import Path

if __package__ in (None, ""):                      # permite rodar o arquivo solto
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from scripts.mdpdf import marcacoes as mc
from scripts.mdpdf import render
from scripts.mdpdf.edge import Edge
from scripts.mdpdf.ignorados import deve_ignorar

# O pacote mora em scripts/mdpdf/; a raiz do repositório é dois níveis acima.
RAIZ = Path(__file__).resolve().parents[2]
AQUI = Path(__file__).resolve().parent
DIR_PDF = RAIZ / "pdf"
# As marcações moram junto do código que as lê e escreve, não na raiz.
DIR_MARCAS = AQUI / "marcacoes"
# ──────────────────────────────────────────────────────────────── caminhos

def relativo(md: Path) -> Path:
    return md.resolve().relative_to(RAIZ)


def pdf_de(md: Path) -> Path:
    return DIR_PDF / relativo(md).with_suffix(".pdf")


def sidecar_de(md: Path) -> Path:
    return DIR_MARCAS / relativo(md).with_suffix(".json")


def descobrir(alvos: list[str]) -> list[Path]:
    if not alvos:
        achados = []
        for p in sorted(RAIZ.rglob("*.md")):
            if deve_ignorar(p, RAIZ) or p.stat().st_size == 0:
                continue
            achados.append(p)
        return achados
    saida = []
    for a in alvos:
        p = Path(a)
        if not p.is_absolute():
            p = RAIZ / p
        if p.is_dir():
            saida += [
                q for q in sorted(p.rglob("*.md"))
                if not deve_ignorar(q, RAIZ) and q.stat().st_size
            ]
        elif p.suffix.lower() == ".md" and p.exists():
            saida.append(p)
        else:
            print(f"  ! ignorado (não é .md existente): {a}")
    return saida


def sha_de(md: Path) -> str:
    return hashlib.sha256(md.read_bytes()).hexdigest()[:16]


# ──────────────────────────────────────────────────────────────── sidecar

def ler_sidecar(md: Path) -> dict:
    s = sidecar_de(md)
    if not s.exists():
        return {"origem": str(relativo(md)).replace("\\", "/"), "marcacoes": []}
    return json.loads(s.read_text(encoding="utf-8"))


def gravar_sidecar(md: Path, dados: dict) -> None:
    s = sidecar_de(md)
    s.parent.mkdir(parents=True, exist_ok=True)
    dados["origem"] = str(relativo(md)).replace("\\", "/")
    dados["atualizado_em"] = datetime.now().isoformat(timespec="seconds")
    s.write_text(json.dumps(dados, ensure_ascii=False, indent=1), encoding="utf-8")


def nao_colhidas(md: Path) -> list[dict]:
    """Marcações que estão no PDF mas não no sidecar — perder-se-iam ao gerar."""
    pdf = pdf_de(md)
    if not pdf.exists():
        return []
    conhecidas = {mc.assinatura(m) for m in ler_sidecar(md)["marcacoes"]}
    return [m for m in mc.colher(pdf) if mc.assinatura(m) not in conhecidas]


# ──────────────────────────────────────────────────────────────── comandos

def cmd_colher(alvos: list[Path]) -> int:
    total = 0
    for md in alvos:
        pdf = pdf_de(md)
        if not pdf.exists():
            continue
        marcas = mc.colher(pdf)
        dados = ler_sidecar(md)
        antes = len(dados["marcacoes"])
        dados["marcacoes"] = marcas
        dados["md_sha256"] = sha_de(md)
        gravar_sidecar(md, dados)
        if marcas or antes:
            delta = len(marcas) - antes
            sinal = f"  ({delta:+d})" if delta else ""
            print(f"  {relativo(md)}: {len(marcas)} marcações{sinal}")
        total += len(marcas)
    print(f"colhidas {total} marcações de {len(alvos)} documento(s)")
    return 0


def _relatar(md: Path, rel: mc.Relatorio, outros: list[Path]) -> None:
    if not rel.total:
        return
    partes = [f"{len(rel.exatas)} exatas"]
    if rel.aproximadas:
        partes.append(f"{len(rel.aproximadas)} aproximadas")
    if rel.orfas:
        partes.append(f"{len(rel.orfas)} ÓRFÃS")
    print(f"     marcações: {', '.join(partes)}")
    for m in rel.aproximadas:
        trecho = (m.get("texto") or m.get("ancora") or "")[:60]
        print(f"       ~ confira: {trecho!r}")
    for m in rel.orfas:
        trecho = (m.get("texto") or m.get("ancora") or "")
        print(f"       x sumiu: {trecho[:60]!r}"
              + (f"  [{m['erro']}]" if m.get("erro") else ""))
        if trecho:
            for outro in outros:                 # migrou para outro arquivo?
                if outro == pdf_de(md) or not outro.exists():
                    continue
                paginas = mc.procurar_texto(outro, trecho[:80])
                if paginas:
                    print(f"         -> esse trecho está em {outro.relative_to(RAIZ)} "
                          f"(pág {paginas[0] + 1})")
                    break
    if rel.orfas:
        print("       (órfãs ficam guardadas no sidecar e voltam sozinhas "
              "se o trecho reaparecer)")


def cmd_gerar(alvos: list[Path], forcar: bool) -> int:
    bloqueados = []
    if not forcar:
        for md in alvos:
            pendentes = nao_colhidas(md)
            if pendentes:
                bloqueados.append((md, pendentes))
    if bloqueados:
        print("PAREI. Estes PDFs têm marcações que não estão no sidecar —")
        print("regerar agora as apagaria. Rode `colher` (ou `ciclo`) antes:\n")
        for md, pend in bloqueados:
            print(f"  {relativo(md)}: {len(pend)} marcação(ões) por colher")
            for m in pend[:3]:
                print(f"      {(m.get('texto') or m.get('ancora') or '?')[:60]!r}")
        print("\n(`--forcar` passa por cima e descarta essas marcações.)")
        return 1

    t0 = time.perf_counter()
    tmp = Path(tempfile.mkdtemp(prefix="mdpdf-html-"))
    todos_pdfs = [pdf_de(m) for m in alvos]
    with Edge() as browser:
        for md in alvos:
            html = tmp / (relativo(md).with_suffix(".html").name)
            render.para_html(md, html)
            pdf = pdf_de(md)
            browser.imprimir(html, pdf)
            dados = ler_sidecar(md)
            rel = mc.aplicar(pdf, dados["marcacoes"])
            print(f"  {relativo(md)} -> {pdf.relative_to(RAIZ)}")
            _relatar(md, rel, todos_pdfs)
            if dados["marcacoes"]:
                # Relê do PDF o que de fato ficou lá: assim uma marcação que
                # reancorou por semelhança adota o texto novo em vez de ficar
                # eternamente divergindo do sidecar. As órfãs não estão no PDF,
                # então seguem guardadas à parte — nunca se perdem.
                agora = datetime.now().isoformat(timespec="seconds")
                orfas = [{**m, "orfa_desde": m.get("orfa_desde", agora)}
                         for m in rel.orfas]
                dados["marcacoes"] = mc.colher(pdf) + orfas
            dados["md_sha256"] = sha_de(md)
            dados["ultima_geracao"] = {
                "quando": datetime.now().isoformat(timespec="seconds"),
                "exatas": len(rel.exatas), "aproximadas": len(rel.aproximadas),
                "orfas": len(rel.orfas),
            }
            if dados["marcacoes"] or sidecar_de(md).exists():
                gravar_sidecar(md, dados)
    print(f"{len(alvos)} PDF(s) em {time.perf_counter() - t0:.1f}s  ->  {DIR_PDF}")
    return 0


def _estado(md: Path) -> str:
    pdf = pdf_de(md)
    if not pdf.exists():
        return "sem pdf"
    if nao_colhidas(md):                 # o mais urgente: há marca a perder
        return "POR COLHER"
    if sidecar_de(md).exists():
        atual = ler_sidecar(md).get("md_sha256") == sha_de(md)
    else:                                # sem marcação nenhuma: basta o relógio
        atual = md.stat().st_mtime <= pdf.stat().st_mtime + 1
    return "em dia" if atual else "md mudou"


def cmd_status(alvos: list[Path]) -> int:
    print(f"{'documento':44s} {'pdf':>5s} {'marcas':>7s} {'estado':>14s}")
    print("-" * 74)
    for md in alvos:
        n = len(ler_sidecar(md)["marcacoes"])
        print(f"{str(relativo(md)):44s} {'sim' if pdf_de(md).exists() else '—':>5s} "
              f"{n:>7d} {_estado(md):>14s}")
    return 0


# ──────────────────────────────────────────────────────────────────── main

def main(argv=None) -> int:
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    p = argparse.ArgumentParser(
        prog="python -m scripts.mdpdf",
        description="Markdown -> PDF preservando as marcações feitas no Edge.")
    sub = p.add_subparsers(dest="comando", required=True)
    for nome, ajuda in [
        ("ciclo", "colhe as marcações e regera (o comando do dia a dia)"),
        ("colher", "lê do PDF o que você marcou no Edge e grava no sidecar"),
        ("gerar", "regera o PDF a partir do markdown e reaplica as marcações"),
        ("status", "o que está desatualizado e o que tem marcação por colher"),
    ]:
        s = sub.add_parser(nome, help=ajuda)
        s.add_argument("alvos", nargs="*", help="arquivos .md ou pastas (padrão: todos)")
        if nome in ("gerar", "ciclo"):
            s.add_argument("--forcar", action="store_true",
                           help="regera mesmo descartando marcações não colhidas")
    a = p.parse_args(argv)

    alvos = descobrir(a.alvos)
    if not alvos:
        print("nenhum .md encontrado")
        return 1

    if a.comando == "status":
        return cmd_status(alvos)
    if a.comando == "colher":
        return cmd_colher(alvos)
    if a.comando == "gerar":
        return cmd_gerar(alvos, a.forcar)
    cmd_colher(alvos)
    return cmd_gerar(alvos, a.forcar)


if __name__ == "__main__":
    raise SystemExit(main())
