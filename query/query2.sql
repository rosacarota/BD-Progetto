# Query inserimento struttura
INSERT INTO StrutturaRicettiva (annoDiIscrizione, nome, citta, via, cap)
VALUES (?, ?, ?, ?, ?);

# Ottenimento del valore dell'ultimo codiceStruttura per inserire correttamente
# il codice della nuova struttura, equivalente a MAX(codiceStruttura) + 1
SELECT MAX(codiceStruttura) as Max FROM StrutturaRicettiva;

# Inserimento Hotel
INSERT INTO Hotel VALUES (?);

# Inserimento Tipi Stanza
INSERT INTO TipoStanza (tipologia, prezzoNotte, postiLetto, stanzePerTipologia, Hotel)
VALUES (?, ?, ?, ?, ?);

# Inserimento Ostello
INSERT INTO Ostello (StrutturaRicettiva, prezzoNottePostoLetto, postiLettoTotali)
VALUES(?, ?, ?);

# Inserimento Appartamento
INSERT INTO Appartamento (StrutturaRicettiva, prezzoNotte, postiLetto, metriQuadri, vani)
VALUES (?, ?, ?, ?, ?)