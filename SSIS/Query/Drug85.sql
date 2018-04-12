USE RPSIDW;
BEGIN TRAN;

INSERT dbo.DimDB
(
    [Name]
)
VALUES
(N'Drug85' -- Name - nvarchar(50)
    );

INSERT dbo.DimUser
(
    UserName,
    FirstName,
    LastName,
    OwnerId,
    DBId,
    OldId
)
SELECT UserName,
       NULL,
       Lname,
       DimOwner.Id,
       DimDB.Id,
       Users.Id
FROM Drug85.dbo.Users
    CROSS JOIN dbo.DimOwner
    CROSS JOIN dbo.DimDB
WHERE dbo.DimOwner.OldId = 1
      AND dbo.DimDB.[Name] = N'Drug85';

INSERT dbo.DimUser
(
    UserName,
    FirstName,
    LastName,
    OwnerId,
    DBId,
    OldId
)
SELECT N'Unknown',
       NULL,
       N'‰«‘‰«”',
       DimOwner.Id,
       DimDB.Id,
       0
FROM dbo.DimOwner
    CROSS JOIN dbo.DimDB
WHERE dbo.DimOwner.OldId = 1
      AND dbo.DimDB.[Name] = N'Drug85';

INSERT dbo.DimFinancialYear
(
    SystemId,
    Title,
    DBId,
    OldId
)
SELECT DimSystem.Id,
       N'œ«—ÊŒ«‰Â «„«„ 85',
       dbo.DimDB.Id,
       0
FROM dbo.DimSystem
    INNER JOIN dbo.DimDB AS DimDBRPSI
        ON DimDBRPSI.Id = DimSystem.DBId
    CROSS JOIN dbo.DimDB
WHERE DimDBRPSI.[Name] = N'RPSI'
      AND dbo.DimSystem.OldId = 1
      AND dbo.DimDB.[Name] = N'Drug85';


INSERT dbo.DimInsuranceGroup
(
    Title,
    DBId,
    OldId
)
SELECT Drug85.dbo.Bimeh.Bimeh,    -- Title - nvarchar(500)
       DimDB.Id,                  -- DBId - int
       Drug85.dbo.Bimeh.BimehCode -- OldId - int
FROM Drug85.dbo.Bimeh
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'Drug85';



INSERT dbo.DimInsuranceGroup
(
    Title,
    DBId,
    OldId
)
SELECT N'«‘ »«Â',
       DD.Id,
       0
FROM dbo.DimDB AS DD
WHERE DD.[Name] = N'Drug85';



INSERT dbo.DimInsurance
(
    InsuranceGroupId,
    Code,
    Title,
    DBId,
    OldId
)
SELECT dbo.DimInsuranceGroup.Id,
       S.CodeSazeMan,
       S.Sazeman,
       dbo.DimDB.Id,
       S.CodeSazeMan
FROM Drug85.dbo.Sazeman AS S
    INNER JOIN
    (
        SELECT SIB.CodeSazeman,
               SIB.BimehCode
        FROM Drug85.dbo.SazemanInBimeh AS SIB
            INNER JOIN
            (
                SELECT DISTINCT
                       SIB.CodeSazeman,
                       MCodeS = MAX(SIB.CodeSazemanInBime)
                FROM Drug85.dbo.SazemanInBimeh AS SIB
                WHERE SIB.BimehCode != 0
                GROUP BY SIB.CodeSazeman
            ) AS mSIB1
                ON mSIB1.MCodeS = SIB.CodeSazemanInBime
    ) AS SIB
        ON SIB.CodeSazeman = S.CodeSazeMan
    INNER JOIN dbo.DimInsuranceGroup
        ON SIB.BimehCode = DimInsuranceGroup.OldId
    INNER JOIN dbo.DimDB
        ON dbo.DimInsuranceGroup.DBId = dbo.DimDB.Id
WHERE dbo.DimDB.[Name] = N'Drug85';

INSERT dbo.DimInsurance
(
    InsuranceGroupId,
    Code,
    Title,
    DBId,
    OldId
)
SELECT DIG.Id,
       InsuranceMCode.MCode + 1,
       N'«‘ »«Â',
       DIG.DBId,
       0
FROM dbo.DimInsuranceGroup AS DIG
    CROSS JOIN
    (
        SELECT MCode = MAX(Code)
        FROM dbo.DimInsurance
		INNER JOIN dbo.DimDB AS DD2 ON DD2.Id = DimInsurance.DBId
        WHERE DD2.[Name] = N'Drug86'
    ) AS InsuranceMCode
    INNER JOIN dbo.DimDB AS DD
        ON DD.Id = DIG.DBId
WHERE DD.[Name] = N'Drug85'
      AND DIG.Title = N'«‘ »«Â'
      AND DIG.OldId = 0;

INSERT dbo.DimProductGroup
(
    Title,
    OwnerId,
    DBId,
    OldId
)
SELECT Drug85.dbo.DrugGroup.DrugGroup,
       dbo.DimOwner.Id,
       dbo.DimDB.Id,
       Drug85.dbo.DrugGroup.CodeGroup
FROM Drug85.dbo.DrugGroup
    CROSS JOIN dbo.DimOwner
    CROSS JOIN dbo.DimDB
WHERE dbo.DimOwner.OldId = 1
      AND dbo.DimDB.[Name] = N'Drug85';

INSERT dbo.DimProductGroup
(
    Title,
    OwnerId,
    DBId,
    OldId
)
SELECT N'‰«‘‰«”',
       DO.Id,
       DD.Id,
       0
FROM dbo.DimDB AS DD
    CROSS JOIN dbo.DimOwner AS DO
WHERE DD.[Name] = N'Drug85'
      AND DO.OldId = 1;

INSERT dbo.DimProduct
(
    ProductGroupId,
    Code,
    Title,
    DBId,
    OldId
)
SELECT ISNULL(DPG.Id, DPG2.Id),
       Drug85.dbo.Kala.Code,
       ISNULL(Drug85.dbo.Kala.FaName, Drug85.dbo.Kala.Code),
       dbo.DimDB.Id,
       Drug85.dbo.Kala.Code
FROM Drug85.dbo.Kala
    CROSS JOIN dbo.DimDB
    LEFT JOIN dbo.DimProductGroup AS DPG
        ON DPG.OldId = Drug85.dbo.Kala.CodeGroup
           AND DPG.DBId = DimDB.Id
    INNER JOIN dbo.DimProductGroup AS DPG2
        ON DPG2.DBId = dbo.DimDB.Id
           AND DPG2.OldId = 0
WHERE dbo.DimDB.[Name] = N'Drug85';

INSERT dbo.DimProduct
(
    ProductGroupId,
    Code,
    Title,
    DBId,
    OldId
)
SELECT DPG.Id,
       maxNumberT.MPCode + 1,
       N'‰«‘‰«”',
       DD.Id,
       0
FROM dbo.DimDB AS DD
    INNER JOIN dbo.DimProductGroup AS DPG
        ON DPG.DBId = DD.Id
    INNER JOIN
    (
        SELECT MPCode = MAX(DP.Code),
               DP.DBId
        FROM dbo.DimProduct AS DP
            INNER JOIN dbo.DimDB AS DD
                ON DD.Id = DP.DBId
        WHERE DD.Name = N'Drug85'
        GROUP BY DP.DBId
    ) AS maxNumberT
        ON maxNumberT.DBId = DPG.DBId
WHERE DD.[Name] = N'Drug85'
      AND DPG.OldId = 0;

------ header
UPDATE Drug85.dbo.FacHeder
SET Sh_Noskhe = NPresSystemNum.NewSystemNumber
FROM Drug85.dbo.FacHeder AS FH
    INNER JOIN
    (
        SELECT FH.CodeFacHeder,
               FH.Sh_Noskhe,
               MaxSystemNumber = FHMax.MaxSystemNumber,
               RN = ROW_NUMBER() OVER (ORDER BY FH.Sh_Noskhe),
               NewSystemNumber = FHMax.MaxSystemNumber + ROW_NUMBER() OVER (ORDER BY FH.Sh_Noskhe)
        FROM Drug85.dbo.FacHeder AS FH
		CROSS JOIN
            (
                SELECT MaxSystemNumber = MAX(Sh_Noskhe)
                FROM Drug86.dbo.FacHeder
                WHERE State IN ( 0, 10 )
            ) AS FHMax
        WHERE FH.State IN ( 0, 10 )
              AND FH.Sh_Noskhe IN (
                                      SELECT Sh_Noskhe
                                      FROM Drug85.dbo.FacHeder AS FH
                                      WHERE FH.State IN ( 0, 10 )
                                      GROUP BY FH.Sh_Noskhe
                                      HAVING COUNT(1) > 1
                                  )
              AND FH.State = 10
    ) AS NPresSystemNum
        ON NPresSystemNum.CodeFacHeder = FH.CodeFacHeder;

INSERT dbo.FactHeader
(
    FinancialYearId,
    InsuranceId,
    Type,
    Number,
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
SELECT DFY.Id,
       ISNULL(DI.Id, DI2.Id),
       CASE
           WHEN FH.State = 10 THEN
               N'Ã«Ìê–«—Ì ‘œÂ'
           ELSE
               N'⁄«œÌ'
       END,
       FH.Sh_Noskhe,
       ISNULL(DU.Id, DU2.Id),
       dbo.DateToInt(FH.Ntime),
       CAST(FH.Ntime AS TIME),
       ISNULL(DU.Id, DU2.Id),
       dbo.DateToInt(FH.Ntime),
       CAST(FH.Ntime AS TIME),
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       ISNULL(FH.JamKolPardakht, 0),
       ISNULL(AN.Naghdi, 0) + ISNULL(AN.Takhfif, 0),
       0,
       DD.Id,
       FH.CodeFacHeder
FROM Drug85.dbo.FacHeder AS FH
    CROSS JOIN dbo.DimDB AS DD
    INNER JOIN dbo.DimFinancialYear AS DFY
        ON DFY.DBId = DD.Id
    LEFT JOIN Drug85.dbo.Sazeman AS S
        ON S.CodeSazeMan = FH.CodeSazeMan
    LEFT JOIN dbo.DimInsurance AS DI
        ON DI.OldId = S.CodeSazeMan
           AND DI.DBId = DD.Id
    INNER JOIN dbo.DimInsurance AS DI2
        ON DI2.DBId = DD.Id
    LEFT JOIN Drug85.dbo.Users AS U
        ON U.Id = FH.CodeUser
    LEFT JOIN dbo.DimUser AS DU
        ON DU.OldId = FH.CodeUser
           AND DU.DBId = DD.Id
    INNER JOIN dbo.DimUser AS DU2
        ON DU2.DBId = DD.Id
    LEFT JOIN [Drug85].[dbo].[allNoskhe] AS AN
        ON AN.[sh_noskhe] = FH.Sh_Noskhe
WHERE FH.State IN ( 0, 10 )
      AND DD.[Name] = N'Drug85'
      AND DI2.OldId = 0
      AND DI2.Title = N'«‘ »«Â'
      AND DU2.LastName = N'‰«‘‰«”';

--UPDATE dbo.FactHeader from table masoolfani


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
SELECT FH.Id,
       CASE
           WHEN FR.Flag = 0 THEN
               --N'Õﬁ ›‰Ì'
               --WHEN FR.Flag = 1
               --     AND (FR.IsReference = 1) THEN
               --    N'„‘«»Â ‘œÂ'
               --WHEN FR.ReferenceId IS NOT NULL THEN
               --    N'„‘«»Â'
               N'⁄«œÌ'
           ELSE
               N'⁄«œÌ'
       END,
       ISNULL(DP.Id, DP2.Id),
       ISNULL(FR.Ted, 0),
       ISNULL(FR.Gh, 0),
       ISNULL(ISNULL(FR.SahmSazeman, 0) / NULLIF((ISNULL(FR.JamRadif, 0) - ISNULL(FR.EzafeDariafty, 0)), 0) * 100, 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0)) / NULLIF(FR.Ted, 0), 0),
       ISNULL(ISNULL(FR.SahmSazeman, 0) / NULLIF(FR.Ted, 0), 0),
       ISNULL(ISNULL(FR.SahmBimar, 0) / NULLIF(FR.Ted, 0), 0),
       ISNULL(FR.EzafeDariafty, 0),
       FR.Buy,
       FH.InsertedBy,
       FH.InsertedDate,
       FH.InsertedTime,
       DD.Id,
       FR.CodeRadifFac
FROM RPSIDW.dbo.FactHeader AS FH
    INNER JOIN RPSIDW.dbo.DimDB AS DD
        ON DD.Id = FH.DBId
    INNER JOIN Drug85.dbo.FacRadif AS FR
        ON FR.CodeFacHeder = FH.OldId
    LEFT JOIN RPSIDW.dbo.DimProduct AS DP
        ON DP.OldId = FR.Code
           AND DP.DBId = DD.Id
    INNER JOIN dbo.DimProduct AS DP2
        ON DP2.DBId = DD.Id
WHERE DD.Name = N'Drug85'
      AND DP2.OldId = 0;


--UPDATE dbo.FactDetail

--INSERT dbo.FactTransaction


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
SELECT K.KheyrieCode,
       K.Kheyrie,
       1,
       0,
       DO.Id,
       DD.Id,
       K.KheyrieCode
FROM Drug85.dbo.Kheyrie AS K
    CROSS JOIN dbo.DimOwner AS DO
    CROSS JOIN dbo.DimDB AS DD
WHERE DO.OldId = 1
      AND DD.[Name] = N'Drug85';

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
SELECT DOT.MCode + 1,
       N'‰«‘‰«”',
       0,
       0,
       DO.Id,
       DD.Id,
       0
FROM dbo.DimOwner AS DO
    CROSS JOIN dbo.DimDB AS DD
    INNER JOIN
    (
        SELECT MCode = MAX(Code),
               DOT.DBId,
               DOT.OwnerId
        FROM dbo.DimOperationType AS DOT
        GROUP BY DOT.DBId,
                 DOT.OwnerId
    ) AS DOT
        ON DOT.OwnerId = DO.Id
           AND DOT.DBId = DD.Id
WHERE DO.OldId = 1
      AND DD.[Name] = N'Drug85';

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
SELECT FH2.Id,
       ISNULL(DOTKh.Id, ISNULL(DOTCash.Id,DOTUnk.Id)),
	   S.Mablagh,
	   NULL,
	   NULL,
	   NULL,
	   ISNULL(DU.Id,DU2.Id),
	   dbo.DateToInt(S.TimeSandogh),
	   CAST(S.TimeSandogh AS TIME),
	   DD.Id,
	   S.Sandogh
FROM Drug85.dbo.FacHeder AS FH
    INNER JOIN dbo.FactHeader AS FH2
        ON FH.CodeFacHeder = FH2.OldId
    INNER JOIN dbo.DimDB AS DD
        ON DD.Id = FH2.DBId
    INNER JOIN Drug85.dbo.Sandogh AS S
        ON S.Sh_Noskhe = FH.Sh_Noskhe
    CROSS JOIN dbo.DimDB AS DD2
    LEFT JOIN dbo.DimOperationType AS DOTKh
        ON DOTKh.DBId = DD.Id
           AND DOTKh.OldId = S.KheyrieCode
    LEFT JOIN dbo.DimOperationType AS DOTCash
        ON DOTCash.DBId = DD2.Id AND S.KheyrieCode=0 AND DOTCash.OldId=1
    INNER JOIN dbo.DimOperationType AS DOTUnk
        ON DOTUnk.DBId = DD.Id
    LEFT JOIN dbo.DimUser AS DU
        ON DU.DBId = DD.Id
           AND DU.OldId = S.UserId
    INNER JOIN dbo.DimUser AS DU2
        ON DU2.DBId = DD.Id
WHERE FH.State IN ( 0, 10 )
      AND DD.[Name] = N'Drug85'
      AND DD2.Name = N'RPSI'
      AND DU2.LastName = N'‰«‘‰«”'
      AND DOTUnk.OldId = 0;



COMMIT TRAN;