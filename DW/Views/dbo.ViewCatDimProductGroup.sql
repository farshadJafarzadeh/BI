SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[ViewCatDimProductGroup]

AS
SELECT Id = MIN(Id),
       DPG.Title
FROM dbo.DimProductGroup AS DPG
WHERE DPG.NewId IS NULL
GROUP BY DPG.Title;
GO