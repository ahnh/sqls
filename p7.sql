create or replace function p7() returns void as $$
declare
	c_account char(10);
	c_cname char(10);
	c_cbalance float8;
	c_crlimit float8;
	c1 cursor for 
		select account, cname, cbalance, crlimit 
		from customer
		order by 1;

	c2 cursor for 
		select	cname, cbalance
		from	customer
		order by 1;
begin
open c1;
	loop
	fetch c1 into c_account, c_cname, c_cbalance, c_crlimit;
	exit when not found;
	if (c_cbalance > c_crlimit) then
	update customer set cbalance = cbalance+(c_crlimit*0.1) where account=c_account;
	end if;
	end loop;
close c1;
open c2;
	loop
	fetch c2 into c_cname, c_cbalance;
	exit when not found;
	raise notice 'Name: %', c_cname;
	raise notice 'Balance: %', c_cbalance;
	raise notice ' ';
	end loop;
close c2;
end;
$$ language plpgsql;
