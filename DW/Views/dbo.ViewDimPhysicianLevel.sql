SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[ViewDimPhysicianLevel]
WITH SCHEMABINDING
AS
SELECT DPL.Id,
       DPL.Title,
       DPL.Level,
       DPL.Mama,
       NewId = ISNULL(DPL.NewId, [VCDPL].Id)
FROM dbo.DimPhysicianLevel AS DPL
    INNER JOIN [dbo].[ViewCatDimPhysicianLevel] AS [VCDPL]
        ON [VCDPL].Title = DPL.Title
           AND (([VCDPL].Level IS NULL AND  DPL.Level IS NULL) OR ([VCDPL].Level = DPL.Level))
           AND (([VCDPL].Mama IS NULL AND  DPL.Mama IS NULL) OR ([VCDPL].Level = DPL.Level))
    LEFT JOIN
    (
        SELECT NewId
        FROM dbo.DimPhysicianLevel
        WHERE NewId IS NULL
        GROUP BY NewId
    ) DPLManualCat
        ON DPLManualCat.NewId = DPL.Id
WHERE DPLManualCat.NewId IS NULL;


GO
