USE RPSIDW
GO

CREATE FUNCTION NotMoreThan
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