# START HERE — GYM APP CONTENT PACK

Contenuti originali proposti per il progetto GYM_APP. Il formato JSON è un contratto di scambio creato per questo pacchetto: non è stato verificato contro il database o le API dell’app esistente.

## File e integrazione

- Il JSON principale contiene `schema_version`, `locale` e `items`.
- Ogni contenuto ha un ID stabile, titolo, testo breve per card, CTA e percorso `image` relativo alla radice del pacchetto.
- `CONTENUTI.md` raccoglie i testi leggibili; `CATALOGO.html` offre una consultazione locale illustrata dopo aver estratto lo ZIP.
- `items/` contiene un JSON per contenuto, identico all’elemento corrispondente del JSON principale.
- `manifest.json` elenca file, dimensioni effettive e checksum. Conservare gli ID quando si importano o aggiornano i contenuti.
- Importare tramite adattatore verso lo schema reale del progetto. Non creare automaticamente tabelle o API sulla base di questo esempio.
- I valori `null` indicano dati non disponibili: non mostrarli come zero e non inventare valori sostitutivi.

## Direzione visiva

Identità Black Performance con Home/Dailies Athletic Editorial: fotografia luminosa, chiara, moderna; materiali naturali, ambienti ariosi, persone adulte atletiche e curate. Le immagini sono generate con AI con resa fotografica, non scatti documentari di persone, sedi o piatti reali. Le copertine sportive non sostituiscono una dimostrazione tecnica.

Dark, Light e System restano temi dell’app: le fotografie non richiedono duplicati. Usare testo fuori dall’immagine quando possibile, evitando di coprire volti, mani e attrezzature. Le immagini sono fornite alla risoluzione nativa, senza stiramenti o ritagli distruttivi. I rapporti richiesti ai prompt sono circa 4:5 per ricette/allenamenti e 16:9 per corsi; leggere le dimensioni effettive nel manifest.

La palette UI proposta nel brief precedente era dark #0A0A0B, off-white e lime; light #F4F2EC. I colori dei tag alimentari sono specificati nel JSON ricette e sono una scelta di questo pacchetto. Il colore da solo non deve identificare una categoria: mantenere la scritta.

## Stato dei contenuti

Testi originali, non programmi personalizzati. Non sono stati eseguiti test in cucina o una validazione professionale dei protocolli. I riferimenti esterni supportano solo i principi generali indicati in FONTI.md, non certificano queste singole ricette o sessioni.

## Ricette e tag

20 ricette, una porzione ciascuna. Pesi di cereali e pasta a secco; carne e pesce a crudo; legumi già cotti e scolati quando indicato. Tempi indicativi, da adattare ad attrezzatura e spessore. Ingredienti, quantità e passaggi fanno fede; le immagini sono interpretazioni editoriali e possono avere guarnizioni o proporzioni leggermente diverse.

I tag sono già incorporati nei PNG: non sovrapporre una seconda etichetta nella UI. `tags` serve per filtri e accessibilità; i colori esatti richiesti sono in `tags` nel JSON, mentre la resa raster può variare leggermente.

SLIM non è una certificazione di basso contenuto calorico. PROTEIN identifica un ingrediente proteico centrale, non un claim quantitativo certificato. POWER non promette incrementi di forza. Calorie e macro sono lasciati null perché non calcolati su prodotti verificati: nascondere il blocco macro fino a validazione.

TESTOSTERONE* e DETOX* conservano il tema richiesto ma devono essere accompagnati dalla nota visibile `tag_note` anche nelle card: non è verificato che queste ricette aumentino il testosterone; DETOX non indica eliminazione di tossine. Per un’etichetta pubblica priva di tale ambiguità, i nomi proposti sono BALANCE e FRESH; la sostituzione richiederebbe anche aggiornare i PNG.

Gli allergeni elencati derivano dagli ingredienti; controllare le etichette effettive e le contaminazioni. Le porzioni di piatti leggeri o dessert non equivalgono automaticamente a un pasto completo per ogni persona.
