CREATE TABLE [dbo].[DimOperationType]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Code] [int] NOT NULL,
[Title] [nvarchar] (50) COLLATE Persian_100_CI_AI NOT NULL,
[IsWarrant] [bit] NOT NULL,
[IsDebt] [bit] NOT NULL CONSTRAINT [DF_DimOperationType_IsDebt] DEFAULT ((0)),
[OwnerId] [int] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimOperationType] ADD CONSTRAINT [CK_DimOperationType_WarrantOrDebt] CHECK (([IsWarrant]=(0) AND [IsDebt]=(0) OR [IsDebt]=(1) OR [IsWarrant]=(1)))
GO
ALTER TABLE [dbo].[DimOperationType] ADD CONSTRAINT [PK_DimOperationType] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimOperationType] ADD CONSTRAINT [FK_DimOperationType_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimOperationType] ADD CONSTRAINT [FK_DimOperationType_DimOwner] FOREIGN KEY ([OwnerId]) REFERENCES [dbo].[DimOwner] ([Id])
GO
