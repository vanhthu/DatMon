USE [DATMON]
GO
/****** Object:  StoredProcedure [dbo].[CATEGORY_CRUD]    Script Date: 30/04/2024 12:27:17 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CATEGORY_CRUD]
	@action varchar(20),
	@categoryID int = null,
	@name nvarchar(200) = null,
	@isActive bit = false,
	@imageURL varchar(MAX) = null
AS
BEGIN
	
	SET NOCOUNT ON;
	
	-- phương thức select 
	if @action = 'SELECT'
		begin	
			select * from DBO.CATEGORIES order by createdDate desc	
		end	

	-- phương thức active category
	if @action = 'ACTIVECAT'
		begin	
			select * from dbo.CATEGORIES where isActive=1	
		end	

	-- phương thức insert
	if @action = 'INSERT'
		begin
			insert into dbo.CATEGORIES(name, imageURL, isActive, createdDate) 
			values (@name, @imageURL, @isActive, GETDATE())
		end	

	-- phương thức update
	if @action = 'UPDATE'
		begin
			declare @update_image varchar(20)
			select @update_image = (case when @imageURL is null then 'NO' else 'YES' end)

			if @update_image = 'NO'
				begin
					update dbo.CATEGORIES
					set name = @name, isActive = @isActive
					where categoryID = @categoryID
				end
			else
				begin
					update dbo.CATEGORIES
					set name = @name, imageURL=@imageURL ,isActive = @isActive
					where categoryID = @categoryID
				end
		end

	-- phương thức delete
	if @action = 'DELETE'
		begin
			delete from dbo.CATEGORIES where categoryID = @categoryID
		end	


	
	-- phương thức lấy ra categoryID
	if @action = 'GETBYID'
		begin
			select * from dbo.CATEGORIES where categoryID = @categoryID
		end	
END
