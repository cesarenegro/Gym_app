# CRITICAL RULE: MAI LANCIARE COMANDI IN BACKGROUND SE NON ESPRESSAMENTE RICHIESTO

> [!CAUTION]
> **REGOLA CRITICA E TASSATIVA**:
> Non lanciare MAI comandi in background o in esecuzione automatica (es. tramite `run_command` asincrono, `IsDaemon: true`, o tentativi automatici di build/deploy) a meno che l'utente non lo richieda **espressamente ed esplicitamente**.
>
> 1. Mostra sempre i comandi nel testo della risposta in modo che l'utente possa revisionarli ed eseguirli autonomamente quando desidera.
> 2. Chiedi sempre l'approvazione esplicita prima di avviare qualsiasi comando di esecuzione, server o build.
