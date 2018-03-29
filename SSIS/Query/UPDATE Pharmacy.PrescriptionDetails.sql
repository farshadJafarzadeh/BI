Use RPSI
GO

UPDATE Pharmacy.PrescriptionDetails
SET InsertedDate=PrescriptionHeaders.InsertedDate
FROM  Pharmacy.PrescriptionDetails
INNER JOIN Pharmacy.PrescriptionHeaders ON PrescriptionHeaders.Id = PrescriptionDetails.HeaderId
WHERE PrescriptionDetails.InsertedDate IS NULL

GO

ALTER TABLE Pharmacy.PrescriptionDetails
ALTER COLUMN InsertedDate DATETIME NOT NULL