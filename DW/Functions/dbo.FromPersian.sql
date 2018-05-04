SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO
CREATE FUNCTION [dbo].[FromPersian] (@Value [nvarchar] (max))
RETURNS [datetime]
WITH EXECUTE AS CALLER
EXTERNAL NAME [RPSIDW.HandyTools].[SqlDateConvertor].[FromPersian]
GO
