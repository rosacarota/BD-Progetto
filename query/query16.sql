# Stampa di un report che mostri i dati delle prenotazioni che ancora non sono state
# effettuate ed il costo di ognuna di esse
SELECT Cliente, dataCheckIn, dataCheckOut, numeroOspiti, durataSoggiorno, prezzoTotale
FROM Prenotazione
WHERE CURRENT_DATE < dataCheckIn