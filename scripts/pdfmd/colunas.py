"""Ordem de leitura de páginas em duas colunas separadas por um fio vertical.

Caderno de prova quase sempre vem em duas colunas com um fio no meio da página:
o texto corre de cima a baixo na coluna da esquerda e só então recomeça no topo
da direita. O pymupdf4llm não enxerga esse fio — agrupa os blocos por
proximidade e acaba costurando as alternativas de uma questão dentro de outra.
Não é só ordem trocada: é enunciado partido e conteúdo de questões misturado.

Aqui a página é lida como o olho lê. Acha-se o fio; separa-se a página em
faixas horizontais — o que **cruza** o fio é de largura cheia (cabeçalho,
rodapé, título de seção, figura larga), o que não cruza é conteúdo de coluna —
e devolve-se a lista de retângulos já na ordem certa. É só geometria: quem
chama (`extract`) é que decide o que fazer com ela.

Duas invariantes, nessa ordem de importância:

1. **Nenhum retângulo corta um bloco ao meio.** As fronteiras entre faixas caem
   sempre no vão em branco entre blocos, e as faixas cobrem a página inteira —
   nada se perde entre uma e outra.
2. Na dúvida, faixa de largura cheia. Quando as faixas se sobrepõem
   verticalmente (não dá para separá-las por uma linha horizontal), elas viram
   uma só, cheia — que é o comportamento antigo, no pior caso.
"""

from __future__ import annotations

import pymupdf

# Um fio de divisória é fino, alto e cai perto do meio horizontal da página.
LARGURA_MAXIMA_FIO = 6.0        # pt
ALTURA_MINIMA_FIO = 0.25        # fração da altura da página
FAIXA_CENTRAL = (0.35, 0.65)    # onde o centro do fio precisa cair, em fração da largura

# Folga ao decidir de que lado do fio o bloco está. Pequena de propósito: em
# prova da Cebraspe o texto chega a 3pt do fio, e uma folga generosa faria todo
# bloco "cruzar" o fio — o que desligaria a separação em colunas.
FOLGA = 1.0                     # pt

TAMANHO_MINIMO_GRAFICO = 4.0    # pt: risco de vetor menor que isso não delimita nada


def _fio(pagina: pymupdf.Page) -> pymupdf.Rect | None:
    """O fio vertical que divide a página em duas colunas, ou `None`.

    Fica com o mais alto dos candidatos. A exigência de centralidade é o que
    descarta bordas e filetes laterais — a capa da prova costuma ter um fio alto
    junto à margem direita, que não divide coisa nenhuma.
    """
    caixa = pagina.rect
    melhor = None
    for desenho in pagina.get_drawings():
        r = desenho["rect"]
        if r.width > LARGURA_MAXIMA_FIO or r.height < caixa.height * ALTURA_MINIMA_FIO:
            continue
        centro = ((r.x0 + r.x1) / 2 - caixa.x0) / caixa.width
        if not FAIXA_CENTRAL[0] <= centro <= FAIXA_CENTRAL[1]:
            continue
        if melhor is None or r.height > melhor.height:
            melhor = r
    return melhor


def _blocos(pagina: pymupdf.Page, fio: pymupdf.Rect) -> list[pymupdf.Rect]:
    """Tudo que ocupa espaço na página: blocos de texto, imagens e desenhos.

    Imagens e desenhos entram junto do texto porque as fronteiras entre faixas
    são cortes de verdade: uma figura que ficasse a cavalo de duas faixas sairia
    partida em dois pedaços.
    """
    saida = [
        pymupdf.Rect(b[:4])
        for b in pagina.get_text("blocks")
        if b[6] == 0 and b[4].strip()
    ]
    saida += [pymupdf.Rect(img["bbox"]) for img in pagina.get_image_info()]

    fio_folgado = pymupdf.Rect(fio) + (-FOLGA, -FOLGA, FOLGA, FOLGA)
    for r in pagina.cluster_drawings():
        if r.width < TAMANHO_MINIMO_GRAFICO and r.height < TAMANHO_MINIMO_GRAFICO:
            continue
        if r in fio_folgado:            # o próprio fio
            continue
        if fio in r:                    # moldura em volta da mancha inteira
            continue
        saida.append(r)
    return saida


def _faixas(blocos: list[tuple[pymupdf.Rect, bool]]) -> list[tuple[float, float, bool]]:
    """Agrupa os blocos, de cima para baixo, em faixas `(y0, y1, largura_cheia)`.

    Blocos que cruzam o fio são o que separa uma faixa de colunas da seguinte:
    tudo que fica entre dois deles é conteúdo de coluna, não importa de que lado
    esteja. Faixas que acabem se sobrepondo em y não podem ser separadas por uma
    linha horizontal, então se fundem numa faixa de largura cheia.
    """
    fatias: list[tuple[float, float, bool]] = []
    for r, cheia in sorted(blocos, key=lambda item: (item[0].y0, item[0].x0)):
        if fatias and fatias[-1][2] == cheia:
            y0, y1, _ = fatias[-1]
            fatias[-1] = (min(y0, r.y0), max(y1, r.y1), cheia)
        else:
            fatias.append((r.y0, r.y1, cheia))

    juntadas: list[tuple[float, float, bool]] = []
    for y0, y1, cheia in fatias:
        if juntadas and y0 < juntadas[-1][1]:
            anterior = juntadas[-1]
            juntadas[-1] = (min(anterior[0], y0), max(anterior[1], y1), True)
        else:
            juntadas.append((y0, y1, cheia))
    return juntadas


def regioes(pagina: pymupdf.Page) -> list[pymupdf.Rect] | None:
    """Retângulos da página na ordem de leitura, ou `None` se ela for de coluna única.

    `None` quer dizer "não mexe": quem chama extrai a página inteira de uma vez,
    como sempre fez. Só páginas com fio no meio *e* conteúdo dos dois lados
    ganham lista.
    """
    fio = _fio(pagina)
    if fio is None:
        return None

    blocos = _blocos(pagina, fio)
    if not blocos:
        return None

    limite_esquerdo, limite_direito = fio.x0 - FOLGA, fio.x1 + FOLGA
    marcados = [(r, r.x0 < limite_esquerdo and r.x1 > limite_direito) for r in blocos]
    faixas = _faixas(marcados)

    # As fronteiras caem no meio do vão entre uma faixa e a seguinte, e as
    # pontas vão até a borda: juntas, as faixas cobrem a página inteira.
    caixa = pagina.rect
    fronteiras = [caixa.y0]
    fronteiras += [(a[1] + b[0]) / 2 for a, b in zip(faixas, faixas[1:])]
    fronteiras.append(caixa.y1)

    saida: list[pymupdf.Rect] = []
    dividiu = False
    for (_, _, cheia), topo, base in zip(faixas, fronteiras, fronteiras[1:]):
        if cheia:
            saida.append(pymupdf.Rect(caixa.x0, topo, caixa.x1, base))
            continue
        esquerda = pymupdf.Rect(caixa.x0, topo, fio.x0, base)
        direita = pymupdf.Rect(fio.x1, topo, caixa.x1, base)
        lados = [c for c in (esquerda, direita)
                 if any(r.intersects(c) for r, _ in marcados)]
        saida += lados
        dividiu = dividiu or len(lados) == 2

    return saida if dividiu else None
