CREATE TABLE [dbo].[DimInsuranceGroup]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (500) COLLATE Persian_100_CI_AI NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimInsuranceGroup] ADD CONSTRAINT [PK_InsuranceGroups] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
