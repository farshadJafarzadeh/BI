SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[NotLessThanINT]
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
GO
