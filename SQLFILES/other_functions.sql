create or replace function login(user_id_in text, pass text) 
returns int 
as $$ 
declare 
r record ;
begin 
for r in select * from users loop
	if r.username = user_id_in then 
		if r.password = MD5(pass) then
			return r.user_id;
		else 
			return 0;
		end if ;
	end if ;
end loop ;
return 0;
end ;
$$ language plpgsql ;

select login('A','anu'); -- This function should be called for checking of login validity




