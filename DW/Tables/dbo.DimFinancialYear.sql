CREATE TABLE [dbo].[DimFinancialYear]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[SystemId] [int] NOT NULL,
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimFinancialYear] ADD CONSTRAINT [PK_FinancialYears] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimFinancialYear] ADD CONSTRAINT [FK_FinancialYears_Systems] FOREIGN KEY ([SystemId]) REFERENCES [dbo].[DimSystem] ([Id])
GO
