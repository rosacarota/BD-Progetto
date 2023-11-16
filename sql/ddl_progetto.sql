CREATE SCHEMA ddl_progetto;

USE ddl_progetto;

CREATE TABLE Cliente (
    email VARCHAR(30) PRIMARY KEY,
    passwd VARCHAR(30) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    cognome VARCHAR(30) NOT NULL,
    dataDiNascita DATE NOT NULL,
    numeroDiTelefono CHAR(13) NOT NULL,
    nazionalita VARCHAR(20) NOT NULL,
    numeroPrenotazioni INT DEFAULT 0 NOT NULL,
    numeroPrenotazioniAttive INT DEFAULT 0 NOT NULL,

    CHECK (numeroPrenotazioniAttive BETWEEN 0 AND 2)
);

CREATE TABLE TesseraFedelta (
    codiceTessera INT AUTO_INCREMENT,
    Cliente VARCHAR(30),
    tipo VARCHAR(20) NOT NULL,
    dataEmissione DATE NOT NULL,
    dataScadenza DATE NOT NULL,
    scontoPremium INT,

    PRIMARY KEY(codiceTessera, Cliente),
    FOREIGN KEY(Cliente) REFERENCES Cliente(email)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CHECK (scontoPremium BETWEEN 0 AND 100),
    CHECK (dataEmissione < dataScadenza)
);

CREATE TABLE AgenziaDiViaggio (
    codiceAgenzia INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL
);

CREATE TABLE SitoWebAgenzia (
    indirizzo VARCHAR(100) PRIMARY KEY,
    Agenzia INT NOT NULL,

    FOREIGN KEY(Agenzia) REFERENCES AgenziaDiViaggio(codiceAgenzia)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE StrutturaRicettiva (
    codiceStruttura INT AUTO_INCREMENT PRIMARY KEY,
    annoDiIscrizione YEAR NOT NULL,
    nome VARCHAR(30) NOT NULL,
    citta VARCHAR(30) NOT NULL,
    via VARCHAR(30) NOT NULL,
    cap VARCHAR(10) NOT NULL
);

CREATE TABLE SitoWebStruttura (
    indirizzo VARCHAR(100) PRIMARY KEY,
    StrutturaRicettiva INT NOT NULL,

    FOREIGN KEY(StrutturaRicettiva) REFERENCES StrutturaRicettiva(codiceStruttura)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE NumeroDiTelefono (
    numero CHAR(13) PRIMARY KEY,
    StrutturaRicettiva INT NOT NULL,

    FOREIGN KEY(StrutturaRicettiva) REFERENCES StrutturaRicettiva(codiceStruttura)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ServizioOfferto (
    nomeServizio VARCHAR(30),
    StrutturaRicettiva INT,
    descrizioneServizio VARCHAR(140) NOT NULL,

    PRIMARY KEY(nomeServizio, StrutturaRicettiva),
    FOREIGN KEY(StrutturaRicettiva) REFERENCES StrutturaRicettiva(codiceStruttura)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PuntoDiInteresse (
    codicePuntoDiInteresse INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    citta VARCHAR(30) NOT NULL,
    via VARCHAR(30) NOT NULL,
    cap VARCHAR(10) NOT NULL,
    descrizionePosizione VARCHAR(140) NOT NULL
);

CREATE TABLE Distanza (
    PuntoDiInteresse INT,
    StrutturaRicettiva INT,
    km INT NOT NULL,

    PRIMARY KEY(PuntoDiInteresse, StrutturaRicettiva),
    FOREIGN KEY(PuntoDiInteresse) REFERENCES PuntoDiInteresse(codicePuntoDiInteresse)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(StrutturaRicettiva) REFERENCES StrutturaRicettiva(codiceStruttura)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CHECK (km BETWEEN 0 AND 100)
);

CREATE TABLE Hotel (
    StrutturaRicettiva INT PRIMARY KEY,

    FOREIGN KEY(StrutturaRicettiva) REFERENCES StrutturaRicettiva(codiceStruttura)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TipoStanza (
    codiceTipologia INT AUTO_INCREMENT PRIMARY KEY,
    tipologia VARCHAR(30) NOT NULL,
    prezzoNotte FLOAT NOT NULL,
    postiLetto INT NOT NULL,
    stanzePerTipologia INT NOT NULL,
    Hotel INT NOT NULL,

    FOREIGN KEY(Hotel) REFERENCES Hotel(StrutturaRicettiva)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Appartamento (
    StrutturaRicettiva INT PRIMARY KEY,
    prezzoNotte FLOAT NOT NULL,
    postiLetto INT NOT NULL,
    metriQuadri INT NOT NULL,
    vani INT NOT NULL,

    FOREIGN KEY(StrutturaRicettiva) REFERENCES StrutturaRicettiva(codiceStruttura)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Ostello (
    StrutturaRicettiva INT PRIMARY KEY,
    prezzoNottePostoLetto FLOAT NOT NULL,
    postiLettoTotali INT NOT NULL,

    FOREIGN KEY(StrutturaRicettiva) REFERENCES StrutturaRicettiva(codiceStruttura)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Prenotazione (
    codicePrenotazione INT AUTO_INCREMENT PRIMARY KEY,
    dataCheckIn DATE NOT NULL,
    dataCheckOut DATE NOT NULL,
    durataSoggiorno INT NOT NULL,
    prezzoTotale FLOAT NOT NULL,
    numeroOspiti INT NOT NULL,
    Cliente VARCHAR(30),
    notaCliente VARCHAR(140),
    AgenziaDiViaggio INT NOT NULL,
    StanzePrenotate INT,
    TipoStanza INT,
    Ostello INT,
    Appartamento INT,

    FOREIGN KEY(Cliente) REFERENCES Cliente(email)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY(AgenziaDiViaggio) REFERENCES AgenziaDiViaggio(codiceAgenzia)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY(TipoStanza) REFERENCES TipoStanza(codiceTipologia)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY(Ostello) REFERENCES Ostello(StrutturaRicettiva)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY(Appartamento) REFERENCES Appartamento(StrutturaRicettiva)
        ON UPDATE CASCADE ON DELETE NO ACTION,

    CHECK (dataCheckIn < dataCheckOut)
)