USE RPSIDW
GO

CREATE FUNCTION NotLessThan
(
    @Value REAL,
    @Min REAL
)
RETURNS REAL
BEGIN
    RETURN CASE
               WHEN @Value > @Min THEN
                   @Min
               ELSE
                   @Value
           END;
END;