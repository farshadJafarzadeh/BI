SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[ViewDimUser]
WITH SCHEMABINDING
AS
SELECT DU.Id,
       DU.UserName,
       DU.FirstName,
       DU.LastName,
       DU.FullName,
       NewId = ISNULL(DU.NewId, [VCDU].Id)
FROM dbo.DimUser AS DU
    INNER JOIN [dbo].[ViewCatDimUser] AS [VCDU]
        ON [VCDU].UserName = DU.UserName
           AND
           (
               (
                   [VCDU].FirstName IS NULL
                   AND DU.FirstName IS NULL
               )
               OR ([VCDU].FirstName = DU.FirstName)
           )
           AND
           (
               (
                   [VCDU].LastName IS NULL
                   AND DU.LastName IS NULL
               )
               OR ([VCDU].LastName = DU.LastName)
           )
           AND
           (
               (
                   [VCDU].FullName IS NULL
                   AND DU.FullName IS NULL
               )
               OR ([VCDU].FullName = DU.FullName)
           )
    LEFT JOIN
    (
        SELECT NewId
        FROM dbo.DimUser
        WHERE NewId IS NULL
        GROUP BY NewId
    ) DUManualCat
        ON DUManualCat.NewId = DU.Id
WHERE DUManualCat.NewId IS NULL;


GO
