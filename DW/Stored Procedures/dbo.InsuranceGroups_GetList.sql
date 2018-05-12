SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE  PROCEDURE [dbo].[InsuranceGroups_GetList]
    @Page INT = 1 ,
    @PageSize INT = 20 ,
    @Asc BIT = 0 ,
    @Sort NVARCHAR(MAX) = 'Title' ,
    @Filter NVARCHAR(MAX) = NULL ,
    @Automatic BIT = 1 ,
    @Manual BIT = 1
AS
    BEGIN
        WITH    TempResult
                  AS ( SELECT   viewcatdiminsurancegroup.Id ,
                                [Title] = viewcatdiminsurancegroup.title ,
                                [NewId] = MAX(diminsurancegroup.NewId)
                       FROM     viewcatdiminsurancegroup
                                LEFT JOIN viewdiminsurancegroup ON viewcatdiminsurancegroup.id = viewdiminsurancegroup.newid
                                LEFT JOIN diminsurancegroup ON viewdiminsurancegroup.id = diminsurancegroup.newId
                       WHERE    ( ( @Automatic = 1
                                    AND @Manual = 1
                                  )
                                  OR ( @Automatic = 0
                                       OR ( @Automatic = 1
                                            AND diminsurancegroup.NewId IS NULL
                                          )
                                     )
                                  AND ( @Manual = 0
                                        OR ( @Manual = 1
                                             AND diminsurancegroup.NewId IS NOT NULL
                                           )
                                      )
                                )
                                AND ( @Filter IS NULL
                                      OR ( viewcatdiminsurancegroup.title LIKE '%'
                                           + @Filter + '%' )
                                    )
                       GROUP BY viewcatdiminsurancegroup.id ,
                                viewcatdiminsurancegroup.title
                     ),
                TempCount
                  AS ( SELECT   [MaxRows] = COUNT(*)
                       FROM     [TempResult]
                     )
            SELECT  *
            FROM    TempResult ,
                    [TempCount]
            ORDER BY title
                    OFFSET ( @Page - 1 ) * @PageSize ROWS
			FETCH NEXT @PageSize ROWS ONLY;
    END;

GO
