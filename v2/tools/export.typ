// Palīgfails draw.io ģenerēšanai: izvada datus JSON formā (sk. gen_drawio.py)
#import "../data.typ": *
#metadata((
  entities: entities,
  links: links,
  rels: rels,
  modules: modules,
  externals: externals,
  roles: roles,
  functions: functions.map(f => (
    id: f.id, mod: f.mod, name: f.name, roles: f.roles, db: f.db,
    fin: f.fin, fout: f.fout, ext: f.at("ext", default: ()), calls: f.at("calls", default: ()),
  )),
)) <export>
