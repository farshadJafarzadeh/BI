SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_CategorizedGetList]
    @Page INT NULL = 1 ,
    @PageSize INT NULL = 20 ,
    @Filter NVARCHAR(MAX) NULL = NULL ,
    @ASC BIT = 1 ,
    @InsuranceGroupId INT NULL = NULL ,
    @All BIT = 0
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
                       WHERE    ( @Filter IS NULL
                                  OR dbo.ViewCatDimInsurance.Title LIKE '%'
                                  + @Filter + '%'
                                )
                                AND ( @InsuranceGroupId IS NULL
                                      OR ( @InsuranceGroupId = dbo.ViewCatDimInsuranceGroup.Id )
                                    )
                       GROUP BY dbo.ViewCatDimInsurance.Id ,
                                dbo.ViewCatDimInsurance.ViewCatDimInsuranceGroupId ,
                                dbo.ViewCatDimInsurance.Code ,
                                dbo.ViewCatDimInsuranceGroup.Title ,
                                dbo.ViewCatDimInsurance.Title
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
