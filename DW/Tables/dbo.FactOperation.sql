CREATE TABLE [dbo].[FactOperation]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[HeaderId] [int] NOT NULL,
[OperationTypeId] [int] NOT NULL,
[OperationValue] [real] NOT NULL,
[AuthorizedBy] [int] NULL,
[AuthorizedDate] [int] NULL,
[AuthorizedTime] [time] NULL,
[ActionBy] [int] NOT NULL,
[ActionDate] [int] NOT NULL,
[ActionTime] [time] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactOperation] ADD CONSTRAINT [PK_FactOperation] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactOperation] ADD CONSTRAINT [FK_FactOperation_DimDate_Action] FOREIGN KEY ([ActionDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactOperation] ADD CONSTRAINT [FK_FactOperation_DimDate_Authorize] FOREIGN KEY ([AuthorizedDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactOperation] ADD CONSTRAINT [FK_FactOperation_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[FactOperation] ADD CONSTRAINT [FK_FactOperation_DimOperationType] FOREIGN KEY ([OperationTypeId]) REFERENCES [dbo].[DimOperationType] ([Id])
GO
ALTER TABLE [dbo].[FactOperation] ADD CONSTRAINT [FK_FactOperation_DimUser_Action] FOREIGN KEY ([ActionBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactOperation] ADD CONSTRAINT [FK_FactOperation_DimUser_Authorize] FOREIGN KEY ([AuthorizedBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactOperation] ADD CONSTRAINT [FK_FactOperation_FactHeader] FOREIGN KEY ([HeaderId]) REFERENCES [dbo].[FactHeader] ([Id])
GO
