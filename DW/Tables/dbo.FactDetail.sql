CREATE TABLE [dbo].[FactDetail]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[HeaderId] [int] NOT NULL,
[DetailId] [int] NULL,
[Type] [nvarchar] (50) COLLATE Persian_100_CI_AI NOT NULL,
[ProductId] [int] NOT NULL,
[Quantity] [int] NOT NULL,
[Price] [real] NOT NULL,
[InsurancePercent] [real] NULL,
[InsurancePrice] [real] NOT NULL,
[InsuranceShare] [real] NOT NULL,
[PatientShare] [real] NOT NULL,
[AddFee] [real] NOT NULL CONSTRAINT [DF_Details_AddFee] DEFAULT ((0)),
[TotalFullCost] [decimal] (38, 3) NULL,
[InsertedBy] [int] NOT NULL,
[InsertedDate] [int] NOT NULL,
[InsertedTime] [time] NOT NULL,
[DBId] [int] NOT NULL,
[OldId] [int] NULL,
[TotalPrice] AS ([Price]*[Quantity]) PERSISTED,
[TotalInsurancePrice] AS ([InsurancePrice]*[Quantity]) PERSISTED,
[TotalInsuranceShare] AS ([InsuranceShare]*[Quantity]) PERSISTED,
[TotalPatientShare] AS ([PatientShare]*[Quantity]) PERSISTED,
[TotalAddFee] AS ([AddFee]*[Quantity]) PERSISTED,
[FullCost] AS (isnull([TotalFullCost]/nullif([Quantity],(0)),(0))) PERSISTED NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactDetail] ADD CONSTRAINT [PK_Details] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactDetail] ADD CONSTRAINT [FK_Details_Products] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[DimProduct] ([Id])
GO
ALTER TABLE [dbo].[FactDetail] ADD CONSTRAINT [FK_FactDetail_DimDate] FOREIGN KEY ([InsertedDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactDetail] ADD CONSTRAINT [FK_FactDetail_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[FactDetail] ADD CONSTRAINT [FK_FactDetail_DimUser] FOREIGN KEY ([InsertedBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactDetail] ADD CONSTRAINT [FK_FactDetail_FactDetail] FOREIGN KEY ([DetailId]) REFERENCES [dbo].[FactDetail] ([Id])
GO
ALTER TABLE [dbo].[FactDetail] ADD CONSTRAINT [FK_FactDetail_FactHeader] FOREIGN KEY ([HeaderId]) REFERENCES [dbo].[FactHeader] ([Id])
GO
