CREATE TABLE [dbo].[DimPhysicianSpeciality]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[PhysicianLevelId] [int] NOT NULL,
[Title] [nvarchar] (150) COLLATE Persian_100_CI_AI NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL,
[NewId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimPhysicianSpeciality] ADD CONSTRAINT [PK_DimPhysicianSpeciality] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimPhysicianSpeciality] ADD CONSTRAINT [FK_DimPhysicianSpeciality_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimPhysicianSpeciality] ADD CONSTRAINT [FK_DimPhysicianSpeciality_DimPhysicianLevel] FOREIGN KEY ([PhysicianLevelId]) REFERENCES [dbo].[DimPhysicianLevel] ([Id])
GO
ALTER TABLE [dbo].[DimPhysicianSpeciality] ADD CONSTRAINT [FK_DimPhysicianSpeciality_DimPhysicianSpeciality] FOREIGN KEY ([NewId]) REFERENCES [dbo].[DimPhysicianSpeciality] ([Id])
GO
