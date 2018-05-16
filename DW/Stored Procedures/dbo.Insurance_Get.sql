SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_Get] @Id INT
AS
    BEGIN
        SELECT  dbo.DimInsurance.* ,
                [GroupTitle] = dbo.DimInsuranceGroup.Title ,
                viewcatdiminsurance.Type
        FROM    dbo.DimInsurance
                INNER JOIN dbo.DimInsuranceGroup ON dbo.DimInsurance.InsuranceGroupId = dbo.DimInsuranceGroup.Id
                LEFT JOIN viewdiminsurance ON viewdiminsurance.id = DimInsurance.id
                LEFT JOIN viewcatdiminsurance ON viewcatdiminsurance.id = viewdiminsurance.newid
        WHERE   dbo.DimInsurance.Id = @Id;

	
        SELECT  diminsurance.* ,
                GroupTitle = diminsurancegroup.title
        FROM    diminsurance
                INNER JOIN diminsurancegroup ON diminsurancegroup.id = diminsurance.insurancegroupid
                LEFT JOIN viewdiminsurance ON diminsurance.id = viewdiminsurance.id
                LEFT JOIN viewcatdiminsurance ON viewdiminsurance.newid = viewcatdiminsurance.id
        WHERE   ( viewcatdiminsurance.Type IS NULL
                  AND diminsurance.newid = @Id
                )
                OR ( viewcatdiminsurance.Type = 0
                     AND viewdiminsurance.Newid = @Id
                   );


    END;
GO
