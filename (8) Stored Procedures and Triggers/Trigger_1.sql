CREATE OR REPLACE FUNCTION process_employee_audit()
	RETURNS TRIGGER AS $BODY$
		DECLARE
		e_typ integer;
		B_NO INTEGER;
        rot_no char(4);
        st_time time;
		dp department%rowtype;
		BEGIN
		e_typ := OLD.E_type;
	
    IF e_typ='401' THEN
  		SELECT bus_no into b_no from working_for where e_id = OLD.E_Id;
        FOR rot_no in select route_no from has_route where bus_no = b_no
		loop
        SELECT Starting_time into st_time from has_route where bus_no = b_no and route_no=rot_no;
    	DELETE FROM Has_route where bus_no = b_no and rot_no=route_no;
    	INSERT INTO buses_in_garage  VALUES(b_no,rot_no,st_time);
    	end loop;
		DELETE FROM WORKING_FOR WHERE E_ID= OLD.E_Id;
    	END IF;
        
        if old.e_type='501' then
		FOR dp in select * from department
		LOOP
		IF OLD.E_id = dp.manager_id THEN
		RAISE EXCEPTION 'Can not delete Employee.'; 
		END IF;
		END LOOP;
        end if;
        DELETE FROM Contacts as c WHERE c.e_id = OLD.E_id;
      	RETURN old ;
        
	END;
    
	$BODY$
	language plpgsql;

	
	CREATE OR REPLACE TRIGGER employee_audit
	BEFORE DELETE ON employee
	FOR EACH ROW
	EXECUTE PROCEDURE process_employee_audit();
	
	