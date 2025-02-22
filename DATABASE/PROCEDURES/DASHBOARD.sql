SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE DASHBOARD
	@action varchar(20) NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @action = 'CATEGORY'
		BEGIN 
			SELECT COUNT(*) FROM DBO.CATEGORIES
		END

	IF @action = 'PRODUCT'
		BEGIN 
			SELECT COUNT(*) FROM DBO.PRODUCTS
		END

	IF @action = 'ORDER'
		BEGIN 
			SELECT COUNT(*) FROM DBO.ORDERS
		END

	IF @action = 'DELIVERY'
		BEGIN 
			SELECT COUNT(*) FROM DBO.ORDERS
			WHERE status=N'Đã giao'
		END

	IF @action = 'PENDING'
		BEGIN 
			SELECT COUNT(*) FROM DBO.ORDERS
			WHERE status IN(N'Đang giao',N'Đã gửi')
		END

	IF @action = 'USER'
		BEGIN 
			SELECT COUNT(*) FROM DBO.[USER]
		END

	-- doanh số
	IF @action = 'SOLDAMOUNT'
		BEGIN 
			SELECT SUM(O.quantity*P.price) FROM DBO.ORDERS O
			INNER JOIN PRODUCTS P ON P.productID=O.productID 
		END

	IF @action = 'CONTACT'
		BEGIN 
			SELECT COUNT(*) FROM DBO.CONTACT
		END
END
GO