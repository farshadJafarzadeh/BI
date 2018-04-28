SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[ViewDimProductGroup]
WITH SCHEMABINDING
AS
SELECT DPG.Id,
       DPG.Title,
       NewId = ISNULL(DPG.NewId, [VCDPG].Id)
FROM dbo.DimProductGroup AS DPG
    INNER JOIN [dbo].[ViewCatDimProductGroup] AS [VCDPG]
        ON [VCDPG].Title = DPG.Title
    LEFT JOIN
    (
        SELECT NewId
        FROM dbo.DimProductGroup
        WHERE NewId IS NULL
        GROUP BY NewId
    ) DPGManualCat
        ON DPGManualCat.NewId = DPG.Id
WHERE DPGManualCat.NewId IS NULL;


GO
