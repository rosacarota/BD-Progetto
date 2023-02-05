SELECT numeroPrenotazioni as PrenotazioniTotali, email, passwd, nome, cognome,
       dataDiNascita, numeroDiTelefono, nazionalita
 FROM Cliente
 JOIN TesseraFedelta TF on Cliente.email = TF.Cliente
 WHERE tipo = 'Premium'
 ORDER BY PrenotazioniTotali DESC
 LIMIT 10