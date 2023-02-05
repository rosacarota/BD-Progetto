SELECT IFNULL(IncassoTotale, 0) AS IncassoTotale, codiceStruttura, annoDiIscrizione, nome, citta, via, cap
 FROM StrutturaRicettiva
 LEFT JOIN (
    SELECT SUM(prezzoTotale) AS IncassoTotale, Ostello, Appartamento, Hotel
    FROM (
        SELECT prezzoTotale, Ostello, Appartamento, Hotel
        FROM Prenotazione
        LEFT JOIN (
            SELECT DISTINCT Hotel, codiceTipologia
            FROM TipoStanza
        ) AS H ON TipoStanza = H.codiceTipologia
    ) AS PrezziPrenotazioni
    GROUP BY Ostello, Appartamento, Hotel
) AS IncassiOstello ON codiceStruttura IN (Ostello, Appartamento, Hotel)