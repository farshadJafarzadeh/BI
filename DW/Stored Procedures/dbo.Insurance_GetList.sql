SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_GetList]
    @Page INT = 1 ,
    @PageSize INT = 20 ,
    @Asc BIT = 0 ,
    @Sort NVARCHAR(MAX) = 'Title' ,
    @Filter NVARCHAR(MAX) = NULL
AS
    BEGIN
        WITH    TempResult
                  AS ( SELECT   dbo.diminsurance.*
                       FROM     dbo.diminsurance
                                INNER JOIN ( SELECT ParentGroup.Id
                                             FROM   dbo.diminsurance AS ParentGroup
                                                    LEFT JOIN dbo.diminsurance
                                                    AS Childs ON ParentGroup.Id = Childs.[NewId]
                                             WHERE  ParentGroup.[NewId] IS NULL
                                                    AND Childs.[NewId] IS NOT NULL
                                             GROUP BY ParentGroup.Id
                                           ) result ON [result].Id = dbo.diminsurance.Id
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
