"""v1 datubāzes loģiskais un fiziskais modelis (draw.io) no db.typ.

    python tools/gen_db_drawio.py          (nepieciešams: pip install typst)

Izveido assets/drawio/db_modeli.drawio ar divām lapām (Loģiskais, Fiziskais).
Eksportējiet katru lapu kā PNG uz assets/db_logical.png un assets/db_physical.png.
UZMANĪBU: palaišana pārraksta draw.io failu un jūsu sakārtojumu.
"""
import json, os
from xml.sax.saxutils import escape
import typst

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
raw = typst.query(os.path.join(ROOT, "db.typ"), "<db1export>", field="value", one=True, root=ROOT)
T = json.loads(raw) if isinstance(raw, (str, bytes)) else raw

POS = {
    "interese": (20, 20), "lietotajs_interese": (440, 20),
    "valoda": (20, 140), "lietotajs_valoda": (440, 140),
    "mbti_rezultats": (440, 260), "saderiba": (440, 400),
    "saruna": (440, 580), "seko": (440, 770), "blokesana": (440, 880),
    "zina": (20, 580),
    "lietotajs": (860, 300),
    "ieraksts": (1280, 20), "komentars": (1280, 170), "medija_fails": (1280, 330),
    "ieraksta_patik": (1280, 520), "kopigosana": (1280, 640),
    "lokacija": (860, 960), "tiksanas": (1280, 780), "tiksanas_dalibnieks": (860, 1180),
    "celojuma_grupa": (1280, 1030), "grupas_dalibnieks": (860, 1300),
}
HEAD, ROWH = 26, 20
KEYW, NAMEW = 64, 170
CELLSTYLE = "text;html=1;align=left;verticalAlign=middle;spacingLeft=4;whiteSpace=nowrap;strokeColor=none;fillColor=none;"
HEADSTYLE = "swimlane;fontStyle=1;html=1;startSize=26;horizontal=1;whiteSpace=wrap;"
ROWSTYLE = "rounded=0;html=1;strokeColor=#cccccc;fillColor=none;"
FK = "endArrow=ERmandOne;startArrow=ERmany;html=1;edgeStyle=entityRelationEdgeStyle;"


def page(name, physical):
    n = [1]
    cells = []

    def nid():
        n[0] += 1
        return f"c{n[0]}"

    W = 400 if physical else 250
    rows = {}
    for t in T:
        x, y = POS[t["t"]]
        box = nid()
        cells.append(f'<mxCell id="{box}" value="{escape(t["t"])}" style="{HEADSTYLE}" vertex="1" parent="1">'
                     f'<mxGeometry x="{x}" y="{y}" width="{W}" height="{HEAD + ROWH * len(t["cols"])}" as="geometry"/></mxCell>')
        for k, c in enumerate(t["cols"]):
            key = c.get("key", "")
            nm = f"<u>{c['n']}</u>" if "PK" in key else c["n"]
            ty = f"{c['pg']}{'' if c['nn'] else ' NULL'}"
            ry = HEAD + ROWH * k
            rid = nid()                      # fona rinda: bultu sākums/beigas
            rows[(t["t"], c["n"])] = rid
            cells.append(f'<mxCell id="{rid}" value="" style="{ROWSTYLE}" vertex="1" parent="{box}">'
                         f'<mxGeometry x="0" y="{ry}" width="{W}" height="{ROWH}" as="geometry"/></mxCell>')
            x0 = 0
            parts = [(key, KEYW), (nm, NAMEW)] + ([(ty, W - KEYW - NAMEW)] if physical else [])
            for j, (txt, w) in enumerate(parts):
                if j == len(parts) - 1:
                    w = W - x0
                cid = nid()
                cells.append(f'<mxCell id="{cid}" value="{escape(txt, {chr(34): "&quot;"})}" style="{CELLSTYLE}" vertex="1" parent="{box}">'
                             f'<mxGeometry x="{x0}" y="{ry}" width="{w}" height="{ROWH}" as="geometry"/></mxCell>')
                x0 += w
    for t in T:
        for c in t["cols"]:
            if "ref" in c:
                e = nid()
                cells.append(f'<mxCell id="{e}" value="" style="{FK}" edge="1" parent="1" '
                             f'source="{rows[(t["t"], c["n"])]}" target="{rows[(c["ref"][0], c["ref"][1])]}">'
                             f'<mxGeometry relative="1" as="geometry"/></mxCell>')
    return (f'<diagram name="{name}" id="{name}"><mxGraphModel><root><mxCell id="0"/><mxCell id="1" parent="0"/>'
            + "".join(cells) + "</root></mxGraphModel></diagram>")


missing = [t["t"] for t in T if t["t"] not in POS]
assert not missing, f"Trūkst pozīciju: {missing}"
out_dir = os.path.join(ROOT, "assets", "drawio")
os.makedirs(out_dir, exist_ok=True)
out = os.path.join(out_dir, "db_modeli.drawio")
with open(out, "w", encoding="utf-8") as fh:
    fh.write('<mxfile host="app.diagrams.net">' + page("Logiskais", False) + page("Fiziskais", True) + "</mxfile>")
print("OK", out, len(T), "tabulas")
