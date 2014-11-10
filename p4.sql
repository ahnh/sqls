create or replace function p4() returns void as $$
declare
	t_account char(10);
	c_account char(10);
	c_cname char(10);
	t_amount float8;
	v_vname char(10);
	t_tdate date;
	c1 cursor for 
		select transaction.account, max(t_date) 
		from transaction, customer 
		where customer.account = transaction.account 
		group by transaction.account order by 1;

	c2 cursor for 
		select	account, cname
		from	customer 
		where	not exists 
			(select * from transaction as t 
				where t.account=customer.account);
begin
open c1;
	loop
	fetch c1 into t_account, t_tdate;
	exit when not found;
	select	customer.cname, transaction.amount, vname
	into 	c_cname, t_amount, v_vname
        from	transaction, customer, vendor
	where   customer.account = transaction.account and
		transaction.vno = vendor.vno and
		transaction.account=t_account and
		transaction.t_date = t_tdate;

	raise notice 'Account: %', t_account;
	raise notice 'Name: %', c_cname;
	raise notice 'Amount: %', t_amount;
	raise notice 'Vendor: %', v_vname;
	raise notice 'date: %', t_tdate;
	raise notice ' ';
	end loop;
close c1;

open c2;
	loop
	fetch c2 into c_account, c_cname;
	exit when not found;
	raise notice '### No transaction ###';
	raise notice 'Account: %', c_account;
	raise notice 'Name: %', c_cname;
	raise notice ' ';
	end loop;
close c2;
end;
$$ language plpgsql;
