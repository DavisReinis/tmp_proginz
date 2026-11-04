"""Ģenerē v2/assets/drawio/diagrammas.drawio no data.typ (bez noformējuma - tikai formas un bultas).

Palaišana (nepieciešams: pip install typst):
    python tools/gen_drawio.py
Katra diagramma ir atsevišķa lapa (tab) draw.io failā. Pēc sakārtošanas eksportējiet katru
lapu kā PNG uz assets/<nosaukums>.png (concept, logical, physical, dpd0, dpd1, dpd2-LM ... dpd2-AM);
main.typ izmanto tikai šos PNG. UZMANĪBU: skripta palaišana pārraksta draw.io failu un jūsu sakārtojumu.
"""
import json, os, sys
from xml.sax.saxutils import escape
import typst

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
raw = typst.query(os.path.join(HERE, "export.typ"), "<export>", field="value", one=True, root=ROOT)
D = json.loads(raw) if isinstance(raw, (str, bytes)) else raw

ENT = {e["name"]: e for e in D["entities"]}
FUN = {f["id"]: f for f in D["functions"]}
MOD = {m["key"]: m for m in D["modules"]}
ROLE = {r["key"]: r for r in D["roles"]}
EXT = {e["key"]: e for e in D["externals"]}


class Page:
    def __init__(self, name):
        self.name = name
        self.cells = []
        self.n = 1

    def _id(self):
        self.n += 1
        return f"c{self.n}"

    def vertex(self, label, x, y, w=140, h=40, style="rounded=0;whiteSpace=wrap;html=1;", parent="1"):
        i = self._id()
        self.cells.append(
            f'<mxCell id="{i}" value="{escape(label, {chr(34): "&quot;"})}" style="{style}" vertex="1" parent="{parent}">'
            f'<mxGeometry x="{x}" y="{y}" width="{w}" height="{h}" as="geometry"/></mxCell>')
        return i

    def edge(self, a, b, label="", style="endArrow=classic;html=1;", pos=None):
        i = self._id()
        seen = self.__dict__.setdefault("_pairs", set())
        if (b, a) in seen or (a, b) in seen:
            style += "curved=1;"
        seen.add((a, b))
        style += "labelBackgroundColor=#ffffff;fontSize=10;"
        self.cells.append(
            f'<mxCell id="{i}" value="{escape(label, {chr(34): "&quot;"})}" style="{style}" edge="1" parent="1" source="{a}" target="{b}">'
            f'<mxGeometry {"" if pos is None else f'x="{pos}" '}relative="1" as="geometry"/></mxCell>')
        return i

    def xml(self):
        body = "".join(self.cells)
        return (f'<diagram name="{escape(self.name)}" id="{escape(self.name)}"><mxGraphModel><root>'
                f'<mxCell id="0"/><mxCell id="1" parent="0"/>{body}</root></mxGraphModel></diagram>')


ACTOR = "rounded=0;whiteSpace=wrap;html=1;"
PROC = "ellipse;whiteSpace=wrap;html=1;"
EXTS = "ellipse;whiteSpace=wrap;html=1;dashed=1;"
STORE = "shape=partialRectangle;whiteSpace=wrap;html=1;left=0;right=0;fillColor=none;"
TBL = "rounded=0;whiteSpace=wrap;html=1;align=left;verticalAlign=top;spacingLeft=4;"
DIA = "rhombus;whiteSpace=wrap;html=1;"


# ------------------------------------------------------------ konceptuālais
def concept():
    p = Page("Konceptuālais modelis")
    pos = {"Lietotājs": (400, 300), "Interese": (400, 20), "Ieraksts": (800, 300), "Komentārs": (800, 20),
           "Ziņa": (20, 300), "Pasākums": (400, 620), "Sūdzība": (800, 620)}
    ids = {}
    for name, (x, y) in pos.items():
        e = ENT[name]
        attrs = "<br>".join(a["c"] for a in e["attrs"])
        ids[name] = p.vertex(f"<b>{name}</b><hr>{attrs}", x, y, 160, 30 + 16 * len(e["attrs"]), TBL)
    lk = {l["name"]: l for l in D["links"]}
    for i, r in enumerate(D["rels"]):
        extra = ""
        if r["name"] in lk and lk[r["name"]]["attrs"]:
            extra = "<br>" + ", ".join(a["c"] for a in lk[r["name"]]["attrs"])
        ax, ay = pos[r["a"]]
        bx, by = pos[r["b"]]
        d = p.vertex(r["name"] + extra, (ax + bx) // 2 + 60 + (i % 2) * 20, (ay + by) // 2 + 30 + (i % 3) * 25, 110, 50, DIA)
        p.edge(ids[r["a"]], d, r["ca"], "endArrow=none;html=1;")
        p.edge(d, ids[r["b"]], r["cb"], "endArrow=none;html=1;")
    return p


# ------------------------------------------------------ loģiskais / fiziskais
def tables():
    return D["entities"] + D["links"]


def cols_of(t):
    ents = ENT
    cols = []
    if "pk" in t:
        cols.append(("PK", t["pk"], "INTEGER", True))
        for f in t["fks"]:
            cols.append(("FK", f["col"], "INTEGER", f["nn"]))
    else:
        cols.append(("PK, FK", t["acol"], "INTEGER", True))
        cols.append(("PK, FK", t["bcol"], "INTEGER", True))
    for a in t["attrs"]:
        cols.append(("", a["col"], a["pg"], a["nn"]))
    return cols


def dbpage(physical):
    """Katra tabula ir konteiners, katra kolonna - atsevišķa šūna; ārējo atslēgu bultas
    iet no FK kolonnas uz atsauces tabulas PK kolonnu (nevis uz tabulu kopumā)."""
    p = Page("Fiziskais modelis" if physical else "Loģiskais modelis")
    pos = {"interese": (20, 20), "lietotajs_interese": (440, 20), "patik": (860, 20),
           "blokesana": (20, 240), "lietotajs": (440, 240), "ieraksts": (860, 240),
           "zina": (20, 420), "komentars": (860, 520),
           "sudziba": (20, 700), "daliba": (440, 700), "pasakums": (860, 760)}
    W = 400 if physical else 250
    KEYW, NAMEW = 64, 180
    CELLSTYLE = "text;html=1;align=left;verticalAlign=middle;spacingLeft=4;whiteSpace=nowrap;strokeColor=none;fillColor=none;"
    HEAD, ROWH = 26, 20
    HEADSTYLE = "swimlane;fontStyle=1;html=1;startSize=26;horizontal=1;whiteSpace=wrap;"
    ROWSTYLE = "rounded=0;html=1;strokeColor=#cccccc;fillColor=none;"
    rowid = {}
    for t in tables():
        cols = cols_of(t)
        x, y = pos[t["table"]]
        x = int(x * (1.3 if physical else 1.1))
        box = p.vertex(t["table"], x, y, W, HEAD + ROWH * len(cols), HEADSTYLE)
        for k, (key, name, pg, nn) in enumerate(cols):
            nm = f"<u>{name}</u>" if "PK" in key else name
            ty = f"{pg}{'' if nn else ' NULL'}"
            ry = HEAD + ROWH * k
            rowid[(t["table"], name)] = p.vertex("", 0, ry, W, ROWH, ROWSTYLE, parent=box)
            x0 = 0
            parts = [(key, KEYW), (nm, NAMEW)] + ([(ty, W - KEYW - NAMEW)] if physical else [])
            for j, (txt, w) in enumerate(parts):
                if j == len(parts) - 1:
                    w = W - x0
                p.vertex(txt, x0, ry, w, ROWH, CELLSTYLE, parent=box)
                x0 += w
    FK = "endArrow=ERmandOne;startArrow=ERmany;html=1;edgeStyle=entityRelationEdgeStyle;"
    for t in tables():
        if "pk" in t:
            for f in t["fks"]:
                tgt = ENT[f["ref"]]
                p.edge(rowid[(t["table"], f["col"])], rowid[(tgt["table"], tgt["pk"])], "", FK)
        else:
            a, b = ENT[t["a"]], ENT[t["b"]]
            p.edge(rowid[(t["table"], t["acol"])], rowid[(a["table"], a["pk"])], "", FK)
            p.edge(rowid[(t["table"], t["bcol"])], rowid[(b["table"], b["pk"])], "", FK)
    return p

# ------------------------------------------------------------------ DPD0/DPD1
def dpd0():
    p = Page("DPD0")
    g = p.vertex("Vieslietotājs", 20, 40, 150, 40, ACTOR)
    u = p.vertex("Reģistrēts lietotājs", 20, 240, 150, 40, ACTOR)
    a = p.vertex("Administrators", 20, 440, 150, 40, ACTOR)
    s = p.vertex("Ceļabiedru un domubiedru meklēšanas platforma", 380, 200, 220, 120, PROC)
    m = p.vertex("Karšu serviss", 800, 60, 150, 50, EXTS)
    k = p.vertex("Push paziņojumu serviss", 800, 400, 150, 50, EXTS)
    for x, lab_in, lab_out in [
        (g, "Reģistrācijas un pieslēgšanās dati", "Lietotnes informācija, pieslēgšanās rezultāts"),
        (u, "Profila dati, testa atbildes, ieraksti, ziņas, pasākumi, sūdzības", "Profila dati, saderīgie lietotāji, plūsma, ziņas, pasākumi, rezultāti un paziņojumi"),
        (a, "Pārvaldības dati (sūdzības, bloķēšana, intereses, satura dzēšana, profila pieprasījumi)", "Sūdzības, lietotāju un interešu dati"),
    ]:
        p.edge(x, s, lab_in)
        p.edge(s, x, lab_out)
    p.edge(s, m, "Kartes pieprasījums")
    p.edge(m, s, "Kartes dati")
    p.edge(s, k, "Paziņojuma dati")
    return p


def dpd1():
    p = Page("DPD1")
    g = p.vertex("Vieslietotājs", 20, 100, 150, 40, ACTOR)
    u = p.vertex("Reģistrēts lietotājs", 20, 400, 150, 40, ACTOR)
    a = p.vertex("Administrators", 20, 700, 150, 40, ACTOR)
    order = ["ZM", "LM", "SM", "SP", "AM", "PA"]
    mid = {}
    for i, k in enumerate(order):
        mid[k] = p.vertex(MOD[k]["name"], 450, 40 + i * 140, 190, 70, PROC)
    db = p.vertex("Datubāze", 900, 40, 160, 760, STORE)
    ps = p.vertex("Push paziņojumu serviss", 450, -100, 190, 50, EXTS)
    mp = p.vertex("Karšu serviss", 450, 900, 190, 50, EXTS)
    pairs = [
        (g, "LM", "Reģistrācijas un pieslēgšanās dati", "Lietotnes informācija, pieslēgšanās rezultāts"),
        (u, "LM", "Profila dati", "Profila dati"),
        (u, "SM", "Testa atbildes, meklēšanas kritēriji", "Testa rezultāts, saderīgie lietotāji"),
        (u, "SP", "Ieraksti, komentāri", "Plūsma"),
        (u, "ZM", "Ziņas", "Ziņas, paziņojumi"),
        (u, "PA", "Pasākumu dati, pieteikumi", "Pasākumi"),
        (u, "AM", "Sūdzības", "Sūdzības rezultāts"),
        (a, "LM", "Profila pieprasījumi", "Profila dati"),
        (a, "SP", "Satura dzēšanas dati", "Plūsma"),
        (a, "PA", "Satura dzēšanas dati", "Pasākumi"),
        (a, "AM", "Sūdzību, bloķēšanas un interešu dati", "Sūdzības, lietotāju un interešu dati"),
    ]
    off = {g: 0.55, u: 0.6, a: 0.35}
    for act, k, li, lo in pairs:
        p.edge(act, mid[k], li, pos=off[act])
        p.edge(mid[k], act, lo, pos=-off[act])
    dbl = {"LM": "Lietotāju dati", "SM": "Profila un interešu dati", "SP": "Ieraksti, komentāri, „patīk”",
           "ZM": "Ziņas, bloķēšanas dati", "PA": "Pasākumi, pieteikumi", "AM": "Sūdzības, intereses, konta statuss"}
    for k in order:
        p.edge(mid[k], db, dbl[k], "startArrow=classic;endArrow=classic;html=1;")
    p.edge(mid["PA"], mp, "Kartes pieprasījums")
    p.edge(mp, mid["PA"], "Kartes dati")
    p.edge(mid["ZM"], ps, "Paziņojuma dati")
    p.edge(mid["PA"], mid["ZM"], "Paziņojuma pieprasījums")
    return p


# ------------------------------------------------------------------------ DPD2
def dpd2(modkey):
    p = Page("DPD2 " + MOD[modkey]["name"])
    fs = [f for f in D["functions"] if f["mod"] == modkey]
    aroles = [r for r in ("GUEST", "USER", "ADM") if any(r in f["roles"] for f in fs)]
    st = []
    for f in fs:
        for d in f["db"]:
            if d[0] not in st:
                st.append(d[0])
    exs = [e for e in D["externals"] if any(x["key"] == e["key"] for f in fs for x in f["ext"])]
    ids = {}
    GAP = 120
    def mean_y(idxs):
        return sum(idxs) / len(idxs) * GAP if idxs else 0
    def spread(items, mingap):
        res, prev = {}, -10**6
        for key, y in sorted(items, key=lambda t: t[1]):
            y = max(y, prev + mingap)
            res[key] = y
            prev = y
        return res
    ay = spread([(r, mean_y([i for i, f in enumerate(fs) if r in f["roles"]])) for r in aroles], 160)
    sy = spread([(s, mean_y([i for i, f in enumerate(fs) if any(d[0] == s for d in f["db"])])) for s in st], 110)
    ey = spread([(e["key"], mean_y([i for i, f in enumerate(fs) if any(x["key"] == e["key"] for x in f["ext"])])) for e in exs], 140)
    for r in aroles:
        ids[r] = p.vertex(ROLE[r]["name"], 20, 20 + ay[r], 170, 44, ACTOR)
    for i, f in enumerate(fs):
        ids[f["id"]] = p.vertex(f"{f['id']}<br>{f['name']}", 500, 20 + i * GAP, 220, 76, PROC)
    for s in st:
        ids["s-" + s] = p.vertex(s, 1000, 30 + sy[s], 170, 44, STORE)
    for e in exs:
        ids["e-" + e["key"]] = p.vertex(e["name"], 1330, 30 + ey[e["key"]], 180, 54, EXTS)
    foreign = []
    for f in fs:
        for c in f["calls"]:
            if FUN[c]["mod"] != modkey and c not in foreign:
                foreign.append(c)
                ids["x-" + c] = p.vertex(f"{c}<br>{FUN[c]['name']} ({MOD[FUN[c]['mod']]['short']})", 500, 20 + (len(fs) + len(foreign) - 1) * GAP, 220, 76, EXTS)
    for f in fs:
        for r in f["roles"]:
            if r == "SYS":
                continue
            off = {"GUEST": 0.5, "USER": 0.62, "ADM": 0.36}[r]
            p.edge(ids[r], ids[f["id"]], f["fin"] or "", pos=off)
            p.edge(ids[f["id"]], ids[r], f["fout"] or "", pos=-off)
        for d in f["db"]:
            l = d[1]
            has_r = "R" in l
            has_w = any(c in l for c in "CUD")
            style = ("startArrow=classic;endArrow=classic;" if has_r and has_w else "startArrow=classic;endArrow=none;" if has_r else "endArrow=classic;") + "html=1;"
            p.edge(ids[f["id"]], ids["s-" + d[0]], d[2], style, pos=-0.4)
        for x in f["ext"]:
            p.edge(ids[f["id"]], ids["e-" + x["key"]], x["fout"] or "", pos=-0.4)
            if x["fin"]:
                p.edge(ids["e-" + x["key"]], ids[f["id"]], x["fin"], pos=0.4)
        for c in f["calls"]:
            key = c if FUN[c]["mod"] == modkey else "x-" + c
            p.edge(ids[f["id"]], ids[c] if FUN[c]["mod"] == modkey else ids["x-" + c], "Paziņojuma dati" if FUN[c]["mod"] == modkey else "Paziņojuma pieprasījums", "endArrow=classic;dashed=1;html=1;")
    return p


pages = [concept(), dbpage(False), dbpage(True), dpd0(), dpd1()] + [dpd2(m["key"]) for m in D["modules"]]
out_dir = os.path.join(ROOT, "assets", "drawio")
os.makedirs(out_dir, exist_ok=True)
out = os.path.join(out_dir, "diagrammas.drawio")
with open(out, "w", encoding="utf-8") as fh:
    fh.write('<mxfile host="app.diagrams.net">' + "".join(p.xml() for p in pages) + "</mxfile>")
print("OK", out, len(pages), "lapas")
