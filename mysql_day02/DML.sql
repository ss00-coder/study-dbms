use study;

create table tbl_member(
	id bigint unsigned auto_increment primary key,
	member_id varchar(255) not null unique,
	member_password varchar(255) not null,
	member_email varchar(255) not null unique,
	member_birth date
);


create table tbl_product(
	id bigint unsigned auto_increment primary key,
	product_name varchar(255) not null,
	product_price int default 0,
	product_stock int default 0
);

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

insert into tbl_order(member_id)
values(1);

select * from tbl_order;

/*상품을 1개 추가하고, 1번 회원의 주문 정보 중 추가된 상품의 번호로 수정하기*/
insert into tbl_product
(product_name, product_price, product_stock)
values('마우스', 35000, 60);

select * from tbl_product;

update tbl_order
set product_id = 1
where id = 1;
/*where product_id is null;*//*안돼요!*/


select id, member_id, member_password, member_email, member_birth from tbl_member;
select * from tbl_member;

insert into tbl_member (member_id, member_password, member_email, member_birth)
values('hds1234', '1234', 'tedhan1204@gmail.com', str_to_date('2000-12-04', '%Y-%m-%d'));

/*문자열을 date타입의 컬럼에 추가할 때에는 자동 형변환된다.*/
insert into tbl_member (member_id, member_password, member_email, member_birth)
values('hgd9876', '9999', 'hgd1234@gmail.com','2010-05-05');

update tbl_member
set member_email = 'dev.tedhan@gmail.com'
where id = 1;

delete from tbl_member
where id = 2;
/******************************************************************************************/
drop table tbl_member;
drop table tbl_product;
drop table tbl_order;

create table tbl_member(
	id bigint unsigned auto_increment primary key,
	member_id varchar(255) not null unique,
	member_password varchar(255) not null,
	member_email varchar(255) not null unique,
	member_birth date
);

create table tbl_post(
	id bigint unsigned auto_increment primary key,
	post_title varchar(255) not null,
	post_content varchar(255) not null,
	member_id bigint unsigned,
	constraint fk_post_member foreign key(member_id)
	references tbl_member(id)
);

/*댓글에 게시글 번호 FK로 추가하기*/
create table tbl_reply(
	id bigint unsigned auto_increment primary key,
	reply_content varchar(255) not null,
	member_id bigint unsigned,
	post_id bigint unsigned,
	constraint fk_reply_member foreign key(member_id)
	references tbl_member(id),
	constraint fk_reply_post foreign key(post_id)
	references tbl_post(id)
);

alter table tbl_reply add post_id bigint unsigned;

alter table tbl_reply add constraint fk_reply_post foreign key(post_id)
references tbl_post(id);

/*회원가입 하기*/
select * from tbl_member;

insert into tbl_member(member_id, member_password, member_email, member_birth)
values('hds1234', '1234', 'tedhan1204@gmail.com', '2000-12-04');

/*게시글을 한 개 추가하기*/
select * from tbl_post;
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);

/*추가된 게시글에 댓글 2개 작성하기*/
select * from tbl_reply;
insert into tbl_reply(reply_content, member_id)
values('댓글 테스트2', 1);

update tbl_reply
set post_id = 1
where post_id is null;

/*회원 정보 중 아이디 수정하기*/
update tbl_member
set member_id = 'hgd1234'
where id = 1;

select * from tbl_member;

/*1개 게시글의 제목 수정하기*/
update tbl_post
set post_title = '수정된 제목'
where id = 1;

select * from tbl_post;

/*1개 게시글의 모든 댓글의 내용을 같은 내용으로 수정하기*/
update tbl_reply
set reply_content = '수정된 내용'
where post_id = 1;

select * from tbl_reply;
/*****************************************************************/
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

select * from tbl_member;

/*사용자의 프로필 사진을 3개 추가한다.*/
INSERT INTO tbl_file
(file_name, file_uuid, file_path, file_represent, member_id)
VALUES('전성기.png', 'fjiodsk_fdu67kol_3128', '2023/07/07', 'NO', 1);

INSERT INTO tbl_file
(file_name, file_uuid, file_path, file_represent, member_id)
VALUES('전성기2.png', 'fjiodsk_fdskol_3128', '2023/07/06', 'YES', 1);

INSERT INTO tbl_file
(file_name, file_uuid, file_path, file_represent, member_id)
VALUES('전성기3.png', 'fjiodsk_fdnbvnskol_3128', '2023/07/06', 'NO', 1);

select * from tbl_member;
select * from tbl_file;

/*사용자의 프로필 사진 중 대표 이미지를 모두 가져오기*/
select * from tbl_file
where file_represent = 'YES';

/*2번 프로필 사진의 회원번호를 알아내서*/
select * from tbl_file
where id = 2;

/*프로필 사진의 주인 정보를 조회하기*/
select * from tbl_member
where id = 1;

/*다른 이미지를 대표로 설정하기(1번 회원)*/
select * from tbl_file;

update tbl_file
set file_represent = 'YES'
where id = 1;

update tbl_file
set file_represent = 'NO'
where id = 2;

/*대표 이미지가 아닌 이미지를 파일의 이름으로 삭제하기(1번 회원)*/

select * from tbl_file;

delete from tbl_file
where file_represent = 'NO' AND file_name = '전성기2.png';
/********************************************************************/
/* alias: 별칭*/
/* select절, from절에서 사용가능*/
/* select 컬럼명 as 별칭 from 테이블명*/
/* select 컬럼명 별칭 from 테이블명*/
select concat('아이디는 ', m.member_id) as intro from tbl_member m;

/* like: 포함된 문자열 값을 찾고, 문자의 개수도 제한을 줄 수 있다.*/
/* %: 모든 것*/
/* _: 글자 수*/

/*
 * -- 예시
 * '%A': A로 끝나는 모든 값(SDNMFKLSMA, 123NHFUA)
 * 'A%': A로 시작하는 모든 값(APPLE1234, APP)
 * 'A__': A로 시작하면서 3글자인 값(ABC, ACE)
 * 'A_': A로 시작하면 2글자인 값
 * '%A%': A가 포함된 값(ABC, BAC, BCA)
 * */

create table tbl_student(
	id bigint unsigned auto_increment primary key,
	student_name varchar(255) not null,
	student_major varchar(255) not null,
	student_level int default 1
);

INSERT INTO tbl_student
(student_name, student_major, student_level)
VALUES('한동석', '컴퓨터 공학', 1);

INSERT INTO tbl_student
(student_name, student_major, student_level)
VALUES('홍길동', '전자 공학', 2);

INSERT INTO tbl_student
(student_name, student_major, student_level)
VALUES('이순신', '의류 패션', 2);

insert into tbl_student
(student_name, student_major, student_level)
(select student_name, student_major, student_level from tbl_student);

select * from tbl_student
where student_major like '%공학%';

select * from tbl_student
where student_major like '____공학'

/*학생 이름 중에서 홍씨 찾기*/
select * from tbl_student
where student_name like '홍%';

/*집계 함수*/
/*결과가 1개 나온다.*/
/*
 * avg()
 * max()
 * min()
 * sum()
 * count()
 * 
 * */
create table tbl_subject(
	id bigint unsigned auto_increment primary key,
	subject_name varchar(255) not null,
	subject_score int default 0
);

INSERT INTO tbl_subject
(subject_name, subject_score)
VALUES('정보와 윤리', 10);

INSERT INTO tbl_subject
(subject_name, subject_score)
VALUES('산업혁명의 대가', 5);

INSERT INTO tbl_subject
(subject_name, subject_score)
VALUES('현대미술의 암기', 7);

INSERT INTO tbl_subject
(subject_name, subject_score)
VALUES('사회적 의존관계 수립', 8);

select * from tbl_subject;

select 
avg(subject_score) as "average",
sum(subject_score) as "total",
max(subject_score) as "max",
min(subject_score) as "min",
count(subject_score) as "count"
from tbl_subject;

/*수강 신청 테이블*/
create table tbl_student_subject(
	id bigint unsigned auto_increment primary key,
	subject_grade varchar(255),
	subject_status varchar(255),
	student_id bigint unsigned,
	subject_id bigint unsigned,
	constraint fk_student_subject_student foreign key(student_id)
	references tbl_student(id),
	constraint fk_student_subject_subject foreign key(subject_id)
	references tbl_subject(id)
);

alter table tbl_student_subject change subject_grade subject_grade int;
alter table tbl_student_subject change subject_status subject_status varchar(255) default 'DONE';

select * from tbl_student;
select * from tbl_subject;

/*수강 완료한 학생들 정보 추가*/
insert into tbl_student_subject
(subject_grade, student_id, subject_id)
values(50, 5, 3);

insert into tbl_student_subject
(subject_grade, student_id, subject_id)
values(70, 44, 1);

insert into tbl_student_subject
(subject_grade, student_id, subject_id)
values(100, 32, 2);

insert into tbl_student_subject
(subject_grade, student_id, subject_id)
values(100, 324, 1);

insert into tbl_student_subject
(subject_grade, student_id, subject_id)
values(99, 34, 4);

insert into tbl_student_subject
(subject_grade, student_id, subject_id)
values(100, 214, 3);

select * from tbl_student_subject;

/*총 점수*/
select sum(subject_grade) "sum" from tbl_student_subject;

/*평균 점수*/
select avg(subject_grade) "sum" 
from tbl_student_subject
where subject_id = 1;

/*수강 신청한 학생 수*/
select count(id) "count" 
from tbl_student_subject
where subject_id = 4;

/*
 * group by: 묶을 때 사용(~별)
 * 
 * group by 컬럼명 having 조건식
 * 
 * */
select subject_id, count(id) "count" 
from tbl_student_subject
group by subject_id;


select * from tbl_subject;
select * from tbl_student_subject;

/*
 * group by 후 전체 조회 시
 * 중복된 데이터는 가장 먼저 찾은 데이터로 조회된다.
 * */

/*
 * 중복된 데이터가 있는 컬럼에 group by를 사용하면
 * 중복이 제거되면서 종류별로 하나씩 가져온다.
 * 중복된 데이터에 대한 집계 함수를 사용해야할 경우
 * group by에 컬럼명을 작성하고, select절에 group by된 컬럼명 + 집계함수를 사용한다.
 * 
 * */
select * from tbl_student_subject
group by student_id;

select student_id, subject_id from tbl_student_subject
group by student_id, subject_id;

select student_id, count(student_id) from tbl_student_subject
group by student_id;

select student_id, avg(subject_grade) average from tbl_student_subject
group by student_id;

select subject_id, count(student_id) from tbl_student_subject
group by subject_id;

/*where절에서는 집계함수 사용 불가*/
/*where avg(subject_grade) > 70*/

/*과목별 평균 점수가 70초과인 학생들의 수*/
select subject_id, count(student_id), avg(subject_grade) from tbl_student_subject
group by subject_id
having avg(subject_grade) > 70;

/**********************************************************************/
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

insert into tbl_member(member_id, member_password)
values('hds', '1234');

insert into tbl_member(member_id, member_password)
values('hgd', '1234');

insert into tbl_member(member_id, member_password)
values('lss', '1234');

select * from tbl_member;

create table tbl_office(
	id bigint unsigned auto_increment primary key,
	office_name varchar(255),
	office_location varchar(255)
);

insert into tbl_office(office_name, office_location)
values('강남점', '강남구');

insert into tbl_office(office_name, office_location)
values('노원점', '노원구');

insert into tbl_office(office_name, office_location)
values('분당점', '분당');

insert into tbl_office(office_name, office_location)
values('인천점', '인천');

select * from tbl_office;

create table tbl_conference_room(
	id bigint unsigned auto_increment primary key,
	office_id bigint unsigned,
	constraint conference_room_office_office foreign key(office_id)
	references tbl_office(id)
);

insert into tbl_conference_room
(office_id)
values (4);

select * from tbl_conference_room;

create table tbl_part_time(
	id bigint unsigned auto_increment primary key,
	start_time datetime,
	end_time datetime,
	conference_room_id bigint unsigned,
	constraint part_time_conference_room foreign key(conference_room_id)
	references tbl_conference_room(id)
);

alter table tbl_part_time change start_time start_time time;
alter table tbl_part_time change end_time end_time time;

insert into tbl_part_time
(start_time, end_time, conference_room_id)
values('11:00:00', '12:00:00', 11);
insert into tbl_part_time
(start_time, end_time, conference_room_id)
values('11:00:00', '12:00:00', 1);
insert into tbl_part_time
(start_time, end_time, conference_room_id)
values('11:00:00', '12:00:00', 9);
insert into tbl_part_time
(start_time, end_time, conference_room_id)
values('16:00:00', '18:00:00', 7);

select * from tbl_part_time;

/*시작 시간별 회의실 개수*/
select start_time, end_time, count(conference_room_id) from tbl_part_time
group by start_time, end_time;

select current_time  from dual;

create table tbl_reservation(
	id bigint unsigned auto_increment primary key,
	member_id bigint unsigned,
	conference_room_id bigint unsigned,
	constraint reservation_member foreign key(member_id)
	references tbl_member(id),
	constraint reservation_conference_room foreign key(conference_room_id)
	references tbl_conference_room(id)
);

select * from tbl_member;
select * from tbl_conference_room;

insert into tbl_reservation
(member_id, conference_room_id)
values(3, 7);

/*회의실 별 등록 인원 수*/
select conference_room_id, count(member_id) from tbl_reservation
group by conference_room_id;

/*회의실 별 등록 인원 수가 2명이 넘는 회의실 조회*/
select conference_room_id, count(member_id) from tbl_reservation
group by conference_room_id
having count(member_id) > 2;








