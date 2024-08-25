-- root

-- 계정생성
create user 'web'@'%' identified by 'web';

-- db 생성
create database web_db 
       default character set utf8mb4 -- 이모티콘 사용 케릭터셋
       collate utf8mb4_general_ci
       default encryption='n'
;


-- 권한부여
 grant all privileges on  web_db.* to 'web'@'%' ;
 
 flush privileges;
 
 
 




-- web 계정

-- teble 생성
CREATE TABLE users (
    no INT auto_increment primary KEY,
    id VARCHAR(20) unique not null,
    password varchar(20) not null,
    name varchar(20),
    gender varchar(10)
);



select * from users;

select no
		,id
        ,password
        ,name
        ,gender
from users;

insert into users
values(null, '1', '123', '임현성', '남')
;


select * from guestbook;

create table guestbook(
	no integer primary key auto_increment,
    name varchar(80) not null,
    password varchar(20),
    content text,
    reg_date datetime
);

USE web_db;
SHOW TABLES;


RENAME TABLE geustbook TO guestbook;



create table board(
	no integer primary key,
    title varchar(500) not null,
    content text,
    hit integer,
    reg_date datetime not null,
    user_no integer,
    FOREIGN KEY (user_no) REFERENCES users(no)
);

select * from board;

ALTER TABLE board MODIFY COLUMN no INT AUTO_INCREMENT;


insert into board
values(null, '늑대', '늑대늑대', 12, 20240825, 1) ;



SELECT b.no, 
		b.title, 
        b.content, 
        b.reg_date, 
        u.name 
FROM board b 
JOIN users u ON b.user_no = u.no 
;