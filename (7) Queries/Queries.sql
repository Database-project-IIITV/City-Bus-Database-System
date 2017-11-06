
--1 Find the bus type and pass type which has maximum pass cost?

	SELECT BUS_TYPE, PASS_TYPE, MAX(PASS_COST) FROM SOLD_PASSES GROUP BY BUS_TYPE, PASS_TYPE ORDER BY BUS_TYPE, PASS_TYPE;

--2 Give bus type, pass type, route no and pass cost for which total no. of passes soid  for each posible paire of value of bus type and pass type?

	SELECT BUS_TYPE, PASS_TYPE, SUM(PASSES_SOLD) FROM SOLD_PASSES GROUP BY BUS_TYPE, PASS_TYPE ORDER BY BUS_TYPE, PASS_TYPE;


--3 Give the route no. for each posible paire of value of bus type and pass type who's pass cost is min.?

	select sold_passes.bus_type, sold_passes.pass_type,sold_passes.route_no, sold_passes.pass_cost from sold_passes INNER JOIN 
	(SELECT bus_type, pass_type, min(pass_cost) as min_pass FROM sold_passes GROUP BY BUS_TYPE, PASS_TYPE) as tb1 
	ON(sold_passes.bus_type=tb1.bus_type and sold_passes.pass_type=tb1.pass_type)
	WHERE sold_passes.pass_cost= tb1.min_pass;

--4 Find the average cost of an pass for each pass type and bus_type?

	SELECT BUS_TYPE, PASS_TYPE, AVG(PASS_COST) FROM SOLD_PASSES GROUP BY BUS_TYPE, PASS_TYPE ORDER BY BUS_TYPE, PASS_TYPE;

--5	Find the routes which have all type of buses?

	select route_no from (select route_no , count(bus_type) from (select distinct route_no , bus_type from(has_route natural  join bus) as q1)
	as q2  group by route_no) as q5
	natural join (select count(Type_name)  from bus_type) q4

--6 Find the all paire of bus_type and pass_ type for route no. "10-A"?

	SELECT BUS_TYPE,PASS_TYPE,ROUTE_NO FROM SOLD_PASSES WHERE ROUTE_NO='10-A';

--7 Give the department wise count of no. of employee for each stand?

	Select stop_name, d_name, count(e_id) from (((Employee as e join employee_type as et on(e.e_type=et.type_no)) as q1 
	natural join
	(Employee as e join bus_stand as bs on(e.working_in_bus_stand=bs.stop_code)) as q2) as q3 
	natural join
	Bus_Stop bs_st) q4 
	natural join
	department dp group by d_name,stop_name order by stop_name

--8 Give the details of drivers of bus whose dailycollection  highest?

	select * from((((select max(daily_collection)  from bus) as dc join bus on(dc.max=bus.daily_collection)) as q1 natural join working_for) as q2
	natural join employee ) as q3 
	join employee_type as et on(q3.e_type=et.type_no) where et.type_name='Bus_driver'

--9 Find the average collection of all buses accourding to bus_type?

	select bus_type, avg(daily_collection) from bus group by bus_type
	
--10 Give details of employees working in department for given department name Accounts?

	SELECT emp.* FROM ((SELECT d_no FROM DEPARTMENT where d_name='Accounts') as R natural join EMPLOYEE_TYPE) as R1 
				join EMPLOYEE as emp on(emp.E_Type=R1.Type_no);
				
--11 List the name of drivers,conductors and their mobile numbers and buses they ar working for?

	Select R3.E_name,R3.contact_no,R4.Bus_Number_Plate,R3.Type_name 
					from (((select emp.E_Id,emp.E_name,et.Type_name from EMPLOYEE as emp join EMPLOYEE_TYPE as et on(emp.E_Type=et.Type_no)
					where (Type_name='Bus_driver' OR Type_name='Conductor')) as R1
					natural join CONTACTS )as R2
					natural join Working_for) as R3
					natural join BUS as R4 order by R4.bus_number_plate ;

--12 List employee and there type.

	select emp.E_Id,emp.E_name,ET.Type_name from EMPLOYEE as emp join EMPLOYEE_TYPE as ET on(Et.Type_no=emp.E_Type);

--13 List all the managers and their departments.

	select * from EMPLOYEE as emp join DEPARTMENT as dep on(emp.E_Id=dep.Manager_ID);

--14 List all the employees with their personal information and their proffession.

	select R1.*,ET.Type_name from (EMPLOYEE natural join CONTACTS) as R1
							join EMPLOYEE_TYPE as ET on (ET.Type_no=R1.E_Type);

--15 Give complete address of emp of id=40101.

	select E_Id,E_name,Add_line1,Add_line2,PIN from EMPLOYEE where E_Id='40101';

--16 List departments along with its type of working employee.

	select dep.d_no,dep.d_name,et.type_name from EMPLOYEE_TYPE as et natural join DEPARTMENT as dep;

--17 Count total no of employees working.

	select count(*) from EMPLOYEE;

--18 Count no of employees working in each department.

	select d_name,count(*) from (EMPLOYEE as emp join EMPLOYEE_TYPE as et on(et.type_no=emp.E_Type)) as R1 
								natural join DEPARTMENT GROUP By d_name;
								
--19 Name and id of drivers and conductors available who are not working for any buses.

	select  emp.E_id,emp.E_name,et.type_name from EMPLOYEE as emp join EMPLOYEE_TYPE as et on (emp.E_type=et.type_no) 
							where (et.type_name='Bus_driver' OR et.type_name='Conductor')
							AND emp.E_Id not In (select E_id from working_for);

--20 Give contact no of cleaning supervisor. 

	select r1.E_id,R1.E_name,R1.contact_no from (EMPLOYEE natural join CONTACTS) as R1 join EMPLOYEE_TYPE as et on(R1.E_Type=et.type_no) 
								where et.type_name='Cleaning_Supervisor';
								
--21 Give the work of id =10201.

	select et.type_name,emp.e_name from EMPLOYEE as emp join EMPLOYEE_TYPE as et on(emp.E_Type=et.type_no) where emp.e_id='10201';

--22 Give details of Empolyee their work and bus stand where the are working.

	select E_id,e_name,type_name,stop_code from (EMPLOYEE as emp join EMPLOYEE_TYPE as et on(et.type_no=emp.E_type)) as R1 
											join Bus_Stand as BS on(R1.working_in_bus_stand = BS.Stop_code) order by stop_code;

											
--23 Give details of workers working in bus stand Patkia Ashram.

	select emp.E_id,emp.E_name,R1.stop_name from (BUS_STAND  natural join BUS_STOP) as R1 
										join EMPLOYEE as emp on(emp.working_in_bus_stand=R1.Stop_code) 
										where R1.stop_name='Patikashram Bus Stand';

										
--24 Count no of employess working in individual bus stand.

	select bs.stop_name,R1.no_of_emp from(select working_in_bus_stand,count(*) as No_of_emp  from EMPLOYEE group by working_in_bus_stand)as R1 
											join Bus_stop as bs on(R1.working_in_bus_stand=BS.Stop_code)											

--25 list all the bus stands with name

select stop_name from bus_stand join bus_stop on bus_stand.stop_code = bus_stop.stop_code

--26 list total number of routes

select count(route_no) as no_of_routes from route

--27 list all stops of a particular routes

select * from has_stop where route_no = '1-A'

--28 list all routes between two stops

select * from 
	(select * from has_stop where stop_code = 'DMM') as stop_one join 
	(select * from has_stop where stop_code = 'ITV') as stop_two on 
	stop_one.route_no = stop_two.route_no and 
	stop_one.stop_no < stop_two.stop_no

--29 list all routes between two stations

select stop_one.route_no from 
	(select * from has_stop where stop_code = 'PTA') as stop_one join 
	(select * from has_stop where stop_code = '') as stop_two on 
	stop_one.route_no = stop_two.route_no and 
	stop_one.stop_no < stop_two.stop_no

--30 list routes greater than x km

select distinct route_no from has_stop where distance_from_start > 25

--31 list time required between two stops

select distinct stop_one.route_no, (stop_two.estimated_time_from_start - stop_one.estimated_time_from_start) as time_required from 
	(select * from has_stop where stop_code = 'PTA') as stop_one join 
	(select * from has_stop where stop_code = 'SMB') as stop_two on 
	stop_one.route_no = stop_two.route_no and 
	stop_one.stop_no < stop_two.stop_no

--32 list distance between two stops

select distinct stop_one.route_no, (stop_two.distance_from_start - stop_one.distance_from_start) as distance_in_km from 
	(select * from has_stop where stop_code = 'PTA') as stop_one join 
	(select * from has_stop where stop_code = 'SMB') as stop_two on 
	stop_one.route_no = stop_two.route_no and 
	stop_one.stop_no < stop_two.stop_no

--33 list all bus stands with garage

select stop_code from bus_stand where has_garage = true

--34 list all bus stands with platforms > x

select stop_code from bus_stand where no_of_platforms > 8

--35 list all buses arriving at stop x

select distinct bus_no from (select distinct route_no from has_stop where stop_code = 'ITV') as route_info natural join has_route

--36 Total number of passes sold for a bus type.

SELECT bus_type, sum(passes_sold) FROM Sold_passes
Group by bus_type

--37 Total number of passes sold for a combination of bus type and pass type.

SELECT bus_type, pass_type, sum(passes_sold) FROM Sold_passes
group by bus_type, pass_type

--38 Average daily collection for buses of same type

SELECT bus_type, avg(daily_collection) FROM BUS 
GROUP BY bus_type

--39 Total daily collection of buses of same type

SELECT bus_type, sum(daily_collection) FROM BUS 
GROUP BY bus_type

--40 Total daily collection of all the buses running on same route

SELECT route_no, sum(daily_collection) FROM has_route AS r JOIN bus AS b ON(r.bus_no = b.bus_no)
GROUP BY route_no

--41 List all places we can go from stop x

SELECT DISTINCT b.stop_code FROM
(SELECT s.stop_no,s.route_no,s.stop_code FROM (SELECT stop_no,route_no,stop_code FROM has_stop WHERE stop_code='GH1') AS a
JOIN has_stop AS s ON(a.route_no = s.route_no)
EXCEPT
SELECT stop_no,route_no,stop_code FROM has_stop WHERE stop_code='GH1') AS b
