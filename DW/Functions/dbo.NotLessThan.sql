SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[NotLessThan]
(
    @Value REAL,
    @Min REAL
)
RETURNS REAL
BEGIN
    RETURN CASE
               WHEN @Value < @Min THEN
                   @Min
               ELSE
                   @Value
           END;
END;
GO
