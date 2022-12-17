/*
 Navicat Premium Data Transfer

 Source Server         : SQLServer
 Source Server Type    : SQL Server
 Source Server Version : 15002000
 Source Catalog        : Store
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 15002000
 File Encoding         : 65001

 Date: 17/12/2022 21:39:33
*/


-- ----------------------------
-- Table structure for Category
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type IN ('U'))
	DROP TABLE [dbo].[Category]
GO

CREATE TABLE [dbo].[Category] (
  [id_category] int  IDENTITY(1,1) NOT NULL,
  [category] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[Category] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for City
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[City]') AND type IN ('U'))
	DROP TABLE [dbo].[City]
GO

CREATE TABLE [dbo].[City] (
  [id_city] int  IDENTITY(1,1) NOT NULL,
  [city] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[City] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Customer
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type IN ('U'))
	DROP TABLE [dbo].[Customer]
GO

CREATE TABLE [dbo].[Customer] (
  [id_customer] int  IDENTITY(1,1) NOT NULL,
  [name] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [surname] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [patronymic] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [id_city] int  NOT NULL,
  [address] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [phone] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL
)
GO

ALTER TABLE [dbo].[Customer] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Order
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Order]') AND type IN ('U'))
	DROP TABLE [dbo].[Order]
GO

CREATE TABLE [dbo].[Order] (
  [id_order] int  IDENTITY(1,1) NOT NULL,
  [id_customer] int  NOT NULL,
  [date_time] datetime  NOT NULL
)
GO

ALTER TABLE [dbo].[Order] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for OrderProduct
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderProduct]') AND type IN ('U'))
	DROP TABLE [dbo].[OrderProduct]
GO

CREATE TABLE [dbo].[OrderProduct] (
  [id_orderProduct] int  IDENTITY(1,1) NOT NULL,
  [id_order] int  NOT NULL,
  [id_product] int  NOT NULL
)
GO

ALTER TABLE [dbo].[OrderProduct] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Product
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type IN ('U'))
	DROP TABLE [dbo].[Product]
GO

CREATE TABLE [dbo].[Product] (
  [id_product] int  IDENTITY(1,1) NOT NULL,
  [name] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [description] text COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [price] int  NOT NULL,
  [id_category] int  NOT NULL,
  [is_available] bit  NULL
)
GO

ALTER TABLE [dbo].[Product] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for Purchasing
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Purchasing]') AND type IN ('U'))
	DROP TABLE [dbo].[Purchasing]
GO

CREATE TABLE [dbo].[Purchasing] (
  [id_purchasing] int  NOT NULL,
  [customer] text COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [phone] varchar(255) COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [product] text COLLATE Cyrillic_General_100_CI_AS  NOT NULL,
  [date] text COLLATE Cyrillic_General_100_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[Purchasing] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- View structure for Query
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Query]') AND type IN ('V'))
	DROP VIEW [dbo].[Query]
GO

CREATE VIEW [dbo].[Query] AS SELECT
	OrderProduct.id_orderProduct as "id", 
	concat(Customer.surname,' ', 	Customer.name,' ', 	Customer.patronymic) as "customer", 
	Customer.phone as "phone", 
	concat(Product.name, ' ', 	Product.description, ' ') as "product",
	[Order].date_time as "date"
FROM
	dbo.OrderProduct
	INNER JOIN
	dbo.Product
	ON 
		OrderProduct.id_product = Product.id_product
	INNER JOIN
	dbo.[Order]
	ON 
		OrderProduct.id_order = [Order].id_order
	INNER JOIN
	dbo.Customer
	ON 
		[Order].id_customer = Customer.id_customer
GO


-- ----------------------------
-- Auto increment value for Category
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Category]', RESEED, 2)
GO


-- ----------------------------
-- Primary Key structure for table Category
-- ----------------------------
ALTER TABLE [dbo].[Category] ADD CONSTRAINT [PK__Untitled__E548B673D5213B57] PRIMARY KEY CLUSTERED ([id_category])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for City
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[City]', RESEED, 3)
GO


-- ----------------------------
-- Primary Key structure for table City
-- ----------------------------
ALTER TABLE [dbo].[City] ADD CONSTRAINT [PK__City__6AEC3C61AAE1B173] PRIMARY KEY CLUSTERED ([id_city])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Customer
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Customer]', RESEED, 2)
GO


-- ----------------------------
-- Primary Key structure for table Customer
-- ----------------------------
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK__Customer__8CC9BA462E3F7F5B] PRIMARY KEY CLUSTERED ([id_customer])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Order
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Order]', RESEED, 4)
GO


-- ----------------------------
-- Primary Key structure for table Order
-- ----------------------------
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [PK__Order__DD5B8F3F24D8C0EE] PRIMARY KEY CLUSTERED ([id_order])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for OrderProduct
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[OrderProduct]', RESEED, 9)
GO


-- ----------------------------
-- Primary Key structure for table OrderProduct
-- ----------------------------
ALTER TABLE [dbo].[OrderProduct] ADD CONSTRAINT [PK__OrderPro__C75960CF21BDF3D3] PRIMARY KEY CLUSTERED ([id_orderProduct])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for Product
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[Product]', RESEED, 4)
GO


-- ----------------------------
-- Primary Key structure for table Product
-- ----------------------------
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [PK__Product__BA39E84FF66B9931] PRIMARY KEY CLUSTERED ([id_product])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table Customer
-- ----------------------------
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK__Customer__id_cit__2E1BDC42] FOREIGN KEY ([id_city]) REFERENCES [dbo].[City] ([id_city]) ON DELETE CASCADE ON UPDATE CASCADE
GO


-- ----------------------------
-- Foreign Keys structure for table Order
-- ----------------------------
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [FK__Order__id_custom__30F848ED] FOREIGN KEY ([id_customer]) REFERENCES [dbo].[Customer] ([id_customer]) ON DELETE CASCADE ON UPDATE CASCADE
GO


-- ----------------------------
-- Foreign Keys structure for table OrderProduct
-- ----------------------------
ALTER TABLE [dbo].[OrderProduct] ADD CONSTRAINT [FK__OrderProd__id_or__33D4B598] FOREIGN KEY ([id_order]) REFERENCES [dbo].[Order] ([id_order]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OrderProduct] ADD CONSTRAINT [FK__OrderProd__id_pr__34C8D9D1] FOREIGN KEY ([id_product]) REFERENCES [dbo].[Product] ([id_product]) ON DELETE CASCADE ON UPDATE CASCADE
GO


-- ----------------------------
-- Foreign Keys structure for table Product
-- ----------------------------
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [FK__Product__id_cate__2B3F6F97] FOREIGN KEY ([id_category]) REFERENCES [dbo].[Category] ([id_category]) ON DELETE CASCADE ON UPDATE CASCADE
GO

