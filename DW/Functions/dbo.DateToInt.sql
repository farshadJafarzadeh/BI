SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[DateToInt]
(
    @D DATETIME
)
RETURNS INT
AS
BEGIN
    RETURN REPLACE(CONVERT(VARCHAR(10), @D, 111), N'/', N'');
END;
GO
