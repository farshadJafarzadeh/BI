SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE VIEW [dbo].[ViewDimInsuranceGroup]
WITH SCHEMABINDING
AS
    SELECT  DIG.Id ,
            DIG.Title ,
            NewId = ISNULL(DIG.NewId, [VCDIG].Id) ,
            DbTitle = dbo.DimDb.Title
    FROM    dbo.DimInsuranceGroup AS DIG
            INNER JOIN [dbo].[ViewCatDimInsuranceGroup] AS [VCDIG] ON ( DIG.NewId IS NOT NULL
                                                              AND [VCDIG].Id = DIG.NewId
                                                              )
                                                              OR ( DIG.NewId IS NULL
                                                              AND [VCDIG].Title = DIG.Title
                                                              )
            LEFT JOIN ( SELECT  NewId
                        FROM    dbo.DimInsuranceGroup
                        WHERE   NewId IS NOT NULL
                        GROUP BY NewId
                      ) DIGManualCat ON DIGManualCat.NewId = DIG.Id
            INNER JOIN dbo.DimDb ON dbo.DimDb.Id = DIG.DbId
    WHERE   DIGManualCat.NewId IS NULL;





GO
