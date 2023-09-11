create database app;
use app;

create table tbl_member(
	id bigint unsigned auto_increment primary key,
	member_id varchar(255) not null,
	member_password varchar(255) not null,
	member_name varchar(255) not null
);
select * from tbl_member;

create table tbl_product(
	id bigint unsigned auto_increment primary key,
	product_name varchar(255) not null,
	product_price int unsigned default 0,
	created_date date default (current_date)
);

select * from tbl_product;

create table tbl_student(
	id bigint unsigned auto_increment primary key,
	student_name varchar(255),
	student_birth datetime default current_timestamp
);


