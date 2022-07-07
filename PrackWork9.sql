use [Test_Cargo2]
go

select * from [dbo].[Country_Trasnport]
inner join [dbo].[Transport] on [ID_Transport] = [Transport_ID]
inner join [dbo].[Country] on [ID_Country] = [Country_ID]
inner join [dbo].[Model] on [ID_Model] = [Model_ID]
inner join [dbo].[Brand] on [ID_Brand] = [Brand_ID]

select * from [dbo].[Cargo_Application]
inner join [dbo].[Cargo] on [ID_Cargo] = [Cargo_ID]
inner join [dbo].[Application] on [ID_Application] = [Application_ID]

select * from [dbo].[Application]
inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]

create or alter view [dbo].[Customer_Route_Sheet_App](
"������ � ���������� �����", "������ � ����������� ������")
as
select distinct 
'����� ����������� �����: ' + (Convert([varchar] (30), [Number_Route_Sheet]) + ' ����: ' + Convert([varchar] (30), [Date_Route_Sheet]) + ' �����: ' + Convert([varchar] (30), [Time_Route_Sheet]) + ' ����������: ' + Convert([varchar] (30), 
[Name_Carrier]) + ' ' + ' ����������: '+[Name_Model] + ' �����: ' + [Number_Transport] + ' ������ ������: ' + Convert([varchar] (30), [Number_Application])),
'���: '+ Lastname_Customer + Name_Customer + Surname_Customer from [dbo].[Application]
inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
inner join [dbo].[Model] on [ID_Model] = [ID_Model]
inner join [dbo].[Transport] on [ID_Transport] = [Transport_ID]
group by '����� ����������� �����: ' + (Convert([varchar] (30), [Number_Route_Sheet]) + ' ����: ' + Convert([varchar] (30), [Date_Route_Sheet]) + ' �����: ' + Convert([varchar] (30), [Time_Route_Sheet]) + ' ����������: ' + Convert([varchar] (30), 
[Name_Carrier]) + ' ' + ' ����������: '+[Name_Model] + ' �����: ' + [Number_Transport] + ' ������ ������: ' + Convert([varchar] (30), [Number_Application])),
'���: '+ Lastname_Customer + Name_Customer + Surname_Customer
go

select * from [dbo].[Customer_Route_Sheet_App]

create or alter view [dbo].[Cargo_App_Leght](
"������ � ������", "���������� � �����")
as
select distinct 
'����� ������: ' + (Convert([varchar] (30), [Number_Application]) + ' ���� ������: ' + Convert([varchar] (30), [Date_Application]) + ' ����� ������: ' + Convert([varchar] (30), [Time_Application]) + ' ������: ' + Convert([varchar] (30), 
[Status_Application]) + ' ' + ' ���: '+Lastname_Customer + ' ' + Name_Customer + ' ' + Surname_Customer + ' ����� ����������� �����: ' + Convert([varchar] (30), [Number_Route_Sheet])),
'�������� �����: ' + [Description_Cargo] + ' ��������: ' + Convert([varchar] (30), [Weight_Cargo]) + ' ' + Convert([varchar] (30), [Length_Cargo]) 
+ ' ' + Convert([varchar] (30), [Width_Cargo]) + ' ' + Convert([varchar] (30), [Height_Cargo])from [dbo].[Cargo_Application]
inner join [dbo].[Cargo] on [ID_Cargo] = [Cargo_ID]
inner join [dbo].[Application] on [ID_Application] = [Application_ID]
inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
group by '����� ������: ' + (Convert([varchar] (30), [Number_Application]) + ' ���� ������: ' + Convert([varchar] (30), [Date_Application]) + ' ����� ������: ' + Convert([varchar] (30), [Time_Application]) + ' ������: ' + Convert([varchar] (30), 
[Status_Application]) + ' ' + ' ���: '+Lastname_Customer + ' ' + Name_Customer + ' ' + Surname_Customer + ' ����� ����������� �����: ' + Convert([varchar] (30), [Number_Route_Sheet])),
'�������� �����: ' + [Description_Cargo] + ' ��������: ' + Convert([varchar] (30), [Weight_Cargo]) + ' ' + Convert([varchar] (30), [Length_Cargo]) 
+ ' ' + Convert([varchar] (30), [Width_Cargo]) + ' ' + Convert([varchar] (30), [Height_Cargo])
go
select * from [dbo].[Cargo_App_Leght]

select * from [dbo].[Delivery_Points]
inner join [dbo].[Points_Route_Sheet] on [ID_Delivery_Point] = [Delivery_Point_ID]

create or alter view [dbo].[Country_Transport_Mark_Model](
"������", "���������", "����� � ������")
as
select distinct [Name_Country],
(Convert([varchar] (30), [Length_Transport]) + ' ' + Convert([varchar] (30), [Width_Transport]) + ' ' + Convert([varchar] (30), [Height_Transport]) + ' ' + Convert([varchar] (30), 
[Load_Copacity]) + ' ' + Convert([varchar] (30), [Copacity]) + ' ' + Convert([varchar] (30), [Number_Transport]) + ' ' + Convert([varchar] (30), [Name_Model])),
(Convert([varchar] (30), [Name_Model]) + ' ' + Convert([varchar] (30), [Brand_ID]) + ' ' + Convert([varchar] (30), 
[Name_Brand])) from [dbo].[Country_Trasnport]
inner join [dbo].[Transport] on [ID_Transport] = [Transport_ID]
inner join [dbo].[Country] on [ID_Country] = [Country_ID]
inner join [dbo].[Model] on [ID_Model] = [Model_ID]
inner join [dbo].[Brand] on [ID_Brand] = [Brand_ID]
group by [Name_Country],
(Convert([varchar] (30), [Length_Transport]) + ' ' + Convert([varchar] (30), [Width_Transport]) + ' ' + Convert([varchar] (30), [Height_Transport]) + ' ' + Convert([varchar] (30), 
[Load_Copacity]) + ' ' + Convert([varchar] (30), [Copacity]) + ' ' + Convert([varchar] (30), [Number_Transport]) + ' ' + Convert([varchar] (30), [Name_Model])),
(Convert([varchar] (30), [Name_Model]) + ' ' + Convert([varchar] (30), [Brand_ID]) + ' ' + Convert([varchar] (30), 
[Name_Brand]))
go

select * from [dbo].[Country_Transport_Mark_Model]


create or alter view [dbo].[Delivery_Route_Sheet_Application](
"���", "������ � ������")
as
	select [Number_Application] + ' ' + [Status_Application] + ' ' + [Date_Application] + ' ' + [Time_Application] as "���������� � ������",
	'���: '+Lastname_Customer,' ',Name_Customer,' ',Surname_Customer from dbo.Application
	inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
	group by  Number_Application + ' ' + [Status_Application] + ' ' + [Date_Application] + ' ' + [Time_Application],
	'���: '+Lastname_Customer,' ',Name_Customer,' ',Surname_Customer
go

create or alter view [dbo].[Delivery_Route_Sheet_Application] ("�����", "������ � ������", "���")
as
select distinct (Convert([varchar] (30), [Delivery_Address])),
Lastname_Customer + ' ' + Name_Customer + ' ' + Surname_Customer as '���',
(Convert([varchar] (30), [Number_Application]) + ' ' + Convert([varchar] (30), [Status_Application]) + ' ' + Convert([varchar] (30), 
[Date_Application]) + ' ' + Convert([varchar] (30), [Time_Application])) from [dbo].[Application]
inner join [dbo].[Customer] on [Customer_ID] = [ID_Customer]
inner join [dbo].[Delivery_Points] on [ID_Delivery_Point] = [ID_Delivery_Point]
group by (Convert([varchar] (30), [Delivery_Address])),
Lastname_Customer + ' ' + Name_Customer + ' ' + Surname_Customer,
(Convert([varchar] (30), [Number_Application]) + ' ' + Convert([varchar] (30), [Status_Application]) + ' ' + Convert([varchar] (30), 
[Date_Application]) + ' ' + Convert([varchar] (30), [Time_Application]))
go

select * from [dbo].[Delivery_Route_Sheet_Application]

select * from  [dbo].[Application]
inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
inner join [dbo].[Points_Route_Sheet] on [ID_Point_Route_Sheet] = [Points_Route_Sheet_ID]
inner join [dbo].[Delivery_Points] on [ID_Delivery_Point] = [Delivery_Point_ID]

select * from  [dbo].[Application]
inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
--inner join [dbo].[Points_Route_Sheet] on [ID_Point_Route_Sheet] = [Point_Route_Sheet_ID]
--inner join [dbo].[Delivery_Points] on [ID_Delivery_Point] = [Delivery_Point_ID]

