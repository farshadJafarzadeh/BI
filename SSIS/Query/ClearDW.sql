USE RPSIDW;
GO
DECLARE @DbId INT=3

DELETE dbo.FactOperation
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.FactOperation',RESEED, 0)

DELETE dbo.DimOperationType
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimOperationType',RESEED, 0)
SELECT * FROM dbo.DimDB AS DD
SELECT * FROM dbo.FactDetail AS FD
WHERE dbid=2
DELETE dbo.FactTransaction
FROM dbo.FactTransaction
WHERE @DbId IS NULL OR FactTransaction.DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.FactTransaction',RESEED, 0)

DELETE dbo.FactDetail
--DBCC CHECKIDENT ('RPSIDW.dbo.FactDetail',RESEED, 0)


DELETE dbo.FactHeader
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.FactHeader',RESEED, 0)


DELETE dbo.DimProduct
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimProduct',RESEED, 0)



DELETE dbo.DimProductGroup
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimProductGroup',RESEED, 0)

DELETE dbo.DimInsurance
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimInsurance',RESEED, 0)

DELETE dbo.DimInsuranceGroup
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimInsuranceGroup',RESEED, 0)

DELETE dbo.DimPhysician
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimPhysician',RESEED, 0)


DELETE dbo.DimPhysicianSpeciality
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimPhysicianSpeciality',RESEED, 0)


DELETE dbo.DimPhysicianLevel
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimPhysicianLevel',RESEED, 0)

DELETE dbo.DimFinancialYear
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimFinancialYear',RESEED, 0)

DELETE dbo.DimSystem
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimSystem',RESEED, 0)

DELETE dbo.DimUser
WHERE @DbId IS NULL OR DBId=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimUser',RESEED, 0)


DELETE dbo.DimOwner
--DBCC CHECKIDENT ('RPSIDW.dbo.DimOwner',RESEED, 0)


DELETE dbo.DimDB
WHERE @DbId IS NULL OR Id=@DbId;
--DBCC CHECKIDENT ('RPSIDW.dbo.DimDB',RESEED, 0)

SELECT * FROM dbo.DimDB AS DD
--DELETE dbo.DimDate;



