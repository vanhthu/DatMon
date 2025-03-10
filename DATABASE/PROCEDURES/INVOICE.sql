USE [DATMON]
GO
/****** Object:  StoredProcedure [dbo].[HOADON]    Script Date: 01/05/2024 2:04:47 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HOADON] 
    @action varchar(20), 
    @userID int = null,  
    @paymentID int = null, 
    @orderDetailsID int = null, 
    @trangthai nvarchar(50) = null 
AS
BEGIN
    SET NOCOUNT ON;

    IF @action = 'IDHOADON' AND @paymentID IS NOT NULL AND @userID IS NOT NULL
    BEGIN
        DECLARE @orderNo nvarchar(MAX);
        SET @orderNo = CONVERT(nvarchar(MAX), NEWID());

        UPDATE ORDERS 
        SET orderNo = @orderNo
        WHERE paymentID = @paymentID AND userID = @userID;

        SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS [stt], D.orderNo, S.name, S.price, D.quantity, (S.price * D.quantity) AS tongtien, 
        D.orderDate, D.status
        FROM ORDERS D
        INNER JOIN PRODUCTS S ON S.productID = D.productID
        WHERE D.paymentID = @paymentID AND D.userID = @userID;
    END

    IF @action = 'LICHSUDONHANG'
    BEGIN 
        SELECT D.paymentID, T.paymentMode, T.cardNo, D.orderDate, D.status
        FROM ORDERS D
        INNER JOIN PAYMENT T ON T.paymentID = D.paymentID
        WHERE D.userID = @userID;
    END
   
    IF @action = 'TRANGTHAIDONHANG'
    BEGIN
        SELECT D.orderDetailsID, D.orderNo, (S.price * D.quantity) AS tongtien, D.status, D.orderDate, T.paymentMode, S.name
        FROM ORDERS D
        INNER JOIN PAYMENT T ON T.paymentID = D.paymentID
        INNER JOIN PRODUCTS S ON S.productID = D.productID
        
    END

    IF @action = 'TRANGTHAIDONHANGID'
    BEGIN
        SELECT orderDetailsID, status 
        FROM ORDERS 
        WHERE orderDetailsID = @orderDetailsID;
    END

    IF @action = 'CAPNHATTRANGTHAI'
    BEGIN
        UPDATE dbo.ORDERS
        SET status = @trangthai
        WHERE orderDetailsID = @orderDetailsID;
        SELECT 1; -- Return a value to indicate success
    END
END
