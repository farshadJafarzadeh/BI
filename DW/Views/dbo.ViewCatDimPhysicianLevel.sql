SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[ViewCatDimPhysicianLevel]
WITH SCHEMABINDING AS
SELECT Id = MIN(Id),
       DPG.Title,
	   DPG.Level,
	   DPG.Mama
FROM dbo.DimPhysicianLevel AS DPG
WHERE DPG.NewId IS NULL
GROUP BY DPG.Title,
	   DPG.Level,
	   DPG.Mama
GO
