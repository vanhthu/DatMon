
CREATE PROCEDURE [dbo].[SAVE_ORDER] @tblOrders OrderDetails READONLY
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO ORDERS(orderNo, productID, quantity, userID, status, paymentID, orderDate) 
	SELECT orderNo, productID, quantity, userID, status, paymentID, orderDate FROM @tblOrders
END


-- tạo store procedure để lưu thông tin thanh toán
create procedure [dbo].[SAVE_PAYMENT]
	@name nvarchar(100) = null,
	@cardNo varchar(50) = null,
	@expiryDate varchar(50) = null,
	@CVV int = null,
	@address nvarchar(max) = null,
	@paymentMode varchar(10) = 'card',
	@insertedID int output

as
begin
	set nocount on;

	-- phương thức insert
	begin
		insert into dbo.PAYMENT(name, cardNo, expiryDate, CVVNo, address, paymentMode)
		values(@name, @cardNo, @expiryDate, @cvv, @address, @paymentMode)

		select @insertedID = SCOPE_IDENTITY();
	end
end