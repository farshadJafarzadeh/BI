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
[PersianSeasonName] [nvarchar] (10) COLLATE Persian_100_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimDate] ADD CONSTRAINT [PK__DimDate__40DF45E3FCB298E1] PRIMARY KEY CLUSTERED  ([DateKey]) ON [PRIMARY]
GO
