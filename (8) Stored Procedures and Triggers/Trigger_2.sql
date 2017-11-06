CREATE OR REPLACE FUNCTION process_recruitment()
	RETURNS TRIGGER AS $BODY$
		DECLARE
		e_typ integer;
		B_NO INTEGER;
		ID integer;
		buses integer;
		r_no char(4);
		s_time time;
		dp department%rowtype;
		BEGIN
		e_typ := NEW.E_type;
		id:= NEW.E_ID;
		
		if e_typ='401' then
		select count(*) into buses from buses_in_garage;
			if buses > 0 then
				
				select bg.bus_no into b_no from buses_in_garage as bg;
				insert into working_for values(id,b_no);
				for r_no in select bg.route_no  from buses_in_garage as bg where bg.bus_no=b_no
				loop
				select bg.Starting_time into s_time from buses_in_garage as bg where bg.bus_no=b_no and bg.route_no=r_no;
				insert into has_route values(b_no,r_no,s_time);
				delete from buses_in_garage as bg where bg.bus_no=b_no and bg.route_no=r_no;
				end loop;
			end if;
		end if;
		return new;
		END;
			
	$BODY$ language 'plpgsql';

CREATE OR REPLACE TRIGGER recruitment
	AFTER INSERT ON employee
	FOR EACH ROW
	EXECUTE PROCEDURE process_recruitment();
	
	
	
