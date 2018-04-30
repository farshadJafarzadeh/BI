SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE VIEW [dbo].[ViewCatDimPhysician]
WITH SCHEMABINDING
AS
SELECT Id = MIN(DP.Id),
       ViewCatDimPhysicianSpecialityId = VDPS.NewId,
       DP.[FirstName],
       DP.[LastName],
       DP.[FullName],
       DP.[MedicalCouncilCode],
       DP.[IsResident],
       DP.[Sex],
       DP.Mama
FROM dbo.DimPhysician AS DP
    INNER JOIN dbo.DimPhysicianSpeciality AS DPS
        ON DPS.Id = DP.PhysicianSpecialityId
    INNER JOIN dbo.ViewDimPhysicianSpeciality AS VDPS
        ON VDPS.Id = DPS.Id
WHERE DP.NewId IS NULL
GROUP BY VDPS.NewId,
         DP.[FirstName],
         DP.[LastName],
         DP.[FullName],
         DP.[MedicalCouncilCode],
         DP.[IsResident],
         DP.[Sex],
         DP.Mama;
GO
