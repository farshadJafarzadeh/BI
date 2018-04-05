CREATE TABLE [dbo].[DimSystem]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[OwnerId] [int] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimSystem] ADD CONSTRAINT [PK_Systems] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimSystem] ADD CONSTRAINT [FK_DimSystem_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimSystem] ADD CONSTRAINT [FK_DimSystem_DimOwner] FOREIGN KEY ([OwnerId]) REFERENCES [dbo].[DimOwner] ([Id])
GO
