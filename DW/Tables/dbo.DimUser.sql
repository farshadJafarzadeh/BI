CREATE TABLE [dbo].[DimUser]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[UserName] [varchar] (50) COLLATE Persian_100_CI_AI NOT NULL,
[FirstName] [nvarchar] (150) COLLATE Persian_100_CI_AI NULL,
[LastName] [nvarchar] (150) COLLATE Persian_100_CI_AI NULL,
[FullName] AS (([FirstName]+' ')+[LastName]),
[OwnerId] [int] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimUser] ADD CONSTRAINT [PK_DimUser] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimUser] ADD CONSTRAINT [FK_DimUser_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimUser] ADD CONSTRAINT [FK_DimUser_DimOwner] FOREIGN KEY ([OwnerId]) REFERENCES [dbo].[DimOwner] ([Id])
GO
