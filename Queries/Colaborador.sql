USE [Colaboradores]
GO

/****** Object:  Table [dbo].[Colaborador]    Script Date: 26/11/2024 01:09:02 ******/
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

ALTER TABLE [dbo].[Colaborador] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
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


