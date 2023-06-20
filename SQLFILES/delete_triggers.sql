----------------------------------------------------------- Deletions to Users Table ----------------------------------------------------------------------------------



-- This is handled automatically with the help of foreign key constraint of on delete cascade

----------------------------------------------------------- Deletions to Posts Table ----------------------------------------------------------------------------------

-- This is all on delete cascade when fked 

create or replace function delete_post(post_id_in text)
returns int 
as $$
declare
r record ;
ae record ;
up int := 0;
down int := 0;
up_new int := 0;
down_new int := 0;
begin 
for r in select * from posts where post_id = post_id_in loop
if r.post_id = post_id_in then 
up := r.upvotes ;
down := r.downvotes ;
end if ;
end loop ;

for ae in select * from users where user_id = r.user_id loop
up_new := ae.upvotes ;
down_new := ae.downvotes ;
end loop ;

up_new := up_new - up ;
down_new := down_new - down ;
update users set upvotes = up_new , downvotes = down_new where user_id = r.user_id ; 
delete from posts where post_id=post_id_in; 
return 1 ;
end ;
$$ language plpgsql ;

select delete_post('B3');

----------------------------------------------------------- Deletions to Comments Table ----------------------------------------------------------------------------------

-- This is all on delete cascade when fked 
create or replace function delete_comment(comment_id_in text)
returns int 
as $$
declare
r record ;
ae record ;
up int := 0;
down int := 0;
up_new int := 0;
down_new int := 0;
begin 
for r in select * from comments where comment_id = comment_id_in loop
if r.comment_id = comment_id_in then 
up := r.upvotes ;
down := r.downvotes ;
end if ;
end loop ;

for ae in select * from users where user_id = r.user_id loop
up_new := ae.upvotes ;
down_new := ae.downvotes ;
end loop ;

up_new := up_new - up ;
down_new := down_new - down ;
update users set upvotes = up_new , downvotes = down_new where user_id = r.user_id ; 
delete from comments where comment_id=comment_id_in; 
return 1 ;
end ;
$$ language plpgsql ;

select delete_comment('B7');




