SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[InsuranceGroups_GetList]
    @Page INT = 1 ,
    @PageSize INT = 20 ,
    @Asc BIT = 0 ,
    @Sort NVARCHAR(MAX) = 'Title' ,
    @Filter NVARCHAR(MAX) = NULL
AS
    BEGIN
        WITH    TempResult
                  AS ( SELECT   dbo.dimInsurancegroup.*
                       FROM     dbo.dimInsurancegroup
                                INNER JOIN ( SELECT ParentGroup.Id
                                             FROM   dbo.DimInsuranceGroup AS ParentGroup
                                                    LEFT JOIN dbo.DimInsuranceGroup
                                                    AS Childs ON ParentGroup.Id = Childs.[NewId]
                                             WHERE  ParentGroup.[NewId] IS NULL
                                                    AND Childs.[NewId] IS NOT NULL
                                             GROUP BY ParentGroup.Id
                                           ) result ON [result].Id = dbo.diminsurancegroup.Id
                     ),
                TempCount
                  AS ( SELECT   [MaxRows] = COUNT(*)
                       FROM     [TempResult]
                     )
            SELECT  *
            FROM    TempResult ,
                    [TempCount]
            ORDER BY Title
                    OFFSET ( @Page - 1 ) * @PageSize ROWS
			FETCH NEXT @PageSize ROWS ONLY;
    END;

GO
