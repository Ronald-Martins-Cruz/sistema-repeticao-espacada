"""Um Edge headless de pé, recebendo HTML e devolvendo PDF pelo DevTools Protocol.

Subir o browser custa ~2s; imprimir uma página custa ~0,9s. Manter uma única
instância viva durante o lote é o que faz a diferença entre 66s e 14s para o
repositório inteiro.
"""

from __future__ import annotations

import base64
import json
import os
import shutil
import socket
import subprocess
import tempfile
import time
import urllib.request
from pathlib import Path

import websocket

CAMINHOS_EDGE = [
    r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
    r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
]

# A4 em polegadas, que é a unidade do Page.printToPDF.
A4_LARGURA, A4_ALTURA = 8.27, 11.69

RODAPE = """
<div style="font-size:7.5pt;color:#999;width:100%;margin:0 14mm;
            font-family:'Segoe UI',sans-serif;display:flex;
            justify-content:space-between;">
  <span class="title"></span>
  <span><span class="pageNumber"></span> / <span class="totalPages"></span></span>
</div>
"""


def achar_edge() -> str:
    for c in CAMINHOS_EDGE:
        if os.path.exists(c):
            return c
    raise RuntimeError(
        "msedge.exe não encontrado. Procurei em:\n  " + "\n  ".join(CAMINHOS_EDGE)
    )


def _porta_livre() -> int:
    with socket.socket() as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]


class Edge:
    """Context manager: `with Edge() as e: e.imprimir(html, pdf)`."""

    def __init__(self, timeout: float = 60.0):
        self.timeout = timeout
        self.proc = None
        self.ws = None
        self.perfil = None
        self._id = 0
        self._respostas: dict[int, dict] = {}
        self._eventos: list[dict] = []

    # ---------------------------------------------------------------- ciclo
    def __enter__(self) -> "Edge":
        porta = _porta_livre()
        self.perfil = tempfile.mkdtemp(prefix="mdpdf-edge-")
        self.proc = subprocess.Popen(
            [
                achar_edge(), "--headless", "--disable-gpu", "--no-first-run",
                "--no-default-browser-check", "--disable-extensions",
                f"--user-data-dir={self.perfil}",
                f"--remote-debugging-port={porta}",
                "--remote-allow-origins=*", "about:blank",
            ],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
        )
        url = self._esperar_browser(porta)
        self.ws = websocket.create_connection(url, timeout=self.timeout)
        alvo = self._cmd("Target.createTarget", {"url": "about:blank"})["targetId"]
        self.sessao = self._cmd(
            "Target.attachToTarget", {"targetId": alvo, "flatten": True}
        )["sessionId"]
        self._cmd("Page.enable", sessao=self.sessao)
        return self

    def __exit__(self, *_):
        try:
            if self.ws:
                self.ws.close()
        except Exception:
            pass
        if self.proc:
            self.proc.terminate()
            try:
                self.proc.wait(timeout=10)
            except subprocess.TimeoutExpired:
                self.proc.kill()
        if self.perfil:
            shutil.rmtree(self.perfil, ignore_errors=True)

    def _esperar_browser(self, porta: int) -> str:
        limite = time.monotonic() + 30
        while time.monotonic() < limite:
            if self.proc.poll() is not None:
                raise RuntimeError("o Edge morreu antes de abrir a porta de depuração")
            try:
                with urllib.request.urlopen(
                    f"http://127.0.0.1:{porta}/json/version", timeout=1
                ) as r:
                    return json.load(r)["webSocketDebuggerUrl"]
            except Exception:
                time.sleep(0.05)
        raise RuntimeError("o Edge não subiu em 30s")

    # ------------------------------------------------------------------ CDP
    def _ler(self):
        msg = json.loads(self.ws.recv())
        if "id" in msg:
            self._respostas[msg["id"]] = msg
        else:
            self._eventos.append(msg)

    def _cmd(self, metodo: str, params: dict | None = None, sessao: str | None = None):
        self._id += 1
        meu = self._id
        pedido = {"id": meu, "method": metodo, "params": params or {}}
        if sessao:
            pedido["sessionId"] = sessao
        self.ws.send(json.dumps(pedido))
        limite = time.monotonic() + self.timeout
        while meu not in self._respostas:
            if time.monotonic() > limite:
                raise TimeoutError(f"sem resposta para {metodo}")
            self._ler()
        resp = self._respostas.pop(meu)
        if "error" in resp:
            raise RuntimeError(f"{metodo}: {resp['error']}")
        return resp.get("result", {})

    def _esperar_evento(self, nome: str, timeout: float = 60.0):
        limite = time.monotonic() + timeout
        while True:
            for i, ev in enumerate(self._eventos):
                if ev.get("method") == nome:
                    return self._eventos.pop(i)
            if time.monotonic() > limite:
                raise TimeoutError(f"o evento {nome} não veio")
            self._ler()

    # ---------------------------------------------------------------- ação
    def imprimir(self, html: Path, pdf: Path, titulo: str = "") -> None:
        self._eventos.clear()
        self._cmd("Page.navigate", {"url": html.resolve().as_uri()}, self.sessao)
        self._esperar_evento("Page.loadEventFired", self.timeout)
        resultado = self._cmd(
            "Page.printToPDF",
            {
                "printBackground": True,
                "paperWidth": A4_LARGURA, "paperHeight": A4_ALTURA,
                "marginTop": 0.63, "marginBottom": 0.63,
                "marginLeft": 0.55, "marginRight": 0.55,
                "displayHeaderFooter": True,
                "headerTemplate": "<span></span>",
                "footerTemplate": RODAPE,
            },
            self.sessao,
        )
        pdf.parent.mkdir(parents=True, exist_ok=True)
        pdf.write_bytes(base64.b64decode(resultado["data"]))
