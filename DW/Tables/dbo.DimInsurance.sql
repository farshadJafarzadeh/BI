CREATE TABLE [dbo].[DimInsurance]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[InsuranceGroupId] [int] NOT NULL,
[Code] [int] NULL,
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimInsurance] ADD CONSTRAINT [PK_Insurances] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimInsurance] ADD CONSTRAINT [FK_Insurances_InsuranceGroups] FOREIGN KEY ([InsuranceGroupId]) REFERENCES [dbo].[DimInsuranceGroup] ([Id])
GO
