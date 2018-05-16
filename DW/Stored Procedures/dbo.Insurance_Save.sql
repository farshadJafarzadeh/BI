SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[Insurance_Save]
    @Id INT NULL = NULL ,
    @SelectedGroupIds [Core].[IntArray] READONLY ,
    @Title NVARCHAR(MAX) ,
    @Code INT ,
    @InsuranceGroupId INT
AS
    BEGIN
        DECLARE @InsertedId INT ,
            @DbId INT ,
            @NotInSameGroup INT ,
            @Type BIT;


			

        SELECT  @NotInSameGroup = COUNT(1)
        FROM    dbo.diminsurance
                INNER JOIN @SelectedGroupIds ON [@SelectedGroupIds].Item = dbo.diminsurance.Id
                LEFT JOIN ( SELECT  Id
                            FROM    dbo.diminsurancegroup
                            WHERE   newId = @InsuranceGroupId
                          ) GroupedInsuranceGroup ON dbo.diminsurance.Insurancegroupid = [GroupedInsuranceGroup].Id
        WHERE   GroupedInsuranceGroup.Id IS NULL;


        IF @NotInSameGroup > 0
            SELECT  -1; 
        ELSE
            BEGIN
                SELECT TOP 1
                        @DbId = Id
                FROM    dbo.dimDb
                WHERE   Name = 'BI';


                SELECT  @Type = viewcatdiminsurance.Type
                FROM    diminsurance
                        LEFT JOIN viewdiminsurance ON diminsurance.Id = viewdiminsurance.Id
                        LEFT JOIN viewcatdiminsurance ON viewcatdiminsurance.Id = viewdiminsurance.newid
                WHERE   diminsurance.id = @Id;


                IF @Type = 0
                    OR @Id IS NULL
                    BEGIN
                        INSERT  INTO [dbo].[DimInsurance]
                        VALUES  ( @InsuranceGroupId, @Code, @Title, @DbId,
                                  NULL, NULL );
                        SET @InsertedId = SCOPE_IDENTITY();

                        UPDATE  [dbo].[DimInsurance]
                        SET     [dbo].[DimInsurance].[NewId] = @InsertedId
                        FROM    [dbo].[DimInsurance]
                                INNER JOIN @SelectedGroupIds ON [@SelectedGroupIds].[Item] = [dbo].[DimInsurance].Id;
                        SELECT  @InsertedId;
                    END;
                ELSE
                    BEGIN
                        UPDATE  [dbo].[DimInsurance]
                        SET     [NewId] = @Id
                        FROM    [dbo].[DimInsurance]
                                INNER JOIN @SelectedGroupIds ON [@SelectedGroupIds].[Item] = [dbo].[DimInsurance].[Id];

                        UPDATE  [dbo].[DimInsurance]
                        SET     [NewId] = NULL
                        FROM    [dbo].[DimInsurance]
                                INNER JOIN ( SELECT *
                                             FROM   [dbo].[DimInsurance]
                                                    LEFT JOIN @SelectedGroupIds ON [@SelectedGroupIds].[Item] = [dbo].[DimInsurance].[Id]
                                             WHERE  [dbo].[DimInsurance].[NewId] = @Id
                                                    AND Item IS NULL
                                           ) Removeds ON [Removeds].Id = [dbo].[DimInsurance].Id;
                        UPDATE  [dbo].[DimInsurance]
                        SET     [Title] = @Title ,
                                InsuranceGroupId = @InsuranceGroupId ,
                                Code = @Code
                        FROM    [dbo].[DimInsurance]
                        WHERE   Id = @Id;

                        SELECT  @Id;

                    END;

        

            END;
    END;


GO
