SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_Get] @Id INT
AS
    BEGIN
        SELECT  dbo.DimInsurance.* ,
                [GroupTitle] = dbo.DimInsuranceGroup.Title
        FROM    dbo.DimInsurance
                INNER JOIN dbo.DimInsuranceGroup ON dbo.DimInsurance.InsuranceGroupId = dbo.DimInsuranceGroup.Id
        WHERE   dbo.DimInsurance.Id = @Id;

        SELECT  dbo.DimInsurance.* ,
                GroupTitle = dbo.DimInsuranceGroup.Title
        FROM    dbo.DimInsurance
                INNER JOIN dbo.DimInsuranceGroup ON dbo.DimInsurance.InsuranceGroupId = dbo.DimInsuranceGroup.Id
        WHERE   dbo.DimInsurance.[NewId] = @Id;
    END;
GO
