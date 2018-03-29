USE [Rpsi]
GO
/****** Object:  StoredProcedure [Pharmacy].[Prescription_CalculateHeaderFromDetail]    Script Date: 3/29/2018 12:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [Pharmacy].[Prescription_CalculateHeaderFromDetail]
	--@ActionOnInsuranceStuffs bit,
    @HeaderId INT ,
    @OperationSourceId INT NULL = NULL ,
    @CashSystemFinancialYearId INT ,
    @SystemNumber INT ,
    @DateTime DATETIME ,
    @FreeInsuranceId INT ,
    @InsuranceId INT ,
    @PreInsurancePercent REAL ,
    @PrevFreeTechnicalFeeDetailId INT NULL = NULL ,
    @NeedInsuranceApproval BIT OUT ,
    @UserId INT ,
    @RoundPriceBase INT ,
    @SystemId INT ,
    @SystemTypeId INT ,
    @OwnerId INT
AS
    BEGIN
	DECLARE @Getdate DATETIME;
        SET @Getdate = GETDATE();

        DECLARE @ProductId INT ,
            @ProductCode INT ,
            @ProductTitle [NVARCHAR](150) ,
            @ProductPhysicianLevelIsLow BIT ,
            @FreeTechnicalFeeDetailId INT ,
            @InsuranceTechnicalFeeDetailId INT ,
            @Price REAL= 0 ,
            @GenericCode INT ,
            @InsurancePrice REAL= 0 ,
            @InsurancePercent REAL= 0 ,
            @SumTotalPrice REAL= 0 ,
            @SumTotalInsurancePrice REAL= 0 ,
            @SumPureTotalPrice REAL= 0 ,
            @SumPureTotalInsurancePrice REAL= 0 ,
            @PayablePrice REAL= 0 ,
            @AddFee REAL= 0 ,
            @InsuranceApprovedBy INT ,
            @InsuranceApprovedByFullName NVARCHAR(150) ,
            @InsuranceApprovedDate DATETIME ,
            @Locked BIT ,
            @FirstName NVARCHAR(150) = NULL ,
            @LastName NVARCHAR(150) = NULL;

        SELECT  @Locked = Locked
        FROM    Cash.OperationSources
        WHERE   Id = @OperationSourceId;


        SELECT  @SumTotalPrice = SUM(CASE WHEN HasIncludeTechnicalFee = 1
                                               AND IsReference != 1
                                          THEN TotalPrice
                                          ELSE 0
                                     END) ,
                @SumTotalInsurancePrice = SUM(CASE WHEN HasIncludeTechnicalFee = 1
                                                   THEN TotalInsurancePrice
                                                   ELSE 0
                                              END) ,
                @SumPureTotalPrice = SUM(CASE WHEN IsReference != 1
                                              THEN TotalPrice
                                              ELSE 0
                                         END) ,
                @SumPureTotalInsurancePrice = SUM(TotalInsurancePrice)
        FROM    [Pharmacy].[PrescriptionDetails]
        WHERE   [PrescriptionDetails].[HeaderId] = @HeaderId
                AND [PrescriptionDetails].[Flag] = 1
                AND IsReference = 0;
        IF ( @SumTotalPrice = 0 )
            SET @SumTotalPrice = NULL;

        IF ( @SumPureTotalPrice = 0 )
            SET @SumPureTotalPrice = NULL;

        IF ( @SumTotalPrice = 0
             AND @SumTotalInsurancePrice > 0
           )
            BEGIN
                SET @SumTotalPrice = @SumTotalInsurancePrice;
            END;

        IF ( @SumPureTotalPrice = 0
             AND @SumPureTotalInsurancePrice > 0
           )
            BEGIN
                SET @SumPureTotalPrice = @SumPureTotalInsurancePrice;
            END;
		
        EXEC [Pharmacy].[InsuranceTechnicalFee_SearchPrice] @DateTime = @DateTime,
            @FreeInsuranceId = @FreeInsuranceId, @InsuranceId = @InsuranceId,
            @SystemTypeId = @SystemTypeId,
            @PreInsurancePercent = @PreInsurancePercent,
            @SumPrice = @SumTotalPrice,
            @SumInsurancePrice = @SumTotalInsurancePrice,
            @ProductId = @ProductId OUT,
            @FreeTechnicalFeeDetailId = @FreeTechnicalFeeDetailId OUT,
            @InsuranceTechnicalFeeDetailId = @InsuranceTechnicalFeeDetailId OUT,
            @Price = @Price OUT, @InsurancePrice = @InsurancePrice OUT,
            @InsurancePercent = @InsurancePercent OUT;


			
		
        IF ( @InsurancePercent = 0 )
            SET @InsurancePrice = 0;
		
        SELECT TOP ( 1 )
                @ProductId = Id ,
                @ProductCode = Code ,
                @ProductTitle = [Products].[Title] ,
                @GenericCode = GenericCode
        FROM    InventoryBasics.[Products]
        WHERE   [Products].[Id] = @ProductId
                AND [IsDeleted] = 0;

        SET @AddFee = ( @Price - @InsurancePrice );

        IF ( @AddFee IS NULL
             OR @AddFee < 0
           )
            SET @AddFee = 0;

			--HEAR 
        IF ( @InsurancePrice > @Price )
            BEGIN
                SET @Price = @InsurancePrice;
                SET @AddFee = 0;
            END; 

        IF @PrevFreeTechnicalFeeDetailId IS NULL
            AND @SumTotalPrice > 0
            BEGIN
                INSERT  INTO [Pharmacy].[PrescriptionDetails]
                        ( [HeaderId] ,
                          [RowNumber] ,
                          [HasIncludeTechnicalFee] ,
                          [ProductId] ,
                          [ProductCode] ,
                          [ProductTitle] ,
                          [Quantity] ,
                          [IsManualInsuranceInValid] ,
                          [IsManualInsuranceValid] ,
                          [ProductPriceDetailId] ,
                          [Price] ,
                          [DrugInsurancePriceDetailId] ,
                          [GenericCode] ,
                          [InsurancePrice] ,
                          [InsurancePercent] ,
                          [AddFee] ,
                          [TotalAddFee] ,
                          [Description] ,
                          [Flag] ,
                          [ActionBy] ,
                          [ActionDate],
						  InsertedDate
                        )
                VALUES  ( @HeaderId ,
                          1 ,
                          0 ,
                          @ProductId ,
                          @ProductCode ,
                          @ProductTitle ,
                          1 ,
                          0 ,
                          0 ,
                          NULL ,
                          @Price ,
                          NULL ,
                          @GenericCode ,
                          @InsurancePrice ,
                          @InsurancePercent ,
                          @AddFee ,
                          @AddFee ,
                          NULL ,
                          0 --technicalFee
                          ,
                          @UserId ,
                          @GETDATE,
						  @GETDATE
                        );
            END;
        ELSE
            IF @SumTotalPrice > 0
                BEGIN
                    UPDATE  [Pharmacy].[PrescriptionDetails]
                    SET     [ProductId] = @ProductId ,
                            [ProductCode] = @ProductCode ,
                            [ProductTitle] = @ProductTitle ,
                            [Price] = @Price ,
                            [InsurancePrice] = @InsurancePrice ,
                            [InsurancePercent] = @InsurancePercent ,
                            [AddFee] = @AddFee ,
                            [TotalAddFee] = @AddFee ,
                            [ActionBy] = @UserId ,
                            [ActionDate] = @GETDATE
                    WHERE   HeaderId = @HeaderId
                            AND [Flag] = 0;
                END;
            ELSE
                BEGIN
                    --UPDATE  [Pharmacy].[PrescriptionDetails]
                    --SET     [ActionBy] = @UserId ,
                    --        [ActionDate] = GETDATE()
                    --WHERE    HeaderId = @HeaderId
                    --        AND [Flag] = 0;

                    DELETE  [Pharmacy].[PrescriptionDetails]
                    WHERE   HeaderId = @HeaderId
                            AND [Flag] = 0;
                END;

        IF ( @Price IS NULL )
            SET @Price = 0;

        IF ( @InsurancePrice IS NULL )
            SET @InsurancePrice = 0;

        SET @SumTotalPrice = @SumTotalPrice + @Price;
        SET @SumTotalInsurancePrice = @SumTotalInsurancePrice
            + @InsurancePrice;


        SET @SumPureTotalPrice = @SumPureTotalPrice + @Price;
        SET @SumPureTotalInsurancePrice = @SumPureTotalInsurancePrice
            + @InsurancePrice;


		

        SELECT  @PayablePrice = [Pharmacy].[Prescription_GetPayablePrice](@HeaderId,
                                                              @RoundPriceBase);


        SELECT  @NeedInsuranceApproval = CASE WHEN @SumPureTotalInsurancePrice > [PrescriptionHeaders].[InsuranceApproveLimitationPrice]
                                              THEN 1
                                              ELSE 0
                                         END ,
                @InsuranceApprovedBy = InsuranceApprovedBy ,
                @InsuranceApprovedByFullName = InsuranceApprovedByFullName ,
                @InsuranceApprovedDate = InsuranceApprovedDate ,
                @FirstName = FirstName ,
                @LastName = LastName
        FROM    [Pharmacy].[PrescriptionHeaders]
        WHERE   [PrescriptionHeaders].[Id] = @HeaderId;

        IF ( @NeedInsuranceApproval = 1 )
            BEGIN
                SET @InsuranceApprovedBy = NULL;
                SET @InsuranceApprovedByFullName = NULL;
                SET @InsuranceApprovedDate = NULL;
            END;

        IF ( @Locked = 1
             OR @NeedInsuranceApproval = 1
           )
            BEGIN
                SET @Locked = 1;
            END;
        ELSE
            BEGIN
                SET @Locked = 0;
            END;

        EXEC [Cash].[OperationSource_Create] @Id = @OperationSourceId OUTPUT,
            @SystemFinancialYearId = @CashSystemFinancialYearId,
            @Number = @SystemNumber, @Value = @PayablePrice, @UserId = @UserId,
            @OwnerId = @OwnerId, @IgnoreSelect = 1, @locked = @Locked,
            @FirstName = @FirstName, @LastName = @LastName;


		--IF @ActionOnInsuranceStuffs=1 
        UPDATE  [PrescriptionHeaders]
        SET     [FreeTechnicalFeeDetailId] = @FreeTechnicalFeeDetailId ,
                [TechnicalFeeDetailId] = @InsuranceTechnicalFeeDetailId ,
                [NeedInsuranceApproval] = @NeedInsuranceApproval ,
                [InsuranceApprovedBy] = @InsuranceApprovedBy ,
                [InsuranceApprovedByFullName] = @InsuranceApprovedByFullName ,
                [InsuranceApprovedDate] = @InsuranceApprovedDate ,
                OperationSourceId = @OperationSourceId
        FROM    [Pharmacy].[PrescriptionHeaders]
        WHERE   [PrescriptionHeaders].[Id] = @HeaderId;


        RETURN;

    END;
