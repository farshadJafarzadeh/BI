SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE  PROCEDURE [dbo].[InsuranceGroup_SearchCategories]
    @Filter NVARCHAR(20) = '..' ,
    @SearchInView BIT = 1
AS
    BEGIN
        
        IF @Filter = '..'
            SET @Filter = NULL;
        IF @SearchInView = 1
            SELECT TOP 20
                    dbo.ViewCatDimInsuranceGroup.* ,
                    [Type] = CASE WHEN ManualCats.NewId IS NULL THEN N'اتوماتیک'
                                  ELSE N'دستی'
                             END
            FROM    dbo.ViewCatDimInsuranceGroup
                    LEFT JOIN ( SELECT DISTINCT
                                        [NewId]
                                FROM    dbo.DimInsuranceGroup
                                WHERE   NewId IS NOT NULL
                              ) ManualCats ON ManualCats.[NewId] = dbo.ViewCatDimInsuranceGroup.Id
            WHERE   @Filter IS NULL
                    OR Title LIKE '%' + @Filter + '%';
        ELSE
            SELECT TOP 20
                    *
            FROM    dbo.dimInsuranceGroup
                    INNER JOIN ( SELECT [Id] = [NewId]
                                 FROM   [dbo].[DimInsuranceGroup]
                                 WHERE  NEWID IS NOT NULL
                                 GROUP BY [NewId]
                               ) ManualCategories ON [ManualCategories].[Id] = dbo.dimInsuranceGroup.[Id]
            WHERE   ( @Filter IS NULL
                      OR Title LIKE '%' + @Filter + '%'
                    );

    END;
GO
