# Stampa di un report che mostri i dati delle agenzie di viaggio compreso il numero
# totale di prenotazioni effettuate
SELECT COUNT(AgenziaDiViaggio) AS PrenotazioniTotali, codiceAgenzia, nome
FROM Prenotazione
RIGHT JOIN AgenziaDiViaggio ON Prenotazione.AgenziaDiViaggio = AgenziaDiViaggio.codiceAgenzia
GROUP BY codiceAgenzia