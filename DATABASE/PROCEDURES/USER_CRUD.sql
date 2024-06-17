SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE USER_CRUD
	-- Add the parameters for the stored procedure here
	@action varchar(20),
	@userID int = null,
	@name nvarchar(50) = null,
	@username nvarchar(50) = null,
	@mobile varchar(50) = null,
	@email nvarchar(50) = null,
	@address nvarchar(max) = null,
	@password nvarchar(50) = null,
	@imageURL varchar(max) = null
AS
BEGIN
	
	SET NOCOUNT ON;

    IF @action='SELECTFORLOGIN'
		BEGIN
			SELECT * FROM dbo.[USER] WHERE username=@username AND password = @password
		END

	IF @action='SELECTFORPROFILE'
		BEGIN
			SELECT * FROM dbo.[USER] WHERE userID=@userID
		END

	IF @action='INSERT'
		BEGIN
			INSERT INTO dbo.[USER](name, username, mobile, email, address, password, imageURL, createdDate) 
			VALUES (@name, @username, @mobile, @email, @address, @password, @imageURL, GETDATE())
		END

	IF @action='UPDATE'
		BEGIN
			DECLARE @update_img varchar(20)
			SELECT @update_img = (CASE WHEN @imageURL IS NULL THEN 'NO' ELSE 'YES' END)
			IF @update_img = 'NO'
				BEGIN
					UPDATE dbo.[USER]
					SET name=@name, username=@username, mobile=@mobile, email=@email, address=@address
					WHERE userID=@userID
				END
			ELSE
				BEGIN
					UPDATE dbo.[USER]
					SET name = @name, username=@username, mobile=@mobile, email=@email, address=@address, imageURL=@imageURL
					WHERE userID=@userID
				END
		END

	IF @action='SELECTFORADMIN'
		BEGIN
			SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo], userID, name, username, email, createdDate
			FROM dbo.[USER]
		END

	IF @action='DELETE'
		BEGIN
			DELETE FROM dbo.[USER] WHERE userID=@userID
		END	
END
GO
