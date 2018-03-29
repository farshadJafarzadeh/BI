CREATE TABLE [dbo].[DimSystem]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimSystem] ADD CONSTRAINT [PK_Systems] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
