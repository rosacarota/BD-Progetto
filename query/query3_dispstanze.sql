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
AND Hotel = ?