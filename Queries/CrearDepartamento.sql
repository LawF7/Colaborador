ALTER PROCEDURE CrearDepartamento
    @Nombre NVARCHAR(255),
    @Estatus INT
AS
BEGIN
    SET NOCOUNT ON;
	 DECLARE @NuevoId INT;

    IF EXISTS (SELECT 1 FROM Departamento WHERE Nombre = @Nombre AND Estatus = @Estatus)
    BEGIN
        SET @NuevoId = 0; 
    END
	ELSE
	BEGIN
		INSERT INTO Departamento (Nombre, Estatus)
		VALUES (@Nombre, @Estatus);

		SET @NuevoId = SCOPE_IDENTITY();
	END
	SELECT @NuevoId
END
GO
