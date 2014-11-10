create or replace function p1(cusname char) returns void as $$
declare
	v_vname char(10);
	t_tdate date;
	t_amount float8;
	c1 cursor for select vname, t_date, amount from transaction, vendor, customer where transaction.vno = vendor.vno and transaction.account = customer.account and customer.cname=cusname;
begin
open c1;
loop
fetch c1 into v_vname, t_tdate, t_amount;
exit when not found;
raise notice 'Vendor name: %', v_vname;
raise notice 'Date: %', t_tdate;
raise notice 'Amount: %', t_amount;
raise notice ' ';
end loop;
close c1;
end;
$$ language plpgsql;
