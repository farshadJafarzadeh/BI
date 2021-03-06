SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_CategorizedGetList]
    @Page INT NULL = 1 ,
    @PageSize INT NULL = 20 ,
    @Filter NVARCHAR(MAX) NULL = NULL ,
    @ASC BIT = 1 ,
    @Automatic BIT = 1 ,
    @Manual BIT = 1
AS
    BEGIN
        WITH    TempResult
                  AS ( SELECT   *
                       FROM     ViewCatDiminsurance
                       WHERE    ( @Filter IS NULL
                                  OR Title LIKE '%' + @Filter + '%'
                                )
                                AND ( ( @Automatic = 1
                                        AND @Manual = 1
                                      )
                                      OR ( @Automatic = 0
                                           OR ( @Automatic = 1
                                                AND ViewCatDiminsurance.[Type] = 0
                                              )
                                         )
                                      AND ( @Manual = 0
                                            OR ( @Manual = 1
                                                 AND ViewCatDiminsurance.[Type] = 1
                                               )
                                          )
                                    )
                     ),
                TempCount
                  AS ( SELECT   MaxRows = COUNT(*)
                       FROM     [TempResult]
                     )
            SELECT  *
            FROM    [TempResult] ,
                    [TempCount]
            ORDER BY Title
                    OFFSET ( @Page - 1 ) * @PageSize ROWS
			FETCH NEXT @PageSize ROWS ONLY;
    END;
GO
