USE [DATMON]
GO
/****** Object:  StoredProcedure [dbo].[CART_CRUD]    Script Date: 30/04/2024 8:51:02 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CART_CRUD]
	@action varchar(10),
	@productID int = null,	
	@quantity int = null,	
	@userID int = null
as
begin
	set nocount on;

	-- phương thức select
	if @action='SELECT'
		begin
			--  G.soluong as SoLuong => số lượng trong giỏ hàng
			--  S.soluong as slsp => số lượng của sản phẩm
			select C.productID, P.name, P.imageURL, P.price, C.quantity, C.quantity as qty, P.quantity as PrdQty
			from dbo.CARTS C
			inner join dbo.PRODUCTS P on P.productID=C.productID
			where userID=@userID
		end

	-- INSRET
	if @action = 'INSERT'
		begin
			insert into dbo.CARTS(productID, quantity, userID)
			values(@productID, @quantity, @userID)			
		end
	-- update
	if @action='UPDATE'
		begin
			update dbo.CARTS
			set	quantity=@quantity
			where  userID=@userID and productID=@productID
		end

	-- phương thức xóa
	if @action='DELETE'
		begin
			delete from dbo.CARTS			
			where  userID=@userID and productID=@productID
		end

	-- phương thức lấy ra id (theo productID và userID)
	if @action='GETBYID'
		begin
			select * from dbo.CARTS
			where userID=@userID and productID=@productID
		end
end
