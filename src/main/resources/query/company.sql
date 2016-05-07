drop table B1_company;
drop table B1_comnum;
drop table B1_recruiting;

select count(*) from B1_NEWSFEED;
--343


create table B1_company(
	com_id			varchar2(20) primary key,
	com_pwd			varchar2(20) not null,
	com_num			number(10) 	 not null,
	com_name		varchar2(50) not null,
	com_mgrName		varchar2(30) not null,
	com_zipcode		varchar2(10) not null,
	com_address		varchar2(100)not null,
	com_phone		varchar2(15) not null,
	com_email		varchar2(30) not null
);

alter table B1_company modify(com_name varchar2(50));


create table B1_comnum(
	com_num		number(10) primary key
);

create table B1_recruiting(
	com_id			varchar2(20) not null references B1_company(com_id) on delete cascade,
	rec_index 		number primary key,
	rec_duty		varchar2(100) not null,
	rec_requirement varchar2(300) not null,
	rec_memnum		varchar2(20) not null,
	rec_location	varchar2(20) not null,
	rec_day			varchar2(20) not null,
	rec_department	varchar2(20) not null,
	rec_salary		varchar2(20) not null,
	rec_position	varchar2(20) not null,
	rec_welfare		varchar2(300) not null,
	rec_procedure	varchar2(100) not null,
	rec_docs		varchar2(200) not null,
	rec_submitway	varchar2(100) not null,
	rec_startdate	date not null,
	rec_enddate		date not null,
	rec_originalfile varchar2(200),
	rec_savedfile varchar2(500)
);

create sequence rec_index_seq;

create table b1_pinboard_com(
	com_id		varchar2(20) not null references B1_company(com_id) on delete cascade,
	pin_index number primary key,
	pin_date	date not null,
	pin_title	varchar2(50) not null,
	pin_contents varchar2(200) not null
);

create sequence pinboard_seq2;

create table b1_applylist(
	rec_index number not null,
	per_id varchar2(20) not null references B1_personal(per_id) on delete cascade
);

desc B1_APPLYLIST;

create table b1_comnameList(
   comname varchar2(40) primary key,
   dartcode varchar2(14)
);

--comnameList테이블 생성전에
set define off;
--실행하고 생성하기

select count(*) from b1_comnameList;
