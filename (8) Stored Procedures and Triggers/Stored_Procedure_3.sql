create table schedule_for_embedded(
bs_tp varchar(10),
route varchar(4),
distance integer,
Arrival varchar(20),
Reaches varchar(20),
fare integer);

create or replace function schedule_enquiry(src varchar(20),dest varchar(20))
	returns setof schedule_for_embedded
as $body$
	
declare 
	 rec schedule_for_embedded;
	 s_dstnc numeric;
	 d_dstnc numeric;
	 s_time integer;
	 d_time integer;
	 bs_fare integer;
	 rate numeric;
	 cost numeric;
	 typ varchar(10);
     bs_n has_route%rowtype;
     root record;
     count integer;
     t time;
	 arri time;
	 reah time;
	 arr varchar(20);
	 reh varchar(20);
begin
	
	for root in select * from
    (select route_no as s1_route_no,stop_no as s1_stop_no,stop_code as s1_stop_code,distance_from_start as s1_distance_from_start ,
     estimated_time_from_start as s1_estimated_time_from_start
                               from has_stop where stop_code = src) as stop_one join 
										(select  route_no as s2_route_no,stop_no as s2_stop_no,stop_code as s2_stop_code,distance_from_start as s2_distance_from_start ,
     estimated_time_from_start as s2_estimated_time_from_start from has_stop where stop_code = dest) as stop_two on 
											stop_one.s1_route_no = stop_two.s2_route_no and 
											stop_one.s1_stop_no < stop_two.s2_stop_no 
	
	loop
		for bs_n in select * from has_route where route_no=root.s1_route_no
		loop
        	
            s_time = root.s1_estimated_time_from_start;
			d_time = root.s2_estimated_time_from_start;
			s_dstnc = root.s1_distance_from_start;
			d_dstnc = root.s2_distance_from_start;
			
            select bt.base_fare into bs_fare from bus as bs join bus_type as bt
            							on (bs.bus_type=bt.type_name) where bs_n.bus_no= bs.bus_no;
			select bt.rate_per_km into rate from bus as bs join bus_type as bt
            							on (bs.bus_type=bt.type_name) where bs_n.bus_no= bs.bus_no;
			select bt.type_name into typ from bus as bs join bus_type as bt
            							on (bs.bus_type=bt.type_name) where bs_n.bus_no= bs.bus_no;

			cost=rate*(d_dstnc-s_dstnc);
			if cost<bs_fare 
				then cost=bs_fare;
			end if;
			rec.fare := cost;
			rec.distance:=d_dstnc-s_dstnc;
			
			arri:= bs_n.starting_time ;
            for count in select * from employee
			 loop
			  if s_time>0 then s_time= s_time-1;
			  arri:= arri+ interval '1 minutes';
			  end if;
			 end loop;
			arr = to_char(arri, 'HH24:MI:SS');
			rec.Arrival=arr;
            reah:= bs_n.starting_time ;
            for count in select * from employee
			 loop
			  if d_time>0 then d_time= d_time-1;
			   reah:=  reah+ interval '1 minutes';
			  end if;
			 end loop;
			 reh = to_char(reah, 'HH24:MI:SS');
			 rec.Reaches=reh;
            rec.bs_tp:=typ;
			-- rec.bs_no:=bs_n.Bus_no;
			rec.route:=root.s1_route_no;
			return next rec;
		end loop;
	end loop;
	return;
end
$body$ language plpgsql;


-- Select * from bus_enquiry_test('DMM','ITV') order by arrival;

