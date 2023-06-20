-- Done
copy users(username,gmail) from
'D:\COLLEGE\SEM4\CS3563 DBMS-2\Assign2_sql_codes\data_csv\Users.csv'
DELIMITER ','
CSV HEADER ;
insert into users(username,gmail) values('A','a@gmail.com');
insert into users(username,gmail) values('B','a@gmail.com');
insert into users(username,gmail) values('C','a@gmail.com');
insert into users(username,gmail) values('D','a@gmail.com');
insert into users(username,gmail) values('E','a@gmail.com');


-- Done
copy tags(tag_name) from 
'D:\COLLEGE\SEM4\CS3563 DBMS-2\Assign2_sql_codes\data_csv\Tags.csv'
DELIMITER ','
CSV HEADER ;
insert into tags values('C');
insert into tags values('C++');
insert into tags values('Python');
insert into tags values('JS');
insert into tags values('Node');

-- Done	
copy posts(user_id,title,body,tags) from 
'D:\COLLEGE\SEM4\CS3563 DBMS-2\Assign2_sql_codes\data_csv\Posts.csv'
DELIMITER ','
CSV HEADER ;
insert into posts(user_id,title,body,tags) values(2,'C is good','Yes','{Zii,C,C++,K}');
insert into posts(user_id,title,body,tags) values(2,'C is good','Yes','{C,C++,K}');
insert into posts(user_id,title,body,tags) values(2,'C is good','Yes','{C++}');
insert into posts(user_id,title,body,tags) values(2,'C is good','Yes','{Zii,LII,C,C++,K}');
insert into posts(user_id,title,body,tags) values(3,'C++ is good','Yes C++','{Python,C,C++,JS}');
insert into posts(user_id,title,body,tags) values(3,'C++ is good','Yes C++','{JS}');
insert into posts(user_id,title,body,tags) values(3,'C++ is good','Yes C++','{C++,Node}');
insert into posts(user_id,title,body,tags) values(3,'C++ is good','Yes C++','{Node}');
insert into posts(user_id,title,body,tags) values(4,'Python is good','Yes','{C,C++,JS}');
insert into posts(user_id,title,body,tags) values(4,'Python is good','Yes','{C,C++,Node}');
insert into posts(user_id,title,body,tags) values(4,'Python is good','Yes','{C++,Node}');
insert into posts(user_id,title,body,tags) values(4,'Python is good','Yes','{C,C++,Python}');

-- Done
copy comments(post_id,user_id,body) from 
'D:\COLLEGE\SEM4\CS3563 DBMS-2\Assign2_sql_codes\data_csv\Comments2.csv'
DELIMITER ','
CSV HEADER ;
insert into comments(post_id,user_id,body) values('A8',2,'yes2');
insert into comments(post_id,user_id,body) values('A8',3,'yes3');
insert into comments(post_id,user_id,body) values('A8',4,'yes4');
insert into comments(post_id,user_id,body) values('A8',5,'yes5');
insert into comments(post_id,user_id,body) values('C7',2,'yes2');
insert into comments(post_id,user_id,body) values('C7',3,'yes3');
insert into comments(post_id,user_id,body) values('C7',4,'yes4');
insert into comments(post_id,user_id,body) values('C7',5,'yes5');
insert into comments(post_id,user_id,body) values('B5',2,'yes2');
insert into comments(post_id,user_id,body) values('B5',3,'yes3');
insert into comments(post_id,user_id,body) values('B5',4,'yes4');
insert into comments(post_id,user_id,body) values('B5',5,'yes5');






