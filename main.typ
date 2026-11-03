#import "@preview/solo-lu-df:2.1.0": *
//#import "template-fork/src/lib.typ": *
#show table: set text(size: 10pt)
#show table: set par(leading: 0.5em)

#show: ludf.with(
  title: "Ceļojumu plānošanas un ceļabiedru meklēšanas platforma",
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
      name: "Viktorija Mihailova ",
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
  submission-date: datetime.today(),
  // submission-date: datetime(
  //   year: 2026,
  //   month: 1,
  //   day: 1,
  // ),
  // defaults to datetime.today()
  defense-date: datetime.today(),
  // defense-date: datetime(
  //   year: 2026,
  //   month: 1,
  //   day: 15,
  // ),
  place: "Rīga",
  bibliography: bibliography("bibliography.yml"),
  abstract: (
    primary: ( //anotacijas
      text: [Kursa darbā ir izstrādāta koncepcija un funkcionalitātes apraksts jaunai starptautiskai sociālajai mobilajai lietotnei (iOS un Android vidēm), kas radīta, lai palīdzētu cilvēkiem atrast jaunus draugus un domubiedrus gan ikdienā, gan ceļojot. Lietotnes galvenais mērķis ir veicināt reālu draudzību veidošanos un kultūru apmaiņu, apvienojot sociālā tīkla, interešu kopienu un ceļošanas rīku priekšrocības. Aplikācija piedāvā integrētu sociālo plūsmu satura dalīšanai, kā arī interaktīvu pasaules karti, kas ļauj atklāt reāllaika notikumus. Lai nodrošinātu veiksmīgu komunikāciju un palīdzētu atrast cilvēkus ar līdzīgu pasaules uztveri, sistēmā ir iestrādāts draudzības saderības aprēķina mehānisms, kas balstās uz lietotāju interesēm un MBTI personības testu rezultātiem. Īpaša uzmanība darbā pievērsta aktivitāšu un tikšanos organizēšanas rīkiem, kā arī iespējai iepazīties ar vietējiem iedzīvotājiem vēl pirms ceļojuma, tādējādi radot uzticamu vidi, kas iedrošina ne tikai redzēt pasauli, bet iepazīt cilvēkus, kuri tajā dzīvo.],



       keywords: ( "Mobilā lietotne", "MBTI personības tests",
    ),
    
    ),
    secondary: (
      text: [
   This course paper presents the concept and functional description of a new international social mobile application (for iOS and Android platforms), designed to help people find new friends and like-minded individuals both in their daily lives and while traveling. The main objective of the app is to foster real friendships and cultural exchange by combining the features of a social network, interest-based communities, and travel networking tools. The application offers an integrated social feed for content sharing, alongside an interactive world map that allows users to discover real-time events. To ensure successful communication and help users connect with people sharing similar mindsets, the system integrates a friendship compatibility mechanism based on user interests and MBTI personality test results. Special attention is given to the activity and meetup organization tools, as well as the feature enabling users to connect with locals before a trip. This creates a trusted environment that encourages users not just to see the world, but to get to know the people who live in it.
      ],

      
      keywords: ( "Mobile application", "MBTI test",
    ),
      ),
  ),
  description: [Dome randam dokument deskriptors harta till ne sensibls un te metadati],
)


#set heading(numbering: none)
= Apzīmējumu saraksts

/ API: Application Programming Interface - Lietojumprogrammas saskarne.
/ Android: Mobilā operētājsistēma.
/ GDPR: General Data Protection Regulation - Vispārīgā datu aizsardzības regula (Regula (ES) 2016/679).
/ ID: Identification - Identifikācija.
/ iOS: Apple mobilā operētājsistēma.
/ MBTI: Myers-Briggs Type Indicator - Maiersas-Brigsas tipu indikators.
/ DPD: Datu plūsmas diagramma.
/ Push paziņojums: Paziņojums, ko lietotājs saņem mobilās ierīces saskarnē.
/ OAuth2: Open Authorization - Atvērta standarta autorizācijas protokols.




= Ievads
==== Nolūks
Šis dokuments ir izstrādāts programminženierijas kursa praktiskā darba ietvaros. Dokuments paredzēts, lai aprakstītu izstrādājamās lietotnes vispārējo aprakstu,  funkcionālās un nefunkcionālās prasības, darbības procesus, kā arī lietotnes projektējumu. Dokuments paredzēts izstrādes komandai, sistēmas administratoriem un projekta vērtēšanas komisijai. 
==== Darbības sfēra
Izstrādājamā sistēma ir starptautiska sociālā lietotne, kas paredzēta cilvēkiem, kuri vēlas atrast jaunus draugus, domubiedrus, ceļošanas biedrus un kopīgu aktivitāšu dalībniekus. Sistēmas galvenais mērķis ir nodrošināt iespēju lietotājiem veidot sociālos kontaktus, dalīties ar saturu, organizēt kopīgas aktivitātes un iepazīt cilvēkus savā valstī vai ceļojot. Mobilā lietotne paredzēta izmantošanai iOS un Android operētājsistēmās. Sistēmā lietotāji varēs izveidot un pārvaldīt savu profilu, publicēt saturu, kā arī lietotnes sākumlapā apskatīt sociālo tīklu plūsmu ar citu lietotāju publicētām fotogrāfijām, video un ierakstiem. Lietotāji varēs sekot citiem lietotājiem, reaģēt uz publikācijām un sazināties privātajā čatā. Profilā iespējams norādīt intereses, hobijus, valodas un citu informāciju, kā arī aizpildīt MBTI personības testu. Testa rezultāti un kopīgās intereses tiks izmantotas piemērotu cilvēku meklēšanai. Sistēmā būs pieejama interaktīva karte, kurā varēs apskatīt lietotājus un publiskas aktivitātes noteiktās atrašanās vietās. Lietotāji varēs izveidot tikšanās un aktivitāšu piedāvājumus, kā arī veidot un pievienoties ceļojumu grupām. Sistēmā paredzētas vairākas lietotāju lomas: vieslietotājs, reģistrēts lietotājs, verificēts lietotājs, virslietotājs un administrators. Lietotāji varēs ziņot par neatbilstošu saturu vai citu lietotāju. Sistēma paredzēta jaunu sociālo kontaktu, draudzības un kopīgu aktivitāšu veidošanai, nevis romantisko attiecību meklēšanai vai iepazīšanās pāru veidošanai.
==== Saistība ar citiem dokumentiem
Dokumenta struktūra un noformējums veidots, ņemot vērā standarta LVS 68:1996 “Programmatūras prasību specifikācijas ceļvedis” @LVS68 un LVS 72:1996 “Ieteicamā prakse programmatūras projektējuma aprakstīšanai” @LVS72 prasības, kā arī programminženierijas kursa praktisko darbu materiālus un vadlīnijas.
#pagebreak()
==== Pārskats
Dokumenta struktūru veido trīs galvenās daļas:
1.	Vispārējais apraksts, kurā sniegts izstrādājamās sistēmas esošā stāvokļa apraksts, produkta perspektīva, darījumprasības, sistēmas lietotāju raksturojums, kā arī vispārējie ierobežojumi un pieņēmumi un atkarības.
2.	Programmatūras prasību specifikācija, kurā aprakstīts sistēmas konceptuālais datu modelis, funkcionālās un nefunkcionālās prasības.
3.	Programmatūras projektējuma apraksts, kurā ietverts datu bāzes projektējums, svarīgāko funkciju daļējs projektējums un lietotāja saskarņu projektējums.


#set heading(numbering: "1.")

= Vispārējais apraksts

== Esošā stāvokļa apraksts
Mūsdienās sociālo tīklu lietotājiem un ceļotājiem ir grūti atrast reālus domubiedrus un kopīgas brīvā laika aktivitātes, jo esošās platformas ir sadalītas un pilda tikai atsevišķas funkcijas. Viena lietotne fokusējas tikai uz vizuālā satura publicēšanu, cita uz pasākumu organizēšanu vai iepazīšanās nolūkiem, liekot patērēt daudz laika vairākās vidēs un nesniedzot skaidru priekšstatu par personu savstarpējo saderību. Rezultātā iebraucot jaunā pilsētā vai meklējot kompāniju saviem hobijiem, trūkst droša un vienkārša veida, kā iepazīties ar līdzīgi domājošiem cilvēkiem. Mūsu sistēmas mērķis ir apvienot šīs funkcijas vienotā platformā, nodrošinot interaktīvu karti ar jaunākajiem notikumiem, MBTI un interešu saderības aprēķinu, kā arī ērtas iespējas plānot kopīgas aktivitātes un atrast īstos cilvēkus, ar kuriem pavadīt laiku.

== Pasūtītājs
Platforma aprakstīta pēc studentu grupas iniciatīvas programminženierijas kursa ietvaros.

== Produkta perspektīva
Lietotne ir patstāvīga mobilā platforma Android un iOS viedtālruņiem, kas nebūs daļa no citas sistēmas. Tomēr platforma nebūs neatkarīga, jo pilnvērtīgai funkcionalitātei tajā tiks integrēti vairāki ārējie servisi: karšu un ģeoplānošanas API (Google Maps), kas tiks izmantots lietotāju un notikumu attēlošanai interaktīvajā kartē; sociālo tīklu un kontu autentifikācijas servisi (Google/Apple Sign-In), lai nodrošinātu ātru un drošu lietotāju pieteikšanos; kā arī izlecošo paziņojumu serviss (Firebase Cloud Messaging), kas nodrošinās operatīvu paziņojumu sūtīšanu par jaunām ziņām, uzaicinājumiem uz pasākumiem un saderīgiem lietotājiem tuvumā; Lietotāju verifikācijas serviss(Sumsub), lai veidotu uzticamību starp reģistrētajiem lietotājiem un lai paaugstinātu lietotāju drošību.


== Darījumprasības
=== Vieslietotāja iespējas
- Iespēja apskatīt vispārīgo informāciju par aplikāciju.
- Iespēja reģistrēties/autorizēties.
- Iespēja redzēt statistiku par aplikāciju.
- Iespēja izlasīt aplikācijas noteikumus, GDPR regulu un citu svarīgo informāciju.



=== Parastā reģistrēta lietotāja iespējas
- Iespēja vēlreiz iepazīties ar aplikācijas noteikumiem un GDPR regulu.
- Iespēja pārskatīt citu lietotāju veidotos ierakstus.
- Iespēja dalīties ar citu lietotāju veidotiem ierakstiem.
- Iespēja verificēt savu profilu, izmantojot (ID dokumentu).
- Iespēja rediģēt savu profilu.
- Iespēja izmantot saraksti sarunai ar citiem lietotājiem.
=== Verificētā reģistrētā lietotāja iespējas
- Visas iespējas, kas ir parastajam reģistrētajam lietotājam.
- Iespēja izpildīt MBTI testu, kura rezultāti pievienosies pie profila.
- Iespēja bez ierobežojumiem rakstīt citiem verificētiem lietotājiem.
- Iespēja izmantot aplikācijas iebūvēto interaktīvo karti.
- Iespēja bez ierobežojumiem komentēt un atzīmēt saturu, kas iepatīkas.
- Iespēja veidot savu saturu (ierakstus, jaunas tikšanās, u.c.).
- Iespēja atrast un iepazīt jaunus cilvēkus pirms ceļojuma.
- Iespēja atrast un piebiedroties kādai esošai grupai.
- Iespēja nosūtīt ziņojumu virslietotājiem par kādu profilu vai saturu.
=== Virslietotāja iespējas
- Iespēja apskatīties verificēto lietotāju ziņojumus.
- Iespēja apskatīt visu saturu, kas tika publicēts platformā.
- Iespēja apskatīt citu lietotāju profilus.
- Iespēja dzēst citu lietotāju veidoto saturu.
- Iespēja dot lietotājiem brīdinājumus par noteikumu pārkāpšanu.
- Iespēja bloķēt lietotājus no aplikācijas.
- Iespēja rediģēt citu lietotāju profilus.
- Iespēja uz laiku deaktivizēt lietotāju kontus.
=== Administratora iespējas
- Visas iespējas, kas ir virslietotājam.
- Iespēja izveidot jaunus virslietotāja kontus.
- Iespēja norādīt virslietotāju kontu deaktivizācijas un aktivizācijas laikus.
- Iespēja redzēt virslietotāju jaunākās veiktās darbības.
- Iespēja ātri deaktivizēt virslietotāju kontus.
- Iespēja dzēst virslietotāja kontus.

== Sistēmas lietotāji
Vieslietotājs, parastais reģistrētais lietotājs, verificētais reģistrētais lietotājs, virslietotājs, administrators.

Vieslietotāji var apskatīt vispārīgo informāciju par aplikāciju, tajā informācija ietilpst aplikācijas reklāma, kas pamatos kāpēc šī aplikācija ir labāka nekā citiem, populāru cilvēku viedokļi par šo aplikāciju un citu cilvēku nesenās labās atsauksmes. Tajā pašā lapā būs parādīta statistika par aplikāciju - reģistrēto lietotāju skaits, krāsu karte, kurā tiek parādīts no kurām valstīm/pilsētām cilvēki visvairāk izmanto šo aplikāciju. Vieslietotājiem arī tiks piedāvāts iepazīties ar aplikācijas GDPR regulu un aplikācijas noteikumiem, lai turpmāk būtu iespējams izmantot šo aplikāciju. Tāpat arī tiks piedāvāts reģistrēties jauniem klientiem vai autorizēties jau esošiem lietotājiem. 

Parastiem reģistrētiem lietotājiem būs iespēja vēlreiz iepazīties ar platformas noteikumiem un GDPR regulu. Šiem lietotājiem būs pieeja pie aplikācijas iebūvētā čata. Tie ir iespēja rakstīt visiem cilvēkiem, kurus atradīs uz platformas, bet gadījumā, ja ziņas saņēmējs savos privātuma iestatījumos norādīja, lai neziņo par ziņām no neverificētiem lietotājiem, tad to ziņas tiek piegādātas bez notifikācijas un atsevišķā sadaļā no citām ziņām. Tie varēs pārskatīt un dalīties ar citu lietotāju izveidotiem ierakstiem, bet nebūs iespēja novērtēt vai komentēt rakstu. Nebūs iespējas izmantot daudzas citas aplikācijas funkcijas, jo tie nav verificējuši savu identitāti, tāpēc jebkurā laikā parastie lietotāji varēs apstiprināt savu identitāti, lai izmantotu visas aplikācijas funkcijas. Šo lietotāju grupa varēs brīvi rediģēt profila noteiktos datus - profila bildi, vārdu, uzvārdu, dzimšanas datumu, intereses, hobijus, valodas.

Verificētajiem reģistrētiem lietotājiem būs pieejamas visas iespējas kā parastiem reģistrētiem lietotājiem. Atšķirībā no neverificētiem lietotājiem, verificētajiem kontiem noņemas ierobežojumi uz aplikāciju funkcijām. Tie var brīvi komentēt un vērtēt citu lietotāju rakstus. Šo lietotāju grupa var izpildīt MBTI testu, kura rezultāti parādīsies profila, kas ļaus izmantot papildus algoritmus saderīgo cilvēku atrašanai. Ierobežojumi no ziņu sūtīšanas tiek noņemti un pilnīgi visas ziņas tiek piegādātas pie adresāta, ja iepriekš nebija aizbloķējuši. Arī ir iespēja izmantot aplikācijas interaktīvo karti, kurā varēs atrast citus cilvēkus. Šai lietotāju grupai ir noņemts ierobežojums no satura veidošanas. Var veidot jaunas tikšanās, ierakstus un grupas. Var arī brīvi piebiedroties kādai esošai grupai. Drošas platformas realizēsanai, verificētiem lietotājiem būs iespēja nosūtīt ziņojumu virslietotājam par kādu profilu vai saturu, kas pārkāpj platformas noteikumus.

Virslietotājiem būs atsevišķie konti, tāpēc visas iepriekšminētās tiesības uz virslietotāju neattiecas. Virslietotājiem ir iespēja ērti apskatīties visu saturu, kas tika publicēts aplikācijā. Tāpat būs iespēja apskatīties verificēto lietotāju ziņojumus par kādu profilu vai saturu, kas neatbilst platformas noteikumiem. Noteikumu pārkāpuma konstatēšanas gadījumā, šo lietotāju grupai būs iespēja dot brīdinājumus par noteikumu pārkāpšanu, bloķēt lietotājus no platformas, deaktivizēt lietotāju kontus uz noteiktu laiku, dzēst lietotāju veidoto saturu un rediģēt lietotāju profilus.

Administratoriem būs pieejamas visas virslietotāja tiesības un papildus tie pēc vajadzības varēs izveidot jaunus virslietotāju kontus, kuriem būs norādīti deaktivizācijas un aktivizācijas laiki un datumi, balstoties uz virslietotāja darba laiku. Administratoriem būs iespēja redzēt visas jaunākas darbības, kuras veica virslietotāji savā darba laikā. Gadījumā, ja tiek konstatēts pārkāpums virslietotāja darbībā, administratori var ātri deaktivizēt virslietotāja kontu. Tāpat arī šo lietotāju grupa pēc vajadzības var dzēst ārā virslietotāju kontus.

Visa informācija, ko var veikt lietotāji, shematiski parādīta 1.1. Attēlā.
#figure( image("assets/DPD0.png", width: 110%), caption: [Programmatūras 0.līmeņa DPD], )

== Vispārējie ierobežojumi
*Interneta savienojums*: Lietotnes darbībai nepieciešams stabils interneta savienojums, lai autentificētu lietotāju, nodrošinātu reāllaika darbības, piemēram saziņu ar citiem lietotājiem, satura ielādi no servera un jaunāko datu piegādi uz lietotāja ierīces.

*Platformas atbalsts*: Lietotne būs pieejama tikai ierīcēm ar iOS un Android 
operētājsistēmām. Lietotājiem, kuri izmanto citas mobilās platformas vai vecākas iOS un Android 
versijas, iespējams, nebūs piekļuves lietotnei vai tiks ierobežota tās funkcionalitāte.

*Lietotāja ierīces jauda*: Lietotnes darbība ir atkarīga no lietotāja ierīces tehniskajiem 
parametriem, piemēram, procesora jaudas un atmiņas. Lietotne var nedarboties optimāli vecākās 
vai lēnākās ierīcēs, īpaši attiecībā uz kartes, video, bilžu un audio funkcionalitāti un parādīšanu lietotājam, kas prasa 
lielākus resursus.

*Lietotnei pieejamā jauda un resursi*: Lietotāja ierīcē paralēli darbojas daudz dažādas programmas un procesi. Šie procesi viens otru ietekmē, un kāds process vai programma var patērēt visus ierīces resursus, samazinot konkrētas lietotnes ātrdarbību, radot aizturi un palēninot lietotnes darbības.

*Servera resursi un lietojums*: Plašā mērogā lietotai aplikācijai vienlaikus var būt daudz lietotāju, palielinot programmas noslodzi un palielinot darbību skaitu un datu apjomu. Šie var būt arī neregulāri pīķveidīgi noslodzes palielinājumu, kas var bremzēt visus procesus, izsmelt visus sistēmas resursus. Uz neparedzētu daudz lietotāju skaitu ir risks ka programmatūrai nepietiks resursi, kas var izraisīt kļūdu darbībā un ietekmēt visus lietotājus.

*Valodu atbalsts*: Lai gan lietotne piedāvās vairākvalodu atbalstu (latviešu, angļu, krievu, spāņu), 
lietotāju pieredze citās valodās var tikt ierobežota, jo ne visi lietotāji zin visas valodas. Publiski pieejamas var būt publikācijas un saturs, kas nav atbalstītā vai lietotājam saprotamā valodā.

*Datu aizsardzība*: Lietotnes funkcionalitāte, kas balstās uz personīgo datu ievākšanu, 
piemēram, personalizētie maršruti vai lietotāju atsauksmes, ir ierobežota ar Vispārīgās datu 
aizsardzības regulas (GDPR) prasībām. Lietotne būs pilnībā atkarīga no lietotāju piekrišanas datu 
apstrādei un iespējām nodrošināt datu drošību.

*Navigācija un kartēšanas pakalpojumi*: Lietotnes navigācijas funkcijas ir atkarīgas no 
trešo pušu kartēšanas un ģeogrāfisko datu pakalpojumu, piemēram, Google Maps API. Ja šie ārējie 
pakalpojumi piedzīvo traucējumus vai kļūmes, lietotne var nebūt spējīga pareizi rādīt maršrutus 
vai objektu atrašanās vietas.

*Lietotāju verifikācija*: Lietotāju verifikācijas funkcionalitāte ir atkarīga tikai no trešās puses. Datu apstrādi nodrošina ārpakalpojums, kā piemēram Sumsub API.


== Pieņēmumi un atkarības
1. Lai piekļūtu lietotnei, lietotājam ir jāizmanto Android (vismaz 12) vai iOS (vismaz 15) 
operētājsistēma.
2. Lietotne darbojas tikai, pie stabila interneta savienojuma, un pietiekama augšuplādes un lejuplādes ātruma, kas atkarīgs no lietojuma.
3. Ir lietotāji, kas lieto lietotni, nodrošinot informāciju, datus un pieejamību citiem lietotājiem.
4. karšu serviss (Google Maps) ir visu laiku pieejams.
5. Autentifikācijas servisi(Google/Apple Sign-In) uz autentifikācijas brīdi ir pieejami.
6. Serveris kur glabājas dati ir visu laiku pieejams.
7. Paziņojumu izsūtīšanas serviss(Firebase Cloud Messaging) ir pieejams uz paziņojuma izsūtīšanas brīdi.
8. Lietotāja ierīce ir pietiekami jaudīga.
9. Serveris uz kura darbina sistēmu ir pietiekami jaudīgs, iekļaujot pietiekamu ātrumu, atmiņu un diska vietu.




= Programmatūras prasību specifikācija


== Konceptuālais datu modelis
#figure( image("assets/konceptualais_modelis.drawio.png", width: 110%), caption: [Konceptuālais datu modelis], )

== Funkcionālās prasības
=== Sistēmas moduļi, to funkcijas, identifikatori un lietotāji
Lietotāju tipu saīsinājumi, kuri izmantoti @function-modules[tabulā]: ADM - administrators, MOD - virslietotājs, PRL - parasts reģistrēts lietotājs, VRL - verificēts reģistrēts lietotājs, GUEST - vieslietotājs.
#figure(
  caption: "Funkciju sadalījums pa moduļiem",
  table(
    columns: (1.75fr, 1.5fr, 1.6fr, 1.1fr, 1fr, 1fr, 1fr, 1fr),
    align: (x, y) => if y <= 1 or x >= 2 { center + horizon } else { left },
    inset: 5pt,
    table.header(
      table.cell(rowspan: 2)[Modulis],
      table.cell(rowspan: 2)[Funkcija],
      table.cell(rowspan: 2)[Identifikators],
      table.cell(colspan: 5)[Lietotāju tipi],
      [GUEST], [PRL], [VRL], [MOD], [ADM]
    ),
    //INFO modulis (app landing page)
    table.cell(rowspan: 3)[Informāciju modulis],
    [Apskatīt vispārīgo informāciju par lietotni], [IN_01], [x], [], [], [], [],
    [Apskatīt lietotnes statistiku], [IN_02], [x], [], [], [], [],
    [Izlasīt noteikumus un GDPR], [IN_03], [x], [x], [x], [x], [x],
    
    //Lietotāja modulis
    table.cell(rowspan: 9)[Lietotāju modulis],
    [Izveidot profilu], [LM_01], [x], [], [], [], [],
    [Izveidot profilu OAuth2], [LM_02], [x], [], [], [], [],
    [Rediģēt profilu], [LM_03], [], [x], [x], [], [],
    [Dzēst profilu], [LM_04], [], [x], [x], [], [],
    [Pieslēgties], [LM_05], [x], [], [], [], [],
    [Pieslēgties OAuth2], [LM_06], [x], [], [], [], [],
    [Atslēgties], [LM_07], [], [x], [x], [x], [x],
    [Verificēt kontu], [LM_08], [], [x], [], [], [],
    [Mainīt privātuma iestatījumus], [LM_09], [], [x], [x], [], [],

    //Matchmaking modulis
    table.cell(rowspan: 4)[Saderības modulis],
    [Izpildīt MBTI testu], [SM_01], [], [], [x], [], [],
    [Meklēt lietotājus pēc interesēm], [SM_02], [], [], [x], [], [],
    [Apskatīt saderības rezultātu], [SM_03], [], [], [x], [], [],
    [Atrast vietējos cilvēkus pirms ceļojuma], [SM_04], [], [], [x], [], [],

    //Sociālo plūsmu modulis
    table.cell(rowspan: 7)[Sociālo plūsmu modulis],
    [Apskatīt sociālo plūsmu], [SP_01], [], [x], [x], [], [],
    [Dalīties ar ierakstu], [SP_02], [], [x], [x], [], [],
    [Izveidot ierakstu], [SP_03], [], [], [x], [], [],
    [Atzīmēt ierakstu "patīk"], [SP_04], [], [], [x], [], [],
    [Komentēt ierakstu], [SP_05], [], [], [x], [], [],
    [Sekot lietotājam], [SP_06], [], [x], [x], [], [],
    [Apskatīt cita lietotāja profilu], [SP_07], [], [x], [x], [x], [x],

    //Ziņojumapmaiņu modulis
    table.cell(rowspan: 4)[Ziņojum-apmaiņu modulis],
    [Sūtīt ziņu], [CH_01], [], [x], [x], [], [],
    [Lasīt ziņas], [CH_02], [], [x], [x], [], [],
    [Bloķēt lietotāju čatā], [CH_03], [], [x], [x], [], [],
    [Saņemt push paziņojumus], [CH_04], [], [x], [x], [], [],

    //Interaktīvās kartes modulis
    table.cell(rowspan: 2)[Interaktīvās kartes modulis],
    [Apskatīt interaktīvo karti], [MP_01], [], [], [x], [], [],
    [Apskatīt lietotājus kartē], [MP_02], [], [], [x], [], [],

    //Notikumu modulis
    table.cell(rowspan: 4)[Notikumu modulis],
    [Izveidot tikšanos vai aktivitāti], [ET_01], [], [], [x], [], [],
    [Pieteikties tikšanās vai aktivitātei], [ET_02], [], [], [x], [], [],
    [Izveidot ceļojuma grupu], [ET_03], [], [], [x], [], [],
    [Pievienoties grupai], [ET_04], [], [], [x], [], [],

    //Moderāciju modulis
    table.cell(rowspan: 8)[Moderāciju modulis],
    [Ziņot par profilu vai saturu], [MD_01], [], [], [x], [], [],
    [Apskatīt ziņojumus], [MD_02], [], [], [], [x], [x],
    [Apskatīt visu publicēto saturu], [MD_03], [], [], [], [x], [x],
    [Dzēst lietotāja saturu], [MD_04], [], [], [], [x], [x],
    [Izdot brīdinājumu], [MD_05], [], [], [], [x], [x],
    [Bloķēt lietotāju], [MD_06], [], [], [], [x], [x],
    [Uz laiku deaktivizēt kontu], [MD_07], [], [], [], [x], [x],
    [Rediģēt lietotāja profilu], [MD_08], [], [], [], [x], [x],

    //Administrēšanas modulis
    table.cell(rowspan: 5)[Administrēšanas modulis],
    [Izveidot virslietotāja kontu], [AM_01], [], [], [], [], [x],
    [Norādīt virslietotāja konta aktivizācijas un deaktivizācijas laikus], [AM_02], [], [], [], [], [x],
    [Apskatīt virslietotāju jaunākās darbības], [AM_03], [], [], [], [], [x],
    [Ātri deaktivizēt virslietotāja kontu], [AM_04], [], [], [], [], [x],
    [Dzēst virslietotāja kontu], [AM_05], [], [], [], [], [x],
  ),
) <function-modules>

=== Sistēmas paziņojumi
Apzīmējumi, kuri ir izmantoti @system-messages[tabulā]: SMSG - vispārējie sistēmas paziņojumi (System message), EMSG - kļūdu paziņojumi (Error message).
#figure(
  caption: "Paziņojumu saraksts",
  table(
    columns: (1fr, 1.5fr, 2fr),
    align: (x, y) => if y == 0 or x == 0 { center + horizon } else { left },
    inset: 5pt,
    table.header[Identifikators][Funkcijas, kas lieto paziņojumu][Paziņojums],

    [SMSG_01], [LM_01, LM02], [Profils veiksmīgi izveidots!],
    [SMSG_02], [LM_03, MD_08], [Profila izmaiņas saglabātas!],
    [SMSG_03], [LM_04], [Vai tiešām vēlaties dzēst profilu? Šo darbību nevar atsaukt.],
    [SMSG_04], [LM_04], [Profils ir dzēsts.],
    [SMSG_05], [LM_07], [Jūs esat veiksmīgi atslēdzies no lietotnes.],
    [SMSG_06], [LM_08], [Verifikācijas dati nosūtīti pārbaudei.],
    [SMSG_07], [LM_08], [Jūsu profils ir veiksmīgi verificēts!],
    [SMSG_08], [LM_09], [Privātuma iestatījumi saglabāti.],
    [SMSG_09], [SM_01], [MBTI tests pabeigts. Rezultāts pievienots profilam.],
    [SMSG_10], [SM_02, SM_04], [Pēc norādītajiem kritērijiem lietotāji netika atrasti.],
    [SMSG_11], [SP_01], [Pagaidām nav neviena ieraksta, ko attēlot.],
    [SMSG_12], [SP_02], [Ieraksts ir kopīgots.],
    [SMSG_13], [SP_03], [Ieraksts ir publicēts.],
    [SMSG_14], [SP_06], [Jūs tagad sekojat lietotājam {lietotājvārds}.],
    [SMSG_15], [CH_03], [Lietotājs {lietotājvārds} ir bloķēts.],
    [SMSG_16], [CH_04], [Jauna ziņa no lietotāja {lietotājvārds}.],
    [SMSG_17], [CH_04], [Lietotājs {lietotājvārds} sāka Jums sekot.],
    [SMSG_18], [CH_04], [Lietotājs {lietotājvārds} atzīmēja vai komentēja Jūsu ierakstu.],
    [SMSG_19], [CH_04, ET_01], [Lietotājs {lietotājvārds} uzaicināja Jūs uz tikšanos {tikšanās nosaukums}.],
    [SMSG_20], [CH_04, SM_02], [Tuvumā ir atrasts saderīgs lietotājs.],
    [SMSG_21], [CH_04, MD_05], [Jūs saņēmāt brīdinājumu par platformas noteikumu pārkāpšanu. Tika pārkāpts {noteikuma numurs}.],
    [SMSG_22], [CH_04, MD_04], [Jūsu saturs tika dzēsts, jo tas pārkāpa platformas noteikumus. Tika pārkāpts {noteikuma numurs}. ],
    [SMSG_24], [ET_01], [Tikšanās vai aktivitāte ir izveidota.],
    [SMSG_25], [ET_02], [Jūs esat pieteicies tikšanās vai aktivitātei {tikšanās/aktivitātes nosaukums}.],
    [SMSG_26], [ET_03], [Ceļojuma grupa ir izveidota.],
    [SMSG_27], [ET_04], [Jūs esat pievienojies grupai {nosaukums}.],
    [SMSG_28], [MD_01], [Ziņojums nosūtīts virslietotājam. Paldies!],
    [SMSG_29], [MD_04], [Lietotāja saturs ir dzēsts.],
    [SMSG_30], [MD_05], [Brīdinājums ir nosūtīts lietotājam.],
    [SMSG_31], [MD_06], [Lietotājs ir bloķēts.],
    [SMSG_32], [MD_07], [Lietotāja konts uz laiku ir deaktivizēts.],
    [SMSG_33], [AM_01], [Virslietotāja konts ir izveidots.],
    [SMSG_34], [AM_02], [Konta aktivizācijas un deaktivizācijas laiki ir saglabāti.],
    [SMSG_35], [AM_04], [Virslietotāja konts ir deaktivizēts.],
    [SMSG_36], [AM_05], [Vai tiešām vēlaties dzēst virslietotāja kontu?],
    [SMSG_37], [AM_05], [Virslietotāja konts ir dzēsts.],
    [EMSG_01], [Visas, kad nav interneta savienojuma], [Nav interneta savienojuma. Pārbaudiet savienojumu un restartējiet aplikāciju.],
    [EMSG_02], [Visas, kad nav sasniedzams serveris], [Servera kļūda. Lūdzu, mēģiniet vēlāk.],
    [EMSG_03], [Visas funkcijas, kas prasa autorizāciju], [Sesija ir beigusies. Lūdzu, piesakieties vēlreiz.],
    [EMSG_04], [LM_01, LM_03], [Lūdzu, aizpildiet visus obligātos laukus.],
    [EMSG_05], [LM_01], [Konts ar šādu e-pastu jau eksistē!],
    [EMSG_06], [LM_01], [Parole neatbilst minimālām drošības prasībām.],
    [EMSG_07], [LM_01, LM_02], [Lai turpinātu, ir jāpiekrīt lietošanas noteikumiem un GDPR regulai.],
    [EMSG_08], [LM_02, LM_06], [Autentifikācija, izmantojot Google vai Apple nav izdevusies.],
    [EMSG_09], [LM_03], [Izmaiņas neizdevās saglabāt.],
    [EMSG_10], [LM_05], [Nepareizs e-pasts vai parole.],
    [EMSG_11], [LM_05, LM_06], [Jūsu konts ir bloķēts.],
    [EMSG_12], [LM_05, LM_06], [Jūsu konts ir deaktivizēts līdz {datums}.],
    [EMSG_13], [LM_05], [Konts šobrīd nav aktīvs atbilstošajam darba laikam.],
    [EMSG_14], [LM_08], [Verifikācija neizdevās. Pārbaudiet dokumenta datus un mēģiniet vēlreiz.],
    [EMSG_15], [LM_08], [Verifikācijas pakalpojums šobrīd nav pieejams.],
    [EMSG_16], [SM_01-SM_04, SP_03-SP_05, MP_01, MP_02, ET_01-ET_04, MD_01], [Šī funkcija ir pieejama tikai verificētiem lietotājiem.],
    [EMSG_17], [SP_03], [Failu neizdevās augšupielādēt. Pārbaudiet formātu un izmēru.],
    [EMSG_18], [SP_01, SP_07, CH_02], [Saturu neizdevās ielādēt.],
    [EMSG_19], [CH_01], [Ziņu neizdevās nosūtīt.],
    [EMSG_20], [MP_01, MP_02], [Nav piekļuves atrašanās vietai. Atļaujiet to ierīces iestatījumos.],
    [EMSG_21], [MP_01, MP_02], [Karti neizdevās ielādēt.],
    [EMSG_22], [ET_02, ET_04], [Šī tikšanās vai grupa vairs nav pieejama.],
  ),
) <system-messages>

=== Funkciju sadalījums pa moduļiem
//DPD1 laikam te
#figure( image("assets/DPD1.png", width: 110%), caption: [Programmatūras 1.līmeņa DPD], )

//FUNKCIJA TABULAS VEIDOŠANAI (MODUĻU FUNKCIJU APRAKSTĪŠANAI)
#let function-table(caption, id, goal, input, process, output) = figure(
  caption: caption,
  {
    set par(first-line-indent: 0pt, leading: 0.55em, justify: false)
    set enum(numbering: "1.", indent: 0pt)
    show table.cell.where(x: 0): strong
    table(
      columns: (1.2fr, 4fr),
      inset: 6pt,
      align: left + top,
      [Identifikators:], [#id],
      [Mērķis:], goal,
      [Ievaddati:], input,
      [Apstrāde:], process,
      [Izvaddati:], output,
    )
  },
)
//FUNKCIJA TABULAS VEIDOŠANAI (MODUĻU FUNKCIJU APRAKSTĪŠANAI)

#figure( image("assets/LietotajaDPD2_stils.png", width: 110%), caption: [2.līmeņa DPD lietotāju modulim], )

//Tabulas ar funkcijām
#function-table(
  "Izveidot profilu",
  "LM_01",
  [Vieslietotājs var izveidot jaunu lietotāja profilu sistēmā.],
  [
    Lietotāja ID - int - obligāts lauks (lietotājs nespēj aizpildīt) \
    Reģistrācijas datums – datums/laiks – obligāts lauks (lietotājs nespēj aizpildīt) \
    Lietotājvārds - teksta lauks - obligāts lauks \
    E-pasts - teksta lauks - obligāts lauks \
    Parole - teksta lauks - obligāts lauks \
    Piekrišana lietošanas noteikumiem un GDPR - izvēles rūtiņa - obligāts lauks
  ],
  [
    + Ievaddati tiek validēti. Ja kāds no obligātajiem laukiem nav aizpildīts, tiek parādīts kļūdas paziņojums EMSG_04.
    + Ja nav atzīmēta piekrišana lietošanas noteikumiem un GDPR, tiek parādīts paziņojums EMSG_07.
    + Tiek pārbaudīta paroles atbilstība minimālajām drošības prasībām. Ja neatbilst, tiek izvadīta kļūda EMSG_06.
    + Tiek pārbaudīts, vai konts ar šādu e-pastu jau eksistē datu bāzē. Ja eksistē, tiek izvadīts EMSG_05.
    + Ja kļūdu nav, profils tiek izveidots, dati saglabāti un lietotājs saņem paziņojumu SMSG_01.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Paziņojumi: SMSG_01; Kļūdas: EMSG_01, EMSG_02, EMSG_04, EMSG_05, EMSG_06, EMSG_07],
) <FT_1> //Tabulas id arī obligāti jāinkrementē. Next būs FT_2, utt.

#function-table(
  "Izveidot profilu OAuth2",
  "LM_02",
  [Vieslietotājs var reģistrēties un izveidot profilu, izmantojot ārējos autorizācijas pakalpojumus.],
  [
    Ārējā autorizācijas pakalpojuma dati (e-pasts, profila dati) \
    Piekrišana lietošanas noteikumiem un GDPR - izvēles rūtiņa - obligāts lauks
  ],
  [
    + Lietotājs izvēlas reģistrēties ar ārējo pakalpojumu (piem., Google vai Apple) un apstiprina piekļuvi ārējā pakalpojumā.
    + Ja lietotājs neapstiprina noteikumus vai GDPR regulu, tiek parādīts kļūdas paziņojums EMSG_07.
    + Ja autentifikācija ar ārējo pakalpojumu nav veiksmīga, tiek parādīta kļūda EMSG_08.
    + Veiksmīgas autentifikācijas un datu saņemšanas gadījumā tiek izveidots lietotāja profils datu bāzē un parādīts apstiprinājuma paziņojums SMSG_01.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Paziņojumi: SMSG_01; Kļūdas: EMSG_01, EMSG_02, EMSG_07, EMSG_08],
) <FT_2>

#function-table(
  "Rediģēt profilu",
  "LM_03",
  [Lietotājs var rediģēt esošā profila datus.],
  [
    Lietotāja ID – int – obligāts lauks (sistēmas noteikts) \
    Lietotājvārds - teksta lauks - obligāts lauks (sākotnēji aizpildīts ar esošo vērtību) \
    E-pasts - teksta lauks - obligāts lauks (sākotnēji aizpildīts ar esošo vērtību) \
    Parole - teksta lauks - neobligāts lauks (aizpilda tikai tad, ja vēlas mainīt paroli) \
    Profila attēls - failu ielāde - neobligāts lauks \
    Vārds, uzvārds - teksta lauki - neobligāti lauki \
    Dzimšanas datums - datums - neobligāts lauks \
    Intereses, hobiji - izvēles lauki - neobligāti lauki \
    Valodas - izvēles lauks - neobligāts lauks
  ],
  [
    + Lietotājs veic izmaiņas profila laukos un nospiež saglabāšanas pogu.
    + Ja nav aizpildīti obligātie pamata lauki (ja tādi tikuši iztukšoti), tiek parādīts EMSG_04.
    + Sistēma mēģina saglabāt datus datu bāzē. Ja datu bāzes vai sistēmas kļūdas dēļ izmaiņas neizdevās saglabāt, tiek izvadīts EMSG_09.
    + Veiksmīgas saglabāšanas gadījumā lietotājs saņem apstiprinājuma paziņojumu SMSG_02.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_02; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_04, EMSG_09],
) <FT_3>

#function-table(
  "Dzēst profilu",
  "LM_04",
  [Lietotājs var dzēst esošo profilu no sistēmas.],
  [
    Lietotāja ID – int – obligāts lauks \
    Dzēšanas apstiprinājums – bool
  ],
  [
    + Lietotājs izvēlas dzēst profilu.
    + Sistēma parāda brīdinājuma paziņojumu SMSG_03 ar lūgumu apstiprināt dzēšanu.
    + Ja lietotājs apstiprina dzēšanu, profils un ar to saistītie dati tiek dzēsti vai anonimizēti datu bāzē.
    + Lietotājam tiek izvadīts paziņojums SMSG_04.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_03, SMSG_04; Kļūdas: EMSG_01, EMSG_02, EMSG_03],
) <FT_4>

#function-table(
  "Pieslēgties",
  "LM_05",
  [Lietotājs pieslēdzas sistēmai, lai iegūtu savam kontam atbilstošās piekļuves tiesības.],
  [
    E-pasts – teksta lauks – obligāts lauks \
    Parole – teksta lauks – obligāts lauks
  ],
  [
    + Lietotājs ievada e-pastu un paroli.
    + Ja ievadīti nepareizi pieslēgšanās dati, tiek parādīts kļūdas paziņojums EMSG_10.
    + Ja konts ir bloķēts, tiek izvadīts EMSG_11.
    + Ja konts ir deaktivizēts līdz noteiktam datumam, tiek izvadīts EMSG_12.
    + Ja konts nav aktīvs atbilstošajā darba laikā, tiek izvadīts EMSG_13.
    + Ja pārbaudes ir veiksmīgas, tiek izveidota autorizēta sesija.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_10, EMSG_11, EMSG_12, EMSG_13],
) <FT_5>

#function-table(
  "Pieslēgties OAuth2",
  "LM_06",
  [Lietotājs pieslēdzas sistēmai, izmantojot savu Google vai Apple kontu.],
  [
    Ārējā pakalpojuma autorizācijas kods 
  ],
  [
    + Lietotājs izvēlas pieslēgties ar ārējo pakalpojumu un tiek pāradresēts uz ārējā pakalpojuma autorizācijas lapu.
    + Pēc veiksmīgas apstiprināšanas sistēma saņem autorizācijas žetonu un iegūst lietotāja e-pastu.
    + Ja autentifikācija ārējā pakalpojumā neizdodas, tiek parādīts kļūdas paziņojums EMSG_08.
    + Ja konts ir bloķēts, tiek parādīts paziņojums EMSG_11.
    + Ja konts ir deaktivizēts līdz noteiktam datumam, tiek parādīts paziņojums EMSG_12.
    + Ja pārbaudes ir veiksmīgas, tiek izveidota autorizēta sesija un lietotājs tiek pāradresēts uz sistēmu.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_08, EMSG_11, EMSG_12],
) <FT_6>

#function-table(
  "Atslēgties",
  "LM_07",
  [Lietotājs beidz darbu ar sistēmu un atslēdzas no sava konta.],
  [
    Nav
  ],
  [
    + Lietotājs nospiež pogu "Atslēgties".
    + Tiek pārtraukta aktīvā lietotāja sesija un dzēsti autorizācijas žetoni.
    + Lietotājam tiek izvadīts paziņojums SMSG_05.
    + Lietotājs tiek pāradresēts uz autentifikācijas vai sākuma skatu.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
    
  ],
  [Paziņojumi: SMSG_05; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_7>

#function-table(
  "Verificēt kontu",
  "LM_08",
  [Reģistrēts lietotājs veic savas identitātes verifikāciju, izmantojot Sumsub pakalpojumu.],
  [
    Sumsub SDK autorizācijas žetons \
    Personu apliecinoša dokumenta dati un sejas biometrija (tiek nodoti tieši Sumsub saskarnē)
  ],
  [
    + Lietotājs nospiež pogu "Verificēt kontu", un sistēma iniciē Sumsub verifikācijas saskarni.
    + Lietotājs Sumsub logā iesniedz nepieciešamos dokumentus un sejas skenējumu.
    + Dokumentu nosūtīšanas brīdī sistēma attēlo paziņojumu SMSG_06.
    + Ja Sumsub pakalpojums nav pieejams vai nevar izveidot savienojumu, tiek parādīta kļūda EMSG_15.
    + Ja Sumsub automātiski vai manuāli noraida verifikāciju, tiek izvadīta kļūda EMSG_14.
    + Veiksmīgas pārbaudes gadījumā lietotāja kontam tiek piešķirts verificēts statuss un parādīts paziņojums SMSG_07.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_06, SMSG_07; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_14, EMSG_15]
) <FT_8>

#function-table(
  "Mainīt privātuma iestatījumus",
  "LM_09",
  [Lietotājs var mainīt konta privātuma un drošības iestatījumus.],
  [
    Lietotāja ID – int – obligāts lauks \
    Privātuma iestatījumu parametri (piem., ziņojumu un paziņojumu saņemšanas preferences) – izvēles lauki
  ],
  [
    + Lietotājs atver privātuma iestatījumu sadaļu un veic izmaiņas savās preferencēs.
    + Lietotājs nospiež saglabāšanas pogu, un dati tiek atjaunināti datu bāzē.
    + Veiksmīgas saglabāšanas gadījumā lietotājs saņem apstiprinājuma paziņojumu SMSG_08.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_08; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_9>

=== Informāciju modulis
//DPD2 šim modulim
#figure( image("assets/InformacijaDPD2.png", width: 110%), caption: [2.līmeņa DPD informāciju modulim], )

#function-table(
  "Apskatīt vispārīgo informāciju par lietotni",
  "IN_01",
  [Vieslietotājs var iepazīties ar lietotnes sākumlapu un vispārīgo informāciju par platformu.],
  [
    Nav
  ],
  [
    + Lietotājs atver aplikācijas sākumlapu.
    + Sistēma attēlo reklāmas bloku (pamatojumu platformas priekšrocībām pār alternatīvām), sabiedrībā populāru cilvēku viedokļus, kā arī labās lietotāju atsauksmes.
    + Skatā lietotājam tiek piedāvātas arī saites uz reģistrāciju (jauniem klientiem) vai autorizāciju (esošajiem lietotājiem).
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Kļūdas: EMSG_01, EMSG_02]
) <FT_10>

#function-table(
  "Apskatīt lietotnes statistiku",
  "IN_02",
  [Vieslietotājs var aplūkot platformas kopējo statistiku.],
  [
    Nav
  ],
  [
    + Lietotājs atver sākumlapas statistikas sadaļu.
    + Sistēma ielādē un attēlo reģistrēto lietotāju kopējo skaits, kā arī vizuālu krāsu karti, kas parāda valstis un pilsētas, kurās aplikācija tiek izmantota visbiežāk.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Kļūdas: EMSG_01, EMSG_02]
) <FT_11>

#function-table(
  "Izlasīt noteikumus un GDPR",
  "IN_03",
  [Lietotāji var iepazīties ar aplikācijas lietošanas noteikumiem un GDPR privātuma politiku, lai saprastu nosacījumus turpmākai platformas izmantošanai.],
  [
    Nav
  ],
  [
    + Lietotājs izvēlas saiti vai sadaļu "Lietošanas noteikumi".
    + Sistēma ielādē un attēlo pilnu noteikumu un GDPR regulas dokumenta tekstu.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Kļūdas: EMSG_01, EMSG_02]
) <FT_12>

=== Saderības modulis
//DPD2 šim modulim
#figure( image("assets/SaderibaDPD2.png", width: 110%), caption: [2.līmeņa DPD saderību modulim], )

#function-table(
  "Izpildīt MBTI testu",
  "SM_01",
  [Verificēts lietotājs var aizpildīt MBTI personības tipa testu, kura rezultāts tiek saglabāts un pievienots viņa profilam.],
  [
    MBTI jautājumu atbilžu masīvs (jautājuma ID, izvēlētais skaitlis no 1 līdz 5 Likerta skalā) – obligāti lauki
  ],
  [
    + Lietotājs atver MBTI testa sadaļu.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Lietotājs secīgi atbild uz visiem jautājumiem.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
    + Pēc testa pabeigšanas sistēma aprēķina rezultātu, saglabā to datu bāzē un piesaista lietotāja profilam.
    + Lietotājs saņem paziņojumu SMSG_09.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Paziņojumi: SMSG_09; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_13>

#function-table(
  "Meklēt lietotājus pēc interesēm",
  "SM_02",
  [Verificēts lietotājs var meklēt citus platformas lietotājus, balstoties uz kopīgām interesēm un MBTI testa rezultātiem.],
  [
    Izvēlētās meklējamās intereses – izvēles saraksts – neobligāti lauki \
    Meklēšanas filtri - vecuma diapazons (min/max), meklēšanas rādiuss (km), dzimums - neobligāti lauki \
    Lietotāja MBTI tips (tiek iegūts automātiski no lietotāja profila datubāzē)
  ],
  [
    + Lietotājs atver meklēšanas sadaļu.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Lietotājs norāda vai izvēlas meklējamās intereses no sistēmas uzturētā klasifikatora saraksta un norāda meklēšanas filtrus (vecumu, rādiusu, dzimumu).
    + Sistēma nolasa profilus, atlasot lietotājus pēc rādiusa, vecuma un dzimuma filtriem.
    + Sistēma aprēķina kopējo saderības procentu, summējot punktus par MBTI tipu savstarpējo sakritību un bonusu par kopīgajām interesēm (katra kopīgā interese dod papildu procentus, ja sakrīt vismaz 2 intereses).
    + Par saderīgiem tiek atlasīti tikai tie lietotāji, kuru kopējais saderības rādītājs sasniedz vismaz 50%.
    + Ja pēc norādītajām interesēm un MBTI kritērijiem nevienu lietotāju neatrod, sistēma parāda paziņojumu SMSG_10.
    + Ja rezultāti tiek atrasti, tie tiek sakārtoti un attēloti lietotājam.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_10; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_14>

#function-table(
  "Apskatīt saderības rezultātu",
  "SM_03",
  [Verificēts lietotājs var apskatīt savu saderības pakāpi un rezultātus ar citiem lietotājiem.],
  [
    Mērķa lietotāja ID vai references dati – sistēmas padoti lauki
  ],
  [
    + Lietotājs izvēlas apskatīt saderību ar konkrētu lietotāju vai saderības pārskatu.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Sistēma aprēķina vai ielādē saderības procentu, salīdzinot abu lietotāju MBTI tipu atbilstību un sakrītošo interešu skaitu.
    + Sistēma attēlo rezultātu vizuālā pārskatā (saderības %, kopīgās intereses un MBTI tipu aprakstu).
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_15>

#function-table(
  "Atrast vietējos cilvēkus pirms ceļojuma",
  "SM_04",
  [Verificēts lietotājs var atrast un sazināties ar vietējiem iedzīvotājiem un domubiedriem izvēlētajā pilsētā vai teritorijā pasākumu, aktivitāšu vai braucienu plānošanai.],
  [
    Atrašanās vieta / pilsēta – teksta lauks vai izvēle – obligāts lauks \
    Laika periods / datumi – datumu intervāls – neobligāts lauks \ 
    Aktivitātes vai pasākuma veids – izvēles lauks – neobligāts lauks
  ],
  [
    + Lietotājs atver vietējo cilvēku meklēšanas sadaļu.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Lietotājs norāda pilsētu/vietu un nepieciešamības gadījumā laika periodu vai plānotās aktivitātes veidu.
    + Datu bāzē tiek veikta meklēšana, atlasot vietējos lietotājus vai domubiedrus atbilstoši norādītajai vietai un laika rāmim.
    + Ja pēc norādītajiem kritērijiem lietotāji netiek atrasti, tiek parādīts paziņojums SMSG_10.
    + Veiksmīgas meklēšanas gadījumā tiek attēlots atbilstošo lietotāju saraksts turpmākai saziņai.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_10; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_16>

=== Sociālo plūsmu modulis
//DPD2 šim modulim
#figure( image("assets/SocialaDPD2.png", width: 110%), caption: [2.līmeņa DPD sociālo plūsmu modulim], )

#function-table(
  "Apskatīt sociālo plūsmu",
  "SP_01",
  [Lietotājs var aplūkot sociālo plūsmu ar citu lietotāju publicētajiem ierakstiem.],
  [
    Nav
  ],
  [
    + Lietotājs atver sociālās plūsmas sadaļu.
    + Tiek pieprasīti jaunākie ieraksti no datu bāzes. Ja plūsmā nav neviena ieraksta, tiek attēlots paziņojums SMSG_11.
    + Ja radusies kļūda datu ielādē, tiek izvadīta kļūda EMSG_18.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_11; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_18]
) <FT_17>

#function-table(
  "Dalīties ar ierakstu",
  "SP_02",
  [Lietotājs var dalīties (kopīgot) ar plūsmā esošu ierakstu.],
  [
    Ieraksta ID – sistēmas noteikts – obligāts lauks \
    Papildu komentārs / teksts (neobligāts) – teksta lauks
  ],
  [
    + Lietotājs pie izvēlētā ieraksta nospiež pogu "Dalīties".
    + Dati tiek saglabāti datu bāzē, izveidojot kopīgotā ieraksta saiti lietotāja profilā/plūsmā.
    + Veiksmīgas kopīgošanas gadījumā tiek parādīts paziņojums SMSG_12.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_12; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_18>

#function-table(
  "Izveidot ierakstu",
  "SP_03",
  [Verificēts lietotājs var izveidot un publicēt jaunu ierakstu (tekstu, attēlus vai citus failus) sociālajā plūsmā.],
  [
    Ieraksta teksts – teksta lauks – neobligāts lauks \
    Pievienotie faili / attēli – failu ielāde – neobligāts lauks \ 
    (Vismaz vienam no šiem laukiem jābūt aizpildītiem)
  ],
  [
    + Lietotājs atver ieraksta izveides logu un pievieno tekstveida saturu, attēlu/failu vai abus kopā.
    + Sistēma pārbauda lietotāja verifikācijas statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Ja tiek pievienoti faili, tiek pārbaudīts to formāts un izmērs. Ja faili neatbilst prasībām, tiek izvadīta kļūda EMSG_17.
    + Pēc veiksmīgas saglabāšanas ieraksts tiek publicēts un parādīts paziņojums SMSG_13.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_13; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16, EMSG_17]
) <FT_19>

#function-table(
  "Atzīmēt ierakstu 'patīk'",
  "SP_04",
  [Verificēts lietotājs var atzīmēt cita lietotāja ierakstu ar "patīk" (like).],
  [
    Ieraksta ID – sistēmas noteikts – obligāts lauks
  ],
  [
    + Lietotājs nospiež pogu "Patīk" zem izvēlētā ieraksta.
    + Sistēma pārbauda lietotāja verifikācijas statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Datu bāzē tiek atjaunināts ieraksta "patīk" atzīmju skaits un stāvoklis.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_20>

#function-table(
  "Komentēt ierakstu",
  "SP_05",
  [Verificēts lietotājs var pievienot komentāru zem publicēta ieraksta.],
  [
    Ieraksta ID – sistēmas noteikts – obligāts lauks \
    Komentāra teksts – teksta lauks – obligāts lauks
  ],
  [
    + Lietotājs ievada komentāra tekstu un nospiež pogu "Komentēt".
    + Sistēma pārbauda lietotāja verifikācijas statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Komentārs tiek saglabāts datu bāzē un attēlots zem attiecīgā ieraksta.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_21>

#function-table(
  "Sekot lietotājam",
  "SP_06",
  [Lietotājs var piesekot citam platformas lietotājam, lai redzētu viņa aktivitātes.],
  [
    Mērķa lietotāja ID – sistēmas noteikts – obligāts lauks
  ],
  [
    + Lietotājs cita lietotāja profilā vai plūsmā nospiež pogu "Sekot".
    + Datu bāzē tiek izveidota sekošanas saite starp abiem lietotājiem.
    + Sistēma izvada paziņojumu SMSG_14 (ietverot mērķa lietotāja lietotājvārdu).
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_14; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_22>

#function-table(
  "Apskatīt cita lietotāja profilu",
  "SP_07",
  [Lietotājs var apskatīt cita platformas lietotāja publisko profilu un viņa publicēto saturu.],
  [
    Mērķa lietotāja ID vai profila saite – sistēmas noteikts – obligāts lauks
  ],
  [
    + Lietotājs izvēlas un atver cita lietotāja profilu.
    + Tiek pieprasīti mērķa lietotāja profila dati un publiskie ieraksti.
    + Ja saturu neizdodas ielādēt, tiek attēlots paziņojums EMSG_18.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_18]
) <FT_23>

=== Ziņojumapmaiņu modulis
//DPD2 šim modulim
#figure( image("assets/ZinojumuDPD2.png", width: 110%), caption: [2.līmeņa DPD ziņojumapmaiņu modulim], )

#function-table(
  "Sūtīt ziņu",
  "CH_01",
  [Lietotājs var nosūtīt privātu ziņu citam platformas lietotājam.],
  [
    Saņēmēja lietotāja ID – sistēmas noteikts – obligāts lauks \ 
    Ziņas teksts un/vai pielikumi – teksta lauks / failu ielāde – obligāts lauks
  ],
  [
    + Lietotājs atver saraksti ar izvēlēto lietotāju, ievada tekstu un/vai pievieno failu un nospiež pogu "Sūtīt".
    + Sistēma pārbauda, vai sūtītājs nav bloķēts saņēmēja čatā.
    + Sistēma pārbauda saņēmēja privātuma iestatījumus: ja saņēmējs ir iestatījis saņemt ziņas no neverificētiem lietotājiem bez notifikācijas un sūtītājs ir neverificēts (PRL), ziņa tiek nogādāta saņēmēja atsevišķajā ziņu sadaļā un push paziņojums netiek nosūtīts. Pretējā gadījumā tiek izsaukta paziņojuma funkcija CH_04.
    + Ja radusies kļūda ziņas apstrādē vai nosūtīšanā, tiek izvadīts paziņojums EMSG_19.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_19]
) <FT_24>

#function-table(
  "Lasīt ziņas",
  "CH_02",
  [Lietotājs var aplūkot saņemtās un nosūtītās ziņas, kā arī sarakstu vēsturi.],
  [
    Nav
  ],
  [
    + Lietotājs atver ziņu / čata sadaļu un izvēlas konkrētu saraksti.
    + Tiek pieprasīti sarakstes dati no datu bāzes un attēloti lietotāja saskarnē (atsevišķi nodalot ziņas no neverificētiem lietotājiem, ja tāds filtrs ir aktivizēts saņēmēja profilā).
    + Atvērtās ziņas tiek atzīmētas kā izlasītas.
    + Ja ziņas neizdodas ielādēt, tiek attēlots paziņojums EMSG_18.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_18]
) <FT_25>

#function-table(
  "Bloķēt lietotāju čatā",
  "CH_03",
  [Lietotājs var nobloķēt citu lietotāju čatā, lai pārtrauktu jebkādu turpmāko ziņu saņemšanu no viņa.],
  [
    Bloķējamā lietotāja ID – sistēmas noteikts – obligāts lauks
  ],
  [
    + Lietotājs sarakstes logā vai profila opcijās izvēlas "Bloķēt lietotāju čatā".
    + Datu bāzē tiek izveidots bloķēšanas ieraksts starp abiem lietotājiem.
    + Sistēma attēlo paziņojumu SMSG_15 (ietverot bloķētā lietotāja lietotājvārdu).
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_15; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_26>

#function-table(
  "Saņemt push paziņojumus",
  "CH_04",
  [Lietotājs saņem sistēmas un citu moduļu ģenerētos reāllaika (push) paziņojumus ierīces ekrānā vai aplikācijā.],
  [
    Paziņojuma tips un saistītie dati (sistēmas nodoti lauki)
  ],
  [
    + Sistēmā tiek reģistrēts notikums, kas pieprasa paziņojuma nosūtīšanu lietotājam.
    + Sistēma pārbauda saņēmēja paziņojumu un privātuma iestatījumus.
    + Ja paziņojumi attiecīgajam notikumam ir atļauti, sistēma izsūta atbilstošo paziņojumu: Jauna ziņa (SMSG_16), jauns sekotājs (SMSG_17), ieraksta atzīme vai komentārs (SMSG_18), tikšanās uzaicinājums (SMSG_19), tuvumā atrasts saderīgs lietotājs (SMSG_20), brīdinājums par noteikumu pārkāpumu (SMSG_21), paziņojums par satura dzēšanu (SMSG_22).
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
  ],
  [Paziņojumi: SMSG_16, SMSG_17, SMSG_18, SMSG_19, SMSG_20, SMSG_21, SMSG_22; Kļūdas: EMSG_01, EMSG_02]
) <FT_27>

=== Interaktīvās kartes modulis
//DPD2 šim modulim
//#figure( image("assets/ZinojumuDPD2.png", width: 110%), caption: [2.līmeņa DPD interaktīvās kartes modulim], )

#function-table(
  "Apskatīt interaktīvo karti",
  "MP_01",
  [Verificēts lietotājs var atvērt un apskatīt interaktīvo karti ar savu pašreizējo atrašanās vietu.],
  [
    Lietotāja ģeolokācijas koordinātas (tiek iegūtas automātiski no ierīces GPS tūlīt pēc piekļuves atļaušanas) \
    Kartes slāņu pieprasījums (tiek pieprasīts automātiski no Google Maps API)
  ],
  [
    + Lietotājs atver kartes sadaļu saskarnē.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Sistēma pieprasa ierīces atrašanās vietas atļaujas. Ja piekļuve nav dota vai ir bloķēta, tiek izvadīta kļūda EMSG_20.
    + Sistēma ielādē kartes grafisko interfeisu un centrē to uz lietotāja pašreizējām koordinātām.
    + Ja kartes datus neizdevās ielādēt servera vai karšu servisa kļūdas dēļ, tiek parādīts paziņojums EMSG_21.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16, EMSG_20, EMSG_21]
) <FT_28>

#function-table(
  "Apskatīt lietotājus kartē",
  "MP_02",
  [Verificēts lietotājs var redzēt citus lietotājus uz interaktīvās kartes savā tuvumā.],
  [
    Lietotāja konta statuss (tiek iegūts automātiski no lietotāja profila) \ 
    Meklēšanas rādiuss kartē - neobligāts lauks — ja nav norādīts, tiek izmantots noklusējuma rādiuss 5 km, ar iespēju saskarnē to mainīt \
    Profilu filtrēšanas kritēriji (piem., vecums, intereses) - neobligāti lauki \
    Citu lietotāju ģeolokācijas koordinātas un konfidencialitātes iestatījumi (tiek nolasīti automātiski no datubāzes)
  ],
  [
    + Lietotājs kartes saskarnē aktivizē citu lietotāju attēlošanas slāni.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Sistēma pieprasa ierīces atrašanās vietas atļaujas. Ja piekļuve nav dota vai ir bloķēta, tiek izvadīta kļūda EMSG_20.
    + Sistēma nolasa no datubāzes to lietotāju koordinātas un profilus, kuri atrodas izvēlētajā rādiusā un kuru konfidencialitātes iestatījumi atļauj atrašanās vietas rādīšanu.
    + Sistēma nofiltrē bloķētos lietotājus un attēlo derīgos lietotāju marķierus uz kartes saskarnes.
    + Ja kartes vai citu lietotāju datu ielāde neizdodas, tiek parādīts paziņojums EMSG_21.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16, EMSG_20, EMSG_21]
) <FT_29>

=== Notikumu modulis
//DPD2 šim modulim
//#figure( image("assets/ZinojumuDPD2.png", width: 110%), caption: [2.līmeņa DPD notikumu modulim], )

#function-table(
  "Izveidot tikšanos vai aktivitāti",
  "ET_01",
  [Verificēts lietotājs var izveidot jaunu tikšanos vai aktivitāti.],
  [
    Nosaukums - teksts - obligāts lauks \ 
    Apraksts - teksts - obligāts lauks \
    Aktivitātes veids/kategorija - izvēle no saraksta - obligāts lauks \
    Datums un laiks - datuma/laika izvēle - obligāts lauks \
    Maksimālais dalībnieku skaits - skaitlis - neobligāts lauks \
    Lietotāja konta statuss (tiek iegūts automātiski no lietotāja profila datubāzē)
  ],
  [
    + Lietotājs atver jaunas tikšanās/aktivitātes izveides formu.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Lietotājs aizpilda vajadzīgos laukus un apstiprina izveidi.
    + Sistēma veic ievaddatu validāciju (pārbauda, vai obligātie lauki ir aizpildīti un datums ir nākotnē).
    + Sistēma saglabā jauno tikšanos/aktivitāti datubāzē un saista to ar izveidotāja profilu.
    + Pēc veiksmīgas saglabāšanas sistēma attēlo paziņojumu SMSG_24.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_24; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_30>

#function-table(
  "Pieteikties tikšanās vai aktivitātei",
  "ET_02",
  [Verificēts lietotājs var pieteikties citu lietotāju izveidotai tikšanās reizei vai aktivitātei.],
  [
    Izvēlētās tikšanās/aktivitātes ID (tiek nodots automātiski, nospiežot pogu "Pieteikties") \ 
    Lietotāja konta statuss (tiek iegūts automātiski no lietotāja profila datubāzē)
  ],
  [
    + Lietotājs izvēlas konkrētu tikšanos/aktivitāti un pieprasa pieteikšanos.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Sistēma pārbauda tikšanās statusu datubāzē. Ja tikšanās ir dzēsta, atcelta vai sasniegts maksimālais dalībnieku limits, tiek izvadīta kļūda EMSG_22.
    + Sistēma reģistrē lietotāja pieteikumu datubāzē un atjaunina dalībnieku sarakstu.
    + Sistēma attēlo apstiprinājuma paziņojumu SMSG_25.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_25; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16, EMSG_22]
) <FT_31>

#function-table(
  "Izveidot ceļojuma grupu",
  "ET_03",
  [Verificēts lietotājs var izveidot jaunu ceļojuma grupu.],
  [
    Grupas nosaukums - teksts - obligāts lauks \ 
    Galamērķis / Maršruts - teksts - obligāts lauks \
    Ceļojuma laika periods / datumi - datumu izvēle - obligāts lauks \
    Grupas apraksts un mērķi - teksts - neobligāts lauks \
    Maksimālais dalībnieku skaits - skaitlis - neobligāts lauks \
    Lietotāja konta statuss (tiek iegūts automātiski no lietotāja profila datubāzē)
  ],
  [
    + Lietotājs atver ceļojuma grupas izveides logu.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Lietotājs aizpilda grupas datus un apstiprina izveidi.
    + Sistēma pārbauda ievadīto datu pareizību un datumu loģiku.
    + Sistēma saglabā ceļojuma grupu datubāzē, piešķirot izveidotājam grupas vadītāja tiesības.
    + Sistēma parāda paziņojumu SMSG_26.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_26; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_32>

#function-table(
  "Pievienoties grupai",
  "ET_04",
  [Verificēts lietotājs var pievienoties esošai ceļojuma grupai.],
  [
    Izvēlētās ceļojuma grupas ID (tiek nodots automātiski, izvēloties grupu) \ 
    Lietotāja konta statuss (tiek iegūts automātiski no lietotāja profila datubāzē)
  ],
  [
    + Lietotājs izvēlas ceļojuma grupu un nospiež pogu "Pievienoties".
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Sistēma pārbauda grupas statusu datubāzē. Ja grupa ir dzēsta, arhīvā vai sasniegusi dalībnieku limitu, tiek parādīta kļūda EMSG_22.
    + Sistēma pievieno lietotāju grupas dalībnieku sarakstam datubāzē.
    + Sistēma attēlo paziņojumu SMSG_27.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_27; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16, EMSG_22]
) <FT_33>

=== Moderācijas modulis
//DPD2 šim modulim
//#figure( image("assets/ZinojumuDPD2.png", width: 110%), caption: [2.līmeņa DPD moderācijas modulim], )

#function-table(
  "Pievienoties grupai",
  "MD_01",
  [Verificēts lietotājs var nosūtīt ziņojumu (sūdzību) par cita lietotāja profilu vai publicēto saturu.],
  [
    Ziņojuma objekta ID (lietotāja ID vai satura ID, tiek iegūts automātiski) \ 
    Ziņojuma iemesls / kategorija - izvēle no saraksta - obligāts lauks \
    Papildu apraksts - teksts - neobligāts lauks \
    Lietotāja konta statuss (tiek iegūts automātiski no lietotāja profila datubāzē)
  ],
  [
    + Lietotājs izvēlas opciju ziņot par profilu vai konkrētu saturu.
    + Sistēma pārbauda lietotāja konta statusu. Ja lietotājs nav verificēts, tiek izvadīta kļūda EMSG_16.
    + Lietotājs norāda ziņošanas iemeslu, pievieno aprakstu un nosūta ziņojumu.
    + Sistēma pārbauda ievadītos datus un saglabā ziņojumu datubāzē moderācijas rindā virslietotājiem un administratoriem.
    + Sistēma parāda apstiprinājuma paziņojumu SMSG_28.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_28; Kļūdas: EMSG_01, EMSG_02, EMSG_03, EMSG_16]
) <FT_34>

#function-table(
  "Apskatīt ziņojumus",
  "MD_02",
  [Virslietotājs un administrators var apskatīt iesniegto ziņojumu (sūdzību) sarakstu un to detaļas.],
  [
    Izpildītāja loma un autorizācijas sesija (tiek iegūta automātiski) \ 
    Ziņojuma statuss - izvēle no saraksta - neobligāts lauks \
    Ziņojuma kategorija / iemesls - izvēle no saraksta - neobligāts lauks \
    Sākuma un beigu datums laika filtram - datumu izvēle - neobligāti lauki
  ],
  [
    + Virslietotājs vai administrators atver moderācijas sadaļu.
    + Sistēma pārbauda lietotāja tiesības (MOD vai ADM lomu). Ja tiesības nav pietiekamas, piekļuve tiek liegta.
    + Sistēma nolasa no datubāzes saņemto ziņojumu sarakstu, ņemot vērā norādītos statusa, kategorijas un datuma filtrus.
    + Sistēma attēlo ziņojumu sarakstu ar iespēju atlasīt konkrētus gadījumus izskatīšanai.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_35>

#function-table(
  "Apskatīt visu publicēto saturu",
  "MD_03",
  [Virslietotājs un administrators var pārraudzīt un apskatīt visu platformā publicēto saturu.],
  [
    Izpildītāja loma un autorizācijas sesija (tiek iegūta automātiski) \ 
    Satura veids - izvēle no saraksta - neobligāts lauks \
    Lietotāja identifikators vai vārds - teksta meklēšanas lauks - neobligāts lauks \
    Publicēšanas sākuma un beigu datums - datumu izvēle - neobligāti lauki
  ],
  [
    + Virslietotājs vai administrators pieprasa publicētā satura pārraudzības skatu.
    + Sistēma pārbauda lietotāja tiesības (MOD vai ADM lomu). Ja tiesības nav pietiekamas, piekļuve tiek liegta.
    + Sistēma nolasa no datubāzes publicētos ierakstus, pasākumus un grupas, ņemot vērā izvēlētos satura veida, lietotāja un datuma filtrus.
    + Sistēma attēlo satura sarakstu ar pieejamiem moderācijas rīkiem un darbībām pie katra ieraksta.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_36>

#function-table(
  "Dzēst lietotāja saturu",
  "MD_04",
  [Virslietotājs un administrators var dzēst noteikumus pārkāpjošu lietotāja saturu.],
  [
    Dzēšamā satura ID (tiek iegūts automātiski izvēloties saturu) \ 
    Pārkāptā noteikuma numurs - izvēle no saraksta - obligāts lauks \
    Dzēšanas iemesls / paskaidrojums - teksts - neobligāts lauks) \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Virslietotājs vai administrators izvēlas konkrētu saturu un atver satura dzēšanas formu.
    + Sistēma pārbauda lietotāja tiesības (MOD vai ADM lomu). Ja tiesības nav pietiekamas, piekļuve tiek liegta.
    + Izpildītājs norāda pārkāptā noteikuma numuru, pēc vajadzības pievieno paskaidrojumu un apstiprina dzēšanu.
    + Sistēma dzēš vai arhivē izvēlēto saturu datubāzē.
    + Sistēma nosūta satura autoram paziņojumu SMSG_22.
    + Sistēma parāda izpildītājam apstiprinājuma paziņojumu SMSG_29.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_22, SMSG_29; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_37>

#function-table(
  "Izdot brīdinājumu",
  "MD_05",
  [Virslietotājs un administrators var izdot oficiālu brīdinājumu lietotājam par noteikumu pārkāpumu.],
  [
    Mērķa lietotāja ID (tiek iegūts automātiski) \ 
    Pārkāptā noteikuma numurs - izvēle no saraksta - obligāts lauks \
    Brīdinājuma paskaidrojums - teksts - neobligāts lauks) \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Virslietotājs vai administrators izvēlas lietotāja profilu un pieprasa brīdinājuma izdošanu.
    + Sistēma pārbauda lietotāja tiesības (MOD vai ADM lomu). Ja tiesības nav pietiekamas, piekļuve tiek liegta.
    + Izpildītājs izvēlas pārkāpto noteikumu, norāda iemeslu un apstiprina brīdinājuma sūtīšanu.
    + Sistēma reģistrē brīdinājuma ierakstu lietotāja konta vēsturē datubāzē.
    + Sistēma dzēš vai arhivē izvēlēto saturu datubāzē.
    + Sistēma nosūta pārkāpējam brīdinājuma paziņojumu SMSG_21.
    + Sistēma parāda izpildītājam apstiprinājumu SMSG_30.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_21, SMSG_30; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_38>

#function-table(
  "Bloķēt lietotāju",
  "MD_06",
  [Virslietotājs un administrators var pilnībā bloķēt pārkāpēja piekļuvi platformai.],
  [
    Bloķējamā lietotāja ID (tiek iegūts automātiski) \ 
    Pārkāptā noteikuma numurs - izvēle no saraksta - obligāts lauks \
    Bloķēšanas iemesls - teksts - neobligāts lauks) \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Virslietotājs vai administrators izvēlas lietotāja profilu un pieprasa tā bloķēšanu.
    + Sistēma pārbauda lietotāja tiesības (MOD vai ADM lomu). Ja tiesības nav pietiekamas, piekļuve tiek liegta.
    + Izpildītājs izvēlas pārkāpto noteikumu, norāda iemeslu un apstiprina bloķēšanu.
    + Sistēma atjaunina lietotāja konta statusu datubāzē uz "Bloķēts" un pārtrauc viņa aktīvās autorizācijas sesijas.
    + Sistēma parāda izpildītājam paziņojumu SMSG_31.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_31; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_39>

#function-table(
  "Uz laiku deaktivizēt kontu",
  "MD_07",
  [Virslietotājs un administrators var uz noteiktu laika periodu apturēt lietotāja konta darbību.],
  [
    Mērķa lietotāja ID (tiek iegūts automātiski) \ 
    Deaktivizācijas ilgums dienās - skaitlis - obligāts lauks \
    Pārkāptā noteikuma numurs - izvēle no saraksta - obligāts lauks \
    Deaktivizācijas iemesls - teksts - neobligāts lauks) \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Virslietotājs vai administrators norāda lietotāju un izvēlas konta temporāru deaktivizēšanu.
    + Sistēma pārbauda lietotāja tiesības (MOD vai ADM lomu). Ja tiesības nav pietiekamas, piekļuve tiek liegta.
    + Izpildītājs izvēlas pārkāpto noteikumu, deaktivizācijas ilgumu, norāda iemeslu un apstiprina deaktivizāciju.
    + Sistēma iestata konta statusu par deaktivizētu un piesaista deaktivizācijas beigu termiņu datubāzē.
    + Sistēma pārtrauc lietotāja aktīvās sesijas un parāda izpildītājam paziņojumu SMSG_32.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_32; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_40>

#function-table(
  "Rediģēt lietotāja profilu",
  "MD_08",
  [Virslietotājs un administrators var labot vai dzēst neatbilstošu profila informāciju (piemēram, nepienācīgu vārdu, aprakstu vai attēlu).],
  [
    Mērķa lietotāja ID (tiek iegūts automātiski) \ 
    Labojamie profila lauki (piem., vārds, apraksts, attēls) - teksts/fails - neobligāti lauki \
    Pārkāptā noteikuma numurs - izvēle no saraksta - neobligāts lauks \
    Rediģēšanas iemesls / paskaidrojums - teksts - neobligāts lauks \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Virslietotājs vai administrators atver lietotāja profila rediģēšanas formu moderācijas rīkos.
    + Sistēma pārbauda lietotāja tiesības (MOD vai ADM lomu). Ja tiesības nav pietiekamas, piekļuve tiek liegta.
    + Izpildītājs veic nepieciešamās izmaiņas profila laukos, norāda iemeslu (un pēc nepieciešamības pārkāptā noteikuma numuru) un apstiprina saglabāšanu.
    + Sistēma veic datu pārbaudi un atjaunina profilu datubāzē.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_41>

=== Administrēšanas modulis
//DPD2 šim modulim
//#figure( image("assets/ZinojumuDPD2.png", width: 110%), caption: [2.līmeņa DPD administrēšanas modulim], )

#function-table(
  "Izveidot virslietotāja kontu",
  "AM_01",
  [Administrators var izveidot jaunu virslietotāja (MOD) kontu sistēmā.],
  [
    Lietotājvārds - teksts - obligāts lauks \ 
    E-pasta adrese - teksts - obligāts lauks \
    Sākotnējā parole - teksts - obligāts lauks \
    Tālruņa numurs - teksts - neobligāts lauks \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Administrators atver virslietotāja konta izveides logu.
    + Sistēma pārbauda izpildītāja lomu. Ja lietotājs nav ADM, piekļuve tiek liegta.
    + Administrators aizpilda nepieciešamos laukus un apstiprina izveidi.
    + Sistēma pārbauda ievadīto datu formātu un e-pasta unikālumu datubāzē.
    + Sistēma izveido jaunu virslietotāja kontu datubāzē ar tiesību līmeni MOD.
    + Sistēma attēlo paziņojumu SMSG_33.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_33; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_42>

#function-table(
  "Norādīt virslietotāja konta aktivizācijas un deaktivizācijas laikus",
  "AM_02",
  [Administrators var iestatīt konkrētu laika periodu, kurā virslietotāja konts ir aktīvs.],
  [
    Virslietotāja konta ID (tiek iegūts automātiski, izvēloties kontu) \ 
    Aktivizācijas datums un laiks - datums/laiks - obligāts lauks \
    Deaktivizācijas datums un laiks - datums/laiks - obligāts lauks \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Administrators izvēlas virslietotāja kontu un atver laika iestatījumu formu.
    + Sistēma pārbauda izpildītāja lomu. Ja lietotājs nav ADM, piekļuve tiek liegta.
    + Administrators norāda aktivizācijas un deaktivizācijas datumus un laikus.
    + Sistēma pārbauda, vai deaktivizācijas laiks ir vēlāks par aktivizācijas laiku.
    + Sistēma saglabā norādītos laika ierobežojumus virslietotāja konta profila datos datubāzē.
    + Sistēma attēlo paziņojumu SMSG_34.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_34; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_43>

#function-table(
  "Apskatīt virslietotāju jaunākās darbības",
  "AM_03",
  [Administrators var pārskatīt virslietotāju veikto darbību auditācijas žurnālu.],
  [
    Virslietotāja konta ID - skaitlis - neobligāts lauks \ 
    Darbības veids - izvēle no saraksta - neobligāts lauks \
    Sākuma un beigu datums - datumu izvēle - neobligāti lauki \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Administrators pieprasa virslietotāju darbību žurnāla skatu.
    + Sistēma pārbauda izpildītāja lomu. Ja lietotājs nav ADM, piekļuve tiek liegta.
    + Sistēma nolasa no datubāzes audita žurnāla ierakstus atbilstoši izvēlētajiem filtriem.
    + Sistēma attēlo virslietotāju veikto darbību sarakstu ar laika zīmogiem un detaļām.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_44>

#function-table(
  "Ātri deaktivizēt virslietotāja kontu",
  "AM_04",
  [Administrators var nekavējoties apturēt virslietotāja konta darbību un piekļuves tiesības.],
  [
    Virslietotāja konta ID (tiek iegūts automātiski, izvēloties kontu) \ 
    Deaktivizācijas iemesls - teksts - neobligāts lauks \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Administrators atver virslietotāju sarakstu un pieprasa konkrēta konta tūlītēju deaktivizēšanu.
    + Sistēma pārbauda izpildītāja lomu. Ja lietotājs nav ADM, piekļuve tiek liegta.
    + Sistēma datubāzē nomaina virslietotāja konta statusu uz "Deaktivizēts" un pārtrauc viņa aktīvās autorizācijas sesijas.
    + Sistēma attēlo paziņojumu SMSG_35.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_35; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_45>

#function-table(
  "Dzēst virslietotāja kontu",
  "AM_05",
  [Administrators var pilnībā dzēst virslietotāja kontu no sistēmas.],
  [
    Virslietotāja konta ID (tiek iegūts automātiski, izvēloties kontu) \ 
    Dzēšanas iemesls / paskaidrojums - teksts - neobligāts lauks \
    Dzēšanas apstiprinājuma izvēle - loģiskais tips (Jā/Nē) - obligāts lauks \
    Izpildītāja loma (tiek iegūta automātiski)
  ],
  [
    + Administrators pieprasa virslietotāja konta dzēšanu.
    + Sistēma pārbauda izpildītāja lomu. Ja lietotājs nav ADM, piekļuve tiek liegta.
    + Administratori norāda dzēšanas iemeslu un apstiprina darbību.
    + Sistēma izvada apstiprinājuma vaicājuma paziņojumu SMSG_36.
    + Sistēma reģistrē dzēšanas iemeslu audita žurnālā un dzēš virslietotāja konta ierakstu un tā piekļuves tiesības no datubāzes.
    + Sistēma attēlo paziņojumu SMSG_37.
    + Ja nav interneta savienojuma vai serveris nav sasniedzams, tiek parādīts paziņojums EMSG_01 vai EMSG_02.
    + Ja autorizācijas sesija ir beigusies, tiek izvadīts paziņojums EMSG_03.
  ],
  [Paziņojumi: SMSG_36, SMSG_37; Kļūdas: EMSG_01, EMSG_02, EMSG_03]
) <FT_46>

== Nefunkcionālās prasības
=== Veiktspējas prasības
- Sistēmai jānodrošina normāla darbība vismaz 200 lietotājiem vienlaicīgi.
- Vismaz 95% no lietotāju autentificēšanas, profilu atvēršanas un sociālās plūsmas ielādes pieprasījumiem jāizpildās ne ilgāk kā 3 sekundēs.
- Vismaz 95% no lietotāju meklēšanas un MBTI saderības aprēķināšanas pieprasījumiem jāizpildās ne ilgāk kā 5 sekundēs.
- Vismaz 95% no nosūtītajām čata ziņām jāparādās saņēmējam 3 sekunžu laikā, ja abiem lietotājiem ir stabils interneta savienojums.
- Sistēmai jāspēj atgriezt interaktīvajā kartē attēlojamos lietotāju un aktivitāšu datus ne ilgāk kā 5 sekundēs vismaz 95% pieprasījumu.
- Vismaz 95% no automātiski izveidotajiem push paziņojumiem jānodod Firebase Cloud Messaging pakalpojumam 10 sekunžu laikā pēc notikuma reģistrēšanas.

=== Izmantojamība
- Sistēmai jāatbalsta responsīvs dizains, pielāgojoties dažādiem mobilo ierīču ekrānu izmēriem.
- Lietotāja saskarnei jābūt pielāgotai portreta orientācijai.
- Lietotnei jābūt pieejamai latviešu, angļu, krievu un spāņu valodā.
- Lietotāja saskarnei jābūt viegli uztveramai, lai lietotāji varētu izmantot visas savai lomai pieejamās funkcijas.
- Lietotājam jāspēj piekļūt savam profilam, privātajām ziņām un aktivitāšu meklēšanai ne vairāk kā 3 darbībās no galvenās navigācijas.
- Pirms lietotāja konta vai publicētā satura neatgriezeniskas dzēšanas sistēmai jāpieprasa darbības apstiprinājums.
- Kļūdu gadījumā sistēmai jāattēlo lietotājam saprotami kļūdu paziņojumi.
- Teksta un fona krāsu kontrastam jābūt vismaz 4,5:1, kā arī jānodrošina operētājsistēmas teksta palielināšanas iespēju atbalsts.

=== Drošības prasības
- Katram lietotājam jānodrošina piekļuve tikai tām funkcijām, kas atbilst viņa lietotāja lomai.
- Lietotāju paroles jāglabā drošu jaucējvērtību veidā, izmantojot Argon2id vai līdzvērtīgu algoritmu.
- Visai datu pārsūtīšanai starp lietotni un serveri jāizmanto šifrēts HTTPS savienojums ar TLS 1.2 vai jaunāku versiju.
- Sistēmai jānodrošina aizsardzība pret SQL injekcijām un nesankcionētu piekļuvi lietotāju datiem.
- Lietotāju identitātes pārbaude jāveic, izmantojot Sumsub pakalpojumu. Sistēmas datubāzē nedrīkst pastāvīgi glabāt personu apliecinošu dokumentu attēlus.
- Lietotāja precīzu atrašanās vietu drīkst iegūt tikai ar viņa atļauju. Citiem lietotājiem redzamajai atrašanās vietai jāatbilst lietotāja privātuma iestatījumiem.
- Privātajām sarakstēm un nepubliskajiem profila datiem jābūt pieejamiem tikai lietotājiem ar atbilstošām piekļuves tiesībām.
- Personas datu apstrādei jāatbilst GDPR prasībām, nodrošinot lietotājiem iespēju pārvaldīt un pieprasīt savu personas datu dzēšanu.
- Sistēmai jāreģistrē virslietotāju un administratoru veiktās darbības, piemēram, lietotāju bloķēšana, satura dzēšana un kontu deaktivizēšana.

=== Pieejamības prasības
- Sistēmai jābūt pieejamai vismaz 99,5% no kalendārā mēneša laika, ieskaitot plānotās apkopes. Ārējo pakalpojumu darbības traucējumi šajā rādītājā netiek iekļauti.
- Pilnvērtīgai lietotnes darbībai jābūt pieejamam stabilam interneta savienojumam.
- Interneta savienojuma vai servera darbības traucējumu gadījumā sistēmai jāattēlo atbilstošs kļūdas paziņojums.
- Ja kāds no ārējiem pakalpojumiem nav pieejams, pārējām neatkarīgajām lietotnes funkcijām jāturpina darboties.
- Interneta savienojuma pārtraukuma gadījumā serverī saglabātās čata ziņas un lietotāju dati nedrīkst pazust.

=== Uzturēšanas prasības
- Sistēmai jābūt sadalītai atsevišķos moduļos, lai izmaiņas vienā modulī pēc iespējas neietekmētu pārējo moduļu darbību.
- Sistēmai automātiski jāveido datubāzes un lietotāju augšupielādēto failu rezerves kopijas vismaz reizi 24 stundās. Rezerves kopijas jāglabā šifrētā veidā atsevišķā krātuvē vismaz 30 dienas.
- Sistēmas bojājuma gadījumā jānodrošina datu atjaunošana ar ne vairāk kā 24 stundu datu zudumu un pamatfunkciju darbības atjaunošana ne ilgāk kā 8 stundās, ja pieejama rezerves infrastruktūra.
- Pirms sistēmas atjauninājumu ieviešanas jāveic to pārbaude atsevišķā testēšanas vidē.
- Sistēmas izmaiņas jāuztur versiju kontroles sistēmā.
- Sistēmai jāreģistrē servera kļūdas un ārējo pakalpojumu darbības traucējumi, lai administratori varētu tos identificēt un novērst.
- Google Maps, Firebase Cloud Messaging, Google/Apple Sign-In un Sumsub integrācijām jābūt veidotām tā, lai tās varētu atjaunināt, neietekmējot pārējo sistēmu.

// = Programmas projektējuma apraksts
// == Datu bāzes projektējums
// Teksts abcabc
// == Daļējs funkciju projektējums
// Teksts abcabc
// == Daļējs lietotāja saskrņu projektējums
// Teksts abcabc

#set heading(numbering: none)
#heading(level: 1, outlined: false)[Dokumentārā lapa]

#bibliography-here()

= Pielikumi
// #appendix(
//   caption: "Appendix table",
//   label: <table-1>,
// )[
//   #table(
//     columns: (1fr, 2fr),
//     table.header([Foto], [Bar]),
//     lorem(10), lorem(20),
//   )
// ]


// #figure(
//   kind: "appendix",
//   caption: "Another table",
//   table(
//     columns: (1fr, 2fr),
//     table.header([Foto], [Bar]),
//     lorem(10), lorem(20),
//   ),
// )
