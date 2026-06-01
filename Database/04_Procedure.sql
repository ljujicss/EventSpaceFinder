USE EventSpaceFinder;
GO

CREATE OR ALTER PROCEDURE sp_DodajRezervaciju
    @id_korisnika INT,
    @id_prostora INT,
    @id_paketa INT,
    @datum_dogadjaja DATE,
    @broj_gostiju INT,
    @napomena NVARCHAR(1000)
AS
BEGIN
    DECLARE @kapacitet INT;
    DECLARE @cijena DECIMAL(10,2);
    DECLARE @id_statusa INT;
    DECLARE @slobodan BIT;

    SELECT @kapacitet = kapacitet
    FROM Prostor
    WHERE id_prostora = @id_prostora
    AND aktivan = 1;

    IF @kapacitet IS NULL
    BEGIN
        PRINT 'Prostor ne postoji ili nije aktivan.';
        RETURN;
    END

    IF @broj_gostiju > @kapacitet
    BEGIN
        PRINT 'Broj gostiju je veci od kapaciteta prostora.';
        RETURN;
    END

    SELECT @cijena = cijena
    FROM Paket
    WHERE id_paketa = @id_paketa
    AND id_prostora = @id_prostora
    AND aktivan = 1;

    IF @cijena IS NULL
    BEGIN
        PRINT 'Paket ne postoji ili ne pripada izabranom prostoru.';
        RETURN;
    END

    SELECT @id_statusa = id_statusa
    FROM StatusRezervacije
    WHERE naziv_statusa = 'Na cekanju';

    IF @id_statusa IS NULL
    BEGIN
        PRINT 'Status Na cekanju ne postoji.';
        RETURN;
    END

    SET @slobodan = dbo.fn_ProstorSlobodan(@id_prostora, @datum_dogadjaja);

    IF @slobodan = 0
    BEGIN
        PRINT 'Prostor nije slobodan za izabrani datum.';
        RETURN;
    END

    INSERT INTO Rezervacija
    (
        id_korisnika,
        id_prostora,
        id_paketa,
        id_statusa,
        datum_dogadjaja,
        broj_gostiju,
        ukupna_cijena,
        napomena
    )
    VALUES
    (
        @id_korisnika,
        @id_prostora,
        @id_paketa,
        @id_statusa,
        @datum_dogadjaja,
        @broj_gostiju,
        @cijena,
        @napomena
    );

    PRINT 'Rezervacija je uspjesno dodata.';
END;
GO

CREATE PROCEDURE sp_PreporuciNajboljiProstor
    @id_grada INT,
    @id_tipa_dogadjaja INT,
    @broj_gostiju INT,
    @budzet DECIMAL(10,2),
    @datum_dogadjaja DATE
AS
BEGIN
    SELECT TOP 10
        p.id_prostora,
        p.naziv,
        g.naziv_grada,
        p.adresa,
        p.kapacitet,
        p.tip_prostora,
        pk.id_paketa,
        pk.naziv_paketa,
        pk.cijena,
        dbo.fn_CijenaPoGostu(pk.id_paketa, @broj_gostiju) AS cijena_po_gostu,
        (
            CASE WHEN p.id_grada = @id_grada THEN 30 ELSE 0 END +
            CASE WHEN p.kapacitet >= @broj_gostiju THEN 25 ELSE 0 END +
            CASE WHEN pk.cijena <= @budzet THEN 20 ELSE 0 END +
            CASE WHEN dbo.fn_ProstorSlobodan(p.id_prostora, @datum_dogadjaja) = 1 THEN 15 ELSE 0 END +
            CASE WHEN EXISTS
            (
                SELECT *
                FROM ProstorTipDogadjaja ptd
                WHERE ptd.id_prostora = p.id_prostora
                AND ptd.id_tipa_dogadjaja = @id_tipa_dogadjaja
            )
            THEN 10 ELSE 0 END
        ) AS broj_bodova
    FROM Prostor p, Grad g, Paket pk
    WHERE p.id_grada = g.id_grada
    AND p.id_prostora = pk.id_prostora
    AND p.aktivan = 1
    AND pk.aktivan = 1
    AND p.id_grada = @id_grada
    AND p.kapacitet >= @broj_gostiju
    AND pk.cijena <= @budzet
    AND dbo.fn_ProstorSlobodan(p.id_prostora, @datum_dogadjaja) = 1
    AND EXISTS
    (
        SELECT *
        FROM ProstorTipDogadjaja ptd
        WHERE ptd.id_prostora = p.id_prostora
        AND ptd.id_tipa_dogadjaja = @id_tipa_dogadjaja
    )
    ORDER BY broj_bodova DESC, pk.cijena ASC;
END;
GO

EXEC sp_DodajRezervaciju
    @id_korisnika = 2,
    @id_prostora = 1,
    @id_paketa = 1,
    @datum_dogadjaja = '2026-12-20',
    @broj_gostiju = 40,
    @napomena = 'Test rezervacija.';

EXEC sp_PreporuciNajboljiProstor
    @id_grada = 1,
    @id_tipa_dogadjaja = 1,
    @broj_gostiju = 100,
    @budzet = 5000,
    @datum_dogadjaja = '2026-12-25';
GO