# SF


create database springdb;

create user 'springdbuser'@'%' identified by '1234';

grant all privileges on springdb.* to 'springdbuser'@'%';
