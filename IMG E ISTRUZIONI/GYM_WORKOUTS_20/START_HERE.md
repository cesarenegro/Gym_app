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

## Uso delle sessioni

Le 20 schede sono un catalogo di allenamenti autonomi, non una sequenza obbligatoria di 20 giorni. Livello, carico e scelta della sessione dipendono dalla persona. Le durate sono indicative e comprendono riscaldamento e defaticamento. RPE è lo sforzo percepito da 1 a 10: non è una frequenza cardiaca prescritta.

Eseguire gli esercizi nell’ordine indicato per il numero di giri `rounds`. `rest_after_seconds` si applica tra gli esercizi; dopo l’ultimo esercizio di ogni giro, usare solo `between_rounds_rest_seconds` prima del giro successivo, senza sommare due pause. Nessuna pausa di giro dopo l’ultimo giro. Corsa e bike hanno recuperi già inclusi nella dose.

Ogni esercizio contiene dose, istruzione e variante più facile. Le copertine illustrano il tema della sessione; non sono video di esecuzione e non vanno utilizzate come diagrammi di postura. Nessuna promessa di calorie bruciate, dimagrimento localizzato o risultato garantito.
