if exists (select * from sysobjects where name = 'G2J') 
DROP FUNCTION [G2J];

GO

CREATE FUNCTION [G2J] ( @intDate DATETIME )

RETURNS NVARCHAR(max)

BEGIN



DECLARE @shYear AS INT ,@shMonth AS INT ,@shDay AS INT ,@intYY AS INT ,@intMM AS INT ,@intDD AS INT ,@Kabiseh1 AS INT ,@Kabiseh2 AS INT ,@d1 AS INT ,@m1 AS INT, @shMaah AS NVARCHAR(max),@shRooz AS NVARCHAR(max),@DayCnt AS INT

DECLARE @DayDate AS NVARCHAR(max)



SET @intYY = DATEPART(yyyy, @intDate)



IF @intYY < 1000 SET @intYY = @intYY + 2000



SET @intMM = MONTH(@intDate)

SET @intDD = DAY(@intDate)

SET @shYear = @intYY - 622

SET @DayCnt = datepart(dw, '01/02/' + CONVERT(CHAR(4), @intYY))



SET @m1 = 1

SET @d1 = 1

SET @shMonth = 10

SET @shDay = 11



IF ( ( @intYY - 1993 ) % 4 = 0 ) SET @shDay = 12



WHILE ( @m1 != @intMM ) OR ( @d1 != @intDD )

BEGIN



  SET @d1 = @d1 + 1

  SET @DayCnt = @DayCnt + 1



  IF ( ( @intYY - 1992 ) % 4 = 0) SET @Kabiseh1 = 1 ELSE SET @Kabiseh1 = 0



  IF ( ( @shYear - 1371 ) % 4 = 0) SET @Kabiseh2 = 1 ELSE SET @Kabiseh2 = 0



  IF 

  (@d1 = 32 AND (@m1 = 1 OR @m1 = 3 OR @m1 = 5 OR @m1 = 7 OR @m1 = 8 OR @m1 = 10 OR @m1 = 12))

  OR

  (@d1 = 31 AND (@m1 = 4 OR @m1 = 6 OR @m1 = 9 OR @m1 = 11))

  OR

  (@d1 = 30 AND @m1 = 2 AND @Kabiseh1 = 1)

  OR

  (@d1 = 29 AND @m1 = 2 AND @Kabiseh1 = 0)

  BEGIN

    SET @m1 = @m1 + 1

    SET @d1 = 1

  END



  IF @m1 > 12

  BEGIN

    SET @intYY = @intYY + 1

    SET @m1 = 1

  END

  

  IF @DayCnt > 7 SET @DayCnt = 1



 SET @shDay = @shDay + 1

  

  IF

  (@shDay = 32 AND @shMonth < 7)

  OR

  (@shDay = 31 AND @shMonth > 6 AND @shMonth < 12)

  OR

  (@shDay = 31 AND @shMonth = 12 AND @Kabiseh2 = 1)

  OR

  (@shDay = 30 AND @shMonth = 12 AND @Kabiseh2 = 0)

  BEGIN

    SET @shMonth = @shMonth + 1

    SET @shDay = 1

  END



  IF @shMonth > 12

  BEGIN

    SET @shYear = @shYear + 1

    SET @shMonth = 1

  END

  

END



IF @shMonth=1 SET @shMaah=N'فروردین'

IF @shMonth=2 SET @shMaah=N'اردیبهشت'

IF @shMonth=3 SET @shMaah=N'خرداد'

IF @shMonth=4 SET @shMaah=N'تیر'

IF @shMonth=5 SET @shMaah=N'مرداد'

IF @shMonth=6 SET @shMaah=N'شهریور'

IF @shMonth=7 SET @shMaah=N'مهر'

IF @shMonth=8 SET @shMaah=N'آبان'

IF @shMonth=9 SET @shMaah=N'آذر'

IF @shMonth=10 SET @shMaah=N'دی'

IF @shMonth=11 SET @shMaah=N'بهمن'

IF @shMonth=12 SET @shMaah=N'اسفند'



IF @DayCnt=1 SET @shRooz=N'شنبه'

IF @DayCnt=2 SET @shRooz=N'یکشنبه'

IF @DayCnt=3 SET @shRooz=N'دوشنبه'

IF @DayCnt=4 SET @shRooz=N'سه‌شنبه'

IF @DayCnt=5 SET @shRooz=N'چهارشنبه'

IF @DayCnt=6 SET @shRooz=N'پنجشنبه'

IF @DayCnt=7 SET @shRooz=N'جمعه'



SET @DayDate = REPLACE(RIGHT(STR(@shYear, 4), 4), ' ', '0') + '/'+ REPLACE(STR(@shMonth, 2), ' ', '0') + '/' + REPLACE(( STR(@shDay,2) ), ' ', '0')

--1394/02/17



/*

SET @DayDate = @shRooz + ' ' + LTRIM(STR(@shDay,2)) + ' ' + @shMaah + ' ' + STR(@shYear,4)

--پنجشنبه 17 اردیبهشت 1394



SET @DayDate = LTRIM(STR(@shDay,2)) + ' ' + @shMaah + ' ' + STR(@shYear,4)

--17 اردیبهشت 1394



SET @DayDate = STR(@shYear,4) + '/'+LTRIM(STR(@shMonth,2)) + '/' + LTRIM(STR(@shDay,2))

--1394/2/17

*/

RETURN @DayDate

END
GO



if exists (select * from sysobjects where name = 'DimDate') 

	Drop table [DimDate];



CREATE TABLE [dbo].[DimDate](

	[DateKey] [int] NOT NULL primary key,

	[FullDateAlternateKey] [nvarchar](10) NOT NULL,

	[CalendarYear] [smallint] NOT NULL,

	[MonthNumberOfYear] [tinyint] NOT NULL,

	[MonthName] [nvarchar](10) NOT NULL,

	[DayOfWeek] [smallint] NOT NULL,

	[DayOfWeekName] [nvarchar](30) NOT NULL,

	[CalendarSeason] [tinyint] NOT NULL,

	[SeasonName] [nvarchar](10) NULL,



	[PersianDateKey] [int] NOT NULL,

	[PersianFullDateAlternateKey] [nvarchar](10) NOT NULL,

	[PersianCalendarYear] [smallint] NOT NULL,

	[PersianMonthNumberOfYear] [tinyint] NOT NULL,

	[PersianMonthName] [nvarchar](10) NOT NULL,

	[PersianDayOfWeek] [smallint] NOT NULL,

	[PersianDayOfWeekName] [nvarchar](30) NOT NULL,

	[PersianCalendarSeason] [tinyint] NOT NULL,

	[PersianSeasonName] [nvarchar](10) NULL

) ON [PRIMARY]

GO



Declare @date datetime = '2006-03-21'

Declare 

	@DateKey int, 

	@FullDateAlternateKey nvarchar(10), 

	@CalendarYear smallint, 

	@MonthNumberOfYear tinyint, 

	@MonthName nvarchar(10), 

	@DayOfWeek smallint,

	@DayOfWeekName nvarchar(30),

	@CalendarSeason tinyint, 

	@SeasonName nvarchar(10),



	@PersianDateKey int, 

	@PersianFullDateAlternateKey nvarchar(10), 

	@PersianCalendarYear smallint, 

	@PersianMonthNumberOfYear tinyint, 

	@PersianMonthName nvarchar(10), 

	@PersianDayOfWeek smallint,

	@PersianDayOfWeekName nvarchar(30),

	@PersianCalendarSeason tinyint, 

	@PersianSeasonName nvarchar(10)



While @date < '2018-01-01'

Begin

	SET @FullDateAlternateKey = convert(varchar(10), @date, 111)

	SET @DateKey = replace(@FullDateAlternateKey,'/','')

	SET @CalendarYear = substring(@FullDateAlternateKey , 1, 4)

	SET @MonthNumberOfYear = substring(@FullDateAlternateKey , 6, 2)



	SET @PersianFullDateAlternateKey = dbo.G2J (@date)  

	SET @PersianDateKey = replace(@PersianFullDateAlternateKey,'/','')

	SET @PersianCalendarYear = substring(@PersianFullDateAlternateKey , 1, 4)

	SET @PersianMonthNumberOfYear = substring(@PersianFullDateAlternateKey , 6, 2)



	If		@MonthNumberOfYear='12'	SET @MonthName='December'

	ELSE IF @MonthNumberOfYear='11' SET @MonthName='November'

	ELSE IF @MonthNumberOfYear='10' SET @MonthName='October'

	ELSE IF @MonthNumberOfYear='09' SET @MonthName='September'

	ELSE IF @MonthNumberOfYear='08' SET @MonthName='August'

	ELSE IF @MonthNumberOfYear='07' SET @MonthName='July'

	ELSE IF @MonthNumberOfYear='06' SET @MonthName='June'

	ELSE IF @MonthNumberOfYear='05' SET @MonthName='May'

	ELSE IF @MonthNumberOfYear='04' SET @MonthName='April'

	ELSE IF @MonthNumberOfYear='03' SET @MonthName='March'

	ELSE IF @MonthNumberOfYear='02' SET @MonthName='February'

	ELSE IF @MonthNumberOfYear='01' SET @MonthName='January'



	If		@PersianMonthNumberOfYear='12' SET @PersianMonthName=N'اسفند'

	ELSE IF @PersianMonthNumberOfYear='11' SET @PersianMonthName=N'بهمن'

	ELSE IF @PersianMonthNumberOfYear='10' SET @PersianMonthName=N'دی'

	ELSE IF @PersianMonthNumberOfYear='09' SET @PersianMonthName=N'آذر'

	ELSE IF @PersianMonthNumberOfYear='08' SET @PersianMonthName=N'آبان'

	ELSE IF @PersianMonthNumberOfYear='07' SET @PersianMonthName=N'مهر'

	ELSE IF @PersianMonthNumberOfYear='06' SET @PersianMonthName=N'شهریور'

	ELSE IF @PersianMonthNumberOfYear='05' SET @PersianMonthName=N'مرداد'

	ELSE IF @PersianMonthNumberOfYear='04' SET @PersianMonthName=N'تیر'

	ELSE IF @PersianMonthNumberOfYear='03' SET @PersianMonthName=N'خرداد'

	ELSE IF @PersianMonthNumberOfYear='02' SET @PersianMonthName=N'اردیبهشت'

	ELSE IF @PersianMonthNumberOfYear='01' SET @PersianMonthName=N'فروردین'



	if @MonthNumberOfYear between 1 and 3

	begin

		set @SeasonName = 'Spring'

		set @CalendarSeason = 1

	end

    else		

	if @MonthNumberOfYear between 4 and 6

	begin

		set @SeasonName = 'Summer'

		set @CalendarSeason = 2

	end

    else		

	if @MonthNumberOfYear between 7 and 9

	begin

		set @SeasonName = 'Autumn'

		set @CalendarSeason = 3

	end

    else		

	if @MonthNumberOfYear between 10 and 12

	begin

		set @SeasonName = 'Winter'

		set @CalendarSeason = 4

	end



	---------------------------

	if @PersianMonthNumberOfYear between 1 and 3

	begin

		set @PersianSeasonName = N'بهار'

		set @PersianCalendarSeason = 1

	end

    else		

	if @PersianMonthNumberOfYear between 4 and 6

	begin

		set @PersianSeasonName = N'تابستان'

		set @PersianCalendarSeason = 2

	end

    else		

	if @PersianMonthNumberOfYear between 7 and 9

	begin

		set @PersianSeasonName = N'پاییز'

		set @PersianCalendarSeason = 3

	end

    else		

	if @PersianMonthNumberOfYear between 10 and 12

	begin

		set @PersianSeasonName = N'زمستان'

		set @PersianCalendarSeason = 4

	end



	Set @DayOfWeek = datepart(dw,@date)

	Set @DayOfWeekName =  datename(dw,@date)



	Set @PersianDayOfWeek = iif(@DayOfWeek + 1 = 8, 1, @DayOfWeek + 1)

	if @PersianDayOfWeek = 1

		Set @PersianDayOfWeekName =  N'شنبه'

	else if @PersianDayOfWeek = 2

		Set @PersianDayOfWeekName =  N'یکشنبه'

	else if @PersianDayOfWeek = 3

		Set @PersianDayOfWeekName =  N'دوشنبه'

	else if @PersianDayOfWeek = 4

		Set @PersianDayOfWeekName =  N'سه شنبه'

	else if @PersianDayOfWeek = 5

		Set @PersianDayOfWeekName =  N'چهارشنبه'

	else if @PersianDayOfWeek = 6

		Set @PersianDayOfWeekName =  N'پنجشنبه'

	else if @PersianDayOfWeek = 7

		Set @PersianDayOfWeekName =  N'جمعه'



	Insert DimDate

		(

		[DateKey]

		,[FullDateAlternateKey]

		,[CalendarYear]

		,[MonthNumberOfYear]

		,[MonthName]

		,[DayOfWeek]

		,[DayOfWeekName]

		,[CalendarSeason]

		,[SeasonName]

		,[PersianDateKey]

		,[PersianFullDateAlternateKey]

		,[PersianCalendarYear]

		,[PersianMonthNumberOfYear]

		,[PersianMonthName]

		,[PersianDayOfWeek]

		,[PersianDayOfWeekName]

		,[PersianCalendarSeason]

		,[PersianSeasonName]

		)

	Values (@DateKey, @FullDateAlternateKey, @CalendarYear, @MonthNumberOfYear, @MonthName, @DayOfWeek, @DayOfWeekName, @CalendarSeason, @SeasonName,

			@PersianDateKey, @PersianFullDateAlternateKey, @PersianCalendarYear, @PersianMonthNumberOfYear, @PersianMonthName, @PersianDayOfWeek, @PersianDayOfWeekName, @PersianCalendarSeason, @PersianSeasonName)



	set @date = dateadd(d, 1, @date) 

End
