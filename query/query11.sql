# Visualizzazione delle strutture ricettive che hanno una distanza di 10km specifica da un punto di interesse
SELECT PDI.nome AS PuntoDiInteresse, km AS DistanzaInKm, codiceStruttura, annoDiIscrizione, SR.nome, SR.citta,
       SR.via, SR.cap
FROM StrutturaRicettiva AS SR
JOIN Distanza D ON SR.codiceStruttura = D.StrutturaRicettiva
JOIN PuntoDiInteresse PDI ON D.PuntoDiInteresse = PDI.codicePuntoDiInteresse
WHERE PDI.nome LIKE ? AND km <= 10