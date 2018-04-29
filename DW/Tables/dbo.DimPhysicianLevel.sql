CREATE TABLE [dbo].[DimPhysicianLevel]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (150) COLLATE Persian_100_CI_AI NOT NULL,
[Level] [tinyint] NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL,
[Mama] [bit] NULL,
[NewId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimPhysicianLevel] ADD CONSTRAINT [PK_DimPhysicianLevel] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimPhysicianLevel] ADD CONSTRAINT [FK_DimPhysicianLevel_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimPhysicianLevel] ADD CONSTRAINT [FK_DimPhysicianLevel_DimPhysicianLevel] FOREIGN KEY ([NewId]) REFERENCES [dbo].[DimPhysicianLevel] ([Id])
GO
