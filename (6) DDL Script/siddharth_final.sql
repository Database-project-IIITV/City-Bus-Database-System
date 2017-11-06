CREATE TABLE Route(
Route_no char(4),
PRIMARY KEY (Route_no)
);
CREATE TABLE Bus_type(
Type_name varchar(10),
base_fare int DEFAULT '0',
seats int NOT NULL,
rate_per_km numeric(4,2) NOT NULL,
PRIMARY KEY (Type_name)
);
CREATE TABLE Pass_type(
Pass_name varchar(10),
PRIMARY KEY (Pass_name)

);
CREATE TABLE Bus_stop(
Stop_code varchar(10),
Stop_name varchar(20) NOT NULL,
PRIMARY KEY (Stop_code)

);
CREATE TABLE Has_Stop(
Route_no char(4),
Stop_code varchar(10),
Stop_no int,
Km_from_previous_stop decimal(4,2) NOT NULL,
time_from_previous_stop time NOT NULL,
PRIMARY KEY (Route_no,Stop_code,Stop_no),
FOREIGN KEY (Route_no) REFERENCES Route(Route_no),
FOREIGN KEY (Stop_code) REFERENCES Bus_stop(Stop_code)
);
CREATE TABLE Bus(
Bus_no int,
Bus_Number_plate char(10),
Bus_type varchar(10) NOT NULL,
daily_collection int DEFAULT '0',
PRIMARY KEY (Bus_no),
FOREIGN KEY (Bus_Type) REFERENCES Bus_type(Type_name)
);
CREATE TABLE Has_route(
Bus_no int,
Route_no char(4),
Starting_time time,
PRIMARY KEY (Bus_no,Route_no,Starting_time),
FOREIGN KEY (Bus_no)REFERENCES Bus(Bus_no),
FOREIGN KEY (Route_no) REFERENCES Route(Route_no)
);
CREATE TABLE Bus_stand(
Stop_code varchar(10),
Has_garage boolean,
no_of_plateform int NOT NULL,
PRIMARY KEY (Stop_code),
FOREIGN KEY (Stop_code) REFERENCES Bus_stop(Stop_code)
);

#Removed Foregin_key
CREATE TABLE Employee(
E_Id int,
E_name varchar(20),
E_Type int NOT NULL,
Add_Line1 varchar(20),
Add_Line2 varchar(20),
PIN int,
PRIMARY KEY (E_Id),
);
ALTER TABLE employee
ADD FOREIGN KEY (E_Type) REFERENCES Employee_Type(Type_no);

CREATE TABLE Working_for(
E_id int,
Bus_no int,
PRIMARY KEY (E_id,Bus_no),
FOREIGN KEY (E_id) REFERENCES Employee(E_Id),
FOREIGN KEY (Bus_no) REFERENCES Bus(Bus_no)
);
CREATE TABLE Department(
D_no int,
D_name varchar(20) NOT NULL UNIQUE,
Manager_id int NOT NULL,
PRIMARY KEY (D_no),
FOREIGN KEY (Manager_id) REFERENCES Employee(E_Id)
);
CREATE TABLE Employee_Type(
Type_no int,
Type_name varchar(20) NOT NULL UNIQUE,
D_No int NOT NULL,
PRIMARY KEY (Type_no),
FOREIGN KEY (D_no) REFERENCES Department(D_no)
);
CREATE TABLE Departments_in_Bus_Stand(
D_no int,
Stop_code varchar(10),
PRIMARY KEY (D_no,Stop_code),
FOREIGN KEY (D_no)REFERENCES Department(D_no),
FOREIGN KEY (Stop_code) REFERENCES Bus_stand(Stop_code)
);
CREATE TABLE Contacts(
E_id int,
contect_no int,
PRIMARY KEY (E_id,contect_no),
FOREIGN KEY (E_Id) REFERENCES Employee(E_Id)
);
CREATE TABLE Sold_passes(
Bus_type varchar(10),
Pass_type varchar(10),
Route_no char(4),
Passes_sold int DEFAULT '0',
Pass_cost int NOT NULL,
PRIMARY KEY (Bus_type,Pass_type,Route_no),
FOREIGN KEY (Bus_Type) REFERENCES Bus_type(Type_name),
FOREIGN KEY (Pass_type) REFERENCES Pass_type(Pass_name),
FOREIGN KEY (Route_no) REFERENCES Route(Route_no)

);