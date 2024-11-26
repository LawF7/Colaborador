CREATE PROCEDURE BuscarColaboradores
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.Id,
        p.Nombre AS Departamento,
        d.NombreCompleto,
        d.FechaCreacion,
        d.DPI
    FROM Colaborador d
    INNER JOIN Departamento p ON p.Id = d.DepartamentoId
    ORDER BY d.DepartamentoId;
END
GO
