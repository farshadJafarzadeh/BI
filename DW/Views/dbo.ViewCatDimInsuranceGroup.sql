SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[ViewCatDimInsuranceGroup]
WITH SCHEMABINDING
AS
SELECT Id = MIN(Id),
       DIG.Title,
       Type = CASE
                  WHEN DIGReference.NewId IS NULL THEN
                      0--A
                  ELSE
                      1--M
              END
FROM dbo.DimInsuranceGroup AS DIG
    LEFT JOIN
    (
        SELECT DIG.NewId
        FROM dbo.DimInsuranceGroup AS DIG
        GROUP BY DIG.NewId
    ) DIGReference
        ON DIGReference.NewId = DIG.Id
WHERE DIG.NewId IS NULL
GROUP BY DIG.Title,DIGReference.NewId;
GO
