CREATE TABLE [dbo].[DimOwner]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) COLLATE Persian_100_CI_AI NOT NULL,
[Addresses] [nvarchar] (max) COLLATE Persian_100_CI_AI NULL,
[ParentId] [int] NULL,
[NationalId] [nvarchar] (50) COLLATE Persian_100_CI_AI NULL,
[OldId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimOwner] ADD CONSTRAINT [PK_DimOwner] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
