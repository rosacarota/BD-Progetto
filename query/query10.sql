# Visualizzazione degli ostelli per i quali non è stata mai registrata una prenotazione di più di 7 giorni
SELECT DISTINCT codiceStruttura, annoDiIscrizione, nome, citta, via, cap
FROM Prenotazione, Ostello
JOIN StrutturaRicettiva ON Ostello.StrutturaRicettiva = StrutturaRicettiva.codiceStruttura
WHERE durataSoggiorno < 7
AND Prenotazione.Ostello = Ostello.StrutturaRicettiva