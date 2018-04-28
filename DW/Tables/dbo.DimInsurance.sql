CREATE TABLE [dbo].[DimInsurance]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[InsuranceGroupId] [int] NOT NULL,
[Code] [int] NULL,
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL,
[NewId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimInsurance] ADD CONSTRAINT [PK_Insurances] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimInsurance] ADD CONSTRAINT [IX_DimInsurance] UNIQUE NONCLUSTERED  ([DBId], [Code]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimInsurance] ADD CONSTRAINT [FK_DimInsurance_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimInsurance] ADD CONSTRAINT [FK_DimInsurance_DimInsurance] FOREIGN KEY ([NewId]) REFERENCES [dbo].[DimInsurance] ([Id])
GO
ALTER TABLE [dbo].[DimInsurance] ADD CONSTRAINT [FK_Insurances_InsuranceGroups] FOREIGN KEY ([InsuranceGroupId]) REFERENCES [dbo].[DimInsuranceGroup] ([Id])
GO
