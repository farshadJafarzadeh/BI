USE RPSIDW;
BEGIN TRAN;

INSERT dbo.DimDB
(
    [Name]
)
VALUES
(N'RPSI' -- Name - nvarchar(50)
    );

INSERT dbo.DimOwner
(
    Name,
    ParentId,
    OldId
)
SELECT Name,
       ParentId,
       Id
FROM Rpsi.Core.Owners;

INSERT dbo.DimUser
(
    UserName,
    FirstName,
    LastName,
    OwnerId,
    DBId,
    OldId
)
SELECT Users.UserName,
       Users.FirstName,
       Users.LastName,
       DimOwner.Id,
       DimDB.Id,
       Users.Id
FROM Rpsi.Core.Users
    INNER JOIN dbo.DimOwner
        ON DimOwner.OldId = Users.OwnerId
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';

INSERT dbo.DimSystem
(
    Title,
    OwnerId,
    DBId,
    OldId
)
SELECT Systems.Title,
       DimOwner.Id,
       dbo.DimDB.Id,
       Systems.Id
FROM Rpsi.Pharmacy.Systems
    INNER JOIN dbo.DimOwner
        ON DimOwner.OldId = Systems.OwnerId
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';

INSERT dbo.DimFinancialYear
(
    SystemId,
    Title,
    DBId,
    OldId
)
SELECT DimSystem.Id,
       FinancialYears.Title,
       dbo.DimDB.Id,
       FinancialYears.Id
FROM Rpsi.Pharmacy.FinancialYears
    INNER JOIN dbo.DimSystem
        ON dbo.DimSystem.OldId = FinancialYears.SystemId
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';

INSERT dbo.DimInsuranceGroup
(
    Title,
    DBId,
    OldId
)
SELECT InsuranceGroups.Title,
       dbo.DimDB.Id,
       InsuranceGroups.Id
FROM Rpsi.Pharmacy.InsuranceGroups
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';

INSERT dbo.DimInsurance
(
    InsuranceGroupId,
    Code,
    Title,
    DBId,
    OldId
)
SELECT dbo.DimInsuranceGroup.Id,
       InsuranceCode,
       Insurances.Title,
       dbo.DimDB.Id,
       Insurances.Id
FROM Rpsi.Pharmacy.Insurances
    INNER JOIN Rpsi.Pharmacy.InsuranceContracts
        ON InsuranceContracts.InsuranceId = Insurances.Id
    INNER JOIN dbo.DimInsuranceGroup
        ON dbo.DimInsuranceGroup.OldId = Insurances.InsuranceGroupId
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI'
      AND SystemId = 1;


INSERT dbo.DimPhysicianLevel
(
    Title,
    Level,
    DBId,
    OldId
)
SELECT Title,
       Level,
       DimDB.Id,
       PL.Id
FROM Rpsi.Medical.PhysicianLevels AS PL
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';

INSERT dbo.DimPhysicianSpeciality
(
    PhysicianLevelId,
    Title,
    DBId,
    OldId
)
SELECT DPL.Id,
       PS.Title,
       DD.Id,
       PS.Id
FROM Rpsi.Medical.PhysicianSpecialities AS PS
    INNER JOIN Rpsi.Medical.PhysicianLevels AS PL
        ON PL.Id = PS.PhysicianLevelId
    INNER JOIN dbo.DimPhysicianLevel AS DPL
        ON DPL.OldId = PL.Id
    INNER JOIN dbo.DimDB AS DD
        ON DD.Id = DPL.DBId
WHERE DD.[Name] = N'RPSI';


INSERT dbo.DimPhysician
(
    PhysicianSpecialityId,
    FirstName,
    LastName,
    MedicalCouncilCode,
    IsResident,
    Sex,
    DBId,
    OldId
)
SELECT DPS.Id,
       P.FirstName,
       P.LastName,
       P.MedicalCouncilCode,
       P.IsResident,
       P.Sex,
       DD.Id,
       P.Id
FROM Rpsi.Medical.Physicians AS P
    INNER JOIN Rpsi.Medical.PhysicianSpecialities AS PS
        ON PS.Id = P.PhysicianSpecialityId
    INNER JOIN dbo.DimPhysicianSpeciality AS DPS
        ON DPS.OldId = PS.Id
    INNER JOIN dbo.DimDB AS DD
        ON DD.Id = DPS.DBId
WHERE DD.[Name] = N'RPSI';

INSERT dbo.DimProductGroup
(
    Title,
    OwnerId,
    DBId,
    OldId
)
SELECT ProductGroups.Title,
       dbo.DimOwner.Id,
       dbo.DimDB.Id,
       ProductGroups.Id
FROM Rpsi.InventoryBasics.ProductGroups
    INNER JOIN dbo.DimOwner
        ON DimOwner.OldId = ProductGroups.OwnerId
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';

INSERT dbo.DimProduct
(
    ProductGroupId,
    Code,
    Title,
    DBId,
    OldId
)
SELECT dbo.DimProductGroup.Id,
       Products.Code,
       Products.Title,
       dbo.DimDB.Id,
       Products.Id
FROM Rpsi.InventoryBasics.Products
    INNER JOIN dbo.DimProductGroup
        ON dbo.DimProductGroup.OldId = Products.ProductGroupId
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';

INSERT dbo.FactHeader
(
    FinancialYearId,
    InsuranceId,
    PhysicianId,
    Type,
    Number,
    CompletedRowNumber,
    ReceptionDate,
    ReceptionTime,
    PrescriptionDate,
    CreditDate,
    InsertedBy,
    InsertedDate,
    InsertedTime,
    AdmissionBy,
    AdmissionDate,
    AdmissionTime,
    InsuranceApprovedBy,
    InsuranceApprovedDate,
    InsuranceApprovedTime,
    PickedUpBy,
    PickedUpDate,
    PickedUpTime,
    DeliveredBy,
    DeliveredDate,
    DeliveredTime,
    AuthorizedBy,
    AuthorizedDate,
    AuthorizedTime,
    Value,
    Paid,
    Locked,
    DBId,
    OldId
)
SELECT DimFinancialYear.Id,
       DimInsurance.Id,
       DP.Id,
       CASE
           WHEN Rpsi.Pharmacy.PrescriptionHeaders.OutputSheetLess = 1 THEN
               N'Ã«Ìê–«—Ì ‘œÂ'
           ELSE
               N'⁄«œÌ'
       END,
       Rpsi.Pharmacy.PrescriptionHeaders.SystemNumber,
       Rpsi.Pharmacy.PrescriptionHeaders.CompletedRowNumber,
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionHeaders.ReceptionDateTime),
       CAST(Rpsi.Pharmacy.PrescriptionHeaders.ReceptionDateTime AS TIME),
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionHeaders.PrescriptionDate),
       dbo.NotMoreThanINT(dbo.DateToInt(Rpsi.Pharmacy.PrescriptionHeaders.CreditDate),20291231),
       DimUserInsert.Id,
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionHeaders.InsertedDate),
       CAST(Rpsi.Pharmacy.PrescriptionHeaders.InsertedDate AS TIME),
       DimUserAdmission.Id,
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionHeaders.AdmissionDate),
       CAST(Rpsi.Pharmacy.PrescriptionHeaders.AdmissionDate AS TIME),
       DimUserInsuranceApprove.Id,
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionHeaders.InsuranceApprovedDate),
       CAST(Rpsi.Pharmacy.PrescriptionHeaders.InsuranceApprovedDate AS TIME),
       DimUserPickUp.Id,
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionHeaders.PickedUpDate),
       CAST(Rpsi.Pharmacy.PrescriptionHeaders.PickedUpDate AS TIME),
       DimUserDeliver.Id,
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionHeaders.DeliveredDate),
       CAST(Rpsi.Pharmacy.PrescriptionHeaders.DeliveredDate AS TIME),
       DimUserAuthorize.Id,
       dbo.DateToInt(Rpsi.Cash.OperationSources.AuthorizedDate),
       CAST(Rpsi.Cash.OperationSources.AuthorizedDate AS TIME),
       Rpsi.Cash.OperationSources.Value,
       Rpsi.Cash.OperationSources.Paid,
       Rpsi.Cash.OperationSources.Locked,
       dbo.DimDB.Id,
       Rpsi.Pharmacy.PrescriptionHeaders.Id
FROM Rpsi.Pharmacy.PrescriptionHeaders
    INNER JOIN dbo.DimFinancialYear
        ON DimFinancialYear.OldId = Rpsi.Pharmacy.PrescriptionHeaders.FinancialYearId
    INNER JOIN dbo.DimInsurance
        ON DimInsurance.OldId = Rpsi.Pharmacy.PrescriptionHeaders.InsuranceId
    LEFT JOIN dbo.DimPhysician AS DP
        ON Rpsi.Pharmacy.PrescriptionHeaders.PhysicianId = DP.Id
    INNER JOIN
    (
        SELECT HeaderId,
               Id = MIN(Id)
        FROM Rpsi.Pharmacy.PrescriptionTransactions
        GROUP BY HeaderId
    ) MinTransactions
        ON MinTransactions.HeaderId = Rpsi.Pharmacy.PrescriptionHeaders.Id
    INNER JOIN Rpsi.Pharmacy.PrescriptionTransactions
        ON PrescriptionTransactions.Id = MinTransactions.Id
    INNER JOIN dbo.DimUser AS DimUserInsert
        ON DimUserInsert.OldId = Rpsi.Pharmacy.PrescriptionTransactions.ActionBy
    INNER JOIN dbo.DimUser AS DimUserAdmission
        ON DimUserAdmission.OldId = Rpsi.Pharmacy.PrescriptionHeaders.AdmissionById
    LEFT JOIN dbo.DimUser AS DimUserInsuranceApprove
        ON DimUserInsuranceApprove.OldId = Rpsi.Pharmacy.PrescriptionHeaders.InsuranceApprovedBy
    LEFT JOIN dbo.DimUser AS DimUserPickUp
        ON DimUserPickUp.OldId = Rpsi.Pharmacy.PrescriptionHeaders.PickedUpById
    LEFT JOIN dbo.DimUser AS DimUserDeliver
        ON DimUserDeliver.OldId = Rpsi.Pharmacy.PrescriptionHeaders.DeliveredById
    INNER JOIN Rpsi.Cash.OperationSources
        ON Rpsi.Cash.OperationSources.Id = Rpsi.Pharmacy.PrescriptionHeaders.OperationSourceId
    LEFT JOIN dbo.DimUser AS DimUserAuthorize
        ON DimUserAuthorize.OldId = Rpsi.Cash.OperationSources.AuthorizedBy
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';


INSERT dbo.FactDetail
(
    HeaderId,
    --DetailId,
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
    InsertedBy,
    InsertedDate,
    InsertedTime,
    DBId,
    OldId
)
SELECT dbo.FactHeader.Id,
       CASE
           WHEN PrescriptionDetails.Flag = 0 THEN
               N'Õﬁ ›‰Ì'
           WHEN PrescriptionDetails.Flag = 1
                AND (PrescriptionDetails.IsReference = 1) THEN
               N'„‘«»Â ‘œÂ'
           WHEN PrescriptionDetails.ReferenceId IS NOT NULL THEN
               N'„‘«»Â'
           ELSE
               N'⁄«œÌ'
       END,
       dbo.DimProduct.Id,
       Rpsi.Pharmacy.PrescriptionDetails.Quantity,
       Rpsi.Pharmacy.PrescriptionDetails.Price,
       Rpsi.Pharmacy.PrescriptionDetails.InsurancePercent,
       Rpsi.Pharmacy.PrescriptionDetails.InsurancePrice,
       Rpsi.Pharmacy.PrescriptionDetails.InsuranceShare,
       Rpsi.Pharmacy.PrescriptionDetails.PatientShare,
       Rpsi.Pharmacy.PrescriptionDetails.AddFee,
       vwFullCost.SumFullCost,
       FactHeader.InsertedBy,
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionDetails.InsertedDate),
       CAST(Rpsi.Pharmacy.PrescriptionDetails.InsertedDate AS TIME),
       dbo.DimDB.Id,
       Rpsi.Pharmacy.PrescriptionDetails.Id
FROM Rpsi.Pharmacy.PrescriptionDetails
    LEFT JOIN Rpsi.Inventory.vwFullCost
        ON vwFullCost.OutputSheetDetailId = PrescriptionDetails.OutputSheetDetailId
    INNER JOIN dbo.FactHeader
        ON FactHeader.OldId = Rpsi.Pharmacy.PrescriptionDetails.HeaderId
    INNER JOIN dbo.DimProduct
        ON DimProduct.OldId = PrescriptionDetails.ProductId
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';


UPDATE dbo.FactDetail
SET DetailId = FactDetailReference.Id
FROM dbo.FactDetail
    INNER JOIN Rpsi.Pharmacy.PrescriptionDetails AS PrescriptionDetailsHasReferenceId
        ON PrescriptionDetailsHasReferenceId.Id = FactDetail.OldId
    INNER JOIN Rpsi.Pharmacy.PrescriptionDetails AS PrescriptionDetailsReference
        ON PrescriptionDetailsReference.Id = PrescriptionDetailsHasReferenceId.ReferenceId
    INNER JOIN dbo.FactDetail AS FactDetailReference
        ON FactDetailReference.OldId = PrescriptionDetailsReference.Id
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI'
      AND PrescriptionDetailsHasReferenceId.ReferenceId IS NOT NULL;



INSERT dbo.FactTransaction
(
    HeaderId,
    Action,
    ActionBy,
    ActionDate,
    ActionTime,
    DBId,
    OldId
)
SELECT FactHeader.Id,
       Rpsi.Pharmacy.PrescriptionTransactions.Action,
       DimUser.Id,
       dbo.DateToInt(Rpsi.Pharmacy.PrescriptionTransactions.ActionDate),
       CAST(Rpsi.Pharmacy.PrescriptionTransactions.ActionDate AS TIME),
       dbo.DimDB.Id,
       Rpsi.Pharmacy.PrescriptionTransactions.Id
FROM Rpsi.Pharmacy.PrescriptionTransactions
    INNER JOIN dbo.FactHeader
        ON FactHeader.OldId = Rpsi.Pharmacy.PrescriptionTransactions.HeaderId
    INNER JOIN dbo.DimUser
        ON DimUser.OldId = Rpsi.Pharmacy.PrescriptionTransactions.ActionBy
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';



INSERT dbo.DimOperationType
(
    Code,
    Title,
    IsWarrant,
    IsDebt,
    OwnerId,
    DBId,
    OldId
)
SELECT Rpsi.Cash.OperationTypes.Code,
       Rpsi.Cash.OperationTypes.Title,
       Rpsi.Cash.OperationTypes.IsWarrant,
       Rpsi.Cash.OperationTypes.IsDebt,
       dbo.DimOwner.Id,
       dbo.DimDB.Id,
       Rpsi.Cash.OperationTypes.Id
FROM Rpsi.Cash.OperationTypes
    INNER JOIN dbo.DimOwner
        ON DimOwner.OldId = Rpsi.Cash.OperationTypes.OwnerId
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI'
      AND ReferenceId IS NULL;

INSERT dbo.FactOperation
(
    HeaderId,
    OperationTypeId,
    OperationValue,
    AuthorizedBy,
    AuthorizedDate,
    AuthorizedTime,
    ActionBy,
    ActionDate,
    ActionTime,
    DBId,
    OldId
)
SELECT FactHeader.Id,
       DimOperationType.Id,
       Rpsi.Cash.Operations.OperationValue,
       DimUserAuthorize.Id,
       dbo.DateToInt(Rpsi.Cash.Operations.AuthorizedDate),
       CAST(Rpsi.Cash.Operations.AuthorizedDate AS TIME),
       DimUserAction.OldId,
       dbo.DateToInt(Rpsi.Cash.Operations.ActionDate),
       CAST(Rpsi.Cash.Operations.ActionDate AS TIME),
       dbo.DimDB.Id,
       Operations.Id
FROM Rpsi.Cash.Operations
    INNER JOIN Rpsi.Cash.OperationSources
        ON Rpsi.Cash.OperationSources.Id = Rpsi.Cash.Operations.OperationSourceId
    INNER JOIN Rpsi.Pharmacy.PrescriptionHeaders
        ON Rpsi.Pharmacy.PrescriptionHeaders.OperationSourceId = Rpsi.Cash.OperationSources.Id
    INNER JOIN dbo.FactHeader
        ON FactHeader.OldId = Rpsi.Pharmacy.PrescriptionHeaders.Id
    INNER JOIN Rpsi.Cash.OperationTypes
        ON Rpsi.Cash.OperationTypes.Id = Rpsi.Cash.Operations.OperationTypeId
    LEFT JOIN Rpsi.Cash.OperationTypes AS OperationTypesMaster
        ON OperationTypesMaster.Id = Rpsi.Cash.OperationTypes.ReferenceId
    INNER JOIN DimOperationType
        ON Rpsi.Cash.OperationTypes.Id = DimOperationType.OldId
           OR Rpsi.Cash.OperationTypes.ReferenceId = DimOperationType.OldId
    LEFT JOIN dbo.DimUser AS DimUserAuthorize
        ON DimUserAuthorize.OldId = Rpsi.Cash.Operations.AuthorizedBy
    INNER JOIN dbo.DimUser AS DimUserAction
        ON DimUserAction.OldId = Rpsi.Cash.Operations.ActionBy
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'RPSI';


COMMIT TRAN;