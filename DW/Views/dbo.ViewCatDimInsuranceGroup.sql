SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE VIEW [dbo].[ViewCatDimInsuranceGroup]
WITH SCHEMABINDING
AS
    SELECT  Id = MIN(DIG.Id) ,
            DIG.Title ,
            DbTitle = MIN(dbo.DimDb.Title) ,
            Type = CASE WHEN DIGReference.NewId IS NULL THEN 0--A
                        ELSE 1--M
                   END ,
            [Count] = CASE WHEN DIGReference.NewId IS NULL THEN COUNT(1)
                           ELSE DIGReference.[Count]
                      END
    FROM    dbo.DimInsuranceGroup AS DIG
            INNER JOIN dbo.DimDb ON dbo.DimDb.Id = DIG.DbId
            LEFT JOIN ( SELECT  DIG.NewId ,
                                [Count] = COUNT(1)
                        FROM    dbo.DimInsuranceGroup AS DIG
                        GROUP BY DIG.NewId
                      ) DIGReference ON DIGReference.NewId = DIG.Id
    WHERE   DIG.NewId IS NULL
    GROUP BY DIG.Title ,
            DIGReference.NewId ,
            DIGReference.[Count];


GO
