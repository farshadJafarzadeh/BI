SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE VIEW [dbo].[ViewCatDimPhysicianSpeciality]
WITH SCHEMABINDING AS
SELECT Id = MIN(DPS.Id),
       ViewCatDimPhysicianLevelId = VDPL.NewId,
       DPS.Title
FROM dbo.DimPhysicianSpeciality AS DPS
    INNER JOIN dbo.DimPhysicianLevel AS DPL
        ON DPL.Id = DPS.PhysicianLevelId
    INNER JOIN dbo.ViewDimPhysicianLevel AS VDPL
        ON VDPL.Id = DPL.Id
WHERE DPS.NewId IS NULL
GROUP BY VDPL.NewId,
         DPS.Title;
GO
