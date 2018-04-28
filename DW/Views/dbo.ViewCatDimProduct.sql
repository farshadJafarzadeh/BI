SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[ViewCatDimProduct]

AS
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
         DP.Title;
GO
