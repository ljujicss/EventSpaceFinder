
USE EventSpaceFinder;
GO

CREATE TABLE Korisnik
(
    id_korisnika INT IDENTITY(1,1) PRIMARY KEY,
    ime NVARCHAR(50) NOT NULL,
    prezime NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    lozinka NVARCHAR(255) NOT NULL,
    telefon NVARCHAR(30),
    uloga NVARCHAR(20) NOT NULL,
    datum_registracije DATETIME NOT NULL DEFAULT GETDATE(),
    aktivan BIT NOT NULL DEFAULT 1,

    CHECK (uloga IN ('Admin', 'Korisnik'))
);
GO

CREATE TABLE Grad
(
    id_grada INT IDENTITY(1,1) PRIMARY KEY,
    naziv_grada NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Prostor
(
    id_prostora INT IDENTITY(1,1) PRIMARY KEY,
    id_grada INT NOT NULL,
    naziv NVARCHAR(100) NOT NULL,
    opis NVARCHAR(1000),
    adresa NVARCHAR(200) NOT NULL,
    kapacitet INT NOT NULL,
    osnovna_cijena DECIMAL(10,2) NOT NULL,
    tip_prostora NVARCHAR(50),
    aktivan BIT NOT NULL DEFAULT 1,

    FOREIGN KEY (id_grada) REFERENCES Grad(id_grada),

    CHECK (kapacitet > 0),
    CHECK (osnovna_cijena >= 0)
);
GO

CREATE TABLE TipDogadjaja
(
    id_tipa_dogadjaja INT IDENTITY(1,1) PRIMARY KEY,
    naziv_tipa NVARCHAR(100) NOT NULL UNIQUE,
    opis NVARCHAR(500)
);
GO

CREATE TABLE ProstorTipDogadjaja
(
    id_prostora INT NOT NULL,
    id_tipa_dogadjaja INT NOT NULL,

    PRIMARY KEY (id_prostora, id_tipa_dogadjaja),

    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora),
    FOREIGN KEY (id_tipa_dogadjaja) REFERENCES TipDogadjaja(id_tipa_dogadjaja)
);
GO

CREATE TABLE Usluga
(
    id_usluge INT IDENTITY(1,1) PRIMARY KEY,
    naziv_usluge NVARCHAR(100) NOT NULL UNIQUE,
    opis NVARCHAR(500)
);
GO

CREATE TABLE ProstorUsluga
(
    id_prostora INT NOT NULL,
    id_usluge INT NOT NULL,

    PRIMARY KEY (id_prostora, id_usluge),

    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora),
    FOREIGN KEY (id_usluge) REFERENCES Usluga(id_usluge)
);
GO

CREATE TABLE Paket
(
    id_paketa INT IDENTITY(1,1) PRIMARY KEY,
    id_prostora INT NOT NULL,
    naziv_paketa NVARCHAR(100) NOT NULL,
    opis NVARCHAR(1000),
    cijena DECIMAL(10,2) NOT NULL,
    broj_sati INT NOT NULL,
    aktivan BIT NOT NULL DEFAULT 1,

    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora),

    CHECK (cijena >= 0),
    CHECK (broj_sati > 0)
);
GO

CREATE TABLE PaketUsluga
(
    id_paketa INT NOT NULL,
    id_usluge INT NOT NULL,

    PRIMARY KEY (id_paketa, id_usluge),

    FOREIGN KEY (id_paketa) REFERENCES Paket(id_paketa),
    FOREIGN KEY (id_usluge) REFERENCES Usluga(id_usluge)
);
GO

CREATE TABLE StatusRezervacije
(
    id_statusa INT IDENTITY(1,1) PRIMARY KEY,
    naziv_statusa NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Rezervacija
(
    id_rezervacije INT IDENTITY(1,1) PRIMARY KEY,
    id_korisnika INT NOT NULL,
    id_prostora INT NOT NULL,
    id_paketa INT NOT NULL,
    id_statusa INT NOT NULL,
    datum_rezervacije DATETIME NOT NULL DEFAULT GETDATE(),
    datum_dogadjaja DATE NOT NULL,
    broj_gostiju INT NOT NULL,
    ukupna_cijena DECIMAL(10,2) NOT NULL,
    napomena NVARCHAR(1000),

    FOREIGN KEY (id_korisnika) REFERENCES Korisnik(id_korisnika),
    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora),
    FOREIGN KEY (id_paketa) REFERENCES Paket(id_paketa),
    FOREIGN KEY (id_statusa) REFERENCES StatusRezervacije(id_statusa),

    CHECK (broj_gostiju > 0),
    CHECK (ukupna_cijena >= 0)
);
GO

CREATE TABLE KalendarZauzetosti
(
    id_kalendara INT IDENTITY(1,1) PRIMARY KEY,
    id_prostora INT NOT NULL,
    id_rezervacije INT NULL,
    datum DATE NOT NULL,
    status_datuma NVARCHAR(30) NOT NULL,
    napomena NVARCHAR(500),

    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora),
    FOREIGN KEY (id_rezervacije) REFERENCES Rezervacija(id_rezervacije),

    CHECK (status_datuma IN ('Slobodno', 'Na cekanju', 'Zauzeto'))
);
GO

CREATE TABLE Ocjena
(
    id_ocjene INT IDENTITY(1,1) PRIMARY KEY,
    id_korisnika INT NOT NULL,
    id_prostora INT NOT NULL,
    ocjena INT NOT NULL,
    datum_ocjene DATETIME NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (id_korisnika) REFERENCES Korisnik(id_korisnika),
    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora),

    CHECK (ocjena BETWEEN 1 AND 5),

    UNIQUE (id_korisnika, id_prostora)
);
GO

CREATE TABLE Komentar
(
    id_komentara INT IDENTITY(1,1) PRIMARY KEY,
    id_korisnika INT NOT NULL,
    id_prostora INT NOT NULL,
    tekst_komentara NVARCHAR(1000) NOT NULL,
    datum_komentara DATETIME NOT NULL DEFAULT GETDATE(),
    odobren BIT NOT NULL DEFAULT 0,

    FOREIGN KEY (id_korisnika) REFERENCES Korisnik(id_korisnika),
    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora)
);
GO

CREATE TABLE SlikaProstora
(
    id_slike INT IDENTITY(1,1) PRIMARY KEY,
    id_prostora INT NOT NULL,
    putanja_slike NVARCHAR(300) NOT NULL,
    opis NVARCHAR(300),
    glavna_slika BIT NOT NULL DEFAULT 0,

    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora)
);
GO

CREATE TABLE OmiljeniProstor
(
    id_korisnika INT NOT NULL,
    id_prostora INT NOT NULL,
    datum_dodavanja DATETIME NOT NULL DEFAULT GETDATE(),

    PRIMARY KEY (id_korisnika, id_prostora),

    FOREIGN KEY (id_korisnika) REFERENCES Korisnik(id_korisnika),
    FOREIGN KEY (id_prostora) REFERENCES Prostor(id_prostora)
);
GO

