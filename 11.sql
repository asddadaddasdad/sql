use [Test_Cargo2]	
go

create table [dbo].[Employee_Application_History]
(
	[ID_Employee_Application] [uniqueidentifier] not null,
	[Employee_Info] [varchar] (max) not null,
	[Application_Info] [varchar] (max) not null, 
	constraint [PK_Agent_Customer] primary key clustered
	([ID_Employee_Application] ASC) on [PRIMARY]
)
go

create or alter function [dbo].Employee_App_History (@Employee_Info [varchar] (100))
returns table 
as
	return (select CONCAT('���: '+Lastname_Employee,' ',Name_Employee,' ',Surname_Employee) as "��� ����������",
	CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]) as "����� ������"
	from dbo.[Application]
	inner join dbo.Route_Sheet on ID_Application = Route_Sheet_ID
	inner join dbo.Carrier on Carrier_ID = ID_Carrier
	inner join dbo.Employee on Carrier.ID_Carrier = ID_Employee
	group by CONCAT('���: '+Lastname_Employee,' ',Name_Employee,' ',Surname_Employee),
	CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]))
Go
select * from Employee_App_History ('2')

select * from dbo.[Customer]
	inner join dbo.Application on Application.Customer_ID = ID_Customer

create or alter function [dbo].Customer_App_History (@Customer_Info [varchar] (100))
returns table 
as
	return (select CONCAT('���: '+Lastname_Customer,' ',Name_Customer,' ',Surname_Customer) as "��� ����������",
	CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]) as "����� ������"
	from dbo.[Customer]
	inner join dbo.Application on Application.Customer_ID = ID_Customer
	group by CONCAT('���: '+Lastname_Customer,' ',Name_Customer,' ',Surname_Customer),
	CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]))
Go

select * from Customer_App_History ('2')
	


create or alter trigger dbo.Employee_Application_Insert 
on dbo.EmployeeCust after insert
as
	insert into dbo.Employee_Application_History ([ID_Employee_Application], [Employee_Info], [Application_Info])
	values (NewID(), 
	(select CONCAT('���: ',Lastname_Employee,' ',Name_Employee,' ',Surname_Employee) from dbo.Employee
	where ID_Employee = (select Employee_ID from inserted)),
	(select CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]) from dbo.Application
	where ID_Application = (select Application_ID from inserted)))
	print('Insert Record Complete!')
go

create or alter trigger dbo.Employee_Application_Update
on dbo.[EmployeeCust] after update
as
	insert into dbo.Employee_Application_History ([ID_Employee_Application], [Employee_Info], [Application_Info])
	values (NewID(), 
	(select CONCAT('���: ',Lastname_Employee,' ',Name_Employee,' ',Surname_Employee) from dbo.Employee
	where ID_Employee = (select Employee_ID from inserted)),
	(select CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]) from dbo.Application
	where ID_Application = (select Application_ID from inserted)))
	print('Update Record Complete!')
go

create or alter trigger dbo.Employee_Application_Delete
on dbo.[EmployeeCust] after delete
as
	insert into dbo.Employee_Application_History ([ID_Employee_Application], [Employee_Info], [Application_Info])
	values (NewID(), 
	(select CONCAT('���: ',Lastname_Employee,' ',Name_Employee,' ',Surname_Employee) from dbo.Employee
	where ID_Employee = (select Employee_ID from deleted)),
	(select CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]) from dbo.Application
	where ID_Application = (select Application_ID from inserted)))
	print('Delete Record Complete!')
go

insert into dbo.EmployeeCust ([Employee_ID], [Application_ID])
values (1,1)
go
insert into dbo.EmployeeCust ([Employee_ID], [Application_ID])
values (2,2)
go
insert into dbo.EmployeeCust ([Employee_ID], [Application_ID])
values (3,3)
go
insert into dbo.EmployeeCust ([Employee_ID], [Application_ID])
values (4,4)
go
insert into dbo.EmployeeCust ([Employee_ID], [Application_ID])
values (5,5)
go

select * from [dbo].[EmployeeCust]

select * from [dbo].[Employee_Application_History]

--##################################################################

create table [dbo].[Customer_Application_History]
(
	[ID_Customer_Application] [uniqueidentifier] not null,
	[Customer_Info] [varchar] (max) not null,
	[Application_Info] [varchar] (max) not null, 
	constraint [PK_Customer_Application] primary key clustered
	([ID_Customer_Application] ASC) on [PRIMARY]
)
go


create or alter trigger dbo.Customer_Application_Insert 
on dbo.CustomerCust after insert
as
	insert into dbo.Customer_Application_History ([ID_Customer_Application], [Customer_Info], [Application_Info])
	values (NewID(), 
	(select CONCAT('���: ',Lastname_Customer,' ',Name_Customer,' ',Surname_Customer) from dbo.Customer
	where ID_Customer = (select Customer_ID from inserted)),
	(select CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]) from dbo.Application
	where ID_Application = (select Application_ID from inserted)))
	print('Insert Record Complete!')
go

create or alter trigger dbo.Customer_Application_Update
on dbo.[CustomerCust] after update
as
	insert into dbo.Customer_Application_History ([ID_Customer_Application], [Customer_Info], [Application_Info])
	values (NewID(), 
	(select CONCAT('���: ',Lastname_Customer,' ',Name_Customer,' ',Surname_Customer) from dbo.Customer
	where ID_Customer = (select Customer_ID from inserted)),
	(select CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]) from dbo.Application
	where ID_Application = (select Application_ID from inserted)))
	print('Update Record Complete!')
go

create or alter trigger dbo.Customer_Application_Delete
on dbo.[CustomerCust] after delete
as
	insert into dbo.Customer_Application_History ([ID_Customer_Application], [Customer_Info], [Application_Info])
	values (NewID(), 
	(select CONCAT('���: ',Lastname_Customer,' ',Name_Customer,' ',Surname_Customer) from dbo.Customer
	where ID_Customer = (select Customer_ID from inserted)),
	(select CONCAT('����� ������: ', Number_Application, ' ������: ', [Status_Application], ' ����: ', [Date_Application], ' �����: ', [Time_Application]) from dbo.Application
	where ID_Application = (select Application_ID from inserted)))
	print('Delete Record Complete!')
go

insert into dbo.CustomerCust ([Customer_ID], [Application_ID])
values (1,1)
go
insert into dbo.CustomerCust ([Customer_ID], [Application_ID])
values (2,2)
go
insert into dbo.CustomerCust ([Customer_ID], [Application_ID])
values (3,3)
go
insert into dbo.CustomerCust ([Customer_ID], [Application_ID])
values (4,4)
go
insert into dbo.CustomerCust ([Customer_ID], [Application_ID])
values (5,5)
go

select * from [dbo].[CustomerCust]

select * from [dbo].[Customer_Application_History]


private void TransportFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Transport], [Length_Transport], [Width_Transport], [Height_Transport], [Load_Copacity], [Copacity], [Number_Transport], [Model_ID], [Model_ID], [Name_Model] from [dbo].[Transport] inner join [dbo].[Model] on [ID_Model] = [Model_ID]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_Transport;
                    dgTransport.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgTransport.Columns[0].Visibility = Visibility.Hidden;
                    dgTransport.Columns[1].Header = "�����";
                    dgTransport.Columns[2].Header = "������";
                    dgTransport.Columns[3].Header = "������";
                    dgTransport.Columns[4].Header = "����������������";
                    dgTransport.Columns[5].Header = "�����������";
                    dgTransport.Columns[6].Header = "�����";
                    dgTransport.Columns[7].Visibility = Visibility.Hidden;
                    dgTransport.Columns[8].Visibility = Visibility.Hidden;
                    dgTransport.Columns[9].Header = "������";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_Transport(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                TransportFill();
            }
        }
        private void dgTransport_Loaded(object sender, RoutedEventArgs e)
        {
            TransportFill();
            cbDuty_ObjFill();
        }

        private void btTransport_Insert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(string.Format("insert into [dbo].[Transport] ([Model_ID], [Length_Transport], [Width_Transport], [Height_Transport], " +
                "[Load_Copacity], [Copacity], [Number_Transport]) values ({0}, '{1}','{2}', '{3}', '{4}', '{5}','{6}')", cbDuty_Obj.SelectedValue, tb_dlina.Text, tb_visota.Text, tb_shirina.Text, tb_gruz.Text, tb_vmestimost.Text, tb_nomer.Text), DataBaseClass.act.manipulation);

        }

        private void btTransport_Delete_Click(object sender, RoutedEventArgs e)
        {
            if (dgTransport.Items.Count != 0 & dgTransport.SelectedItems.Count != 0)
            {
                DataRowView dataRowView = (DataRowView)dgTransport.SelectedItems[0];
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute(string.Format("delete from [dbo].[Transport] where [ID_Transport] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
            }
            
        }

        private void btTransport_Update_Click(object sender, RoutedEventArgs e)
        {
                if (dgTransport.Items.Count != 0 & dgTransport.SelectedItems.Count != 0)
                {
                    DataRowView dataRowView = (DataRowView)dgTransport.SelectedItems[0];
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute(string.Format("update [dbo].[Transport] set " +
                        "[Model_ID]  = '{0}'," +
                        "[Length_Transport]  = '{2}'," +
                        "[Width_Transport]  = '{1}'," +
                        "[Height_Transport] = '{3}'," +
                        "[Load_Copacity] = '{4}'," +
                        "[Copacity] = '{5}'," +
                        "[Number_Transport] = '{6}'" +
                        "where [ID_Transport] = {7}",
                        cbDuty_Obj.SelectedValue, tb_shirina.Text, tb_dlina.Text, tb_visota.Text, tb_gruz.Text, tb_vmestimost.Text, tb_nomer.Text, dataRowView[0]), DataBaseClass.act.manipulation);
                }
        }

        private void dgTransport_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            try
            {
                DataRowView dataRowView = dgTransport.SelectedItems[0] as DataRowView;
                tb_dlina.Text = dataRowView[1].ToString();
                tb_visota.Text = dataRowView[2].ToString();
                tb_shirina.Text = dataRowView[3].ToString();
                tb_gruz.Text = dataRowView[4].ToString();
                tb_vmestimost.Text = dataRowView[5].ToString();
                tb_nomer.Text = dataRowView[6].ToString();
                cbDuty_Obj.SelectedValue = dataRowView[7];
            }
            catch
            {

            }
        }


private void cbDuty_ObjFill()
        {
            Action action = () =>
            {
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute("select [Model_ID], [Name_Model] from [dbo].[Transport] inner join [dbo].[Model] on [ID_Model] = [Model_ID]", DataBaseClass.act.select);
                dataBaseClass.dependency.OnChange += cbDuty_ObjDependency_OnChange;
                cbDuty_Obj.ItemsSource = dataBaseClass.resultTable.DefaultView;
                cbDuty_Obj.SelectedValuePath = dataBaseClass.resultTable.Columns[0].ColumnName;
                cbDuty_Obj.DisplayMemberPath = dataBaseClass.resultTable.Columns[1].ColumnName;
                
            };
            Dispatcher.Invoke(action);
        }

        private void cbDuty_Obj_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                cbDuty_ObjFill();
            }
            catch
            {

            }
        }

        private void cbDuty_ObjDependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            if(e.Info != SqlNotificationInfo.Invalid)
                cbDuty_ObjFill();
        }


		                    <ComboBox Name="cbDuty_Obj" Grid.Column="1" Grid.Row="6" Grid.ColumnSpan="3" Loaded="cbDuty_Obj_Loaded" Margin="0,37,0,37" Grid.RowSpan="3"></ComboBox>


--create or alter trigger [dbo].[Employee_Insert_Update]
--on [dbo].[Employee] after insert, update
--as 
--	begin 
--		declare @Full_Names_Employee [varchar] (max) = (select distinct([Name_Employee]) from [dbo].[Employee]
--		inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
--		where [ID_Employee] = (select [ID_Employee] from [inserted])) -- ��������� ������
--		declare @Full_Application [varchar] (max) = (select count(*) from [dbo].[Employee_History] where [Application_History] = @Full_Names_Employee) --���������� �������
		if @Full_Names_Employee >  0
		begin 
			update [dbo].[Employee_History] set
			[Fullname_Employee_History] = (select concat([Name_Employee], ' ',  [Lastname_Employee], ' ', [Surname_Employee]) from [dbo].[Employee]
			inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
			where [ID_Employee] = (select [ID_Employee] from [inserted])),
			[Application_History] = (select concat(convert(varchar (max), [Number_Application]), ' ������; ��� �����: ', [Date_Application], '; ����� ������: ', [Time_Application], '; �����', [Status_Application], '; ', [Number_Route_Sheet]) from [dbo].[Application]
			inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
			inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
			where [ID_Application] = (select [ID_Application] from [inserted]))
			print('Update Record Complete!')
		end
		else
		begin
			--										1							2								3								4					5					
			insert into [Employee_History] ([ID_Employee_History], [Fullname_Employee_History], [Application_History],  [Date_Application_History], [Time_Application_History])
			values
			(
				NEWID(), -- 1
				--(select [Name_Employee] from [dbo].[Employee] inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
				--where [Route_Sheet_ID] = (select [Route_Sheet_ID] from [inserted])),  -- 3
				(select concat([Name_Employee], ' ',  [Lastname_Employee], ' ', [Surname_Employee]) from [dbo].[Employee]
				inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
				where [ID_Carrier] = (select [ID_Carrier] from [inserted])), -- 4 
				(select concat(convert(varchar (100), [Number_Route_Sheet]), ' ������; ��� �����: ', [Date_Route_Sheet], '; ����� ������: ', [Time_Route_Sheet]) from [dbo].[Route_Sheet]
				inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
				inner join [dbo].[Transport] on [ID_Transport] = [Transport_ID] inner join [dbo].[Model] on [ID_Model] = [Model_ID]
				where [ID_Route_Sheet] = (select [ID_Route_Sheet] from [inserted])) -- 5
				--(select concat('����� ��������: ', [Passport_Number], '; ���� ���������: ', convert(varchar (10), format([Date_of_Birth_Passenger], 'dd.MM.yyyy')), '; ����� ���������� �����: ', [Bankcard_Number], '; ���� ��������: ', [Bankcard_Validity], '; ��� ������������: ', [Security_Code])  from [dbo].[Ticket]
				--where [ID_Ticket] = (select [ID_Ticket] from [inserted])) -- 6
			)
			print('Insert record complete!')
		end
	end
go



create or alter trigger [dbo].[Employee_History_Insert_Update]
on [dbo].[Route_Sheet] after insert, update
as
	begin
		declare @Number_Route_Sheet varchar (max) = (select distinct([Number_Route_Sheet]) from [dbo].[Route_Sheet]
		inner join dbo.Route_Sheet on Route_Sheet_ID = ID_Route_Sheet
		where Route_Sheet_ID = (select Route_Sheet_ID from [inserted]) and
		[Employee_ID] = (select [Employee_ID] from [inserted]))
		if ((select COUNT(*) from [dbo].[Employee_History]
		where Number_Route_Sheet = @Number_Route_Sheet) > 0)
		begin
			update [dbo].[Employee_History] set
			[Employee_Info] = (select STRING_AGG(CONCAT('���: ',Lastname_Employee,' ',Name_Employee,' ',Surname_Employee),' ;') from dbo.Employee
			inner join dbo.Employee on Employee_ID = ID_Employee
			inner join dbo.Route_Sheet on Route_Sheet_ID = ID_Route_Sheet
			where ID_Employee = (select Employee_ID from inserted)),









create or alter trigger [dbo].[Agent_Customer_History_Update] 
on [dbo].[Contract] after insert, update
as
	begin 
		declare @Contract_Number [varchar] (4) = (select distinct (Contract_Number) from dbo.[Contract]
		inner join dbo.Object on Contract_ID = ID_Contract
		where Contract_ID = (select Agent_ID from [inserted]))
		if ((select COUNT(*) from dbo.[Contract] 
		where Contract_Number = @Contract_Number) > 0)
		begin
			update [dbo].[Agent_Customer_History] set 
			[Agent_Info] = (select STRING_AGG(CONCAT('���: ',Agent_Last_Name,' ',Agent_Name,' ',Agent_Middle_Name),' ;') from dbo.Agent
			inner join dbo.Security_Object on Security_Object_ID = ID_Security_Object
			inner join dbo.Object on Object.Security_Object_ID = ID_Object
			inner join dbo.Contract on Contract_ID = ID_Security_Object
			where ID_Contract = (select Contract_ID from inserted)),
			[Security_Group_Info] = (select STRING_AGG(CONCAT('������������ ������: ', Group_Equipment),' ;') from dbo.Security_Group
			inner join dbo.Security_Type on Security_Type_ID = ID_Security_Type
			inner join dbo.Employee on Employee_ID = ID_Employee
			inner join dbo.Employee_PSC_Company on Employee_PSC_Company.Employee_ID = ID_Employee_PSC_Company
			inner join dbo.PSC_Company on PSC_Company_ID = ID_PSC_Company
			inner join dbo.Company on PSC_Company.ID_PSC_Company = ID_Company
			inner join dbo.Object on ID_Company = ID_Object
			inner join dbo.Contract on Contract_ID = ID_Security_Type
			where ID_Contract = (select Contract_ID from inserted)),
			[Shift_Info] = (select STRING_AGG(CONCAT('���� ������ ���������: ',Shift_Start_Date, ', ���� ��������� ���������:',[Shift_End_Date]),' ;') from dbo.Duty_Schedule
			inner join dbo.Security_Type on Duty_Schedule_ID = ID_Security_Type
			inner join dbo.Employee on Employee_ID = ID_Employee
			inner join dbo.Employee_PSC_Company on ID_Employee_PSC_Company = ID_Employee
			inner join dbo.PSC_Company on PSC_Company_ID = ID_PSC_Company
			inner join dbo.Company on PSC_Company.Company_ID = ID_Company
			inner join dbo.Object on Object.Company_ID = ID_Object
			inner join dbo.Contract on Contract_ID = ID_Security_Type
			where ID_Contract = (select Contract_ID from inserted)),
			[Object_Info] = (select STRING_AGG(CONCAT('������ �������� �������: ',Object_Full_Name, ', ����������� ��������:',Objecr_Short_Name),' ;') from dbo.[Object]
			inner join dbo.Contract on ID_Contract = ID_Contract
			where ID_Contract = (select Contract_ID from inserted))
			print ('Update Record Complete!')
		end
		else 
		begin 
			insert into [dbo].[Agent_Customer_History] ([ID_Agent_Customer], [Contract_Number], [Security_System_Complex], [Name_Company])
			values (NEWID(), 
			(select concat('����� ��������: ', Contract_Number) from dbo.Contract
			where ID_Contract = (select ID_Contract from inserted)),
			(select concat('�������� ������ ������: ', [Security_System_Complex]) from dbo.Security_Group 
			inner join dbo.Security_Type on Security_Type_ID = ID_Security_Type
			inner join dbo.Employee on Security_Type_ID = ID_Employee
			inner join dbo.Employee_Object on Employee_Object.Employee_ID = ID_Employee_Object 
			inner join dbo.Object on Security_Object_ID = ID_Object
			inner join dbo.Contract on Contract_ID = ID_Security_Group
			where ID_Contract = (select ID_Contract from inserted)),
			(select concat('�������� �����������: ', [Name_Company], '�����: ',[Address]) from dbo.Company
			inner join dbo.Object on Company.ID_Company = ID_Object
			inner join dbo.Contract on Contract_ID = ID_Company
			where ID_Contract = (select ID_Contract from inserted)))
			print ('Insert Record Complete!')
		end
	end
go 












--on [dbo].[Employee] after insert, update
--as
--	begin
--		declare @Name_Employee varchar (32) = (select distinct([Name_Employee]) from [dbo].[Employee]
--		inner join dbo.Employee on Employee_ID = ID_Employee
--		where Employee_ID = (select Employee_ID from [inserted]) and
--		[Route_Sheet_ID] = (select [Route_Sheet_ID] from [inserted]))
--		if ((select COUNT(*) from [dbo].[Employee]
--		where Name_Employee = @Name_Employee) > 0)
--		begin
--			update [dbo].[Employee_History] set
--			[Surname_Employee] = (select STRING_AGG(CONCAT('�������� �����: ')))
