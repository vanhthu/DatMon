
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE CONTACTPro
	@action varchar(20),
	@contactID  INT = NULL,
	@name NVARCHAR(100) = NULL,
	@email NVARCHAR(100) = NULL,
	@subject NVARCHAR(200) = NULL,
	@message NVARCHAR(MAX) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;

	IF @action = 'INSERT'
	BEGIN 
		INSERT INTO dbo.CONTACT(name, email, subject, message, createdDate)
		VALUES (@name, @email, @subject, @message, GETDATE())
	END

	IF @action = 'SELECT'
	BEGIN 
		SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [stt], * FROM dbo.CONTACT
	END

	-- xóa bởi admin
	IF @action = 'DELETE'
	BEGIN 
		DELETE FROM  dbo.CONTACT WHERE contactID=@contactID
	END
    
END
GO
