USE EventSpaceFinder;
GO
 
CREATE OR ALTER FUNCTION fn_ProstorSlobodan
(
    @id_prostora INT,
    @datum DATE
)
RETURNS BIT
AS
BEGIN
    DECLARE @slobodan BIT;
    DECLARE @status_datuma NVARCHAR(30);
 
    SET @slobodan = 1;
 
    DECLARE kursor CURSOR FOR
    SELECT status_datuma
    FROM KalendarZauzetosti
    WHERE id_prostora = @id_prostora
    AND datum = @datum;
 
    OPEN kursor;
 
    FETCH NEXT FROM kursor INTO @status_datuma;
 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @status_datuma = 'Na cekanju' OR @status_datuma = 'Zauzeto'
        BEGIN
		            SET @slobodan = 0;
        END
 
        FETCH NEXT FROM kursor INTO @status_datuma;
    END
 
    CLOSE kursor;
    DEALLOCATE kursor;
 
    RETURN @slobodan;
END;
GO
 
CREATE OR ALTER FUNCTION fn_CijenaPoGostu
(
    @id_paketa INT,
    @broj_gostiju INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @cijena DECIMAL(10,2);
    DECLARE @cijena_po_gostu DECIMAL(10,2);
 
    SET @cijena_po_gostu = 0;
 
    IF @broj_gostiju <= 0
    BEGIN
        RETURN 0;
    END
 
    SELECT @cijena = cijena
    FROM Paket
    WHERE id_paketa = @id_paketa;
 
    IF @cijena IS NULL
    BEGIN
        RETURN 0;
    END
 
    SET @cijena_po_gostu = @cijena / @broj_gostiju;
 
    RETURN @cijena_po_gostu;
END;
GO
 
SELECT dbo.fn_ProstorSlobodan(1, '2026-12-20') AS ProstorSlobodan;
SELECT dbo.fn_CijenaPoGostu(2, 50) AS CijenaPoGostu;
GO

