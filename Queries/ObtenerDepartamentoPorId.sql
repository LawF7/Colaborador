CREATE PROCEDURE ObtenerDepartamentoPorId
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.Id,
        d.Nombre,
        d.Estatus,
        d.FechaCreacion
    FROM Departamento d
    WHERE d.Id = @Id;
END
GO
