----------------------------------------------------------- Insertions to Users Table ----------------------------------------------------------------------------------

-- Trigger to handle insertions to users table 
CREATE OR REPLACE FUNCTION insert_users_table_1()
returns trigger 
as $$ 
declare 
begin 
new.password = MD5(new.username);
return new ;
end ;
$$ language plpgsql ;

create or replace trigger insert_users_1 
before insert 
on users 
for each row 
execute procedure insert_users_table_1() ;

-- Trigger to add new tuple to user_count_number
CREATE OR REPLACE FUNCTION insert_users_table_2()
returns trigger 
as $$ 
declare 
begin 
insert into user_count_number(user_id) values(new.user_id);
return new ;
end ;
$$ language plpgsql ;

create or replace trigger insert_users_2
after insert 
on users 
for each row 
execute procedure insert_users_table_2() ;

----------------------------------------------------------- Insertions to Posts Table ----------------------------------------------------------------------------------
create or replace function insert_posts_table()
returns trigger 
as $$
declare 
r record ;
temp_arr text[] ;
track integer := 1 ;
q record ;
t record ;
i TEXT ;
loopvar int := 0; 
checke int := 0;
count int ;
begin 
for r in select * from users 
loop
if r.user_id = new.user_id then 
	EXIT ;
end if ;
end loop;

for q in select * from user_count_number 
loop 
if q.user_id = new.user_id then 
	count := q.total_number_posts ; 
	count := count + 1 ;
	update user_count_number set total_number_posts = count where user_id = q.user_id ;
end if ;
end loop;

loopvar := 0 ;
if new.tags is not null then 
foreach i in array new.tags loop 
loopvar := loopvar + 1 ;
checke := 0 ;
for t in select * from tags loop
if i = t.tag_name then 
	temp_arr[track] := i ; 
	track := track+1 ; 
	exit ;
end if ;
end loop;
end loop ;
end if ;
new.tags = temp_arr ;
new.post_id = r.username || count ;
return new ;
end ;
$$ language plpgsql ;

create or replace trigger insert_posts 
before insert 
on posts 
for each row 
execute procedure insert_posts_table() ;

----------------------------------------------------------- Insertions to Comments Table ----------------------------------------------------------------------------------
create or replace function insert_comments_table()
returns trigger 
as $$
declare
r record ;
q record ;
count int ;
begin 
for r in select * from users 
loop
if r.user_id = new.user_id then 
	EXIT ;
end if ;
end loop;

for q in select * from user_count_number 
loop 
if q.user_id = new.user_id then 
	count := q.total_number_comments ; 
	count := count + 1 ;
	update user_count_number set total_number_comments = count where user_id = q.user_id ;
	EXIT ;
end if ;
end loop;

new.comment_id = r.username || count ;
return new ;
end ;
$$ language plpgsql ;

create or replace trigger insert_comments 
before insert 
on comments 
for each row
execute procedure insert_comments_table() ;


