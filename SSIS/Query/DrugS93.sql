﻿USE RPSIDW;
BEGIN TRAN;

DECLARE @DBIdRPSI INT;
DECLARE @DBIdDrug85 INT;
DECLARE @DBIdDrugShafa93 INT;

INSERT dbo.DimDB
(
    [Name]
)
VALUES
(N'DrugShafa93' -- Name - nvarchar(50)
    );
SELECT @DBIdRPSI = DD.Id
FROM dbo.DimDB AS DD
WHERE DD.Name = N'RPSI';

SELECT @DBIdDrug85 = DD.Id
FROM dbo.DimDB AS DD
WHERE DD.Name = N'Drug85';

SELECT @DBIdDrugShafa93 = DD.Id
FROM dbo.DimDB AS DD
WHERE DD.Name = N'DrugShafa93';

INSERT dbo.DimUser
(
    UserName,
    FirstName,
    LastName,
    OwnerId,
    DBId,
    OldId,
    OldType
)
SELECT ISNULL(UserName, Lname),
       NULL,
       Lname,
       DimOwner.Id,
       @DBIdDrugShafa93,
       Users.Id,
       N'کاربر'
FROM DrugShafa93.dbo.Users
    CROSS JOIN dbo.DimOwner
WHERE dbo.DimOwner.OldId = 1
      AND ISNULL(UserName, Lname) IS NOT NULL;

INSERT dbo.DimUser
(
    UserName,
    FirstName,
    LastName,
    OwnerId,
    DBId,
    OldId,
    OldType
)
SELECT MF.MasolFani,
       NULL,
       MF.MasolFani,
       DimOwner.Id,
       @DBIdDrugShafa93,
       MF.CodeMasolFani,
       N'مسئول فنی'
FROM DrugShafa93.dbo.MasolFani AS MF
    CROSS JOIN dbo.DimOwner
WHERE dbo.DimOwner.OldId = 1;

--INSERT dbo.DimUser
--(
--    UserName,
--    FirstName,
--    LastName,
--    OwnerId,
--    DBId,
--    OldId
--)
--SELECT N'Unknown',
--       NULL,
--       N'ناشناس',
--       DimOwner.Id,
--       @DBIdDrugShafa93,
--       0
--FROM dbo.DimOwner
--WHERE dbo.DimOwner.OldId = 1;

INSERT dbo.DimFinancialYear
(
    SystemId,
    Title,
    DBId,
    OldId
)
SELECT DimSystem.Id,
       N'داروخانه دارالشفا 93',
       @DBIdDrugShafa93,
       0
FROM dbo.DimSystem
    INNER JOIN dbo.DimDB AS DimDBRPSI
        ON DimDBRPSI.Id = DimSystem.DBId
WHERE DimDBRPSI.[Name] = N'RPSI'
      AND dbo.DimSystem.OldId = 1;



INSERT dbo.DimInsuranceGroup
(
    Title,
    DBId,
    OldId
)
SELECT DrugShafa93.dbo.Bimeh.Bimeh,    -- Title - nvarchar(600)
       @DBIdDrugShafa93,               -- DBId - int
       DrugShafa93.dbo.Bimeh.BimehCode -- OldId - int
FROM DrugShafa93.dbo.Bimeh;


--INSERT dbo.DimInsuranceGroup
--(
--    Title,
--    DBId,
--    OldId
--)
--SELECT N'اشتباه',
--       @DBIdDrugShafa93,
--       0;




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
       @DBIdDrugShafa93,
       S.CodeSazeMan
FROM DrugShafa93.dbo.Sazeman AS S
    INNER JOIN
    (
        SELECT SIB.CodeSazeman,
               SIB.BimehCode
        FROM DrugShafa93.dbo.SazemanInBimeh AS SIB
            INNER JOIN
            (
                SELECT DISTINCT
                       SIB.CodeSazeman,
                       MCodeS = MAX(SIB.CodeSazemanInBime)
                FROM DrugShafa93.dbo.SazemanInBimeh AS SIB
                WHERE SIB.BimehCode != 0
                GROUP BY SIB.CodeSazeman
            ) AS mSIB1
                ON mSIB1.MCodeS = SIB.CodeSazemanInBime
    ) AS SIB
        ON SIB.CodeSazeman = S.CodeSazeMan
    INNER JOIN dbo.DimInsuranceGroup
        ON SIB.BimehCode = DimInsuranceGroup.OldId
           AND DimInsuranceGroup.DBId = @DBIdDrugShafa93;

--INSERT dbo.DimInsurance
--(
--    InsuranceGroupId,
--    Code,
--    Title,
--    DBId,
--    OldId
--)
--SELECT DIG.Id,
--       InsuranceMCode.MCode + 1,
--       N'اشتباه',
--       DIG.DBId,
--       0
--FROM dbo.DimInsuranceGroup AS DIG
--    CROSS JOIN
--    (
--        SELECT MCode = MAX(Code)
--        FROM dbo.DimInsurance
--            INNER JOIN dbo.DimDB AS DD2
--                ON DD2.Id = DimInsurance.DBId
--        WHERE DD2.[Name] = N'DrugShafa93'
--    ) AS InsuranceMCode
--WHERE @DBIdDrugShafa93 = DIG.DBId
--      AND DIG.Title = N'اشتباه'
--      AND DIG.OldId = 0;


INSERT dbo.DimPhysicianLevel
(
    Title,
    Level,
    DBId,
    OldId,
    Mama
)
SELECT T.Takhasos2,
       NULL,
       @DBIdDrugShafa93,
       T.CodeTakh2,
       T.Mama
FROM DrugShafa93.dbo.Takhasos2 AS T;

--INSERT dbo.DimPhysicianLevel
--(
--    Title,
--    Level,
--    DBId,
--    OldId,
--    Mama
--)
--SELECT N'ناشناس',
--       NULL,
--       @DBIdDrugShafa93,
--       0,
--       NULL;


INSERT dbo.DimPhysicianSpeciality
(
    PhysicianLevelId,
    Title,
    DBId,
    OldId
)
SELECT DPL.Id,
       T.Takhasos,
       @DBIdDrugShafa93,
       T.CodeTakh
FROM DrugShafa93.dbo.Takhasos AS T
    INNER JOIN DrugShafa93.dbo.Takhasos2 AS T2
        ON T2.CodeTakh2 = T.CodeTakh2
    INNER JOIN dbo.DimPhysicianLevel AS DPL
        ON DPL.OldId = T2.CodeTakh2
           AND @DBIdDrugShafa93 = DPL.DBId;

--INSERT dbo.DimPhysicianSpeciality
--(
--    PhysicianLevelId,
--    Title,
--    DBId,
--    OldId
--)
--SELECT DPL.Id,
--       N'ناشناس',
--       @DBIdDrugShafa93,
--       0
--FROM dbo.DimPhysicianLevel AS DPL
--WHERE DPL.DBId = @DBIdDrugShafa93
--      AND DPL.OldId = 0;

INSERT dbo.DimPhysician
(
    PhysicianSpecialityId,
    FirstName,
    LastName,
    MedicalCouncilCode,
    IsResident,
    Sex,
    DBId,
    OldId,
    Mama
)
SELECT DISTINCT
       ISNULL(DPS.Id, DPS2.Id),
       NULL,
       D.NameDr,
       D.CodeDr,
       NULL,
       NULL,
       @DBIdDrugShafa93,
       D.CodeDr,
       T2.Mama
FROM DrugShafa93.dbo.Dr AS D
    LEFT JOIN DrugShafa93.dbo.Takhasos AS T
        ON T.CodeTakh = D.CodeTakh
    LEFT JOIN DrugShafa93.dbo.Takhasos2 AS T2
        ON T2.CodeTakh2 = T.CodeTakh2
    LEFT JOIN dbo.DimPhysicianSpeciality AS DPS
        ON DPS.OldId = T.CodeTakh
           AND @DBIdDrugShafa93 = DPS.DBId
    INNER JOIN dbo.DimPhysicianSpeciality AS DPS2
        ON DPS2.OldId = 0
           AND @DBIdDrugShafa93 = DPS2.DBId
ORDER BY D.CodeDr;



INSERT dbo.DimProductForm
(
    Title,
    OwnerId,
    DBId,
    OldId
)
SELECT DrugShafa93.dbo.DrugGroup.DrugGroup,
       dbo.DimOwner.Id,
       @DBIdDrugShafa93,
       DrugShafa93.dbo.DrugGroup.CodeGroup
FROM DrugShafa93.dbo.DrugGroup
    CROSS JOIN dbo.DimOwner
WHERE dbo.DimOwner.OldId = 1
      AND DrugGroup.DrugGroup IS NOT NULL;

--INSERT dbo.DimProductForm
--(
--    Title,
--    OwnerId,
--    DBId,
--    OldId
--)
--SELECT N'ناشناس',
--       DO.Id,
--       @DBIdDrugShafa93,
--       0
--FROM dbo.DimOwner AS DO
--WHERE DO.OldId = 1;

INSERT dbo.DimProduct
(
    ProductFormId,
    Code,
    Title,
    DBId,
    OldId
)
SELECT ISNULL(DPF.Id, DPF2.Id),
       DrugShafa93.dbo.Kala.Code,
       ISNULL(DrugShafa93.dbo.Kala.FaName, DrugShafa93.dbo.Kala.Code),
       @DBIdDrugShafa93,
       DrugShafa93.dbo.Kala.Code
FROM DrugShafa93.dbo.Kala
    LEFT JOIN dbo.DimProductForm AS DPF
        ON DPF.OldId = DrugShafa93.dbo.Kala.CodeGroup
           AND DPF.DBId = @DBIdDrugShafa93
    INNER JOIN dbo.DimProductForm AS DPF2
        ON DPF2.DBId = @DBIdRPSI
           AND DPF2.OldId = 0;

--INSERT dbo.DimProduct
--(
--    ProductFormId,
--    Code,
--    Title,
--    DBId,
--    OldId
--)
--SELECT DPF.Id,
--       maxNumberT.MPCode + 1,
--       N'ناشناس',
--       DD.Id,
--       0
--FROM dbo.DimDB AS DD
--    INNER JOIN dbo.DimProductForm AS DPF
--        ON DPF.DBId = DD.Id
--    INNER JOIN
--    (
--        SELECT MPCode = MAX(DP.Code),
--               DBId = @DBIdDrugShafa93
--        FROM dbo.DimProduct AS DP
--        WHERE DP.DBId = @DBIdDrugShafa93
--    ) AS maxNumberT
--        ON maxNumberT.DBId = DPF.DBId
--WHERE DPF.OldId = 0;

------ header



SELECT FH.CodeFacHeder,
       FH.Sh_Noskhe,
       MaxSystemNumber = FHMax.MaxSystemNumber,
       RN = ROW_NUMBER() OVER (ORDER BY FH.Sh_Noskhe),
       NewSystemNumber = FHMax.MaxSystemNumber + ROW_NUMBER() OVER (ORDER BY FH.Sh_Noskhe)
INTO #FacHederDuplicated
FROM DrugShafa93.dbo.FacHeder AS FH
    CROSS JOIN
    (
        SELECT MaxSystemNumber = MAX(Sh_Noskhe)
        FROM DrugShafa93.dbo.FacHeder
        WHERE State IN ( 0, 10 )
    ) AS FHMax
WHERE FH.State IN ( 0, 10 )
      AND FH.Sh_Noskhe IN (
                              SELECT Sh_Noskhe
                              FROM DrugShafa93.dbo.FacHeder AS FH
                              WHERE FH.State IN ( 0, 10 )
                              GROUP BY FH.Sh_Noskhe
                              HAVING COUNT(1) > 1
                          )
      AND FH.State = 10;

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
SELECT DFY.Id,
       ISNULL(DI.Id, DI2.Id),
       DP.Id,
       CASE
           WHEN FH.State = 10 THEN
               N'جايگذاري شده'
           ELSE
               N'عادي'
       END,
       ISNULL(#FacHederDuplicated.NewSystemNumber, FH.Sh_Noskhe),
       FH.Radif,
       ISNULL(DD2.DateKey, dbo.DateToInt(FH.Ntime)),
       NULL,
       DD3.DateKey,
       DD4.DateKey,
       ISNULL(DU.Id, DU3.Id),
       dbo.DateToInt(FH.Ntime),
       CAST(FH.Ntime AS TIME),
       ISNULL(DU.Id, DU3.Id),
       dbo.DateToInt(FH.Ntime),
       CAST(FH.Ntime AS TIME),
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       ISNULL(DU2.Id, DU3.Id),
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       ISNULL(FH.JamKolPardakht, 0),
       ISNULL(AN.Naghdi, 0) + ISNULL(AN.Takhfif, 0),
       0,
       @DBIdDrugShafa93,
       FH.CodeFacHeder
FROM DrugShafa93.dbo.FacHeder AS FH
    LEFT JOIN #FacHederDuplicated
        ON #FacHederDuplicated.CodeFacHeder = FH.CodeFacHeder
    LEFT JOIN DrugShafa93.dbo.Dr AS D
        ON D.CodeDr = FH.CodeDr
           AND D.Mama = FH.Mama
    LEFT JOIN.DrugShafa93.dbo.Takhasos AS T
        ON T.CodeTakh = D.CodeTakh
    LEFT JOIN DrugShafa93.dbo.Takhasos2 AS T2
        ON T2.CodeTakh2 = T.CodeTakh2
           AND T2.Mama = D.Mama
    LEFT JOIN dbo.DimPhysician AS DP
        ON DP.Mama = T2.Mama
           AND FH.CodeDr = DP.OldId
           AND DP.DBId = @DBIdDrugShafa93
    LEFT JOIN dbo.DimDate AS DD2
        ON DD2.PersianDateKey = FH.DateFac + 13000000
    LEFT JOIN dbo.DimDate AS DD3
        ON DD3.PersianDateKey = FH.DateNoskhe + 13000000
    LEFT JOIN dbo.DimDate AS DD4
        ON DD4.PersianDateKey = FH.Etebar + 13000000
    INNER JOIN dbo.DimFinancialYear AS DFY
        ON DFY.DBId = @DBIdDrugShafa93
    LEFT JOIN DrugShafa93.dbo.Sazeman AS S
        ON S.CodeSazeMan = FH.CodeSazeMan
    LEFT JOIN dbo.DimInsurance AS DI
        ON DI.OldId = S.CodeSazeMan
           AND DI.DBId = @DBIdDrugShafa93
    INNER JOIN dbo.DimInsurance AS DI2
        ON DI2.DBId = @DBIdDrug85
    LEFT JOIN
    (
        SELECT S.Sh_Noskhe,
               S.CodeMasolFani
        FROM DrugShafa93.dbo.Sandogh AS S
            INNER JOIN
            (
                SELECT Sh_Noskhe,
                       MaxSandogh = MAX(Sandogh)
                FROM DrugShafa93.dbo.Sandogh
                WHERE State = 1
                GROUP BY Sh_Noskhe
            ) AS S2
                ON S2.MaxSandogh = S.Sandogh
        WHERE S.State = 1
    ) AS S2
        ON FH.Sh_Noskhe = S2.Sh_Noskhe
    LEFT JOIN DrugShafa93.dbo.Users AS U
        ON U.Id = FH.CodeUser
    LEFT JOIN dbo.DimUser AS DU
        ON DU.OldId = FH.CodeUser
           AND DU.DBId = @DBIdDrugShafa93
           AND DU.OldType = N'کاربر'
    LEFT JOIN dbo.DimUser AS DU2
        ON DU2.OldId = S2.CodeMasolFani
           AND DU2.DBId = @DBIdDrugShafa93
           AND DU2.OldType = N'مسئول فنی'
    INNER JOIN dbo.DimUser AS DU3
        ON DU3.DBId = @DBIdDrug85
    LEFT JOIN [DrugShafa93].[dbo].[allNoskhe] AS AN
        ON AN.[sh_noskhe] = FH.Sh_Noskhe
WHERE FH.State IN ( 0, 10 )
      AND DI2.OldId = 0
      AND DI2.Title = N'اشتباه'
      AND DU3.LastName = N'ناشناس'
      AND DU3.OldType IS NULL;


--technicalfee from row
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
       N'حق فني',
       ISNULL(DP.Id, DP2.Id),
       ISNULL(FR.Ted, 0),
       ISNULL(FR.Gh, 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) * 100) / (NULLIF(ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0), 0)), 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0)) / NULLIF(FR.Ted, 0), 0),
       ISNULL(ISNULL(FR.SahmSazeman, 0) / NULLIF(FR.Ted, 0), 0),
       ISNULL(ISNULL(FR.SahmBimar, 0) / NULLIF(FR.Ted, 0), 0),
       ISNULL(FR.EzafeDariafty, 0),
       FR.Buy,
       FH.InsertedBy,
       FH.InsertedDate,
       FH.InsertedTime,
       @DBIdDrugShafa93,
       FR.CodeRadifFac
FROM RPSIDW.dbo.FactHeader AS FH
    INNER JOIN DrugShafa93.dbo.FacRadif AS FR
        ON FR.CodeFacHeder = FH.OldId
    LEFT JOIN RPSIDW.dbo.DimProduct AS DP
        ON DP.OldId = FR.Code
           AND DP.DBId = FH.DBId
    INNER JOIN dbo.DimProduct AS DP2
        ON DP2.DBId = @DBIdDrug85
WHERE DP2.OldId = 0
      AND
      (
          FR.Code = 1
          OR FR.Code = 2
      )
      AND FH.DBId = @DBIdDrugShafa93;

--normal

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
       N'عادي',
       ISNULL(DP.Id, DP2.Id),
       ISNULL(FR.Ted, 0),
       ISNULL(FR.Gh, 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) * 100) / (NULLIF(ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0), 0)), 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0)) / NULLIF(FR.Ted, 0), 0),
       ISNULL(ISNULL(FR.SahmSazeman, 0) / NULLIF(FR.Ted, 0), 0),
       ISNULL(ISNULL(FR.SahmBimar, 0) / NULLIF(FR.Ted, 0), 0),
       ISNULL(FR.EzafeDariafty, 0),
       FR.Buy,
       FH.InsertedBy,
       FH.InsertedDate,
       FH.InsertedTime,
       @DBIdDrugShafa93,
       FR.CodeRadifFac
FROM RPSIDW.dbo.FactHeader AS FH
    INNER JOIN DrugShafa93.dbo.FacRadif AS FR
        ON FR.CodeFacHeder = FH.OldId
    LEFT JOIN RPSIDW.dbo.DimProduct AS DP
        ON DP.OldId = FR.Code
           AND DP.DBId = FH.DBId
    INNER JOIN dbo.DimProduct AS DP2
        ON DP2.DBId = @DBIdDrug85
WHERE DP2.OldId = 0
      AND FR.CodeM IS NULL
      AND FR.Code <> 1
      AND FR.Code <> 2
      AND FH.DBId = @DBIdDrugShafa93;

--isreference
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
       N'مشابه شده',
       ISNULL(DP.Id, DP2.Id),
       ISNULL(FR.TedM, 0),
       ISNULL(FR.GhM, 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) * 100) / (NULLIF(ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0), 0)), 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0)) / NULLIF(FR.TedM, 0), 0),
       ISNULL(ISNULL(FR.SahmSazeman, 0) / NULLIF(FR.TedM, 0), 0),
       ISNULL(ISNULL(FR.SahmBimar, 0) / NULLIF(FR.TedM, 0), 0),
       ISNULL(FR.GhM, 0) - ISNULL((ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0)) / NULLIF(FR.TedM, 0), 0),
       FR.Buy,
       FH.InsertedBy,
       FH.InsertedDate,
       FH.InsertedTime,
       @DBIdDrugShafa93,
       FR.CodeRadifFac
FROM RPSIDW.dbo.FactHeader AS FH
    INNER JOIN DrugShafa93.dbo.FacRadif AS FR
        ON FR.CodeFacHeder = FH.OldId
    LEFT JOIN RPSIDW.dbo.DimProduct AS DP
        ON DP.OldId = FR.CodeM
           AND DP.DBId = FH.DBId
    INNER JOIN dbo.DimProduct AS DP2
        ON DP2.DBId = @DBIdDrug85
WHERE DP2.OldId = 0
      AND FR.CodeM IS NOT NULL
      AND FR.Code <> 1
      AND FR.Code <> 2
      AND FH.DBId = @DBIdDrugShafa93;


--has refrence

INSERT dbo.FactDetail
(
    HeaderId,
    DetailId,
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
       FD.Id,
       N'مشابه',
       ISNULL(DP.Id, DP2.Id),
       ISNULL(FR.Ted, 0),
       ISNULL(FR.Gh, 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) * 100) / (NULLIF(ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0), 0)), 0),
       ISNULL((ISNULL(FR.SahmSazeman, 0) + ISNULL(FR.SahmBimar, 0)) / NULLIF(FR.Ted, 0), 0),
       ISNULL(ISNULL(FR.SahmSazeman, 0) / NULLIF(FR.Ted, 0), 0),
       ISNULL(ISNULL(FR.SahmBimar, 0) / NULLIF(FR.Ted, 0), 0),
       ISNULL(FR.EzafeDariafty, 0),
       FR.Buy,
       FH.InsertedBy,
       FH.InsertedDate,
       FH.InsertedTime,
       @DBIdDrugShafa93,
       FR.CodeRadifFac
FROM RPSIDW.dbo.FactHeader AS FH
    INNER JOIN DrugShafa93.dbo.FacRadif AS FR
        ON FR.CodeFacHeder = FH.OldId
    INNER JOIN dbo.FactDetail AS FD
        ON FD.OldId = FR.CodeRadifFac
           AND FD.DBId = FH.DBId
           AND FD.Type = N'مشابه شده'
    LEFT JOIN RPSIDW.dbo.DimProduct AS DP
        ON DP.OldId = FR.Code
           AND DP.DBId = FH.DBId
    INNER JOIN dbo.DimProduct AS DP2
        ON DP2.DBId = @DBIdDrug85
WHERE DP2.OldId = 0
      AND FR.CodeM IS NOT NULL
      AND FR.Code <> 1
      AND FR.Code <> 2
      AND FH.DBId = @DBIdDrugShafa93;


UPDATE dbo.FactDetail
SET InsurancePercent = dbo.NotMoreThan(dbo.NotLessThan(InsurancePercent, 0), 100),
    AddFee = dbo.NotLessThan(AddFee, 0)
FROM dbo.FactDetail
WHERE InsurancePercent > 100
      OR InsurancePercent < 0
      OR AddFee < 0
         AND dbo.FactDetail.DBId = @DBIdDrugShafa93;

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
       @DBIdDrugShafa93,
       K.KheyrieCode
FROM DrugShafa93.dbo.Kheyrie AS K
    CROSS JOIN dbo.DimOwner AS DO
WHERE DO.OldId = 1;


--INSERT dbo.DimOperationType
--(
--    Code,
--    Title,
--    IsWarrant,
--    IsDebt,
--    OwnerId,
--    DBId,
--    OldId
--)
--SELECT DOT.MCode + 1,
--       N'ناشناس',
--       0,
--       0,
--       DO.Id,
--       @DBIdDrugShafa93,
--       0
--FROM dbo.DimOwner AS DO
--    INNER JOIN
--    (
--        SELECT MCode = MAX(Code),
--               DOT.DBId,
--               DOT.OwnerId
--        FROM dbo.DimOperationType AS DOT
--        GROUP BY DOT.DBId,
--                 DOT.OwnerId
--    ) AS DOT
--        ON DOT.OwnerId = DO.Id
--           AND DOT.DBId = @DBIdDrugShafa93
--WHERE DO.OldId = 1;


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
       ISNULL(DOTKh.Id, ISNULL(DOTCash.Id, DOTUnk.Id)),
       S.Mablagh,
       NULL,
       NULL,
       NULL,
       ISNULL(DU.Id, DU2.Id),
       dbo.DateToInt(S.TimeSandogh),
       CAST(S.TimeSandogh AS TIME),
       @DBIdDrugShafa93,
       S.Sandogh
FROM DrugShafa93.dbo.FacHeder AS FH
    LEFT JOIN #FacHederDuplicated
        ON #FacHederDuplicated.CodeFacHeder = FH.CodeFacHeder
    INNER JOIN dbo.FactHeader AS FH2
        ON FH.CodeFacHeder = FH2.OldId
    INNER JOIN DrugShafa93.dbo.Sandogh AS S
        ON S.Sh_Noskhe = FH.Sh_Noskhe
    CROSS JOIN dbo.DimDB AS DD2
    LEFT JOIN dbo.DimOperationType AS DOTKh
        ON DOTKh.DBId = FH2.DBId
           AND DOTKh.OldId = ISNULL(S.KheyrieCode, 0)
           AND ISNULL(S.KheyrieCode, 0) != 0
    LEFT JOIN dbo.DimOperationType AS DOTCash
        ON DOTCash.DBId = DD2.Id
           AND DOTCash.OldId = 1
           AND ISNULL(S.KheyrieCode, 0) = 0
    INNER JOIN dbo.DimOperationType AS DOTUnk
        ON DOTUnk.DBId = @DBIdDrug85
    LEFT JOIN dbo.DimUser AS DU
        ON DU.DBId = FH2.DBId
           AND DU.OldId = S.UserId
           AND DU.OldType = N'کاربر'
    INNER JOIN dbo.DimUser AS DU2
        ON DU2.DBId = @DBIdDrug85
WHERE FH.State IN ( 0, 10 )
      AND DD2.Name = N'RPSI'
      AND DU2.LastName = N'ناشناس'
      AND DOTUnk.OldId = 0
      AND FH2.DBId = @DBIdDrugShafa93
      AND S.State IN ( 0, 1, 50 )
      AND #FacHederDuplicated.CodeFacHeder IS NULL;

DROP TABLE #FacHederDuplicated;






COMMIT TRAN;
