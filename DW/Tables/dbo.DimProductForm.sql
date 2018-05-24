CREATE TABLE [dbo].[DimProductForm]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AS NOT NULL,
[OwnerId] [int] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL,
[NewId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimProductForm] ADD CONSTRAINT [PK_ProductForms] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimProductForm] ADD CONSTRAINT [FK_DimProductForm_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimProductForm] ADD CONSTRAINT [FK_DimProductForm_DimOwner] FOREIGN KEY ([OwnerId]) REFERENCES [dbo].[DimOwner] ([Id])
GO
ALTER TABLE [dbo].[DimProductForm] ADD CONSTRAINT [FK_DimProductForm_DimProductForm] FOREIGN KEY ([NewId]) REFERENCES [dbo].[DimProductForm] ([Id])
GO
