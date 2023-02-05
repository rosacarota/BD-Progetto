# Visualizzazione del numero di prenotazioni effettuate da tutti i clienti nell'ultimo mese
SELECT Cliente, COUNT(Cliente) AS TotaliPrenotazioni
FROM Prenotazione
WHERE dataCheckIn BETWEEN (DATE_SUB(CURDATE(), INTERVAL 30 DAY)) AND CURDATE()
GROUP BY Cliente