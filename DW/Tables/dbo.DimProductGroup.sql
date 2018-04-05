CREATE TABLE [dbo].[DimProductGroup]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[OwnerId] [int] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimProductGroup] ADD CONSTRAINT [PK_ProductGroups] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimProductGroup] ADD CONSTRAINT [FK_DimProductGroup_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimProductGroup] ADD CONSTRAINT [FK_DimProductGroup_DimOwner] FOREIGN KEY ([OwnerId]) REFERENCES [dbo].[DimOwner] ([Id])
GO
