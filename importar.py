#!/usr/bin/env python3
"""Importa perguntas.md para estudo.db.

Idempotente: pode rodar toda vez que voce editar o markdown.
A chave natural e o codigo da pergunta ('Q94'), entao o historico de
respostas sobrevive a edicoes, reordenacoes e insercoes no arquivo.

  - pergunta nova            -> INSERT (o trigger ja cria o agendamento)
  - enunciado alterado       -> UPDATE do texto e do hash, historico intacto
  - pergunta sumiu do .md    -> ativa = 0 (nunca DELETE)
  - pergunta reapareceu      -> ativa = 1

Sem dependencias: so a biblioteca padrao.
"""

from __future__ import annotations

import hashlib
import re
import sqlite3
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parent
FONTE = RAIZ / "perguntas.md"
BANCO = RAIZ / "estudo.db"

# Espelha o CHECK da coluna pergunta.profundidade no schema. Validar aqui
# transforma um "CHECK constraint failed" cru, no meio do loop de gravacao,
# num erro que aponta a pergunta e o valor exatos.
PROFUNDIDADES = {"D0", "D1", "D2", "D3", "D4", "D5"}

RE_PARTE = re.compile(r"^# PARTE (I{1,2}) ")
RE_SECAO = re.compile(r"^## (\d+\.\d+) +(.+?)\s*$")
RE_PERGUNTA = re.compile(r"^\*\*Q(\d+)\.\*\* *")
RE_TAG_PROVA = re.compile(r"`\[prova (Q\d+)\]`")
RE_TAG_DISTRATOR = re.compile(r"`\[distrator\]`")
RE_TAG_CASO = re.compile(r"`\[caso\]`")
RE_TAG_PROF = re.compile(r"`\[prof: ([^\]]+)\]`")


def desdobrar(linhas: list[str]) -> str:
    """Junta as quebras de linha do markdown, preservando listas.

    O arquivo e quebrado em ~79 colunas. Reflui os paragrafos para uma linha
    so, mas mantem cada item de lista separado — ha perguntas cuja estrutura
    de alternativas (a)/(b)/(c) e parte do enunciado.
    """
    blocos: list[str] = []
    atual: list[str] = []
    em_lista = False

    for linha in linhas:
        despida = linha.strip()
        if not despida:
            if atual:
                blocos.append(" ".join(atual))
                atual = []
            em_lista = False
            continue
        if despida.startswith("- "):
            if atual:
                blocos.append(" ".join(atual))
            atual = [despida]
            em_lista = True
        elif em_lista and linha.startswith("  "):
            atual.append(despida)  # continuacao do item
        else:
            if em_lista and atual:
                blocos.append(" ".join(atual))
                atual = []
                em_lista = False
            atual.append(despida)

    if atual:
        blocos.append(" ".join(atual))
    return "\n".join(blocos).strip()


def analisar(texto: str) -> tuple[list[dict], list[dict]]:
    """Le o markdown e devolve (secoes, perguntas)."""
    secoes: list[dict] = []
    perguntas: list[dict] = []

    parte = None
    secao_atual = None
    numero = None
    buffer: list[str] = []

    def fechar():
        if numero is None:
            return
        if secao_atual is None:
            raise ValueError(f"Q{numero} aparece fora de qualquer secao")

        bruto = desdobrar(buffer)

        # A coluna tag_prova guarda uma ancora so. Se a pergunta cobre duas
        # questoes da prova, avisa e mantem a primeira — silencio aqui vira
        # peso_prova subcontado e questao da prova sem ancora no banco.
        provas = RE_TAG_PROVA.findall(bruto)
        tag_prova = provas[0] if provas else None
        if len(provas) > 1:
            print(f"AVISO: Q{numero} tem varias tags [prova] "
                  f"({', '.join(provas)}); o schema guarda so a primeira.",
                  file=sys.stderr)
        eh_distrator = 1 if RE_TAG_DISTRATOR.search(bruto) else 0
        eh_caso = 1 if RE_TAG_CASO.search(bruto) else 0
        profundidade = None
        m = RE_TAG_PROF.search(bruto)
        if m:
            profundidade = m.group(1)

        # As tags saem do enunciado: sao metadado, e mostrar "[distrator]"
        # antes de voce responder ja entrega metade da pergunta.
        enunciado = RE_TAG_PROVA.sub("", bruto)
        enunciado = RE_TAG_DISTRATOR.sub("", enunciado)
        enunciado = RE_TAG_CASO.sub("", enunciado)
        enunciado = RE_TAG_PROF.sub("", enunciado)
        enunciado = re.sub(r"[ \t]{2,}", " ", enunciado).strip()

        perguntas.append(
            {
                "codigo": f"Q{numero}",
                "numero": numero,
                "secao": secao_atual,
                "enunciado": enunciado,
                "hash": hashlib.sha256(enunciado.encode("utf-8")).hexdigest(),
                "tag_prova": tag_prova,
                "eh_distrator": eh_distrator,
                "eh_caso": eh_caso,
                "profundidade": profundidade,
            }
        )

    for linha in texto.splitlines():
        m = RE_PARTE.match(linha)
        if m:
            fechar()
            numero, buffer = None, []
            parte = m.group(1)
            continue

        m = RE_SECAO.match(linha)
        if m:
            fechar()
            numero, buffer = None, []
            secao_atual = m.group(1)
            secoes.append(
                {
                    "codigo": m.group(1),
                    "titulo": m.group(2),
                    "parte": parte or "I",
                    "ordem": len(secoes) + 1,
                }
            )
            continue

        # linha de corte entre secoes
        if linha.strip() == "---":
            fechar()
            numero, buffer = None, []
            continue

        m = RE_PERGUNTA.match(linha)
        if m:
            fechar()
            numero = int(m.group(1))
            buffer = [RE_PERGUNTA.sub("", linha)]
            continue

        if numero is not None:
            buffer.append(linha)

    fechar()
    return secoes, perguntas


def gravar(secoes: list[dict], perguntas: list[dict]) -> dict[str, int]:
    con = sqlite3.connect(BANCO)
    con.execute("PRAGMA foreign_keys = ON")
    cur = con.cursor()
    stats = {"secoes": 0, "novas": 0, "atualizadas": 0, "inalteradas": 0,
             "desativadas": 0, "reativadas": 0}

    for s in secoes:
        cur.execute(
            """INSERT INTO secao (parte, codigo, titulo, ordem) VALUES (?,?,?,?)
               ON CONFLICT(codigo) DO UPDATE SET
                 parte=excluded.parte, titulo=excluded.titulo, ordem=excluded.ordem""",
            (s["parte"], s["codigo"], s["titulo"], s["ordem"]),
        )
        stats["secoes"] += 1

    ids_secao = dict(cur.execute("SELECT codigo, id FROM secao").fetchall())
    existentes = {
        cod: (pid, h, ativa, prof, tagp, distr, caso)
        for cod, pid, h, ativa, prof, tagp, distr, caso in cur.execute(
            "SELECT codigo, id, enunciado_hash, ativa, profundidade, "
            "tag_prova, eh_distrator, eh_caso FROM pergunta"
        )
    }

    for p in perguntas:
        secao_id = ids_secao[p["secao"]]
        atual = existentes.get(p["codigo"])
        if atual is None:
            cur.execute(
                """INSERT INTO pergunta
                     (codigo, numero, secao_id, enunciado, enunciado_hash,
                      tag_prova, eh_distrator, eh_caso, profundidade)
                   VALUES (?,?,?,?,?,?,?,?,?)""",
                (p["codigo"], p["numero"], secao_id, p["enunciado"], p["hash"],
                 p["tag_prova"], p["eh_distrator"], p["eh_caso"],
                 p["profundidade"]),
            )
            stats["novas"] += 1
            continue

        # As tags (profundidade, tag_prova, distrator, caso) saem do enunciado
        # ANTES do hash, entao editar so uma tag nao muda o hash. Todas elas
        # precisam entrar na comparacao, senao a edicao seria ignorada aqui.
        _pid, hash_antigo, ativa, prof_antiga, tagp_antiga, distr_antigo, caso_antigo = atual
        inalterada = (
            hash_antigo == p["hash"] and ativa == 1
            and prof_antiga == p["profundidade"]
            and tagp_antiga == p["tag_prova"]
            and distr_antigo == p["eh_distrator"]
            and caso_antigo == p["eh_caso"]
        )
        if inalterada:
            stats["inalteradas"] += 1
            continue

        cur.execute(
            """UPDATE pergunta SET
                 numero=?, secao_id=?, enunciado=?, enunciado_hash=?,
                 tag_prova=?, eh_distrator=?, eh_caso=?, profundidade=?, ativa=1,
                 atualizada_em=datetime('now','localtime')
               WHERE codigo=?""",
            (p["numero"], secao_id, p["enunciado"], p["hash"], p["tag_prova"],
             p["eh_distrator"], p["eh_caso"], p["profundidade"], p["codigo"]),
        )
        if ativa == 0:
            stats["reativadas"] += 1
        else:
            stats["atualizadas"] += 1

    no_arquivo = {p["codigo"] for p in perguntas}
    for cod, (_pid, _h, ativa, *_meta) in existentes.items():
        if cod not in no_arquivo and ativa == 1:
            cur.execute("UPDATE pergunta SET ativa=0 WHERE codigo=?", (cod,))
            stats["desativadas"] += 1

    # peso_prova = quantas questoes da prova real aquela secao cobre.
    # Derivado, nunca mantido a mao.
    cur.execute(
        """UPDATE secao SET peso_prova = (
             SELECT COUNT(DISTINCT p.tag_prova) FROM pergunta p
             WHERE p.secao_id = secao.id AND p.ativa = 1 AND p.tag_prova IS NOT NULL
           )"""
    )

    con.commit()
    con.close()
    return stats


def main() -> int:
    if not BANCO.exists():
        print(f"ERRO: {BANCO.name} nao existe. Restaure do git:")
        print(f"  git restore {BANCO.name}")
        return 1
    if not FONTE.exists():
        print(f"ERRO: {FONTE.name} nao encontrado.")
        return 1

    secoes, perguntas = analisar(FONTE.read_text(encoding="utf-8"))

    invalidas = [
        p for p in perguntas
        if p["profundidade"] is not None and p["profundidade"] not in PROFUNDIDADES
    ]
    if invalidas:
        print("ERRO: profundidade fora da escala D0-D5 (ver perguntas.md):")
        for p in invalidas:
            print(f"  {p['codigo']}: [prof: {p['profundidade']}]")
        print(f"aceitos: {', '.join(sorted(PROFUNDIDADES))}")
        return 1

    stats = gravar(secoes, perguntas)

    print(f"secoes         {stats['secoes']}")
    print(f"perguntas      {len(perguntas)}")
    print(f"  novas        {stats['novas']}")
    print(f"  atualizadas  {stats['atualizadas']}")
    print(f"  reativadas   {stats['reativadas']}")
    print(f"  inalteradas  {stats['inalteradas']}")
    print(f"  desativadas  {stats['desativadas']}")
    return 0


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8")
    except Exception:
        pass
    raise SystemExit(main())
