UPDATE dbo.DimFinancialYear
set SystemId=2
WHERE id BETWEEN 31 AND 41

UPDATE dbo.DimFinancialYear
set SystemId=4
WHERE id BETWEEN 44 AND 53


SELECT * FROM dbo.DimSystem AS DS