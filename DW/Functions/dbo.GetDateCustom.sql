SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[GetDateCustom]()
RETURNS [DATETIME]
AS 
BEGIN
RETURN DATEADD(DAY,-1,GETDATE());
end
GO