CREATE PROCEDURE BorrarColaborador
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Colaborador WHERE Id = @Id)
    BEGIN
        DELETE FROM Colaborador WHERE Id = @Id;
    END

END
GO
