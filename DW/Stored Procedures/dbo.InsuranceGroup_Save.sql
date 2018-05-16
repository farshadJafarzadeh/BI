SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[InsuranceGroup_Save]
    @Id INT NULL = NULL ,
    @SelectedGroupIds [Core].[IntArray] READONLY ,
    @Title NVARCHAR(MAX)
AS
    BEGIN

        DECLARE @Type INT;
        SELECT TOP ( 1 )
                @Type = VCDIG.Type
        FROM    dbo.ViewCatDimInsuranceGroup AS VCDIG
        WHERE   VCDIG.id = @Id;
        IF @Type = 0
            OR @Id IS NULL
            BEGIN
                DECLARE @InsertedId INT ,
                    @DbId INT;

                SELECT TOP 1
                        @DbId = Id
                FROM    dbo.dimdb
                WHERE   Name = 'BI';


                INSERT  INTO [dbo].[DimInsuranceGroup]
                VALUES  ( @Title, @DbId, NULL, NULL );
                SET @InsertedId = SCOPE_IDENTITY();

                UPDATE  [dbo].[DimInsuranceGroup]
                SET     [dbo].[DimInsuranceGroup].[NewId] = @InsertedId
                FROM    [dbo].[DimInsuranceGroup]
                        INNER JOIN @SelectedGroupIds ON [@SelectedGroupIds].[Item] = [dbo].[DimInsuranceGroup].Id;
                SELECT  @InsertedId;
            END;
        ELSE
            BEGIN
                UPDATE  [dbo].[DimInsuranceGroup]
                SET     [NewId] = @Id
                FROM    [dbo].[DimInsuranceGroup]
                        INNER JOIN @SelectedGroupIds ON [@SelectedGroupIds].[Item] = [dbo].[DimInsuranceGroup].[Id];

                UPDATE  [dbo].[DimInsuranceGroup]
                SET     [NewId] = NULL
                FROM    [dbo].[DimInsuranceGroup]
                        INNER JOIN ( SELECT *
                                     FROM   [dbo].[DimInsuranceGroup]
                                            LEFT JOIN @SelectedGroupIds ON [@SelectedGroupIds].[Item] = [dbo].[DimInsuranceGroup].[Id]
                                     WHERE  [dbo].[DimInsuranceGroup].[NewId] = @Id
                                            AND Item IS NULL
                                   ) Removeds ON [Removeds].Id = [dbo].[DimInsuranceGroup].Id;
                UPDATE  [dbo].[DimInsuranceGroup]
                SET     [Title] = @Title
                FROM    [dbo].[DimInsuranceGroup]
                WHERE   Id = @Id;

                SELECT  @Id;

            END;

        

    END;


GO
