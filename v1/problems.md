# Problēmu saraksts – main.typ

Pārbaudīts: `main.typ`, `bibliography.yml`, konceptuālais datu modelis (`assets/konceptualais_modelis.drawio.png`).
**Nav pārbaudīti** DPD attēli (DPD0, DPD1, 2.līmeņa DPD) – tikai to izvietojums dokumentā.

## Sekciju numerācija (kā to rēķina main.typ)

`= Ievads` un `= Apzīmējumu saraksts` ir **bez numerācijas** (`numbering: none`), numurēšana sākas ar `= Vispārējais apraksts`.
Ja kompilētajā PDF numuri atšķiras, jāpārbauda sarakstā norādītie numuri.

| Nr. | Sekcija | Rindas main.typ |
|---|---|---|
| – | Apzīmējumu saraksts | 108 |
| – | Ievads (Nolūks, Darbības sfēra, Saistība ar citiem dok., Pārskats) | 123–135 |
| 1 | Vispārējais apraksts | 140 |
| 1.1 | Esošā stāvokļa apraksts | 142 |
| 1.2 | Pasūtītājs | 145 |
| 1.3 | Produkta perspektīva | 148 |
| 1.4 | Darījumprasības (1.4.1 Vieslietotājs, 1.4.2 Parastais reģ., 1.4.3 Verificētais, 1.4.4 Virslietotājs, 1.4.5 Administrators) | 152 |
| 1.5 | Sistēmas lietotāji | 195 |
| 1.6 | Vispārējie ierobežojumi | 211 |
| 1.7 | Pieņēmumi un atkarības | 243 |
| 2 | Programmatūras prasību specifikācija | 258 |
| 2.1 | Konceptuālais datu modelis | 261 |
| 2.2 | Funkcionālās prasības | 264 |
| 2.2.1 | Sistēmas moduļi, to funkcijas, identifikatori un lietotāji | 265 |
| 2.2.2 | Sistēmas paziņojumi | 355 |
| 2.2.3 | Funkciju sadalījums pa moduļiem (satur arī **Lietotāju moduļa** funkcijas LM_01–LM_09) | 426 |
| 2.2.4 | Informāciju modulis (IN_01–03) | 637 |
| 2.2.5 | Saderības modulis (SM_01–04) | 687 |
| 2.2.6 | Sociālo plūsmu modulis (SP_01–07) | 774 |
| 2.2.7 | Ziņojumapmaiņu modulis (CH_01–04) | 902 |
| 2.2.8 | Interaktīvās kartes modulis (MP_01–02) | 976 |
| 2.2.9 | Notikumu modulis (ET_01–04) | 1023 |
| 2.2.10 | Moderācijas modulis (MD_01–08) | 1117 |
| 2.2.11 | Administrēšanas modulis (AM_01–05) | 1299 |
| 2.3 | Nefunkcionālās prasības (2.3.1 Veiktspējas, 2.3.2 Izmantojamība, 2.3.3 Drošības, 2.3.4 Pieejamības, 2.3.5 Uzturēšanas) | 1414 |

Smagums: **[A]** augsts (pretruna / trūkst satura / kļūda, ko komisija pamanīs), **[V]** vidējs, **[Z]** zems (pareizrakstība, noformējums).

---

## 0. Titullapa, anotācija, metadati (main.typ 1–104)

- **[A]** Nosaukums „Ceļojumu plānošanas un ceļabiedru meklēšanas platforma” neatbilst saturam: anotācija, Ievads un 1.1 apraksta **sociālo lietotni draugu/domubiedru meklēšanai**; ceļojumu plānošanas funkciju (maršrutu, plānu) nav, ir tikai ceļojuma grupas (ET_03/ET_04) un vietējo meklēšana (SM_04).
- **[A]** Anotācija saka „Kursa darbā ir izstrādāta koncepcija…”, bet dokumenta tips ir „Programminženierijas praktiskais darbs” (`thesis-type: "bachelor"`, 13. rinda). Angļu versija arī „course paper”.
- **[A]** `description` (103. rinda) ir nesaprotams aizpildījums: „Dome randam dokument deskriptors harta till ne sensibls un te metadati”.
- **[V]** `submission-date` un `defense-date` = `datetime.today()` – datums mainīsies katrā kompilācijā, abi vienādi. Aizkomentētie piemēri (2026-01-01 / 2026-01-15) arī nav aktuāli.
- **[V]** Atslēgvārdi tikai 2 katrā valodā; latviešu sarakstam beigās liekā komata (89.–90. rinda). Anotācijā nav pieminēta verifikācija un moderācija.
- **[Z]** Autora vārds „Viktorija Mihailova ” ar atstarpi beigās (38. rinda).
- **[Z]** Atstāti aizkomentēti koda gabali un pagaidu komentāri (`//#import "template-fork…`, rindas 2, 69–80).

## Apzīmējumu saraksts (108–118)

- **[V]** Trūkst lietotos saīsinājumus: PRL, VRL, MOD, ADM, GUEST (2.2.1), SMSG, EMSG (2.2.2), FCM, SDK, TLS, HTTPS, GPS, SQL, LM/IN/SM/SP/CH/MP/ET/MD/AM prefiksi, kā arī „Sumsub”.
- **[Z]** Saraksts nav alfabētiskā secībā („DPD” pēc „MBTI”, „OAuth2” beigās).
- **[Z]** „Android: Mobilā operētājsistēma.” – nepilns apraksts (kā iOS: kam pieder).

## Ievads (123–135)

- **[A]** „Pārskats” (132–135): „trīs galvenās daļas”, trešā – „Programmatūras projektējuma apraksts” (datu bāzes projektējums, daļējs funkciju projektējums, saskarņu projektējums). Šīs daļas **dokumentā nav** (1460–1466 aizkomentētas ar „Teksts abcabc”). Arī „Nolūks” solījums: „…darbības procesus, kā arī lietotnes projektējumu”.
- **[A]** „Saistība ar citiem dokumentiem” atsaucas uz LVS 72 (projektējuma apraksts), bet projektējuma daļas nav.
- **[V]** „Darbības sfēra” apgalvo: lietotāji varēs „apskatīt lietotājus **un publiskas aktivitātes** noteiktās atrašanās vietās” kartē – MP_01/MP_02 (2.2.8) attēlo **tikai lietotājus**, aktivitātes/notikumi kartē nav aprakstīti.
- **[V]** Darbības sfēra: sistēma „nevis romantisko attiecību meklēšanai”, bet SM_02 (2.2.5) filtrē pēc **dzimuma, vecuma un rādiusa** – tas izskatās pēc iepazīšanās lietotnes loģikas; nav pamatots.
- **[Z]** Apakšvirsraksti izmanto `====` (4. līmenis), izlaižot 2. un 3. līmeni (124., 126., 128., 131. rinda). Pēc `#pagebreak()` (130) „Pārskats” sākas jaunā lapā bez iemesla.

## 1.1 Esošā stāvokļa apraksts

- **[V]** Teksts „Mūsu sistēmas mērķis…” – pirmās personas stils, dokumentā citur neitrāls. Apraksta **kas ir** nepieciešams, bet nav konkrētu esošo risinājumu piemēru/avotu (nav atsauču).
- **[V]** Piemin „interaktīvu karti ar jaunākajiem notikumiem” – sk. pretrunu ar MP_01/MP_02.

## 1.3 Produkta perspektīva

- **[Z]** Pieturzīmes/atstarpes: „(Firebase Cloud Messaging) … tuvumā; Lietotāju verifikācijas serviss(Sumsub)” – `;` pirms lielā burta, trūkst atstarpes pirms „(”.
- **[V]** Sumsub minēts šeit un 1.6, bet **nav** 1.7 pieņēmumos (pieejamība), kamēr Google Maps, Sign-In un FCM ir.

## 1.4 Darījumprasības

- **[V]** 1.4.2 (parastais reģistrētais): trūkst iespēju, kas 2.2.1 tabulā PRL ir atļautas: dzēst profilu (LM_04), mainīt privātuma iestatījumus (LM_09), sekot (SP_06), skatīt citu profilu (SP_07), bloķēt čatā (CH_03), saņemt push (CH_04), atslēgties.
- **[V]** 1.4.3 (verificētais): nav minēts saderības rezultāta skatīšana (SM_03), sekošana, ceļojuma grupas izveide kā atsevišķa iespēja.
- **[Z]** 1.4.2: „verificēt savu profilu, izmantojot (ID dokumentu)” – liekas iekavas. „izmantot **saraksti** sarunai” → „sarakstei”.
- **[Z]** 1.4.1–1.4.5: nekonsekvents formulējums („apskatīties”, „piebiedroties”, „iespēja … bez ierobežojumiem”).

## 1.5 Sistēmas lietotāji

- **[A]** Virslietotāja/administratora pieteikšanās: 2.2.1 tabulā LM_05/LM_06 (Pieslēgties) atļautas **tikai GUEST**, LM_03 (Rediģēt profilu) – tikai PRL/VRL; nav aprakstīts, kā MOD/ADM pieslēdzas, maina paroli, kā tiek izveidots **pirmais administrators**.
- **[V]** PRL apraksts: „Tie ir iespēja rakstīt visiem cilvēkiem…” (jābūt „Tiem ir iespēja”); „norādīja, lai neziņo” – nekorekts formulējums; „PRL „var rakstīt visiem”, bet 1.4.3 VRL „bez ierobežojumiem rakstīt **citiem verificētiem** lietotājiem” – apraksti par to, kam kurš drīkst rakstīt, ir nekonsekventi.
- **[V]** „Virslietotājiem būs atsevišķie konti, tāpēc visas iepriekšminētās tiesības uz virslietotāju neattiecas”, bet 2.2.1 tabulā MOD/ADM tiek piešķirtas SP_07, LM_07; nav skaidrs, kuras „iepriekšējās” tiesības.
- **[Z]** Vieslietotāju apraksts ir mārketinga stilā („labāka nekā citiem”, „populāru cilvēku viedokļi”) – prasību dokumentā tas nav pārbaudāms.
- **[Z]** „Visa informācija… parādīta **1.1. Attēlā**” (208. rinda) – attēla numurs ierakstīts ar roku ar lielo burtu; attēliem nav `<label>` un nav `@` atsauču. Parakstos „0.līmeņa DPD”, „2.līmeņa DPD…” trūkst atstarpes.

## 1.6 Vispārējie ierobežojumi

- **[V]** „Datu aizsardzība”: piemin „personalizētie maršruti vai lietotāju atsauksmes”; „Navigācija un kartēšanas pakalpojumi”: „maršrutus”. Maršrutu un atsauksmju funkciju sistēmā **nav**.
- **[V]** „Platformas atbalsts” runā par „vecākām versijām”, minimālās versijas (Android 12, iOS 15) parādās tikai 1.7 (1. punkts) un neviena nefunkcionālā prasība tās neatkārto.
- **[Z]** „Lietotāju verifikācija: … atkarīga **tikai** no trešās puses” – 2.3.3 saka, ka verifikācija jāveic caur Sumsub; apgalvojumi jāsaskaņo.
- **[Z]** Daudz pareizrakstības/gramatikas kļūdu: „Šie var būt arī neregulāri pīķveidīgi noslodzes palielinājumu”, „Uz neparedzētu daudz lietotāju skaitu”, „piemēram saziņu”, „kartes, video, bilžu un audio funkcionalitāti un parādīšanu” u.c. (212–225).

## 1.7 Pieņēmumi un atkarības

- **[A]** 4. un 6. punkts („karšu serviss … **visu laiku** pieejams”, „Serveris … **visu laiku** pieejams”) pretrunā ar 2.3.4 (pieejamība 99,5 %, ārējo pakalpojumu traucējumi iespējami) un 1.6 (pakalpojumi var neizdoties).
- **[V]** Nav pieņēmuma par Sumsub pieejamību.
- **[Z]** Punkti rakstīti dažādi: 4. punkts mazajiem burtiem, „servisi(Google” bez atstarpes, 3. punkts neskaidri formulēts („Ir lietotāji, kas lieto lietotni…”).

---

## 2.1 Konceptuālais datu modelis

- **[A]** Modelī **nav entītiju datiem, ko izmanto funkcijas**: Sūdzība/ziņojums (MD_01, MD_02), Brīdinājums (MD_05; „brīdinājuma ieraksts konta vēsturē”), Pārkāptais noteikums (MD_04–MD_08 izvēles saraksts), Audita žurnāls (AM_03, 2.3.3 pēdējā prasība), Paziņojums/ierīces tokens (CH_04, FCM).
- **[A]** Trūkst atribūtu, ko izmanto funkcijas: **dzimums** (SM_02 filtrs), **lietotāja ģeokoordinātas** (MP_01/MP_02, SM_02 „rādiuss” – modelī tikai valsts/pilsēta), **tālruņa numurs** (AM_01), **dalībnieku limits un statuss** ceļojuma grupai (ET_03/ET_04 – grupai ir tikai nosaukums, sākuma/beigu datums, apraksts), **tikšanās statuss** (ET_02 „atcelta”), **konta aktivizācijas laiks** (AM_02; ir tikai `deaktivizēts_līdz` un `darba_laiks`), **maršruts** (ET_03 „Galamērķis / Maršruts” – ir tikai Lokācija).
- **[V]** AM_02 definē vienu aktivizācijas/deaktivizācijas periodu, modelis un EMSG_13 „darba laikam” – atkārtojošu darba laiku (`darba_laiks`) – nekonsekvence.
- **[V]** LM_03 minē „Intereses, **hobiji**” kā atsevišķus laukus; modelī ir tikai entītija Interese.
- **[Z]** Modelis ir tikai attēls (110 % platumā), nav teksta apraksta, kardinalitāšu skaidrojuma vai atslēgu definīcijas.

## 2.2.1 Sistēmas moduļi, funkcijas, identifikatori, lietotāji

- **[V]** Tabulas paraksts „Funkciju sadalījums pa moduļiem” ir tāds pats kā sekcijas 2.2.3 nosaukums – var sajaukt.
- **[Z]** Moduļu nosaukumi nesakrīt ar virsrakstiem: „Ziņojum-apmaiņu modulis” (ar defisi) vs 2.2.7 „Ziņojumapmaiņu”; „Moderāciju modulis” vs 2.2.10 „Moderācijas”; „Lietotāju modulis” **nav savas apakšsekcijas** (iekļauts 2.2.3).
- **[Z]** Identifikatoru prefiksi jaukti latviski/angliski (CH – Chat, MP – Map, ET – Event, bet LM, SM, SP, MD…); „LM_” = Lietotāju modulis, bet izklausās pēc „Login module”.
- **[V]** Nav funkciju, kas aprakstītas citur: sekošanas atcelšana (unfollow), čata bloķēšanas atcelšana, lietotāja atbloķēšana/konta atjaunošana (MD_06, MD_07), tikšanās/grupas apskate un meklēšana, tikšanās/grupas atcelšana, rediģēšana, atstāšana, grupas dalībnieku pārvaldība, ziņojuma (sūdzības) izskatīšana/statusa maiņa, komentāra/ieraksta dzēšana pašam autoram, paroles atjaunošana (aizmirsta parole).

## 2.2.2 Sistēmas paziņojumi

- **[A]** SMSG numerācijā **trūkst SMSG_23** (SMSG_22 → SMSG_24).
- **[A]** Piekļuves liegums: MD_02–MD_08 un AM_01–AM_05 nosaka „piekļuve tiek liegta”, bet **nav atbilstoša EMSG**.
- **[A]** Trūkst kļūdu paziņojumu validācijai: AM_01 (formāts, e-pasta unikālums), AM_02 (beigu laiks vēlāks par sākuma), ET_01 (datums nākotnē), ET_03 („datumu loģika”), MD_01/MD_04–MD_07 (obligātie lauki), SP_03 (ja abi lauki tukši).
- **[V]** SMSG_01 funkcijās norādīts „LM_01, **LM02**” (365. rinda) – trūkst pasvītras.
- **[V]** SMSG_02 piešķirts „LM_03, **MD_08**”, bet MD_08 (2.2.10) izvaddatos SMSG_02 **nav**.
- **[V]** SMSG_19 piešķirts „CH_04, **ET_01**” („uzaicināja Jūs uz tikšanos”), bet ET_01 neietver uzaicinājumu funkciju un izvadā tikai SMSG_24.
- **[V]** SMSG_20 piešķirts „CH_04, **SM_02**” („Tuvumā ir atrasts saderīgs lietotājs”), bet SM_02 ir meklēšana, nevis fona uzraudzība; nav funkcijas, kas to ģenerē, kā arī nav aprakstīta nepārtraukta atrašanās vietas izsekošana.
- **[V]** SMSG_17 („sāka Jums sekot”) un SMSG_18 („atzīmēja vai komentēja”) – SP_06, SP_04, SP_05 neizsauc CH_04, tikai CH_01 to dara tieši.
- **[V]** EMSG_05 (e-pasts jau eksistē) un EMSG_06 (parole neatbilst) piešķirti tikai LM_01, bet LM_03 ļauj mainīt e-pastu un paroli bez šīm pārbaudēm; LM_02/LM_06 neapraksta, kas notiek, ja Google/Apple e-pasts jau ir reģistrēts vai nav reģistrēts.
- **[V]** EMSG_13 („Konts … nav aktīvs darba laikam”) lietots tikai LM_05, bet LM_06 (OAuth pieteikšanās) to neapstrādā (MOD/ADM arī varētu pieteikties).
- **[V]** EMSG_17 (failu formāts/izmērs) piešķirts tikai SP_03; CH_01 (pielikumi) un LM_03 (profila attēls) arī augšupielādē failus bez kļūdas paziņojuma.
- **[Z]** Liekā atstarpe SMSG_22 beigās (386. rinda). Paziņojumu tabulai neatbilst galvenes izlīdzinājums (`y == 0 or x == 0`).

## 2.2.3 Funkciju sadalījums pa moduļiem + Lietotāju modulis (LM_01–LM_09)

- **[A]** Lietotāju modulim nav savas sekcijas (virsraksta); funkcijas „iekārtas” zem 2.2.3, kur pirms tā stāv DPD1.
- **[V]** Atstāts pagaidu komentārs „//DPD1 laikam te” (427. rinda); un FT_ komentāri (475. rinda).
- **LM_01**: **[V]** ievaddatos nav paroles apstiprinājuma lauka (obligāts lauks tikai „Parole”); „Lietotāja ID” un „Reģistrācijas datums” norādīti kā ievaddati, lai gan lietotājs tos neievada; trūkst „dzimšanas datums”, vecuma ierobežojuma pārbaude (GDPR piekrišanas vecums).
- **LM_02**: **[V]** neapstrādā gadījumu, ja e-pasts jau reģistrēts (EMSG_05); EMSG_04 nav.
- **LM_03**: **[V]** sk. EMSG_05/EMSG_06 augstāk; ievaddati „Lietotājvārds, e-pasts, parole” 1.5 sadaļā neparādās kā rediģējami.
- **LM_04**: **[V]** „dzēsti **vai anonimizēti**” – nenoteikts; nav teikts, vai notiek automātiska atslēgšanās un kas notiek ar ierakstiem/komentāriem/čatiem (GDPR).
- **LM_05/LM_06**: **[V]** LM_06 ievaddati „autorizācijas kods”, apstrādē – „autorizācijas žetons”; nav teikts, kas notiek, ja Google/Apple konts nav reģistrēts.
- **LM_08**: **[V]** SMSG_06 („nosūtīti pārbaudei”) un SMSG_07 („verificēts”) – nav aprakstīts, kā rezultāts atgriežas (webhook/gaidīšana), kāds ir „gaida pārbaudi” statuss; „sejas biometrija” ir īpašās kategorijas dati – nav minēts GDPR pamatojums.
- **LM_09**: **[V]** privātuma parametri aprakstīti vispārīgi („piem.”) – nav minēta atrašanās vietas redzamība (nepieciešama MP_02 un 2.3.3 prasībai), nav minēta paziņojumu izslēgšana pa veidiem (CH_04).

## 2.2.4 Informāciju modulis (IN_01–IN_03)

- **[Z]** IN_02: „reģistrēto lietotāju kopējo **skaits**” → „skaitu”.
- **[Z]** IN_01: „labās lietotāju atsauksmes” / „populāru cilvēku viedokļi” – nav definēts, kur tiek ņemti dati (nav entītijas modelī).

## 2.2.5 Saderības modulis (SM_01–SM_04)

- **[A]** Saderības aprēķins **nav definēts**: SM_02 – „punkti par MBTI tipu savstarpējo sakritību” un „bonuss par kopīgajām interesēm (… ja sakrīt vismaz 2 intereses)”, slieksnis 50 %, bet nav formulas/tabulas, nav MBTI testa jautājumu skaita, nav noteikts, kas notiek, ja otrs lietotājs nav izpildījis MBTI.
- **[V]** SM_02 filtrē pēc **dzimuma, vecuma, rādiusa** – profilā nav dzimuma un koordinātu (sk. 2.1); vecums ir tikai no neobligātā dzimšanas datuma.
- **[V]** SM_02 nosaukums „Meklēt lietotājus **pēc interesēm**”, bet apstrādā arī MBTI, filtrus un 50 % slieksni.
- **[V]** SM_02 un SM_03 abi aprēķina saderību – dublēšanās, nav teikts, vai rezultāts tiek saglabāts (modelī ir entītija Saderība).
- **[V]** SM_04: nav teikts, kā tiek noteikts, kurš ir „vietējais” (modelī lietotājam ir valsts/pilsēta, bet nav definēts), un kā tiek izmantots ievadītais „laika periods”.
- **[Z]** SM_01: nav minēts atkārtots testa izpildījums (modelī MBTI rezultāts ir n:1).

## 2.2.6 Sociālo plūsmu modulis (SP_01–SP_07)

- **[A]** SP_02 (Dalīties) ļauj PRL pievienot „Papildu komentāru / tekstu”, kamēr 1.4.2/1.5 un SP_05 PRL **neļauj komentēt** – pretruna.
- **[V]** SP_03: „Vismaz vienam no šiem laukiem jābūt aizpildītiem”, bet **nav kļūdas paziņojuma**, ja abi tukši; nav teksta garuma/faila izmēra/formāta robežu (EMSG_17 atsaucas uz „formātu un izmēru”).
- **[V]** SP_06: nav pārbaudes „jau seko” un nav atsekošanas atcelšanas funkcijas; nav sekotāja paziņojuma izsaukuma (CH_04).
- **[Z]** SP_04 paraksts: `"Atzīmēt ierakstu 'patīk'"` – vienkāršās pēdiņas, citur dubultās.

## 2.2.7 Ziņojumapmaiņu modulis (CH_01–CH_04)

- **[V]** CH_01/CH_02: „atver **saraksti**” → „sarakstni/sarakstī” (915., 933. rinda).
- **[V]** CH_03: nav atbloķēšanas funkcijas (1.5 min „ja iepriekš nebija aizbloķējuši”); sūtītājam netiek parādīts nekāds paziņojums, ka viņš ir bloķēts (CH_01 2. solis).
- **[V]** CH_04: apraksta tikai paziņojumu **saņemšanu**, bet neapraksta, kā reģistrēt ierīci/tokenu FCM, kā lietotājs ieslēdz/izslēdz paziņojumus; 4. solis „Ja nav interneta savienojuma … EMSG_01/EMSG_02” – push paziņojumam bez atbilstošas lietotāja darbības nav jēgas.
- **[Z]** CH_01 ievaddati: „Ziņas teksts un/vai pielikumi – … obligāts lauks” – nav jasaprot, kurš ir obligāts.

## 2.2.8 Interaktīvās kartes modulis (MP_01–MP_02)

- **[A]** **Nav 2.līmeņa DPD** (rinda 978 – aizkomentēts, atsaucas uz ZinojumuDPD2.png – nepareizs fails).
- **[A]** Kartē nav tikšanās/aktivitāšu/grupu attēlošanas, lai gan: Ievads (darbības sfēra), anotācija („reāllaika notikumi”), 1.1, 2.3.1 (veiktspēja: „lietotāju **un aktivitāšu** datus”).
- **[V]** MP_02: izmanto citu lietotāju koordinātas un „konfidencialitātes iestatījumus” – modelī koordinātu nav; LM_09 neapraksta atrašanās vietas privātumu.
- **[V]** MP_01/MP_02: nav iestatījuma, kā lietotājs pats izslēdz savas atrašanās vietas rādīšanu; EMSG_20 nepārklāj gadījumu, kad lietotājs atsakās no atļaujas pēc tam.

## 2.2.9 Notikumu modulis (ET_01–ET_04)

- **[A]** **Nav 2.līmeņa DPD** (aizkomentēts, atsaucas uz ZinojumuDPD2.png).
- **[A]** ET_01: nav **atrašanās vietas** ievaddatu, lai gan modelī Tikšanās notiek Lokācijā (`notiek`), un tikšanās jāattēlo kartē.
- **[V]** ET_01 nepiemin uzaicinājumus (SMSG_19), pieteikšanās apstiprināšanu/noraidīšanu; ET_02/ET_04 lieto vienu EMSG_22 („vairs nav pieejama”) gan dzēstām, gan pilnām tikšanām/grupām.
- **[V]** ET_03: „Maršruts” ievadlaukā nav modelī; grupas izveidotājam piešķir „vadītāja tiesības”, kuras nekur nav aprakstītas; ET_04: „grupa … **arhīvā**” – arhivēšanas funkcijas nav.
- **[V]** ET_02/ET_04: nav dalības atcelšanas funkcijas.

## 2.2.10 Moderācijas modulis (MD_01–MD_08)

- **[A]** **Nav 2.līmeņa DPD**.
- **[A]** MD_01 funkcijas nosaukums ir **„Pievienoties grupai”** (1122. rinda) – kopēts no ET_04; jābūt „Ziņot par profilu vai saturu”.
- **[A]** MD_05 (Izdot brīdinājumu), 5. solis: „Sistēma **dzēš vai arhivē izvēlēto saturu** datubāzē” – kopēts no MD_04; brīdinājums nedrīkst dzēst saturu.
- **[V]** MD_02: ir ziņojumu statusa filtrs, bet **nav funkcijas**, kas maina ziņojuma statusu (izskatīts, noraidīts) vai saista to ar sekojošo darbību.
- **[V]** MD_04–MD_07: pēc „Rediģēt/Dzēst/Bloķēt/Deaktivizēt” nav paredzēta atbloķēšana vai apelācija; nav ierobežojuma, ka MOD nedrīkst bloķēt/rediģēt citus MOD/ADM kontus.
- **[V]** MD_08: apraksts „labot **vai dzēst** neatbilstošu informāciju”, bet dzēšanas darbības nav; SMSG_02 (sk. 2.2.2) nav izvaddatos.
- **[Z]** MD_04–MD_07 ievaddatos liekā noslēdzošā iekavā: „… neobligāts lauks**)**” (1192., 1215., 1239., 1262. rinda).

## 2.2.11 Administrēšanas modulis (AM_01–AM_05)

- **[A]** **Nav 2.līmeņa DPD**.
- **[V]** AM_03 rāda tikai **virslietotāju** darbības, bet 2.3.3 paredz reģistrēt **gan virslietotāju, gan administratoru** darbības.
- **[V]** AM_01: „Tālruņa numurs” nav modelī; „Sākotnējā parole” – nav piegādes/obligātas nomaiņas procesa; AM_01 neļauj izveidot administratoru (pirmā ADM izveide nav aprakstīta).
- **[V]** AM_02: viens periods ar abiem obligātiem datumiem – bezgalīgs darbs bez beigu datuma nav iespējams; modelī `darba_laiks` kā atkārtojošs grafiks.
- **[V]** AM_05: apstiprinājums tiek ievadīts kā ievadlauks un 3. solī tiek apstiprināts, bet SMSG_36 („Vai tiešām vēlaties dzēst?”) parādās **pēc** apstiprināšanas (4. solis) – kļūdaina secība; „Administratori norāda” (daudzskaitlis).
- **[Z]** AM_04 vs AM_02 – nav teikts, kā deaktivizētu virslietotāju atkal aktivizēt.

## 2.3 Nefunkcionālās prasības

- **2.3.1 [V]** „…lietotāju **un aktivitāšu** datus” (karte) – sk. 2.2.8. 200 vienlaicīgu lietotāju ir ļoti maz „starptautiskai” lietotnei (1.2, anotācija).
- **2.3.2 [Z]** Valodu saraksts (lv, en, ru, es) sakrīt ar 1.6, bet dokumenta teksts un paziņojumi (2.2.2) doti tikai latviski – nav norādīts, kā tiek nodrošināta tulkošana.
- **2.3.3 [V]** „Reģistrēt virslietotāju **un administratoru** darbības” – sk. AM_03 un modeļa trūkstošo žurnālu. Nav prasību par: vecuma ierobežojumu (dzimšanas datums, GDPR), sesiju/žetonu derīgumu, divfaktoru autentifikāciju virslietotājiem, mēģinājumu skaita ierobežošanu, ziņojumu/lietotāju datu saglabāšanas termiņiem pēc profila dzēšanas.
- **2.3.4 [Z]** „Pilnvērtīgai lietotnes darbībai jābūt pieejamam stabilam interneta savienojumam.” – tas jau ir 1.6 un 1.7 (2. p.), nav pārbaudāma NFR; dublējas arī 2.3.4 3. prasība ar EMSG_01/02.
- **2.3.5 [V]** Nav prasības par kodēšanas/dokumentācijas standartiem; „Sistēmas izmaiņas jāuztur versiju kontroles sistēmā” – ir pašsaprotama, nav mērāma.

## Bibliogrāfija (bibliography.yml, Dokumentārā lapa)

- **[A]** Ieraksts `typst` **nekur netiek citēts** dokumentā (citēti tikai @LVS68, @LVS72). Nav avotu par GDPR (Regula (ES) 2016/679), MBTI, Google Maps, Firebase, Sumsub, kuri tiek apgalvoti tekstā.
- **[V]** `typst` ieraksts: autori sadalīti kā četri atsevišķi „autori” (Mädje; Laurenz; Haug; Martin) + „Typst Projekta Izstrādātāji”; datums `2025-01-01` izskatās pēc aizpildītāja.
- **[Z]** LVS ierakstos `author: SIA „Latvijas standarts” (LVS); (1996)` – gads iekļauts autora laukā.
- **[Z]** `bibliography-here()` stāv pirms `= Pielikumi`; „Pielikumi” ir tukšs (visa saturs aizkomentēts).

## Faili / struktūra

- **[Z]** `assets/LietotajaDPD2.png` nav izmantots (izmantots `LietotajaDPD2_stils.png`); `assets/template-fork/` (veidnes kopija) ir repozitorijā un neatbilst importam (`@preview/solo-lu-df:2.1.0`).
- **[Z]** Visiem attēliem `width: 110%` – var iziet ārpus lapas malām.
- **[Z]** `function-table` figūru etiķetes `<FT_n>` nekur netiek izmantotas ar `@FT_n`; tabulu atsauces dokumentā tikai ar „@function-modules”, „@system-messages”.
