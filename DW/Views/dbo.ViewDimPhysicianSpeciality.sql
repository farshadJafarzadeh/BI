SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE VIEW [dbo].[ViewDimPhysicianSpeciality]
WITH SCHEMABINDING
AS
SELECT DPS.Id,
       ViewCatDimPhysicianLevelId = VDPL.NewId,
       DPS.Title,
       NewId = ISNULL(DPS.NewId, [VCDPS].Id)
FROM dbo.DimPhysicianSpeciality AS DPS
    INNER JOIN dbo.DimPhysicianLevel AS DPL
        ON DPL.Id = DPS.PhysicianLevelId
    INNER JOIN dbo.ViewDimPhysicianLevel AS VDPL
        ON VDPL.Id = DPL.Id
    INNER JOIN [dbo].[ViewCatDimPhysicianSpeciality] AS [VCDPS]
        ON [VCDPS].ViewCatDimPhysicianLevelId = VDPL.NewId
           AND [VCDPS].Title = DPS.Title
    LEFT JOIN
    (
        SELECT NewId
        FROM dbo.DimPhysicianSpeciality
        WHERE NewId IS NULL
        GROUP BY NewId
    ) DPSManualCat
        ON DPSManualCat.NewId = DPS.Id
WHERE DPSManualCat.NewId IS NULL;



GO
