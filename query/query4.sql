# Controllo che il Cliente sia nel database
SELECT email FROM Cliente
WHERE email = ?;

# Controllo se il Cliente è già premium
SELECT tipo
FROM TesseraFedelta WHERE Cliente = ?;

# Se non è premium imposto la sua tessera a premium
UPDATE TesseraFedelta SET tipo = ?, scontoPremium = ? WHERE Cliente = ?
