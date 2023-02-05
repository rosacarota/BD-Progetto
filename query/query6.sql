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
) AND codiceStruttura NOT IN (SELECT DISTINCT Hotel FROM TipoStanza) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Appartamento)
   OR codiceStruttura IN (
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
) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Appartamento) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Ostello)
   OR codiceStruttura NOT IN (
    SELECT Appartamento
    FROM Prenotazione
             JOIN Appartamento ON Prenotazione.Appartamento = StrutturaRicettiva
    WHERE ((? BETWEEN dataCheckIn AND dataCheckOut) OR (? BETWEEN
        dataCheckIn AND dataCheckOut) OR (dataCheckIn BETWEEN ? AND ?)
        OR (dataCheckOut BETWEEN ? AND ?))
) AND codiceStruttura NOT IN (SELECT DISTINCT Hotel FROM TipoStanza) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Ostello)