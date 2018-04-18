USE RPSIDW
GO

CREATE FUNCTION NotMoreThanINT
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