create or replace function pass_update(bus_tp varchar(10),pass_tp varchar(10),route_n varchar(4),out cost integer)
as $body$
declare 
	p_count integer:=0;
begin
	SELECT sp.pass_cost into cost FROM sold_passes as sp where sp.route_no=route_n and pass_tp=sp.pass_type and bus_tp=sp.bus_type;
	SELECT passes_sold into p_count FROM sold_passes as sp where sp.route_no=route_n and pass_tp=sp.pass_type and bus_tp=sp.bus_type;
	p_count=p_count+1;
	raise notice 'Cost you have to pay %',cost;
    update sold_passes set passes_sold = p_count where route_no=route_n and pass_tp=pass_type and bus_tp=bus_type;
end
$body$ language plpgsql;

-- Select * from pass_update('AC','Yearly','1-A') ;