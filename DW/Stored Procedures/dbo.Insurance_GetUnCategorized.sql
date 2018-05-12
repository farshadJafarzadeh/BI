SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_GetUnCategorized]
    @Page INT NULL = 1 ,
    @PageSize INT NULL = 20 ,
    @Filter NVARCHAR(MAX) NULL = NULL ,
    @ASC BIT = 1 ,
    @InsuranceCategoryId INT NULL = NULL ,
    @InsuranceCategoryTitle NVARCHAR(MAX) NULL = NULL ,
    @InsuranceGroupId INT NULL = NULL ,
    @TempSelectedGroupIds [Core].[IntArray] NULL READONLY ,
    @All BIT = 0
AS
    BEGIN
        WITH    TempRealCats
                  AS ( SELECT DISTINCT
                                [NewId]
                       FROM     [dbo].[DimInsurance]
                       WHERE    [NewId] IS NOT NULL
                     ),
                TempResult
                  AS ( SELECT   Childs.* ,
                                [CatTitle] = Parents.Title ,
                                [GroupId] = [dbo].[DimInsuranceGroup].Id ,
                                [GroupTitle] = [dbo].[DimInsuranceGroup].Title ,
                                CatId = Parents.Id
                       FROM     [dbo].[DimInsurance] AS Childs
                                LEFT JOIN [dbo].[DimInsurance] AS Parents ON Childs.NewId = Parents.Id
                                LEFT JOIN [dbo].[DimInsuranceGroup] ON Childs.InsuranceGroupId = [dbo].[DimInsuranceGroup].Id
                                LEFT JOIN @TempSelectedGroupIds ON [@TempSelectedGroupIds].Item = Childs.Id
                       WHERE    ( ( @InsuranceCategoryId IS NOT NULL
                                    OR ( @InsuranceCategoryId IS NULL
                                         AND ( @All = 1
                                               OR ( @All = 0
                                                    AND Childs.NewId IS NULL
                                                    AND Parents.Id IS NULL
                                                  )
                                             )
                                       )
                                  )
                                  AND Childs.Id NOT IN ( SELECT
                                                              *
                                                         FROM [TempRealCats] )
                                  AND ( @Filter IS NULL
                                        OR Childs.Title LIKE '%' + @Filter
                                        + '%'
                                      )
                                  AND ( @InsuranceCategoryId IS NULL
                                        OR ( @InsuranceCategoryId IN ( SELECT
                                                              *
                                                              FROM
                                                              [TempRealCats] )
                                             AND Childs.NewId = @InsuranceCategoryId
                                           )
                                        OR ( @InsuranceCategoryId NOT IN (
                                             SELECT *
                                             FROM   [TempRealCats] )
                                             AND Childs.Title LIKE '%'
                                             + @InsuranceCategoryTitle + '%'
                                           )
                                      )
                                )
                                AND [@TempSelectedGroupIds].Item IS NULL
                                AND ( @InsuranceGroupId IS NULL
                                      OR ( [dbo].[DimInsuranceGroup].[NewId] = @InsuranceGroupId )
                                    )
                     ),
                TempCount
                  AS ( SELECT   MaxRows = COUNT(*)
                       FROM     [TempResult]
                     )
            SELECT  *
            FROM    [TempResult] ,
                    [TempCount]
            ORDER BY Id
                    OFFSET ( @Page - 1 ) * @PageSize ROWS
			
			FETCH NEXT @pageSize ROWS ONLY;
    END;








GO
