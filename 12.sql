use [Test_Cargo2]
go


create login Driver_Log with password=
'password'
go
create user Driver_Pass from login
Driver_Log
go

create login Manager_Log with password=
'password'
go
create user Manager_Pass from login
Manager_Log
go

create login Employee_Log with password=
'password'
go
create user Employee_Pass from login
Employee_Log
go

create login Admin_Log with password=
'password'
go
create user Admin_Pass from login
Admin_Log
go

create or alter procedure [dbo].[Brand_Insert]
@Name_Brand [varchar] (50)
as
	begin try
	declare @exsist [int] = (select count(*) from
	[dbo].[Brand]
	where [Name_Brand] = @Name_Brand)
	if (@exsist > 0)
	insert into [dbo].[Brand] ([Name_Brand])
	values (@Name_Brand)
	end try
	begin catch
	throw 50001, 'Данные о марке уже существует в таблице', 1
	end catch
go

execute dbo.[Brand_Insert]
@Name_Brand = 'Man'
go

select * from dbo.Brand

create or alter procedure [dbo].[Brand_Delete]
@ID_Brand [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Brand]
	where [ID_Brand] = @ID_Brand)
	if (@any_child_record > 0)
	throw 50001, 'Данные о марке уже существует в таблице', 1
	else 
	delete from [dbo].[Brand]
		where 
		[ID_Brand] = @ID_Brand
go

execute [dbo].[Brand_Delete]
@ID_Brand = 1
go

create or alter procedure [dbo].[Post_Update]
@ID_Post [int], @Name_Post [varchar] (10)
as
	declare @exsist [int] = (select count(*) from
	[dbo].[Post]
	where [Name_Post] = @Name_Post)
	if (@exsist > 0)
	throw 50001, 'Данный о должностях уже есть в таблице', 1
	else
	update [dbo].[Post] set
	[Name_Post] = @Name_Post
	where
	[ID_Post] = @ID_Post
go

execute [dbo].[Post_Update]
@ID_Post = 1, @Name_Post = 'Менеджер по заказам'
go


execute dbo.Carrier_Delete 
@ID_Carrier = 1

execute [dbo].Carrier_Delete
@ID_Carrier = 1

select * from [dbo].Customer
go
revoke select on [dbo].[Employee]
from Driver_Pass
go

--#######################################################################################################

grant select, insert, update, delete on [dbo].Carrier
to Driver_Pass 
go
grant execute on [dbo].Carrier_Delete
to Driver_Pass 
go

grant execute on [dbo].Carrier_Insert
to Driver_Pass 
go
grant execute on [dbo].Carrier_Update
to Driver_Pass 
go
grant execute on [dbo].Transport_Delete
to Driver_Pass 
go
grant execute on [dbo].Transport_Insert
to Driver_Pass 
go
grant execute on [dbo].Transport_Update
to Driver_Pass 
go
grant execute on [dbo].Type_Organization_Delete
to Driver_Pass 
go
grant execute on [dbo].Type_Organization_Insert
to Driver_Pass 
go
grant execute on [dbo].Type_Organization_Update
to Driver_Pass 
go
grant select on [dbo].Customer_Route_Sheet_App
to Driver_Pass 
go
grant select on [dbo].Delivery_Route_Sheet_Application
to Driver_Pass 
go
--######################################################################################

grant select, insert, update, delete on [dbo].Cargo
to Employee_Pass
go

grant select on [dbo]. Employee_Application_History
to Driver_Pass 
go


execute dbo.Type_Organization_Delete 
@ID_Type_Organization = 1  

select * from dbo.Type_Organization


grant select, insert, update, delete on [dbo].Delivery_Points
to Employee_Pass
go
grant select, insert, update, delete on [dbo].License
to Employee_Pass
go
grant select, insert, update, delete on [dbo].Transport
to Employee_Pass
go
grant execute on [dbo].Cargo_Insert
to Employee_Pass
go
grant execute on [dbo].Cargo_Delete
to Employee_Pass
go
grant execute on [dbo].Cargo_Update
to Employee_Pass
go
grant execute on [dbo].Delivery_Points_Insert
to Employee_Pass
go
grant execute on [dbo].Delivery_Points_Delete
to Employee_Pass
go
grant execute on [dbo].Delivery_Points_Update
to Employee_Pass
go
grant execute on [dbo].License_Insert
to Employee_Pass
go
grant execute on [dbo].License_Delete
to Employee_Pass
go
grant execute on [dbo].License_Update
to Employee_Pass
go
grant execute on [dbo].Route_Sheet_Delete
to Employee_Pass
go
grant execute on [dbo].Route_Sheet_Insert
to Employee_Pass
go
grant execute on [dbo].Route_Sheet_Update
to Employee_Pass
go
grant select on [dbo].Country_Transport_Mark_Model
to Employee_Pass
go

execute [dbo].Route_Sheet_Delete
@ID_Route_Sheet = 1


--##############################################################################################

grant select, insert, update, delete on [dbo].Application
to Manager_Pass 
go

execute dbo.Application_Delete 
@ID_Application = 1  

grant select, insert, update, delete on [dbo].Customer
to Manager_Pass 
go
grant select, insert, update, delete on [dbo].Model
to Manager_Pass 
go
grant select, insert, update, delete on [dbo].Route_Sheet
to Manager_Pass 
go
grant execute on [dbo].Application_Delete
to Manager_Pass 
go
grant execute on [dbo].Application_Insert
to Manager_Pass 
go
grant execute on [dbo].Application_Update
to Manager_Pass 
go
grant execute on [dbo].Customer_Delete
to Manager_Pass 
go
grant execute on [dbo].Customer_Insert	
to Manager_Pass 
go
grant execute on [dbo].Customer_Update
to Manager_Pass 
go
grant execute on [dbo].Model_Delete
to Manager_Pass 
go
grant execute on [dbo].Model_Insert	
to Manager_Pass 
go
grant execute on [dbo].Model_Update		
to Manager_Pass 
go

--#########################################################################################

grant select, insert, update, delete on [dbo].Brand
to Admin_Pass
go
grant select, insert, update, delete on [dbo].Country
to Admin_Pass
go
--///////////////////////
execute dbo.Country_Delete 
@ID_Country = 1  
--////////////////////////////////
grant select, insert, update, delete on [dbo].Employee
to Admin_Pass
go
grant select, insert, update, delete on [dbo].Post
to Admin_Pass
go
grant select, insert, update, delete on [dbo].Type_Organization
to Admin_Pass
go
grant execute on [dbo].Brand_Delete
to Admin_Pass	
go
grant execute on [dbo].Brand_Insert	
to Admin_Pass
go
grant execute on [dbo].Brand_Update
to Admin_Pass
go
grant execute on [dbo].Country_Delete
to Admin_Pass	
go
grant execute on [dbo].Country_Insert	
to Admin_Pass
go
grant execute on [dbo].Country_Update
to Admin_Pass
go
grant execute on [dbo].Employee_Delete
to Admin_Pass	
go
grant execute on [dbo].Employee_Insert	
to Admin_Pass
go
grant execute on [dbo].Employee_Update
to Admin_Pass
go
grant select on [dbo].Cargo_App_Leght
to Admin_Pass
go

select * from dbo.License

execute dbo.License_Delete
@ID_License = 1
go

select * from dbo.Route_Sheet


execute dbo.Country_Delete
@ID_Country = 1 
go 





