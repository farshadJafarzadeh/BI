SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE VIEW [dbo].[ViewDimPhysician]
WITH SCHEMABINDING
AS
SELECT DP.Id,
       ViewCatDimPhysicianSpecialityId = VDPS.NewId,
       DP.[FirstName],
       DP.[LastName],
       DP.[FullName],
       DP.[MedicalCouncilCode],
       DP.[IsResident],
       DP.[Sex],
       DP.Mama,
       NewId = ISNULL(DP.NewId, [VCDP].Id)
FROM dbo.DimPhysician AS DP
    INNER JOIN dbo.DimPhysicianSpeciality AS DPS
        ON DPS.Id = DP.PhysicianSpecialityId
    INNER JOIN dbo.ViewDimPhysicianSpeciality AS VDPS
        ON VDPS.Id = DPS.Id
    INNER JOIN [dbo].[ViewCatDimPhysician] AS [VCDP]
        ON [VCDP].ViewCatDimPhysicianSpecialityId = VDPS.NewId
           AND
           (
               (
                   [VCDP].[FirstName] IS NULL
                   AND DP.[FirstName] IS NULL
               )
               OR ([VCDP].[FirstName] = DP.[FirstName])
           )
           AND
           (
               (
                   [VCDP].[LastName] IS NULL
                   AND DP.[LastName] IS NULL
               )
               OR ([VCDP].[LastName] = DP.[LastName])
           )
           AND
           (
               (
                   [VCDP].[FullName] IS NULL
                   AND DP.[FullName] IS NULL
               )
               OR ([VCDP].[FullName] = DP.[FullName])
           )
           AND
           (
               (
                   [VCDP].[MedicalCouncilCode] IS NULL
                   AND DP.[MedicalCouncilCode] IS NULL
               )
               OR ([VCDP].[MedicalCouncilCode] = DP.[MedicalCouncilCode])
           )
           AND
           (
               (
                   [VCDP].[IsResident] IS NULL
                   AND DP.[IsResident] IS NULL
               )
               OR ([VCDP].[IsResident] = DP.[IsResident])
           )
           AND
           (
               (
                   [VCDP].[Sex] IS NULL
                   AND DP.[Sex] IS NULL
               )
               OR ([VCDP].[Sex] = DP.[Sex])
           )
           AND
           (
               (
                   [VCDP].Mama IS NULL
                   AND DP.Mama IS NULL
               )
               OR ([VCDP].Mama = DP.Mama)
           )
    LEFT JOIN
    (
        SELECT NewId
        FROM dbo.DimPhysician
        WHERE NewId IS NULL
        GROUP BY NewId
    ) DPManualCat
        ON DPManualCat.NewId = DP.Id
WHERE DPManualCat.NewId IS NULL;



GO
