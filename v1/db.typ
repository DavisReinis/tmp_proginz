// =====================================================================
// db.typ - v1 datubāzes projektējums (3. nodaļa), veidots pēc v1 konceptuālā
// datu modeļa (assets/konceptualais_modelis.drawio.png).
// Viens datu avots: no šejienes tiek ģenerētas tabulu apraksti (3.1.3), un
// tools/gen_db_drawio.py zīmē loģisko un fizisko modeli (draw.io).
// Kolonnā: n - nosaukums, pg - datu tips, nn - true = NOT NULL, key - PK/FK/"PK, FK",
//          ref - (tabula, kolonna) FK gadījumā, del - ON DELETE darbība.
// fn - funkcijas (no 2.2.1 tabulas), kas veic C/R/U/D darbības ar tabulu.
// =====================================================================

#let NP = "nav paredzēts"

#let db1 = (
  (
    t: "lietotajs",
    purpose: "satur visu reģistrēto lietotāju, virslietotāju un administratoru datus. Ieraksts rodas, lietotājam reģistrējoties (LM_01, LM_02) vai administratoram izveidojot virslietotāja kontu (AM_01)",
    fn: (C: "LM_01, LM_02, AM_01", R: "LM_05, LM_06, SP_07, MD_02", U: "LM_03, LM_08, LM_09, MD_06, MD_07, MD_08, AM_02, AM_04", D: "LM_04, AM_05"),
    cols: (
      (n: "lietotaja_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls lietotāja identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "lietotajvards", pg: "VARCHAR(40)", nn: true, d: "Lietotāja izvēlētais lietotājvārds. Vērtībai jābūt unikālai."),
      (n: "vards", pg: "VARCHAR(100)", nn: false, d: "Lietotāja vārds."),
      (n: "uzvards", pg: "VARCHAR(100)", nn: false, d: "Lietotāja uzvārds."),
      (n: "epasts", pg: "VARCHAR(140)", nn: true, d: "Lietotāja e-pasta adrese. Vērtībai jābūt unikālai."),
      (n: "paroles_hess", pg: "VARCHAR(255)", nn: false, d: "Paroles hešs; NULL, ja lietotājs reģistrējies ar ārējo autentifikācijas pakalpojumu (OAuth2)."),
      (n: "dzimsanas_datums", pg: "DATE", nn: false, d: "Lietotāja dzimšanas datums."),
      (n: "profila_attels", pg: "VARCHAR(255)", nn: false, d: "Saite uz profila attēla failu."),
      (n: "registracijas_datums", pg: "TIMESTAMP", nn: true, d: "Konta izveides datums un laiks."),
      (n: "valsts", pg: "VARCHAR(100)", nn: false, d: "Lietotāja valsts."),
      (n: "pilseta", pg: "VARCHAR(100)", nn: false, d: "Lietotāja pilsēta."),
      (n: "statuss", pg: "SMALLINT", nn: true, codes: ("0 – bloķēts", "1 – aktīvs", "2 – uz laiku deaktivizēts"), d: "Konta statuss."),
      (n: "deaktivizets_lidz", pg: "TIMESTAMP", nn: false, d: "Datums un laiks, līdz kuram konts ir deaktivizēts; NULL, ja konts nav deaktivizēts."),
      (n: "darba_laiks", pg: "VARCHAR(100)", nn: false, d: "Virslietotāja konta aktīvais darba laiks (piem., 09:00–17:00); NULL parastiem lietotājiem."),
      (n: "loma", pg: "SMALLINT", nn: true, codes: ("0 – parasts reģistrēts lietotājs", "1 – verificēts reģistrēts lietotājs", "2 – virslietotājs", "3 – administrators"), d: "Lietotāja loma sistēmā."),
      (n: "verifikacijas_statuss", pg: "SMALLINT", nn: true, codes: ("0 – nav verificēts", "1 – gaida pārbaudi", "2 – verificēts"), d: "Lietotāja identitātes verifikācijas statuss."),
      (n: "verifikacijas_datums", pg: "TIMESTAMP", nn: false, d: "Verifikācijas pabeigšanas datums un laiks; NULL, ja lietotājs nav verificēts."),
      (n: "autentifikacijas_veids", pg: "SMALLINT", nn: true, codes: ("0 – e-pasts un parole", "1 – Google", "2 – Apple"), d: "Veids, kā lietotājs reģistrējies un pieslēdzas."),
      (n: "piekrisana_gdpr", pg: "BOOLEAN", nn: true, d: "Vai lietotājs ir piekritis lietošanas noteikumiem un GDPR."),
      (n: "privatuma_iestatijumi", pg: "TEXT", nn: false, d: "Lietotāja privātuma iestatījumu parametri (piem., ziņu saņemšanas preferences); NULL, ja lietotājs tos nav mainījis."),
    ),
  ),
  (
    t: "mbti_rezultats",
    purpose: "satur lietotāju MBTI testu rezultātus. Ieraksts rodas, lietotājam pabeidzot testu (SM_01)",
    fn: (C: "SM_01", R: "SM_02, SM_03", U: NP, D: NP),
    cols: (
      (n: "mbti_rezultata_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls MBTI rezultāta identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "lietotaja_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas ieguvis rezultātu (attiecība „iegūst”)."),
      (n: "mbti_tips", pg: "CHAR(4)", nn: true, d: "MBTI personības tips (piem., INFP)."),
      (n: "izpildes_datums", pg: "TIMESTAMP", nn: true, d: "Testa izpildes datums un laiks."),
    ),
  ),
  (
    t: "interese",
    purpose: "satur interešu sarakstu, no kura lietotāji izvēlas savas intereses (LM_03)",
    fn: (C: NP, R: "LM_03, SM_02", U: NP, D: NP),
    cols: (
      (n: "interese_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls intereses identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "nosaukums", pg: "VARCHAR(60)", nn: true, d: "Intereses nosaukums."),
      (n: "kategorija", pg: "VARCHAR(60)", nn: true, d: "Kategorija, kurai interese pieder."),
    ),
  ),
  (
    t: "lietotajs_interese",
    purpose: "saista lietotājus ar viņu izvēlētajām interesēm (attiecība „norāda”, m:n)",
    fn: (C: "LM_03", R: "SM_02, SM_03", U: NP, D: "LM_03"),
    cols: (
      (n: "lietotaja_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas norāda interesi."),
      (n: "interese_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("interese", "interese_id"), del: "CASCADE", d: "Norādītā interese."),
    ),
  ),
  (
    t: "valoda",
    purpose: "satur valodu sarakstu, no kura lietotāji izvēlas valodas, kurās runā (LM_03)",
    fn: (C: NP, R: "LM_03", U: NP, D: NP),
    cols: (
      (n: "valoda_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls valodas identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "nosaukums", pg: "VARCHAR(60)", nn: true, d: "Valodas nosaukums."),
      (n: "valodas_kods", pg: "VARCHAR(10)", nn: true, d: "Valodas kods (piem., lv, en). Vērtībai jābūt unikālai."),
    ),
  ),
  (
    t: "lietotajs_valoda",
    purpose: "saista lietotājus ar valodām, kurās viņi runā (attiecība „runā”, m:n)",
    fn: (C: "LM_03", R: NP, U: NP, D: "LM_03"),
    cols: (
      (n: "lietotaja_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas runā valodā."),
      (n: "valoda_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("valoda", "valoda_id"), del: "CASCADE", d: "Valoda, kurā lietotājs runā."),
    ),
  ),
  (
    t: "saderiba",
    purpose: "satur aprēķinātos saderības rezultātus starp diviem lietotājiem. Ieraksts rodas, sistēmai aprēķinot saderību (SM_02, SM_03)",
    fn: (C: "SM_02, SM_03", R: "SM_02, SM_03", U: NP, D: NP),
    cols: (
      (n: "saderibas_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls saderības identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "vertetaja_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kam saderība tiek aprēķināta (attiecība „vērtē”)."),
      (n: "vertetais_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, ar kuru saderība tiek aprēķināta (attiecība „tiek vērtēts”)."),
      (n: "rezultats", pg: "SMALLINT", nn: true, d: "Saderības rezultāts procentos (0–100)."),
      (n: "aprekina_laiks", pg: "TIMESTAMP", nn: true, d: "Rezultāta aprēķina datums un laiks."),
    ),
  ),
  (
    t: "saruna",
    purpose: "satur lietotāju sarunas. Ieraksts rodas, lietotājam nosūtot pirmo ziņu citam lietotājam (CH_01)",
    fn: (C: "CH_01", R: "CH_02", U: NP, D: NP),
    cols: (
      (n: "sarunas_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls sarunas identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "uzsaceja_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas sarunu uzsācis (attiecība „uzsāk”)."),
      (n: "sanemeja_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas saņem sarunu (attiecība „saņem”)."),
      (n: "izveides_datums", pg: "TIMESTAMP", nn: true, d: "Sarunas izveides datums un laiks."),
      (n: "sadala", pg: "SMALLINT", nn: true, codes: ("0 – galvenā sadaļa", "1 – ziņas no neverificētiem lietotājiem"), d: "Saņēmēja sarunu sadaļa, kurā saruna tiek attēlota."),
    ),
  ),
  (
    t: "zina",
    purpose: "satur sarunu ziņas. Ieraksts rodas, lietotājam nosūtot ziņu (CH_01)",
    fn: (C: "CH_01", R: "CH_02", U: "CH_02 (piegādes statuss)", D: NP),
    cols: (
      (n: "zinas_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls ziņas identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "sarunas_id", pg: "INTEGER", nn: true, key: "FK", ref: ("saruna", "sarunas_id"), del: "CASCADE", d: "Saruna, kurai ziņa pieder (attiecība „satur”)."),
      (n: "sutitaja_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Ziņas sūtītājs (attiecība „sūta”)."),
      (n: "teksts", pg: "VARCHAR(1000)", nn: false, d: "Ziņas teksts; NULL, ja ziņa satur tikai pielikumu."),
      (n: "nosutisanas_laiks", pg: "TIMESTAMP", nn: true, d: "Ziņas nosūtīšanas datums un laiks."),
      (n: "piegades_statuss", pg: "SMALLINT", nn: true, codes: ("0 – nosūtīta", "1 – izlasīta"), d: "Ziņas piegādes statuss."),
      (n: "pielikuma_saite", pg: "VARCHAR(255)", nn: false, d: "Saite uz ziņas pielikuma failu; NULL, ja pielikuma nav."),
    ),
  ),
  (
    t: "ieraksts",
    purpose: "satur lietotāju publicētos ierakstus sociālajā plūsmā. Ieraksts rodas, lietotājam publicējot ierakstu (SP_03)",
    fn: (C: "SP_03", R: "SP_01, SP_07", U: NP, D: "MD_04"),
    cols: (
      (n: "ieraksta_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls ieraksta identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "autora_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Ieraksta autors (attiecība „publicē”)."),
      (n: "teksts", pg: "VARCHAR(2000)", nn: false, d: "Ieraksta teksts; NULL, ja ieraksts satur tikai mediju failu."),
      (n: "redzamiba", pg: "SMALLINT", nn: true, codes: ("0 – publisks", "1 – tikai sekotājiem"), d: "Ieraksta redzamība."),
      (n: "publicesanas_datums", pg: "TIMESTAMP", nn: true, d: "Ieraksta publicēšanas datums un laiks."),
    ),
  ),
  (
    t: "medija_fails",
    purpose: "satur ierakstiem pievienotos attēlus un video. Ieraksts rodas, lietotājam publicējot ierakstu ar failu (SP_03)",
    fn: (C: "SP_03", R: "SP_01", U: NP, D: "MD_04"),
    cols: (
      (n: "medija_faila_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls mediju faila identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "ieraksta_id", pg: "INTEGER", nn: true, key: "FK", ref: ("ieraksts", "ieraksta_id"), del: "CASCADE", d: "Ieraksts, kuram fails pievienots (attiecība „satur”)."),
      (n: "veids", pg: "SMALLINT", nn: true, codes: ("0 – attēls", "1 – video"), d: "Mediju faila veids."),
      (n: "augsupielades_datums", pg: "TIMESTAMP", nn: true, d: "Faila augšupielādes datums un laiks."),
      (n: "saites_adrese", pg: "VARCHAR(255)", nn: true, d: "Saite uz failu."),
      (n: "izmers", pg: "INTEGER", nn: true, d: "Faila izmērs baitos."),
    ),
  ),
  (
    t: "komentars",
    purpose: "satur komentārus pie ierakstiem. Ieraksts rodas, lietotājam komentējot ierakstu (SP_05)",
    fn: (C: "SP_05", R: "SP_01", U: NP, D: "MD_04"),
    cols: (
      (n: "komentara_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls komentāra identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "ieraksta_id", pg: "INTEGER", nn: true, key: "FK", ref: ("ieraksts", "ieraksta_id"), del: "CASCADE", d: "Ieraksts, pie kura komentārs pievienots (attiecība „saņem”)."),
      (n: "autora_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Komentāra autors (attiecība „raksta”)."),
      (n: "teksts", pg: "VARCHAR(500)", nn: true, d: "Komentāra teksts."),
      (n: "izveides_datums", pg: "TIMESTAMP", nn: true, d: "Komentāra izveides datums un laiks."),
    ),
  ),
  (
    t: "ieraksta_patik",
    purpose: "saglabā, kuri lietotāji ir atzīmējuši kuru ierakstu ar „patīk” (attiecība „atzīmē patīk”, m:n). Ieraksti rodas, lietotājam atzīmējot ierakstu (SP_04)",
    fn: (C: "SP_04", R: "SP_01", U: NP, D: "SP_04"),
    cols: (
      (n: "lietotaja_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas atzīmējis ierakstu."),
      (n: "ieraksta_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("ieraksts", "ieraksta_id"), del: "CASCADE", d: "Atzīmētais ieraksts."),
    ),
  ),
  (
    t: "kopigosana",
    purpose: "saglabā, kuri lietotāji ir kopīgojuši kuru ierakstu (attiecība „kopīgo”, m:n). Ieraksti rodas, lietotājam kopīgojot ierakstu (SP_02)",
    fn: (C: "SP_02", R: "SP_01", U: NP, D: NP),
    cols: (
      (n: "lietotaja_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas kopīgo ierakstu."),
      (n: "ieraksta_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("ieraksts", "ieraksta_id"), del: "CASCADE", d: "Kopīgotais ieraksts."),
      (n: "papildu_teksts", pg: "VARCHAR(500)", nn: false, d: "Lietotāja pievienotais papildu teksts; NULL, ja nav pievienots."),
    ),
  ),
  (
    t: "seko",
    purpose: "saglabā, kuri lietotāji seko kuriem lietotājiem (attiecība „seko”, m:n). Ieraksti rodas, lietotājam uzsākot sekošanu (SP_06)",
    fn: (C: "SP_06", R: NP, U: NP, D: NP),
    cols: (
      (n: "sekotaja_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas seko."),
      (n: "sekojama_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kuram seko."),
    ),
  ),
  (
    t: "blokesana",
    purpose: "saglabā, kuri lietotāji ir bloķējuši kuru lietotāju čatā (attiecība „bloķē čatā”, m:n). Ieraksti rodas, lietotājam bloķējot citu lietotāju (CH_03)",
    fn: (C: "CH_03", R: "CH_01", U: NP, D: NP),
    cols: (
      (n: "bloketaja_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas veic bloķēšanu."),
      (n: "bloketa_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kuru bloķē."),
    ),
  ),
  (
    t: "lokacija",
    purpose: "satur vietas, kurās notiek tikšanās vai uz kurām dodas ceļojumu grupas. Ieraksts rodas, lietotājam izveidojot tikšanos vai ceļojumu grupu (ET_01, ET_03)",
    fn: (C: "ET_01, ET_03", R: "ET_02, ET_04, MP_01", U: NP, D: NP),
    cols: (
      (n: "lokacijas_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls lokācijas identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "platums", pg: "NUMERIC(9,6)", nn: true, d: "Ģeogrāfiskais platums."),
      (n: "garums", pg: "NUMERIC(9,6)", nn: true, d: "Ģeogrāfiskais garums."),
      (n: "adrese", pg: "VARCHAR(200)", nn: false, d: "Vietas adrese; NULL, ja adrese nav norādīta."),
      (n: "valsts", pg: "VARCHAR(100)", nn: true, d: "Valsts, kurā vieta atrodas."),
      (n: "pilseta", pg: "VARCHAR(100)", nn: true, d: "Pilsēta, kurā vieta atrodas."),
    ),
  ),
  (
    t: "tiksanas",
    purpose: "satur lietotāju izveidotās tikšanās un aktivitātes. Ieraksts rodas, lietotājam izveidojot tikšanos (ET_01)",
    fn: (C: "ET_01", R: "ET_02", U: NP, D: "MD_04"),
    cols: (
      (n: "tiksanas_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls tikšanās identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "organizatora_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Tikšanās organizators (attiecība „organizē”)."),
      (n: "lokacijas_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lokacija", "lokacijas_id"), del: "RESTRICT", d: "Tikšanās norises vieta (attiecība „notiek”)."),
      (n: "nosaukums", pg: "VARCHAR(100)", nn: true, d: "Tikšanās nosaukums."),
      (n: "sakuma_laiks", pg: "TIMESTAMP", nn: true, d: "Tikšanās sākuma datums un laiks."),
      (n: "veids", pg: "VARCHAR(60)", nn: true, d: "Aktivitātes veids vai kategorija."),
      (n: "apraksts", pg: "VARCHAR(1000)", nn: true, d: "Tikšanās apraksts."),
      (n: "dalibnieku_limits", pg: "INTEGER", nn: false, d: "Maksimālais dalībnieku skaits; NULL, ja ierobežojuma nav."),
    ),
  ),
  (
    t: "tiksanas_dalibnieks",
    purpose: "saglabā, kuri lietotāji ir pieteikušies kurām tikšanām (attiecība „piedalās”, m:n). Ieraksti rodas, lietotājam pieteikties tikšanās (ET_02)",
    fn: (C: "ET_02", R: "ET_02", U: NP, D: NP),
    cols: (
      (n: "lietotaja_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas piedalās tikšanās."),
      (n: "tiksanas_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("tiksanas", "tiksanas_id"), del: "CASCADE", d: "Tikšanās, kurai lietotājs pieteicies."),
    ),
  ),
  (
    t: "celojuma_grupa",
    purpose: "satur lietotāju izveidotās ceļojumu grupas. Ieraksts rodas, lietotājam izveidojot ceļojuma grupu (ET_03)",
    fn: (C: "ET_03", R: "ET_04", U: NP, D: "MD_04"),
    cols: (
      (n: "grupas_id", pg: "INTEGER", nn: true, key: "PK", d: "Unikāls ceļojuma grupas identifikators. Vērtība tiek ģenerēta automātiski."),
      (n: "veidotaja_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Grupas izveidotājs (attiecība „veido”)."),
      (n: "galamerka_lokacijas_id", pg: "INTEGER", nn: true, key: "FK", ref: ("lokacija", "lokacijas_id"), del: "RESTRICT", d: "Ceļojuma galamērķis (attiecība „galamērķis”)."),
      (n: "nosaukums", pg: "VARCHAR(100)", nn: true, d: "Grupas nosaukums."),
      (n: "apraksts", pg: "VARCHAR(1000)", nn: false, d: "Grupas apraksts un mērķi; NULL, ja nav norādīts."),
      (n: "sakuma_datums", pg: "DATE", nn: true, d: "Ceļojuma sākuma datums."),
      (n: "beigu_datums", pg: "DATE", nn: true, d: "Ceļojuma beigu datums."),
    ),
  ),
  (
    t: "grupas_dalibnieks",
    purpose: "saglabā, kuri lietotāji ir pievienojušies kurām ceļojumu grupām (attiecība „pievienojas”, m:n). Ieraksti rodas, lietotājam pievienojoties grupai (ET_04)",
    fn: (C: "ET_04", R: "ET_04", U: NP, D: NP),
    cols: (
      (n: "lietotaja_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("lietotajs", "lietotaja_id"), del: "CASCADE", d: "Lietotājs, kas pievienojies grupai."),
      (n: "grupas_id", pg: "INTEGER", nn: true, key: "PK, FK", ref: ("celojuma_grupa", "grupas_id"), del: "CASCADE", d: "Ceļojuma grupa, kurai lietotājs pievienojies."),
    ),
  ),
)

// Datu eksports (tools/gen_db_drawio.py)
#metadata(db1) <db1export>

// ------------------------------------------------ tabulu aprakstu ģenerators
#let del-note(del) = if del == "CASCADE" {
  " Dzēšot atsauces ierakstu, šis ieraksts tiek dzēsts (ON DELETE CASCADE)."
} else if del == "RESTRICT" {
  " Atsauces ierakstu nevar dzēst, kamēr uz to atsaucas citi ieraksti (ON DELETE RESTRICT)."
} else { "" }

#let crud-line(t) = {
  ("C", "R", "U", "D").zip(("izveidot", "lasīt", "labot", "dzēst")).map(p => p.at(0) + " (" + p.at(1) + "): " + t.fn.at(p.at(0))).join("; ")
}

#let db-table(t) = {
  par(first-line-indent: 0pt)[
    #ref(label("dbt-" + t.t)) – tabula *#t.t* #t.purpose. Funkcijas, kas veic datu darbības ar tabulu: #crud-line(t).
  ]
  [#figure(
    kind: table,
    caption: [Tabula #t.t],
    {
      set text(size: 9pt)
      set par(first-line-indent: 0pt, leading: 0.5em, justify: false)
      table(
        columns: (1.9fr, 1.45fr, 2.8fr, 0.8fr, 0.9fr),
        inset: 4pt,
        align: left + top,
        table.header([*Nosaukums*], [*Datu tips*], [*Apraksts*], [*Pieļauj NULL*], [*Atslēga (PK/FK)*]),
        ..t.cols.map(c => (
          [#c.n],
          [#c.pg#if "codes" in c { linebreak() + c.codes.join(linebreak()) }],
          [#c.d#if "ref" in c { " Atsauce uz tabulu " + c.ref.at(0) + "." + del-note(c.del) }],
          [#if c.nn { "Nē" } else { "Jā" }],
          [#c.at("key", default: "")],
        )).flatten(),
      )
    },
  )#label("dbt-" + t.t)]
}
