CREATE PROCEDURE BorrarDepartamento
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si el departamento existe
    IF EXISTS (SELECT 1 FROM Departamento WHERE Id = @Id)
    BEGIN
        -- Eliminar el departamento
        DELETE FROM Departamento
        WHERE Id = @Id;
    END
END
GO
