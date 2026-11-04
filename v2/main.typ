#import "@preview/solo-lu-df:2.1.0": *
#import "lib.typ": *
Tinymist Typs
#show table: set text(size: 10pt)
#show table: set par(leading: 0.5em)

// Diagrammas ir zīmētas draw.io (assets/drawio/diagrammas.drawio) un eksportētas kā assets/<nosaukums>.png
#let dgm(name) = image("assets/" + name + ".png", width: 100%)
// Palīgfunkcija: attēls ar parakstu un atsauces etiķeti
#let fig(body, caption, lbl) = [#figure(body, caption: caption)#label(lbl)]

#show: ludf.with(
  title: "Ceļabiedru un domubiedru meklēšanas platforma",
  thesis-type: "bachelor",
  locale: "lv",
  labels: (
    thesis: (
      label: (
        bachelor: "PROGRAMMINŽENIERIJAS PRAKTISKAIS DARBS",
      ),
    ),
    title: (
      page: (
        authors: (
          plural: strong[Darba autori],
          singular: strong[Darba autors],
        ),
        advisors: (
          prefix: strong[Darba],
          singular: strong[vadītāja],
          plural: strong[vadītāji],
        ),
      ),
    ),
  ),
  authors: (
    (
      name: "Madara Luize Verpakovska",
      code: "mv25071",
      location: [Rīga, Latvija],
      email: "mv25071@edu.lu.lv",
    ),
    (
      name: "Viktorija Mihailova",
      code: "vm23071",
      location: [Rīga, Latvija],
      email: "vm23071@edu.lu.lv",
    ),
    (
      name: "Dāvis Reinis",
      code: "dr24039",
      location: [Rīga, Latvija],
      email: "dr24039@edu.lu.lv",
    ),
    (
      name: "Mariuss Krasavcevs",
      code: "mk25150",
      location: [Rīga, Latvija],
      email: "mk25150@edu.lu.lv",
    ),
    (
      name: "Annija Maslovska",
      code: "am25136",
      location: [Rīga, Latvija],
      email: "am25136@edu.lu.lv",
    ),
  ),
  advisors: (
    (
      title: "Dr. sc. comp.",
      name: "Laila Niedrīte",
    ),
  ),
  // submission-date un defense-date pēc noklusējuma ir datetime.today();
  // pirms iesniegšanas uzstādiet gala datumus, piemēram: datetime(year: 2026, month: 12, day: 1)
  place: "Rīga",
  bibliography: bibliography("bibliography.yml"),
  abstract: (
    primary: (
      text: [Praktiskajā darbā ir izstrādāta prasību specifikācija un datubāzes projektējums mobilai sociālajai lietotnei (iOS un Android), kas palīdz cilvēkiem atrast jaunus draugus, domubiedrus un ceļabiedrus. Lietotne apvieno ierakstu plūsmu, privātās ziņas, saderīgu lietotāju meklēšanu pēc vienkāršota MBTI personības testa un kopīgām interesēm, kā arī tikšanos un ceļojumu izveidi ar attēlošanu kartē. Dokumentā ir sniegts sistēmas vispārējais apraksts, konceptuālais datu modelis, sešu moduļu funkcionālās prasības, nefunkcionālās prasības, kā arī datubāzes loģiskais un fiziskais modelis ar tabulu aprakstiem.],
      keywords: ("Mobilā lietotne", "MBTI saderība", "Ceļabiedru meklēšana", "Pasākumi"),
    ),
    secondary: (
      text: [This practical work contains the requirements specification and database design of a mobile social application (iOS and Android) that helps people find new friends, like-minded people and travel companions. The application combines a social feed, private messages, a search for compatible users based on a simplified MBTI personality test and shared interests, and the creation of meetups and trips shown on a map. The document presents the general description of the system, the conceptual data model, the functional requirements of six modules, the non-functional requirements, and the logical and physical database models with descriptions of all tables.],
      keywords: ("Mobile application", "MBTI compatibility", "Travel companions", "Events"),
    ),
  ),
  description: [Ceļabiedru un domubiedru meklēšanas platformas prasību specifikācija un datubāzes projektējums (programminženierijas praktiskais darbs).],
)

#set heading(numbering: none)
= Apzīmējumu saraksts

/ ADM: Administrators – lietotāju grupa ar tiesībām pārvaldīt saturu un lietotājus.
/ API: Application Programming Interface – lietojumprogrammas saskarne.
/ DPD: Datu plūsmu diagramma.
/ EMSG: Error message – kļūdas paziņojums (sk. 2.2.2).
/ FK: Foreign key – ārējā atslēga datubāzes tabulā.
/ GDPR: General Data Protection Regulation – Vispārīgā datu aizsardzības regula (Regula (ES) 2016/679).
/ GUEST: Vieslietotājs – nepieslēdzies lietotājs.
/ MBTI: Myers-Briggs Type Indicator – Maiersas–Brigsas tipu indikators (četru burtu personības tips, piem., INFP).
/ NULL: Datubāzes lauka tukša vērtība; ja lauks nepieļauj NULL, tas ir obligāts.
/ Pasākums: Lietotāja izveidota tikšanās vai ceļojums.
/ PK: Primary key – primārā atslēga datubāzes tabulā.
/ Push paziņojums: Paziņojums, ko lietotājs saņem savā mobilās ierīces saskarnē, kamēr lietotne nav atvērta.
/ SMSG: System message – sistēmas (veiksmes vai informatīvs) paziņojums (sk. 2.2.2).
/ SYS: Sistēma – automātiski veicamas darbības bez lietotāja līdzdalības.
/ TLS: Transport Layer Security – datu pārsūtīšanas šifrēšanas protokols.
/ USER: Reģistrēts lietotājs – lietotājs ar izveidotu profilu.

= Ievads
== Nolūks
Dokuments ir izstrādāts programminženierijas kursa praktiskā darba ietvaros. Tajā aprakstīts izstrādājamās lietotnes vispārējais apraksts, programmatūras prasību specifikācija (funkcionālās un nefunkcionālās prasības) un datubāzes projektējums. Dokuments paredzēts izstrādes komandai, nākotnes sistēmas administratoriem un darba vērtēšanas komisijai.
== Darbības sfēra
Izstrādājamā sistēma ir starptautiska sociālā mobilā lietotne iOS un Android ierīcēm, kas paredzēta cilvēkiem, kuri vēlas atrast jaunus draugus, domubiedrus un ceļabiedrus. Lietotāji veido profilu, norāda intereses un izpilda vienkāršotu MBTI testu, pēc kura sistēma piedāvā saderīgus lietotājus. Lietotāji publicē ierakstus ierakstu plūsmā, komentē tos, sūta privātas ziņas, kā arī izveido tikšanās un ceļojumus, kas ir redzami kartē un kuriem citi lietotāji var pieteikties. Administrators izskata lietotāju sūdzības, dzēš nevēlamu saturu un bloķē lietotājus.

Lietotne nav paredzēta romantisko attiecību meklēšanai, ceļojumu maršrutu plānošanai, maksājumiem vai reklāmai. Šajā dokumenta versijā ir ietverts minimāls funkciju apjoms. Nākamajām versijām ir atliktas šādas iespējas: lietotāju identitātes verifikācija, pieslēgšanās ar Google vai Apple kontu, sekošana lietotājiem, ierakstu kopīgošana plūsmā, privātuma un paziņojumu iestatījumi, lietotāju atrašanās vietas rādīšana kartē, administratoru kontu pārvaldība un sarežģītāka sūdzību apstrāde (brīdinājumi, noteikumu saraksts).
== Saistība ar citiem dokumentiem
Dokumenta struktūra un noformējums veidots, ņemot vērā standarta LVS 68:1996 “Programmatūras prasību specifikācijas ceļvedis” @LVS68 un LVS 72:1996 “Ieteicamā prakse programmatūras projektējuma aprakstīšanai” @LVS72 prasības, kā arī programminženierijas kursa praktisko darbu materiālus un vadlīnijas.
== Pārskats
Dokumenta struktūru veido trīs daļas:
+ Vispārējais apraksts – esošā stāvokļa apraksts, produkta perspektīva, darījumprasības, sistēmas lietotāji, vispārējie ierobežojumi, pieņēmumi un atkarības.
+ Programmatūras prasību specifikācija – konceptuālais datu modelis, funkcionālās prasības (moduļi, funkcijas, paziņojumi, datu plūsmu diagrammas un funkciju apraksti) un nefunkcionālās prasības.
+ Programmatūras projektējuma apraksts – datubāzes projektējums (loģiskais modelis, fiziskais modelis un tabulu apraksti). Funkciju projektējums un lietotāja saskarņu projektējums šajā dokumenta versijā nav iekļauts.

#set heading(numbering: "1.")

= Vispārējais apraksts

== Esošā stāvokļa apraksts
Cilvēkiem, kuri vēlas atrast jaunus draugus vai ceļabiedrus, šobrīd jāizmanto vairākas atsevišķas lietotnes: sociālie tīkli ierakstu publicēšanai, pasākumu organizēšanas platformas un ceļotāju forumi. Neviena no tām parasti nesniedz priekšstatu par to, cik labi cilvēki savstarpēji saderas, un lietotājam jāpārslēdzas starp vairākām vidēm. Rezultātā, iebraucot jaunā pilsētā vai meklējot kompāniju savam hobijam, ir grūti ātri un droši atrast domubiedrus. Izstrādājamā lietotne šīs iespējas apvieno vienā platformā: lietotājs atrod cilvēkus pēc MBTI tipa un interesēm, sazinās ar tiem privātās ziņās un kopā ar tiem piedalās tikšanās vai ceļojumos, kas attēloti kartē.

== Pasūtītājs
Platforma aprakstīta pēc studentu grupas iniciatīvas programminženierijas kursa ietvaros.

== Produkta perspektīva
Lietotne ir mobila platforma iOS un Android ierīcēm ar servera daļu un relāciju datubāzi (piemēram, PostgreSQL). Tā nav daļa no citas sistēmas, taču izmanto divus ārējos pakalpojumus:
- karšu serviss (piemēram, Google Maps) – vietas izvēlei pasākuma izveidē un pasākumu attēlošanai kartē;
- push paziņojumu serviss (piemēram, Firebase Cloud Messaging) – paziņojumu piegādei lietotāju ierīcēm.

Lietotāji ar ārējiem servisiem tieši nesadarbojas – visa saziņa notiek caur sistēmu (sk. @fig-dpd0).

== Darījumprasības
Šajā nodaļā lietotāju iespējas uzskaitītas pa lietotāju grupām. Saraksti ir izveidoti no funkciju tabulas (@function-modules), iekavās norādīts funkcijas identifikators.

=== Vieslietotāja iespējas
#role-list("GUEST")

=== Reģistrēta lietotāja iespējas
#role-list("USER")

=== Administratora iespējas
#role-list("ADM")

=== Sistēmas automātiskās darbības
#role-list("SYS")

== Sistēmas lietotāji
Sistēmā ir trīs lietotāju grupas.

*Vieslietotājs* ir nepieslēdzies lietotājs. Viņš var iepazīties ar lietotnes aprakstu, lietošanas noteikumiem un GDPR politiku, reģistrēties un pieslēgties. Citas funkcijas viņam nav pieejamas.

*Reģistrēts lietotājs* ir lietotājs ar izveidotu profilu. Viņš var rediģēt profilu un izvēlēties intereses, izpildīt MBTI testu un meklēt saderīgus lietotājus, publicēt ierakstus, komentēt tos un atzīmēt ar „patīk”, kopīgot ierakstu ar saiti, sūtīt privātas ziņas un bloķēt lietotājus čatā, izveidot pasākumus (tikšanās vai ceļojumus), pārlūkot tos kartē un pieteikties tiem, kā arī iesniegt sūdzības par citiem lietotājiem un viņu ierakstiem. Lietotājs var dzēst savu profilu.

*Administrators* ir lietotājs ar īpašu lomu, kura konts tiek izveidots datubāzē sistēmas uzstādīšanas laikā. Administrators pārvalda saturu un lietotājus: izskata sūdzības, dzēš ierakstus, komentārus un pasākumus, bloķē un atbloķē lietotājus platformā un pārvalda interešu sarakstu. Administrators nepublicē ierakstus un nepiedalās pasākumos.

#fig(dgm("dpd0"), [Programmatūras 0. līmeņa DPD], "fig-dpd0")

@fig-dpd0 parāda sistēmas mijiedarbību ar lietotāju grupām un ārējiem servisiem. Taisnstūri ir lietotāju grupas, aplis – visa sistēma kā viens process, punktotie apļi – ārējās sistēmas. Bultas ir datu plūsmas, to nosaukumi norādīti pie bultām. Lietotāji ar ārējām sistēmām tieši nesadarbojas.

== Vispārējie ierobežojumi
*Platformas atbalsts*: lietotne ir pieejama iOS 15 un jaunākām versijām, kā arī Android 12 un jaunākām versijām. Citām platformām lietotne netiek izstrādāta.

*Interneta savienojums*: visu funkciju izmantošanai nepieciešams interneta savienojums. Bezsaistes režīms nav paredzēts.

*Ārējie servisi*: pasākumu izveide un pārlūkošana ir atkarīga no karšu servisa, bet push paziņojumi – no push paziņojumu servisa. Ja serviss nav pieejams, attiecīgā funkcija nedarbojas, bet pārējās funkcijas turpina darboties.

*Datu aizsardzība*: personas datu apstrādei jāatbilst GDPR prasībām @GDPR. Reģistrējoties lietotājs piekrīt lietošanas noteikumiem un GDPR politikai, un viņš jebkurā laikā var dzēst savu profilu kopā ar saistītajiem datiem (LM_06).

*Valoda*: lietotnes saskarne ir latviešu valodā.

== Pieņēmumi un atkarības
+ Lietotājam ir iOS 15 vai jaunāka, vai Android 12 vai jaunāka ierīce ar interneta savienojumu.
+ Karšu serviss ir pieejams pasākumu izveides un pārlūkošanas brīdī.
+ Push paziņojumu serviss ir pieejams paziņojuma nosūtīšanas brīdī.
+ Datubāzes serveris ir pieejams atbilstoši pieejamības prasībām (sk. 2.3.4).
+ Pirmais administratora konts tiek izveidots datubāzē sistēmas uzstādīšanas laikā; administratoru kontu pārvaldības funkcijas šajā versijā nav aprakstītas.
+ Pietiekams skaits lietotāju veido saturu (ierakstus, pasākumus), lai lietotne būtu noderīga citiem lietotājiem.

= Programmatūras prasību specifikācija

== Konceptuālais datu modelis
Konceptuālais datu modelis (@fig-concept) apraksta sistēmā glabājamos datus. Tajā ir septiņas entitātes:
- *Lietotājs* – reģistrēts lietotājs vai administrators (lauks loma); MBTI tips glabājas lietotāja laukā mbti_tips, tāpēc saderības rezultāts atsevišķi netiek glabāts, bet tiek aprēķināts meklēšanas brīdī (SM_02);
- *Interese* – administratora pārvaldīts interešu saraksts;
- *Ieraksts* un *Komentārs* – ierakstu plūsmas saturs;
- *Ziņa* – privāta ziņa starp diviem lietotājiem (saruna atsevišķi netiek glabāta);
- *Pasākums* – tikšanās vai ceļojums; atšķirību nosaka lauks veids, tāpēc abiem pasākumu veidiem ir kopīga entitāte, funkcijas un paziņojumi;
- *Sūdzība* – lietotāja sūdzība par citu lietotāju vai viņa ierakstu.

#fig(dgm("concept"), [Konceptuālais datu modelis], "fig-concept")

@fig-concept parāda entitātes (taisnstūri ar atribūtu sarakstu), attiecības starp tām (rombi) un kardinalitāti (1 – viens, n un m – daudzi). Entitātēm identifikatori netiek rādīti; tie parādās loģiskajā modelī (3.1.1). Attiecība „piedalās” satur atribūtu pieteikšanās_datums. Attiecība „bloķē” saista lietotāju ar citu lietotāju; „sūta” un „saņem” saista lietotāju ar viņa nosūtītajām un saņemtajām ziņām.

== Funkcionālās prasības
Funkcionālās prasības ir sistēmas lietotāju vai automātisku procesu darbības, kas saistītas ar datu ievadi, apstrādi un izvadi. Funkcijas ir sagrupētas sešos moduļos. Funkciju apraksta tabulās ievaddati ir norādīti formā Entitāte.atribūts, kas atbilst konceptuālajam datu modelim (@fig-concept); obligātums atbilst tam, vai datubāzes lauks pieļauj NULL (sk. 3.1.3).

=== Sistēmas moduļi, to funkcijas, identifikatori un lietotāji
Lietotāju tipu saīsinājumi, kas izmantoti @function-modules: #roles.map(r => [#r.key – #lower(r.name)]).join(", ").

#figure(
  caption: [Funkciju sadalījums pa moduļiem un lietotāju tipiem],
  function-overview(),
) <function-modules>

@function-modules parāda, kuras funkcijas ietilpst katrā modulī un kuriem lietotāju tipiem tās ir pieejamas (x). Funkcijas identifikators sastāv no moduļa saīsinājuma un kārtas numura; tas tiek lietots visā dokumentā.

=== Sistēmas paziņojumi
Paziņojumi ir sadalīti sistēmas paziņojumos (SMSG, veiksmes vai informatīvi) un kļūdu paziņojumiem (EMSG). Figūriekavās norādītās vērtības ({objekts}, {lietotājvārds} u.c.) sistēma aizvieto ar konkrēto vērtību; vārds {objekts} tiek lietots atbilstošajā locījumā (piem., „profils”, „ieraksts”, „komentārs”, „pasākums”, „interese”, „sūdzība”, „ziņa”).

Kopīgie kļūdu paziņojumi EMSG_01 līdz EMSG_04 attiecas uz visām funkcijām atbilstoši @system-messages norādītajiem nosacījumiem, un funkciju aprakstos katrai funkcijai ir norādīts, kuri no tiem tai tiek piemēroti. Pārējie paziņojumi tiek norādīti katras funkcijas aprakstā.

#figure(
  caption: [Paziņojumu saraksts],
  messages-table(),
) <system-messages>

@system-messages parāda visus sistēmas un kļūdu paziņojumus, to tekstu un funkcijas, kuras tos izmanto. Funkciju saraksts šajā tabulā tiek veidots automātiski no funkciju aprakstiem.

=== Funkciju sadalījums pa moduļiem
Sistēmas moduļu savstarpējā mijiedarbība, mijiedarbība ar lietotāju grupām, ārējām sistēmām un datubāzi parādīta 1. līmeņa DPD (@fig-dpd1). Lietotāji un ārējās sistēmas sadarbojas tikai ar moduļiem, un tikai moduļi sadarbojas ar datubāzi; datu plūsmas ir saskaņotas ar 0. līmeņa DPD (@fig-dpd0).

#fig(dgm("dpd1"), [Programmatūras 1. līmeņa DPD], "fig-dpd1")

@fig-dpd1 parāda sešus moduļus (apļi), trīs lietotāju grupas (taisnstūri), datubāzi (atvērtais taisnstūris) un divas ārējās sistēmas (punktotie apļi). Bultas ir datu plūsmas ar nosaukumiem. Bulta no Pasākumu un kartes moduļa uz Ziņojumapmaiņas moduli apzīmē push paziņojuma pieprasījumu (PA_05 izsauc ZM_05).

Katrai entitātei vai saitei starp entitātēm ir funkcijas, kas datus izveido (C), nolasa (R), labo (U) un dzēš (D). @crud-matrix parāda šo atbilstību; tā ir izveidota automātiski no funkciju aprakstiem, un kompilācija neizdodas, ja kādai darbībai nav funkcijas un tā nav atzīmēta kā neparedzēta.

#figure(
  caption: [Entitāšu un saišu atbilstība funkcijām (CRUD)],
  crud-table(),
) <crud-matrix>

#crud-notes()
Lietotāja dzēšanas (LM_06), ieraksta dzēšanas (SP_04) un pasākuma dzēšanas (PA_03) gadījumā datubāze papildus dzēš saistītos ierakstus (ON DELETE CASCADE, sk. 3.1.3); matricā šīs kaskādes darbības nav atzīmētas atsevišķi.

#let mod-desc = (
  LM: [Lietotāju modulis nodrošina reģistrāciju, pieslēgšanos un atslēgšanos, profila apskati, rediģēšanu (ieskaitot interešu izvēli un paroles maiņu) un dzēšanu, kā arī lietotnes apraksta, noteikumu un GDPR informācijas apskati.],
  SM: [Saderības modulis nodrošina vienkāršota MBTI testa izpildi un saderīgo lietotāju meklēšanu. Lietotāja MBTI tips tiek saglabāts profilā (lauks mbti_tips), un saderība tiek aprēķināta meklēšanas brīdī, to nesaglabājot.],
  SP: [Ierakstu modulis nodrošina ierakstu publicēšanu, plūsmas skatīšanu, ierakstu rediģēšanu un dzēšanu, atzīmēšanu ar „patīk”, komentēšanu un ierakstu kopīgošanu ar saiti.],
  ZM: [Ziņojumapmaiņas modulis nodrošina privātu ziņu sūtīšanu, lasīšanu un dzēšanu, lietotāju bloķēšanu čatā un push paziņojumu sūtīšanu, izmantojot ārējo push paziņojumu servisu. Saruna sastāv no ziņām starp diviem lietotājiem, tāpēc atsevišķas sarunu tabulas nav.],
  PA: [Pasākumu un kartes modulis apvieno tikšanās un ceļojumus vienā entitātē Pasākums (lauks veids). Modulis nodrošina pasākumu izveidi, rediģēšanu, dzēšanu, pārlūkošanu kartē un sarakstā un pieteikšanos pasākumam. Vietas izvēlei un kartes attēlošanai tiek izmantots ārējais karšu serviss.],
  AM: [Administrēšanas modulis nodrošina sūdzību iesniegšanu, administratora veikto sūdzību izskatīšanu, lietotāju bloķēšanu platformā un interešu saraksta pārvaldību. Ierakstu, komentāru un pasākumu dzēšana administratoram ir pieejama attiecīgo moduļu funkcijās (SP_04, SP_07, PA_03).],
)

#for m in modules [
  === #m.name
  #mod-desc.at(m.key)

  #fig(dgm("dpd2-" + m.key), [2. līmeņa DPD: #lower(m.name)], "fig-dpd2-" + m.key)

  #ref(label("fig-dpd2-" + m.key)) parāda moduļa funkcijas (apļi), lietotāju grupas (taisnstūri), datu krātuves – entitātes un saites no konceptuālā modeļa (atvērtie taisnstūri) – un, ja tās ir saistītas ar moduli, ārējās sistēmas un citu moduļu funkcijas (punktotie apļi). Bultas ir datu plūsmas ar nosaukumiem. Bulta uz krātuvi apzīmē datu saglabāšanu, bulta no krātuves – datu nolasīšanu, abpusēja bulta – abas darbības.

  #module-function-tables(m.key)
]

== Nefunkcionālās prasības
Nefunkcionālās prasības ir formulētas tā, lai tās varētu pārbaudīt: katrai ir skaitliska robeža vai nosacījums, kas ir izpildīts vai nav izpildīts, un norādīta pārbaudes metode.

#let nfr-table(cap, lbl, rows) = [
  #figure(
    caption: cap,
    table(
      columns: (1fr, 4fr, 2.6fr),
      align: left + top,
      inset: 5pt,
      table.header([*ID*], [*Prasība*], [*Pārbaude*]),
      ..rows.map(r => ([#r.at(0)], [#r.at(1)], [#r.at(2)])).flatten(),
    ),
  )#label(lbl)
]
#let delete-funs = functions.filter(f => f.msgs.contains("SMSG_03")).map(f => f.id).join(", ")

=== Veiktspējas prasības
@nfr-perf apraksta sistēmas ātrdarbības prasības.

#nfr-table([Veiktspējas prasības], "nfr-perf", (
  ("VP_01", [Vismaz 95 % pieprasījumu pieslēgšanās (LM_02), profila apskates (LM_04), plūsmas ielādes (SP_01) un pasākumu saraksta ielādes (PA_04) funkcijās tiek izpildīti ne ilgāk kā 3 sekundēs, ja lietotāja savienojuma ātrums ir vismaz 5 Mbit/s.], [Slodzes tests: 200 vienlaicīgi lietotāji, 1000 pieprasījumu katrai funkcijai; mēra 95. procentili.]),
  ("VP_02", [Vismaz 95 % saderīgo lietotāju meklēšanas pieprasījumu (SM_02) tiek izpildīti ne ilgāk kā 5 sekundēs, ja datubāzē ir 10 000 lietotāju ar MBTI tipu.], [Tests ar 10 000 testa lietotāju; mēra 95. procentili.]),
  ("VP_03", [Vismaz 95 % nosūtīto ziņu (ZM_01) parādās saņēmēja ierīcē ne vēlāk kā 3 sekundes pēc nosūtīšanas, ja abi lietotāji ir pieslēgti.], [Tests ar 100 ziņām starp diviem testa lietotājiem; mēra laiku līdz parādīšanai.]),
  ("VP_04", [Vismaz 95 % push paziņojumu (ZM_05) tiek nodoti push paziņojumu servisam ne vēlāk kā 10 sekundes pēc notikuma reģistrēšanas.], [Salīdzina notikuma un nodošanas laika zīmogus servera žurnālā 100 paziņojumiem.]),
  ("VP_05", [Sistēma vienlaikus apkalpo vismaz 200 pieslēgtus lietotājus, un kļūdas EMSG_02 īpatsvars šajā slodzē nepārsniedz 1 % pieprasījumu.], [Slodzes tests ar 200 vienlaicīgiem lietotājiem 10 minūtes.]),
))

=== Izmantojamība
@nfr-use apraksta lietotāja saskarnes prasības.

#nfr-table([Izmantojamības prasības], "nfr-use", (
  ("IZ_01", [Visi lietotāja saskarnes teksti un paziņojumi no 2.2.2 ir latviešu valodā (100 % tekstu).], [Visu ekrānu un paziņojumu pārskatīšana.]),
  ("IZ_02", [Funkcijas LM_04, SM_02, SP_01, ZM_02 un PA_04 ir sasniedzamas ne vairāk kā 3 pieskārienos no galvenās navigācijas joslas.], [Manuāla pārbaude uz testa ierīces.]),
  ("IZ_03", [Pirms katras dzēšanas funkcijas (#delete-funs) izpildes tiek parādīts apstiprinājuma jautājums SMSG_03.], [Katras minētās funkcijas izpilde; dzēšana nenotiek, kamēr lietotājs neapstiprina.]),
  ("IZ_04", [Teksta un fona krāsu kontrasts ir vismaz 4,5:1.], [Kontrasta pārbaudes rīks visiem ekrāniem.]),
  ("IZ_05", [Saskarne darbojas portreta orientācijā ekrāniem ar platumu no 360 līdz 430 loģiskajiem pikseļiem bez horizontālas ritināšanas.], [Pārbaude emulatoros ar platumiem 360, 390 un 430.]),
  ("IZ_06", [Katrs kļūdu paziņojums no 2.2.2 tiek parādīts ar tur norādīto tekstu (22 no 22).], [Katras kļūdas izraisīšana testa vidē.]),
))

=== Drošības prasības
@nfr-sec apraksta datu un piekļuves drošības prasības.

#nfr-table([Drošības prasības], "nfr-sec", (
  ("DR_01", [Paroles tiek glabātas kā Argon2id vai bcrypt hešs; datubāzē ir 0 paroles atklātā veidā.], [Datubāzes lauka paroles_hešs pārskatīšana.]),
  ("DR_02", [Visa datu pārsūtīšana starp lietotni un serveri notiek, izmantojot HTTPS ar TLS 1.2 vai jaunāku versiju.], [Mēģinājums savienoties bez TLS vai ar TLS 1.1 tiek noraidīts.]),
  ("DR_03", [Serveris katrā pieprasījumā pārbauda lietotāja lomu un objekta piederību; 100 % mēģinājumu veikt darbību bez tiesībām beidzas ar EMSG_04 un datu izmaiņu nenotiek.], [Automatizēti testi: katras funkcijas izsaukums ar nepareizu lomu un svešu objektu.]),
  ("DR_04", [Citu lietotāju e-pasta adreses un paroļu hešs netiek atgriezti reģistrētam lietotājam (LM_04) – tikai administratoram var tikt atgriezts e-pasts.], [API atbilžu pārbaude profila pieprasījumiem.]),
  ("DR_05", [Visi datubāzes vaicājumi ir parametrizēti; nav neviena vaicājuma, kurā lietotāja ievade tiek savienota ar SQL tekstu.], [Koda pārskatīšana un SQL injekcijas testi.]),
  ("DR_06", [Lietotāja sesija beidzas pēc 7 dienām bez aktivitātes; pēc tam tiek parādīts EMSG_03.], [Tests ar sesiju, kuras pēdējā aktivitāte ir 7 dienas veca.]),
  ("DR_07", [Pēc profila dzēšanas (LM_06) nevienā datubāzes tabulā nav neviena ieraksta, kas atsaucas uz dzēsto lietotāju (0 ierakstu).], [SQL pārbaude visās 11 tabulās pēc testa lietotāja dzēšanas.]),
))

=== Pieejamības prasības
@nfr-avail apraksta pieejamības un atbalstīto platformu prasības.

#nfr-table([Pieejamības prasības], "nfr-avail", (
  ("PI_01", [Sistēma ir pieejama vismaz 99 % kalendārā mēneša laika, neieskaitot plānoto apkopi, kas nepārsniedz 4 stundas mēnesī un notiek plkst. 00:00–06:00.], [Pieejamības monitorings mēneša laikā.]),
  ("PI_02", [Ja karšu serviss vai push paziņojumu serviss nav pieejams, visas funkcijas, kas no tā nav atkarīgas, turpina darboties (100 %); no karšu servisa ir atkarīgas PA_01, PA_02 un PA_04, no push servisa – ZM_05.], [Servisa atslēgšana testa vidē un visu pārējo funkciju izpilde.]),
  ("PI_03", [Lietotne darbojas iOS 15 un jaunākās versijās un Android 12 un jaunākās versijās.], [Funkciju pārbaude uz ierīcēm ar iOS 15 un Android 12.]),
))

=== Uzturēšanas prasības
@nfr-maint apraksta sistēmas uzturēšanas prasības.

#nfr-table([Uzturēšanas prasības], "nfr-maint", (
  ("UZ_01", [Datubāzes rezerves kopija tiek izveidota vismaz reizi 24 stundās un tiek glabāta vismaz 14 dienas ārpus galvenā servera.], [Rezerves kopiju saraksta pārbaude 14 dienu periodā.]),
  ("UZ_02", [Pēc sistēmas bojājuma datu zudums nepārsniedz 24 stundas, un pamatfunkciju darbība tiek atjaunota ne vēlāk kā 8 stundu laikā.], [Atjaunošanas mēģinājums no rezerves kopijas testa vidē ar laika mērījumu.]),
  ("UZ_03", [Servera kļūdas un push paziņojumu servisa kļūdas tiek reģistrētas žurnālā un glabātas vismaz 30 dienas.], [Kļūdas izraisīšana un ieraksta atrašana žurnālā.]),
))

= Programmatūras projektējuma apraksts

== Datubāzes projektējums
Datubāzes projektējums ir veidots pēc konceptuālā datu modeļa (@fig-concept) un aprakstīts relāciju datubāzei (piemēram, PostgreSQL). Datubāzē ir #db-tables.len() tabulas: #entities.len() tabulas atbilst entitātēm un #links.len() starptabulas atbilst m:n attiecībām.

=== Datubāzes loģiskais modelis
Loģiskajā modelī katra entitāte ir kļuvusi par tabulu ar primāro atslēgu (PK), bet attiecības 1:n ir realizētas ar ārējām atslēgām (FK) bērna tabulā. Attiecības m:n ir aizstātas ar starptabulām: #links.map(l => [#l.table (attiecība „#l.name”)]).join(", "). Visiem nosaukumiem lietoti latīņu burti bez diakritiskajām zīmēm.

#fig(dgm("logical"), [Datubāzes loģiskais modelis], "fig-logical")

@fig-logical parāda tabulas ar kolonnām un atslēgu apzīmējumiem (PK – primārā atslēga, FK – ārējā atslēga; primārās atslēgas kolonnas ir pasvītrotas). Katra līnija savieno ārējās atslēgas kolonnu (FK) ar tās tabulas primārās atslēgas kolonnu (PK), uz kuru tā atsaucas; simbols „vārna” pie FK apzīmē „daudzi”, dubultā svītra pie PK – „viens”. Divas līnijas starp vienām un tām pašām tabulām nozīmē divas ārējās atslēgas (piemēram, ziņas sūtītājs un saņēmējs).

=== Datubāzes fiziskais modelis
Fiziskajā modelī katrai kolonnai ir piešķirts datu tips. Primārās atslēgas ir veseli skaitļi (INTEGER), kuru vērtības datubāze ģenerē automātiski. Datumi un laiki glabājas kā TIMESTAMP, atzīmes (loma, statuss, veids) – kā SMALLINT ar kodu atšifrējumu tabulu aprakstos (3.1.3).

#fig(dgm("physical"), [Datubāzes fiziskais modelis], "fig-physical")

@fig-physical parāda tās pašas tabulas, papildinot kolonnas ar datu tipiem. Atzīme NULL pie tipa norāda, ka kolonna pieļauj tukšu vērtību; kolonnām bez šīs atzīmes ir ierobežojums NOT NULL.

=== Datubāzes tabulu apraksti
Katras tabulas aprakstā (@dbt-lietotajs un turpmākajās tabulās) ir norādīts kolonnas nosaukums, datu tips (kopā ar uzskaitāmo vērtību atšifrējumu), apraksts, vai kolonna pieļauj NULL, un atslēgas veids (PK, FK vai PK, FK). Pirms katras tabulas norādīts, kuras funkcijas tabulai veic datu izveidi (C), nolasīšanu (R), labošanu (U) un dzēšanu (D). Ja tabulas ārējā atslēga atsaucas uz citu tabulu, aprakstā norādīts, kas notiek, dzēšot atsauces ierakstu (ON DELETE CASCADE vai SET NULL).

#for (i, t) in db-tables.enumerate() { db-description(t, i) }

#set heading(numbering: none)
#heading(level: 1, outlined: false)[Dokumentārā lapa]

#bibliography-here()
