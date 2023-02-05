SELECT * FROM StrutturaRicettiva
 WHERE codiceStruttura NOT IN (
    # Query che restituisce gli Ostelli che non hanno posti sufficienti
    # durante il periodo di data indicato
    SELECT Ostello
    FROM Prenotazione
    JOIN Ostello ON Prenotazione.Ostello = StrutturaRicettiva
    WHERE ((? BETWEEN dataCheckIn AND dataCheckOut) OR (? BETWEEN
        dataCheckIn AND dataCheckOut) OR (dataCheckIn BETWEEN ? AND ?)
        OR (dataCheckOut BETWEEN ? AND ?))
    GROUP BY Prenotazione.Ostello, postiLettoTotali
    HAVING SUM(numeroOspiti) >= Ostello.postiLettoTotali
# È necessario escludere le altre strutture ricettive dal risultato
# Poiché ogni subquery è dedicata a garantire la disponibilità della propria struttura ricettiva
) AND codiceStruttura NOT IN (SELECT DISTINCT Hotel FROM TipoStanza) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Appartamento)
   OR codiceStruttura IN (
    # Query che restituisce soltanto gli Hotel che hanno almeno una stanza disponibile
    # durante il periodo di data indicato
    # se tutte le stanze, di ogni tipologia dell'Hotel sono piene allora l'Hotel sarà escluso
    SELECT DISTINCT Hotel FROM TipoStanza
    WHERE codiceTipologia NOT IN (
        # Query che restituisce le tipologie di stanze che sono piene
        # durante il periodo di data indicato
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
# È necessario escludere le altre strutture ricettive dal risultato
# Poiché ogni subquery è dedicata a garantire la disponibilità della propria struttura ricettiva
) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Appartamento) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Ostello)
   OR codiceStruttura NOT IN (
     # Query che restituisce gli Appartamenti che sono già stati prenotati
     # durante il periodo di data indicato
    SELECT Appartamento
    FROM Prenotazione
    JOIN Appartamento ON Prenotazione.Appartamento = StrutturaRicettiva
    WHERE ((? BETWEEN dataCheckIn AND dataCheckOut) OR (? BETWEEN
        dataCheckIn AND dataCheckOut) OR (dataCheckIn BETWEEN ? AND ?)
        OR (dataCheckOut BETWEEN ? AND ?))
# È necessario escludere le altre strutture ricettive dal risultato
# Poiché ogni subquery è dedicata a garantire la disponibilità della propria struttura ricettiva
) AND codiceStruttura NOT IN (SELECT DISTINCT Hotel FROM TipoStanza) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Ostello)