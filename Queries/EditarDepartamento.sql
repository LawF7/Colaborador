ALTER PROCEDURE EditarDepartamento
    @Id INT,
    @Nombre NVARCHAR(255),
    @Estatus INT
AS
BEGIN
    SET NOCOUNT ON;
	
	DECLARE @YaExiste int = 1;

	IF EXISTS (SELECT 1 FROM Departamento WHERE Nombre = @Nombre AND Estatus = @Estatus and Id != @Id)
    BEGIN
        SET @YaExiste = 0; 
    END
	ELSE
		BEGIN
		IF EXISTS (SELECT 1 FROM Departamento WHERE Id = @Id)
		BEGIN
			UPDATE Departamento
			SET 
				Nombre = @Nombre,
				Estatus = @Estatus
			WHERE Id = @Id;
		END
	END
	SELECT @YaExiste
END
GO
