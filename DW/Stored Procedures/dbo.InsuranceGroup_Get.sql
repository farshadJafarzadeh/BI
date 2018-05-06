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

        SELECT  *
        FROM    dbo.DimInsuranceGroup
        WHERE   [NewId] = @Id;

    END;

GO
