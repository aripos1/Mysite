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
