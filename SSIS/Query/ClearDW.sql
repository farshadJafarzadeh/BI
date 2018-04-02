USE RPSIDW;
GO

DELETE dbo.FactDetail;
TRUNCATE TABLE dbo.FactDetail;
GO

DELETE dbo.FactHeader;
TRUNCATE TABLE dbo.FactHeader;

GO
DELETE dbo.DimProduct;
TRUNCATE TABLE dbo.DimProduct;

GO

DELETE dbo.DimProductGroup;
TRUNCATE TABLE dbo.DimProductGroup;
GO
DELETE dbo.DimInsurance;
TRUNCATE TABLE dbo.DimInsurance;
GO
DELETE dbo.DimInsuranceGroup;
TRUNCATE TABLE dbo.DimInsuranceGroup;
GO
DELETE dbo.DimFinancialYear;
TRUNCATE TABLE dbo.DimFinancialYear;
GO
DELETE dbo.DimSystem;
TRUNCATE TABLE dbo.DimSystem;
GO
