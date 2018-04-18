SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[NotMoreThanINT]
(
    @Value INT,
    @Max INT
)
RETURNS INT
BEGIN
    RETURN CASE
               WHEN @Value > @Max THEN
                   @Max
               ELSE
                   @Value
           END;
END;
GO
