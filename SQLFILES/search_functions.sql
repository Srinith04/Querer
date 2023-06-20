------------------------------------------------------- SEARCHING FOR USERS ---------------------------------
create or replace function search_posts_by_user_id(user_id_in int)
returns table(
	post_id_out TEXT ,
	user_id_out int ,
	title_out TEXT ,
	body_out TEXT ,
	image_out BYTEA ,
	time_created_out_time timestamp,
	edit_status_out int,
	upvotes_out int ,
	downvotes_out int ,
	tags_out TEXT[] ,
	availability_of_post_to_ans_out int
)
as $$
declare 
r record ;
begin 
for r in select * from posts loop
if user_id_in = r.user_id then 
	post_id_out := r.post_id ;
	user_id_out := r.user_id ;
	title_out := r.title ;
	body_out := r.body ;
	image_out := r.image ;
	time_created_out_time := r.time_created ;
	edit_status_out := r.edit_status ;
	upvotes_out := r.upvotes ;
	downvotes_out := r.downvotes ;
	tags_out := r.tags ;
	availability_of_post_to_ans_out := r.availability_of_post_to_ans ;
	return next ;
end if ;
end loop ;
end ;
$$ language plpgsql ;

select post_id_out as post_id,user_id_out as user_id,title_out as title,body_out as body,image_out as image,time_created_out_time as time_created,edit_status_out as edit_status,upvotes_out as upvotes,downvotes_out as downvotes,tags_out as tags,availability_of_post_to_ans_out as availability_of_post_to_ans  FROM search_posts_by_user_id(2) order by time_created Asc ; -- New posts sort
select post_id_out as post_id,user_id_out as user_id,title_out as title,body_out as body,image_out as image,time_created_out_time as time_created,edit_status_out as edit_status,upvotes_out as upvotes,downvotes_out as downvotes,tags_out as tags,availability_of_post_to_ans_out as availability_of_post_to_ans FROM search_posts_by_user_id(2) order by time_created_out_time desc ; -- Old posts sort
select post_id_out as post_id,
user_id_out as user_id,
title_out as title,
body_out as body,
image_out as image,
time_created_out_time as time_created,
edit_status_out as edit_status,upvotes_out as upvotes,downvotes_out as downvotes,tags_out as tags,availability_of_post_to_ans_out as availability_of_post_to_ans
FROM search_posts_by_user_id(2) order by upvotes asc ; -- Least upvotes at top
select post_id_out as post_id,user_id_out as user_id,title_out as title,body_out as body,image_out as image,time_created_out_time as time_created,edit_status_out as edit_status,upvotes_out as upvotes,downvotes_out as downvotes,tags_out as tags,availability_of_post_to_ans_out as availability_of_post_to_ans FROM search_posts_by_user_id(3) order by upvotes desc ; -- Highest upvotes at top

------------------------------------------------------- SEARCHING BASED ON TAGS ---------------------------------

create or replace function search_posts_by_tags(tags_in text[])
returns table(
	post_id_out TEXT ,
	user_id_out int ,
	title_out TEXT ,
	body_out TEXT ,
	image_out BYTEA ,
	time_created_out_time timestamp,
	edit_status_out int,
	upvotes_out int ,
	downvotes_out int ,
	tags_out TEXT[] ,
	availability_of_post_to_ans_out int
)
as $$
declare 
r record ;
tags_temp text[] ;
i text ;
j text;
counter int := 0;
begin 
for r in select * from posts loop
counter := 0;
tags_temp := r.tags;
if tags_in is not null then 
foreach i in array tags_in loop 
if tags_temp is not null then 
foreach j in array tags_temp loop 
if j = i then 
counter := counter + 1 ;
end if ;
end loop;
end if ;
end loop;
if cardinality(r.tags) >= counter and counter > 0 and counter >= cardinality(tags_in) then 
	post_id_out := r.post_id ;
	user_id_out := r.user_id ;
	title_out := r.title ;
	body_out := r.body ;
	image_out := r.image ;
	time_created_out_time := r.time_created ;
	edit_status_out := r.edit_status ;
	upvotes_out := r.upvotes ;
	downvotes_out := r.downvotes ;
	tags_out := r.tags ;
	availability_of_post_to_ans_out := r.availability_of_post_to_ans ;
return next ;
end if ;
end if ;
end loop ;
end ;
$$ language plpgsql ;

-- 	MODIFIED AS DID ABOVE
select post_id_out as post_id,user_id_out as user_id,title_out as title,body_out as body,image_out as image,time_created_out_time as time_created,edit_status_out as edit_status,upvotes_out as upvotes,downvotes_out as downvotes,tags_out as tags,availability_of_post_to_ans_out as availability_of_post_to_ans FROM search_posts_by_tags('{C}') order by time_created_out_time desc ; -- New posts sort
select post_id_out as post_id,user_id_out as user_id,title_out as title,body_out as body,image_out as image,time_created_out_time as time_created,edit_status_out as edit_status,upvotes_out as upvotes,downvotes_out as downvotes,tags_out as tags,availability_of_post_to_ans_out as availability_of_post_to_ans FROM search_posts_by_tags('{C,C++,Python}') order by time_created_out_time asc ; -- Old posts sort
select post_id_out as post_id,user_id_out as user_id,title_out as title,body_out as body,image_out as image,time_created_out_time as time_created,edit_status_out as edit_status,upvotes_out as upvotes,downvotes_out as downvotes,tags_out as tags,availability_of_post_to_ans_out as availability_of_post_to_ans FROM search_posts_by_tags('{C,C++,Python}') order by upvotes asc ; -- Upvotes lowest
select post_id_out as post_id,user_id_out as user_id,title_out as title,body_out as body,image_out as image,time_created_out_time as time_created,edit_status_out as edit_status,upvotes_out as upvotes,downvotes_out as downvotes,tags_out as tags,availability_of_post_to_ans_out as availability_of_post_to_ans FROM search_posts_by_tags('{C,C++,Python}') order by upvotes desc ; -- Upvotes highest sort


