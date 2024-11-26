CREATE PROCEDURE EditarColaborador
    @Id INT,
    @DepartamentoId INT,
    @DPI NVARCHAR(50),
    @NombreCompleto NVARCHAR(255),
    @Telefono NVARCHAR(20),
    @CorreoElectronico NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @NuevoId INT = 1;

	IF EXISTS (SELECT 1 FROM Colaborador WHERE DPI = @DPI AND Id != @Id)
    BEGIN
        SET @NuevoId = 0; 
    END
	ELSE
	BEGIN
		IF EXISTS (SELECT 1 FROM Colaborador WHERE Id = @Id)
		BEGIN
			UPDATE Colaborador
			SET 
				DepartamentoId = @DepartamentoId,
				DPI = @DPI,
				NombreCompleto = @NombreCompleto,
				Telefono = @Telefono,
				CorreoElectronico = @CorreoElectronico
			WHERE Id = @Id;

		END
	END

	SELECT @NuevoId
END
GO
