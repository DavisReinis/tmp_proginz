// =====================================================================
// lib.typ - tabulu ģeneratori un konsekvences pārbaudes.
// Nav jāmaina, ja nemaināt dokumenta struktūru. Datus maina data.typ.
// =====================================================================
#import "data.typ": *

// ------------------------------------------------------------ meklēšana
#let find-entity(name) = entities.find(e => e.name == name)
#let find-module(k) = modules.find(m => m.key == k)
#let find-role(k) = roles.find(r => r.key == k)
#let find-msg(id) = messages.find(m => m.id == id)
#let find-fun(id) = functions.find(f => f.id == id)
#let find-ext(k) = externals.find(e => e.key == k)
#let find-attr(entity, attr) = {
  let e = find-entity(entity)
  assert(e != none, message: "Nezināma entitāte: " + entity)
  let a = e.attrs.find(x => x.c == attr)
  assert(a != none, message: "Entitātei " + entity + " nav atribūta " + attr)
  a
}
// Visas datubāzes tabulas (entitātes + saites) vienotā sarakstā
#let db-tables = entities + links

// Funkcija ir "publiska", ja to drīkst izmantot vieslietotājs, vai ja to izpilda sistēma;
// tai netiek piemēroti kopīgie paziņojumi EMSG_03 un EMSG_04.
#let is-public(f) = f.roles.contains("GUEST") or f.roles.contains("SYS")
#let common-msgs(f) = {
  if f.roles.contains("SYS") { () }
  else if f.roles.contains("GUEST") { ("EMSG_01", "EMSG_02") }
  else { ("EMSG_01", "EMSG_02", "EMSG_03", "EMSG_04") }
}

// -------------------------------------------------- konsekvences pārbaudes
#let id-regex = regex("\\b[A-Z]{2}_\\d{2}\\b")
#let msg-regex = regex("\\b[SE]MSG_\\d{2}\\b")

#let validate() = {
  // unikāli identifikatori
  let ids = functions.map(f => f.id)
  for (i, id) in ids.enumerate() {
    assert(ids.position(x => x == id) == i, message: "Dublēts funkcijas ID: " + id)
  }
  let mids = messages.map(m => m.id)
  for (i, id) in mids.enumerate() {
    assert(mids.position(x => x == id) == i, message: "Dublēts paziņojuma ID: " + id)
  }
  for f in functions {
    assert(find-module(f.mod) != none, message: f.id + ": nezināms modulis " + f.mod)
    assert(f.id.starts-with(f.mod + "_"), message: f.id + ": ID nesakrīt ar moduli " + f.mod)
    for r in f.roles { assert(find-role(r) != none, message: f.id + ": nezināma loma " + r) }
    for m in f.msgs {
      assert(find-msg(m) != none, message: f.id + ": nezināms paziņojums " + m)
      assert(not find-msg(m).at("common", default: false), message: f.id + ": kopīgo paziņojumu " + m + " nedrīkst norādīt msgs sarakstā")
    }
    for s in f.db {
      assert(stores.contains(s.at(0)), message: f.id + ": nezināma datu krātuve " + s.at(0))
    }
    for c in f.at("calls", default: ()) {
      assert(find-fun(c) != none, message: f.id + ": izsauc neesošu funkciju " + c)
    }
    for e in f.at("ext", default: ()) {
      assert(find-ext(e.key) != none, message: f.id + ": nezināma ārējā sistēma " + e.key)
    }
    // ievaddati pret datu modeli
    for i in f.input {
      if "a" in i {
        let p = i.a.split(".")
        let attr = find-attr(p.at(0), p.at(1))
        if i.at("gen", default: false) == false and i.at("filter", default: false) == false {
          let r = i.req
          if r == true {
            assert(attr.nn, message: f.id + ": " + i.a + " ir obligāts ievadē, bet datubāzē pieļauj NULL")
          } else {
            assert(not attr.nn, message: f.id + ": " + i.a + " ir neobligāts ievadē, bet datubāzē ir NOT NULL")
          }
        }
      }
    }
    // paziņojumu un funkciju ID tekstā pret sarakstiem
    let text-all = f.steps.join(" ") + " " + f.goal
    for m in text-all.matches(msg-regex) {
      let id = m.text
      assert(find-msg(id) != none, message: f.id + ": tekstā minēts neesošs paziņojums " + id)
      if not find-msg(id).at("common", default: false) {
        assert(f.msgs.contains(id), message: f.id + ": tekstā minēts " + id + ", bet tas nav msgs sarakstā")
      }
    }
    for m in f.msgs {
      assert(f.steps.join(" ").contains(m), message: f.id + ": " + m + " ir msgs sarakstā, bet nav minēts apstrādes soļos")
    }
    for m in text-all.matches(id-regex) {
      assert(find-fun(m.text) != none, message: f.id + ": tekstā minēta neesoša funkcija " + m.text)
    }
  }
  // katrs nekopīgais paziņojums tiek izmantots
  for m in messages {
    if not m.at("common", default: false) {
      assert(functions.any(f => f.msgs.contains(m.id)), message: "Paziņojums " + m.id + " netiek izmantots nevienā funkcijā")
    }
  }
  // katrai attiecībai starp entitātēm eksistē entitātes
  for r in rels {
    assert(find-entity(r.a) != none and find-entity(r.b) != none, message: "Attiecība " + r.name + ": nezināma entitāte")
  }
  // moduļiem ir funkcijas
  for m in modules {
    assert(functions.any(f => f.mod == m.key), message: "Modulim " + m.key + " nav funkciju")
  }
  true
}
#let _valid = validate()

// ---------------------------------------------------- 1.4 lomu iespējas
#let role-list(role) = {
  list(..functions.filter(f => f.roles.contains(role)).map(f => [#f.name (#f.id)]))
}

// --------------------------------------------- 2.2.1 funkciju tabula
#let function-overview() = {
  let rows = ()
  for m in modules {
    let fs = functions.filter(f => f.mod == m.key)
    for (i, f) in fs.enumerate() {
      if i == 0 { rows.push(table.cell(rowspan: fs.len())[#m.name]) }
      rows.push([#f.name])
      rows.push([#f.id])
      for r in roles {
        rows.push(if f.roles.contains(r.key) { [x] } else { [] })
      }
    }
  }
  table(
    columns: (1.7fr, 3fr, 1.2fr, 1fr, 1fr, 1fr, 1fr),
    align: (x, y) => if y <= 1 or x >= 2 { center + horizon } else { left + horizon },
    inset: 5pt,
    table.header(
      table.cell(rowspan: 2)[*Modulis*], table.cell(rowspan: 2)[*Funkcija*], table.cell(rowspan: 2)[*Identifikators*],
      table.cell(colspan: 4)[*Lietotāju tipi*],
      ..roles.map(r => [*#r.key*]),
    ),
    ..rows,
  )
}

// -------------------------------------------------- 2.2.2 paziņojumi
#let msg-users(m) = {
  if m.at("common", default: false) {
    if m.id in ("EMSG_01", "EMSG_02") {
      [Visas funkcijas, izņemot ZM_05]
    } else {
      let ex = functions.filter(f => is-public(f)).map(f => f.id).join(", ")
      [Visas funkcijas, kas prasa pieslēgšanos (izņemot #ex)]
    }
  } else {
    functions.filter(f => f.msgs.contains(m.id)).map(f => f.id).join(", ")
  }
}
#let messages-table() = {
  table(
    columns: (1.1fr, 2.4fr, 3fr),
    align: (x, y) => if y == 0 or x == 0 { center + horizon } else { left + horizon },
    inset: 5pt,
    table.header([*Identifikators*], [*Funkcijas, kas lieto paziņojumu*], [*Paziņojums*]),
    ..messages.map(m => ([#m.id], msg-users(m), [„#m.text”])).flatten(),
  )
}

// ----------------------------------------------------------- CRUD matrica
#let crud-ids(store, letter) = {
  functions.filter(f => f.db.any(d => d.at(0) == store and d.at(1).contains(letter))).map(f => f.id)
}
#let crud-table() = {
  let rows = ()
  for s in stores {
    for l in ("C", "R", "U", "D") {
      let ids = crud-ids(s, l)
      if ids.len() == 0 {
        let na = crud-na.find(n => n.at(0) == s and n.at(1) == l)
        assert(na != none, message: "CRUD trūkst: krātuvei " + s + " nav funkcijas darbībai " + l + " (un tā nav norādīta crud-na sarakstā)")
        rows.push([nav paredzēts\*])
      } else {
        rows.push([#ids.join(", ")])
      }
    }
  }
  let body = ()
  for (i, s) in stores.enumerate() {
    body.push([*#s*])
    for j in range(4) { body.push(rows.at(i * 4 + j)) }
  }
  table(
    columns: (1.3fr, 1.4fr, 1.6fr, 1.4fr, 1.4fr),
    align: (x, y) => if y == 0 { center + horizon } else { left + horizon },
    inset: 5pt,
    table.header([*Entitāte vai saite*], [*C (izveidot)*], [*R (lasīt)*], [*U (labot)*], [*D (dzēst)*]),
    ..body,
  )
}
#let crud-notes() = {
  for n in crud-na {
    [\* #n.at(0), darbība #n.at(1): #n.at(2). \ ]
  }
}

// --------------------------------------------------- funkciju apraksti
#let input-line(i) = {
  if "a" in i {
    let p = i.a.split(".")
    let attr = find-attr(p.at(0), p.at(1))
    let status = if i.at("gen", default: false) {
      "nosaka sistēma"
    } else if i.req == true {
      "obligāts lauks"
    } else if i.req == false {
      "neobligāts lauks"
    } else {
      i.note
    }
    let note = if i.at("gen", default: false) == false and i.req != "cond" and "note" in i { " (" + i.note + ")" } else { "" }
    [#i.a – #attr.lv – #status#note]
  } else {
    [#i.t]
  }
}
#let output-block(f) = {
  let sm = f.msgs.filter(m => m.starts-with("SMSG"))
  let em = f.msgs.filter(m => m.starts-with("EMSG"))
  let cm = common-msgs(f)
  let lines = ()
  if f.fout != none { lines.push([Datu izvade: #f.fout.]) }
  lines.push([Paziņojumi: #if sm.len() > 0 { sm.join(", ") } else { [nav] }.])
  lines.push([Kļūdu paziņojumi: #if em.len() > 0 { em.join(", ") } else { [nav] }.])
  if cm.len() > 0 { lines.push([Kopīgie kļūdu paziņojumi (sk. 2.2.2): #cm.join(", ").]) }
  lines.join(linebreak())
}
#let function-table(f) = {
  [#figure(
    kind: table,
    caption: [#f.id #f.name],
    {
      set par(first-line-indent: 0pt, leading: 0.55em, justify: false)
      set enum(numbering: "1.", indent: 0pt)
      show table.cell.where(x: 0): strong
      table(
        columns: (1.2fr, 4fr),
        inset: 6pt,
        align: left + top,
        [Identifikators:], [#f.id],
        [Mērķis:], [#f.goal],
        [Ievaddati:], f.input.map(i => input-line(i)).join(linebreak()),
        [Apstrāde:], enum(..f.steps.map(s => [#s])),
        [Izvaddati:], output-block(f),
      )
    },
  )#label("ft-" + f.id)]
}
// Funkciju tabulas visam modulim, ar īsu ievadteikumu pirms katras tabulas
#let module-function-tables(modkey) = {
  for f in functions.filter(f => f.mod == modkey) {
    par(first-line-indent: 0pt)[
      #ref(label("ft-" + f.id)) apraksta funkciju „#f.name” (#f.id): mērķi, ievaddatus, apstrādes soļus un izvaddatus.
    ]
    function-table(f)
  }
}

// -------------------------------------------------------- 3.1.3 DB tabulas
#let del-note(del) = if del == "CASCADE" {
  " Dzēšot atsauces ierakstu, šis ieraksts tiek dzēsts (ON DELETE CASCADE)."
} else {
  " Dzēšot atsauces ierakstu, vērtība tiek iestatīta uz NULL (ON DELETE SET NULL)."
}
// Atgriež tabulas kolonnu sarakstu: (name, pg, codes, nn, key, d)
#let table-cols(t) = {
  let cols = ()
  let is-entity = "pk" in t
  if is-entity {
    cols.push((name: t.pk, pg: "INTEGER", codes: (), nn: true, key: "PK", d: t.pkd + " Vērtība tiek ģenerēta automātiski."))
    for fk in t.fks {
      let target = find-entity(fk.ref)
      cols.push((name: fk.col, pg: "INTEGER", codes: (), nn: fk.nn, key: "FK", d: fk.d + " Atsauce uz tabulu " + target.table + "." + del-note(fk.del)))
    }
  } else {
    let a = find-entity(t.a)
    let b = find-entity(t.b)
    let descs = t.at("descs", default: ("Atsauce uz tabulu " + a.table + ".", "Atsauce uz tabulu " + b.table + "."))
    cols.push((name: t.acol, pg: "INTEGER", codes: (), nn: true, key: "PK, FK", d: descs.at(0) + " Atsauce uz tabulu " + a.table + "." + del-note("CASCADE")))
    cols.push((name: t.bcol, pg: "INTEGER", codes: (), nn: true, key: "PK, FK", d: descs.at(1) + " Atsauce uz tabulu " + b.table + "." + del-note("CASCADE")))
  }
  for at in t.attrs {
    cols.push((
      name: at.col, pg: at.pg, codes: at.at("codes", default: ()), nn: at.nn, key: "",
      d: at.d + if at.at("uniq", default: false) { " Vērtībai jābūt unikālai." } else { "" },
    ))
  }
  cols
}
#let crud-line(t) = {
  // t.name ir entitātes vai saites nosaukums, kas sakrīt ar krātuves nosaukumu
  let parts = ()
  for (l, nm) in (("C", "izveidot"), ("R", "lasīt"), ("U", "labot"), ("D", "dzēst")) {
    let ids = crud-ids(t.name, l)
    if ids.len() > 0 { parts.push(l + " (" + nm + "): " + ids.join(", ")) }
    else { parts.push(l + " (" + nm + "): nav paredzēts") }
  }
  parts.join("; ")
}
#let db-description(t, idx) = {
  let cols = table-cols(t)
  par(first-line-indent: 0pt)[
    #ref(label("dbt-" + t.table)) – tabula *#t.table* #t.purpose. Datu darbības ar tabulu (CRUD): #crud-line(t).
  ]
  [#figure(
    kind: table,
    caption: [Tabula #t.table],
    {
      set text(size: 9pt)
      set par(first-line-indent: 0pt, leading: 0.5em, justify: false)
      table(
        columns: (1.35fr, 1.5fr, 3fr, 0.8fr, 0.8fr),
        inset: 4pt,
        align: left + top,
        table.header([*Nosaukums*], [*Datu tips*], [*Apraksts*], [*Pieļauj NULL*], [*Atslēga (PK/FK)*]),
        ..cols.map(c => (
          [#c.name],
          [#c.pg#if c.codes.len() > 0 { linebreak() + c.codes.join(linebreak()) }],
          [#c.d],
          [#if c.nn { "Nē" } else { "Jā" }],
          [#c.key],
        )).flatten(),
      )
    },
  )#label("dbt-" + t.table)]
}
