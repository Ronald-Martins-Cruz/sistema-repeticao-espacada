"""Colher marcações de um PDF e reancorá-las noutro PDF regerado.

A ideia toda: uma marcação não vale pelas coordenadas onde foi feita, e sim
pelo **texto que ela cobre**. Destaque guarda as palavras sob si; traço de
caneta guarda a linha de texto por baixo dele mais os pontos do traço em
coordenadas relativas àquela linha. Quando o markdown muda e o PDF é regerado,
procura-se o texto de novo e a marcação é redesenhada onde ele foi parar.

Três desfechos possíveis para cada marcação, e todos são reportados:
  exata       — o texto foi reencontrado igual;
  aproximada  — o trecho foi reescrito, casou por semelhança (confira);
  órfã        — o texto sumiu do documento; a marcação fica guardada no
                sidecar e é reportada, nunca descartada em silêncio.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from difflib import SequenceMatcher
from pathlib import Path

import pymupdf

TIPOS_TEXTO = {"Highlight", "Underline", "StrikeOut", "Squiggly"}
TIPOS_CAIXA = {"FreeText", "Text", "Square", "Circle"}
TIPOS_DESENHO = {"Ink"}
SUPORTADOS = TIPOS_TEXTO | TIPOS_CAIXA | TIPOS_DESENHO

_ADICIONA = {
    "Highlight": "add_highlight_annot",
    "Underline": "add_underline_annot",
    "StrikeOut": "add_strikeout_annot",
    "Squiggly": "add_squiggly_annot",
}

LIMIAR_SEMELHANCA = 0.72   # abaixo disto não é o mesmo trecho, é outro trecho
ESCALA_MIN, ESCALA_MAX = 0.5, 2.0


# ───────────────────────────────────────────────────────────── utilitários

def _normalizar(s: str) -> str:
    return re.sub(r"\s+", " ", (s or "")).strip().casefold()


def _palavras(page) -> list[tuple]:
    """Palavras da página em ordem de leitura: (x0,y0,x1,y1,txt,bloco,linha,n)."""
    ws = page.get_text("words")
    ws.sort(key=lambda w: (w[5], w[6], w[7]))
    return ws


def _indices_sob(palavras, rect, minimo=0.30) -> list[int]:
    """Índices das palavras cobertas por `rect` (pelo menos `minimo` da área)."""
    out = []
    for i, w in enumerate(palavras):
        r = pymupdf.Rect(w[0], w[1], w[2], w[3])
        area = r.get_area()
        if area <= 0:
            continue
        inter = r & rect
        if not inter.is_empty and inter.get_area() >= minimo * area:
            out.append(i)
    return out


def _uniao(palavras, indices) -> pymupdf.Rect:
    r = pymupdf.Rect(palavras[indices[0]][:4])
    for i in indices[1:]:
        r |= pymupdf.Rect(palavras[i][:4])
    return r


def assinatura(m: dict) -> tuple:
    """Identidade de conteúdo de uma marcação — serve para comparar o que está
    no PDF com o que está no sidecar sem depender de coordenada."""
    return (m["tipo"], _normalizar(m.get("texto") or m.get("ancora") or ""),
            _normalizar(m.get("nota", "")))


# ─────────────────────────────────────────────────────────────── colheita

def _comum(a, pno: int) -> dict:
    cores = a.colors or {}
    info = a.info or {}
    return {
        "tipo": a.type[1],
        "pagina": pno,
        "cor": cores.get("stroke"),
        "preenchimento": cores.get("fill"),
        "opacidade": a.opacity if a.opacity and a.opacity >= 0 else None,
        "nota": info.get("content", "") or "",
        "autor": info.get("title", "") or "",
        "largura_traco": (a.border or {}).get("width") or 1.0,
    }


def _linha_ancora(page, palavras, rect):
    """Trecho de UMA linha de texto sob (ou perto de) `rect`, e o retângulo dele.

    Uma linha só porque `search_for` não atravessa quebra de linha nem célula
    de tabela de forma confiável. Se não houver texto sob o traço — uma seta na
    margem, por exemplo — a busca se alarga até encontrar a linha mais próxima.
    """
    for margem in (0, 6, 14, 30, 60, 120, 220):
        area = pymupdf.Rect(rect.x0 - margem, rect.y0 - margem,
                            rect.x1 + margem, rect.y1 + margem) & page.rect
        if area.is_empty:
            continue
        dentro = [w for w in palavras
                  if not (pymupdf.Rect(w[:4]) & area).is_empty]
        if not dentro:
            continue
        linhas: dict[tuple, list] = {}
        for w in dentro:
            linhas.setdefault((w[5], w[6]), []).append(w)

        def proximidade(ws):
            y0, y1 = min(w[1] for w in ws), max(w[3] for w in ws)
            sobrepoe = min(y1, rect.y1) - max(y0, rect.y0)
            if sobrepoe > 0:
                return (1, sobrepoe)
            return (0, -abs((y0 + y1) / 2 - (rect.y0 + rect.y1) / 2))

        linha = max(linhas.values(), key=proximidade)
        linha.sort(key=lambda w: w[7])

        # menor frase de palavras inteiras que a página reencontre — de
        # preferência única. Frases curtas demais casam em qualquer lugar.
        reserva = None
        for n in range(1, len(linha) + 1):
            frase = " ".join(w[4] for w in linha[:n])
            if len(frase) < 12 and n < len(linha):
                continue
            achados = page.search_for(frase)
            if len(achados) == 1:
                return frase, achados[0]
            if achados and reserva is None:
                reserva = (frase, achados[0])
        if reserva:
            return reserva
    return None, None


def _colher_texto(page, palavras, a) -> dict:
    """Destaque/sublinhado: guarda um segmento por linha coberta."""
    vertices = a.vertices or []
    segmentos, todos = [], []
    for i in range(0, len(vertices) - 3, 4):
        quad = pymupdf.Quad(*vertices[i:i + 4])
        idx = _indices_sob(palavras, quad.rect)
        if idx:
            segmentos.append(" ".join(palavras[j][4] for j in sorted(set(idx))))
            todos += idx
        else:
            bruto = " ".join(page.get_textbox(quad.rect).split())
            if bruto:
                segmentos.append(bruto)
    segmentos = [s for s in segmentos if s.strip()]
    antes = depois = ""
    if todos:
        i0, i1 = min(todos), max(todos)
        antes = " ".join(w[4] for w in palavras[max(0, i0 - 8):i0])
        depois = " ".join(w[4] for w in palavras[i1 + 1:i1 + 9])
    return {"segmentos": segmentos, "texto": " ".join(segmentos),
            "antes": antes, "depois": depois}


def _colher_desenho(page, palavras, a) -> dict:
    ancora, arect = _linha_ancora(page, palavras, a.rect)
    if not ancora:
        return {"ancora": None, "texto": None}
    ox, oy = arect.x0, arect.y0
    relativos = [[(p[0] - ox, p[1] - oy) for p in traco] for traco in a.vertices or []]
    return {"ancora": ancora, "ancora_largura": arect.width,
            "pontos": relativos, "texto": None}


def _colher_caixa(page, palavras, a) -> dict:
    ancora, arect = _linha_ancora(page, palavras, a.rect)
    if not ancora:
        return {"ancora": None, "texto": None}
    r = a.rect
    return {"ancora": ancora, "ancora_largura": arect.width,
            "caixa": [r.x0 - arect.x0, r.y0 - arect.y0,
                      r.x1 - arect.x0, r.y1 - arect.y0],
            "conteudo": (a.info or {}).get("content", ""),
            "tamanho_fonte": getattr(a, "font_size", None) or 11,
            "texto": None}


def colher(pdf: Path) -> list[dict]:
    """Todas as marcações de um PDF, em forma reancorável."""
    doc = pymupdf.open(pdf)
    marcas = []
    try:
        for pno in range(doc.page_count):
            page = doc[pno]
            anotacoes = list(page.annots() or [])
            if not anotacoes:
                continue
            palavras = _palavras(page)
            for a in anotacoes:
                nome = a.type[1]
                if nome not in SUPORTADOS:
                    continue
                if nome in TIPOS_TEXTO:
                    extra = _colher_texto(page, palavras, a)
                elif nome in TIPOS_DESENHO:
                    extra = _colher_desenho(page, palavras, a)
                else:
                    extra = _colher_caixa(page, palavras, a)
                m = _comum(a, pno)
                m.update(extra)
                marcas.append(m)
    finally:
        doc.close()
    return marcas


# ─────────────────────────────────────────────────────────────── procura

def _pontuar(page, palavras, rect, antes: str, depois: str) -> float:
    """Quanto o entorno deste candidato parece com o entorno original."""
    if not antes and not depois:
        return 0.5
    idx = _indices_sob(palavras, rect)
    if not idx:
        return 0.0
    i0, i1 = min(idx), max(idx)
    a = " ".join(w[4] for w in palavras[max(0, i0 - 8):i0])
    d = " ".join(w[4] for w in palavras[i1 + 1:i1 + 9])
    notas = []
    if antes:
        notas.append(SequenceMatcher(None, _normalizar(a), _normalizar(antes)).ratio())
    if depois:
        notas.append(SequenceMatcher(None, _normalizar(d), _normalizar(depois)).ratio())
    return sum(notas) / len(notas)


def _aproximar(page, palavras, alvo: str):
    """Melhor janela de palavras da página parecida com `alvo`."""
    n = max(1, len(alvo.split()))
    alvo_n = _normalizar(alvo)
    melhor = (0.0, None)
    for janela in {max(1, n - 2), max(1, n - 1), n, n + 1, n + 2}:
        for i in range(0, max(0, len(palavras) - janela) + 1):
            grupo = palavras[i:i + janela]
            frase = _normalizar(" ".join(w[4] for w in grupo))
            if not frase or abs(len(frase) - len(alvo_n)) > 0.45 * max(len(alvo_n), 1):
                continue
            sm = SequenceMatcher(None, frase, alvo_n)
            if sm.quick_ratio() < LIMIAR_SEMELHANCA:
                continue
            r = sm.ratio()
            if r > melhor[0]:
                melhor = (r, list(range(i, i + janela)))
    if melhor[1] and melhor[0] >= LIMIAR_SEMELHANCA:
        return melhor[0], _uniao(palavras, melhor[1])
    return 0.0, None


def _localizar(doc, cache, alvo: str, antes: str, depois: str, dica: int):
    """(pagina, rect, exata) do melhor lugar para `alvo` no documento."""
    ordem = sorted(range(doc.page_count), key=lambda p: abs(p - dica))
    candidatos = []
    for pno in ordem:
        page = doc[pno]
        achados = page.search_for(alvo)
        if not achados:
            continue
        palavras = cache.setdefault(pno, _palavras(page))
        for r in achados:
            nota = _pontuar(page, palavras, r, antes, depois)
            candidatos.append((nota - 0.002 * abs(pno - dica), pno, r))
    if candidatos:
        _, pno, r = max(candidatos, key=lambda c: c[0])
        return pno, r, True

    for pno in ordem:                      # nada exato: tenta por semelhança
        page = doc[pno]
        palavras = cache.setdefault(pno, _palavras(page))
        nota, r = _aproximar(page, palavras, alvo)
        if r:
            candidatos.append((nota - 0.002 * abs(pno - dica), pno, r))
    if candidatos:
        _, pno, r = max(candidatos, key=lambda c: c[0])
        return pno, r, False
    return None, None, False


def procurar_texto(pdf: Path, alvo: str) -> list[int]:
    """Páginas de outro PDF onde `alvo` aparece igual — para achar marcação que
    migrou de arquivo quando você move um trecho de um .md para outro."""
    doc = pymupdf.open(pdf)
    try:
        return [p for p in range(doc.page_count) if doc[p].search_for(alvo)]
    finally:
        doc.close()


# ─────────────────────────────────────────────────────────────── aplicação

@dataclass
class Relatorio:
    exatas: list = field(default_factory=list)
    aproximadas: list = field(default_factory=list)
    orfas: list = field(default_factory=list)

    @property
    def total(self):
        return len(self.exatas) + len(self.aproximadas) + len(self.orfas)


def _pintar(annot, m: dict):
    if m.get("cor"):
        annot.set_colors(stroke=m["cor"])
    if m.get("preenchimento"):
        try:
            annot.set_colors(fill=m["preenchimento"])
        except Exception:
            pass
    if m.get("opacidade") is not None:
        annot.set_opacity(m["opacidade"])
    # só quem desenha traço tem borda; pedir isso a um destaque só gera ruído
    if m.get("largura_traco") and m["tipo"] in (TIPOS_DESENHO | {"Square", "Circle"}):
        annot.set_border(width=m["largura_traco"])
    annot.set_info(content=m.get("nota", ""), title=m.get("autor", ""))
    annot.update()


def _aplicar_texto(doc, cache, m) -> str:
    segmentos = [s for s in (m.get("segmentos") or []) if s.strip()]
    if not segmentos:
        return "orfa"
    pno, rect, exata = _localizar(doc, cache, segmentos[0],
                                  m.get("antes", ""), m.get("depois", ""),
                                  m.get("pagina", 0))
    if rect is None:
        return "orfa"
    page = doc[pno]
    quads = [rect.quad]
    anterior = rect
    for seg in segmentos[1:]:               # linhas seguintes: logo abaixo
        seguintes = [r for r in page.search_for(seg) if r.y0 >= anterior.y0 - 1]
        if not seguintes:
            exata = False
            continue
        prox = min(seguintes, key=lambda r: (r.y0 - anterior.y1) ** 2 + (r.x0 - anterior.x0) ** 2)
        quads.append(prox.quad)
        anterior = prox
    annot = getattr(page, _ADICIONA[m["tipo"]])(quads)
    _pintar(annot, m)
    return "exata" if exata else "aproximada"


def _aplicar_desenho(doc, cache, m) -> str:
    if not m.get("ancora"):
        return "orfa"
    pno, rect, exata = _localizar(doc, cache, m["ancora"], "", "", m.get("pagina", 0))
    if rect is None:
        return "orfa"
    escala = 1.0
    if m.get("ancora_largura"):
        escala = min(ESCALA_MAX, max(ESCALA_MIN, rect.width / m["ancora_largura"]))
    ox, oy = rect.x0, rect.y0
    tracos = [[(ox + x * escala, oy + y * escala) for x, y in t] for t in m["pontos"]]
    tracos = [t for t in tracos if len(t) >= 2]
    if not tracos:
        return "orfa"
    page = doc[pno]          # segure a página: anotação de página solta se desvincula
    annot = page.add_ink_annot(tracos)
    _pintar(annot, m)
    return "exata" if exata else "aproximada"


def _aplicar_caixa(doc, cache, m) -> str:
    if not m.get("ancora"):
        return "orfa"
    pno, rect, exata = _localizar(doc, cache, m["ancora"], "", "", m.get("pagina", 0))
    if rect is None:
        return "orfa"
    page = doc[pno]
    cx, cy = rect.x0, rect.y0
    x0, y0, x1, y1 = m["caixa"]
    alvo = pymupdf.Rect(cx + x0, cy + y0, cx + x1, cy + y1)
    tipo = m["tipo"]
    if tipo == "FreeText":
        annot = page.add_freetext_annot(alvo, m.get("conteudo", ""),
                                        fontsize=m.get("tamanho_fonte") or 11,
                                        text_color=m.get("cor") or (0, 0, 0))
        annot.set_info(content=m.get("conteudo", ""), title=m.get("autor", ""))
        annot.update()
        return "exata" if exata else "aproximada"
    if tipo == "Text":
        annot = page.add_text_annot((alvo.x0, alvo.y0), m.get("nota", ""))
    elif tipo == "Square":
        annot = page.add_rect_annot(alvo)
    else:
        annot = page.add_circle_annot(alvo)
    _pintar(annot, m)
    return "exata" if exata else "aproximada"


def aplicar(pdf: Path, marcas: list[dict]) -> Relatorio:
    """Redesenha `marcas` no PDF (recém-gerado, sem anotação nenhuma)."""
    rel = Relatorio()
    if not marcas:
        return rel
    doc = pymupdf.open(pdf)
    cache: dict[int, list] = {}
    try:
        for m in marcas:
            tipo = m.get("tipo")
            try:
                if tipo in TIPOS_TEXTO:
                    desfecho = _aplicar_texto(doc, cache, m)
                elif tipo in TIPOS_DESENHO:
                    desfecho = _aplicar_desenho(doc, cache, m)
                elif tipo in TIPOS_CAIXA:
                    desfecho = _aplicar_caixa(doc, cache, m)
                else:
                    desfecho = "orfa"
            except Exception as e:            # uma marcação torta não derruba o lote
                m["erro"] = f"{type(e).__name__}: {e}"
                desfecho = "orfa"
            getattr(rel, {"exata": "exatas", "aproximada": "aproximadas",
                          "orfa": "orfas"}[desfecho]).append(m)
        if rel.exatas or rel.aproximadas:
            doc.save(pdf, incremental=True, encryption=pymupdf.PDF_ENCRYPT_KEEP)
    finally:
        doc.close()
    return rel
