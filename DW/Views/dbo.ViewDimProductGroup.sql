SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[ViewDimProductGroup]

AS
SELECT DPG.Id,
       DPG.Title,
       NewId = ISNULL(DPG.NewId, DPGAutoCat.Id)
FROM dbo.DimProductGroup AS DPG
    INNER JOIN
    (
        SELECT Id = MIN(Id),
               DPGAutoCat.Title
        FROM dbo.DimProductGroup AS DPGAutoCat
        WHERE DPGAutoCat.NewId IS NULL
        GROUP BY DPGAutoCat.Title
    ) DPGAutoCat
        ON DPGAutoCat.Title = DPG.Title
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
