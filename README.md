-- 📌 1) Database & User 설정
CREATE DATABASE springdb;

CREATE USER 'springdbuser'@'%' IDENTIFIED BY '1234';

GRANT ALL PRIVILEGES ON springdb.* TO 'springdbuser'@'%';


-- 📌 2) table_board 테이블 생성
create table table_board(
    bno int auto_increment primary key,
    title varchar(500) not null,
    content varchar(2000) not null,
    writer varchar(50) not null,
    regdate timestamp default now(),
    updatedate timestamp default now(),
    delflag boolean default false
);

-- 📌 3) tbl_reply 테이블 생성
create table tbl_reply(
	rno int auto_increment primary key,
    replyText varchar(500) not null, -- 댓글 내용
    replyer varchar(50) not null,  -- 작성자
    replydate timestamp default now(),
    updatedate timestamp default now() on update now(),
    delflag boolean default false,
    bno int not  null  
);

-- 📌 4) 외래키 설정
alter table tbl_reply add constraint fk_reply_board foreign key(bno)
references tbl_board(bno);

-- 📌 5) 인텍스 설정
create index idx_reply_board on tbl_reply(bno desc, rno asc);
