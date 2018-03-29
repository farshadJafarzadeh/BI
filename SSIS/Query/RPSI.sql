USE RPSIDW;
GO

INSERT dbo.DimSystem
(
    Title,
    OldId
)
SELECT Title,
       Id
FROM Rpsi.Pharmacy.Systems;

GO


INSERT dbo.DimFinancialYear
(
    SystemId,
    Title,
    OldId
)
SELECT DimSystem.Id,
       FinancialYears.Title,
       FinancialYears.Id
FROM Rpsi.Pharmacy.FinancialYears
    INNER JOIN dbo.DimSystem
        ON dbo.DimSystem.OldId = FinancialYears.SystemId;


GO


INSERT dbo.DimInsuranceGroup
(
    Title,
    OldId
)
SELECT Title,
       Id
FROM Rpsi.Pharmacy.InsuranceGroups;


GO


INSERT dbo.DimInsurance
(
    InsuranceGroupId,
    Title,
    OldId
)
SELECT dbo.DimInsuranceGroup.Id,
       Insurances.Title,
       Insurances.Id
FROM Rpsi.Pharmacy.Insurances
    INNER JOIN dbo.DimInsuranceGroup
        ON dbo.DimInsuranceGroup.OldId = Insurances.InsuranceGroupId;


GO


INSERT dbo.DimProductGroup
SELECT ProductGroups.Title,
       ProductGroups.Id
FROM Rpsi.InventoryBasics.ProductGroups;


GO



INSERT dbo.DimProduct
(
    ProductGroupId,
    Code,
    Title,
    OldId
)
SELECT dbo.DimProductGroup.Id,
       Products.Code,
       Products.Title,
       Products.Id
FROM Rpsi.InventoryBasics.Products
    INNER JOIN dbo.DimProductGroup
        ON dbo.DimProductGroup.OldId = Products.ProductGroupId;


GO


INSERT dbo.FactHeader
(
    FinancialYearId,
    InsuranceId,
    [Type],
    Title,
    OldId,
    InsertedDate,
    InsertedTime
)
SELECT NewFinancialYears.Id,
       NewInsurances.Id,
       CASE
           WHEN PrescriptionHeaders.OutputSheetLess = 1 THEN
               'Ã«Ìê–«—Ì ‘œÂ'
           ELSE
               '⁄«œÌ'
       END,
       PrescriptionHeaders.SystemNumber,
       PrescriptionHeaders.Id,
       REPLACE(CONVERT(VARCHAR(10), PrescriptionHeaders.InsertedDate, 111), '/', ''),
       CAST(PrescriptionHeaders.InsertedDate AS TIME)
FROM Rpsi.Pharmacy.PrescriptionHeaders
    INNER JOIN dbo.DimFinancialYear AS NewFinancialYears
        ON NewFinancialYears.OldId = PrescriptionHeaders.FinancialYearId
    INNER JOIN dbo.DimInsurance AS NewInsurances
        ON NewInsurances.OldId = Rpsi.Pharmacy.PrescriptionHeaders.InsuranceId;
GO


INSERT dbo.FactDetail
(
    HeaderId,
    Type,
    ProductId,
    Quantity,
    Price,
    InsurancePercent,
    InsurancePrice,
    InsuranceShare,
    PatientShare,
    AddFee,
    TotalFullCost,
    OldId,
    InsertedDate,
    InsertedTime
)
SELECT dbo.FactHeader.Id,
       CASE
           WHEN PrescriptionDetails.Flag = 0 THEN
               'Õﬁ ›‰Ì'
           WHEN PrescriptionDetails.Flag = 1
                AND (PrescriptionDetails.IsReference = 1) THEN
               '„‘«»Â ‘œÂ'
           WHEN PrescriptionDetails.ReferenceId IS NOT NULL THEN
               '„‘«»Â'
           ELSE
               '⁄«œÌ'
       END,
       dbo.DimProduct.Id,
       PrescriptionDetails.Quantity,
       Rpsi.Pharmacy.PrescriptionDetails.Price,
       InsurancePercent,
       InsurancePrice,
       InsuranceShare,
       PatientShare,
       AddFee,
       vwFullCost.SumFullCost,
       Rpsi.Pharmacy.PrescriptionDetails.Id,
       REPLACE(CONVERT(VARCHAR(10), PrescriptionDetails.InsertedDate, 111), '/', ''),
       CAST(PrescriptionDetails.InsertedDate AS TIME)
FROM Rpsi.Pharmacy.PrescriptionDetails
    INNER JOIN Rpsi.Inventory.vwFullCost
        ON vwFullCost.OutputSheetDetailId = PrescriptionDetails.OutputSheetDetailId
    INNER JOIN dbo.FactHeader
        ON FactHeader.Id = Rpsi.Pharmacy.PrescriptionDetails.HeaderId
    INNER JOIN dbo.DimProduct
        ON DimProduct.OldId = PrescriptionDetails.ProductId;


