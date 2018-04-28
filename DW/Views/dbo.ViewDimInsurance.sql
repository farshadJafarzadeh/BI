SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[ViewDimInsurance]

AS
SELECT  DI.Id,
       ViewCatDimInsuranceGroupId=VCDIG.Id,
       DI.Code,
       DI.Title,
       NewId = ISNULL(DI.NewId, DIAutoCat.Id)
FROM dbo.DimInsurance AS DI
    INNER JOIN dbo.DimInsuranceGroup AS DIG
        ON DIG.Id = DI.InsuranceGroupId
    INNER JOIN dbo.ViewDimInsuranceGroup AS VDIG
        ON VDIG.Id = DIG.Id
    INNER JOIN dbo.ViewCatDimInsuranceGroup AS VCDIG
        ON VCDIG.Id = VDIG.NewId
    INNER JOIN
    (
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
                 DI.Title
    ) DIAutoCat
        ON DIAutoCat.ViewCatDimInsuranceGroupId = VCDIG.Id
           AND DIAutoCat.Code = DI.Code
           AND DIAutoCat.Title = DI.Title
    LEFT JOIN
    (
        SELECT NewId
        FROM dbo.DimInsurance
        WHERE NewId IS NULL
        GROUP BY NewId
    ) DIManualCat
        ON DIManualCat.NewId = DI.Id
WHERE DIManualCat.NewId IS NULL;



GO
