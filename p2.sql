create or replace function p2(venname char) returns void as $$
declare
	c_account char(10);
	c_cname char(10);
	c_province char(10);
	c1 cursor for select customer.account, cname, province from transaction, vendor, customer where transaction.vno = vendor.vno and transaction.account = customer.account and vendor.vname=venname;
begin
open c1;
loop
fetch c1 into c_account, c_cname, c_province;
exit when not found;
raise notice 'Account: %', c_account;
raise notice 'Name: %', c_cname;
raise notice 'Province: %', c_province;
raise notice ' ';
end loop;
close c1;
end;
$$ language plpgsql;
