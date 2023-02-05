SELECT COUNT(numeroPrenotazioni) as PrenotazioniTotali, email, nome, cognome,
       dataDiNascita, numeroDiTelefono, nazionalita
 FROM Cliente
 JOIN TesseraFedelta TF on Cliente.email = TF.Cliente
 JOIN Prenotazione P on Cliente.email = P.Cliente
 WHERE tipo = 'Premium'
 GROUP BY email
 ORDER BY PrenotazioniTotali DESC
 LIMIT 10