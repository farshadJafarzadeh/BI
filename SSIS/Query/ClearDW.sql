USE RPSIDW;
GO

DELETE dbo.FactOperation;
DBCC CHECKIDENT ('RPSIDW.dbo.FactOperation',RESEED, 0)

DELETE dbo.DimOperationType;
DBCC CHECKIDENT ('RPSIDW.dbo.DimOperationType',RESEED, 0)


DELETE dbo.FactTransaction;
DBCC CHECKIDENT ('RPSIDW.dbo.FactTransaction',RESEED, 0)

DELETE dbo.FactDetail;
DBCC CHECKIDENT ('RPSIDW.dbo.FactDetail',RESEED, 0)


DELETE dbo.FactHeader;
DBCC CHECKIDENT ('RPSIDW.dbo.FactHeader',RESEED, 0)


DELETE dbo.DimProduct;
DBCC CHECKIDENT ('RPSIDW.dbo.DimProduct',RESEED, 0)



DELETE dbo.DimProductGroup;
DBCC CHECKIDENT ('RPSIDW.dbo.DimProductGroup',RESEED, 0)

DELETE dbo.DimInsurance;
DBCC CHECKIDENT ('RPSIDW.dbo.DimInsurance',RESEED, 0)

DELETE dbo.DimInsuranceGroup;
DBCC CHECKIDENT ('RPSIDW.dbo.DimInsuranceGroup',RESEED, 0)

DELETE dbo.DimFinancialYear;
DBCC CHECKIDENT ('RPSIDW.dbo.DimFinancialYear',RESEED, 0)

DELETE dbo.DimSystem;
DBCC CHECKIDENT ('RPSIDW.dbo.DimSystem',RESEED, 0)

DELETE dbo.DimUser;
DBCC CHECKIDENT ('RPSIDW.dbo.DimUser',RESEED, 0)


DELETE dbo.DimOwner;
DBCC CHECKIDENT ('RPSIDW.dbo.DimOwner',RESEED, 0)


DELETE dbo.DimDB;
DBCC CHECKIDENT ('RPSIDW.dbo.DimDB',RESEED, 0)

--DELETE dbo.DimDate;



