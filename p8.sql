create or replace function p8(transacc char, vnum  char, cusacc char, amount float8) returns void as $$
declare
        t_account char(30);
        t_amount float8;
	t_tdate date;
	v_vno char(30);
        v_vname char(30);
        v_city char(30);
        v_vbalance float8;
        c_account char(30);
        c_cname char(30);
        c_province char(30);
        c_cbalance float8;
        c_crlimit char(30);

begin
	insert into transaction values (transacc, vnum, cusacc, current_date, amount);
	update customer set cbalance = cbalance+amount where account=cusacc;
	update vendor set vbalance = vbalance+amount where vno=vnum;
        select * into t_account, v_vno, c_account, t_tdate, t_amount from transaction where tno = transacc;
        raise notice '## New transaction ##';
        raise notice 'tno: %',t_account;
        raise notice 'vno: %',v_vno;
        raise notice 'Account: %',c_account;
        raise notice 't_date: %',t_tdate;
        raise notice 'Amount: %',t_amount;
	raise notice ' ';

	if ((select count(*) from customer where account=cusacc) > 0) then
		select * into c_account, c_cname, c_province, c_cbalance, c_crlimit
		from customer
		where account = cusacc;
		raise notice '## Updated Customer ## ';
		raise notice 'account: %',c_account;
       		raise notice 'cname: %',c_cname;
	        raise notice 'province: %',c_province;
	        raise notice 'cbalance:: %',c_cbalance;
        	raise notice 'crlimit: %',c_crlimit;
	else
		raise notice '## Customer not found ##';
	end if;
	raise notice ' ';
	
	if ((select count(*) from vendor where vno=vnum) > 0) then
                select * into v_vno, v_vname, v_city, v_vbalance
                from vendor
                where vno = vnum;
                raise notice '## Updated Vendor ## ';
                raise notice 'vno: %',v_vno;
                raise notice 'vname: %',v_vname;
                raise notice 'city: %',v_city;
                raise notice 'vbalance: %',v_vbalance;
        else
                raise notice '## Vendor not found ##';
        end if;
        raise notice ' ';

end;
$$ language plpgsql;


