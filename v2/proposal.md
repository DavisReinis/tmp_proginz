# v2 proposal: cut documentation work, not features that are only hard to build

Rule used: this is a **documentation-only** course project, so a feature is expensive if it needs its own
function table, message rows, DPD arrows, data-model entity, DB table description, flow diagram or UI screen.
Hard-to-implement but cheap-to-describe features (MBTI compatibility, map) can stay.

## What the CodeLingo example shows the course accepts

- Structure: Ievads → 1 Vispārējais apraksts → 2 PPS (model, functions, messages, NFR) → **3 Programmatūras projektējuma apraksts** (DB logical/physical/table descriptions, partial function design, partial UI design).
- Size: **3 roles**, 5 modules, ~39 functions, only 8 SMSG + 11 EMSG, 5 DPD2, 6 flow/sequence diagrams, ~20 screen mockups.
- Function tables are short: no repeated "no internet / server down / session expired" lines.
- Our v1 is **bigger than the example in sections 1–2 and has no section 3 at all**, so the real risk is not finishing, not missing features.
- Use the example for structure and level of detail only; it has its own typos/inconsistencies (S003 used by login, duplicate 1.4.2, etc.).

## Documentation load: v1 vs v2 target

| Item | v1 | CodeLingo | v2 target |
|---|---|---|---|
| Roles | 5 | 3 | **3** (guest, user, admin) |
| Modules | 9 | 5 | **6** |
| Function tables | 46 | ~39 | **~22** |
| SMSG / EMSG rows | 36 / 22 | 8 / 11 | **~12 / ~10** |
| DPD2 diagrams | 9 needed, 5 exist | 5 | **6** (one per module) |
| Entities / DB tables to describe | ~14 + gaps | 13 | **~10** |
| Section 3 | missing | full | **scoped: ~10 tables, 4 flow diagrams, ~10 screens** |
| External services | Maps, Sign-In, FCM, Sumsub | 6 | **Maps, FCM** |

## What to remove or postpone (ordered by documentation saved)

### 1. Registered vs verified split + Sumsub ID verification → postpone
- Costs: LM_08, SMSG_06/07, EMSG_14/15/16 and a "check verified, else EMSG_16" step in ~15 function tables, a 5th role in every table and in 1.4/1.5.
- Replace with: email confirmation at registration. One "user" role.
- Fixes most of the contradictions found in `../problems.md` (who can comment, who can message whom).

### 2. Merge create/edit/delete into one table per object ("Pārvaldīt …")
- Biggest pure documentation saver. v1 has these triples as separate tables: profile edit/delete, admin objects.
- One function table "Pārvaldīt profilu" with Apstrāde steps for edit and delete. Same features, ~1/3 of the tables.
- Same for moderator accounts (create + deactivate + delete → one table).

### 3. Common errors and standard steps stated once
- EMSG_01 (no internet), EMSG_02 (server), EMSG_03 (session expired), plus "access denied" apply to **every** function: define once in 2.2.2 and delete the repeated 2–3 lines from every table.
- Saves ~100 lines and 3 message rows per table; also removes the "which function uses which EMSG" cross-checking errors.

### 4. Google/Apple Sign-In (OAuth2) → postpone
- Removes LM_02, LM_06, EMSG_08, `oauth_veids` column, one external service, one flow diagram.

### 5. Show events/trips on the map, not other users' locations; drop privacy settings page
- Removes MP_02, user coordinates, location-privacy settings, LM_09, SMSG_08, `privātuma_iestatījumi` and the "unverified messages go to separate section" logic.
- Fixes "map should show events" gap: map + event list become one function ("Pārlūkot pasākumus kartē/sarakstā").

### 6. Merge meetup + travel group into one entity: Pasākums (type: meetup / trip)
- 1 entity and 1 DB table instead of 2; functions: create, browse, join/leave (3 instead of 4 and incomplete).

### 7. Compatibility module: 4 → 2 functions, one formula
- Keep MBTI test and "find compatible users" (filters: interests, city); merge SM_03/SM_04 into it; drop gender/age/radius filters.
- Add one short formula (documented in 3–4 lines). Compute compatibility on the fly, no `Saderība` table.

### 8. Social feed: keep post, feed, react, profile view; drop share and follow
- 7 → 4 functions ("react" = like + comment in one table). Removes `seko`, `kopīgo` relations and their messages.

### 9. Push notifications: new message and moderation notice only
- Drops SMSG_14, 17, 18, 19 (invite with no function), 20 (needs background location). CH_04 becomes a paragraph, not a table.

### 10. Moderation + admin: 13 functions → 4–5
- Keep: report content/user, review & resolve reports, delete content, block/unblock user (merges warn/block/deactivate; free-text reason, no rules table), plus "manage admin accounts" only if 4 roles are kept.
- Drop: browse all content, edit others' profiles, warnings, working-hours scheduling, audit-log screen (just store "who/when" in a column).

### 11. Landing page: info + terms only
- Drop statistics/country heat-map and testimonials (IN_02). One function covers about the app + terms/GDPR.

### 12. Languages lv + en; shorter NFR
- Drop ru/es mention. Keep ~12 measurable NFR lines (performance, HTTPS/hash/GDPR, availability, backup).

## Proposed v2 modules and functions (≈22 function tables)

| Module | Functions |
|---|---|
| Lietotāji | Skatīt informāciju un noteikumus; Reģistrēties; Pieslēgties; Atslēgties; Pārvaldīt profilu (edit/delete) |
| Saderība | Izpildīt MBTI testu; Meklēt saderīgus lietotājus |
| Sociālais | Skatīt plūsmu; Izveidot ierakstu; Reaģēt (patīk/komentārs); Skatīt profilu |
| Ziņojumapmaiņa | Sūtīt ziņu; Lasīt ziņas; Bloķēt/atbloķēt lietotāju |
| Pasākumi un karte | Izveidot pasākumu (tikšanās/ceļojums); Pārlūkot pasākumus (karte/saraksts); Pieteikties/atteikties |
| Moderācija | Ziņot; Izskatīt ziņojumus; Dzēst saturu; Bloķēt/atbloķēt lietotāju |

(+1 function "Pārvaldīt administratoru kontus" only if Moderator and Admin stay separate roles.)

## Section 3 (missing in v1) scoped to be cheap

- 3.1 DB: logical model (~10 tables), physical model screenshot, table descriptions for ~10 tables (the slow part, so fewer entities help).
- 3.2 Partial function design: 4 diagrams (register/login, MBTI compatibility, event join, report-and-block).
- 3.3 Partial UI design: ~10 mockups (login/register, home/feed, profile, MBTI test, compatible users, map+events, event details, chat, report dialog, admin report list) plus a screen diagram.

## Structure fixes that cost nothing extra

- 1.4 and 1.5 duplicate each other: keep 1.4 as bullet lists, make 1.5 one short paragraph per role.
- One heading per module; module names identical everywhere; contiguous message numbering; no copy-paste titles; real `description`/title/abstract matching the content.
- Cite every source in the bibliography and remove uncited ones; use `@label` for figures and tables.

## Decisions needed

1. **Title.** Rename to match the content (e.g. "Ceļabiedru un domubiedru meklēšanas platforma") or keep "Ceļojumu plānošanas…" and keep trips as the headline feature (then the event/trip type should get a bit more detail)?
2. **Roles.** 3 roles like the example (guest, user, admin who also moderates; recommended, saves a role column and a module) or keep Moderator separate (4 roles)?
3. **Section 3.** Is the scope above right (~10 tables, 4 flow diagrams, ~10 screens)? Smaller is possible if your supervisor allows.
4. **Diagrams.** Should I draft the DPD/flow diagrams as draw.io files, or write only text and leave drawing to the team?

Say "go with recommended" and I will build the full v2 `main.typ` (sections 1–3) with all issues from `../problems.md` fixed.
