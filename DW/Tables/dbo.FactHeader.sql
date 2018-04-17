CREATE TABLE [dbo].[FactHeader]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[FinancialYearId] [int] NOT NULL,
[InsuranceId] [int] NOT NULL,
[PhysicianId] [int] NULL,
[Type] [nvarchar] (50) COLLATE Persian_100_CI_AI NOT NULL,
[Number] [int] NOT NULL,
[CompletedRowNumber] [int] NULL,
[ReceptionDate] [int] NOT NULL,
[ReceptionTime] [time] NOT NULL,
[PrescriptionDate] [date] NULL,
[CreditDate] [date] NULL,
[InsertedBy] [int] NOT NULL,
[InsertedDate] [int] NOT NULL,
[InsertedTime] [time] NOT NULL,
[AdmissionBy] [int] NOT NULL,
[AdmissionDate] [int] NOT NULL,
[AdmissionTime] [time] NOT NULL,
[InsuranceApprovedBy] [int] NULL,
[InsuranceApprovedDate] [int] NULL,
[InsuranceApprovedTime] [time] NULL,
[PickedUpBy] [int] NULL,
[PickedUpDate] [int] NULL,
[PickedUpTime] [time] NULL,
[DeliveredBy] [int] NULL,
[DeliveredDate] [int] NULL,
[DeliveredTime] [time] NULL,
[AuthorizedBy] [int] NULL,
[AuthorizedDate] [int] NULL,
[AuthorizedTime] [time] NULL,
[Value] [real] NOT NULL,
[Paid] [real] NOT NULL CONSTRAINT [DF_FactHeader_Paid] DEFAULT ((0)),
[PaymentStatus] AS (case  when [Value]-[Paid]<(0) then (-1) when [Value]-[Paid]>(0) then (1) else (0) end),
[Remaining] AS ([Value]-[Paid]),
[Settled] AS (case  when [Value]-[Paid]=(0) then (1) else (0) end),
[Locked] [bit] NOT NULL CONSTRAINT [DF_FactHeader_Locked] DEFAULT ((0)),
[DBId] [int] NOT NULL,
[OldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [PK_Headers] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimDate_Admission] FOREIGN KEY ([AdmissionDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimDate_Authorize] FOREIGN KEY ([AuthorizedDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimDate_Deliver] FOREIGN KEY ([DeliveredDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimDate_Insert] FOREIGN KEY ([InsertedDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimDate_InsuranceApprove] FOREIGN KEY ([InsuranceApprovedDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimDate_PickUp] FOREIGN KEY ([PickedUpDate]) REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimDB] FOREIGN KEY ([DBId]) REFERENCES [dbo].[DimDB] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimPhysician] FOREIGN KEY ([PhysicianId]) REFERENCES [dbo].[DimPhysician] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimUser_Admission] FOREIGN KEY ([AdmissionBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimUser_Authorize] FOREIGN KEY ([AuthorizedBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimUser_Deliver] FOREIGN KEY ([DeliveredBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimUser_Insert] FOREIGN KEY ([InsertedBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimUser_InsuranceApprove] FOREIGN KEY ([InsuranceApprovedBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_FactHeader_DimUser_PickUp] FOREIGN KEY ([PickedUpBy]) REFERENCES [dbo].[DimUser] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_Headers_FinancialYears] FOREIGN KEY ([FinancialYearId]) REFERENCES [dbo].[DimFinancialYear] ([Id])
GO
ALTER TABLE [dbo].[FactHeader] ADD CONSTRAINT [FK_Headers_Insurances] FOREIGN KEY ([InsuranceId]) REFERENCES [dbo].[DimInsurance] ([Id])
GO
