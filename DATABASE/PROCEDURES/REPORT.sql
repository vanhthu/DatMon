
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE REPORT
	-- Add the parameters for the stored procedure here
	@fromDate DATE = NULL,
	@toDate DATE = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [stt],U.name, U.email, SUM(O.quantity) AS soluong,SUM(O.quantity * P.price) AS tongtien
	FROM ORDERS O
	INNER JOIN PRODUCTS P ON P.productID=O.productID
	INNER JOIN dbo.[USER] U ON U.userID = O.userID
	WHERE CAST(O.orderDate AS DATE) BETWEEN @fromDate AND @toDate
	GROUP BY U.name, U.email
END
GO

