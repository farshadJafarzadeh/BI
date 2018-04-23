SELECT * FROM dbo.DimDB AS DD
SELECT FH.DBId,COUNT(1) FROM dbo.DimProductGroup   AS FH
GROUP BY FH.DBId

SELECT * FROM DrugDaroshafa9107.dbo.Users


SELECT * FROM Drug94.dbo.DrugGroup  AS B

SELECT * FROM dbo.DimProduct AS DPG
WHERE DPG.DBId=12

SELECT * FROM dbo.DimOwner AS DO
SELECT OwnerId,COUNT(1) FROM dbo.DimUser AS DU
GROUP BY DU.OwnerId

SELECT * FROM dbo.DimUser AS DU

UPDATE dbo.DimUser
SET OwnerId=1
WHERE DBId<>1

SELECT COUNT(1),FH.Number FROM dbo.FactHeader AS FH
WHERE FH.DBId=3
GROUP BY FH.Number
HAVING COUNT(1)>1

SELECT COUNT(1) FROM Drug86.dbo.FacHeder AS FH
WHERE FH.State IN (0,10)


SELECT COUNT(1) FROM Drug86.dbo.FacRadif AS FR
INNER JOIN Drug86.dbo.FacHeder AS FH ON FH.CodeFacHeder = FR.CodeFacHeder
WHERE fh.State IN (0,10)
AND FR.Code IN (1,2)

SELECT COUNT(1) FROM Drug86.dbo.FacRadif AS FR
INNER JOIN Drug86.dbo.FacHeder AS FH ON FH.CodeFacHeder = FR.CodeFacHeder
WHERE fh.State IN (0,10)
AND FR.CodeM IS NULL
AND FR.Code NOT IN (1,2)


SELECT COUNT(1) FROM Drug86.dbo.FacRadif AS FR
INNER JOIN Drug86.dbo.FacHeder AS FH ON FH.CodeFacHeder = FR.CodeFacHeder
WHERE fh.State IN (0,10)
AND FR.CodeM IS NOT NULL
AND FR.Code NOT IN (1,2)

SELECT COUNT(1) FROM Drug86.dbo.FacRadif AS FR
INNER JOIN Drug86.dbo.FacHeder AS FH ON FH.CodeFacHeder = FR.CodeFacHeder
WHERE fh.State IN (0,10)
AND FR.CodeM IS NOT NULL
AND FR.Code NOT IN (1,2)


SELECT COUNT(1) FROM Drug86.dbo.FacHeder AS FH
INNER JOIN Drug86.dbo.Sandogh AS S ON S.Sh_Noskhe = FH.Sh_Noskhe
WHERE FH.State IN (0,10)
AND S.State=1


