DROP SCHEMA TRANSPORT CASCADE;
CREATE SCHEMA TRANSPORT;
SET search_path TO TRANSPORT;

CREATE TABLE Route(
Route_no char(4),
PRIMARY KEY (Route_no)
);

CREATE TABLE Bus_type(
Type_name varchar(10),
base_fare int DEFAULT '0',
seats int NOT NULL,
rate_per_km numeric NOT NULL,
PRIMARY KEY (Type_name)
);

CREATE TABLE Pass_type(
Pass_name varchar(10),
PRIMARY KEY (Pass_name)
);

CREATE TABLE Bus_stop(
Stop_code char(3),
Stop_name varchar(30) NOT NULL,
PRIMARY KEY (Stop_code)
);

CREATE TABLE Has_Stop(
Route_no char(4),
Stop_no int,
Stop_code char(3),
distance_from_start decimal NOT NULL,
estimated_time_from_start int NOT NULL,
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
Stop_code char(3),
Has_garage boolean,
no_of_platforms int NOT NULL,
PRIMARY KEY (Stop_code),
FOREIGN KEY (Stop_code) REFERENCES Bus_stop(Stop_code)
);

CREATE TABLE Employee(
E_Id int,
E_name varchar(20),
E_Type int NOT NULL,
Add_Line1 varchar(20),
Add_Line2 varchar(20),
PIN int,
Working_In_Bus_Stand char(3), 
PRIMARY KEY (E_Id),
FOREIGN KEY (Working_In_Bus_Stand) REFERENCES Bus_Stand(Stop_Code)
);

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
PRIMARY KEY (D_no)
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
contact_no numeric,
PRIMARY KEY (E_id,contact_no),
FOREIGN KEY (E_Id) REFERENCES Employee(E_Id)
);

CREATE TABLE buses_in_garage(
bus_no integer,
route_no char(4),
Starting_time time,
PRIMARY KEY (bus_no,route_no),
FOREIGN KEY (Bus_no) REFERENCES Bus(Bus_no),
FOREIGN KEY (Route_no) REFERENCES Route(Route_no)

);
	
CREATE TABLE Sold_passes(
Bus_type varchar(10),
Pass_type varchar(10),
Route_no char(4),
Pass_cost int NOT NULL,
Passes_sold int DEFAULT '0',
PRIMARY KEY (Bus_type,Pass_type,Route_no),
FOREIGN KEY (Bus_Type) REFERENCES Bus_type(Type_name),
FOREIGN KEY (Pass_type) REFERENCES Pass_type(Pass_name),
FOREIGN KEY (Route_no) REFERENCES Route(Route_no)
);

ALTER TABLE employee
ADD FOREIGN KEY (E_Type) REFERENCES Employee_Type(Type_no);

INSERT INTO BUS_STOP VALUES ('GH4', 'GH4 Circle');
INSERT INTO BUS_STOP VALUES ('GH1', 'GH1/5 Sector 2');
INSERT INTO BUS_STOP VALUES ('GH6', 'GH6 Sector 28');
INSERT INTO BUS_STOP VALUES ('KH3', 'KH3 Circle');
INSERT INTO BUS_STOP VALUES ('SMB', 'Swamynarayan Mandir Bus Stand');
INSERT INTO BUS_STOP VALUES ('S3B', 'Sector 3B');
INSERT INTO BUS_STOP VALUES ('MSC', 'Mini Shopping Centre');
INSERT INTO BUS_STOP VALUES ('SEH', 'Soham Eye Hospital, Sector 22');
INSERT INTO BUS_STOP VALUES ('GOH', 'Government Hospital, Sector 3');
INSERT INTO BUS_STOP VALUES ('CH3', 'CH3 Circle');
INSERT INTO BUS_STOP VALUES ('S10', 'Sector 10-B Circle');
INSERT INTO BUS_STOP VALUES ('CH6', 'CH6 Yuva Chetna Circle');
INSERT INTO BUS_STOP VALUES ('GJP', 'Gandhinagar Jilla Panchayat');
INSERT INTO BUS_STOP VALUES ('TAT', 'Triambakeshwar Temple');
INSERT INTO BUS_STOP VALUES ('PTA', 'Patikashram Bus Stand');
INSERT INTO BUS_STOP VALUES ('ADT', 'Akshardham Temple');
INSERT INTO BUS_STOP VALUES ('S21', 'Sector 21 Circle');
INSERT INTO BUS_STOP VALUES ('S19', 'Sector 19 Shopping Centre');
INSERT INTO BUS_STOP VALUES ('GT1', 'Gayatri Temple, Sector 1');
INSERT INTO BUS_STOP VALUES ('INU', 'I G N O U');
INSERT INTO BUS_STOP VALUES ('CH2', 'Nyay Circle, CH2 Circle');
INSERT INTO BUS_STOP VALUES ('GH0', 'GH0 circle');
INSERT INTO BUS_STOP VALUES ('IDC', 'Indrora Circle');
INSERT INTO BUS_STOP VALUES ('PTM', 'Pratik Mall');
INSERT INTO BUS_STOP VALUES ('CPB', 'City Pulse Bus Stand');
INSERT INTO BUS_STOP VALUES ('MCH', 'M Cure Hospital, KH Road');
INSERT INTO BUS_STOP VALUES ('DMM', 'D-Mart Mall, Sector 26');
INSERT INTO BUS_STOP VALUES ('S17', 'Sector 17 Bus Stand');
INSERT INTO BUS_STOP VALUES ('ITV', 'IIITV, GEC, Sector 28');

INSERT INTO BUS_STAND VALUES ('SMB', FALSE, 10);
INSERT INTO BUS_STAND VALUES ('PTA', TRUE, 20);
INSERT INTO BUS_STAND VALUES ('CPB', FALSE, 10);
INSERT INTO BUS_STAND VALUES ('S17', FALSE, 10);

INSERT INTO ROUTE VALUES ('1-A');
INSERT INTO ROUTE VALUES ('1-B');
INSERT INTO ROUTE VALUES ('2-A');
INSERT INTO ROUTE VALUES ('2-B');
INSERT INTO ROUTE VALUES ('3-A');
INSERT INTO ROUTE VALUES ('3-B');
INSERT INTO ROUTE VALUES ('4-A');
INSERT INTO ROUTE VALUES ('4-B');
INSERT INTO ROUTE VALUES ('5-A');
INSERT INTO ROUTE VALUES ('5-B');
INSERT INTO ROUTE VALUES ('6-A');
INSERT INTO ROUTE VALUES ('6-B');
INSERT INTO ROUTE VALUES ('7-A');
INSERT INTO ROUTE VALUES ('7-B');
INSERT INTO ROUTE VALUES ('8-A');
INSERT INTO ROUTE VALUES ('8-B');
INSERT INTO ROUTE VALUES ('9-A');
INSERT INTO ROUTE VALUES ('9-B');
INSERT INTO ROUTE VALUES ('10-A');
INSERT INTO ROUTE VALUES ('10-B');

INSERT INTO HAS_STOP VALUES ('1-A', 1, 'PTA', 0, 0);
INSERT INTO HAS_STOP VALUES ('1-A', 2, 'GH4', 1.0, 3);
INSERT INTO HAS_STOP VALUES ('1-A', 3, 'KH3', 7.2, 14);
INSERT INTO HAS_STOP VALUES ('1-A', 4, 'GH1', 10.4, 19);
INSERT INTO HAS_STOP VALUES ('1-A', 5, 'SMB', 12.5, 22);
INSERT INTO HAS_STOP VALUES ('1-B', 5, 'PTA', 12.5, 22);
INSERT INTO HAS_STOP VALUES ('1-B', 4, 'GH4', 11.5, 19);
INSERT INTO HAS_STOP VALUES ('1-B', 3, 'KH3', 5.3, 8);
INSERT INTO HAS_STOP VALUES ('1-B', 2, 'GH1', 2.1, 3);
INSERT INTO HAS_STOP VALUES ('1-B', 1, 'SMB', 0, 0);
INSERT INTO HAS_STOP VALUES ('2-A', 1, 'PTA', 0, 0);
INSERT INTO HAS_STOP VALUES ('2-A', 2, 'S3B', 2.1, 5);
INSERT INTO HAS_STOP VALUES ('2-A', 3, 'MSC', 5.6, 12);
INSERT INTO HAS_STOP VALUES ('2-A', 4, 'SEH', 9.6, 19);
INSERT INTO HAS_STOP VALUES ('2-A', 5, 'GOH', 16.3, 32);
INSERT INTO HAS_STOP VALUES ('2-A', 6, 'S10', 27.7, 55);
INSERT INTO HAS_STOP VALUES ('2-A', 7, 'SMB', 32.4, 63);
INSERT INTO HAS_STOP VALUES ('2-B', 7, 'PTA', 32.4, 63);
INSERT INTO HAS_STOP VALUES ('2-B', 6, 'S3B', 30.3, 58);
INSERT INTO HAS_STOP VALUES ('2-B', 5, 'MSC', 26.8, 51);
INSERT INTO HAS_STOP VALUES ('2-B', 4, 'SEH', 22.8, 44);
INSERT INTO HAS_STOP VALUES ('2-B', 3, 'GOH', 16.1, 31);
INSERT INTO HAS_STOP VALUES ('2-B', 2, 'S10', 4.7, 8);
INSERT INTO HAS_STOP VALUES ('2-B', 1, 'SMB', 0, 0);
INSERT INTO HAS_STOP VALUES ('3-A', 1, 'PTA', 0, 0);
INSERT INTO HAS_STOP VALUES ('3-A', 2, 'CH6', 3.9, 8);
INSERT INTO HAS_STOP VALUES ('3-A', 3, 'GJP', 5.6, 11);
INSERT INTO HAS_STOP VALUES ('3-A', 4, 'S10', 6.7, 15);
INSERT INTO HAS_STOP VALUES ('3-A', 5, 'TAT', 8.9, 21);
INSERT INTO HAS_STOP VALUES ('3-A', 6, 'SMB', 10.1, 23);
INSERT INTO HAS_STOP VALUES ('3-B', 6, 'PTA', 10.1, 23);
INSERT INTO HAS_STOP VALUES ('3-B', 5, 'CH6', 6.2, 15);
INSERT INTO HAS_STOP VALUES ('3-B', 4, 'GJP', 4.5, 12);
INSERT INTO HAS_STOP VALUES ('3-B', 3, 'S10', 3.4, 8);
INSERT INTO HAS_STOP VALUES ('3-B', 2, 'TAT', 1.2, 2);
INSERT INTO HAS_STOP VALUES ('3-B', 1, 'SMB', 0, 0);
INSERT INTO HAS_STOP VALUES ('4-A', 1, 'CPB', 0, 0);
INSERT INTO HAS_STOP VALUES ('4-A', 2, 'GT1', 3.3, 5);
INSERT INTO HAS_STOP VALUES ('4-A', 3, 'ADT', 9.6, 14);
INSERT INTO HAS_STOP VALUES ('4-A', 4, 'S21', 11.1, 18);
INSERT INTO HAS_STOP VALUES ('4-A', 5, 'S17', 13.2, 23);
INSERT INTO HAS_STOP VALUES ('4-B', 5, 'CPB', 13.2, 23);
INSERT INTO HAS_STOP VALUES ('4-B', 4, 'GT1', 9.9, 18);
INSERT INTO HAS_STOP VALUES ('4-B', 3, 'ADT', 3.6, 9);
INSERT INTO HAS_STOP VALUES ('4-B', 2, 'S21', 2.2, 5);
INSERT INTO HAS_STOP VALUES ('4-B', 1, 'S17', 0, 0);
INSERT INTO HAS_STOP VALUES ('5-A', 1, 'S17', 0, 0);
INSERT INTO HAS_STOP VALUES ('5-A', 2, 'S19', 1.8, 4);
INSERT INTO HAS_STOP VALUES ('5-A', 3, 'ADT', 4.1, 8);
INSERT INTO HAS_STOP VALUES ('5-A', 4, 'INU', 8.7, 18);
INSERT INTO HAS_STOP VALUES ('5-A', 5, 'CH2', 10.3, 23);
INSERT INTO HAS_STOP VALUES ('5-A', 6, 'SMB', 11.6, 26);
INSERT INTO HAS_STOP VALUES ('5-B', 6, 'S17', 11.6, 26);
INSERT INTO HAS_STOP VALUES ('5-B', 5, 'S19', 9.8, 22);
INSERT INTO HAS_STOP VALUES ('5-B', 4, 'ADT', 7.5, 18);
INSERT INTO HAS_STOP VALUES ('5-B', 3, 'INU', 2.9, 8);
INSERT INTO HAS_STOP VALUES ('5-B', 2, 'CH2', 1.3, 3);
INSERT INTO HAS_STOP VALUES ('5-B', 1, 'SMB', 0, 0);
INSERT INTO HAS_STOP VALUES ('6-A', 1, 'S17', 0, 0);
INSERT INTO HAS_STOP VALUES ('6-A', 2, 'DMM', 4.3, 9);
INSERT INTO HAS_STOP VALUES ('6-A', 3, 'ITV', 6.3, 14);
INSERT INTO HAS_STOP VALUES ('6-A', 4, 'ADT', 11.1, 23);
INSERT INTO HAS_STOP VALUES ('6-A', 5, 'CH2', 16.7, 32);
INSERT INTO HAS_STOP VALUES ('6-A', 6, 'SMB', 18.4, 35);
INSERT INTO HAS_STOP VALUES ('6-B', 6, 'S17', 18.4, 35);
INSERT INTO HAS_STOP VALUES ('6-B', 5, 'DMM', 14.1, 26);
INSERT INTO HAS_STOP VALUES ('6-B', 4, 'ITV', 12.1, 21);
INSERT INTO HAS_STOP VALUES ('6-B', 3, 'ADT', 7.3, 12);
INSERT INTO HAS_STOP VALUES ('6-B', 2, 'CH2', 1.7, 3);
INSERT INTO HAS_STOP VALUES ('6-B', 1, 'SMB', 0, 0);
INSERT INTO HAS_STOP VALUES ('7-A', 1, 'SMB', 0, 0);
INSERT INTO HAS_STOP VALUES ('7-A', 2, 'KH3', 4.0, 6);
INSERT INTO HAS_STOP VALUES ('7-A', 3, 'DMM', 8.7, 17);
INSERT INTO HAS_STOP VALUES ('7-A', 4, 'ITV', 10.7, 22);
INSERT INTO HAS_STOP VALUES ('7-A', 5, 'ADT', 15.5, 31);
INSERT INTO HAS_STOP VALUES ('7-A', 6, 'S17', 19.1, 38);
INSERT INTO HAS_STOP VALUES ('7-B', 6, 'SMB', 19.1, 38);
INSERT INTO HAS_STOP VALUES ('7-B', 5, 'KH3', 15.1, 32);
INSERT INTO HAS_STOP VALUES ('7-B', 4, 'DMM', 8.4, 26);
INSERT INTO HAS_STOP VALUES ('7-B', 3, 'ITV', 10.4, 21);
INSERT INTO HAS_STOP VALUES ('7-B', 2, 'ADT', 3.6, 7);
INSERT INTO HAS_STOP VALUES ('7-B', 1, 'S17', 0, 0);
INSERT INTO HAS_STOP VALUES ('8-A', 1, 'CPB', 0, 0);
INSERT INTO HAS_STOP VALUES ('8-A', 2, 'IDC', 2.5, 3);
INSERT INTO HAS_STOP VALUES ('8-A', 3, 'ADT', 8.6, 10);
INSERT INTO HAS_STOP VALUES ('8-A', 4, 'CH3', 13.0, 17);
INSERT INTO HAS_STOP VALUES ('8-A', 5, 'GH1', 15.3, 21);
INSERT INTO HAS_STOP VALUES ('8-A', 6, 'KH3', 18.4, 26);
INSERT INTO HAS_STOP VALUES ('8-A', 7, 'DMM', 23.1, 37);
INSERT INTO HAS_STOP VALUES ('8-A', 8, 'ITV', 25.1, 42);
INSERT INTO HAS_STOP VALUES ('8-A', 9, 'GH6', 30.3, 52);
INSERT INTO HAS_STOP VALUES ('8-A', 10, 'S17', 32.0, 55);
INSERT INTO HAS_STOP VALUES ('8-B', 10, 'CPB', 32.0, 55);
INSERT INTO HAS_STOP VALUES ('8-B', 9, 'IDC', 29.5, 52);
INSERT INTO HAS_STOP VALUES ('8-B', 8, 'ADT', 23.4, 45);
INSERT INTO HAS_STOP VALUES ('8-B', 7, 'CH3', 19.0, 38);
INSERT INTO HAS_STOP VALUES ('8-B', 6, 'GH1', 16.7, 34);
INSERT INTO HAS_STOP VALUES ('8-B', 5, 'KH3', 13.6, 29);
INSERT INTO HAS_STOP VALUES ('8-B', 4, 'DMM', 8.9, 18);
INSERT INTO HAS_STOP VALUES ('8-B', 3, 'ITV', 6.9, 13);
INSERT INTO HAS_STOP VALUES ('8-B', 2, 'GH6', 1.7, 3);
INSERT INTO HAS_STOP VALUES ('8-B', 1, 'S17', 0, 0);
INSERT INTO HAS_STOP VALUES ('9-A', 1, 'CPB', 0, 0);
INSERT INTO HAS_STOP VALUES ('9-A', 2, 'IDC', 2.5, 3);
INSERT INTO HAS_STOP VALUES ('9-A', 3, 'ADT', 8.6, 10);
INSERT INTO HAS_STOP VALUES ('9-A', 4, 'ITV', 13.8, 20);
INSERT INTO HAS_STOP VALUES ('9-A', 5, 'DMM', 15.8, 25);
INSERT INTO HAS_STOP VALUES ('9-A', 6, 'KH3', 20.5, 36);
INSERT INTO HAS_STOP VALUES ('9-A', 7, 'CH3', 23.1, 41);
INSERT INTO HAS_STOP VALUES ('9-A', 8, 'S17', 26.6, 46);
INSERT INTO HAS_STOP VALUES ('9-B', 8, 'CPB', 26.6, 46);
INSERT INTO HAS_STOP VALUES ('9-B', 7, 'IDC', 24.1, 43);
INSERT INTO HAS_STOP VALUES ('9-B', 6, 'ADT', 18.0, 36);
INSERT INTO HAS_STOP VALUES ('9-B', 5, 'ITV', 12.8, 26);
INSERT INTO HAS_STOP VALUES ('9-B', 4, 'DMM', 10.8, 21);
INSERT INTO HAS_STOP VALUES ('9-B', 3, 'KH3', 6.1, 10);
INSERT INTO HAS_STOP VALUES ('9-B', 2, 'CH3', 3.5, 5);
INSERT INTO HAS_STOP VALUES ('9-B', 1, 'S17', 0, 0);
INSERT INTO HAS_STOP VALUES ('10-A', 1, 'CPB', 0, 0);
INSERT INTO HAS_STOP VALUES ('10-A', 2, 'PTM', 0.5, 2);
INSERT INTO HAS_STOP VALUES ('10-A', 3, 'MCH', 4.5, 9);
INSERT INTO HAS_STOP VALUES ('10-A', 4, 'GH0', 6.9, 13);
INSERT INTO HAS_STOP VALUES ('10-A', 5, 'GT1', 8.7, 17);
INSERT INTO HAS_STOP VALUES ('10-A', 6, 'GH4', 12.5, 25);
INSERT INTO HAS_STOP VALUES ('10-A', 7, 'S17', 14.2, 28);
INSERT INTO HAS_STOP VALUES ('10-B', 7, 'CPB', 14.2, 28);
INSERT INTO HAS_STOP VALUES ('10-B', 6, 'PTM', 13.7, 26);
INSERT INTO HAS_STOP VALUES ('10-B', 5, 'MCH', 9.7, 19);
INSERT INTO HAS_STOP VALUES ('10-B', 4, 'GH0', 7.3, 15);
INSERT INTO HAS_STOP VALUES ('10-B', 3, 'GT1', 5.5, 9);
INSERT INTO HAS_STOP VALUES ('10-B', 2, 'GH4', 1.7, 3);
INSERT INTO HAS_STOP VALUES ('10-B', 1, 'S17', 0, 0);

INSERT INTO Department VALUES ('1','Accounts','50101');
INSERT INTO Department VALUES ('2','Cleaning','50201');
INSERT INTO Department VALUES ('3','Enquiry','50301');
INSERT INTO Department VALUES ('4','Transport','50401');
INSERT INTO Department VALUES ('5','Management','50102');

INSERT INTO Employee_Type VALUES ('101','Clerk','1');
INSERT INTO Employee_Type VALUES ('102','Accountant','1');
INSERT INTO Employee_Type VALUES ('201','Bus_cleaner','2');
INSERT INTO Employee_Type VALUES ('202','Sweeper','2');
INSERT INTO Employee_Type VALUES ('301','Enquiry_operator','3');
INSERT INTO Employee_Type VALUES ('302','Messenger','3');
INSERT INTO Employee_Type VALUES ('401','Bus_driver','4');
INSERT INTO Employee_Type VALUES ('402','Conductor','4');
INSERT INTO Employee_Type VALUES ('403','Chief_Engineer','4');
INSERT INTO Employee_Type VALUES ('404','Mechanic','4');
INSERT INTO Employee_Type VALUES ('501','Station_master','5');  
INSERT INTO Employee_Type VALUES ('502','Cleaning_Supervisor','5');    
INSERT INTO Employee_Type VALUES ('503','Enquiry_Supervisor','5'); 
INSERT INTO Employee_Type VALUES ('504','Transport_Supervisor','5');
INSERT INTO Employee_Type VALUES ('505','Peon','2');

INSERT INTO Employee VALUES ('10101','Joy sinng','101','sector-21','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('10102','Roy Smith','101','sector-22','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('10201','Dany Lana','102','sector-11','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('10202','Riya Sharma','102','sector-1','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('10203','Priya Gupta','102','sector-14','Gandhinagar','382010','CPB');
INSERT INTO Employee VALUES ('10204','Kamal Kumar','102','sector-4','Gandhinagar','382010','S17');
INSERT INTO Employee VALUES ('20101','Harry Patidar','201','sector-11','Gandhinagar','382010');
INSERT INTO Employee VALUES ('20102','Joss Roy','201','sector-7','Gandhinagar','382010');
INSERT INTO Employee VALUES ('20103','Sigi Mathu','201','sector-11','Gandhinagar','382010');
INSERT INTO Employee VALUES ('20201','Dany Cook','202','sector-5','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('20202','Marsh Shon','202','sector-4','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('30101','Rachit','301','sector-6','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('30102','Mayank Padhi','301','sector-14','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('30201','Ram Lakhan','302','sector-8','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('30202','Keary Jat','302','sector-21','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('40101','Naresh Mohan','401','sector-1','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40102','Mahesh Puri','401','sector-17','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40103','Anas Gori','401','sector-9','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40104','Mradul Soni','401','sector-23','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40105','Lakhan Patidar','401','sector-24','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40106','Shivam Roy','401','sector-11','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40107','Pankaj Jha','401','sector-22','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40108','Karan sing','401','sector-26','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40109','Mohit Tomar','401','sector-25','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40110','Piyush Beniwal','401','sector-4','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40111','Praneet Dhurve','401','sector-4','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40112','Prashant Ladda','401','sector-12','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40113','Shubham Verma','401','sector-1','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40114','Deepak Verma','401','sector-21','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40115','Manee Kongla','401','sector-28','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40116','Mayank Pandey','401','sector-5','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40117','Saurabh Shrivastva','401','sector-8','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40118','Sourabh Yadav','401','sector-10','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40119','Kapil Dev','401','sector-11','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40120','Bittu Sharma','401','sector-12','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40121','Maneesh Kulshresth','401','sector-18','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40122','Akaash Chandra','401','sector-20','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40123','Prabhu Yadav','401','sector-22','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40124','Harsh Jain','401','sector-24','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40125','Yash Kumar','401','sector-11','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40201','Mudit Vyas','402','sector-5','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40202','Suresh Prabhu','402','sector-4','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40203','Alis Cooper','402','sector-16','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40204','Ravi Jha','402','sector-1','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40205','Ajay Rathi','402','sector-17','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40206','Vijay Tank','402','sector-16','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40207','Pankaj soni','402','sector-23','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40208','Rohan Mathur','402','sector-4','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40209','Piyush Kala','402','sector-14','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40210','Ome yadav','402','sector-15','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40211','Umesh Yadav','402','sector-27','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40212','Prakhar Bahadur','402','sector-12','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40213','Shashi lal','402','sector-23','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40214','Kamal Nath','402','sector-13','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40215','Ajay Kishore','402','sector-14','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40216','Jitendra Sinha','402','sector-2','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40217','Ramlal Sahai','402','sector-6','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40218','Mukesh Babu','402','sector-15','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40219','Shipranshu Sharma','402','sector-18','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40220','Gaurav Singh','402','sector-20','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40221','Ajay Rathi','402','sector-29','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40222','Shekhar yadav','402','sector-11','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40223','Shree yadav','402','sector-16','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40224','Aalok Jain','402','sector-12','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40225','Deepa Maravi','402','sector-17','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40226','Manisha Sharma','402','sector-25','Gandhinagar','382010');
INSERT INTO Employee VALUES ('40301','Ankur Sharma','403','sector-7','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('40302','Zahid Khan','403','sector-8','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('40303','Aman Dhawal','403','sector-24','Gandhinagar','382010','CPB');
INSERT INTO Employee VALUES ('40304','Sahil Lada','403','sector-2','Gandhinagar','382010','S17');
INSERT INTO Employee VALUES ('40401','Vikram Patel','404','sector-3','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('40402','Yamini Khanna','404','sector-9','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('40403','Mehul Seni','404','sector-13','Gandhinagar','382010','CPB');
INSERT INTO Employee VALUES ('40404','Nikunj Lana','404','sector-12','Gandhinagar','382010','S17');
INSERT INTO Employee VALUES ('40405','Nikil Sing','404','sector-5','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('40406','Jay chobe','404','sector-9','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('40407','Kushal Rohit','404','sector-8','Gandhinagar','382010','CPB');
INSERT INTO Employee VALUES ('40408','Fezal Pathan','404','sector-19','Gandhinagar','382010','S17');
INSERT INTO Employee VALUES ('50101','Sunny Prakash','501','sector-21','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('50102','Diraj Ambani','501','sector-12','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('50103','Deepak Solanki','501','sector-16','Gandhinagar','382010','CPB');
INSERT INTO Employee VALUES ('50104','Lalit Dhangar','501','sector-19','Gandhinagar','382010','S17');
INSERT INTO Employee VALUES ('50201','Aswin Gore','502','sector-3','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('50501','Ayush Joshi','505','sector-28','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('50502','Anil Rana','505','sector-27','Gandhinagar','382010','SMB');
INSERT INTO Employee VALUES ('50503','Ahem Guju','505','sector-23','Gandhinagar','382010','CPB');
INSERT INTO Employee VALUES ('50301','Kunal Sing','503','sector-12','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('50504','Umed Khan','505','sector-13','Gandhinagar','382010','S17');
INSERT INTO Employee VALUES ('50505','Vinod Khanna ','505','sector-27','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('50401','Binni Goyal','504','sector-25','Gandhinagar','382010','PTA');
INSERT INTO Employee VALUES ('50506','Hemanshu Patel','505','sector-3','Gandhinagar','382010','SMB');

ALTER TABLE DEPARTMENT
ADD FOREIGN KEY (Manager_id) REFERENCES Employee(E_Id);

INSERT INTO Contacts VALUES ('10101','9206897513'); 
INSERT INTO Contacts VALUES ('10101','8366040610');
INSERT INTO Contacts VALUES ('10101','9363978089'); 
INSERT INTO Contacts VALUES ('10102','7804735012'); 
INSERT INTO Contacts VALUES ('10102','9314238862');
INSERT INTO Contacts VALUES ('10201','8352255505'); 
INSERT INTO Contacts VALUES ('10202','9747666917'); 
INSERT INTO Contacts VALUES ('10202','9540178460'); 
INSERT INTO Contacts VALUES ('10203','8575680754');
INSERT INTO Contacts VALUES ('10203','7793218144');
INSERT INTO Contacts VALUES ('10204','9848350097'); 
INSERT INTO Contacts VALUES ('20101','8821394739'); 
INSERT INTO Contacts VALUES ('20101','9359764755'); 
INSERT INTO Contacts VALUES ('20102','9245870862'); 
INSERT INTO Contacts VALUES ('20103','9597618373'); 
INSERT INTO Contacts VALUES ('20103','8289587357');
INSERT INTO Contacts VALUES ('20201','7279967223'); 
INSERT INTO Contacts VALUES ('20201','9692342973'); 
INSERT INTO Contacts VALUES ('20202','8465453370'); 
INSERT INTO Contacts VALUES ('30101','9334649074'); 
INSERT INTO Contacts VALUES ('30101','7656771503'); 
INSERT INTO Contacts VALUES ('30102','9284279533');
INSERT INTO Contacts VALUES ('30102','8341982897');
INSERT INTO Contacts VALUES ('40102','7472121143'); 
INSERT INTO Contacts VALUES ('40102','9487135667'); 
INSERT INTO Contacts VALUES ('40101','8422632980'); 
INSERT INTO Contacts VALUES ('40101','9738677960'); 
INSERT INTO Contacts VALUES ('40103','7345248343'); 
INSERT INTO Contacts VALUES ('40103','9843194939'); 
INSERT INTO Contacts VALUES ('40104','8362998124'); 
INSERT INTO Contacts VALUES ('40105','7868812499'); 
INSERT INTO Contacts VALUES ('40105','9313434180'); 
INSERT INTO Contacts VALUES ('40106','8735385828'); 
INSERT INTO Contacts VALUES ('40107','9362398892'); 
INSERT INTO Contacts VALUES ('40107','7376852045'); 
INSERT INTO Contacts VALUES ('40110','9644090152'); 
INSERT INTO Contacts VALUES ('40108','8821071969');
INSERT INTO Contacts VALUES ('40109','7758499222'); 
INSERT INTO Contacts VALUES ('40110','9856250417'); 
INSERT INTO Contacts VALUES ('40202','8720685609'); 
INSERT INTO Contacts VALUES ('40201','9438167499'); 
INSERT INTO Contacts VALUES ('40203','7472025413'); 
INSERT INTO Contacts VALUES ('40204','9374875635'); 
INSERT INTO Contacts VALUES ('40205','8572182805'); 
INSERT INTO Contacts VALUES ('40205','7474069129'); 
INSERT INTO Contacts VALUES ('40206','9514847281'); 
INSERT INTO Contacts VALUES ('40207','8204191880'); 
INSERT INTO Contacts VALUES ('40208','9789444209'); 
INSERT INTO Contacts VALUES ('40209','7372327759'); 
INSERT INTO Contacts VALUES ('40210','9233612133'); 
INSERT INTO Contacts VALUES ('40210','8560443107');
INSERT INTO Contacts VALUES ('40301','7683622189'); 
INSERT INTO Contacts VALUES ('40302','9226648131'); 
INSERT INTO Contacts VALUES ('40302','8308401308'); 
INSERT INTO Contacts VALUES ('40303','9954436637');
INSERT INTO Contacts VALUES ('40304','8613342144');
INSERT INTO Contacts VALUES ('40304','9772537269');
INSERT INTO Contacts VALUES ('40401','8526611830'); 
INSERT INTO Contacts VALUES ('40402','7769274783'); 
INSERT INTO Contacts VALUES ('40402','9455814513'); 
INSERT INTO Contacts VALUES ('40402','8678219836'); 
INSERT INTO Contacts VALUES ('40403','9277917399'); 
INSERT INTO Contacts VALUES ('40403','8181476659'); 
INSERT INTO Contacts VALUES ('40404','9209764383');  
INSERT INTO Contacts VALUES ('40404','8551480326'); 
INSERT INTO Contacts VALUES ('40405','7389421996'); 
INSERT INTO Contacts VALUES ('40405','9438207388'); 
INSERT INTO Contacts VALUES ('40406','8688433425'); 
INSERT INTO Contacts VALUES ('40407','9880083428'); 
INSERT INTO Contacts VALUES ('40407','8620294218'); 
INSERT INTO Contacts VALUES ('40408','9460724391'); 
INSERT INTO Contacts VALUES ('50101','8418750602');
INSERT INTO Contacts VALUES ('50101','7528710182'); 
INSERT INTO Contacts VALUES ('50102','9214143777'); 
INSERT INTO Contacts VALUES ('50103','8580564420'); 
INSERT INTO Contacts VALUES ('50103','9820274429'); 
INSERT INTO Contacts VALUES ('50104','8446834869'); 
INSERT INTO Contacts VALUES ('50201','9762913683'); 
INSERT INTO Contacts VALUES ('50201','8704447821'); 
INSERT INTO Contacts VALUES ('50501','8864348904'); 
INSERT INTO Contacts VALUES ('50201','7687657621'); 
INSERT INTO Contacts VALUES ('50201','9613620477'); 
INSERT INTO Contacts VALUES ('50301','8880447738'); 
INSERT INTO Contacts VALUES ('50301','9601336380'); 
INSERT INTO Contacts VALUES ('50401','8557842176'); 
INSERT INTO Contacts VALUES ('50401','9571271422'); 
INSERT INTO Contacts VALUES ('50501','8708600207'); 
INSERT INTO Contacts VALUES ('50502','7759026399'); 
INSERT INTO Contacts VALUES ('50503','9731824119'); 
INSERT INTO Contacts VALUES ('50504','8486065510'); 
INSERT INTO Contacts VALUES ('50505','9810982384');

INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (1,'PTA');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (2,'PTA');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (3,'PTA');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (4,'PTA');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (5,'PTA');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (1,'SMB');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (2,'SMB');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (3,'SMB');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (4,'SMB');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (1,'CPB');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (2,'CPB');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (3,'CPB');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (4,'CPB');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (1,'S17');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (2,'S17');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (3,'S17');
INSERT INTO DEPARTMENTS_IN_BUS_STAND VALUES (4,'S17');

INSERT INTO Bus_Type VALUES ('General',5,44,2);
INSERT INTO Bus_Type VALUES ('AC',15,36,4);

INSERT INTO Pass_Type VALUES ('Weekly');
INSERT INTO Pass_Type VALUES ('Monthly');
INSERT INTO Pass_Type VALUES ('HalfYearly');
INSERT INTO Pass_Type VALUES ('Yearly');

INSERT INTO Bus Values (1,'GJ18CW6723','General',1240);
INSERT INTO Bus Values (2,'GJ18CW1736','General',3240);
INSERT INTO Bus Values (3,'GJ18CW9436','General',1020);
INSERT INTO Bus Values (4,'GJ18CW8344','General',1320);
INSERT INTO Bus Values (5,'GJ18CW8923','General',1190);
INSERT INTO Bus Values (6,'GJ18CW2389','General',1840);
INSERT INTO Bus Values (7,'GJ18CW6479','General',1910);
INSERT INTO Bus Values (8,'GJ18CW2378','General',3200);
INSERT INTO Bus Values (9,'GJ18CW5847','General',1920);
INSERT INTO Bus Values (10,'GJ18CW7492','General',1420);
INSERT INTO Bus Values (11,'GJ18CW7243','General',1250);
INSERT INTO Bus Values (12,'GJ18CW2894','General',3250);
INSERT INTO Bus Values (13,'GJ18CW9423','General',1000);
INSERT INTO Bus Values (14,'GJ18CW2879','General',1310);
INSERT INTO Bus Values (15,'GJ18CW4532','General',1200);
INSERT INTO Bus Values (16,'GJ18CW9502','General',1850);
INSERT INTO Bus Values (17,'GJ18CW9243','General',1900);
INSERT INTO Bus Values (18,'GJ18CW9356','General',3150);
INSERT INTO Bus Values (19,'GJ18CW8256','General',1940);
INSERT INTO Bus Values (20,'GJ18CW7887','General',1400);
INSERT INTO Bus Values (21,'GJ18CW9012','AC',2480);
INSERT INTO Bus Values (22,'GJ18CW9292','AC',2640);
INSERT INTO Bus Values (23,'GJ18CW9876','AC',2380);
INSERT INTO Bus Values (24,'GJ18CW9978','AC',3820);
INSERT INTO Bus Values (25,'GJ18CW9998','AC',2840);

INSERT INTO Sold_Passes VALUES ('General','Weekly','1-A',130,2);
INSERT INTO Sold_Passes VALUES ('General','Weekly','2-A',340,1);
INSERT INTO Sold_Passes VALUES ('General','Weekly','3-A',105,0);
INSERT INTO Sold_Passes VALUES ('General','Weekly','4-A',135,3);
INSERT INTO Sold_Passes VALUES ('General','Weekly','5-A',125,2);
INSERT INTO Sold_Passes VALUES ('General','Weekly','6-A',190,1);
INSERT INTO Sold_Passes VALUES ('General','Weekly','7-A',200,4);
INSERT INTO Sold_Passes VALUES ('General','Weekly','8-A',330,3);
INSERT INTO Sold_Passes VALUES ('General','Weekly','9-A',200,2);
INSERT INTO Sold_Passes VALUES ('General','Weekly','10-A',150,0);
INSERT INTO Sold_Passes VALUES ('General','Monthly','1-A',550,1);
INSERT INTO Sold_Passes VALUES ('General','Monthly','2-A',1450,1);
INSERT INTO Sold_Passes VALUES ('General','Monthly','3-A',460,1);
INSERT INTO Sold_Passes VALUES ('General','Monthly','4-A',590,2);
INSERT INTO Sold_Passes VALUES ('General','Monthly','5-A',535,3);
INSERT INTO Sold_Passes VALUES ('General','Monthly','6-A',820,2);
INSERT INTO Sold_Passes VALUES ('General','Monthly','7-A',860,3);
INSERT INTO Sold_Passes VALUES ('General','Monthly','8-A',1440,2);
INSERT INTO Sold_Passes VALUES ('General','Monthly','9-A',860,3);
INSERT INTO Sold_Passes VALUES ('General','Monthly','10-A',640,0);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','1-A',2700,3);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','2-A',7000,0);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','3-A',2200,0);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','4-A',2800,2);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','5-A',2600,2);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','6-A',3900,1);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','7-A',4100,1);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','8-A',6880,3);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','9-A',4100,2);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','10-A',3050,0);
INSERT INTO Sold_Passes VALUES ('General','Yearly','1-A',4450,3);
INSERT INTO Sold_Passes VALUES ('General','Yearly','2-A',11650,0);
INSERT INTO Sold_Passes VALUES ('General','Yearly','3-A',3650,1);
INSERT INTO Sold_Passes VALUES ('General','Yearly','4-A',4750,3);
INSERT INTO Sold_Passes VALUES ('General','Yearly','5-A',4300,1);
INSERT INTO Sold_Passes VALUES ('General','Yearly','6-A',6600,1);
INSERT INTO Sold_Passes VALUES ('General','Yearly','7-A',6850,2);
INSERT INTO Sold_Passes VALUES ('General','Yearly','8-A',11500,3);
INSERT INTO Sold_Passes VALUES ('General','Yearly','9-A',6900,0);
INSERT INTO Sold_Passes VALUES ('General','Yearly','10-A',5100,1);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','1-A',260,4);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','2-A',680,2);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','3-A',210,0);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','4-A',270,4);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','5-A',250,3);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','6-A',380,2);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','7-A',400,1);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','8-A',660,4);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','9-A',400,0);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','10-A',300,1);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','1-A',1100,5);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','2-A',2900,2);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','3-A',920,0);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','4-A',1180,1);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','5-A',1070,3);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','6-A',1640,0);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','7-A',1720,2);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','8-A',2880,2);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','9-A',1720,1);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','10-A',1280,2);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','1-A',5400,3);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','2-A',14000,1);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','3-A',4400,0);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','4-A',5600,3);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','5-A',5200,4);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','6-A',7800,1);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','7-A',8200,0);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','8-A',13760,2);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','9-A',8200,0);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','10-A',6100,1);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','1-A',9900,3);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','2-A',23300,2);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','3-A',7300,0);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','4-A',9500,3);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','5-A',8600,2);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','6-A',13200,1);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','7-A',13700,3);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','8-A',23000,2);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','9-A',13800,0);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','10-A',10200,2);
INSERT INTO Sold_Passes VALUES ('General','Weekly','1-B',130,2);
INSERT INTO Sold_Passes VALUES ('General','Weekly','2-B',340,1);
INSERT INTO Sold_Passes VALUES ('General','Weekly','3-B',105,0);
INSERT INTO Sold_Passes VALUES ('General','Weekly','4-B',135,3);
INSERT INTO Sold_Passes VALUES ('General','Weekly','5-B',125,2);
INSERT INTO Sold_Passes VALUES ('General','Weekly','6-B',190,1);
INSERT INTO Sold_Passes VALUES ('General','Weekly','7-B',200,4);
INSERT INTO Sold_Passes VALUES ('General','Weekly','8-B',330,3);
INSERT INTO Sold_Passes VALUES ('General','Weekly','9-B',200,2);
INSERT INTO Sold_Passes VALUES ('General','Weekly','10-B',150,0);
INSERT INTO Sold_Passes VALUES ('General','Monthly','1-B',550,1);
INSERT INTO Sold_Passes VALUES ('General','Monthly','2-B',1450,1);
INSERT INTO Sold_Passes VALUES ('General','Monthly','3-B',460,1);
INSERT INTO Sold_Passes VALUES ('General','Monthly','4-B',590,2);
INSERT INTO Sold_Passes VALUES ('General','Monthly','5-B',535,3);
INSERT INTO Sold_Passes VALUES ('General','Monthly','6-B',820,2);
INSERT INTO Sold_Passes VALUES ('General','Monthly','7-B',860,3);
INSERT INTO Sold_Passes VALUES ('General','Monthly','8-B',1440,2);
INSERT INTO Sold_Passes VALUES ('General','Monthly','9-B',860,3);
INSERT INTO Sold_Passes VALUES ('General','Monthly','10-B',640,0);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','1-B',2700,3);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','2-B',7000,0);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','3-B',2200,0);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','4-B',2800,2);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','5-B',2600,2);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','6-B',3900,1);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','7-B',4100,1);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','8-B',6880,3);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','9-B',4100,2);
INSERT INTO Sold_Passes VALUES ('General','HalfYearly','10-B',3050,0);
INSERT INTO Sold_Passes VALUES ('General','Yearly','1-B',4450,3);
INSERT INTO Sold_Passes VALUES ('General','Yearly','2-B',11650,0);
INSERT INTO Sold_Passes VALUES ('General','Yearly','3-B',3650,1);
INSERT INTO Sold_Passes VALUES ('General','Yearly','4-B',4750,3);
INSERT INTO Sold_Passes VALUES ('General','Yearly','5-B',4300,4);
INSERT INTO Sold_Passes VALUES ('General','Yearly','6-B',6600,1);
INSERT INTO Sold_Passes VALUES ('General','Yearly','7-B',6850,2);
INSERT INTO Sold_Passes VALUES ('General','Yearly','8-B',11500,3);
INSERT INTO Sold_Passes VALUES ('General','Yearly','9-B',6900,0);
INSERT INTO Sold_Passes VALUES ('General','Yearly','10-B',5100,1);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','1-B',260,4);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','2-B',680,2);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','3-B',210,0);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','4-B',270,4);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','5-B',250,3);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','6-B',380,2);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','7-B',400,1);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','8-B',660,4);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','9-B',400,0);
INSERT INTO Sold_Passes VALUES ('AC','Weekly','10-B',300,1);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','1-B',1100,5);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','2-B',2900,2);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','3-B',920,0);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','4-B',1180,1);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','5-B',1070,3);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','6-B',1640,0);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','7-B',1720,2);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','8-B',2880,2);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','9-B',1720,1);
INSERT INTO Sold_Passes VALUES ('AC','Monthly','10-B',1280,2);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','1-B',5400,3);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','2-B',14000,1);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','3-B',4400,0);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','4-B',5600,3);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','5-B',5200,4);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','6-B',7800,1);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','7-B',8200,0);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','8-B',13760,2);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','9-B',8200,0);
INSERT INTO Sold_Passes VALUES ('AC','HalfYearly','10-B',6100,1);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','1-B',9900,3);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','2-B',23300,2);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','3-B',7300,0);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','4-B',9500,3);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','5-B',8600,2);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','6-B',13200,1);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','7-B',13700,3);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','8-B',23000,2);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','9-B',13800,0);
INSERT INTO Sold_Passes VALUES ('AC','Yearly','10-B',10200,2);

INSERT INTO Has_Route VALUES (1,'1-A','08:00:00');
INSERT INTO Has_Route VALUES (1,'1-B','17:30:00');
INSERT INTO Has_Route VALUES (2,'2-A','08:30:00');
INSERT INTO Has_Route VALUES (2,'2-B','17:25:00');
INSERT INTO Has_Route VALUES (3,'3-A','09:00:00');
INSERT INTO Has_Route VALUES (3,'3-B','16:00:00');
INSERT INTO Has_Route VALUES (4,'4-A','08:15:00');
INSERT INTO Has_Route VALUES (4,'4-B','17:15:00');
INSERT INTO Has_Route VALUES (5,'5-A','07:45:00');
INSERT INTO Has_Route VALUES (5,'5-B','18:45:00');
INSERT INTO Has_Route VALUES (6,'6-A','07:00:00');
INSERT INTO Has_Route VALUES (6,'6-B','16:30:00');
INSERT INTO Has_Route VALUES (7,'7-A','07:30:00');
INSERT INTO Has_Route VALUES (7,'7-B','18:00:00');
INSERT INTO Has_Route VALUES (8,'8-A','08:00:00');
INSERT INTO Has_Route VALUES (8,'8-B','17:45:00');
INSERT INTO Has_Route VALUES (9,'9-A','09:00:00');
INSERT INTO Has_Route VALUES (9,'9-B','19:00:00');
INSERT INTO Has_Route VALUES (10,'10-A','07:15:00');
INSERT INTO Has_Route VALUES (10,'10-B','16:00:00');
INSERT INTO Has_Route VALUES (11,'1-A','11:00:00');
INSERT INTO Has_Route VALUES (11,'1-B','20:00:00');
INSERT INTO Has_Route VALUES (12,'2-A','11:30:00');
INSERT INTO Has_Route VALUES (12,'2-B','20:45:00');
INSERT INTO Has_Route VALUES (13,'3-A','10:30:00');
INSERT INTO Has_Route VALUES (13,'3-B','20:30:00');
INSERT INTO Has_Route VALUES (14,'4-A','11:15:00');
INSERT INTO Has_Route VALUES (14,'4-B','21:00:00');
INSERT INTO Has_Route VALUES (15,'5-A','10:45:00');
INSERT INTO Has_Route VALUES (15,'5-B','19:45:00');
INSERT INTO Has_Route VALUES (16,'6-A','10:30:00');
INSERT INTO Has_Route VALUES (16,'6-B','20:20:00');
INSERT INTO Has_Route VALUES (17,'7-A','11:30:00');
INSERT INTO Has_Route VALUES (17,'7-B','21:00:00');
INSERT INTO Has_Route VALUES (18,'8-A','11:00:00');
INSERT INTO Has_Route VALUES (18,'8-B','21:30:00');
INSERT INTO Has_Route VALUES (19,'9-A','10:30:00');
INSERT INTO Has_Route VALUES (19,'9-B','19:30:00');
INSERT INTO Has_Route VALUES (20,'10-A','11:45:00');
INSERT INTO Has_Route VALUES (20,'10-B','21:00:00');
INSERT INTO Has_Route VALUES (21,'1-A','14:00:00');
INSERT INTO Has_Route VALUES (21,'1-B','22:00:00');
INSERT INTO Has_Route VALUES (22,'4-A','13:30:00');
INSERT INTO Has_Route VALUES (22,'4-B','21:30:00');
INSERT INTO Has_Route VALUES (23,'5-A','13:00:00');
INSERT INTO Has_Route VALUES (23,'5-B','21:00:00');
INSERT INTO Has_Route VALUES (24,'7-A','13:45:00');
INSERT INTO Has_Route VALUES (24,'7-B','22:00:00');
INSERT INTO Has_Route VALUES (25,'10-A','14:00:00');
INSERT INTO Has_Route VALUES (25,'10-B','19:30:00');

INSERT INTO Working_for VALUES (40113, 1);
INSERT INTO Working_for VALUES (40119, 2);
INSERT INTO Working_for VALUES (40107, 3);
INSERT INTO Working_for VALUES (40118, 4);
INSERT INTO Working_for VALUES (40112, 5);
INSERT INTO Working_for VALUES (40120, 6);
INSERT INTO Working_for VALUES (40106, 7);
INSERT INTO Working_for VALUES (40117, 8);
INSERT INTO Working_for VALUES (40121, 9);
INSERT INTO Working_for VALUES (40111, 10);
INSERT INTO Working_for VALUES (40104, 11);
INSERT INTO Working_for VALUES (40108, 12);
INSERT INTO Working_for VALUES (40122, 13);
INSERT INTO Working_for VALUES (40123, 14);
INSERT INTO Working_for VALUES (40103, 15);
INSERT INTO Working_for VALUES (40114, 16);
INSERT INTO Working_for VALUES (40124, 17);
INSERT INTO Working_for VALUES (40115, 18);
INSERT INTO Working_for VALUES (40102, 19);
INSERT INTO Working_for VALUES (40110, 20);
INSERT INTO Working_for VALUES (40116, 21);
INSERT INTO Working_for VALUES (40125, 22);
INSERT INTO Working_for VALUES (40109, 23);
INSERT INTO Working_for VALUES (40105, 24);
INSERT INTO Working_for VALUES (40101, 25);
INSERT INTO Working_for VALUES (40213, 1);
INSERT INTO Working_for VALUES (40219, 2);
INSERT INTO Working_for VALUES (40207, 3);
INSERT INTO Working_for VALUES (40218, 4);
INSERT INTO Working_for VALUES (40212, 5);
INSERT INTO Working_for VALUES (40220, 6);
INSERT INTO Working_for VALUES (40206, 7);
INSERT INTO Working_for VALUES (40217, 8);
INSERT INTO Working_for VALUES (40221, 9);
INSERT INTO Working_for VALUES (40211, 10);
INSERT INTO Working_for VALUES (40204, 11);
INSERT INTO Working_for VALUES (40208, 12);
INSERT INTO Working_for VALUES (40222, 13);
INSERT INTO Working_for VALUES (40223, 14);
INSERT INTO Working_for VALUES (40203, 15);
INSERT INTO Working_for VALUES (40214, 16);
INSERT INTO Working_for VALUES (40224, 17);
INSERT INTO Working_for VALUES (40215, 18);
INSERT INTO Working_for VALUES (40202, 19);
INSERT INTO Working_for VALUES (40210, 20);
INSERT INTO Working_for VALUES (40216, 21);
INSERT INTO Working_for VALUES (40225, 22);
INSERT INTO Working_for VALUES (40209, 23);
INSERT INTO Working_for VALUES (40205, 24);
INSERT INTO Working_for VALUES (40201, 25);