CREATE TABLE [dbo].[DimPhysician]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[PhysicianSpecialityId] [int] NOT NULL,
[FirstName] [nvarchar] (150) COLLATE Persian_100_CI_AI NULL,
[LastName] [nvarchar] (150) COLLATE Persian_100_CI_AI NULL,
[FullName] AS (isnull([FirstName]+' ','')+isnull([LastName],'')),
[MedicalCouncilCode] [int] NOT NULL,
[IsResident] [bit] NOT NULL,
[Sex] [tinyint] NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL,
[Mama] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimPhysician] ADD CONSTRAINT [PK_DimPhysician] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimPhysician] ADD CONSTRAINT [FK_DimPhysician_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[DimPhysician] ADD CONSTRAINT [FK_DimPhysician_DimPhysicianSpeciality] FOREIGN KEY ([PhysicianSpecialityId]) REFERENCES [dbo].[DimPhysicianSpeciality] ([Id])
GO
