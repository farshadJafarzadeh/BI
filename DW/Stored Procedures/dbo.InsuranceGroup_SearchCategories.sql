SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[InsuranceGroup_SearchCategories]
    @Filter NVARCHAR(20) = '..',
    @SearchInView BIT = 1
AS
BEGIN

    IF @Filter = '..'
        SET @Filter = NULL;
    IF @SearchInView = 1
        SELECT TOP 20
               dbo.ViewCatDimInsuranceGroup.*,
               [Type] = CASE
                            WHEN ViewCatDimInsuranceGroup.Type = 0 THEN
                                N'اتوماتیک'
                            ELSE
                                N'دستی'
                        END
        FROM dbo.ViewCatDimInsuranceGroup
        WHERE @Filter IS NULL
              OR Title LIKE N'%' + @Filter + '%';
    ELSE
        SELECT TOP 20
               *
        FROM dbo.DimInsuranceGroup
            INNER JOIN
            (
                SELECT [Id] = [NewId]
                FROM [dbo].[DimInsuranceGroup]
                WHERE NewId IS NOT NULL
                GROUP BY [NewId]
            ) ManualCategories
                ON [ManualCategories].[Id] = dbo.DimInsuranceGroup.[Id]
        WHERE (
                  @Filter IS NULL
                  OR Title LIKE N'%' + @Filter + '%'
              );

END;
GO
