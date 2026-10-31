"""Renderiza sinais de uma captura real VCD; sem biblioteca gráfica externa."""

from pathlib import Path
import html, re

root = Path(__file__).resolve().parents[1]
vcd = root / "build/double_dabble.vcd"
if not vcd.exists():
    raise SystemExit("Execute scripts/verificar.py primeiro")
nomes = {}
mudancas = {}
tempo = 0
for line in vcd.read_text(encoding="utf-8").splitlines():
    if line.startswith("$var"):
        p = line.split()
        nomes[p[3]] = p[4]
        mudancas[p[3]] = []
    elif line.startswith("#"):
        tempo = int(line[1:])
    elif line and line[0] in "01xXzZ" and line[1:] in nomes:
        mudancas[line[1:]].append((tempo, line[0]))
    elif line.startswith("b"):
        p = line.split()
        if len(p) == 2 and p[1] in nomes:
            mudancas[p[1]].append((tempo, p[0][1:]))
limite = 400000  # picosegundos: reset, captura e conversão do exemplo 42.
svg = [
    '<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="440" viewBox="0 0 1200 440"><rect width="1200" height="440" fill="#101c2e"/><text x="25" y="30" fill="white" font-size="19" font-family="sans-serif">Double-Dabble · captura real do exemplo 42</text>'
]


def x(t):
    return 145 + 1000 * t / limite


for tick in range(0, 401, 50):
    xx = x(tick * 1000)
    svg.append(
        f'<path d="M{xx:.2f} 45V365" stroke="#2b3e58"/><text x="{xx:.2f}" y="390" fill="#bbc8dc" font-family="sans-serif" font-size="12">{tick} ns</text>'
    )
for row, (code, nome) in enumerate(nomes.items()):
    y = 65 + row * 43
    svg.append(
        f'<text x="20" y="{y+4}" fill="white" font-family="sans-serif" font-size="14">{html.escape(nome)}</text>'
    )
    vals = [(t, v) for t, v in mudancas[code] if t <= limite]
    for i, (t, v) in enumerate(vals):
        fim = vals[i + 1][0] if i + 1 < len(vals) else limite
        if fim <= t:
            continue
        if nome in ["clk", "rst", "start", "done"]:
            yy = y - 10 if v == "1" else y + 10
            svg.append(
                f'<path d="M{x(t):.2f} {yy}H{x(fim):.2f}" stroke="#52d6bf" fill="none" stroke-width="2"/>'
            )
            if i:
                svg.append(f'<path d="M{x(t):.2f} {y-10}V{y+10}" stroke="#52d6bf"/>')
        else:
            label = hex(int(v, 2))[2:].upper() if re.fullmatch("[01]+", v) else "X"
            svg.append(
                f'<path d="M{x(t):.2f} {y-10}H{x(fim):.2f}M{x(t):.2f} {y+10}H{x(fim):.2f}" stroke="#70aaff"/>'
            )
            if fim - t >= 8000:
                svg.append(
                    f'<text x="{x(t)+3:.2f}" y="{y+4}" fill="#dce8ff" font-family="monospace" font-size="11">{label}</text>'
                )
# A última janela de WAIT é curta: destaca valores realmente lidos do VCD.
ultimos = {}
for code, nome in nomes.items():
    validos = [v for t, v in mudancas[code] if t <= limite and re.fullmatch("[01]+", v)]
    if validos:
        ultimos[nome] = int(validos[-1], 2)
rodape = f"Últimos valores válidos da captura: BCD=0x{ultimos['bcd']:X}; done={ultimos['done']}; state={ultimos['state']} (WAIT)"
svg.append(
    f'<text x="25" y="430" fill="#dce8ff" font-family="sans-serif" font-size="15">{html.escape(rodape)}</text>'
)
svg.append("</svg>")
(root / "assets").mkdir(exist_ok=True)
(root / "assets/double_dabble_42.svg").write_text("".join(svg), encoding="utf-8")
# Retira apenas a data do host para evitar metadado não determinístico.
conteudo = re.sub(r"\$date.*?\$end\n", "", vcd.read_text(encoding="utf-8"), flags=re.S)
(root / "assets/double_dabble_42.vcd").write_text(conteudo, encoding="utf-8")
print("PASS: SVG derivado de VCD real")
