SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_GetUnCategorized]
    @Page INT NULL = 1 ,
    @PageSize INT NULL = 20 ,
    @Filter NVARCHAR(MAX) NULL=NULL ,
    @ASC BIT = 1 ,
    @InsuranceGroupCategoryId INT NULL = NULL ,
    @InsuranceGroupCategorytitle NVARCHAR(MAX) NULL=NULL ,
    @InsuranceCategoryId INT NULL = NULL ,
    @InsuranceCategoryTitle INT NULL = NULL ,
    @IncludeAll BIT = 0
AS
    BEGIN
        WITH    TempResult
                  AS ( SELECT   Childs.*
                       FROM     [dbo].[DimInsurance] AS Childs
                                LEFT JOIN [dbo].[DimInsurance] AS Parents ON Childs.NewId = Parents.Id
                       WHERE    ( @IncludeAll = 0
                                  AND Childs.NewId IS NULL
                                  AND Parents.Id IS NULL
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
			
			FETCH NEXT @pageSize ROWS ONLY;
    END;








GO
