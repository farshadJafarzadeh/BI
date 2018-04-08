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
        WHERE DBId = 2
    ) AS InsuranceMCode
    CROSS JOIN dbo.DimDB AS DD
WHERE DD.[Name] = N'Drug85'
      AND DIG.Title = N'«‘ »«Â'
      AND DD.[Name] = N'Drug85'
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


INSERT dbo.DimProduct
(
    ProductGroupId,
    Code,
    Title,
    DBId,
    OldId
)
SELECT dbo.DimProductGroup.Id,
       Drug85.dbo.Kala.Code,
       Drug85.dbo.Kala.FaName,
       dbo.DimDB.Id,
       Drug85.dbo.Kala.Code
FROM Drug85.dbo.Kala
    INNER JOIN dbo.DimProductGroup
        ON dbo.DimProductGroup.OldId = Drug85.dbo.Kala.CodeGroup
    CROSS JOIN dbo.DimDB
WHERE dbo.DimDB.[Name] = N'Drug85';




------ header
DECLARE @MaxSystemNumber INT = 0;

SELECT @MaxSystemNumber = MAX(Sh_Noskhe)
FROM Drug85.dbo.FacHeder
WHERE State IN ( 0, 10 );

UPDATE Drug85.dbo.FacHeder
SET Sh_Noskhe = NPresSystemNum.NewSystemNumber
FROM Drug85.dbo.FacHeder AS FH
    INNER JOIN
    (
        SELECT FH.CodeFacHeder,
               FH.Sh_Noskhe,
               MaxSystemNumber = @MaxSystemNumber,
               RN = ROW_NUMBER() OVER (ORDER BY FH.Sh_Noskhe),
               NewSystemNumber = @MaxSystemNumber + ROW_NUMBER() OVER (ORDER BY FH.Sh_Noskhe)
        FROM Drug85.dbo.FacHeder AS FH
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
       ISNULL(DI.Id,Di2.Id),
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
       ISNULL(FH.JamKolPardakht,0),
       ISNULL(AN.Naghdi,0) + ISNULL(AN.Takhfif,0),
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
	inner JOIN dbo.DimInsurance AS DI2 ON DI2.DBId=DD.Id
    LEFT JOIN Drug85.dbo.Users AS U
        ON U.Id = FH.CodeUser
    LEFT JOIN dbo.DimUser AS DU
        ON DU.OldId = FH.CodeUser
           AND DU.DBId = DD.Id
    INNER JOIN dbo.DimUser AS DU2
        ON DU2.LastName = N'‰«‘‰«”'
           AND DU2.DBId = DD.Id
    LEFT JOIN [Drug85].[dbo].[allNoskhe] AS AN
        ON AN.[sh_noskhe] = FH.Sh_Noskhe
WHERE FH.State IN ( 0, 10 )
      AND DD.[Name] = N'Drug85'
	  AND DI2.OldId=0
	  AND DI2.Title=N'«‘ »«Â'

COMMIT TRAN;