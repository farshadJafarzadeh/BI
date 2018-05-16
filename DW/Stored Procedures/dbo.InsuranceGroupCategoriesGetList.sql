SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[InsuranceGroupCategoriesGetList]
    @Page INT NULL = 1 ,
    @PageSize INT NULL = 20 ,
    @Filter NVARCHAR(MAX) NULL = NULL ,
    @ASC BIT = 1 ,
    @Sort NVARCHAR(MAX) NULL = NULL ,
    @Automatic BIT = 1 ,
    @Manual BIT = 1
AS
    BEGIN
        WITH    tempResult
                  AS ( SELECT   *
                       FROM     viewCatDiminsuranceGroup
                       WHERE    ( @Filter IS NULL
                                  OR title LIKE '%' + @Filter + '%'
                                )
                                AND ( ( @Automatic = 1
                                        AND @Manual = 1
                                      )
                                      OR ( @Automatic = 0
                                           OR ( @Automatic = 1
                                                AND viewCatDiminsuranceGroup.[Type] = 0
                                              )
                                         )
                                      AND ( @Manual = 0
                                            OR ( @Manual = 1
                                                 AND viewCatDiminsuranceGroup.[Type] = 1
                                               )
                                          )
                                    )
                     ),
                TempCount
                  AS ( SELECT   MaxRows = COUNT(*)
                       FROM     [tempResult]
                     )
            SELECT  *
            FROM    [tempResult] ,
                    [TempCount]
            ORDER BY CASE WHEN @ASC = 1 THEN Title
                     END ,
                    CASE WHEN @ASC = 0 THEN Title
                    END DESC
                    OFFSET ( @page - 1 ) * @Pagesize ROWS  FETCH NEXT @pageSize
                    ROWS ONLY; 
                     


    END;
GO
