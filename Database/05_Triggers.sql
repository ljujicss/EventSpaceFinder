USE EventSpaceFinder;
GO

CREATE OR ALTER TRIGGER trg_AfterInsertRezervacija
ON Rezervacija
AFTER INSERT
AS
BEGIN
    DECLARE @id_rezervacije INT;
    DECLARE @id_prostora INT;
    DECLARE @datum_dogadjaja DATE;

    DECLARE kursor CURSOR FOR
    SELECT id_rezervacije, id_prostora, datum_dogadjaja
    FROM inserted;

    OPEN kursor;

    FETCH NEXT FROM kursor INTO @id_rezervacije, @id_prostora, @datum_dogadjaja;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO KalendarZauzetosti
        (
            id_prostora,
            id_rezervacije,
            datum,
            status_datuma,
            napomena
        )
        VALUES
        (
            @id_prostora,
            @id_rezervacije,
            @datum_dogadjaja,
            'Na cekanju',
            'Rezervacija je dodata i ceka potvrdu admina.'
        );

        FETCH NEXT FROM kursor INTO @id_rezervacije, @id_prostora, @datum_dogadjaja;
    END

    CLOSE kursor;
    DEALLOCATE kursor;
END;
GO

CREATE OR ALTER TRIGGER trg_UpdateStatusRezervacije
ON Rezervacija
AFTER UPDATE
AS
BEGIN
    DECLARE @id_rezervacije INT;
    DECLARE @id_statusa INT;
    DECLARE @naziv_statusa NVARCHAR(50);

    DECLARE kursor CURSOR FOR
    SELECT id_rezervacije, id_statusa
    FROM inserted;

    OPEN kursor;

    FETCH NEXT FROM kursor INTO @id_rezervacije, @id_statusa;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @naziv_statusa = naziv_statusa
        FROM StatusRezervacije
        WHERE id_statusa = @id_statusa;

        IF @naziv_statusa = 'Prihvacena'
        BEGIN
            UPDATE KalendarZauzetosti
            SET status_datuma = 'Zauzeto',
                napomena = 'Rezervacija je prihvacena.'
            WHERE id_rezervacije = @id_rezervacije;
        END

        IF @naziv_statusa = 'Na cekanju'
        BEGIN
            UPDATE KalendarZauzetosti
            SET status_datuma = 'Na cekanju',
                napomena = 'Rezervacija ceka potvrdu admina.'
            WHERE id_rezervacije = @id_rezervacije;
        END

        IF @naziv_statusa = 'Odbijena' OR @naziv_statusa = 'Otkazana'
        BEGIN
            UPDATE KalendarZauzetosti
            SET status_datuma = 'Slobodno',
                napomena = 'Termin je oslobodjen.'
            WHERE id_rezervacije = @id_rezervacije;
        END

        IF @naziv_statusa = 'Zavrsena'
        BEGIN
            UPDATE KalendarZauzetosti
            SET status_datuma = 'Zauzeto',
                napomena = 'Dogadjaj je zavrsen.'
            WHERE id_rezervacije = @id_rezervacije;
        END

        FETCH NEXT FROM kursor INTO @id_rezervacije, @id_statusa;
    END

    CLOSE kursor;
    DEALLOCATE kursor;
END;
GO

UPDATE Rezervacija
SET id_statusa = 2
WHERE id_rezervacije = 1;


GO