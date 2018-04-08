/****** Object:  LinkedServer [192.168.7.100]    Script Date: 02/12/2017 10:35:50 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'192.168.7.100', @srvproduct=N'Msh95', @provider=N'SQLNCLI', @datasrc=N'192.168.7.100', 
@provstr=N'Provider=SQLNCLI10.1;Data Source=192.168.7.100;Persist Security Info=True;Password=124444;User ID=sa;Initial Catalog=msh95;Connection Timeout=90000', @catalog=N'msh95'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'192.168.7.100',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='124444'

GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'collation compatible', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'192.168.7.100', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


