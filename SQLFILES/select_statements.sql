select * from users ;
select * from tags ;
select * from user_count_number  ;
select * from posts ;
select * from comments ;


------------------------------------------- EXTRA ---------------------------------------------------------------------------
SELECT post_id,title FROM posts WHERE upper(replace(title, ' ','')) LIKE upper(replace('HOWto%', ' ','')) LIMIT 10 OFFSET 0

SELECT t.post_id,t.time_created,t.title FROM 
(SELECT post_id,time_created,title 
 FROM posts  
 order by title)t
 WHERE upper(title) LIKE upper('how%') order by time_created  limit 10 offset 0 

SELECT REPLACE(title , ' ','') from posts where user_id=4

select DISTINCT(time_created) from posts ORDER BY time_created

select datediff(second , current_timestamp , '2023-03-04 20:28:45' ) from (select time_created from posts)t

select extract(epoch from current_timestamp - t.time_created::timestamp) as duration from (select time_created from posts)t
				
select * from users where user_id =1;
select * from posts where post_id='Community12';
-----------------------------------------------------------------------------------------------------------------------------------
