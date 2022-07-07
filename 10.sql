use [Test_Cargo2]
go

select top (3) [Copacity] as "Самая большая грузоподъемность", "Размерность" = case 
	when [Copacity] <= 40 then 'Малая грузоподъемность'
	when [Copacity] between 41 and 54 then 'Средняя грузоподъемность'
	when [Copacity] > 54 then 'Большая грузоподъемность'
	end, ROW_NUMBER() over (order by [Copacity]) as "№ транспорта" from dbo.Transport
	group by [Copacity]
go

select Max([Weight_Cargo]) as "Самый большой вес груза", Min([Weight_Cargo]) as "Самый маленький вес груза"
from dbo.Cargo
go

select Concat('ФИО: ', Lastname_Customer,' ', SUBSTRING(Name_Customer, 1,1),'.', SUBSTRING(Surname_Customer,1,1),'.') as "Данные заказчика",
Lower(Substring([Type_Name], 1,3)) as "Тип организации", UPPER([Name_Customer_Organization]) as "Название организации" from dbo.Customer
inner join [dbo].[Type_Organization] on [ID_Type_Organization] = [Type_Organization_ID]
go

select Concat('Номер маршрутного листа: ', STRING_AGG(Number_Route_Sheet,','), 'Дата маршрутного листа: ', Date_Route_Sheet) as "Данные маршрутного листа",
Format(Date_Route_Sheet, 'dd.MM.yyyy') as "Дата", 
format(DATEADD(YEAR, 1, Date_Route_Sheet), 'dd.MM.yyyy') as "Дата окончания дежурства", 
DATEDIFF(DAY, GETDATE(), DATEADD(YEAR,1, Date_Route_Sheet)) as "Длительность доставки",
DATEPART(YEAR, DATEADD(YEAR,1,Date_Route_Sheet)) as "Месяц окончания доставки",
DATEPART(QUARTER, DATEADD(YEAR, CONVERT([int], 1), Date_Route_Sheet))	as "Квартал окончания доставки" from dbo.Route_Sheet
inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
inner join [dbo].[Transport] on [ID_Transport] = [Transport_ID] inner join [dbo].[Model] on [ID_Model] = [Model_ID]
group by Date_Route_Sheet,
format(DATEADD(YEAR, 1, Date_Route_Sheet), 'dd.MM.yyyy'), 
DATEDIFF(DAY, GETDATE(), DATEADD(YEAR,1, Date_Route_Sheet)),
DATEPART(YEAR, DATEADD(YEAR,1,Date_Route_Sheet)),
DATEPART(QUARTER, DATEADD(YEAR, CONVERT([int], 1), Date_Route_Sheet))
go

--select Concat('Оборудование группы: ', STRING_AGG(Number_Route_Sheet,','), 'Комплекс систем охраны: ', Date_Route_Sheet) as "Данные охранной группы",
--Format(Date_Route_Sheet, 'dd.MM.yyyy') as "Дата начала дежурства", 
--format(DATEADD(YEAR, 1, Date_Route_Sheet), 'dd.MM.yyyy') as "Дата окончания дежурства", 
--DATEDIFF(DAY, GETDATE(), DATEADD(YEAR,1, Date_Route_Sheet)) as "Длительность службы в днях",
--DATEPART(YEAR, DATEADD(YEAR,1,Date_Route_Sheet)) as "Месяц окончания службы",
--DATEPART(QUARTER, DATEADD(YEAR, CONVERT([int], 1), Date_Route_Sheet)) as "Квартал окончания договора" from dbo.Route_Sheet
--go

--select Concat('Оборудование группы: ', STRING_AGG(Number_Route_Sheet,','), 'Комплекс систем охраны: ', Date_Route_Sheet) as "Данные охранной группы",
--Format(Date_Route_Sheet, 'dd.MM.yyyy') as "Дата начала дежурства" from dbo.Route_Sheet
--group by Number_Route_Sheet, Format(Date_Route_Sheet, 'dd.MM.yyyy')
--go

select distinct([Surname_Employee]) as "ФИО сотруднкиов" from dbo.Employee
go

select STRING_AGG(Concat('ФИО: ', Surname_Employee,' ', SUBSTRING(Name_Employee, 1,1),'.', SUBSTRING(Lastname_Employee,1,1)),' | ') as "Сотрудник",
Name_Post as "Должность"
from Post_Employee
inner join [dbo].[Employee] on [ID_Employee] = [Employee_ID]
inner join [dbo].[Post] on [ID_Post] = [Post_ID]
group by Name_Post
having Name_Post = 'Водитель'
go

select string_agg(Concat('ФИО: ', Surname_Employee,' ',SUBSTRING(Name_Employee,1,1),' ',SUBSTRING(Lastname_Employee,1,1)),' | ') as "Сотрудник", 
Name_Carrier as "Название организации", 
count(Carrier_ID) as "Количество перевозчиков" from dbo.Employee
inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
group by Name_Carrier
go
------ ROUND sum
create or alter function [dbo].[Cargo_Weight] (@Number_Application [varchar] (max))
returns [decimal] (38,2)
with execute as caller
as
	begin
		return(select ROUND(sum(Weight_Cargo),1) from dbo.Cargo
		inner join dbo.Cargo_Application on Cargo_ID = ID_Cargo_Application
		inner join dbo.Application on Application_ID = ID_Application
		where Number_Application = @Number_Application) 
	end
go
---- avg 
create or alter function [dbo].[Cargo_Weight_Avg] (@Number_Application [varchar] (max))
returns [decimal] (38,2)
with execute as caller
as
	begin
		return(select ROUND(avg(Weight_Cargo),1) from dbo.Cargo
		inner join dbo.Cargo_Application on Cargo_ID = ID_Cargo_Application
		inner join dbo.Application on Application_ID = ID_Application
		where Number_Application = @Number_Application) 
	end
go

select [dbo].[Cargo_Weight] ('1')
go

create or alter function [dbo].[Cargo_Info] (@Description_Cargo	[varchar] (max))
returns table 
as
	return(select Description_Cargo as "Название груза",
	STRING_AGG(CONVERT([varchar] (max), Weight_Cargo)+', общий вес (кг)'+ (CONVERT([varchar] (max), Weight_Cargo)),',') as "Общий вес", 
	CONVERT([varchar] (max), Weight_Cargo) as "Средний вес груза (Кг)" from dbo.[Cargo]
	where Description_Cargo = @Description_Cargo
	group by Description_Cargo, CONVERT([varchar] (max), Weight_Cargo))
go
select * from [dbo].[Cargo_Info] ('Древисина')
go
