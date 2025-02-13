--Andreé
USE [master]
GO
/****** Object:  Database [Colaboradores]    Script Date: 27/11/2024 11:17:56 ******/
CREATE DATABASE [Colaboradores]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Colaboradores', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Colaboradores.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Colaboradores_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Colaboradores_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Colaboradores] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Colaboradores].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Colaboradores] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Colaboradores] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Colaboradores] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Colaboradores] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Colaboradores] SET ARITHABORT OFF 
GO
ALTER DATABASE [Colaboradores] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Colaboradores] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Colaboradores] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Colaboradores] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Colaboradores] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Colaboradores] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Colaboradores] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Colaboradores] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Colaboradores] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Colaboradores] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Colaboradores] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Colaboradores] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Colaboradores] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Colaboradores] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Colaboradores] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Colaboradores] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Colaboradores] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Colaboradores] SET RECOVERY FULL 
GO
ALTER DATABASE [Colaboradores] SET  MULTI_USER 
GO
ALTER DATABASE [Colaboradores] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Colaboradores] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Colaboradores] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Colaboradores] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Colaboradores] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Colaboradores] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Colaboradores', N'ON'
GO
ALTER DATABASE [Colaboradores] SET QUERY_STORE = ON
GO
ALTER DATABASE [Colaboradores] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Colaboradores]
GO
/****** Object:  User [andreefalla]    Script Date: 27/11/2024 11:17:57 ******/
CREATE USER [andreefalla] FOR LOGIN [andreefalla] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Colaborador]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colaborador](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartamentoId] [int] NOT NULL,
	[Departamento] [nvarchar](255) NULL,
	[DPI] [char](13) NOT NULL,
	[NombreCompleto] [nvarchar](255) NOT NULL,
	[Telefono] [nvarchar](15) NOT NULL,
	[CorreoElectronico] [nvarchar](255) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](256) NOT NULL,
	[Estatus] [int] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Estatus] [int] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Colaborador] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Departamento] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Colaborador]  WITH CHECK ADD  CONSTRAINT [FK_Colaborador_Departamento] FOREIGN KEY([DepartamentoId])
REFERENCES [dbo].[Departamento] ([Id])
GO
ALTER TABLE [dbo].[Colaborador] CHECK CONSTRAINT [FK_Colaborador_Departamento]
GO
ALTER TABLE [dbo].[Colaborador]  WITH CHECK ADD CHECK  (([CorreoElectronico] like '%@%.%'))
GO
ALTER TABLE [dbo].[Colaborador]  WITH CHECK ADD CHECK  ((NOT [NombreCompleto] like '%[^a-zA-Z ]%'))
GO
ALTER TABLE [dbo].[Colaborador]  WITH CHECK ADD CHECK  (([Telefono] like '[0-9]%'))
GO
ALTER TABLE [dbo].[Colaborador]  WITH CHECK ADD CHECK  (([DPI] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Departamento]  WITH CHECK ADD  CONSTRAINT [CH_NombreDepartamento] CHECK  ((NOT [Nombre] like '%[^a-zA-Z ]%'))
GO
ALTER TABLE [dbo].[Departamento] CHECK CONSTRAINT [CH_NombreDepartamento]
GO
ALTER TABLE [dbo].[Pais]  WITH CHECK ADD  CONSTRAINT [CH_Nombre] CHECK  (([Nombre] like '%[^0-9]%'))
GO
ALTER TABLE [dbo].[Pais] CHECK CONSTRAINT [CH_Nombre]
GO
/****** Object:  StoredProcedure [dbo].[BorrarColaborador]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BorrarColaborador]
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
/****** Object:  StoredProcedure [dbo].[BorrarDepartamento]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BorrarDepartamento]
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
/****** Object:  StoredProcedure [dbo].[BuscarColaboradores]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarColaboradores]
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
/****** Object:  StoredProcedure [dbo].[CrearColaborador]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearColaborador]
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
/****** Object:  StoredProcedure [dbo].[CrearDepartamento]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearDepartamento]
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
/****** Object:  StoredProcedure [dbo].[EditarColaborador]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditarColaborador]
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
/****** Object:  StoredProcedure [dbo].[EditarDepartamento]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditarDepartamento]
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
/****** Object:  StoredProcedure [dbo].[InsertarDepartamento]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertarDepartamento]
    @Nombre NVARCHAR(100), -- Nombre del departamento
    @Estatus INT -- Estatus del departamento (0 = Inactivo, 1 = Activo)
AS
BEGIN
    BEGIN TRY
        -- Validación: Verificar que el nombre no esté vacío
        IF LTRIM(RTRIM(@Nombre)) = ''
        BEGIN
            THROW 50000, 'El campo Nombre no puede estar vacío.', 1;
        END

        -- Validación: Verificar que el estatus sea válido (0 o 1)
        IF @Estatus NOT IN (0, 1)
        BEGIN
            THROW 50001, 'El campo Estatus debe ser 0 (Inactivo) o 1 (Activo).', 1;
        END

        -- Insertar el registro en la tabla Departamento
        INSERT INTO Departamento (Nombre, Estatus, FechaCreacion)
        VALUES (@Nombre, @Estatus, GETDATE());
		select SCOPE_IDENTITY();
        PRINT 'El departamento se insertó correctamente.';
    END TRY
    BEGIN CATCH
        -- Capturar y manejar errores
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[ObtenerColaboradorPorId]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerColaboradorPorId]
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
/****** Object:  StoredProcedure [dbo].[ObtenerDepartamentoPorId]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerDepartamentoPorId]
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
/****** Object:  StoredProcedure [dbo].[ObtenerDepartamentos]    Script Date: 27/11/2024 11:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerDepartamentos]
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
USE [master]
GO
ALTER DATABASE [Colaboradores] SET  READ_WRITE 
GO
