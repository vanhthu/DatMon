CREATE TYPE [dbo].[OrderDetails] AS TABLE(
	[orderNo] [varchar](MAX) NULL,
	[productID] [int] NULL,
	[quantity] [int] NULL,
	[userID] [int] NULL,
	[status] [nvarchar](50) NULL,
	[paymentID] [int] NULL,
	[orderDate] [datetime] NULL
)
