CREATE TABLE [dbo].[FactHeader]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[FinancialYearId] [int] NOT NULL,
[InsuranceId] [int] NOT NULL,
[Type] [nvarchar] (50) COLLATE Persian_100_CI_AI NOT NULL,
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[InsertedDate] [int] NOT NULL,
[InsertedTime] [time] NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [PK_Headers] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimDate] FOREIGN KEY ([InsertedDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_Headers_FinancialYears] FOREIGN KEY ([FinancialYearId]) REFERENCES [dbo].[DimFinancialYear] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_Headers_Insurances] FOREIGN KEY ([InsuranceId]) REFERENCES [dbo].[DimInsurance] ([Id])
GO
