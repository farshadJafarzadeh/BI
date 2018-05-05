CREATE TABLE [dbo].[DimDate]
(
[DateKey] [int] NOT NULL,
[FullDateAlternateKey] [nvarchar] (10) COLLATE Persian_100_CI_AS NOT NULL,
[CalendarYear] [smallint] NOT NULL,
[MonthNumberOfYear] [tinyint] NOT NULL,
[MonthName] [nvarchar] (10) COLLATE Persian_100_CI_AS NOT NULL,
[DayOfWeek] [smallint] NOT NULL,
[DayOfWeekName] [nvarchar] (30) COLLATE Persian_100_CI_AS NOT NULL,
[CalendarSeason] [tinyint] NOT NULL,
[SeasonName] [nvarchar] (10) COLLATE Persian_100_CI_AS NULL,
[PersianDateKey] [int] NOT NULL,
[PersianFullDateAlternateKey] [nvarchar] (10) COLLATE Persian_100_CI_AS NOT NULL,
[PersianCalendarYear] [smallint] NOT NULL,
[PersianMonthNumberOfYear] [tinyint] NOT NULL,
[PersianMonthName] [nvarchar] (10) COLLATE Persian_100_CI_AS NOT NULL,
[PersianDayOfWeek] [smallint] NOT NULL,
[PersianDayOfWeekName] [nvarchar] (30) COLLATE Persian_100_CI_AS NOT NULL,
[PersianCalendarSeason] [tinyint] NOT NULL,
[PersianSeasonName] [nvarchar] (10) COLLATE Persian_100_CI_AS NULL,
[Date] [date] NOT NULL,
[PersianRunningYear] AS (substring([dbo].[ToPersian](getdate()),(1),(4))-[PersianCalendarYear]),
[PersianRunningSeason] AS ((substring([dbo].[ToPersian](getdate()),(1),(4))-[PersianCalendarYear])*(4)+(CONVERT([int],[dbo].[ToPersianSNu](getdate()),(0))-CONVERT([int],[dbo].[ToPersianSNu]([Date]),(0)))),
[PersianRunningMonth] AS ((substring([dbo].[ToPersian](getdate()),(1),(4))-[PersianCalendarYear])*(12)+(substring([dbo].[ToPersian](getdate()),(6),(2))-CONVERT([smallint],[PersianMonthNumberOfYear],(0)))),
[PersianRunningWeek] AS (datediff(week,dateadd(day,(1),[Date]),CONVERT([date],dateadd(day,(7)-[dbo].[ToPersianWNu](getdate()),getdate()),(0)))),
[RunningDay] AS (datediff(day,[Date],getdate())),
[PersianCurrentYear] AS (case  when substring([dbo].[ToPersian](getdate()),(1),(4))=[PersianCalendarYear] then (1) else (0) end),
[PersianCurrentSeason] AS (case  when substring([dbo].[ToPersian](getdate()),(1),(4))=[PersianCalendarYear] AND CONVERT([int],[dbo].[ToPersianSNu](getdate()),(0))=CONVERT([int],[dbo].[ToPersianSNu]([Date]),(0)) then (1) else (0) end),
[PersianCurrentMonth] AS (case  when substring([dbo].[ToPersian](getdate()),(1),(4))=[PersianCalendarYear] AND substring([dbo].[ToPersian](getdate()),(6),(2))=CONVERT([smallint],[PersianMonthNumberOfYear],(0)) then (1) else (0) end),
[PersianCurrentWeek] AS (case  when [Date]>=CONVERT([date],dateadd(day,(-[dbo].[ToPersianWNu](getdate()))+(1),getdate()),(0)) AND [Date]<=CONVERT([date],dateadd(day,(7)-[dbo].[ToPersianWNu](getdate()),getdate()),(0)) then (1) else (0) end),
[CurrentDay] AS (case  when [Date]=CONVERT([date],getdate(),(0)) then (1) else (0) end)
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimDate] ADD CONSTRAINT [PK__DimDate__40DF45E3FCB298E1] PRIMARY KEY CLUSTERED  ([DateKey]) ON [PRIMARY]
GO
