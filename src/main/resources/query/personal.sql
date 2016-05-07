CREATE TABLE B1_PERSONAL (
   PER_ID      VARCHAR2(20) PRIMARY KEY,
   PER_PWD      VARCHAR2(20) NOT NULL,
   PER_NAME   VARCHAR2(20) NOT NULL,
   PER_PHONE   VARCHAR2(15) NOT NULL,
   PER_EMAIL   VARCHAR2(30) NOT NULL,
   PER_ADDRESS   VARCHAR2(100) NOT NULL,
   PER_ZIPCODE   VARCHAR2(10) NOT NULL,
   per_originalfile varchar2(200),   
   per_savedfile varchar2(500),
   PER_EMAILSETTING VARCHAR2(10) default 'agree'
);


--채용정보 관심기업
CREATE TABLE b1_interestRecruiting(
	REC_INDEX NUMBER not null REFERENCES b1_recruiting(rec_index) on delete cascade,
	PER_ID	VARCHAR2(20) NOT NULL REFERENCES B1_PERSONAL(PER_ID) ON DELETE CASCADE
);


--뉴스피드 관심기업
CREATE TABLE b1_interestcom(
   PER_INTERESTCOM VARCHAR2(50) NOT NULL,
   PER_ID   VARCHAR2(20) NOT NULL REFERENCES B1_PERSONAL(PER_ID) ON DELETE CASCADE,
   CONSTRAINT set_uk UNIQUE(PER_INTERESTCOM, PER_ID)
);


create table b1_newsfeed(
   NF_URL VARCHAR2(200) PRIMARY KEY,
   NF_TITLE VARCHAR2(2000) NOT NULL,
   NF_SUBTITLE VARCHAR2(2000),
   NF_DATE VARCHAR2(2000) DEFAULT SYSDATE,
   NF_CONTENT CLOB NOT NULL,
   INPUTDATE DATE DEFAULT SYSDATE,
   PER_INTERESTCOM VARCHAR2(50) NOT NULL
);

alter table b1_newsfeed modify(per_interestcom varchar2(50));

create sequence scrap_seq;

create table b1_scrap(
   SCR_SEQ NUMBER PRIMARY KEY,
   PER_ID VARCHAR2(20) NOT NULL REFERENCES B1_PERSONAL(PER_ID) ON DELETE CASCADE,
   SCR_TITLE VARCHAR2(2000) NOT NULL,
   SCR_SUBTITLE VARCHAR2(2000),
   SCR_DATE VARCHAR2(2000) DEFAULT SYSDATE,
   SCR_CONTENT CLOB NOT NULL
);
CREATE TABLE B1_POSTNUMBER (
   ZIPCODE      VARCHAR2(10) NOT NULL,
   AREA1      VARCHAR2(30),
   AREA2      VARCHAR2(45),
   AREA3      VARCHAR2(150),
   AREA4      VARCHAR2(70) 
);

CREATE TABLE B1_EDUCATION (
   PER_ID         VARCHAR2(20) NOT NULL REFERENCES B1_PERSONAL(PER_ID) ON DELETE CASCADE,
   EDU_STARTDATE   DATE NOT NULL,
   EDU_ENDDATE    DATE NOT NULL,
   EDU_SCNAME      VARCHAR2(50) NOT NULL,
   EDU_MAJOR      VARCHAR2(50) NOT NULL,
   EDU_GRADUATION   VARCHAR2(50)
);   

create table b1_career(
	per_id		varchar2(20) not null references b1_personal(per_id) on delete cascade,
	car_comname	varchar2(50) not null,
	car_startdate	date not null,
	car_enddate		date not null,
	car_department	varchar2(50),
	car_duty	varchar2(100)
);

alter table b1_career modify(car_comname varchar2(50));

create table b1_certificate(
	per_id		varchar2(20) not null references b1_personal(per_id) on delete cascade,
	cer_cername	varchar2(50) not null,
	cer_date	date not null,
	cer_grade	varchar2(30)
);

create table b1_award(
	per_id		varchar2(20) not null references b1_personal(per_id) on delete cascade,
	awa_name	varchar2(50) not null,
	awa_date 	date,
	awa_detail	varchar2(50)
);

create table b1_introduce(
   per_id      varchar2(20) not null references b1_personal(per_id) on delete cascade,
   intro_title   varchar2(100) not null,
   intro_contents   varchar2(3000) not null
);

create table b1_pinboard_per(
	per_id		varchar2(20) not null references b1_personal(per_id) on delete cascade,
	pin_index number primary key,
	pin_date	date not null,
	pin_title	varchar2(50) not null,
	pin_contents varchar2(200) not null
);

create sequence pinboard_seq;

create table b1_reply(
   reply_index number primary key,
   PER_ID	VARCHAR2(20) not null,
   PER_NAME   VARCHAR2(20) NOT NULL,
   reply_content varchar2(2000) not null,
   reply_date date not null,
   SCR_TITLE VARCHAR2(2000) not null,
   per_savedfile varchar2(500)
);

drop table b1_reply

create sequence reply_seq;



drop table b1_pinboard_per;
drop table b1_interestRecruiting;
drop table b1_introduce;
drop table b1_award;
drop table b1_certificate;
drop table b1_career;
drop table b1_scrap;
drop table b1_education;
drop table b1_personal;
drop table b1_interestcom;

delete from b1_newsfeed;
delete from b1_interestcom;

