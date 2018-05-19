SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[InsuranceGroup_GetUnCategorized]
    @Filter NVARCHAR(MAX) = NULL ,
    @Page INT = 1 ,
    @PageSize INT = 10 ,
    @Sort NVARCHAR(MAX) = 'Title' ,
    @CategoryTitle NVARCHAR(MAX) NULL = NULL ,
    @CategoryId INT NULL = NULL ,
    @TempSelectedGroupIds [Core].[IntArray] NULL READONLY ,
    @Asc BIT = 1
AS
    BEGIN
        WITH    TempResult
                  AS ( SELECT   dbo.diminsurancegroup.* ,
                                [CatTitle] = Categories.Title ,
                                [Type] = CASE WHEN Categories.Id IS NULL
                                              THEN 0
                                              ELSE 1
                                         END ,
                                DbTitle = dbo.dimDb.Title
                       FROM     dbo.diminsurancegroup
                                LEFT JOIN dbo.diminsurancegroup Categories ON dbo.diminsurancegroup.[NewId] = [Categories].[Id]
                                LEFT JOIN @TempSelectedGroupIds ON [@TempSelectedGroupIds].Item = dbo.diminsurancegroup.Id
                                INNER JOIN dbo.dimDb ON dimDb.Id = dbo.diminsurancegroup.DbId
                       WHERE    ( @Filter IS NULL
                                  OR ( dbo.diminsurancegroup.Title LIKE '%'
                                       + @Filter + '%' )
                                )
                                AND ( @CategoryTitle IS NULL
                                      OR ( dbo.diminsurancegroup.Title = @CategoryTitle )
                                      OR ( dbo.diminsurancegroup.[NewId] = @CategoryId )
                                    )
                                AND dbo.diminsurancegroup.Id NOT IN (
                                SELECT  DISTINCT
                                        [NewId]
                                FROM    dbo.diminsurancegroup
                                WHERE   newId IS NOT NULL )
                                AND [@TempSelectedGroupIds].Item IS NULL
                     ),
                TempCount
                  AS ( SELECT   MaxRows = COUNT(*)
                       FROM     [TempResult]
                     )
            SELECT  *
            FROM    [TempCount] ,
                    [TempResult]
            ORDER BY CASE WHEN @Asc = 1
                               AND @Sort = 'Title' THEN Title
                     END ,
                    CASE WHEN @Asc = 0
                              AND @Sort = 'Title' THEN Title
                    END DESC ,
                    CASE WHEN @Asc = 1
                              AND @Sort = 'CatTitle' THEN CatTitle
                    END ,
                    CASE WHEN @Asc = 0
                              AND @Sort = 'CatTitle' THEN CatTitle
                    END DESC
                    OFFSET ( @Page - 1 ) * @PageSize ROWS
					FETCH NEXT @PageSize ROWS ONLY;
    END;
GO
