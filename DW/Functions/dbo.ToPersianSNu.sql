SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO





CREATE FUNCTION [dbo].[ToPersianSNu]
(
    @Value DATE
)
RETURNS TINYINT
AS
BEGIN
    RETURN
    (
        SELECT TOP (1)
               (PersianCalendarSeason)


        FROM dbo.DimDate
        WHERE [Date] = @Value
    );

END;
GO
