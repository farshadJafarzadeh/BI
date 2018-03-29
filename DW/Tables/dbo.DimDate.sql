CREATE TABLE [dbo].[DimDate]
(
[DateKey] [int] NOT NULL,
[FullDateAlternateKey] [nvarchar] (10) COLLATE Persian_100_CI_AI NOT NULL,
[CalendarYear] [smallint] NOT NULL,
[MonthNumberOfYear] [tinyint] NOT NULL,
[MonthName] [nvarchar] (10) COLLATE Persian_100_CI_AI NOT NULL,
[DayOfWeek] [smallint] NOT NULL,
[DayOfWeekName] [nvarchar] (30) COLLATE Persian_100_CI_AI NOT NULL,
[CalendarSeason] [tinyint] NOT NULL,
[SeasonName] [nvarchar] (10) COLLATE Persian_100_CI_AI NULL,
[PersianDateKey] [int] NOT NULL,
[PersianFullDateAlternateKey] [nvarchar] (10) COLLATE Persian_100_CI_AI NOT NULL,
[PersianCalendarYear] [smallint] NOT NULL,
[PersianMonthNumberOfYear] [tinyint] NOT NULL,
[PersianMonthName] [nvarchar] (10) COLLATE Persian_100_CI_AI NOT NULL,
[PersianDayOfWeek] [smallint] NOT NULL,
[PersianDayOfWeekName] [nvarchar] (30) COLLATE Persian_100_CI_AI NOT NULL,
[PersianCalendarSeason] [tinyint] NOT NULL,
[PersianSeasonName] [nvarchar] (10) COLLATE Persian_100_CI_AI NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimDate] ADD CONSTRAINT [PK__DimDate__40DF45E3964014CA] PRIMARY KEY CLUSTERED  ([DateKey]) ON [PRIMARY]
GO
