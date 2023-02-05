SELECT * FROM StrutturaRicettiva
 WHERE codiceStruttura NOT IN (
   SELECT Appartamento
    FROM Prenotazione
             JOIN Appartamento ON Prenotazione.Appartamento = StrutturaRicettiva
    WHERE ((? BETWEEN dataCheckIn AND dataCheckOut) OR (? BETWEEN
        dataCheckIn AND dataCheckOut) OR (dataCheckIn BETWEEN ? AND ?)
        OR (dataCheckOut BETWEEN ? AND ?))
) AND codiceStruttura NOT IN (SELECT DISTINCT Hotel FROM TipoStanza) AND codiceStruttura NOT IN (SELECT StrutturaRicettiva FROM Ostello)