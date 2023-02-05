SELECT codiceStruttura, annoDiIscrizione, nome,
       citta, via, cap
 FROM StrutturaRicettiva
 WHERE citta = ?
 AND (codiceStruttura IN (
    SELECT Ostello
    FROM Prenotazione
    WHERE Ostello IS NOT NULL
    GROUP BY Ostello
    HAVING COUNT(Ostello) < 3
)
 OR codiceStruttura IN (
    SELECT Appartamento
    FROM Prenotazione
    WHERE Appartamento IS NOT NULL
    GROUP BY Appartamento
    HAVING COUNT(Appartamento) < 3
)
 OR codiceStruttura IN (
    SELECT Hotel
    FROM Prenotazione
    LEFT JOIN (
        SELECT DISTINCT Hotel, codiceTipologia
        FROM TipoStanza
    ) AS H ON TipoStanza = H.codiceTipologia
    WHERE Hotel IS NOT NULL
    GROUP BY Hotel
    HAVING COUNT(Hotel) < 3
));