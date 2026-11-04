// =====================================================================
// data.typ - VIENĪGAIS DATU AVOTS visam dokumentam.
//
// Šeit ir definēti: lomas, moduļi, entitātes (datu modelis), funkcijas
// un paziņojumi. No šiem datiem automātiski tiek ģenerēti:
//   * funkciju tabula (2.2.1) un paziņojumu tabula (2.2.2),
//   * CRUD matrica, DPD2 diagrammas, funkciju apraksta tabulas (2.2.4-2.2.9),
//   * loģiskais un fiziskais modelis un tabulu apraksti (3.1).
// Ja maināt funkciju vai atribūtu, maināt TIKAI šeit - pārējais atjaunosies.
// Pārbaudes (assert) kompilācijas laikā atrod nesaskaņas.
// =====================================================================

// ---------------------------------------------------------------- lomas
#let roles = (
  (key: "GUEST", name: "Vieslietotājs"),
  (key: "USER", name: "Reģistrēts lietotājs"),
  (key: "ADM", name: "Administrators"),
  (key: "SYS", name: "Sistēma (automātiski)"),
)

// -------------------------------------------------------------- moduļi
#let modules = (
  (key: "LM", name: "Lietotāju modulis", short: "Lietotāji"),
  (key: "SM", name: "Saderības modulis", short: "Saderība"),
  (key: "SP", name: "Ierakstu modulis", short: "Ieraksti"),
  (key: "ZM", name: "Ziņojumapmaiņas modulis", short: "Ziņojumi"),
  (key: "PA", name: "Pasākumu un kartes modulis", short: "Pasākumi"),
  (key: "AM", name: "Administrēšanas modulis", short: "Administrēšana"),
)

// ------------------------------------------------------ ārējās sistēmas
#let externals = (
  (key: "maps", name: "Karšu serviss"),
  (key: "push", name: "Push paziņojumu serviss"),
)

// =====================================================================
// ENTITĀTES (konceptuālais, loģiskais un fiziskais modelis)
// c   - atribūta nosaukums konceptuālajā modelī un ievaddatos
// col - kolonnas nosaukums datubāzē
// pg  - datu tips (PostgreSQL)
// nn  - true = NOT NULL, false = pieļauj NULL
// lv  - datu tipa apraksts latviski (izmanto funkciju ievaddatos)
// =====================================================================
#let entities = (
  (
    name: "Lietotājs", table: "lietotajs", pk: "lietotaja_id", pkd: "Unikāls lietotāja identifikators.",
    purpose: "satur visu reģistrēto lietotāju un administratoru datus. Ieraksts rodas, kad vieslietotājs reģistrējas (LM_01); administratora konti tiek izveidoti datubāzē sistēmas uzstādīšanas laikā",
    attrs: (
      (c: "lietotājvārds", col: "lietotajvards", pg: "VARCHAR(40)", nn: true, uniq: true, lv: "teksts, 3–40 simboli", d: "Lietotāja izvēlētais lietotājvārds."),
      (c: "e_pasts", col: "epasts", pg: "VARCHAR(140)", nn: true, uniq: true, lv: "teksts, līdz 140 simboliem", d: "Lietotāja e-pasta adrese pieslēgšanai."),
      (c: "paroles_hešs", col: "paroles_hess", pg: "VARCHAR(255)", nn: true, lv: "teksts, līdz 255 simboliem", d: "Paroles hešs (parole netiek glabāta atklātā veidā)."),
      (c: "apraksts", col: "apraksts", pg: "VARCHAR(500)", nn: false, lv: "teksts, līdz 500 simboliem", d: "Lietotāja pašapraksts."),
      (c: "pilsēta", col: "pilseta", pg: "VARCHAR(100)", nn: false, lv: "teksts, līdz 100 simboliem", d: "Pilsēta, kurā lietotājs dzīvo vai uzturas."),
      (c: "mbti_tips", col: "mbti_tips", pg: "CHAR(4)", nn: false, lv: "4 burti (piem., INFP)", d: "MBTI testa rezultāts; NULL, kamēr tests nav izpildīts."),
      (c: "loma", col: "loma", pg: "SMALLINT", nn: true, lv: "skaitlis", codes: ("0 – reģistrēts lietotājs", "1 – administrators"), d: "Lietotāja loma sistēmā (noklusējums 0)."),
      (c: "statuss", col: "statuss", pg: "SMALLINT", nn: true, lv: "skaitlis", codes: ("0 – bloķēts", "1 – aktīvs"), d: "Konta statuss (noklusējums 1)."),
      (c: "reģistrācijas_datums", col: "registracijas_datums", pg: "TIMESTAMP", nn: true, lv: "datums/laiks", d: "Konta izveides datums un laiks."),
      (c: "piekrišanas_datums", col: "piekrisanas_datums", pg: "TIMESTAMP", nn: true, lv: "datums/laiks", d: "Datums un laiks, kad lietotājs piekrita lietošanas noteikumiem un GDPR."),
      (c: "push_tokens", col: "push_tokens", pg: "VARCHAR(255)", nn: false, lv: "teksts, līdz 255 simboliem", d: "Ierīces tokens push paziņojumiem; NULL, ja lietotājs nav pieslēdzies."),
    ),
    fks: (),
  ),
  (
    name: "Interese", table: "interese", pk: "interese_id", pkd: "Unikāls intereses identifikators.",
    purpose: "satur interešu sarakstu, no kura lietotāji izvēlas savas intereses. Ierakstus pārvalda administrators (AM_04)",
    attrs: (
      (c: "nosaukums", col: "nosaukums", pg: "VARCHAR(60)", nn: true, uniq: true, lv: "teksts, 2–60 simboli", d: "Intereses nosaukums (piem., fotogrāfija)."),
    ),
    fks: (),
  ),
  (
    name: "Ieraksts", table: "ieraksts", pk: "ieraksta_id", pkd: "Unikāls ieraksta identifikators.",
    purpose: "satur lietotāju publicētos ierakstus ierakstu plūsmā. Ieraksts rodas, lietotājam publicējot ierakstu (SP_02)",
    attrs: (
      (c: "teksts", col: "teksts", pg: "VARCHAR(2000)", nn: true, lv: "teksts, 1–2000 simboli", d: "Ieraksta teksts."),
      (c: "attēla_saite", col: "attela_saite", pg: "VARCHAR(255)", nn: false, lv: "saite uz attēla failu", d: "Saite uz ieraksta attēlu; NULL, ja attēls nav pievienots."),
      (c: "publicēšanas_datums", col: "publicesanas_datums", pg: "TIMESTAMP", nn: true, lv: "datums/laiks", d: "Ieraksta publicēšanas datums un laiks."),
    ),
    fks: (
      (col: "autora_id", ref: "Lietotājs", nn: true, d: "Ieraksta autors.", del: "CASCADE"),
    ),
  ),
  (
    name: "Komentārs", table: "komentars", pk: "komentara_id", pkd: "Unikāls komentāra identifikators.",
    purpose: "satur komentārus pie ierakstiem. Ieraksts rodas, lietotājam komentējot ierakstu (SP_06)",
    attrs: (
      (c: "teksts", col: "teksts", pg: "VARCHAR(500)", nn: true, lv: "teksts, 1–500 simboli", d: "Komentāra teksts."),
      (c: "izveides_datums", col: "izveides_datums", pg: "TIMESTAMP", nn: true, lv: "datums/laiks", d: "Komentāra izveides datums un laiks."),
    ),
    fks: (
      (col: "ieraksta_id", ref: "Ieraksts", nn: true, d: "Ieraksts, pie kura komentārs pievienots.", del: "CASCADE"),
      (col: "autora_id", ref: "Lietotājs", nn: true, d: "Komentāra autors.", del: "CASCADE"),
    ),
  ),
  (
    name: "Ziņa", table: "zina", pk: "zinas_id", pkd: "Unikāls ziņas identifikators.",
    purpose: "satur privātās ziņas starp lietotājiem. Ieraksts rodas, lietotājam nosūtot ziņu (ZM_01). Saruna nav atsevišķa tabula – tā sastāv no ziņām starp diviem lietotājiem",
    attrs: (
      (c: "teksts", col: "teksts", pg: "VARCHAR(1000)", nn: true, lv: "teksts, 1–1000 simboli", d: "Ziņas teksts."),
      (c: "nosūtīšanas_laiks", col: "nosutisanas_laiks", pg: "TIMESTAMP", nn: true, lv: "datums/laiks", d: "Ziņas nosūtīšanas datums un laiks."),
      (c: "izlasīta", col: "izlasita", pg: "BOOLEAN", nn: true, lv: "jā/nē", d: "Vai saņēmējs ziņu ir izlasījis (noklusējums FALSE)."),
    ),
    fks: (
      (col: "sutitaja_id", ref: "Lietotājs", nn: true, d: "Ziņas sūtītājs.", del: "CASCADE"),
      (col: "sanemeja_id", ref: "Lietotājs", nn: true, d: "Ziņas saņēmējs.", del: "CASCADE"),
    ),
  ),
  (
    name: "Pasākums", table: "pasakums", pk: "pasakuma_id", pkd: "Unikāls pasākuma identifikators.",
    purpose: "satur gan tikšanās, gan ceļojumus (pasākuma veids norādīts laukā veids). Ieraksts rodas, lietotājam izveidojot pasākumu (PA_01)",
    attrs: (
      (c: "nosaukums", col: "nosaukums", pg: "VARCHAR(100)", nn: true, lv: "teksts, 3–100 simboli", d: "Pasākuma nosaukums."),
      (c: "apraksts", col: "apraksts", pg: "VARCHAR(1000)", nn: false, lv: "teksts, līdz 1000 simboliem", d: "Pasākuma apraksts."),
      (c: "veids", col: "veids", pg: "SMALLINT", nn: true, lv: "izvēle: tikšanās vai ceļojums", codes: ("0 – tikšanās", "1 – ceļojums"), d: "Pasākuma veids."),
      (c: "sākuma_laiks", col: "sakuma_laiks", pg: "TIMESTAMP", nn: true, lv: "datums/laiks", d: "Pasākuma sākuma datums un laiks."),
      (c: "beigu_laiks", col: "beigu_laiks", pg: "TIMESTAMP", nn: false, lv: "datums/laiks", d: "Pasākuma beigu datums un laiks. Ceļojumam obligāts, tikšanās gadījumā var būt NULL."),
      (c: "dalībnieku_limits", col: "dalibnieku_limits", pg: "INTEGER", nn: false, lv: "vesels skaitlis no 2 līdz 500", d: "Maksimālais pieteikušos dalībnieku skaits (organizators netiek skaitīts); NULL = bez ierobežojuma."),
      (c: "pilsēta", col: "pilseta", pg: "VARCHAR(100)", nn: true, lv: "teksts, līdz 100 simboliem", d: "Pilsēta, kurā pasākums notiek (ceļojumam – galamērķa pilsēta)."),
      (c: "adrese", col: "adrese", pg: "VARCHAR(200)", nn: false, lv: "teksts, līdz 200 simboliem", d: "Vietas adrese vai apraksts."),
      (c: "platums", col: "platums", pg: "NUMERIC(9,6)", nn: true, lv: "decimālskaitlis (ģeogrāfiskais platums)", d: "Vietas ģeogrāfiskais platums kartes atzīmei."),
      (c: "garums", col: "garums", pg: "NUMERIC(9,6)", nn: true, lv: "decimālskaitlis (ģeogrāfiskais garums)", d: "Vietas ģeogrāfiskais garums kartes atzīmei."),
    ),
    fks: (
      (col: "organizatora_id", ref: "Lietotājs", nn: true, d: "Pasākuma organizators.", del: "CASCADE"),
    ),
  ),
  (
    name: "Sūdzība", table: "sudziba", pk: "sudzibas_id", pkd: "Unikāls sūdzības identifikators.",
    purpose: "satur lietotāju iesniegtās sūdzības par citu lietotāju vai viņa ierakstu. Ieraksts rodas, lietotājam iesniedzot sūdzību (AM_01)",
    attrs: (
      (c: "iemesls", col: "iemesls", pg: "VARCHAR(500)", nn: true, lv: "teksts, 1–500 simboli", d: "Sūdzības iemesla apraksts."),
      (c: "izveides_datums", col: "izveides_datums", pg: "TIMESTAMP", nn: true, lv: "datums/laiks", d: "Sūdzības iesniegšanas datums un laiks."),
      (c: "statuss", col: "statuss", pg: "SMALLINT", nn: true, lv: "skaitlis", codes: ("0 – jauna", "1 – izskatīta"), d: "Sūdzības izskatīšanas statuss (noklusējums 0)."),
    ),
    fks: (
      (col: "iesniedzeja_id", ref: "Lietotājs", nn: true, d: "Lietotājs, kas sūdzību iesniedza.", del: "CASCADE"),
      (col: "apsudzeta_id", ref: "Lietotājs", nn: true, d: "Lietotājs, par kuru sūdzība iesniegta.", del: "CASCADE"),
      (col: "ieraksta_id", ref: "Ieraksts", nn: false, d: "Ieraksts, par kuru sūdzība iesniegta; NULL, ja sūdzība ir tikai par lietotāju.", del: "SET NULL"),
    ),
  ),
)

// =====================================================================
// SAITES STARP ENTITĀTĒM, kas kļūst par atsevišķām tabulām (m:n attiecības)
// =====================================================================
#let links = (
  (
    name: "norāda", table: "lietotajs_interese", a: "Lietotājs", b: "Interese",
    acol: "lietotaja_id", bcol: "interese_id", attrs: (),
    purpose: "saista lietotājus ar viņu izvēlētajām interesēm (attiecība „norāda”, m:n). Ieraksti rodas, lietotājam rediģējot profilu (LM_05)",
  ),
  (
    name: "atzīmē patīk", table: "patik", a: "Lietotājs", b: "Ieraksts",
    acol: "lietotaja_id", bcol: "ieraksta_id", attrs: (),
    purpose: "saglabā, kuri lietotāji ir atzīmējuši kuru ierakstu ar „patīk” (attiecība „atzīmē patīk”, m:n). Ieraksti rodas, lietotājam atzīmējot ierakstu (SP_05)",
  ),
  (
    name: "bloķē", table: "blokesana", a: "Lietotājs", b: "Lietotājs",
    acol: "bloketaja_id", bcol: "bloketa_id", attrs: (),
    purpose: "saglabā, kurš lietotājs ir bloķējis kuru lietotāju čatā (attiecība „bloķē”, m:n). Ieraksti rodas, lietotājam bloķējot citu lietotāju (ZM_04)",
    descs: ("Lietotājs, kas veic bloķēšanu.", "Lietotājs, kuru bloķē."),
  ),
  (
    name: "piedalās", table: "daliba", a: "Lietotājs", b: "Pasākums",
    acol: "lietotaja_id", bcol: "pasakuma_id",
    attrs: (
      (c: "pieteikšanās_datums", col: "pieteiksanas_datums", pg: "TIMESTAMP", nn: true, lv: "datums/laiks", d: "Datums un laiks, kad lietotājs pieteicās pasākumam."),
    ),
    purpose: "saglabā, kuri lietotāji ir pieteikušies kuriem pasākumiem (attiecība „piedalās”, m:n). Ieraksti rodas, lietotājam pieteikties pasākumam (PA_05)",
  ),
)

// Attiecības konceptuālajam modelim (a, b - entitātes; ca, cb - kardinalitāte pie a un b)
#let rels = (
  (name: "norāda", a: "Lietotājs", ca: "m", b: "Interese", cb: "n"),
  (name: "publicē", a: "Lietotājs", ca: "1", b: "Ieraksts", cb: "n"),
  (name: "satur", a: "Ieraksts", ca: "1", b: "Komentārs", cb: "n"),
  (name: "raksta", a: "Lietotājs", ca: "1", b: "Komentārs", cb: "n"),
  (name: "atzīmē patīk", a: "Lietotājs", ca: "m", b: "Ieraksts", cb: "n"),
  (name: "sūta", a: "Lietotājs", ca: "1", b: "Ziņa", cb: "n"),
  (name: "saņem", a: "Lietotājs", ca: "1", b: "Ziņa", cb: "n"),
  (name: "bloķē", a: "Lietotājs", ca: "m", b: "Lietotājs", cb: "n"),
  (name: "organizē", a: "Lietotājs", ca: "1", b: "Pasākums", cb: "n"),
  (name: "piedalās", a: "Lietotājs", ca: "m", b: "Pasākums", cb: "n"),
  (name: "iesniedz", a: "Lietotājs", ca: "1", b: "Sūdzība", cb: "n"),
  (name: "tiek apsūdzēts", a: "Lietotājs", ca: "1", b: "Sūdzība", cb: "n"),
  (name: "attiecas uz", a: "Ieraksts", ca: "1", b: "Sūdzība", cb: "n"),
)

// Datu krātuves nosaukumi DPD2 un CRUD matricai (entitātes + saites)
#let stores = (
  "Lietotājs", "Interese", "norāda", "Ieraksts", "Komentārs", "atzīmē patīk",
  "Ziņa", "bloķē", "Pasākums", "piedalās", "Sūdzība",
)

// =====================================================================
// PAZIŅOJUMI
// EMSG_01 - EMSG_04 ir kopīgi un attiecas uz visām funkcijām automātiski
// (sk. paskaidrojumu 2.2.2). Pārējie tiek norādīti katras funkcijas msgs.
// =====================================================================
#let messages = (
  // --- sistēmas (veiksmes/informatīvie) paziņojumi
  (id: "SMSG_01", text: "{Objekts} veiksmīgi izveidots."),
  (id: "SMSG_02", text: "Izmaiņas veiksmīgi saglabātas."),
  (id: "SMSG_03", text: "Vai tiešām vēlaties dzēst {objektu}? Šo darbību nevar atsaukt."),
  (id: "SMSG_04", text: "{Objekts} ir dzēsts."),
  (id: "SMSG_05", text: "MBTI tests pabeigts. Jūsu tips: {mbti_tips}."),
  (id: "SMSG_06", text: "Pēc norādītajiem kritērijiem lietotāji netika atrasti."),
  (id: "SMSG_07", text: "Saite uz ierakstu ir nokopēta."),
  (id: "SMSG_08", text: "Lietotājs {lietotājvārds} ir bloķēts čatā."),
  (id: "SMSG_09", text: "Lietotājs {lietotājvārds} ir atbloķēts čatā."),
  (id: "SMSG_10", text: "Jūs esat pieteicies pasākumam {nosaukums}."),
  (id: "SMSG_11", text: "Jūs esat atteicies no pasākuma {nosaukums}."),
  (id: "SMSG_12", text: "Sūdzība ir nosūtīta. Paldies!"),
  (id: "SMSG_13", text: "Lietotājs {lietotājvārds} ir bloķēts platformā."),
  (id: "SMSG_14", text: "Lietotājs {lietotājvārds} ir atbloķēts platformā."),
  (id: "SMSG_15", text: "Saraksts ir tukšs."),
  (id: "SMSG_16", text: "Jauna ziņa no lietotāja {lietotājvārds}."),
  (id: "SMSG_17", text: "Lietotājs {lietotājvārds} pieteicās jūsu pasākumam {nosaukums}."),
  // --- kļūdu paziņojumi: kopīgie (EMSG_01 - EMSG_04)
  (id: "EMSG_01", text: "Nav interneta savienojuma. Pārbaudiet savienojumu un mēģiniet vēlreiz.", common: true),
  (id: "EMSG_02", text: "Servera kļūda. Lūdzu, mēģiniet vēlāk.", common: true),
  (id: "EMSG_03", text: "Sesija ir beigusies. Lūdzu, piesakieties vēlreiz.", common: true),
  (id: "EMSG_04", text: "Jums nav tiesību veikt šo darbību.", common: true),
  // --- kļūdu paziņojumi: specifiskie
  (id: "EMSG_05", text: "Lūdzu, aizpildiet visus obligātos laukus."),
  (id: "EMSG_06", text: "Lauka {lauks} vērtība nav derīga."),
  (id: "EMSG_07", text: "{Objekts} nav atrasts vai vairs nav pieejams."),
  (id: "EMSG_08", text: "Vērtība {vērtība} laukā {lauks} jau tiek izmantota."),
  (id: "EMSG_09", text: "Parole neatbilst prasībām (vismaz 8 simboli un vismaz viens cipars)."),
  (id: "EMSG_10", text: "Paroles nesakrīt."),
  (id: "EMSG_11", text: "Lai turpinātu, jāpiekrīt lietošanas noteikumiem un GDPR."),
  (id: "EMSG_12", text: "Nepareizs e-pasts vai parole."),
  (id: "EMSG_13", text: "Jūsu konts ir bloķēts."),
  (id: "EMSG_14", text: "Nepareiza pašreizējā parole."),
  (id: "EMSG_15", text: "Attēls neatbilst prasībām (JPG vai PNG, līdz 5 MB)."),
  (id: "EMSG_16", text: "Lai meklētu saderīgus lietotājus, vispirms jāizpilda MBTI tests."),
  (id: "EMSG_17", text: "Ziņu nevar nosūtīt šim lietotājam."),
  (id: "EMSG_18", text: "Pasākumam ir sasniegts dalībnieku limits."),
  (id: "EMSG_19", text: "Organizators nevar pieteikties savam pasākumam."),
  (id: "EMSG_20", text: "Nederīgs laiks: sākuma laikam jābūt nākotnē, bet ceļojuma beigu laikam – vēlākam par sākuma laiku."),
  (id: "EMSG_21", text: "Šo darbību nevar veikt attiecībā uz šo lietotāju."),
  (id: "EMSG_22", text: "Karti neizdevās ielādēt."),
)

// =====================================================================
// FUNKCIJAS
// id, mod, name, roles, goal
// input : ievaddati. Elementi:
//     (a: "Entitāte.atribūts", req: true/false/"cond", note: "...")  - atribūts no datu modeļa
//     (a: "Entitāte.atribūts", gen: true)                            - nosaka sistēma
//     (t: "teksts")                                                   - cits ievaddatu lauks
// steps : apstrādes soļi
// msgs  : specifiskie paziņojumi (SMSG_xx, EMSG_05 un tālāk)
// db    : datu bāzes piekļuve (krātuve, "CRUD" burti, datu apraksts) - no tā
//         veidojas DPD2 un CRUD matrica
// fin / fout : datu plūsmu nosaukumi DPD2 (lietotājs -> funkcija, funkcija -> lietotājs)
// ext   : ārējās sistēmas (key, fout - plūsma uz ārējo sistēmu, fin - plūsma no ārējās sistēmas)
// calls : citas funkcijas, ko šī funkcija izsauc
// =====================================================================
#let functions = (
  // ------------------------------------------------------------ LM
  (
    id: "LM_01", mod: "LM", name: "Reģistrēties", roles: ("GUEST",),
    goal: "Vieslietotājs izveido jaunu lietotāja profilu un kļūst par reģistrētu lietotāju.",
    input: (
      (a: "Lietotājs.lietotājvārds", req: true),
      (a: "Lietotājs.e_pasts", req: true),
      (t: "parole – teksts, 8–64 simboli – obligāts lauks"),
      (t: "paroles_apstiprinājums – teksts, 8–64 simboli – obligāts lauks"),
      (a: "Lietotājs.pilsēta", req: false),
      (t: "piekrišana lietošanas noteikumiem un GDPR – izvēles rūtiņa – obligāts lauks"),
      (a: "Lietotājs.reģistrācijas_datums", gen: true),
      (a: "Lietotājs.piekrišanas_datums", gen: true),
    ),
    steps: (
      "Vieslietotājs aizpilda reģistrācijas formu un nospiež pogu „Reģistrēties”.",
      "Sistēma pārbauda, vai ir aizpildīti visi obligātie lauki. Ja nav – tiek parādīts EMSG_05.",
      "Sistēma pārbauda lauku formātu: lietotājvārdā drīkst būt burti, cipari un simbols „_”, e-pastam jābūt derīgā formātā. Ja formāts nav derīgs – tiek parādīts EMSG_06.",
      "Sistēma pārbauda paroli: vismaz 8 simboli un vismaz viens cipars. Ja neatbilst – EMSG_09; ja parole un paroles_apstiprinājums nesakrīt – EMSG_10.",
      "Ja nav atzīmēta piekrišana lietošanas noteikumiem un GDPR – tiek parādīts EMSG_11.",
      "Sistēma pārbauda, vai lietotājvārds vai e-pasts jau ir datubāzē. Ja ir – tiek parādīts EMSG_08.",
      "Ja kļūdu nav, sistēma saglabā jauno lietotāju (loma = 0, statuss = 1, parole tiek saglabāta kā hešs, piekrišanas_datums = pašreizējais laiks) un parāda SMSG_01 (objekts – profils).",
    ),
    msgs: ("SMSG_01", "EMSG_05", "EMSG_06", "EMSG_08", "EMSG_09", "EMSG_10", "EMSG_11"),
    db: (("Lietotājs", "CR", "Jaunā lietotāja dati"),),
    fin: "Reģistrācijas dati", fout: "Reģistrācijas rezultāts",
  ),
  (
    id: "LM_02", mod: "LM", name: "Pieslēgties", roles: ("GUEST",),
    goal: "Vieslietotājs vai administrators pieslēdzas sistēmai ar e-pastu un paroli.",
    input: (
      (a: "Lietotājs.e_pasts", req: true),
      (t: "parole – teksts – obligāts lauks"),
      (a: "Lietotājs.push_tokens", gen: true),
    ),
    steps: (
      "Lietotājs ievada e-pastu un paroli un nospiež pogu „Pieslēgties”.",
      "Ja kāds obligātais lauks nav aizpildīts – tiek parādīts EMSG_05.",
      "Sistēma atrod lietotāju pēc e-pasta un salīdzina ievadītās paroles hešu ar saglabāto. Ja lietotājs nav atrasts vai parole nesakrīt – tiek parādīts EMSG_12.",
      "Ja lietotāja statuss = 0 (bloķēts) – tiek parādīts EMSG_13.",
      "Ja pārbaudes ir veiksmīgas, sistēma izveido sesiju un saglabā ierīces push_tokens pie lietotāja.",
      "Sistēma atver sākuma skatu: reģistrētam lietotājam – ierakstu plūsmu (SP_01), administratoram – sūdzību sarakstu (AM_02).",
    ),
    msgs: ("EMSG_05", "EMSG_12", "EMSG_13"),
    db: (("Lietotājs", "RU", "Konta dati, ierīces tokens"),),
    fin: "Pieslēgšanās dati", fout: "Pieslēgšanās rezultāts",
  ),
  (
    id: "LM_03", mod: "LM", name: "Atslēgties", roles: ("USER", "ADM"),
    goal: "Lietotājs beidz darbu ar sistēmu un atslēdzas no sava konta.",
    input: ((t: "nav (tiek izmantota aktīvā sesija)"),),
    steps: (
      "Lietotājs nospiež pogu „Atslēgties”.",
      "Sistēma pārtrauc aktīvo sesiju un iestata lietotāja push_tokens uz NULL, lai ierīcē vairs nesaņemtu push paziņojumus.",
      "Lietotājs tiek pārvietots uz pieslēgšanās skatu.",
    ),
    msgs: (),
    db: (("Lietotājs", "U", "Ierīces tokens (dzēšana)"),),
    fin: "Atslēgšanās pieprasījums", fout: "Sesijas beigu apstiprinājums",
  ),
  (
    id: "LM_04", mod: "LM", name: "Apskatīt lietotāja profilu", roles: ("USER", "ADM"),
    goal: "Lietotājs apskata savu vai cita lietotāja profilu.",
    input: ((t: "profila īpašnieks – lietotāja izvēle (savs vai cits lietotājs) – obligāts lauks"),),
    steps: (
      "Lietotājs izvēlas savu vai cita lietotāja profilu.",
      "Sistēma nolasa lietotājvārdu, aprakstu, pilsētu, MBTI tipu un interešu sarakstu. E-pasts tiek rādīts tikai paša lietotāja profilā un administratoram.",
      "Ja lietotājs nav atrasts – tiek parādīts EMSG_07 (objekts – lietotājs).",
      "Sistēma nolasa un parāda lietotāja 20 jaunākos ierakstus.",
      "Cita lietotāja profilā tiek piedāvātas darbības: rakstīt ziņu (ZM_01), bloķēt čatā (ZM_04), iesniegt sūdzību (AM_01); administratoram – bloķēt platformā (AM_03).",
    ),
    msgs: ("EMSG_07",),
    db: (("Lietotājs", "R", "Profila dati"), ("norāda", "R", "Intereses"), ("Interese", "R", "Interešu nosaukumi"), ("Ieraksts", "R", "Lietotāja ieraksti")),
    fin: "Profila pieprasījums", fout: "Profila dati",
  ),
  (
    id: "LM_05", mod: "LM", name: "Rediģēt profilu", roles: ("USER",),
    goal: "Lietotājs maina sava profila datus, izvēlas intereses vai maina paroli.",
    input: (
      (a: "Lietotājs.lietotājvārds", req: true),
      (a: "Lietotājs.e_pasts", req: true),
      (a: "Lietotājs.apraksts", req: false),
      (a: "Lietotājs.pilsēta", req: false),
      (t: "intereses (Interese.nosaukums) – daudzizvēle no esošā saraksta – neobligāts lauks (var nenorādīt nevienu)"),
      (t: "pašreizējā_parole – teksts – obligāta tikai paroles maiņai"),
      (t: "jaunā_parole – teksts, 8–64 simboli – neobligāts lauks"),
      (t: "jaunās_paroles_apstiprinājums – teksts – obligāts, ja norādīta jaunā parole"),
    ),
    steps: (
      "Lietotājs atver profila rediģēšanu; formā tiek parādītas esošās vērtības.",
      "Lietotājs maina laukus un nospiež pogu „Saglabāt”.",
      "Ja lietotājvārds vai e-pasts ir tukšs – EMSG_05; ja formāts nav derīgs – EMSG_06.",
      "Ja ir norādīta jaunā parole: pašreizējai parolei jābūt pareizai (citādi EMSG_14), jaunajai jāatbilst prasībām (citādi EMSG_09) un tai jāsakrīt ar apstiprinājumu (citādi EMSG_10).",
      "Ja mainīts lietotājvārds vai e-pasts un šāda vērtība jau pieder citam lietotājam – tiek parādīts EMSG_08.",
      "Sistēma saglabā izmaiņas un atjaunina lietotāja interešu izvēli (pievieno jaunās un dzēš noņemtās saites ar interesēm).",
      "Lietotājs saņem paziņojumu SMSG_02.",
    ),
    msgs: ("SMSG_02", "EMSG_05", "EMSG_06", "EMSG_08", "EMSG_09", "EMSG_10", "EMSG_14"),
    db: (("Lietotājs", "RU", "Profila dati, parole"), ("Interese", "R", "Interešu saraksts"), ("norāda", "CRD", "Lietotāja intereses")),
    fin: "Jaunie profila dati", fout: "Saglabāšanas rezultāts",
  ),
  (
    id: "LM_06", mod: "LM", name: "Dzēst profilu", roles: ("USER",),
    goal: "Lietotājs dzēš savu profilu un visus ar to saistītos datus (GDPR tiesības uz dzēšanu).",
    input: ((t: "dzēšanas apstiprinājums – jā/nē – obligāts lauks"),),
    steps: (
      "Lietotājs izvēlas „Dzēst profilu”.",
      "Sistēma parāda apstiprinājuma jautājumu SMSG_03 (objekts – profilu).",
      "Ja lietotājs neapstiprina – izmaiņas netiek veiktas.",
      "Ja lietotājs apstiprina, sistēma dzēš lietotāju un kaskādes veidā visus ar to saistītos datus: ierakstus, komentārus, „patīk” atzīmes, ziņas (nosūtītās un saņemtās), bloķēšanas, pieteikumus, organizētos pasākumus un sūdzības (sk. 3.1.3).",
      "Sistēma pārtrauc sesiju, parāda SMSG_04 (objekts – profils) un atver pieslēgšanās skatu.",
    ),
    msgs: ("SMSG_03", "SMSG_04"),
    db: (("Lietotājs", "D", "Lietotāja dzēšana"),),
    fin: "Dzēšanas apstiprinājums", fout: "Dzēšanas rezultāts",
  ),
  (
    id: "LM_07", mod: "LM", name: "Apskatīt informāciju par lietotni un noteikumus", roles: ("GUEST", "USER", "ADM"),
    goal: "Lietotājs iepazīstas ar lietotnes aprakstu, lietošanas noteikumiem un GDPR privātuma politiku.",
    input: ((t: "nav"),),
    steps: (
      "Lietotājs atver sākuma skatu vai izvēlni „Par lietotni”.",
      "Sistēma attēlo lietotnes aprakstu, lietošanas noteikumus un GDPR privātuma politiku (statiski teksti, kas ir daļa no lietotnes).",
      "Vieslietotājam tiek piedāvātas saites uz reģistrāciju (LM_01) un pieslēgšanos (LM_02).",
    ),
    msgs: (),
    db: (),
    fin: "Informācijas pieprasījums", fout: "Lietotnes apraksts, noteikumi, GDPR",
  ),
  // ------------------------------------------------------------ SM
  (
    id: "SM_01", mod: "SM", name: "Izpildīt MBTI testu", roles: ("USER",),
    goal: "Lietotājs izpilda MBTI testu; rezultāts tiek saglabāts profilā un izmantots saderības aprēķinam.",
    input: (
      (t: "testa atbildes – 12 jautājumi, katram viena atbilde A vai B – obligāts lauks (jāatbild uz visiem 12)"),
    ),
    steps: (
      "Lietotājs atver MBTI testu; sistēma pa vienam parāda 12 jautājumus (pa 3 katrai dimensijai: E/I, S/N, T/F, J/P).",
      "Lietotājs atbild uz visiem jautājumiem. Ja kāds jautājums paliek neatbildēts – tiek parādīts EMSG_05.",
      "Katrai dimensijai sistēma saskaita atbildes: atbilde A atbilst pirmajam burtam (E, S, T, J), atbilde B – otrajam (I, N, F, P). Dimensijas burts ir tas, kas saņem vismaz 2 no 3 atbildēm.",
      "Četri burti veido MBTI tipu (piem., INFP). Sistēma saglabā to laukā mbti_tips (aizstājot iepriekšējo).",
      "Lietotājs saņem paziņojumu SMSG_05 ar savu tipu.",
    ),
    msgs: ("SMSG_05", "EMSG_05"),
    db: (("Lietotājs", "U", "MBTI tips"),),
    fin: "Testa atbildes", fout: "Testa rezultāts",
  ),
  (
    id: "SM_02", mod: "SM", name: "Meklēt saderīgus lietotājus", roles: ("USER",),
    goal: "Lietotājs atrod citus lietotājus ar līdzīgu MBTI tipu un interesēm, tai skaitā vietējos iedzīvotājus ceļojuma galamērķī.",
    input: (
      (a: "Lietotājs.pilsēta", req: false, filter: true, note: "meklēšanas filtrs"),
      (t: "meklētāja mbti_tips un intereses – tiek nolasīti automātiski no profila"),
    ),
    steps: (
      "Lietotājs atver saderīgo lietotāju meklēšanu un pēc izvēles ievada pilsētu.",
      "Ja lietotāja mbti_tips ir NULL – tiek parādīts EMSG_16.",
      "Sistēma atlasa citus aktīvus lietotājus (statuss = 1) ar norādīto pilsētu (ja norādīta) un ar aizpildītu mbti_tips, izņemot pašu lietotāju un tos, ar kuriem starp lietotājiem ir bloķēšana jebkurā virzienā.",
      "Katram atlasītajam sistēma aprēķina saderību procentos pēc formulas: saderība = 0,6 × MBTI daļa + 0,4 × interešu daļa. MBTI daļa = sakrītošo MBTI tipa burtu skaits (0–4) × 25. Interešu daļa = kopīgo interešu skaits ÷ mazākais no abu lietotāju interešu skaitiem × 100 (ja kādam lietotājam nav neviena interese, interešu daļa = 0).",
      "Sistēma atstāj lietotājus ar saderību vismaz 50 %, sakārto tos dilstošā secībā pēc saderības un attēlo ne vairāk kā 50 lietotājus (lietotājvārds, pilsēta, saderība %).",
      "Ja neviens lietotājs neatbilst – tiek parādīts SMSG_06.",
    ),
    msgs: ("SMSG_06", "EMSG_16"),
    db: (("Lietotājs", "R", "Lietotāju profili"), ("norāda", "R", "Intereses"), ("bloķē", "R", "Bloķēšanas ieraksti")),
    fin: "Meklēšanas kritēriji", fout: "Saderīgo lietotāju saraksts",
  ),
  // ------------------------------------------------------------ SP
  (
    id: "SP_01", mod: "SP", name: "Skatīt ierakstu plūsmu", roles: ("USER", "ADM"),
    goal: "Lietotājs apskata ierakstu plūsmu ar visu lietotāju ierakstiem un to komentāriem.",
    input: ((t: "nav"),),
    steps: (
      "Lietotājs atver ierakstu plūsmu.",
      "Sistēma nolasa 20 jaunākos ierakstus (jaunākie pirmie) kopā ar autora lietotājvārdu, „patīk” atzīmju skaitu, komentāru skaitu un norādi, vai pašreizējais lietotājs ierakstu ir atzīmējis.",
      "Ja ierakstu nav – tiek parādīts SMSG_15.",
      "Ritinot sarakstu, sistēma ielādē nākamos 20 ierakstus.",
      "Atverot ierakstu, sistēma parāda visus tā komentārus (vecākie pirmie). Ja ieraksts vairs nav pieejams – tiek parādīts EMSG_07 (objekts – ieraksts).",
    ),
    msgs: ("SMSG_15", "EMSG_07"),
    db: (("Ieraksts", "R", "Ieraksti"), ("Komentārs", "R", "Komentāri"), ("atzīmē patīk", "R", "„Patīk” atzīmes"), ("Lietotājs", "R", "Autoru lietotājvārdi")),
    fin: "Plūsmas pieprasījums", fout: "Ieraksti ar komentāriem",
  ),
  (
    id: "SP_02", mod: "SP", name: "Izveidot ierakstu", roles: ("USER",),
    goal: "Lietotājs publicē jaunu ierakstu (tekstu ar neobligātu attēlu) ierakstu plūsmā.",
    input: (
      (a: "Ieraksts.teksts", req: true),
      (t: "attēls – JPG vai PNG fails, līdz 5 MB – neobligāts lauks (saite tiek saglabāta laukā attēla_saite)"),
      (a: "Ieraksts.publicēšanas_datums", gen: true),
    ),
    steps: (
      "Lietotājs atver ieraksta izveides formu, ievada tekstu un pēc izvēles pievieno attēlu.",
      "Ja teksts nav aizpildīts – EMSG_05; ja teksts garāks par 2000 simboliem – EMSG_06.",
      "Ja pievienots attēls, sistēma pārbauda formātu (JPG vai PNG) un izmēru (līdz 5 MB). Ja neatbilst – EMSG_15.",
      "Sistēma saglabā ierakstu ar autoru un publicēšanas laiku un parāda SMSG_01 (objekts – ieraksts).",
    ),
    msgs: ("SMSG_01", "EMSG_05", "EMSG_06", "EMSG_15"),
    db: (("Ieraksts", "C", "Jaunā ieraksta dati"),),
    fin: "Ieraksta dati", fout: "Publicēšanas rezultāts",
  ),
  (
    id: "SP_03", mod: "SP", name: "Rediģēt ierakstu", roles: ("USER",),
    goal: "Lietotājs maina sava ieraksta tekstu vai attēlu.",
    input: (
      (a: "Ieraksts.teksts", req: true),
      (t: "attēls – JPG vai PNG fails, līdz 5 MB – neobligāts lauks (var aizstāt vai noņemt)"),
    ),
    steps: (
      "Lietotājs savam ierakstam izvēlas „Rediģēt”.",
      "Sistēma pārbauda, vai ieraksts eksistē (citādi EMSG_07, objekts – ieraksts) un vai tā autors ir šis lietotājs (citādi EMSG_04).",
      "Lietotājs maina tekstu vai attēlu un nospiež „Saglabāt”.",
      "Ja teksts ir tukšs – EMSG_05; ja garāks par 2000 simboliem – EMSG_06; ja attēls neatbilst prasībām – EMSG_15.",
      "Sistēma saglabā izmaiņas un parāda SMSG_02.",
    ),
    msgs: ("SMSG_02", "EMSG_05", "EMSG_06", "EMSG_07", "EMSG_15"),
    db: (("Ieraksts", "RU", "Ieraksta dati"),),
    fin: "Labotie ieraksta dati", fout: "Saglabāšanas rezultāts",
  ),
  (
    id: "SP_04", mod: "SP", name: "Dzēst ierakstu", roles: ("USER", "ADM"),
    goal: "Lietotājs dzēš savu ierakstu; administrators var dzēst jebkuru ierakstu.",
    input: (
      (t: "dzēšamais ieraksts – lietotāja izvēle – obligāts lauks"),
      (t: "dzēšanas apstiprinājums – jā/nē – obligāts lauks"),
    ),
    steps: (
      "Lietotājs ierakstam izvēlas „Dzēst”.",
      "Sistēma pārbauda, vai ieraksts eksistē (citādi EMSG_07, objekts – ieraksts) un vai lietotājs ir tā autors vai administrators (citādi EMSG_04).",
      "Sistēma parāda apstiprinājuma jautājumu SMSG_03 (objekts – ierakstu). Ja lietotājs neapstiprina – izmaiņas netiek veiktas.",
      "Ja apstiprina, sistēma dzēš ierakstu; kaskādes veidā tiek dzēsti tā komentāri un „patīk” atzīmes, bet sūdzībās saite uz ierakstu tiek iestatīta uz NULL (sk. 3.1.3).",
      "Sistēma parāda SMSG_04 (objekts – ieraksts).",
    ),
    msgs: ("SMSG_03", "SMSG_04", "EMSG_07"),
    db: (("Ieraksts", "RD", "Dzēšamais ieraksts"),),
    fin: "Dzēšamais ieraksts", fout: "Dzēšanas rezultāts",
  ),
  (
    id: "SP_05", mod: "SP", name: "Atzīmēt ierakstu ar „patīk” vai noņemt atzīmi", roles: ("USER",),
    goal: "Lietotājs atzīmē ierakstu ar „patīk” vai noņem savu iepriekšējo atzīmi.",
    input: ((t: "ieraksts – lietotāja izvēle – obligāts lauks"),),
    steps: (
      "Lietotājs nospiež pogu „Patīk” zem ieraksta.",
      "Sistēma pārbauda, vai ieraksts eksistē. Ja nē – EMSG_07 (objekts – ieraksts).",
      "Ja šis lietotājs ierakstu vēl nav atzīmējis – sistēma izveido „patīk” atzīmi; ja jau ir atzīmējis – atzīmi dzēš.",
      "Sistēma atjauno parādīto „patīk” skaitu.",
    ),
    msgs: ("EMSG_07",),
    db: (("Ieraksts", "R", "Ieraksta esamība"), ("atzīmē patīk", "CRD", "„Patīk” atzīme")),
    fin: "„Patīk” atzīme", fout: "Atjaunotais „patīk” skaits",
  ),
  (
    id: "SP_06", mod: "SP", name: "Komentēt ierakstu", roles: ("USER",),
    goal: "Lietotājs pievieno komentāru pie ieraksta.",
    input: (
      (a: "Komentārs.teksts", req: true),
      (a: "Komentārs.izveides_datums", gen: true),
    ),
    steps: (
      "Lietotājs zem ieraksta ievada komentāra tekstu un nospiež „Komentēt”.",
      "Sistēma pārbauda, vai ieraksts eksistē. Ja nē – EMSG_07 (objekts – ieraksts).",
      "Ja teksts ir tukšs – EMSG_05; ja garāks par 500 simboliem – EMSG_06.",
      "Sistēma saglabā komentāru ar autoru un laiku un parāda SMSG_01 (objekts – komentārs).",
    ),
    msgs: ("SMSG_01", "EMSG_05", "EMSG_06", "EMSG_07"),
    db: (("Ieraksts", "R", "Ieraksta esamība"), ("Komentārs", "C", "Jaunā komentāra dati")),
    fin: "Komentāra dati", fout: "Komentāra rezultāts",
  ),
  (
    id: "SP_07", mod: "SP", name: "Dzēst komentāru", roles: ("USER", "ADM"),
    goal: "Lietotājs dzēš savu komentāru; administrators var dzēst jebkuru komentāru.",
    input: (
      (t: "dzēšamais komentārs – lietotāja izvēle – obligāts lauks"),
      (t: "dzēšanas apstiprinājums – jā/nē – obligāts lauks"),
    ),
    steps: (
      "Lietotājs komentāram izvēlas „Dzēst”.",
      "Sistēma pārbauda, vai komentārs eksistē (citādi EMSG_07, objekts – komentārs) un vai lietotājs ir tā autors vai administrators (citādi EMSG_04).",
      "Sistēma parāda SMSG_03 (objekts – komentāru). Ja lietotājs neapstiprina – izmaiņas netiek veiktas.",
      "Ja apstiprina, sistēma dzēš komentāru un parāda SMSG_04 (objekts – komentārs).",
    ),
    msgs: ("SMSG_03", "SMSG_04", "EMSG_07"),
    db: (("Komentārs", "RD", "Dzēšamais komentārs"),),
    fin: "Dzēšamais komentārs", fout: "Dzēšanas rezultāts",
  ),
  (
    id: "SP_08", mod: "SP", name: "Kopīgot ierakstu", roles: ("USER",),
    goal: "Lietotājs iegūst saiti uz ierakstu, ko var nosūtīt citiem ārpus lietotnes plūsmas.",
    input: ((t: "ieraksts – lietotāja izvēle – obligāts lauks"),),
    steps: (
      "Lietotājs zem ieraksta nospiež pogu „Kopīgot”.",
      "Sistēma pārbauda, vai ieraksts eksistē. Ja nē – EMSG_07 (objekts – ieraksts).",
      "Sistēma izveido saiti uz ierakstu formā https://{lietotnes_domēns}/ieraksts/{ieraksta_id} un nokopē to starpliktuvē vai atver ierīces kopīgošanas izvēlni. Dati datubāzē netiek mainīti.",
      "Lietotājs saņem paziņojumu SMSG_07. Atverot saiti, pieslēgts lietotājs redz ierakstu; vieslietotājs tiek aizvests uz pieslēgšanās skatu.",
    ),
    msgs: ("SMSG_07", "EMSG_07"),
    db: (("Ieraksts", "R", "Ieraksta esamība"),),
    fin: "Kopīgošanas pieprasījums", fout: "Saite uz ierakstu",
  ),
  // ------------------------------------------------------------ ZM
  (
    id: "ZM_01", mod: "ZM", name: "Sūtīt ziņu", roles: ("USER",),
    goal: "Lietotājs nosūta privātu ziņu citam lietotājam.",
    input: (
      (t: "saņēmējs – lietotājs – obligāts lauks"),
      (a: "Ziņa.teksts", req: true),
      (a: "Ziņa.nosūtīšanas_laiks", gen: true),
      (a: "Ziņa.izlasīta", gen: true),
    ),
    steps: (
      "Lietotājs atver sarunu ar citu lietotāju (no profila vai sarunu saraksta), ievada tekstu un nospiež „Sūtīt”.",
      "Ja saņēmējs nav atrasts – EMSG_07 (objekts – lietotājs). Ja saņēmējs ir pats sūtītājs – EMSG_21.",
      "Ja teksts ir tukšs – EMSG_05; ja garāks par 1000 simboliem – EMSG_06.",
      "Ja starp lietotājiem ir bloķēšana jebkurā virzienā vai saņēmēja konts ir bloķēts – tiek parādīts EMSG_17.",
      "Sistēma saglabā ziņu (izlasīta = FALSE) un attēlo to sarunā.",
      "Sistēma izsauc funkciju ZM_05, lai saņēmējam nosūtītu push paziņojumu par jaunu ziņu.",
    ),
    msgs: ("EMSG_05", "EMSG_06", "EMSG_07", "EMSG_17", "EMSG_21"),
    db: (("Lietotājs", "R", "Saņēmēja dati"), ("bloķē", "R", "Bloķēšanas ieraksti"), ("Ziņa", "C", "Jaunās ziņas dati")),
    calls: ("ZM_05",),
    fin: "Ziņas dati", fout: "Nosūtīšanas rezultāts",
  ),
  (
    id: "ZM_02", mod: "ZM", name: "Lasīt ziņas", roles: ("USER",),
    goal: "Lietotājs apskata savu sarunu sarakstu un atver konkrētu sarunu.",
    input: ((t: "saruna – izvēle no saraksta (sarunu partneris) – neobligāts lauks"),),
    steps: (
      "Lietotājs atver ziņu sadaļu; sistēma parāda sarunu sarakstu (pēdējā ziņa un nelasīto ziņu skaits katram sarunu partnerim, jaunākās sarunas pirmās).",
      "Ja sarunu nav – tiek parādīts SMSG_15.",
      "Lietotājs atver sarunu; sistēma parāda visas ziņas starp abiem lietotājiem hronoloģiskā secībā (arī tad, ja viens lietotājs ir bloķējis otru).",
      "Sistēma visām saņemtajām ziņām, kas parādītas, iestata izlasīta = TRUE.",
    ),
    msgs: ("SMSG_15",),
    db: (("Ziņa", "RU", "Ziņas, izlasīšanas atzīme"), ("Lietotājs", "R", "Sarunu partneru lietotājvārdi")),
    fin: "Sarunas pieprasījums", fout: "Ziņas",
  ),
  (
    id: "ZM_03", mod: "ZM", name: "Dzēst ziņu", roles: ("USER",),
    goal: "Lietotājs dzēš savu nosūtīto ziņu.",
    input: (
      (t: "dzēšamā ziņa – lietotāja izvēle – obligāts lauks"),
      (t: "dzēšanas apstiprinājums – jā/nē – obligāts lauks"),
    ),
    steps: (
      "Lietotājs savai nosūtītajai ziņai izvēlas „Dzēst”.",
      "Sistēma pārbauda, vai ziņa eksistē (citādi EMSG_07, objekts – ziņa) un vai lietotājs ir tās sūtītājs (citādi EMSG_04).",
      "Sistēma parāda SMSG_03 (objekts – ziņu). Ja lietotājs neapstiprina – izmaiņas netiek veiktas.",
      "Ja apstiprina, sistēma dzēš ziņu (tā pazūd abiem sarunas dalībniekiem) un parāda SMSG_04 (objekts – ziņa).",
    ),
    msgs: ("SMSG_03", "SMSG_04", "EMSG_07"),
    db: (("Ziņa", "RD", "Dzēšamā ziņa"),),
    fin: "Dzēšamā ziņa", fout: "Dzēšanas rezultāts",
  ),
  (
    id: "ZM_04", mod: "ZM", name: "Bloķēt vai atbloķēt lietotāju čatā", roles: ("USER",),
    goal: "Lietotājs bloķē citu lietotāju čatā, lai ar viņu nevarētu sazināties, vai atceļ iepriekšējo bloķēšanu.",
    input: ((t: "bloķējamais lietotājs – lietotāja izvēle – obligāts lauks"),),
    steps: (
      "Lietotājs profilā vai sarunā izvēlas „Bloķēt čatā” vai „Atbloķēt”.",
      "Ja izvēlētais lietotājs nav atrasts – EMSG_07 (objekts – lietotājs). Ja tas ir pats lietotājs – EMSG_21.",
      "Ja bloķēšanas ieraksta vēl nav – sistēma to izveido un parāda SMSG_08.",
      "Ja bloķēšanas ieraksts jau ir – sistēma to dzēš un parāda SMSG_09.",
      "Kamēr bloķēšana ir spēkā, lietotāji nevar sūtīt ziņas viens otram (ZM_01) un neparādās viens otra saderīgo lietotāju meklēšanā (SM_02).",
    ),
    msgs: ("SMSG_08", "SMSG_09", "EMSG_07", "EMSG_21"),
    db: (("Lietotājs", "R", "Lietotāja esamība"), ("bloķē", "CRD", "Bloķēšanas ieraksts")),
    fin: "Bloķēšanas pieprasījums", fout: "Bloķēšanas rezultāts",
  ),
  (
    id: "ZM_05", mod: "ZM", name: "Nosūtīt push paziņojumu", roles: ("SYS",),
    goal: "Sistēma automātiski nosūta lietotājam push paziņojumu, izmantojot ārējo push paziņojumu servisu.",
    input: (
      (t: "saņēmēja ierīces push_tokens – tiek nolasīts no datubāzes"),
      (t: "paziņojuma veids (jauna ziņa vai jauns pasākuma dalībnieks) – nodod izsaucošā funkcija (ZM_01 vai PA_05)"),
      (t: "paziņojuma dati (sūtītāja lietotājvārds vai pasākuma nosaukums) – nodod izsaucošā funkcija"),
    ),
    steps: (
      "Funkciju izsauc ZM_01 (jauna ziņa) vai PA_05 (jauns dalībnieks organizatora pasākumam).",
      "Sistēma nolasa saņēmēja push_tokens. Ja tas ir NULL (lietotājs nav pieslēdzies nevienā ierīcē), paziņojums netiek sūtīts un funkcija beidzas.",
      "Sistēma sagatavo paziņojuma tekstu: SMSG_16 (jauna ziņa) vai SMSG_17 (jauns dalībnieks).",
      "Sistēma nodod push_tokens un tekstu push paziņojumu servisam, kas piegādā paziņojumu lietotāja ierīcei.",
      "Ja push serviss nav pieejams, paziņojums netiek sūtīts atkārtoti, kļūda tiek reģistrēta servera žurnālā, bet izsaucošās funkcijas darbība netiek ietekmēta.",
    ),
    msgs: ("SMSG_16", "SMSG_17"),
    db: (("Lietotājs", "R", "Ierīces tokens"),),
    ext: ((key: "push", fout: "Paziņojuma dati", fin: none),),
    fin: none, fout: "Push paziņojums",
  ),
  // ------------------------------------------------------------ PA
  (
    id: "PA_01", mod: "PA", name: "Izveidot pasākumu", roles: ("USER",),
    goal: "Lietotājs izveido tikšanos vai ceļojumu un norāda vietu kartē.",
    input: (
      (a: "Pasākums.nosaukums", req: true),
      (a: "Pasākums.apraksts", req: false),
      (a: "Pasākums.veids", req: true),
      (a: "Pasākums.sākuma_laiks", req: true),
      (a: "Pasākums.beigu_laiks", req: "cond", note: "obligāts ceļojumam, neobligāts tikšanās gadījumā"),
      (a: "Pasākums.dalībnieku_limits", req: false),
      (a: "Pasākums.pilsēta", req: true),
      (a: "Pasākums.adrese", req: false),
      (t: "vieta kartē (platums un garums) – punkts kartē, ko sniedz karšu serviss – obligāts lauks"),
    ),
    steps: (
      "Lietotājs atver pasākuma izveides formu un norāda vietu kartē; karti sniedz ārējais karšu serviss. Ja karti neizdodas ielādēt – EMSG_22.",
      "Lietotājs aizpilda formu un nospiež „Izveidot”.",
      "Ja kāds obligātais lauks nav aizpildīts – EMSG_05; ja nosaukums, dalībnieku limits (2–500) vai cits lauks nav derīgs – EMSG_06.",
      "Sistēma pārbauda laikus: sākuma laikam jābūt vēlākam par pašreizējo laiku; ceļojumam jānorāda beigu laiks un tam jābūt vēlākam par sākuma laiku; ja tikšanās gadījumā beigu laiks ir norādīts, tam arī jābūt vēlākam par sākuma laiku. Ja nosacījumi nav izpildīti – EMSG_20.",
      "Sistēma saglabā pasākumu ar lietotāju kā organizatoru un parāda SMSG_01 (objekts – pasākums).",
    ),
    msgs: ("SMSG_01", "EMSG_05", "EMSG_06", "EMSG_20", "EMSG_22"),
    db: (("Pasākums", "C", "Jaunā pasākuma dati"),),
    ext: ((key: "maps", fout: "Kartes pieprasījums", fin: "Kartes dati"),),
    fin: "Pasākuma dati", fout: "Izveides rezultāts",
  ),
  (
    id: "PA_02", mod: "PA", name: "Rediģēt pasākumu", roles: ("USER",),
    goal: "Organizators maina sava pasākuma datus.",
    input: (
      (a: "Pasākums.nosaukums", req: true),
      (a: "Pasākums.apraksts", req: false),
      (a: "Pasākums.sākuma_laiks", req: true),
      (a: "Pasākums.beigu_laiks", req: "cond", note: "obligāts ceļojumam, neobligāts tikšanās gadījumā"),
      (a: "Pasākums.dalībnieku_limits", req: false),
      (a: "Pasākums.pilsēta", req: true),
      (a: "Pasākums.adrese", req: false),
      (t: "vieta kartē (platums un garums) – punkts kartē – obligāts lauks"),
    ),
    steps: (
      "Lietotājs savam pasākumam izvēlas „Rediģēt”.",
      "Sistēma pārbauda, vai pasākums eksistē (citādi EMSG_07, objekts – pasākums) un vai lietotājs ir tā organizators (citādi EMSG_04). Karti attēlo karšu serviss; ja neizdodas – EMSG_22.",
      "Lietotājs maina laukus un nospiež „Saglabāt”. Pasākuma veidu mainīt nevar.",
      "Ja obligātais lauks ir tukšs – EMSG_05. Ja kāda vērtība nav derīga vai jaunais dalībnieku limits ir mazāks par jau pieteikušos dalībnieku skaitu – EMSG_06. Laiku pārbaude – kā PA_01 (EMSG_20).",
      "Sistēma saglabā izmaiņas un parāda SMSG_02.",
    ),
    msgs: ("SMSG_02", "EMSG_05", "EMSG_06", "EMSG_07", "EMSG_20", "EMSG_22"),
    db: (("Pasākums", "RU", "Pasākuma dati"), ("piedalās", "R", "Pieteikušos skaits")),
    ext: ((key: "maps", fout: "Kartes pieprasījums", fin: "Kartes dati"),),
    fin: "Labotie pasākuma dati", fout: "Saglabāšanas rezultāts",
  ),
  (
    id: "PA_03", mod: "PA", name: "Dzēst pasākumu", roles: ("USER", "ADM"),
    goal: "Organizators dzēš savu pasākumu; administrators var dzēst jebkuru pasākumu.",
    input: (
      (t: "dzēšamais pasākums – lietotāja izvēle – obligāts lauks"),
      (t: "dzēšanas apstiprinājums – jā/nē – obligāts lauks"),
    ),
    steps: (
      "Lietotājs pasākumam izvēlas „Dzēst”.",
      "Sistēma pārbauda, vai pasākums eksistē (citādi EMSG_07, objekts – pasākums) un vai lietotājs ir organizators vai administrators (citādi EMSG_04).",
      "Sistēma parāda SMSG_03 (objekts – pasākumu). Ja lietotājs neapstiprina – izmaiņas netiek veiktas.",
      "Ja apstiprina, sistēma dzēš pasākumu; kaskādes veidā tiek dzēsti arī visu dalībnieku pieteikumi (sk. 3.1.3). Tiek parādīts SMSG_04 (objekts – pasākums).",
    ),
    msgs: ("SMSG_03", "SMSG_04", "EMSG_07"),
    db: (("Pasākums", "RD", "Dzēšamais pasākums"),),
    fin: "Dzēšamais pasākums", fout: "Dzēšanas rezultāts",
  ),
  (
    id: "PA_04", mod: "PA", name: "Pārlūkot pasākumus kartē un sarakstā", roles: ("USER", "ADM"),
    goal: "Lietotājs apskata gaidāmos pasākumus kartē un sarakstā un atver to detaļas.",
    input: (
      (a: "Pasākums.pilsēta", req: false, filter: true, note: "meklēšanas filtrs"),
      (a: "Pasākums.veids", req: false, filter: true, note: "meklēšanas filtrs"),
    ),
    steps: (
      "Lietotājs atver sadaļu „Pasākumi” un izvēlas skatu: karte vai saraksts. Karti sniedz karšu serviss; ja neizdodas – EMSG_22.",
      "Sistēma nolasa gaidāmos pasākumus (sākuma_laiks vēl nav pagājis vai ceļojuma beigu_laiks vēl nav pagājis) ar izvēlētajiem filtriem, sakārtotus pēc sākuma laika.",
      "Ja pasākumu nav – tiek parādīts SMSG_15.",
      "Kartē katram pasākumam tiek rādīta atzīme, sarakstā – nosaukums, veids, laiks, vieta un pieteikušos skaits (kopā ar limitu, ja tāds ir).",
      "Izvēloties pasākumu, tiek parādītas tā detaļas: apraksts, organizators un dalībnieku lietotājvārdi. Lietotājam tiek piedāvāta darbība „Pieteikties” vai „Atteikties” (PA_05), organizatoram – „Rediģēt” (PA_02) un „Dzēst” (PA_03), administratoram – „Dzēst” (PA_03).",
    ),
    msgs: ("SMSG_15", "EMSG_22"),
    db: (("Pasākums", "R", "Pasākumi"), ("piedalās", "R", "Pieteikumi"), ("Lietotājs", "R", "Organizatoru un dalībnieku lietotājvārdi")),
    ext: ((key: "maps", fout: "Kartes pieprasījums", fin: "Kartes dati"),),
    fin: "Pasākumu filtri", fout: "Pasākumu saraksts un karte",
  ),
  (
    id: "PA_05", mod: "PA", name: "Pieteikties pasākumam vai atteikties", roles: ("USER",),
    goal: "Lietotājs pieteicas pasākumam vai atceļ savu iepriekšējo pieteikumu.",
    input: ((t: "pasākums – lietotāja izvēle – obligāts lauks"),),
    steps: (
      "Lietotājs pasākuma detaļās nospiež „Pieteikties” vai „Atteikties”.",
      "Sistēma pārbauda, vai pasākums eksistē un nav beidzies. Ja nē – EMSG_07 (objekts – pasākums).",
      "Ja lietotājs vēl nav pieteicies: ja viņš ir pasākuma organizators – EMSG_19; ja pieteikušos skaits jau sasniedz dalībnieku_limits – EMSG_18; citādi sistēma saglabā pieteikumu, parāda SMSG_10 un izsauc ZM_05, lai organizatoram nosūtītu push paziņojumu par jaunu dalībnieku.",
      "Ja lietotājs jau ir pieteicies – sistēma dzēš pieteikumu un parāda SMSG_11.",
    ),
    msgs: ("SMSG_10", "SMSG_11", "EMSG_07", "EMSG_18", "EMSG_19"),
    db: (("Pasākums", "R", "Pasākuma dati"), ("piedalās", "CRD", "Pieteikums")),
    calls: ("ZM_05",),
    fin: "Pieteikšanās pieprasījums", fout: "Pieteikšanās rezultāts",
  ),
  // ------------------------------------------------------------ AM
  (
    id: "AM_01", mod: "AM", name: "Iesniegt sūdzību", roles: ("USER",),
    goal: "Lietotājs iesniedz sūdzību par citu lietotāju vai viņa ierakstu.",
    input: (
      (a: "Sūdzība.iemesls", req: true),
      (t: "apsūdzētais lietotājs – tiek nodots automātiski no profila vai ieraksta – obligāts lauks"),
      (t: "ieraksts – tiek nodots automātiski, ja sūdzība ir par ierakstu – neobligāts lauks"),
      (a: "Sūdzība.izveides_datums", gen: true),
      (a: "Sūdzība.statuss", gen: true),
    ),
    steps: (
      "Lietotājs profilā vai pie ieraksta izvēlas „Ziņot”.",
      "Sistēma pārbauda, vai apsūdzētais lietotājs (un ieraksts, ja norādīts) eksistē. Ja nē – EMSG_07 (objekts – lietotājs vai ieraksts).",
      "Ja apsūdzētais ir pats lietotājs vai administrators – tiek parādīts EMSG_21.",
      "Lietotājs ievada iemeslu un nospiež „Nosūtīt”. Ja iemesls ir tukšs – EMSG_05; ja garāks par 500 simboliem – EMSG_06.",
      "Sistēma saglabā sūdzību ar statusu 0 (jauna) un parāda SMSG_12.",
    ),
    msgs: ("SMSG_12", "EMSG_05", "EMSG_06", "EMSG_07", "EMSG_21"),
    db: (("Lietotājs", "R", "Apsūdzētā lietotāja dati"), ("Ieraksts", "R", "Ieraksta esamība"), ("Sūdzība", "C", "Jaunās sūdzības dati")),
    fin: "Sūdzības dati", fout: "Sūdzības rezultāts",
  ),
  (
    id: "AM_02", mod: "AM", name: "Izskatīt sūdzības", roles: ("ADM",),
    goal: "Administrators apskata sūdzību sarakstu, atzīmē sūdzības kā izskatītas vai dzēš tās.",
    input: (
      (a: "Sūdzība.statuss", req: false, filter: true, note: "saraksta filtrs; noklusējums 0 (jaunās)"),
      (t: "darbība – atzīmēt kā izskatītu vai dzēst sūdzību – lietotāja izvēle"),
    ),
    steps: (
      "Administrators atver sūdzību sarakstu; sistēma parāda sūdzības ar izvēlēto statusu (noklusējums – jaunās), jaunākās pirmās.",
      "Ja sūdzību nav – tiek parādīts SMSG_15.",
      "Administrators atver sūdzību; sistēma parāda iemeslu, iesniedzēja un apsūdzētā lietotājvārdus un, ja norādīts, ieraksta tekstu. Ja sūdzība vairs nav pieejama – EMSG_07 (objekts – sūdzība).",
      "Administrators var izvēlēties: (a) „Atzīmēt kā izskatītu” – statuss tiek iestatīts uz 1 un parādīts SMSG_02; (b) „Dzēst sūdzību” – tiek parādīts SMSG_03 (objekts – sūdzību), pēc apstiprināšanas sūdzība tiek dzēsta un parādīts SMSG_04 (objekts – sūdzība).",
      "No sūdzības administrators var pāriet uz ieraksta dzēšanu (SP_04) vai lietotāja bloķēšanu (AM_03).",
    ),
    msgs: ("SMSG_02", "SMSG_03", "SMSG_04", "SMSG_15", "EMSG_07"),
    db: (("Sūdzība", "RUD", "Sūdzības"), ("Lietotājs", "R", "Lietotājvārdi"), ("Ieraksts", "R", "Ieraksta teksts")),
    fin: "Izskatīšanas darbība", fout: "Sūdzību saraksts un detaļas",
  ),
  (
    id: "AM_03", mod: "AM", name: "Bloķēt vai atbloķēt lietotāju platformā", roles: ("ADM",),
    goal: "Administrators bloķē lietotāja kontu, lai tas nevarētu pieslēgties, vai atbloķē iepriekš bloķētu kontu.",
    input: ((t: "lietotājs – lietotāja izvēle no profila vai sūdzības – obligāts lauks"),),
    steps: (
      "Administrators lietotāja profilā vai sūdzībā izvēlas „Bloķēt” vai „Atbloķēt”.",
      "Ja lietotājs nav atrasts – EMSG_07 (objekts – lietotājs). Ja lietotājs ir administrators – EMSG_21.",
      "Ja lietotāja statuss = 1: sistēma iestata statusu 0, iestata push_tokens uz NULL un pārtrauc lietotāja aktīvās sesijas; tiek parādīts SMSG_13.",
      "Ja lietotāja statuss = 0: sistēma iestata statusu 1 un parāda SMSG_14.",
      "Bloķēts lietotājs vairs nevar pieslēgties sistēmai (LM_02).",
    ),
    msgs: ("SMSG_13", "SMSG_14", "EMSG_07", "EMSG_21"),
    db: (("Lietotājs", "RU", "Konta statuss"),),
    fin: "Bloķēšanas pieprasījums", fout: "Bloķēšanas rezultāts",
  ),
  (
    id: "AM_04", mod: "AM", name: "Pārvaldīt intereses", roles: ("ADM",),
    goal: "Administrators pievieno, labo vai dzēš intereses sarakstā, no kura lietotāji izvēlas savas intereses.",
    input: (
      (a: "Interese.nosaukums", req: true),
      (t: "darbība – pievienot, labot vai dzēst – lietotāja izvēle"),
    ),
    steps: (
      "Administrators atver interešu sarakstu; sistēma parāda visas intereses alfabēta secībā. Ja saraksts ir tukšs – SMSG_15.",
      "Pievienošana: administrators ievada nosaukumu (2–60 simboli). Ja tukšs – EMSG_05; ja nederīgs – EMSG_06; ja šāda interese jau ir – EMSG_08. Sistēma saglabā interesi un parāda SMSG_01 (objekts – interese).",
      "Labošana: administrators izvēlas interesi un maina nosaukumu; pārbaudes – kā pievienošanai; ja interese nav atrasta – EMSG_07 (objekts – interese). Tiek parādīts SMSG_02.",
      "Dzēšana: administrators izvēlas interesi; sistēma parāda SMSG_03 (objekts – interesi). Pēc apstiprināšanas interese tiek dzēsta kopā ar lietotāju saitēm uz to un parādīts SMSG_04 (objekts – interese).",
    ),
    msgs: ("SMSG_01", "SMSG_02", "SMSG_03", "SMSG_04", "SMSG_15", "EMSG_05", "EMSG_06", "EMSG_07", "EMSG_08"),
    db: (("Interese", "CRUD", "Intereses"), ("norāda", "D", "Dzēstās intereses saites")),
    fin: "Intereses dati", fout: "Interešu saraksts un rezultāts",
  ),
)

// =====================================================================
// CRUD matricā neapzīmētās kombinācijas, kuras ir apzināti izlaistas
// =====================================================================
#let crud-na = (
  ("norāda", "U", "saite nesatur labojamus atribūtus"),
  ("Komentārs", "U", "komentārus nelabo; lietotājs var komentāru dzēst (SP_07) un uzrakstīt jaunu (SP_06)"),
  ("atzīmē patīk", "U", "saite nesatur labojamus atribūtus"),
  ("bloķē", "U", "saite nesatur labojamus atribūtus"),
  ("piedalās", "U", "pieteikumu nelabo; lietotājs to atceļ un pieteicas no jauna (PA_05)"),
)
