CREATE PROCEDURE CrearColaborador
    @DepartamentoId INT,
    @DPI NVARCHAR(50),
    @NombreCompleto NVARCHAR(255),
    @Telefono NVARCHAR(20),
    @CorreoElectronico NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @NuevoId INT;

    IF EXISTS (SELECT 1 FROM Colaborador WHERE DPI = @DPI)
    BEGIN
        SET @NuevoId = 0; 
    END
	ELSE
	BEGIN

    INSERT INTO Colaborador (DepartamentoId, DPI, NombreCompleto, Telefono, CorreoElectronico)
    VALUES (@DepartamentoId, @DPI, @NombreCompleto, @Telefono, @CorreoElectronico);

    SET @NuevoId = SCOPE_IDENTITY();
	END

	SELECT @NuevoId;
END
GO
