USE RPSIDW;
GO

CREATE FUNCTION NotLessThanINT
(
    @Value INT,
    @Min INT
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