SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[ViewCatDimInsurance]

WITH SCHEMABINDING AS
SELECT Id = MIN(DI.Id),
       ViewCatDimInsuranceGroupId = VDIG.NewId,
       DI.Code,
       DI.Title
FROM dbo.DimInsurance AS DI
    INNER JOIN dbo.DimInsuranceGroup AS DIG
        ON DIG.Id = DI.InsuranceGroupId
    INNER JOIN dbo.ViewDimInsuranceGroup AS VDIG
        ON VDIG.Id = DIG.Id
WHERE DI.NewId IS NULL
GROUP BY VDIG.NewId,
         DI.Code,
         DI.Title;
GO
