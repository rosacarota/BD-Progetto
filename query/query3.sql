# Verifica del cliente
SELECT numeroPrenotazioniAttive FROM Cliente
WHERE email = ?;

# Aumento delle prenotazioni totali e prenotazioni attive in cliente
UPDATE Cliente
SET numeroPrenotazioniAttive = numeroPrenotazioniAttive + 1, numeroPrenotazioni = numeroPrenotazioni + 1
WHERE email = ?;

# Visualizzazione agenzie di viaggio
SELECT * FROM AgenziaDiViaggio;

# Applicazione sconto per clienti premium
SELECT IFNULL(scontoPremium, 0) AS scontoPremium
FROM TesseraFedelta
WHERE Cliente = ?;

# Ostelli disponibili
SELECT * FROM StrutturaRicettiva
 WHERE codiceStruttura NOT IN (
    SELECT Ostello
    FROM Prenotazione
             JOIN Ostello ON Prenotazione.Ostello = StrutturaRicettiva
    WHERE ((? BETWEEN dataCheckIn AND dataCheckOut) OR (? BETWEEN
        dataCheckIn AND dataCheckOut) OR (dataCheckIn BETWEEN ? AND ?)
        OR (dataCheckOut BETWEEN ? AND ?))
    GROUP BY Prenotazione.Ostello, postiLettoTotali
    HAVING SUM(numeroOspiti) >= Ostello.postiLettoTotali
) AND codiceStruttura NOT IN (SELECT DISTINCT Hotel FROM TipoStanza) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Appartamento);

# Insert Prenotazione Ostelli
INSERT INTO Prenotazione (dataCheckIn, dataCheckOut, durataSoggiorno, prezzoTotale, numeroOspiti, Cliente, notaCliente, Ostello, AgenziaDiViaggio)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);

# Necessario per il calcolo del prezzo dell'ostello
SELECT prezzoNottePostoLetto FROM Ostello
WHERE StrutturaRicettiva = ?;

# Appartamenti disponibili
SELECT * FROM StrutturaRicettiva
 WHERE codiceStruttura NOT IN (
   SELECT Appartamento
    FROM Prenotazione
             JOIN Appartamento ON Prenotazione.Appartamento = StrutturaRicettiva
    WHERE ((? BETWEEN dataCheckIn AND dataCheckOut) OR (? BETWEEN
        dataCheckIn AND dataCheckOut) OR (dataCheckIn BETWEEN ? AND ?)
        OR (dataCheckOut BETWEEN ? AND ?))
) AND codiceStruttura NOT IN (SELECT DISTINCT Hotel FROM TipoStanza) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Ostello);

# Insert Prenotazione Appartamenti
INSERT INTO Prenotazione (dataCheckIn, dataCheckOut, durataSoggiorno, prezzoTotale, numeroOspiti, Cliente, notaCliente, Appartamento, AgenziaDiViaggio)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);

# Necessario per il calcolo del prezzo dell'appartamento
SELECT prezzoNotte FROM Appartamento
WHERE StrutturaRicettiva = ?;

# Hotel disponibili
SELECT * FROM StrutturaRicettiva
WHERE codiceStruttura IN (
    SELECT DISTINCT Hotel FROM TipoStanza
    WHERE codiceTipologia NOT IN (
        SELECT codiceTipologia
        FROM TipoStanza
                 JOIN (
            SELECT SUM(StanzePrenotate) AS StanzeTotaliPrenotate, TipoStanza
            FROM Prenotazione
                     JOIN TipoStanza TS on Prenotazione.TipoStanza = TS.codiceTipologia
            WHERE ((? BETWEEN dataCheckIn AND dataCheckOut) OR (? BETWEEN
                dataCheckIn AND dataCheckOut) OR (dataCheckIn BETWEEN ? AND ?)
                OR (dataCheckOut BETWEEN ? AND ?))
            GROUP BY TipoStanza
        ) AS Count ON codiceTipologia = Count.TipoStanza
        WHERE StanzeTotaliPrenotate >= TipoStanza.stanzePerTipologia
    )
) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Appartamento) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Ostello);


# Disponibilità stanze
SELECT * FROM TipoStanza
WHERE codiceTipologia NOT IN (
    SELECT codiceTipologia
    FROM TipoStanza
             JOIN (
        SELECT SUM(StanzePrenotate) AS StanzeTotaliPrenotate, TipoStanza
        FROM Prenotazione
                 JOIN TipoStanza TS on Prenotazione.TipoStanza = TS.codiceTipologia
        WHERE ((? BETWEEN dataCheckIn AND dataCheckOut) OR (? BETWEEN
            dataCheckIn AND dataCheckOut) OR (dataCheckIn BETWEEN ? AND ?)
            OR (dataCheckOut BETWEEN ? AND ?))
        GROUP BY TipoStanza
    ) AS Count ON codiceTipologia = Count.TipoStanza
    WHERE StanzeTotaliPrenotate >= TipoStanza.stanzePerTipologia
)
AND Hotel = ?;


# Insert Prenotazione Tipo stanza
INSERT INTO Prenotazione (dataCheckIn, dataCheckOut, durataSoggiorno, prezzoTotale, numeroOspiti, Cliente, notaCliente, TipoStanza, StanzePrenotate, AgenziaDiViaggio)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

# Necessario per il calcolo del prezzo della stanza
SELECT prezzoNotte FROM TipoStanza
WHERE codiceTipologia = ?;
