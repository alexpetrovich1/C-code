USE [master]
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'Clinic')
DROP DATABASE [Clinic]

CREATE DATABASE [Clinic]

USE [Clinic]
GO

CREATE TABLE Specification
(
	Post_code_Specification int primary key identity(1,1),
	Name_specification nVARCHAR(50) not null
)
GO

create table Person
(
	Post_code_Person int primary key identity(1,1),
	Surname nVARCHAR(50) not null,
	Name nvarchar(50) not null,
	Lastname nvarchar(50) not null,
	Number_pasport nvarchar(20) not null,
	Date_of_birth date not null,
	Registration nvarchar(50) not null,
	Staj int not null,
	FK_code_post_Specification INT FOREIGN KEY REFERENCES Specification on delete cascade on update cascade
)
GO

create table Position
(
	Post_code_Position int primary key identity(1,1),
	Job_title nvarchar(50) not null,
	Salary int not null
)
GO

create table Recruitment
(
	Post_code_Recruitment int primary key identity(1,1),
	Date_start date not null,
	Date_stop date,
	FK_post_code_Person int foreign key references Person on delete cascade on update cascade,
	FK_post_code_Position int foreign key references Position on delete cascade on update cascade
)
GO

create table Lot
(
	Post_code_Lot int primary key identity(1,1),
	Number_lot int not null
)
GO

create table Street
(
	Post_code_Street int primary key identity(1,1),
	Name_street nvarchar(100) not null,
	FK_post_code_Lot int foreign key references Lot on delete cascade on update cascade
)
GO

create table Patient
(
	Post_code_Patient int primary key identity(1,1),
	Surname nvarchar(50) not null,
	Name nvarchar(50) not null,
	Lastname nvarchar(50) not null,
	Number_pasport nvarchar(50) not null,
	Date_of_birth date not null,
	Status_patient nvarchar(20) not null,
	FK_post_code_Street int foreign key references Street on delete cascade on update cascade
)
GO


create table Fixing_lot 
(
	Post_code_Fixing_lot int primary key identity (1,1),
	Date_fixing date not null,
	Date_stop date,
	FK_post_code_Lot int foreign key references Lot on delete cascade on update cascade,
	FK_post_code_Person int foreign key references Person on delete cascade on update cascade
)
GO

create table Serrvices 
(
	Post_code_Services int primary key identity(1,1),
	Name_services nvarchar(50) not null,
	Cast_of int not null
)
GO

create table Nominal_cabinet
(
	Post_code_Name_cabinet int primary key identity(1,1),
	Name_cabinet  nvarchar(50) not null
)
GO

create table Days_of_the_week
(
	Post_code_Days_of_the_week int primary key identity(1,1),
	Name_day nvarchar(50) not null,
	Time_start time not null,
	Time_stop time not null,
	Change nvarchar(20) not null
)
GO

create table Schedule_cabinet
(
	Post_code_Schedule_cabinet int primary key identity(1,1),
	Number_cabinet int not null,
	FK_post_code_Nominal_cabinet int foreign key references Nominal_cabinet on delete cascade on update cascade,
	FK_post_code_Person int foreign key references Person on delete cascade on update cascade,
	FK_post_code_Days_of_the_week int foreign key references Days_of_the_week on delete cascade on update cascade 
)
GO

create table Ticket
(
	Post_code_Ticket int primary key identity(1,1),
	Number_ticket int not null,
	FK_post_code_Schedule_cabinet int foreign key references Schedule_cabinet on delete cascade on update cascade,
	FK_post_code_Patient int foreign key references Patient on delete cascade on update cascade,
	Time_ticket time not null
)
GO

create table Reception
(
	Post_code_Reception int primary key identity(1,1),
	FK_post_code_Ticket int foreign key references Ticket on delete cascade on update cascade,
	FK_post_code_Serrvices int foreign key references Serrvices on delete cascade on update cascade,
	unique(FK_post_code_Ticket)
)
GO

create table Payment
(
	Post_code_Payment int primary key identity(1,1),
	FK_post_code_reception int foreign key references Reception on delete cascade on update cascade
)
GO

create table Diagnosis 
(
	Post_code_Diagnosis int primary key identity(1,1),
	Name_Diagnos nvarchar(50) not null,
	FK_post_code_Specification int foreign key references Specification on delete cascade on update cascade,
)
GO

create table Cart_Patient 
(
	Post_code_Cart_Patient int primary key identity(1,1),
	Procedure_status nvarchar(50) not null,
	Name_procederr nvarchar(50) not null,
	Resept nvarchar(50) not null,
	Date_of_write date not null,
	FK_post_code_Patient int foreign key references Patient on delete cascade on update cascade,
	FK_post_code_Diagnosis int foreign key references Diagnosis on delete cascade on update cascade,
	
)
GO


create procedure Add_Specification
(
	@Name_specification nVARCHAR(50)
)
as
	begin
		insert into Specification (Name_specification)
		values(@Name_specification)
	end
GO

create procedure Delete_Specification
(
	@Post_code_Specification int
)
as 
	begin
		delete 
		from Specification 
		where Post_code_Specification = @Post_code_Specification
	end	
GO

create procedure Update_Specification
(
	@Post_code_Specification int,
	@Name_specification nvarchar(50)
)
as
	begin
		update Specification 
		set Name_specification = @Name_specification
		where Post_code_Specification = @Post_code_Specification
	end
GO

create procedure Add_Position
(
	@Job_title nvarchar(50),
	@Salary int
)
as
	begin 
		insert into Position(Job_title, Salary)
		values(@Job_title, @Salary)
	end
GO

create procedure Delete_Position
(
	@Post_code_Position int
)
as
	begin 
		delete 
		from Position
		where Post_code_Position = @Post_code_Position 
	end
GO

create procedure Update_Position
(
	@Post_code_Position int,
	@Job_title nvarchar(50),
	@Salary int
)
as 
	begin
		update Position
		set Job_title = @Job_title,
			Salary = @Salary
		where Post_code_Position = @Post_code_Position
	end
GO

create procedure Add_Person
(
	@Surname nvarchar(50),
	@Name nvarchar(50),
	@Lastname nvarchar(50),
	@Number_pasport nvarchar(20),
	@Date_of_birth date,
	@Registration nvarchar(50),
	@Staj int,
	@FK_post_code_Specification int
)
as
	begin
		insert into Person(Surname, Name, Lastname, Number_pasport, Date_of_birth, Registration, Staj, FK_code_post_Specification)
		values (@Surname, @Name, @Lastname, @Number_pasport, @Date_of_birth, @Registration, @Staj, @FK_post_code_Specification)
	end
GO

create procedure Delete_Person
(
	@Post_code_Person int
)
as
	begin
		delete 
		from Person
		where Post_code_Person = @Post_code_Person
	end
GO

create procedure Update_Person
(
	@Post_code_Person int,
	@Surname nvarchar(50),
	@Name nvarchar(50),
	@Lastname nvarchar(50),
	@Number_pasport nvarchar(20),
	@Date_of_birth date,
	@Registration nvarchar(50),
	@Staj int,
	@FK_post_code_Specification nvarchar(50)
)
as
	begin
		declare @fk_spec int
		set @fk_spec = (select Specification.Post_code_Specification
						from Specification
						where Specification.Name_specification = @FK_post_code_Specification)

		declare @proverka int
		set @proverka = (select count(*) from Person where Person.Number_pasport = @Number_pasport)

		if(@proverka <= 1)
		begin
			update Person
			set 
				Surname = @Surname,
				Name = @Name,
				Lastname = @Lastname,
				Number_pasport = @Number_pasport,
				Date_of_birth = @Date_of_birth,
				Registration = @Registration,
				Staj = @Staj,
				FK_code_post_Specification = @fk_spec
			where Post_code_Person = @Post_code_Person
		end
		else 
				raiserror('ошибка такой пасспорт существует',16,10);
	end
GO
 
create procedure Add_Recruitment
(
	@Surname nvarchar(50),
	@Name nvarchar(50),
	@Lastname nvarchar(50),
	@Number_pasport nvarchar(20),
	@Date_of_birth date,
	@Registration nvarchar(50),
	@Staj int,
	@FK_post_code_Specification nvarchar(50),


	@Date_start date,
	@FK_post_code_Position nvarchar(50)
)
as
	begin
		declare @fk_spec int
		set @fk_spec = (select Specification.Post_code_Specification
						from Specification
						where Specification.Name_specification = @FK_post_code_Specification)

		insert into Person(Surname, Name, Lastname, Number_pasport, Date_of_birth, Registration, Staj, FK_code_post_Specification)
		values (@Surname, @Name, @Lastname, @Number_pasport, @Date_of_birth, @Registration, @Staj, @fk_spec)

		declare @fk_person int
			set @fk_person = (select max(Person.Post_code_Person) from Person)

		declare @fk_dol int
		set @fk_dol = (select Position.Post_code_Position
						from Position
						where Position.Job_title = @FK_post_code_Position)

		insert into Recruitment(Date_start, Date_stop, FK_post_code_Person, FK_post_code_Position)
		values (@Date_start, NULL, @fk_person, @fk_dol)
	end
GO

create procedure Delete_Recruitment
(
	@Post_code_Recruitment int
)
as
	begin
		delete 
		from Recruitment
		where Post_code_Recruitment = @Post_code_Recruitment		
	end
GO

create procedure Add_Daysoftheweek
(
	@Name_day nvarchar(50),
	@Time_start time,
	@Time_stop time
)
as
	begin
	declare @first nvarchar(20)
		set @first = 'Первая'
	declare @last nvarchar(20)
		set @last = 'Вторая'

		if(@Name_day = 'Понедельник-П' or @Name_day = 'Вторник-П' or @Name_day = 'Среда-П' or @Name_day = 'Четверг-П' or @Name_day = 'Пятница-П')
		begin
			insert into Days_of_the_week(Name_day, Time_start, Time_stop, Change)
			values (@Name_day, @Time_start, @Time_stop, @first)
		end
			else
			begin
				insert into Days_of_the_week(Name_day,Time_start,Time_stop, Change)
				values (@Name_day, @Time_start, @Time_stop, @last)
			end
	end
GO

create procedure Delete_Daysoftheweek
(
	@Post_code_Days_of_the_week int
)
as
	begin 
		delete 
		from Days_of_the_week
		where Post_code_Days_of_the_week = @Post_code_Days_of_the_week
	end
GO

create procedure Update_Daysoftheweek
(
	@Post_code_Days_of_the_week int,
	@Name_day nvarchar(20),
	@Time_start time,
	@Time_stop time
)
as
	begin 
	declare @first nvarchar(20)
		set @first = 'Первая'
	declare @last nvarchar(20)
		set @last = 'Вторая'

		if(@Name_day = 'Понедельник-П' or @Name_day = 'Вторник-П' or @Name_day = 'Среда-П' or @Name_day = 'Четверг-П' or @Name_day = 'Пятница-П')
		begin
			update Days_of_the_week
			set
				Name_day = @Name_day,
				Time_start = @Time_start,
				Time_stop = @Time_stop,
				Change = @first
			where Post_code_Days_of_the_week = @Post_code_Days_of_the_week
		end
			else
			begin
				update Days_of_the_week
			set
				Name_day = @Name_day,
				Time_start = @Time_start,
				Time_stop = @Time_stop,
				Change = @last
			where Post_code_Days_of_the_week = @Post_code_Days_of_the_week
			end
	end
GO

create procedure Add_Nominal_cabinet
(
	@Name_cabinet nvarchar(50)
)
as
	begin
		insert into Nominal_cabinet(Name_cabinet)
		values (@Name_cabinet)
	end
GO

create procedure Delete_Nominal_cabinet
(
	@Post_code_Nominal_cabinet int
)
as
	begin
		delete 
		from Nominal_cabinet
		where Post_code_Name_cabinet = @Post_code_Nominal_cabinet
	end
GO

create procedure Update_Nominal_cabinet
(
	@Post_code_Name_cabinet int,
	@Name_cabinet nvarchar(50)
)
as
	begin
		update Nominal_cabinet
		set 
			Name_cabinet = @Name_cabinet
		where Post_code_Name_cabinet = @Post_code_Name_cabinet 
	end
GO

create procedure Add_Schedule_cabinet
(
	@Number_cabinet int,
	@FK_post_code_Nominal_cabinet nvarchar(50),
	@FK_post_code_Person nvarchar(50),
	@FK_post_code_Days_of_the_week nvarchar(50)
)
as
	begin 
		declare @fk_Nominal int
		set  @fk_Nominal = (select Post_code_Name_cabinet
							from Nominal_cabinet	
							where Nominal_cabinet.Name_cabinet = @FK_post_code_Nominal_cabinet)
							

		declare @fk_person int
		set @fk_person = (select Post_code_Person
						  from Person
						  where Person.Surname = @FK_post_code_Person)

		declare @prov_cabinet int
			set @prov_cabinet = (select COUNT(*)
							 from Schedule_cabinet
							 where Schedule_cabinet.Number_cabinet = @Number_cabinet)

		declare @fk_days int
		set @fk_days = (select Post_code_Days_of_the_week
						from Days_of_the_week
						where Days_of_the_week.Name_day = @FK_post_code_Days_of_the_week)

			if (@prov_cabinet = 0)
			begin		
				insert into Schedule_cabinet(Number_cabinet, FK_post_code_Nominal_cabinet, FK_post_code_Person, FK_post_code_Days_of_the_week)
				values (@Number_cabinet, @fk_Nominal, @fk_person, @fk_days)
			end
			else raiserror('Ошибка такой кабинет существует',16,10);
	end
GO

create procedure Delete_Schedule_cabinet
(
	@Post_code_Schedule_cabinet int
)
as
	begin
		delete 
		from Schedule_cabinet
		where Post_code_Schedule_cabinet = @Post_code_Schedule_cabinet
	end
GO

create procedure Update_Schedule_cabinet
(
	@Post_code_Schedule_cabinet int,
	@Number_cabinet int,
	@FK_post_code_Nominal_cabinet nvarchar(50),
	@FK_post_code_Person nvarchar(50),
	@FK_post_code_Days_of_the_week nvarchar(50) 
)
as
	begin
		declare @fk_Nominal int
		set  @fk_Nominal = (select Post_code_Name_cabinet
							from Nominal_cabinet	
							where Nominal_cabinet.Name_cabinet = @FK_post_code_Nominal_cabinet)
							
		declare @prov_Nominal int
		set @prov_Nominal = (select count(*) from Schedule_cabinet where Schedule_cabinet.FK_post_code_Nominal_cabinet = @fk_Nominal)
		
		declare @fk_person int
		set @fk_person = (select Post_code_Person
						  from Person
						  where Person.Surname = @FK_post_code_Person)

		declare @prov_Person int 
		set @prov_Person = (select count(*) from Schedule_cabinet where Schedule_cabinet.FK_post_code_Person = @fk_person)

		declare @prov_cabinet int
			set @prov_cabinet = (select COUNT(*)
							 from Schedule_cabinet
							 where Schedule_cabinet.Number_cabinet = @Number_cabinet)

		declare @fk_days int
		set @fk_days = (select Post_code_Days_of_the_week
						from Days_of_the_week
						where Days_of_the_week.Name_day = @FK_post_code_Days_of_the_week)
		if (@prov_cabinet <=1 AND @prov_Nominal<=1 AND @prov_Person<=1)
		begin
			update Schedule_cabinet
			set
				Number_cabinet = @Number_cabinet,
				FK_post_code_Nominal_cabinet = @fk_Nominal,
				FK_post_code_Person = @fk_person,
				FK_post_code_Days_of_the_week = @fk_days
			where Post_code_Schedule_cabinet = @Post_code_Schedule_cabinet
		end
		else raiserror('Ошибка такой кабинет, персонал или номер кабинета существует',16,10);
	end
GO

create procedure Add_Ticket
(
	@Number_ticket int,
	@FK_post_code_Schedule_cabinet nvarchar(50),
	@FK_post_code_Patient nvarchar(50),
	@Time_ticket time
	
)
as
	begin
		declare @fk_patient int
			set @fk_patient = (select Post_code_Patient 
							   from Patient
							   where Patient.Surname = @FK_post_code_Patient)

		declare @fk_schedule_cab int
			set @fk_schedule_cab = (select Post_code_Schedule_cabinet
									from Schedule_cabinet
									where Schedule_cabinet.Number_cabinet = @FK_post_code_Schedule_cabinet)

		declare @prov_tiket int 
		set @prov_tiket = (select count(*) from Ticket where Ticket.Number_ticket = @Number_ticket)

		if (@prov_tiket=0)
		begin
			insert into Ticket(Number_ticket, FK_post_code_Schedule_cabinet, FK_post_code_Patient, Time_ticket)
			values(@Number_ticket, @fk_schedule_cab, @fk_patient, @Time_ticket)
		end
		else raiserror('ошибка такой номер талона существует',16,10);
	end
GO

create procedure Delete_Ticket
(
	@Post_code_Ticket int
)
as
	begin
		delete 
		from Ticket
		where Post_code_Ticket = @Post_code_Ticket
	end
GO

create procedure Update_Ticket
(
	@Post_code_Ticket int,
	@Number_ticket int,
	@FK_post_code_Schedule_cabinet nvarchar(50),
	@FK_post_code_Patient nvarchar(50),
	@Time_ticket time
)
as
	begin
	declare @fk_patient int
		set @fk_patient = (select Post_code_Patient 
						   from Patient
						   where Patient.Surname = @FK_post_code_Patient)
	declare @fk_schedule_cab int
		set @fk_schedule_cab = (select Post_code_Schedule_cabinet
								from Schedule_cabinet
								where Schedule_cabinet.Number_cabinet = @FK_post_code_Schedule_cabinet)

	declare @prov_number_ticket int 
		set @prov_number_ticket = (select count(*) from Ticket where Ticket.Number_ticket = @Number_ticket)

	declare @prov_time int 
		set @prov_time = (select count(*) from Ticket where Ticket.Time_ticket = @Time_ticket)

		if(@prov_time <= 1 and @prov_number_ticket <= 1)
		begin
			update Ticket
			set 
				Number_ticket = @Number_ticket,
				FK_post_code_Schedule_cabinet = @fk_schedule_cab,
				FK_post_code_Patient = @fk_patient,
				Time_ticket = @Time_ticket
			where Post_code_Ticket = @Post_code_Ticket
		end
		else raiserror('ошибка такое время талона или номер талона существует',16,10);
	end
GO

create procedure Add_lot
(
	@Number_lot int
)
as
	begin
		declare @prov_lot int 
			set @prov_lot = (select count(*) from Lot where Lot.Number_lot = @Number_lot)

		if(@prov_lot = 0)
		begin 
			insert into Lot (Number_lot)
			values (@Number_lot)
		end		
			else raiserror('ошибка такой номер участка существует',16,10);
	end
GO

create procedure Delete_lot
(
	@Post_code_Lot int
)
as
	begin
		delete
		from Lot
		where Post_code_Lot = @Post_code_Lot
	end
GO

create procedure Update_Lot
(
	@Post_code_Lot int,
	@Number_lot int
)
as
	begin
	declare @prov_lot int 
			set @prov_lot = (select count(*) from Lot where Lot.Number_lot = @Number_lot)

		if(@prov_lot <= 1)
		begin 
			update Lot
			set
				Number_lot = @Number_lot
			where Post_code_Lot = @Post_code_Lot
		end
			else
				raiserror('ошибка такой участок существует',16,10);
	end
GO

create procedure Add_Fixing_lot
(
	@Date_fixing date,
	@FK_post_code_Lot nvarchar(50),
	@FK_post_code_Person nvarchar(50)
)
as
	begin
		declare @fk_lot int 
			set @fk_lot = (select Post_code_Lot	
						   from Lot
						   where Lot.Number_lot = @FK_post_code_Lot)

		declare @fk_person int
			set @fk_person = (select Post_code_Person
							  from Person
							  where Person.Surname = @FK_post_code_Person)
		
		insert into Fixing_Lot (Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
		values (@Date_fixing, NULL, @fk_lot, @fk_person)
	end
GO

create procedure Delete_Fixing_lot
(
	@Post_code_Fixing_lot int
)
as
	begin
		delete
		from Fixing_lot
		where Post_code_Fixing_lot = @Post_code_Fixing_lot
	end
GO

create procedure Update_Fixing_lot
(
	@Post_code_Fixing_lot int,
	@Date_fixing date,
	@FK_post_code_Lot nvarchar(50),
	@FK_post_code_Person nvarchar(50)
)
as
	begin
		declare @fk_lot int 
			set @fk_lot = (select Post_code_Lot	
						   from Lot
						   where Lot.Number_lot = @FK_post_code_Lot)
		declare @fk_person int
			set @fk_person = (select Post_code_Person
							  from Person
							  where Person.Surname = @FK_post_code_Person)
		declare @prov_lot int
			set @prov_lot = (select count(*) 
							 from Fixing_lot
							 where Fixing_lot.FK_post_code_Lot = @fk_lot)
		declare @prov_person int 
			set @prov_person = (select count(*)
								from Fixing_lot
								where Fixing_lot.FK_post_code_Person = @fk_person)
		if(@prov_lot <= 1 AND @prov_person <= 1)
		begin
			update Fixing_lot
			set 
				Date_fixing = @Date_fixing,
				Date_stop = NULL,
				FK_post_code_Lot = @fk_lot,
				FK_post_code_Person = @fk_person
			where Post_code_Fixing_lot = @Post_code_Fixing_lot
		end
			else raiserror('ошибка такой участок или персонал существует',16,10);
	end
GO

create procedure Add_Street
(
	@Name_street nvarchar(100),
	@FK_post_code_Lot nvarchar(100)
)
as
	begin 
		declare @fk_lot int 
			set @fk_lot = (select Post_code_Lot
							from Lot	
							where Lot.Number_lot = @FK_post_code_Lot)

		declare @prov_street int 
			set @prov_street = (select count(*) from Street where Street.Name_street = @Name_street)

		if(@prov_street = 0)
		begin
			insert into Street(Name_street, FK_post_code_Lot)
			values (@Name_street, @fk_lot)
		end
			else raiserror('ошибка такая улица существует',16,10);
	end
GO

create procedure Delete_Street
(
	@Post_code_Street int
)
as
	begin
		delete 
		from Street
		where Post_code_Street = @Post_code_Street
	end
GO

create procedure Update_Street
(
	@Post_code_Street int,
	@Name_street nvarchar(100),
	@FK_post_code_Lot nvarchar(100)
)
as	
	begin
	declare @fk_lot int 
			set @fk_lot = (select Post_code_Lot
							from Lot	
							where Lot.Number_lot = @FK_post_code_Lot)

		declare @prov_street int 
			set @prov_street = (select count(*) from Street where Street.Name_street = @Name_street)
		
			if(@prov_street <= 1)
			begin
				update Street
				set
				Name_street = @Name_street,
				FK_post_code_Lot = @fk_lot
				where Post_code_Street = @Post_code_Street
			end
				else raiserror('ошибка такая улица существует',16,10);
	end
GO

create procedure Add_Patient
(
	@Surname nvarchar(50),
	@Name nvarchar(50),
	@Lastname nvarchar(50),
	@Number_pasport nvarchar(50),
	@Date_of_birth date,
	@Status_patient nvarchar(50),
	@FK_post_code_Street nvarchar(50)
)
as
	begin
		declare @fk_street int
			set @fk_street = (select Post_code_Street
							  from Street
							  where Street.Name_street = @FK_post_code_Street)

		insert into Patient(Surname, Name, Lastname, Number_pasport, Date_of_birth, Status_patient, FK_post_code_Street)
		values (@Surname, @Name, @Lastname, @Number_pasport, @Date_of_birth, @Status_patient, @fk_street)

	end
GO

create procedure Delete_Patient
(
	@Post_code_Patient int
)
as
	begin
		delete 
		from Patient
		where Post_code_Patient = @Post_code_Patient
	end
GO

create procedure Update_Patient
(
	@Post_code_Patient int,
	@Surname nvarchar(50),
	@Name nvarchar(50),
	@Lastname nvarchar(50),
	@Number_pasport nvarchar(50),
	@Date_of_birth date,
	@Status_patient nvarchar(50),
	@FK_post_code_Street nvarchar(50)
)
as
	begin
		declare @fk_street int
			set @fk_street = (select Post_code_Street
							  from Street
							  where Street.Name_street = @FK_post_code_Street)
		declare @prov_st nvarchar(50)
			set @prov_st = (select Status_patient	
							from Patient
							where Patient.Post_code_Patient = @Post_code_Patient)

			update Patient
			set
				Surname = @Surname,
				Name = @Name,
				Lastname = @Lastname,
				Number_pasport = @Number_pasport,
				Date_of_birth = @Date_of_birth,
				Status_patient = @Status_patient,
				FK_post_code_Street = @fk_street
			where Post_code_Patient = @Post_code_Patient

	end
GO

create procedure Add_Serrvices
(
	@Name_service nvarchar(50),
	@Cast_of int
)
as
	begin
	declare @prov_ser int
			set @prov_ser = (select count(*)
							from Serrvices
							where Serrvices.Name_services = @Name_service)
		if (@prov_ser = 0)
		begin
			insert into Serrvices (Name_services, Cast_of)
			values (@Name_service, @Cast_of)
		end
		else raiserror('ошибка такая услуга существует',16,10);
	end
GO

create procedure Delete_Serrvices
(
	@Post_code_Services int
)
as
	begin
		delete
		from Serrvices
		where Post_code_Services = @Post_code_Services
	end
GO

create procedure Update_Serrvices
(
	@Post_code_Services int,
	@Name_service nvarchar(50),
	@Cast_of int
)
as
	begin

		begin
			update Serrvices
			set
				Name_services = @Name_service,
				Cast_of = @Cast_of
			where Post_code_Services = @Post_code_Services
		end
	end
GO

create procedure Add_Reception
(
	@FK_post_code_Ticket nvarchar(50),
	@FK_post_code_Serrvices nvarchar(50)
)
as
	begin
		
		declare @fk_ticket int 
			set @fk_ticket = (select Post_code_Ticket
							  from Ticket
							  where Ticket.Number_ticket = @FK_post_code_Ticket)
		declare @fk_serrvices int
			set @fk_serrvices = (select Post_code_Services
								 from Serrvices
								 where Serrvices.Name_services = @FK_post_code_Serrvices)

		insert into Reception(FK_post_code_Ticket, FK_post_code_Serrvices)
		values(@fk_ticket, @fk_serrvices)

		declare @fk_rec int
			set @fk_rec = (select max(Post_code_Reception) from Reception)

			insert into Payment(FK_post_code_reception)
			values(@fk_rec)
	end
GO

create procedure Delete_Reception
(
	@Post_code_Reception int
)
as
	begin
		delete 
		from Reception
		where Post_code_Reception = @Post_code_Reception
	end
GO

create procedure Update_Reception
(
	@Post_code_Reception int,
	@FK_post_code_Ticket nvarchar(50),
	@FK_post_code_Serrvices nvarchar(50)
)
as
	begin
		
		declare @fk_ticket int 
			set @fk_ticket = (select Post_code_Ticket
							  from Ticket
							  where Ticket.Number_ticket = @FK_post_code_Ticket)
		declare @fk_serrvices int
			set @fk_serrvices = (select Post_code_Services
								 from Serrvices
								 where Serrvices.Name_services = @FK_post_code_Serrvices)

		update Reception
		set 
			FK_post_code_Ticket = @fk_ticket,
			FK_post_code_Serrvices = @fk_serrvices
		where Post_code_Reception = @Post_code_Reception
	end
GO

create procedure Add_Payment
(
	@FK_post_code_reception nvarchar(50)
)
as
	begin
		declare @fk_reception int
			set @fk_reception = (select Reception.Post_code_Reception 
								 from   Reception
								 where  Reception.Post_code_Reception = @FK_post_code_reception)

		insert into Payment(FK_post_code_reception)
		values(@fk_reception)
	end
GO

create procedure Add_Diagnosis
(
	@Name_Diagnos nvarchar(50),
	@FK_post_code_Specification nvarchar(50)
)
as
	begin
	
		declare @fk_speci int
		set @fk_speci = (select Specification.Post_code_Specification
						from Specification
						where Specification.Name_specification = @FK_post_code_Specification)
		
		insert into Diagnosis (Name_Diagnos,FK_post_code_Specification)
		values(@Name_Diagnos,@fk_speci)
	end
GO


create procedure Add_Cart_Patient
(
	@Procedure_status nvarchar(50),
	@Name_procederr nvarchar(50),
	@Resept nvarchar(50),
	@Date_of_write date,
	@FK_post_code_Patient nvarchar(50),
	@FK_post_code_Diagnosis nvarchar(50)
)
as
	begin
	
		declare @fk_patientss int
		set @fk_patientss = (select Patient.Post_code_Patient
						from Patient
						where Patient.Surname = @FK_post_code_Patient)
		
		declare @fk_diag int
		set @fk_diag = (select Diagnosis.Post_code_Diagnosis
						from Diagnosis
						where Diagnosis.Name_Diagnos = @FK_post_code_Diagnosis)
		insert into Cart_Patient (Procedure_status, Name_procederr, Resept, Date_of_write, FK_post_code_Patient,FK_post_code_Diagnosis)
		values(@Procedure_status,@Name_procederr, @Resept, @Date_of_write, @fk_patientss,@fk_diag)
	end
GO

/*create procedure Delete_Cart_Patient
(
	@Post_code_Cart_Patient int
)
as 
	begin
		delete 
		from Cart_Patient 
		where Post_code_Cart_Patient = @Post_code_Cart_Patient
	end	
GO

create procedure Update_Cart_Patient
(
	@Post_code_Cart_Patient int,
	@Procedure_status nvarchar(50),
	@FK_post_code_Patient nvarchar(50),
	@FK_post_code_Diagnosis nvarchar(50)
)
as
	begin
		declare @fk_patientd int
		set @fk_patientd = (select Patient.Post_code_Patient
						from Patient
						where Patient.Surname = @FK_post_code_Patient)
		
		declare @fk_diagos int
		set @fk_diagos = (select Diagnosis.Post_code_Diagnosis
						from Diagnosis
						where Diagnosis.Name_Diagnos = @FK_post_code_Diagnosis)
						
		update Cart_Patient 
		set Procedure_status = @Procedure_status,
			FK_post_code_Patient = @fk_patientd,
			FK_post_code_Diagnosis = @fk_diagos
		where Post_code_Cart_Patient = @Post_code_Cart_Patient
	end
GO*/


create trigger Trigger_add_Position
on Position
instead of insert
as
	begin
		declare @prov_job nvarchar(50)
		set @prov_job = (select inserted.Job_title from inserted)

		declare @prov int
		set @prov = (select count(*) from Position where  Position.Job_title = @prov_job)

		if(@prov = 0)
		begin
			insert into Position(Job_title, Salary)
			values ((select inserted.Job_title from inserted), (select inserted.Salary from inserted))
		end
		else
		rollback

	end
GO

create trigger Trigger_add_Specification
on Specification
instead of insert
as 
	begin
		declare @prov_specification nvarchar(50)
		set @prov_specification = (select inserted.Name_specification from inserted)
		begin
		
		declare @prov int
		set @prov = (select count(*) from Specification where Specification.Name_specification = @prov_specification)
		
		if(@prov = 0)
			insert into Specification(Name_specification)
			values((select inserted.Name_specification from inserted))
		else
			rollback
			end
	end
GO

create trigger Trigger_update_Position
on Position
instead of update
as
	begin
		declare @prov_job nvarchar(50)
		set @prov_job = (select inserted.Job_title from inserted)

		declare @prov int
		set @prov = (select count(*) from Position where  Position.Job_title = @prov_job)

		if(@prov <= 1)
		begin
			update Position
				set Job_title = (select inserted. Job_title from inserted),
					Salary = (select inserted.Salary from inserted)
				where Post_code_Position = (select inserted.Post_code_Position from inserted)
		end
		else
		rollback

	end
GO

create trigger Trigger_update_Specification
on Specification
instead of update
as 
	begin
		declare @prov_specification nvarchar(50)
		set @prov_specification = (select inserted.Name_specification from inserted)
		
		declare @prov int
		set @prov = (select count(*) from Specification where Specification.Name_specification = @prov_specification)
		
		if(@prov <= 1)
		begin
			update Specification 
				set Name_specification = (select inserted.Name_specification from inserted)
				where Post_code_Specification = (select inserted.Post_code_Specification from inserted)
		end	
		else
			rollback
	end
GO

create trigger Trigger_insert_Person
on Person
instead of insert
as 
	begin
		declare @number_pasport_prov nvarchar(50)
		set @number_pasport_prov = (select inserted.Number_pasport from inserted)

		declare @proverka int
		set @proverka = (select count(*) from Person where Person.Number_pasport = @number_pasport_prov)
		if(@proverka = 0)
		begin
			insert into Person (Number_pasport, Surname, Name, Lastname, Date_of_birth, Registration, Staj, FK_code_post_Specification)
			values((select inserted.Number_pasport from inserted), (select inserted.Surname from inserted), (select inserted.Name from inserted), (select inserted.Lastname from inserted)
			,(select inserted.Date_of_birth from inserted), (select inserted.Registration from inserted), (select inserted.Staj from inserted), (select inserted.FK_code_post_Specification from inserted))
		end
		else
		rollback
	end
GO



create trigger Trigger_add_fixing_lot
on Fixing_lot
instead of insert
as
	begin
		declare @fk_person nvarchar(50) 
			set @fk_person = (select inserted.FK_post_code_Person from inserted)

		declare @fkp int
			set @fkp = (select Post_code_Person 
						from Person
						where Person.Surname = @fk_person)	
								
		declare @prov int
			set @prov = (select count(*)
						from Fixing_lot
						where Fixing_lot.FK_post_code_Person = @fk_person)
						 
		declare @fk_lot nvarchar(50)
			set @fk_lot = (select inserted.FK_post_code_Lot from inserted)

		declare @fkl int
			set @fkl = (select Post_code_Lot
						from Lot
						where Lot.Number_lot = @fk_lot)
			
			declare @prov_lot int
				set @prov_lot = (select count(*) from Fixing_lot
								where Fixing_lot.FK_post_code_Lot = @fk_lot)
		
		if(@prov = 0 AND @prov_lot = 0)
		begin
			insert into Fixing_lot(Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
			values ((select inserted.Date_fixing from inserted), NULL, @fkl, @fk_person)
		end
			else
				rollback
	end
GO

create trigger Trigger_add_Reception
on Reception
instead of insert
as
	begin
		declare @number_ticket int
			set @number_ticket = (select inserted.FK_post_code_Ticket from inserted)

		declare @prov_number_ticket int
			set @prov_number_ticket = (select count(*)
									   from Reception
									   where Reception.FK_post_code_Ticket = @number_ticket)

			if(@prov_number_ticket = 0)
			begin
				insert into Reception(FK_post_code_Ticket, FK_post_code_Serrvices)
				values((select inserted.FK_post_code_Ticket from inserted), (Select inserted.FK_post_code_Serrvices from inserted))
			end
				else
					rollback
	end
GO

create trigger Trigger_add_Patient
on Patient
instead of insert
as
	begin
		declare @number_pasport nvarchar(50)
			set @number_pasport = (select inserted.Number_pasport from inserted)

		declare @prov_pasport int
			set @prov_pasport = (select count(*) from Patient where Patient.Number_pasport = @number_pasport)

		if(@prov_pasport = 0)
		begin
			insert into Patient(Surname, Name, Lastname, Number_pasport, Date_of_birth, Status_patient, FK_post_code_Street)
			values ((select inserted.Surname from inserted), (select inserted.Name from inserted), (select inserted.Lastname from inserted), (select inserted.Number_pasport from inserted), 
					(select inserted.Date_of_birth from inserted),(select inserted.Status_patient from inserted), (select inserted.FK_post_code_Street from inserted))
		end
			else
				rollback 
	end
GO

create trigger Trigger_add_Nominal_cabinet
on Nominal_cabinet
instead of insert
as
	begin
		declare @Name_cab nvarchar(50)
			set @Name_cab = (select inserted.Name_cabinet from inserted)
		declare @prov int
			set @prov = (select count(*) 
						 from Nominal_cabinet 
						 where Nominal_cabinet.Name_cabinet = @Name_cab)
		if(@prov = 0)
		begin
			insert into Nominal_cabinet(Name_cabinet)
			values ((select inserted.Name_cabinet from inserted))
		end
			else
				rollBack print('Существует кабинет с таким названием!!!')
	end
GO

create trigger Trigger_add_Days
on Days_of_the_week
instead of insert
as
	begin
		declare @first nvarchar(20)
			set @first = 'Первая'

		declare @last nvarchar(20)
			set @last = 'Вторая'

		declare @name_day nvarchar(50)
			set @name_day = (select inserted.Name_day from inserted)

		declare @prov_name_day int
			set @prov_name_day = (select count(*) from Days_of_the_week where Days_of_the_week.Name_day = @name_day)

		if(@prov_name_day = 0)
		begin
			if(@name_day = 'Понедельник-П' or @name_day = 'Вторник-П' or @name_day = 'Среда-П' or @name_day = 'Четверг-П' or @name_day = 'Пятница-П')
			begin
				insert into Days_of_the_week(Name_day, Time_start, Time_stop, Change)
				values (@name_day, (select inserted.Time_start from inserted), (select inserted.Time_stop from inserted), @first)
			end
			else
				begin
					insert into Days_of_the_week(Name_day, Time_start, Time_stop, Change)
					values (@name_day, (select inserted.Time_start from inserted), (select inserted.Time_stop from inserted), @last)
				end
		end
			else
				rollback
	end
GO

create trigger new_Trigger_add_Schedule_cabinet
on Schedule_cabinet
instead of insert
as
	begin
		declare @fk_person nvarchar(50) 
			set @fk_person = (select inserted.FK_post_code_Person from inserted)
								
		declare @prov int
			set @prov = (select count(*)
						from Schedule_cabinet
						where Schedule_cabinet.FK_post_code_Person = @fk_person)


		declare @fk_nominal nvarchar(50)
			set @fk_nominal = (select inserted.FK_post_code_Nominal_cabinet from inserted)



		declare @prov_nom int
			set @prov_nom = (select COUNT(*)
							 from Schedule_cabinet
							 where Schedule_cabinet.FK_post_code_Nominal_cabinet = @fk_nominal)
		declare @dol nvarchar(50)
		set @dol = ( select Job_title from Person, Position,Recruitment,Schedule_cabinet,Nominal_cabinet
		where Recruitment.FK_post_code_Person=Person.Post_code_Person AND Recruitment.FK_post_code_Position=Position.Post_code_Position
		AND Person.Post_code_Person = Schedule_cabinet.FK_post_code_Person AND Nominal_cabinet.Post_code_Name_cabinet=Schedule_cabinet.FK_post_code_Nominal_cabinet
		AND Position.Job_title=Nominal_cabinet.Name_cabinet)
	

		if(@prov = 0 AND @prov_nom = 0)
		begin
			insert into Schedule_cabinet(Number_cabinet, FK_post_code_Nominal_cabinet, FK_post_code_Person, FK_post_code_Days_of_the_week)
			values ((select inserted.Number_cabinet from inserted), @fk_nominal, @fk_person, (select inserted.FK_post_code_Days_of_the_week from inserted))
		end
			else
				rollback
	end
GO


create procedure add_users
(
	@login_ nvarchar(50),
	@password1 nvarchar(50)
)
AS
	begin
		exec sp_addlogin @login_,@password1, 'Clinic'
		exec sp_adduser @login_,@login_, null
	end
GO

create procedure delete_users
(
	@login_ nvarchar(50)
)
AS
	begin
		exec sp_droplogin @login_
		exec sp_dropuser @login_
	end
GO

insert into SPECIFICATION (Name_specification)
values ('Хирург');
insert into SPECIFICATION (Name_specification)
values ('Стоматолог');
insert into SPECIFICATION (Name_specification)
values ('Терапевт');
insert into SPECIFICATION (Name_specification)
values ('Лор');
insert into SPECIFICATION (Name_specification)
values ('Окулист');
insert into SPECIFICATION (Name_specification)
values ('Физиотерапевт');
insert into SPECIFICATION (Name_specification)
values ('Гинеколог');

insert into Lot (Number_lot)
values (1);
insert into Lot (Number_lot)
values (2);
insert into Lot (Number_lot)
values (3);
insert into Lot (Number_lot)
values (4);
insert into Lot (Number_lot)
values (5);
insert into Lot (Number_lot)
values (6);
insert into Lot (Number_lot)
values (7);
insert into Lot (Number_lot)
values (8);
insert into Lot (Number_lot)
values (9);

insert into Street (Name_street,FK_post_code_Lot)
values ('Челюскинса',1);
insert into Street (Name_street,FK_post_code_Lot)
values ('Парковая',2);
insert into Street (Name_street,FK_post_code_Lot)
values ('Ленинская',3);
insert into Street (Name_street,FK_post_code_Lot)
values ('Коммунистическая',4);
insert into Street (Name_street,FK_post_code_Lot)
values ('Независимости',5);
insert into Street (Name_street,FK_post_code_Lot)
values ('Свердлова',1);

insert into Patient (Surname,Name,Lastname,Number_pasport,Date_of_birth,Status_patient,FK_post_code_Street)
values ('Петрович','Александр','Александрович','BM1234567','19960228','Здоров',1);
insert into Patient (Surname,Name,Lastname,Number_pasport,Date_of_birth,Status_patient,FK_post_code_Street)
values ('Гоголь','Николай','Александрович','BM1284567','19900202','Болен',2);
insert into Patient (Surname,Name,Lastname,Number_pasport,Date_of_birth,Status_patient,FK_post_code_Street)
values ('Петров','Александр','Николаевич','BM5234567','19980322','Здоров',3);
insert into Patient (Surname,Name,Lastname,Number_pasport,Date_of_birth,Status_patient,FK_post_code_Street)
values ('Романов','Михаил','Петрович','BM7234567','19880121','Здоров',4);
insert into Patient (Surname,Name,Lastname,Number_pasport,Date_of_birth,Status_patient,FK_post_code_Street)
values ('Сергеев','Сергей','Александрович','BM6234167','19990320','Болен',5);
insert into Patient (Surname,Name,Lastname,Number_pasport,Date_of_birth,Status_patient,FK_post_code_Street)
values ('Ломоносов','Илья','Леонидович','BM4234517','19900528','Болен',6);
insert into Patient (Surname,Name,Lastname,Number_pasport,Date_of_birth,Status_patient,FK_post_code_Street)
values ('Детров','Денис','Александрович','BM3234537','19950505','Здоров',1);

insert into Person(Surname,Name,Lastname,Number_pasport,Date_of_birth,Registration,Staj,FK_code_post_Specification)
values ('Попов','Иван','Иванов','BM1234567','19800202','ул.Парковая д.3 кв.10','13','1');
insert into Person(Surname,Name,Lastname,Number_pasport,Date_of_birth,Registration,Staj,FK_code_post_Specification)
values ('Петров','Денис','Петрович','BM5689742','19850202','ул.Челюскинса д.3 кв.15','5','2');
insert into Person(Surname,Name,Lastname,Number_pasport,Date_of_birth,Registration,Staj,FK_code_post_Specification)
values ('Иванов','Василий','Василиевич','BM2456358','19800202','ул.Победителей д.2 кв.11','6','3');
insert into Person(Surname,Name,Lastname,Number_pasport,Date_of_birth,Registration,Staj,FK_code_post_Specification)
values ('Ланиров','Иван','Юрьевич','BM9876543','19770302','ул.Парковая д.5 кв.20','7','4');
insert into Person(Surname,Name,Lastname,Number_pasport,Date_of_birth,Registration,Staj,FK_code_post_Specification)
values ('Донилов','Иван','Петрович','BM7876543','19770302','ул.Парковая д.9 кв.20','7','5');
insert into Person(Surname,Name,Lastname,Number_pasport,Date_of_birth,Registration,Staj,FK_code_post_Specification)
values ('Жуков','Иван','Деньтьевич','BM9876513','19790302','ул.Челюскинса д.10 кв.10','6','6');
insert into Person(Surname,Name,Lastname,Number_pasport,Date_of_birth,Registration,Staj,FK_code_post_Specification)
values ('Тараканов','Иван','Александрович','BM7871543','19780302','ул.Советская д.20 кв.25','5','7');

insert into Position (Job_title,Salary)
values ('Главврач','1000');
insert into Position (Job_title,Salary)
values ('Врач','500');


insert into Recruitment (Date_start,Date_stop,FK_post_code_Person,FK_post_code_Position)
values ('20180501',NULL,'1','1');
insert into Recruitment (Date_start,Date_stop,FK_post_code_Person,FK_post_code_Position)
values ('20180301',NULL,'2','2');
insert into Recruitment (Date_start,Date_stop,FK_post_code_Person,FK_post_code_Position)
values ('20180111',NULL,'3','2');
insert into Recruitment (Date_start,Date_stop,FK_post_code_Person,FK_post_code_Position)
values ('20180421',NULL,'4','2');
insert into Recruitment (Date_start,Date_stop,FK_post_code_Person,FK_post_code_Position)
values ('20180601',NULL,'5','2');
insert into Recruitment (Date_start,Date_stop,FK_post_code_Person,FK_post_code_Position)
values ('20180611',NULL,'6','2');
insert into Recruitment (Date_start,Date_stop,FK_post_code_Person,FK_post_code_Position)
values ('20180511',NULL,'7','2');


insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Вроший нокоть','1');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Геморой','1');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Кариес','2');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Простуда','3');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Ушная пробка','4');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Остигматизм','5');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Болевой синдром','6');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Болезни опорно-двигательной системы','6');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Заболевания нервной системы','6');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Нарушения менструального цикла','6');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Гипоплазия матки','7');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Эрозия шейки матки','7');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Уреаплазмоз','7');
insert into Diagnosis(Name_Diagnos,FK_post_code_Specification)
values ('Микоплазмоз','7');



insert into Nominal_cabinet (Name_cabinet)
values ('Хирург');
insert into Nominal_cabinet (Name_cabinet)
values ('Стоматолог');
insert into Nominal_cabinet (Name_cabinet)
values ('Терапевт');
insert into Nominal_cabinet (Name_cabinet)
values ('Лор');
insert into Nominal_cabinet (Name_cabinet)
values ('Окулист');
insert into Nominal_cabinet (Name_cabinet)
values ('Физиотерапевт');
insert into Nominal_cabinet (Name_cabinet)
values ('Гинеколог');




insert into Fixing_lot (Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
values ('20180101','20181231',1,1);
insert into Fixing_lot (Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
values ('20180101','20181231',2,2);
insert into Fixing_lot (Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
values ('20180101','20181231',3,3);
insert into Fixing_lot (Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
values ('20180101','20181231',4,4);
insert into Fixing_lot (Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
values ('20180101','20181231',5,5);
insert into Fixing_lot (Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
values ('20180101','20181231',6,6);
insert into Fixing_lot (Date_fixing, Date_stop, FK_post_code_Lot, FK_post_code_Person)
values ('20180101','20181231',7,7);


insert into Serrvices (Name_services,Cast_of)
values ('Обследование','200');
insert into Serrvices (Name_services,Cast_of)
values ('Мрт','500');
insert into Serrvices (Name_services,Cast_of)
values ('Прогревание','200');
insert into Serrvices (Name_services,Cast_of)
values ('Ультразвук','200');
insert into Serrvices (Name_services,Cast_of)
values ('Лазеротерапия','200');
insert into Serrvices (Name_services,Cast_of)
values ('Узи','200');

insert into Days_of_the_week (Name_day,Time_start,Time_stop,Change)
values ('Понедельник-П','08:00:00.0000000','14:00:00.0000000','Первая');
insert into Days_of_the_week (Name_day,Time_start,Time_stop,Change)
values ('Понедельник-В','16:00:00.0000000','20:00:00.0000000','Вторая');
insert into Days_of_the_week (Name_day,Time_start,Time_stop,Change)
values ('Вторник-П','08:00:00.0000000','14:00:00.0000000','Первая');
insert into Days_of_the_week (Name_day,Time_start,Time_stop,Change)
values ('Вторник-В','16:00:00.0000000','20:00:00.0000000','Вторая');
insert into Days_of_the_week (Name_day,Time_start,Time_stop,Change)
values ('Среда-П','08:00:00.0000000','14:00:00.0000000','Первая');
insert into Days_of_the_week (Name_day,Time_start,Time_stop,Change)
values ('Среда-В','16:00:00.0000000','20:00:00.0000000','Вторая');
insert into Days_of_the_week (Name_day,Time_start,Time_stop,Change)
values ('Четверг-П','08:00:00.0000000','14:00:00.0000000','Первая');
insert into Days_of_the_week (Name_day,Time_start,Time_stop,Change)
values ('Четверг-В','16:00:00.0000000','20:00:00.0000000','Вторая');

insert into Cart_Patient (Procedure_status,Name_procederr,Resept,Date_of_write,FK_post_code_Patient,FK_post_code_Diagnosis)
values ('Лечение','Обследование','Преднизалон','20181231',1,1);
insert into Cart_Patient (Procedure_status,Name_procederr,Resept,Date_of_write,FK_post_code_Patient,FK_post_code_Diagnosis)
values ('Лечение','Обследование','Лейцин','20181231',2,2);
insert into Cart_Patient (Procedure_status,Name_procederr,Resept,Date_of_write,FK_post_code_Patient,FK_post_code_Diagnosis)
values ('Лечение','Прогревание','Преднизалон','20181231',2,3);


insert into Schedule_cabinet (Number_cabinet, FK_post_code_Nominal_cabinet,FK_post_code_Person,FK_post_code_Days_of_the_week)
values ('1',1,1,1);
insert into Schedule_cabinet (Number_cabinet, FK_post_code_Nominal_cabinet,FK_post_code_Person,FK_post_code_Days_of_the_week)
values ('2',2,2,2);
insert into Schedule_cabinet (Number_cabinet, FK_post_code_Nominal_cabinet,FK_post_code_Person,FK_post_code_Days_of_the_week)
values ('3',3,3,3);
insert into Schedule_cabinet (Number_cabinet, FK_post_code_Nominal_cabinet,FK_post_code_Person,FK_post_code_Days_of_the_week)
values ('4',4,4,4);
insert into Schedule_cabinet (Number_cabinet, FK_post_code_Nominal_cabinet,FK_post_code_Person,FK_post_code_Days_of_the_week)
values ('5',5,5,5);

insert into Ticket (Number_ticket,FK_post_code_Schedule_cabinet,FK_post_code_Patient,Time_ticket)
values ('1',1,1,'08:00:00.0000000');
insert into Ticket (Number_ticket,FK_post_code_Schedule_cabinet,FK_post_code_Patient,Time_ticket)
values ('2',1,2,'08:10:00.0000000');
insert into Ticket (Number_ticket,FK_post_code_Schedule_cabinet,FK_post_code_Patient,Time_ticket)
values ('3',1,3,'08:20:00.0000000');


insert into Reception (FK_post_code_Ticket,FK_post_code_Serrvices)
values (1,1);
insert into Reception (FK_post_code_Ticket,FK_post_code_Serrvices)
values (2,1);
insert into Reception (FK_post_code_Ticket,FK_post_code_Serrvices)
values (3,1)



