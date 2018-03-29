CREATE TABLE [dbo].[DimProduct]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[ProductGroupId] [int] NOT NULL,
[Code] [int] NOT NULL,
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimProduct] ADD CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimProduct] ADD CONSTRAINT [FK_Products_ProductGroups] FOREIGN KEY ([ProductGroupId]) REFERENCES [dbo].[DimProductGroup] ([Id])
GO
