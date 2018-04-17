SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[NotMoreThan]
(
    @Value REAL,
    @Max REAL
)
RETURNS REAL
BEGIN
    RETURN CASE
               WHEN @Value > @Max THEN
                   @Max
               ELSE
                   @Value
           END;
END;
GO
