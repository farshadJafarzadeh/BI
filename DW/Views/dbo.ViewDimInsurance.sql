SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










 


CREATE VIEW [dbo].[ViewDimInsurance]
WITH SCHEMABINDING
AS
    SELECT  DI.Id ,
            ViewCatDimInsuranceGroupId = VDIG.NewId ,
            DI.Code ,
            DI.Title ,
			DbTitle=dbo.DimDb.Title,
            NewId = ISNULL(DI.NewId, [ViewCatDimInsurance].Id)
    FROM    dbo.DimInsurance AS DI
            INNER JOIN dbo.DimInsuranceGroup AS DIG ON DIG.Id = DI.InsuranceGroupId
            INNER JOIN dbo.ViewDimInsuranceGroup AS VDIG ON VDIG.Id = DIG.Id
            INNER JOIN dbo.DimDb ON DI.DbId = dbo.DimDb.Id
            INNER JOIN [dbo].[ViewCatDimInsurance] ON [ViewCatDimInsurance].ViewCatDimInsuranceGroupId = VDIG.NewId
                                                      AND [ViewCatDimInsurance].Code = DI.Code
                                                      AND [ViewCatDimInsurance].Title = DI.Title
            LEFT JOIN ( SELECT  NewId
                        FROM    dbo.DimInsurance
                        WHERE   NewId IS NULL
                        GROUP BY NewId
                      ) DIManualCat ON DIManualCat.NewId = DI.Id
    WHERE   DIManualCat.NewId IS NULL;








GO
