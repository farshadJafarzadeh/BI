SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[ViewCatDimProduct]
WITH SCHEMABINDING AS
SELECT Id = MIN(DP.Id),
       ViewCatDimProductGroupId = VDPG.NewId,
       DP.Code,
       DP.Title
FROM dbo.DimProduct AS DP
    INNER JOIN dbo.DimProductGroup AS DPG
        ON DPG.Id = DP.ProductGroupId
    INNER JOIN dbo.ViewDimProductGroup AS VDPG
        ON VDPG.Id = DPG.Id
WHERE DP.NewId IS NULL
GROUP BY VDPG.NewId,
         DP.Code,
         DP.Title;
GO
