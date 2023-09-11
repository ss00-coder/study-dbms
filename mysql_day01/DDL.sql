create database study;
use study;

/*무결성 위반*/
create table tbl_animal(
	animal_name varchar(255),
	animal_age tinyint
);

drop table tbl_animal;

create table tbl_animal(
	id bigint unsigned auto_increment primary key,
	animal_name varchar(255) not null,
	animal_age tinyint unsigned check(animal_age > 3)
);

/*	TBL_MEMBER
	-------------------------
	id: bigint(pk)		
	-------------------------
	member_id(uk): varchar	
	member_password: varchar	
	member_address: varchar	
	member_email(uk): varchar
	member_birth: date
*/
create table tbl_member(
	id bigint unsigned auto_increment primary key,
	member_id varchar(255) not null unique,
	member_password varchar(255) not null,
	member_email varchar(255) not null unique,
	member_birth date
);

/*alter table [테이블명] add [컬럼명] [자료형] [제약조건];*/
alter table tbl_member add member_address varchar(255);

/*
	tbl_product
	-------------------------
	id: bigint(pk)
	-------------------------
	product_name: varchar
	product_price: int
	product_stock: int
*/
create table tbl_product(
	id bigint unsigned auto_increment primary key,
	product_name varchar(255) not null,
	product_price int default 0,
	product_stock int default 0
);

/*
	tbl_order
	-------------------------
	id: bigint(pk)
	-------------------------
	order_date: datetime
	member_id: bigint(fk)
	product_id: bigint(fk)
*/
create table tbl_order(
	id bigint unsigned auto_increment primary key,
	order_date datetime default current_timestamp(),
	member_id bigint unsigned,
	product_id bigint unsigned,
	constraint fk_order_member foreign key(member_id)
	references tbl_member(id),
	constraint fk_order_product foreign key(product_id)
	references tbl_product(id)
);

alter table tbl_order add product_count int;

/*
 * 요구 사항
 * 
 * 커뮤니티 게시판을 만들고 싶어요.
 * 게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
 * 게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요
 * 작성자는 회원(TBL_MEMBER)정보를 그대로 사용해요.
 * 댓글에도 작성자가 필요해요.
 * 
 * 
 * */
create table tbl_post(
	id bigint unsigned auto_increment primary key,
	post_title varchar(255) not null,
	post_content varchar(255) not null,
	member_id bigint unsigned,
	constraint fk_post_member foreign key(member_id)
	references tbl_member(id)
);

create table tbl_reply(
	id bigint unsigned auto_increment primary key,
	reply_content varchar(255) not null,
	member_id bigint unsigned,
	constraint fk_reply_member foreign key(member_id)
	references tbl_member(id)
);



/*
 * 요구사항
 * 
 * 마이페이지에서 회원 프로필을 구현하고 싶습니다.
 * 회원당 프로필을 여러 개 설정할 수 있고 
 * 대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.
 * 
 * */

create table tbl_file(
	id bigint unsigned auto_increment primary key,
	file_name varchar(255),
	file_uuid varchar(255),
	file_path varchar(255),
	file_represent varchar(255),
	member_id bigint unsigned,
	constraint fk_file_member foreign key(member_id)
	references tbl_member(id)
);


/*

1.학사 관리 시스템에서 학생과 교수가 존재
2.학생은 학번, 이름, 전공, 학년 등
3.교수는 교수 번호, 이름, 전공, 직위 등
4.과목은 고유한 과목 번호, 과목명, 학점 등
6.학생은 여러 개의 과목을 수강가능
7.교수는 여러 개의 과목을 강의가능
8.학생이 수강한 과목은 성적이 기록됩니다. 
*/

create table tbl_student(
	id bigint unsigned auto_increment primary key,
	student_name varchar(255) not null,
	student_major varchar(255) not null,
	student_level int default 1
);

create table tbl_professor(
	id bigint unsigned auto_increment primary key,
	professor_name varchar(255) not null,
	professor_major varchar(255) not null,
	professor_position varchar(255) not null
);


create table tbl_subject(
	id bigint unsigned auto_increment primary key,
	subject_name varchar(255) not null,
	subject_score int default 0
);

create table tbl_student_subject(
	id bigint unsigned auto_increment primary key,
	student_id bigint unsigned,
	subject_id bigint unsigned,
	constraint fk_student_subject_student foreign key(student_id)
	references tbl_student(id),
	constraint fk_student_subject_subject foreign key(subject_id)
	references tbl_subject(id)
);

alter table tbl_student_subject add subject_grade varchar(255);
alter table tbl_student_subject add subject_status varchar(255);

create table tbl_lecture(
	id bigint unsigned auto_increment primary key,
	professor_id bigint unsigned,
	subject_id bigint unsigned,
	constraint fk_lecture_professor foreign key(professor_id)
	references tbl_professor(id),
	constraint fk_lecture_subject foreign key(subject_id)
	references tbl_subject(id)
);

/*
 * 요구사항 
 * 
 * 대 카테고리, 소 카테고리가 필요해요. 
 * 
 * */
create table tbl_category_a(
	id bigint unsigned auto_increment primary key,
	category_a_name varchar(255) not null,
	category_a_status varchar(255) default 'ENABLE'
);


create table tbl_category_b(
	id bigint unsigned auto_increment primary key,
	category_b_name varchar(255) not null,
	category_status varchar(255) default 'ENABLE',
	category_a_id bigint unsigned,
	constraint category_b_category_a foreign key(category_a_id)
	references tbl_category_a(id)
);


/*
 * 요구 사항
 * 
 * 회의실 예약 서비스를 제작하고 싶습니다.
 * 회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
 * 회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.
 * 
 * */


drop table tbl_order;
drop table tbl_reply;
drop table tbl_post;
drop table tbl_file;
drop table tbl_member;

create table tbl_member(
	id bigint unsigned auto_increment primary key,
	member_type varchar(255) default 'basic',
	member_id varchar(255) unique not null,
	member_password varchar(255) not null
);

create table tbl_office(
	id bigint unsigned auto_increment primary key,
	office_name varchar(255),
	office_location varchar(255)
);

/*파트 타임이 아닐 경우*/
/*
create table tbl_conference_room(
	id bigint unsigned auto_increment primary key,
	start_time datetime,
	end_time datetime,
	office_id bigint unsigned,
	constraint conference_room_office_office foreign key(office_id)
	references tbl_office(id)
);
*/

alter table tbl_conference_room drop start_time;
alter table tbl_conference_room drop end_time;

/*파트 타임일 경우*/
create table tbl_conference_room(
	id bigint unsigned auto_increment primary key,
	office_id bigint unsigned,
	constraint conference_room_office_office foreign key(office_id)
	references tbl_office(id)
);

/*파트 타임일 경우*/
create table tbl_part_time(
	id bigint unsigned auto_increment primary key,
	start_time datetime,
	end_time datetime,
	conference_room_id bigint unsigned,
	constraint part_time_conference_room foreign key(conference_room_id)
	references tbl_conference_room(id)
);

create table tbl_reservation(
	id bigint unsigned auto_increment primary key,
	member_id bigint unsigned,
	conference_room_id bigint unsigned,
	constraint reservation_member foreign key(member_id)
	references tbl_member(id),
	constraint reservation_conference_room foreign key(conference_room_id)
	references tbl_conference_room(id)
);



















