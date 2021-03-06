create or replace function p5a() returns void as $$
declare
	t_account char(30);
	v_vno char(30);
	t_amount float8;
	v_vname char(30);
	v_vbalance char(30);
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

create or replace function p5() returns void as $$
declare
        t_account char(30);
        v_vno char(30);
        t_amount float8;
        v_vname char(30);
        v_vbalance char(30);
        c1 cursor for
                select vno, sum(amount)
                from transaction
                group by vno order by 1;

        c2 cursor for
                select  vno, vname, vbalance
                from    vendor
                order by 1;
begin
open c1;
        loop
        fetch c1 into v_vno, t_amount;
        exit when not found;
        update vendor set vbalance = vbalance+t_amount where vno=v_vno;
        end loop;
close c1;
open c2;
	loop
	fetch c2 into v_vno, v_vname, v_vbalance;
        exit when not found;
        raise notice '### Vendor ###';
        raise notice 'Number: %', v_vno;
        raise notice 'Name: %', v_vname;
        raise notice 'Balance: %', v_vbalance;
        raise notice ' ';
	end loop;
close c2;
end;
$$ language plpgsql;

