# Projekta konteksts

Latvijas Universitātes kursa "Programminženierijas praktiskais darbs" dokumentācijas projekts (tikai dokumentācija, kods netiek rakstīts). Komanda: 5 autori, vadītāja Laila Niedrīte. Dokumenti ir latviešu valodā, rakstīti Typst ar veidni `@preview/solo-lu-df:2.1.0`.

Sociālā lietotne: reģistrēti lietotāji, MBTI testi un saderība, intereses un valodas, ieraksti, sarunas, tikšanās un ceļojumu grupas.

## Struktūra

- `v1/` – oriģinālā (pilnā) versija. `main.typ` ir dokuments, `db.typ` satur 3. nodaļas datubāzes tabulu datus (21 tabula). Visi ceļi ir relatīvi pret `v1/`, tāpēc Typst saknei jābūt `v1/`.
- `v2/` – vienkāršota versija (1.–3.1. nodaļa) ar labotām problēmām. Datu vienīgais avots ir `v2/data.typ`, tabulas un pārbaudes ģenerē `v2/lib.typ`, dokuments ir `v2/main.typ`.
- `v1/problems.md` – v1 problēmu saraksts pēc nodaļu numuriem. `v2/proposal.md` – kas v2 vienkāršots un kāpēc.
- `presentation_section3_v1/` – lokāla prezentācija (git to ignorē).

## Kompilēšana

`typst compile main.typ` attiecīgajā mapē (`v1/` vai `v2/`). Pēc tam atjauniniet `main.pdf`, jo tas tiek glabāts repozitorijā.

## Diagrammas (draw.io)

Datubāzes modeļi un v2 diagrammas tiek ģenerētas no Typst datiem uz draw.io failiem:

- v1: `python v1/tools/gen_db_drawio.py` → `v1/assets/drawio/db_modeli.drawio`
- v2: `python v2/tools/gen_drawio.py` → `v2/assets/drawio/diagrammas.drawio`
- Nepieciešams `pip install typst`. PNG eksportu veic draw.io darbvirsmas CLI (`drawio -x -f png -p <lapas numurs> -o <fails>.png <fails>.drawio`).
- **Uzmanību:** ģenerators pārraksta draw.io failu un lietotāja manuāli sakārtoto izkārtojumu. Pēc rokas labojumiem ģeneratoru nepalaidiet.
- PNG attēli no `assets/` tiek iekļauti dokumentā, tāpēc pēc diagrammu izmaiņām tie jāpārexportē.

## Kursa noteikumi, kas jāievēro

- Konceptuālais modelis bez ID kolonnām; loģiskajā un fiziskajā modelī atslēgas, nosaukumi un datu tipi ir atsevišķās kolonnās.
- DPD0/DPD1/DPD2: lietotāji un ārējās sistēmas mijiedarbojas tikai ar moduļiem, ne tieši ar datubāzi.
- Katrai entitātei/tabulai ir CRUD pārklājums (kas nav paredzēts, tiek atzīmēts "nav paredzēts").
- Nefunkcionālajām prasībām jābūt izmērāmām ar pārbaudes metodi.
- Katram attēlam un tabulai jābūt aprakstam tekstā.
- Datubāzes tabulu aprakstos jānorāda NULL / NOT NULL un ON DELETE darbība.
- Datubāzes nosaukumi bez latviešu diakritiskajām zīmēm.

## v2 īpatnības

- Dati vienuviet (`data.typ`), konsekvenci nodrošina `assert` pārbaudes `lib.typ`: nezināmi ID, obligātie lauki pret NOT NULL, kļūdu ziņojumi, CRUD pārklājums (izņēmumi `crud-na`).
- Typst atslēgvārdi `in`, `out`, `auto` nav izmantojami kā vārdnīcas atslēgas (izmantoti `fin`, `fout`, `gen`).
- Pasākums apvieno tikšanos un ceļojumu grupu (lauks `veids`).

## Git noteikumi

- Katra commit ziņa sākas ar datumu formātā `GGGG-MM-DD`, piemēram `2026-11-04 Apraksts`.
- Commitos un pull requestos nedrīkst pievienot Claude (vai citu AI) kā līdzautoru vai atsauci, nedz `Co-Authored-By`, nedz "Generated with" rindas.
- Commitu un push veic tikai pēc lietotāja pieprasījuma.

## TODO

- **v1, 3.1.3. nodaļa (tabulu apraksti):** pārbaudīt un izlabot funkciju (C/R/U/D) sarakstus pie katras tabulas (`fn` lauki `v1/db.typ`). Daļa funkciju ID ir nepareizi, un jāpārbauda, vai katra norādītā funkcija (IN/LM/SM/SP/CH/MP/ET/MD/AM) 2.2. nodaļā tiešām veic attiecīgo darbību ar šo tabulu un darbojas kā paredzēts. Pēc labojumiem pārkompilēt `v1/main.typ`.

## Zināmie trūkumi v1

- Dažām tabulām nav funkciju visām CRUD darbībām (piem. interese, valoda, ieraksts U, saruna/ziņa D); 3. nodaļā tās atzīmētas kā "nav paredzēts".
- v1 "Pārskata" tekstā minēts funkciju un UI projektējums, kura dokumentā nav.
