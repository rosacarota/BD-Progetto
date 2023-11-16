USE ddl_progetto;

# Cliente
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('fdiversa@indiatimes.com','H4lQFP','Franni','Divers','1986-04-25',7358279843,'Spain',4,1);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('eletteresseb@woothemes.com','RJ4K11JJI0X','Essa','Letteresse','1995-05-31',3938316030,'Ukraine',41,2);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('pizhakovc@chronoengine.com','uVWdwhkXxo2','Pris','Izhakov','1989-08-30',7185172191,'Portugal',100,2);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('bmixerd@mail.ru','35nvB41CMRGc','Bill','Mixer','1991-02-24',8028441549,'Mauritius',0,1);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('gwhitese@networksolutions.com','6gTi26','Godfry','Whitehouse','1976-09-18',3559381029,'China',9,2);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('csimonelf@shinystat.com','Y3cwpG0MJa','Carlota','Simonel','2002-04-17',1394402174,'Slovenia',91,2);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('mdykag@edublogs.org','1GB6zy1Grvw','Mala','Dyka','1997-03-14',7693235314,'Ukraine',100,0);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('cmichinh@earthlink.net','oO5AwnSvSH','Chloris','Michin','2001-10-15',2718323707,'France',1,1);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('cwhelani@guardian.co.uk','9ijaL6qm','Callean','Whelan','1971-04-06',5574900010,'Portugal',75,2);
INSERT INTO Cliente(email,passwd,nome,cognome,datadinascita,numeroditelefono,nazionalita,numeroprenotazioni,numeroprenotazioniattive) VALUES ('ltarbinj@auda.org.au','bcKN2Y2','Lionello','Tarbin','1996-02-16',2204705677,'Greece',94,1);

# TesseraFedelta
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza) VALUES ('fdiversa@indiatimes.com','Standard','2022-03-27','2032-12-04');
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza) VALUES ('eletteresseb@woothemes.com','Standard','2022-07-29','2030-05-02');
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza) VALUES ('pizhakovc@chronoengine.com','Standard','2022-02-24','2031-10-20');
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza) VALUES ('bmixerd@mail.ru','Standard','2022-10-30','2031-11-14');
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza) VALUES ('gwhitese@networksolutions.com','Standard','2022-06-27','2031-04-28');
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza, scontoPremium) VALUES ('csimonelf@shinystat.com','Premium','2022-08-23','2031-06-04', 40);
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza, scontoPremium) VALUES ('mdykag@edublogs.org','Premium','2022-04-09','2031-02-12', 50);
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza, scontoPremium) VALUES ('cmichinh@earthlink.net','Premium','2022-02-16','2030-03-07', 30);
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza, scontoPremium) VALUES ('cwhelani@guardian.co.uk','Premium','2022-08-26','2031-12-17', 25);
INSERT INTO TesseraFedelta(cliente,tipo,dataemissione,datascadenza, scontoPremium) VALUES ('ltarbinj@auda.org.au','Premium','2022-09-07','2032-02-19', 15);

# AgenziaDiViaggio
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Porter''s Wormwood');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Bignonia');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Trematodon Moss');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Hong Kong Kumquat');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Parakmeria');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Chinese Windmill Palm');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Broom');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Mt. Hamilton Desertparsley');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Henry Indian Paintbrush');
INSERT INTO AgenziaDiViaggio(nome) VALUES ('Pride Of Ohio');

# SitoWebAgenzia
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('http://vk.com',1);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('http://parallels.com',2);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('http://unicef.org',3);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('http://ebay.co.uk',4);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('http://cubical.com',5);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('https://amazon.co.uk',6);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('https://scribd.com',7);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('http://sina.com.cn',8);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('https://1688.com',9);
INSERT INTO SitoWebAgenzia(indirizzo,agenzia) VALUES ('http://bravesites.com',10);

# StrutturaRicettiva
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2018,'Johns-Anderson','Belūsovka','0777 Roxbury Terrace',80347);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2020,'Cormier LLC','Leeuwarden','52 Stuart Road',68436);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2013,'Klein Inc','Polykárpi','92 Nobel Parkway',70582);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2019,'Weber, Steuber and Murazik','Sukumo','22 Annamark Alley',22645);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2015,'Gorczany Inc','Achiaman','2 Charing Cross Court',98391);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2013,'Grady-Bosco','Marihatag','790 Coolidge Court',35201);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2011,'Zemlak, Bednar and Wolf','Tall Abyaḑ','701 Mayer Center',58867);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2017,'Harber-O''Keefe','Eirol','0512 Evergreen Parkway',53046);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2017,'Bernier, Schiller and Feil','Limit','85 Northport Drive',97316);
INSERT INTO StrutturaRicettiva(annodiiscrizione,nome,citta,via,cap) VALUES (2014,'Fritsch-Stark','Arrepiado','748 Blaine Junction',77812);

# SitoWebStruttura
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('https://themeforest.net',1);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('http://cbsnews.com',2);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('http://cmu.edu',3);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('http://ocn.ne.jp',4);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('https://ebay.co.uk',5);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('https://zimbio.com',6);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('https://upenn.edu',7);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('http://toplist.cz',8);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('https://dyndns.org',9);
INSERT INTO SitoWebStruttura(indirizzo,strutturaricettiva) VALUES ('http://imageshack.us',10);

# NumeroDiTelefono
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('6912966259',1);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('8705126381',2);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('2719249920',3);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('6521565986',4);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('9829067720',5);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('7884916009',6);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('1911702580',7);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('7132203668',8);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('9282667523',9);
INSERT INTO NumeroDiTelefono(numero,strutturaricettiva) VALUES ('8731476650',10);

# ServizioOfferto
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Navetta aeroportuale',1,'Navetta che trasporta i clienti dall''areoporto alla struttura');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Vasca idromassaggio',2,'Vasca idromassaggio riscaldata utilizzata dai clienti della struttura');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('SPA',3,'SPA adibita al raggiungimento del benessere per il cliente');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Sala Giochi',4,'Sala giochi per i bambini dei clienti');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Bar 24H',5,'Bar aperto 24h per accogliere i clienti');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Piscina esterna',6,'Piscina esterna per permettere ai clienti di rinfrescarsi');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Piscina interna',7,'Piscina interna per permettere al cliente di rilassarsi anche d''inverno');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Tour',8,'Tour per visitare i punti di interesse vicini alla struttra');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Safari',9,'Safari organizzato dalla struttura per stare a contatto con la natura');
INSERT INTO ServizioOfferto(nomeservizio,strutturaricettiva,descrizioneservizio) VALUES ('Wi-Fi gratuito',10,'Wi-Fi libero solo per i clienti della struttura');

# PuntoDiInteresse
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Cupola di Brunelleschi','Monumento architettonico','Firenze','Piazza del Duomo',50122,'E'' in piazza Duomo a firenze, al centro della piazza');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Museo di Capodimonte','Museo','Napoli','Via Milano 2',80131,'Si trova in un grande giardino a Capodomonte');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Zoo di Berlino','Zoo','Berlino','Hardenbergpl 8',10787,'E'' tra le ultime fermate della metro, abbastanza lontano dal centro');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Roma Tiburtina','Fermata Treno','Roma','Via Tiburtina',00162,'Vicino a molti punti di interesse');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Museo dei pastori','Museo','Madrid','C. de Sta. Isabel 52',28012 ,'Situato vicino al museo del Prado e altri punti di interesse');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Tour Eiffel','Monumento','Parigi','Champ de Marse',75007,'Situato al centro di un enorme spazio verde');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Colosseo','Monumento','Roma','Piazza Colosseo 1',00184,'Situato vicino ad altri punti di interesse');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Aaeroporto Barcellona','Aeroporto','Barcellona','El Prat de Llobregat',08820,'Situato lontano dai punti di interesse ma raggiungibile tramite navetta');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Castello di Schönbrunn','Castello','Wien','Schönbrunner Schloßstraße 47',11300,'Unico punto di interesse nei dintorni');
INSERT INTO PuntoDiInteresse(nome,tipo,citta,via,cap,descrizioneposizione) VALUES ('Vang Gogh Museum','Museo','Amsterdam','Museumplein 6',10710,'Situato vicino stazioni raggiungibili facilmente');

# Distanza
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (1,1,20);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (2,2,23);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (3,3,13);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (4,4,0);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (5,5,52);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (6,6,80);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (7,7,47);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (8,8,67);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (9,9,44);
INSERT INTO Distanza(puntodiinteresse,strutturaricettiva,km) VALUES (10,10,87);

# Hotel
INSERT INTO Hotel(strutturaricettiva) VALUES (1);
INSERT INTO Hotel(strutturaricettiva) VALUES (2);
INSERT INTO Hotel(strutturaricettiva) VALUES (3);
INSERT INTO Hotel(strutturaricettiva) VALUES (4);
INSERT INTO Hotel(strutturaricettiva) VALUES (5);

# TipoStanza
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Standard',20.00,1,10,1);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Standard',30.00,2,10,2);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Standard',40.00,3,10,3);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Standard',50.00,4,10,4);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Standard',60.00,5,10,5);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Premium',50.00,1,10,1);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Premium',70.00,2,10,2);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Premium',90.00,3,10,3);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Deluxe',80.00,1,10,4);
INSERT INTO TipoStanza(tipologia,prezzonotte,postiletto,stanzepertipologia,hotel) VALUES ('Deluxe',100.00,2,10,5);

# Appartamento
INSERT INTO Appartamento(strutturaricettiva,prezzonotte,postiletto,metriquadri,vani) VALUES (6,40.00,2,21,3);
INSERT INTO Appartamento(strutturaricettiva,prezzonotte,postiletto,metriquadri,vani) VALUES (7,50.00,3,25,5);

# Ostello
INSERT INTO Ostello(strutturaricettiva,prezzonottepostoletto,postilettototali) VALUES (8,32.00,85);
INSERT INTO Ostello(strutturaricettiva,prezzonottepostoletto,postilettototali) VALUES (9,25.00,63);
INSERT INTO Ostello(strutturaricettiva,prezzonottepostoletto,postilettototali) VALUES (10,39.00,67);

# Prenotazione
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,stanzeprenotate,tipostanza) VALUES ('2022-10-20','2022-10-25',5,20.00,1,'eletteresseb@woothemes.com',1,1,1);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,stanzeprenotate,tipostanza) VALUES ('2022-11-01','2022-11-03',2,30.00,2,'fdiversa@indiatimes.com',2,1,2);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,stanzeprenotate,tipostanza) VALUES ('2022-10-16','2022-10-18',2,40.00,3,'pizhakovc@chronoengine.com',3,1,3);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,stanzeprenotate,tipostanza) VALUES ('2022-11-12','2022-11-18',6,50.00,4,'bmixerd@mail.ru',4,1,4);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,appartamento) VALUES ('2022-11-18','2022-11-20',2,40.00,2,'gwhitese@networksolutions.com',5,6);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,appartamento) VALUES ('2022-10-18','2022-10-25',7,50.00,3,'csimonelf@shinystat.com',6,7);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,ostello) VALUES ('2022-12-13','2022-12-14',1,32.00,8,'mdykag@edublogs.org',7,8);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,ostello) VALUES ('2022-12-18','2022-12-19',1,30.00,6,'cmichinh@earthlink.net',8,8);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,ostello) VALUES ('2022-12-20','2022-12-22',2,25.00,3,'cwhelani@guardian.co.uk',9,9);
INSERT INTO Prenotazione(datacheckin,datacheckout,duratasoggiorno,prezzototale,numeroospiti,cliente,agenziadiviaggio,ostello) VALUES ('2022-10-21','2022-10-29',8,29.00,5,'ltarbinj@auda.org.au',10,10);