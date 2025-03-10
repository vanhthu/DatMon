USE [DATMON]
GO
/****** Object:  StoredProcedure [dbo].[PRODUCT_CRUD]    Script Date: 30/04/2024 12:21:13 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PRODUCT_CRUD]
	@action VARCHAR(20),
	@productID INT = NULL,
	@name NVARCHAR(100) = NULL,
	@description NVARCHAR(MAX) = NULL,
	@price DECIMAL(18,3) = 0,
	@quantity INT = NULL,
	@imageURL VARCHAR(MAX) = NULL,
	@categoryID INT = NULL,
	@isActive BIT = false
AS
BEGIN	
	SET NOCOUNT ON;
	-- phương thức SELECT
	IF @action = 'SELECT'
		BEGIN
			SELECT P.*, C.name AS CategoryName
			FROM dbo.PRODUCTS P
			INNER JOIN dbo.CATEGORIES C ON C.categoryID = P.categoryID			
			ORDER BY P.createdDate DESC
		END

	IF @action = 'ACTIVEPROD'
		BEGIN
			SELECT P.*, C.name AS CategoryName
			FROM dbo.PRODUCTS P
			INNER JOIN dbo.CATEGORIES C ON C.categoryID = P.categoryID			
			WHERE P.isActive=1
		END

	-- phương thức INSERT
	IF @action = 'INSERT'
		BEGIN
			INSERT INTO dbo.PRODUCTS(name, description, price, quantity, imageURL, categoryID, isActive, createdDate)
			VALUES (@name, @description, @price, @quantity, @imageURL, @categoryID, @isActive, GETDATE())
		END

	-- phương thức UPDATE
	IF @action = 'UPDATE'
		BEGIN
			DECLARE @update_image VARCHAR(20)
			SELECT @update_image = (CASE WHEN @imageURL IS NULL THEN 'NO' ELSE 'YES' END)
			IF @update_image = 'NO'
				BEGIN
					UPDATE dbo.PRODUCTS
					SET name = @name, @description = @description, price = @price, quantity = @quantity, 
						categoryID = @categoryID, isActive = @isActive
					WHERE productID = @productID
				END
			ELSE
				BEGIN
					UPDATE dbo.PRODUCTS
					SET name = @name, description = @description, price = @price, quantity = @quantity, 
						imageURL=@imageURL, categoryID = @categoryID, isActive = @isActive
					WHERE productID = @productID
				END
		END
	-- phương thức cập nhật số lượng
	IF @action = 'QTYUPDATE'
		BEGIN
			UPDATE dbo.PRODUCTS 
			SET quantity = @quantity 
			WHERE productID = @productID			
		END

	-- phương thức xóa
	IF @action = 'DELETE'
		BEGIN
			DELETE FROM dbo.PRODUCTS WHERE productID = @productID;
		END

	-- phương thức getbyid
	IF @action = 'GETBYID'
		BEGIN
			SELECT * FROM dbo.PRODUCTS WHERE productID = @productID
		END

END
