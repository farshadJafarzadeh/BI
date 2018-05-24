CREATE TABLE [dbo].[DimProductLine]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AS NOT NULL,
[OwnerId] [int] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL,
[NewId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimProductLine] ADD CONSTRAINT [PK_ProductLines] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimProductLine] ADD CONSTRAINT [FK_DimProductLine_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimProductLine] ADD CONSTRAINT [FK_DimProductLine_DimOwner] FOREIGN KEY ([OwnerId]) REFERENCES [dbo].[DimOwner] ([Id])
GO
ALTER TABLE [dbo].[DimProductLine] ADD CONSTRAINT [FK_DimProductLine_DimProductLine] FOREIGN KEY ([NewId]) REFERENCES [dbo].[DimProductLine] ([Id])
GO
