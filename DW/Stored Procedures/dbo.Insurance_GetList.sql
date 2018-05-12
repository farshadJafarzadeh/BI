SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_GetList]
    @Page INT = 1 ,
    @PageSize INT = 20 ,
    @Asc BIT = 0 ,
    @Sort NVARCHAR(MAX) = 'Title' ,
    @Filter NVARCHAR(MAX) = NULL ,
    @InsuranceGroupId INT NULL = NULL ,
    @Automatic BIT = 1 ,
    @Manual BIT = 1
AS
    BEGIN
        WITH    TempResult
                  AS ( SELECT   dbo.ViewCatDimInsurance.* ,
                                [GroupTitle] = dbo.ViewCatDimInsuranceGroup.Title ,
                                [Type] = CASE WHEN MAX(dbo.diminsurance.newId) IS NULL
                                              THEN 0
                                              ELSE 1
                                         END
                       FROM     dbo.ViewCatDimInsurance
                                INNER JOIN dbo.ViewCatDimInsuranceGroup ON dbo.ViewCatDimInsuranceGroup.Id = dbo.ViewCatDimInsurance.ViewcatDimInsuranceGroupId
                                LEFT JOIN dbo.diminsurance ON dbo.ViewCatDimInsurance.Id = dbo.diminsurance.NewId
                       GROUP BY dbo.ViewCatDimInsurance.Id ,
                                dbo.ViewCatDimInsurance.ViewCatDimInsuranceGroupId ,
                                dbo.ViewCatDimInsurance.Code ,
                                dbo.ViewCatDimInsuranceGroup.Title ,
                                dbo.ViewCatDimInsurance.Title
                     ),
                TempFinalResult
                  AS ( SELECT   *
                       FROM     TempResult
                       WHERE    ( ( @Automatic = 1
                                    AND @Manual = 1
                                  )
                                  OR ( @Automatic = 0
                                       OR ( @Automatic = 1
                                            AND [TempResult].[Type] = 0
                                          )
                                     ) 
                                  AND ( @Manual = 0
                                        OR ( @Manual = 1
                                             AND [TempResult].[Type] = 1
                                           )
                                      )
                                )
                                AND ( @Filter IS NULL
                                      OR TempResult.Title LIKE '%' + @Filter
                                      + '%'
                                    )
                                AND ( @InsuranceGroupId IS NULL
                                      OR @InsuranceGroupId = TempResult.ViewCatDimInsuranceGroupId
                                    )
                     ),
                TempCount
                  AS ( SELECT   [MaxRows] = COUNT(*)
                       FROM     [TempFinalResult]
                     )
            SELECT  *
            FROM    [TempFinalResult] ,
                    [TempCount]
            ORDER BY CASE WHEN @Asc = 1
                               AND @Sort = 'Title' THEN Title
                     END ,
                    CASE WHEN @Asc = 0
                              AND @Sort = 'Title' THEN Title
                    END DESC ,
                    CASE WHEN @Asc = 1
                              AND @Sort = 'GroupTitle' THEN GroupTitle
                    END ,
                    CASE WHEN @Asc = 0
                              AND @Sort = 'GroupTitle' THEN GroupTitle
                    END DESC ,
                    CASE WHEN @Asc = 1
                              AND @Sort = 'Type' THEN [Type]
                    END ,
                    CASE WHEN @Asc = 0
                              AND @Sort = 'Type' THEN [Type]
                    END DESC
                    OFFSET ( @Page - 1 ) * @PageSize ROWS
			FETCH NEXT @PageSize ROWS ONLY;
    END;

GO
