create or replace function p3(cusname char, cusprovince char) returns void as $$
declare
	c_account char(10);
	n_account char(10);
	c_anum integer;
	temp integer;
	c_cname char(10);
	c_province char(10);
	c_cbalance float8;
	c_crlimit float8;
	c1 cursor for select account,
	CAST(COALESCE(substring(account FROM '[0-9]+'), account) as integer),
	cname, province, cbalance, crlimit from customer;
begin
	temp := 0;
	open c1;
	loop
		fetch c1 into c_account, 
		c_anum, c_cname, c_province, c_cbalance, c_crlimit;
		exit when not found;
		raise notice 'Account: %', c_account;
		raise notice 'Name: %', c_cname;
		raise notice 'Province: %', c_province;
		raise notice 'Balance: %', c_cbalance;
		raise notice 'CrLimit: %', c_crlimit;
		if c_anum>temp then
			temp:=c_anum;
		end if;
		raise notice ' ';
	end loop;

	temp := temp+1;
	n_account := 'A'||temp;
	insert into customer values (n_account,cusname,cusprovince,0,1000);
	select * from customer into c_account, c_cname, c_province, c_cbalance, c_crlimit 
		where account = n_account;
	raise notice ' ';
	raise notice '### New Account ###';
	raise notice 'Account: %', c_account;
	raise notice 'Name: %', c_cname;
	raise notice 'Province: %', c_province;
	raise notice 'Balance: %', c_cbalance;
	raise notice 'CrLimit: %', c_crlimit;

	close c1;
end;
$$ language plpgsql;
