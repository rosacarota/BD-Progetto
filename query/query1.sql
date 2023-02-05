# Query inserimento cliente
INSERT INTO Cliente (email, passwd, nome, cognome, datadinascita, numeroDiTelefono, nazionalita)
VALUES (?, ?, ?, ?, ?, ?, ?);

# Query inserimento tessera
INSERT INTO TesseraFedelta (Cliente, tipo, dataEmissione, dataScadenza, scontoPremium)
VALUES (?, ?, ?, ?, ?)
