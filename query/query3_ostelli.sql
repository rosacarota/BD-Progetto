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