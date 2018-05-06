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
                *
        FROM    dbo.ViewCatDimInsurance
        WHERE   @Filter IS NULL
                OR Title LIKE '%' + @Filter + '%';
    END;

	
GO
