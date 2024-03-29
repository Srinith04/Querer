-- Table for tags -- Created
CREATE TABLE tags(
	tag_name TEXT primary key 
);

-- Table for users -- Created 
CREATE TABLE users(
	user_id SERIAL ,
	username TEXT UNIQUE not null ,
	gmail TEXT not null,
	password TEXT not null,
	upvotes int default 0 ,
	downvotes int default 0 ,
	profile_image BYTEA ,
	primary key(user_id)
);

-- Table for posts -- created 
CREATE TABLE posts(
	post_id TEXT not null,
	user_id int not null,
	title TEXT not null,
	body TEXT not null,
	image BYTEA ,
	time_created timestamp default current_timestamp not null ,
	edit_status int default 0 ,
	upvotes int default 0 ,
	downvotes int default 0 ,
	tags TEXT[] ,
	availability_of_post_to_ans int default 1,
	primary key(post_id),
	foreign key(user_id) references users(user_id) on delete cascade 
);

-- Table for Comments -- created 
CREATE table comments(
	comment_id TEXT not null ,
	post_id TEXT not null,
	user_id int not null ,
	body TEXT not null ,
	upvotes int default 0 ,
	downvotes int default 0 ,
	editstatus int default 0 ,
	time_created timestamp default current_timestamp not null ,
	primary key(comment_id) ,
	foreign key(post_id) references posts(post_id) on delete cascade ,
	foreign key(user_id) references users(user_id) on delete cascade 
);


-- Table for count of users activity -- Created 
CREATE TABLE user_count_number(
	user_id int ,
	total_number_posts int default 0,
	total_number_comments int default 0,
	primary key(user_id) ,
	foreign key(user_id) references users(user_id) on delete cascade 
);


