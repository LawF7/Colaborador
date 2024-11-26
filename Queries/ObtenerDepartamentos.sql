CREATE PROCEDURE ObtenerDepartamentos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.Id,
        d.Nombre,
        CASE 
            WHEN d.Estatus = 0 THEN 'Inactivo' 
            WHEN d.Estatus = 1 THEN 'Activo' 
        END AS Estatus,
        d.FechaCreacion
    FROM Departamento d;
END
GO
