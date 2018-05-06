SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[InsuranceGroup_SearchCategories]
    @Filter NVARCHAR(20) = '..'
AS
    BEGIN
        IF @Filter = '..'
            SET @filter = NULL;
        SELECT TOP 20
                *
        FROM    dbo.ViewCatDimInsuranceGroup
        WHERE   @Filter IS NULL
                OR Title LIKE '%' + @filter + '%';
    END;
GO
