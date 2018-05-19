SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[InsuranceGroup_Get] @Id INT
AS
    BEGIN
        SELECT  *
        FROM    dbo.DimInsuranceGroup
        WHERE   Id = @Id;

        SELECT  DIG.* ,
                VCDIG.DbTitle
        FROM    dbo.ViewCatDimInsuranceGroup AS VCDIG
                INNER JOIN dbo.ViewDimInsuranceGroup AS VDIG ON VDIG.NewId = VCDIG.Id
                INNER JOIN dbo.DimInsuranceGroup AS DIG ON DIG.Id = VDIG.Id
        WHERE   VCDIG.Id = @Id;


    END;

GO
