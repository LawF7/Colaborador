CREATE PROCEDURE ObtenerColaboradorPorId
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.Id,
        p.Nombre AS Departamento,
        d.DPI,
        d.NombreCompleto,
        d.Telefono,
        d.CorreoElectronico,
        d.FechaCreacion,
        d.DepartamentoId
    FROM Colaborador d
    INNER JOIN Departamento p ON p.Id = d.DepartamentoId
    WHERE d.Id = @Id;
END
GO
