SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_SearchCategories]
    @Filter NVARCHAR(MAX) NULL = NULL
AS
    BEGIN
        IF @Filter = '..'
            SET @Filter = NULL;


        SELECT TOP 10
                dbo.ViewCatDimInsurance.* ,
                [GroupTitle] = dbo.ViewCatDimInsuranceGroup.Title ,
                [Type] = CASE WHEN MAX(dbo.diminsurance.newId) IS NULL
                                THEN N'اتومات'
                                ELSE N'دستی'
                           END
        FROM    dbo.ViewCatDimInsurance
                INNER JOIN dbo.ViewCatDimInsuranceGroup ON dbo.ViewCatDimInsuranceGroup.Id = dbo.ViewCatDimInsurance.ViewcatDimInsuranceGroupId
                LEFT JOIN dbo.diminsurance ON dbo.ViewCatDimInsurance.Id = dbo.diminsurance.NewId
        WHERE   @Filter IS NULL
                OR dbo.ViewCatDimInsurance.Title LIKE '%' + @Filter + '%'
        GROUP BY dbo.ViewCatDimInsurance.Id ,
                dbo.ViewCatDimInsurance.ViewCatDimInsuranceGroupId ,
                dbo.ViewCatDimInsurance.Code ,
                dbo.ViewCatDimInsuranceGroup.Title ,
                dbo.ViewCatDimInsurance.Title
        ORDER BY Id;




    END;
GO
