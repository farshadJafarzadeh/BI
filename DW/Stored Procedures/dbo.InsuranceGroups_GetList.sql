SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[InsuranceGroups_GetList]
    @Page INT = 1 ,
    @PageSize INT = 20 ,
    @Asc BIT = 1 ,
    @Sort NVARCHAR(MAX) = 'Title' ,
    @Filter NVARCHAR(MAX) = NULL ,
    @Automatic BIT = 1 ,
    @Manual BIT = 1
AS
    BEGIN;
        WITH    TempResult
                  AS ( SELECT   ViewCatDimInsuranceGroup.Id ,
                                ViewCatDimInsuranceGroup.Count ,
                                [Title] = ViewCatDimInsuranceGroup.Title ,
                                [NewId] = CASE WHEN Type = 0 THEN NULL
                                               ELSE 1
                                          END
                       FROM     ViewCatDimInsuranceGroup
                       WHERE    ( ( ( @Automatic = 0
                                      AND ViewCatDimInsuranceGroup.Type <> 0
                                    )
                                    OR ( @Automatic = 1
                                         AND ViewCatDimInsuranceGroup.Type = 0
                                       )
                                  )
                                  OR ( ( @Manual = 0
                                         AND ViewCatDimInsuranceGroup.Type <> 1
                                       )
                                       OR ( @Manual = 1
                                            AND ViewCatDimInsuranceGroup.Type = 1
                                          )
                                     )
                                )
                                AND ( @Filter IS NULL
                                      OR ( ViewCatDimInsuranceGroup.Title LIKE '%'
                                           + @Filter + '%' )
                                    )
                     ),
                TempCount
                  AS ( SELECT   [MaxRows] = COUNT(*)
                       FROM     [TempResult]
                     )
            SELECT  *
            FROM    TempResult ,
                    [TempCount]
            ORDER BY CASE WHEN @Asc = 1 THEN Title
                     END ,
                    CASE WHEN @Asc = 0 THEN Title
                    END DESC
                    OFFSET ( @Page - 1 ) * @PageSize ROWS FETCH NEXT @PageSize
                    ROWS ONLY;
    END;

GO
