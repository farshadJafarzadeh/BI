SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[ViewDimInsuranceGroup]

AS
SELECT DIG.Id,
       DIG.Title,
       NewId = ISNULL(DIG.NewId, DIGAutoCat.Id)
FROM dbo.DimInsuranceGroup AS DIG
    INNER JOIN
    (
        SELECT Id = MIN(Id),
               DIGAutoCat.Title
        FROM dbo.DimInsuranceGroup AS DIGAutoCat
        WHERE DIGAutoCat.NewId IS NULL
        GROUP BY DIGAutoCat.Title
    ) DIGAutoCat
        ON DIGAutoCat.Title = DIG.Title
    LEFT JOIN
    (
        SELECT NewId
        FROM dbo.DimInsuranceGroup
        WHERE NewId IS NULL
        GROUP BY NewId
    ) DIGManualCat
        ON DIGManualCat.NewId = DIG.Id
WHERE DIGManualCat.NewId IS NULL;


GO
