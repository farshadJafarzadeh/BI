CREATE TABLE [dbo].[FactTransaction]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[HeaderId] [int] NOT NULL,
[Action] [int] NOT NULL,
[ActionBy] [int] NOT NULL,
[ActionDate] [int] NOT NULL,
[ActionTime] [time] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [nchar] (10) COLLATE Persian_100_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactTransaction] ADD CONSTRAINT [PK_FactTransaction] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactTransaction] ADD CONSTRAINT [FK_FactTransaction_DimDate] FOREIGN KEY ([ActionDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactTransaction] ADD CONSTRAINT [FK_FactTransaction_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[FactTransaction] ADD CONSTRAINT [FK_FactTransaction_DimUser] FOREIGN KEY ([ActionBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactTransaction] ADD CONSTRAINT [FK_FactTransaction_FactHeader] FOREIGN KEY ([HeaderId]) REFERENCES [dbo].[FactHeader] ([Id])
GO
