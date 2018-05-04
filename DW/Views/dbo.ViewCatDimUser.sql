SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[ViewCatDimUser]
WITH SCHEMABINDING AS
SELECT Id = MIN(Id),
       DU.UserName,
	   DU.FirstName,
	   DU.LastName,
	   DU.FullName
FROM dbo.DimUser AS DU
WHERE DU.NewId IS NULL
GROUP BY DU.UserName,
	   DU.FirstName,
	   DU.LastName,
	   DU.FullName


GO
