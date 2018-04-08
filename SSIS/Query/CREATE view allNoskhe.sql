USE Drug85
GO

SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
CREATE view allNoskhe as 
 
SELECT     
sh_noskhe ,
DateFac, 
DateFac / 100 mah ,
Sazeman  , 
               isnull(dbo.FacHeder.SahmBimar,0)   AS SahmBimar, 
               isnull(dbo.FacHeder.EzafeDaryafty,0)   AS EzafeDariafty , 
               case when isnull(dbo.Sazeman.HaghFani,0) = 0 then  isnull(dbo.FacHeder.HaghFani,0) else 0 end   AS HaghFani, 
               isnull(dbo.FacHeder.SahmSazeman,0)   as  SahmSazeman,
               
                    isnull(dbo.FacHeder.SahmBimar,0) +  
                    isnull(dbo.FacHeder.SahmSazeman,0) +
                    isnull(dbo.FacHeder.EzafeDaryafty,0) + 
                    case when isnull(dbo.Sazeman.HaghFani,0)=0 then  isnull(dbo.FacHeder.HaghFani,0)  else 0 end 
                      as  JamKolNoskhe,
           
               ISNULL(dbo.Fu_MablaghPardakhti2 (Sh_Noskhe,0 , 999999   )  ,0)   Naghdi,
               isnull(dbo.Fu_MablaghTakhfif    (Sh_Noskhe,0 , 999999   )  ,0)   Takhfif
 
FROM    dbo.FacHeder INNER  JOIN 
dbo.Sazeman ON ISNULL(dbo.Sazeman.CodeSazeMan,55) = ISNULL(dbo.FacHeder.CodeSazeMan,55)
where       dbo.FacHeder.SH_Noskhe IN   ( SELECT  SH_Noskhe FROM sandogh )
       and state in ('0','8') 

  
GO


