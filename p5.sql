create or replace function p5() returns void as $$
declare
	t_account char(10);
	v_vno char(10);
	t_amount float8;
	v_vname char(10);
	v_vbalance char(10);
	c1 cursor for 
		select vno, sum(amount) 
		from transaction
		group by vno order by 1;

	c2 cursor for 
		select	vno, vname, vbalance
		from	vendor
		order by 1;
begin
open c1;
	loop
	fetch c1 into v_vno, t_amount;
	exit when not found;
	update vendor set vbalance = vbalance+t_amount where vno=v_vno;
	
	select	vno, vname, vbalance into v_vno, v_vname, v_vbalance
        from	vendor
	where   vno = v_vno;
	raise notice '### Vendor ###';
	raise notice 'Number: %', v_vno;
	raise notice 'Name: %', v_vname;
	raise notice 'Balance: %', v_vbalance;
	raise notice ' ';
	end loop;
close c1;
end;
$$ language plpgsql;
