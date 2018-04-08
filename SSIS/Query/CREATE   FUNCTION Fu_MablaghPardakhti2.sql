USE Drug85
GO

SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
CREATE   FUNCTION Fu_MablaghPardakhti2 (@Sh_Noskhe int ,@Datemin int , @DateMax  int )
RETURNS   Float AS  
BEGIN 
Declare @Ret Float  

-----------------------‰ﬁœÌ ’‰œÊﬁ œ— «„«— ⁄„·ﬂ—œ ”«“„«‰----------------------
set @Ret=(    select sum(isnull(Mablagh,0)) from  Sandogh where 
Sh_Noskhe=@Sh_Noskhe and state=1   and isnull(KheyrieCode,0)=0  
and DateDaryaft between @Datemin and  @DateMax  
)


return @Ret

END



GO

