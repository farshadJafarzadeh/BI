SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GroupedInsuranceGroup_GetList]
    @Filter NVARCHAR(MAX) = NULL ,
    @Automatic BIT = 1 ,
    @Manual BIT = 1,
	@UserFullName nvarchar(50)
AS
    BEGIN;
  select ROW_NUMBER() OVER ( ORDER BY Title) AS Row,* FROM(
				 SELECT ViewCatDimInsuranceGroup.Id,
						ViewCatDimInsuranceGroup.Title,
						ViewCatDimInsuranceGroup.Type,
						ViewCatDimInsuranceGroup.Count,
						ViewDimInsuranceGroup.Id as ChildId,
						ViewDimInsuranceGroup.Title AS ChildTitle,
						ViewDimInsuranceGroup.NewId,
						ViewDimInsuranceGroup.DBTitle AS ChildDBTitle ,
						ViewCatDimInsuranceGroup.DBTitle,
						@UserFullName as UserFullName
				 FROM ViewCatDimInsuranceGroup
				 LEFT JOIN  ViewDimInsuranceGroup on ViewDimInsuranceGroup.newId=ViewCatDimInsuranceGroup.Id
				 WHERE    ( ( ( @Automatic = 0
                                      AND ViewCatDimInsuranceGroup.Type <> 0
                                    )
                                    OR ( @Automatic = 1
                                         AND ViewCatDimInsuranceGroup.Type = 0
                                       )
                                  )
                                  OR ( ( @Manual = 0
                                         AND ViewCatDimInsuranceGroup.Type <> 1
                                       )
                                       OR ( @Manual = 1
                                            AND ViewCatDimInsuranceGroup.Type = 1
                                          )
                                     )
                                )
                                AND ( @Filter IS NULL
                                      OR ( ViewCatDimInsuranceGroup.Title LIKE '%'
                                           + @Filter + '%' )
                                    )
			)a
  
    END;

GO
