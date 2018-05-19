SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













CREATE  VIEW [dbo].[ViewCatDimInsurance]
WITH SCHEMABINDING
AS
    SELECT  Id = MIN(DI.Id) ,
            ViewCatDimInsuranceGroupId = VDIG.NewId ,
            DI.Code ,
            DI.Title ,
            DbTitle = dbo.DimDb.Title ,
            Type = CASE WHEN [InsuranceReferences].NewId IS NULL THEN 0 --A
                        ELSE 1 --M
                   END ,
            [Count] = CASE WHEN InsuranceReferences.NewId IS NULL
                           THEN COUNT(1)
                           ELSE [InsuranceReferences].[Count]
                      END
    FROM    dbo.DimInsurance AS DI
            INNER JOIN dbo.DimInsuranceGroup AS DIG ON DIG.Id = DI.InsuranceGroupId
            INNER JOIN dbo.DimDb ON DI.DbId = dbo.DimDb.Id
            INNER JOIN dbo.ViewDimInsuranceGroup AS VDIG ON VDIG.Id = DIG.Id
            LEFT JOIN ( SELECT  NewId ,
                                [Count] = COUNT(1)
                        FROM    dbo.DimInsurance
                        GROUP BY NewId
                      ) InsuranceReferences ON [DI].Id = InsuranceReferences.NewId
    WHERE   DI.NewId IS NULL
    GROUP BY VDIG.NewId ,
            DI.Code ,
            DI.Title ,
            [InsuranceReferences].NewId ,
            [InsuranceReferences].[Count] ,
            dbo.DimDb.Title





GO
