SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[ViewCatDimInsurance]

AS
SELECT Id = MIN(DI.Id),
       ViewCatDimInsuranceGroupId = VCDIG.Id,
       DI.Code,
       DI.Title
FROM dbo.DimInsurance AS DI
    INNER JOIN dbo.DimInsuranceGroup AS DIG
        ON DIG.Id = DI.InsuranceGroupId
    INNER JOIN dbo.ViewDimInsuranceGroup AS VDIG
        ON VDIG.Id = DIG.Id
    INNER JOIN dbo.ViewCatDimInsuranceGroup AS VCDIG
        ON VCDIG.Id = VDIG.NewId
WHERE DI.NewId IS NULL
GROUP BY VCDIG.Id,
         DI.Code,
         DI.Title;
GO
