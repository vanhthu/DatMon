CREATE DATABASE DATMON
GO

USE DATMON
GO

CREATE TABLE [USER](
	[userID] [int] PRIMARY KEY IDENTITY (1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL UNIQUE,
	[mobile] [varchar](50) NULL,
	[email] [nvarchar](50) NULL UNIQUE,
	[address] [nvarchar](MAX) NULL,
	[password] [nvarchar](50) NULL,
	[imageURL] [nvarchar](MAX) NULL,
	[createdDate] [datetime] NULL -- ngày tạo tài khoản
)


CREATE TABLE [CONTACT](
	[contactID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[subject] [nvarchar](200) NULL,
	[message] [nvarchar](MAX) NULL,
	[createdDate] [datetime] NULL 
)


CREATE TABLE [CATEGORIES](
	[categoryID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[imageURL] [varchar](MAX) NULL,
	[isActive] [bit] NULL, -- trạng thái hoạt động của món ăn: true=>hiện cho người dùng thấy, false=>không hiện
	[createdDate] [datetime] NULL
)

CREATE TABLE [PRODUCTS](
	[productID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](MAX) NULL,
	[price] [decimal](18, 3) NULL, -- 123.456
	[quantity] [int] NULL,
	[imageURL] [varchar](MAX) NULL,
	[categoryID] [int] NULL, --FK
	[isActive] [bit] NULL,
	[createdDate] [datetime] NULL
)


CREATE TABLE [CARTS](
	[cartID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[productID] [int] NULL, --FK
	[quantity] [int] NULL,
	[userID] [int] NULL -- FK
)

CREATE TABLE [ORDERS](
	[orderDetailsID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[orderNo] [nvarchar](MAX) NULL, -- mã số đơn hàng
	[productID] [int] NULL, --FK
	[quantity] [int] NULL,
	[userID] [int] NULL, --FK
	[status] [nvarchar](50) NULL,
	[paymentID] [int] NULL, --FK: mã thanh toán
	[orderDate] [datetime] NULL -- ngày đặt hàng
)

CREATE TABLE [PAYMENT](
	[paymentID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[cardNo] [varchar](50) NULL, -- số thẻ
	[expiryDate] [varchar](50) NULL,
	[CVVNo] [int] NULL,
	[address] [nvarchar](MAX) NULL,
	[paymentMode] [varchar](50) NULL -- chế độ thanh toán: card/cod
)
