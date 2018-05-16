SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[InsuracneGroup_GetNextPrev]
    @Direction VARCHAR(10) ,
    @Id INT = 0
AS
    BEGIN
		

        IF ( @Direction = 'next' )
            SELECT TOP 1
                    Id
            FROM    dbo.diminsurancegroup
            WHERE   dbo.diminsurancegroup.Id > @Id
            ORDER BY Id; 

        IF ( @Direction = 'prev' )
            SELECT TOP 1
                    Id
            FROM    dbo.diminsurancegroup
            WHERE   dbo.diminsurancegroup.Id < @Id
            ORDER BY Id DESC;
            
    END;
GO
