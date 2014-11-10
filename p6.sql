create or replace function p6() returns void as $$
declare
	t_account char(10);
	v_vno char(10);
	t_amount float8;
	v_vname char(10);
	v_vbalance float;
	v_servicefee float;


	c1 cursor for 
		select vno, vbalance 
		from vendor
		order by 1;

	c2 cursor for 
		select	vno, vname, vbalance
		from	vendor
		order by 1;
begin
open c1;
	loop
	fetch c1 into v_vno, v_vbalance;
	exit when not found;
	raise notice 'before: %',v_vbalance;
	v_servicefee = v_vbalance * 0.04;
	update vendor set vbalance = vbalance-(v_servicefee*0.04) where vno=v_vno;
	
	select	vno, vname, vbalance into v_vno, v_vname, v_vbalance
        from	vendor
	where   vno = v_vno;
	raise notice 'Number: %', v_vno;
	raise notice 'Name: %', v_vname;
	raise notice 'Service Fee: %', v_servicefee;
	raise notice 'New Balance: %', v_vbalance;
	raise notice ' ';
	end loop;
close c1;
end;
$$ language plpgsql;
