SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[ViewDimProduct]

AS
SELECT  DP.Id,
       ViewCatDimProductGroupId=VCDPG.Id,
       DP.Code,
       DP.Title,
       NewId = ISNULL(DP.NewId, DPAutoCat.Id)
FROM dbo.DimProduct AS DP
    INNER JOIN dbo.DimProductGroup AS DPG
        ON DPG.Id = DP.ProductGroupId
    INNER JOIN dbo.ViewDimProductGroup AS VDPG
        ON VDPG.Id = DPG.Id
    INNER JOIN dbo.ViewCatDimProductGroup AS VCDPG
        ON VCDPG.Id = VDPG.NewId
    INNER JOIN
    (
        SELECT Id = MIN(DP.Id),
               ViewCatDimProductGroupId = VCDPG.Id,
               DP.Code,
               DP.Title
        FROM dbo.DimProduct AS DP
            INNER JOIN dbo.DimProductGroup AS DPG
                ON DPG.Id = DP.ProductGroupId
            INNER JOIN dbo.ViewDimProductGroup AS VDPG
                ON VDPG.Id = DPG.Id
            INNER JOIN dbo.ViewCatDimProductGroup AS VCDPG
                ON VCDPG.Id = VDPG.NewId
        WHERE DP.NewId IS NULL
        GROUP BY VCDPG.Id,
                 DP.Code,
                 DP.Title
    ) DPAutoCat
        ON DPAutoCat.ViewCatDimProductGroupId = VCDPG.Id
           AND DPAutoCat.Code = DP.Code
           AND DPAutoCat.Title = DP.Title
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
