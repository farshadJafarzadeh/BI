SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[ViewDimProduct]
WITH SCHEMABINDING
AS
SELECT DP.Id,
       ViewCatDimProductGroupId = VDPG.NewId,
       DP.Code,
       DP.Title,
       NewId = ISNULL(DP.NewId, [VCDP].Id)
FROM dbo.DimProduct AS DP
    INNER JOIN dbo.DimProductGroup AS DPG
        ON DPG.Id = DP.ProductGroupId
    INNER JOIN dbo.ViewDimProductGroup AS VDPG
        ON VDPG.Id = DPG.Id
    INNER JOIN [dbo].[ViewCatDimProduct] AS [VCDP]
        ON [VCDP].ViewCatDimProductGroupId = VDPG.NewId
           AND [VCDP].Code = DP.Code
           AND [VCDP].Title = DP.Title
    LEFT JOIN
    (
        SELECT NewId
        FROM dbo.DimProduct
        WHERE NewId IS NULL
        GROUP BY NewId
    ) DPManualCat
        ON DPManualCat.NewId = DP.Id
WHERE DPManualCat.NewId IS NULL;



GO
