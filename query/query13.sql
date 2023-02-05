# Stampa dei dati dei clienti che hanno prenotato solo appartamenti e ostelli
SELECT email, nome, cognome, dataDiNascita, numeroDiTelefono, nazionalita,
       numeroPrenotazioni, numeroPrenotazioniAttive
FROM Cliente
JOIN Prenotazione ON Cliente.email = Prenotazione.Cliente
WHERE TipoStanza IS NULL