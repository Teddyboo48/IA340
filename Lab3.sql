-- Create Schema
-- Create tables
CREATE TABLE IF NOT EXISTS professor
(
    p_email VARCHAR(50) NOT NULL,
    p_name VARCHAR(50) NOT NULL,
    office VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY(p_email)
);

CREATE TABLE IF NOT EXISTS student
(
    s_email VARCHAR(50) NOT NULL,
    s_name VARCHAR(50) NOT NULL,
    major VARCHAR(10) NOT NULL,
    PRIMARY KEY(s_email)
);

CREATE TABLE IF NOT EXISTS course
(
    c_number VARCHAR(50) NOT NULL,
    c_name VARCHAR(50) NOT NULL,
    room VARCHAR(10) NOT NULL,
    p_email VARCHAR(50) NOT NULL,
    PRIMARY KEY(c_number)
);

CREATE TABLE IF NOT EXISTS enroll
(
    c_number VARCHAR(50) NOT NULL,
    s_email VARCHAR(50) NOT NULL,
    PRIMARY KEY(c_number, s_email)
);


-- Create FKs
ALTER TABLE course
    ADD    FOREIGN KEY (p_email)
    REFERENCES professor(p_email)
    MATCH SIMPLE
;
   
ALTER TABLE enroll
    ADD    FOREIGN KEY (c_number)
    REFERENCES course(c_number)
    MATCH SIMPLE
;
   
ALTER TABLE enroll
    ADD    FOREIGN KEY (s_email)
    REFERENCES student(s_email)
    MATCH SIMPLE
;
   
-- Create Indexes

-- Q2.1
insert into student(s_email,s_name,major)

values('s1@jmu.edu','s1','IA'),
      ('s2@jmu.edu','s2','IA'),
      ('s3@jmu.edu','s3','ISAT'),
      ('s4@jmu.edu','s4','ISAT')

--Q2.2
insert into public.professor(p_email,p_name,office)
values	('p1@jmu.edu','p1','o1'),
		('p2@jmu.edu','p2','o2')

--Q2.3
insert into course(c_number,c_name,room,p_email)
values	('c1', 'postgresql', 'r1', 'p1@jmu.edu'),
		('c2', 'mongodb', 'r2', 'p2@jmu.edu'),
		('c3', 'twitter', 'r1', 'p1@jmu.edu')

--Q2.4
insert into enroll (s_email, c_number)
values ('s1@jmu.edu','c1'),
	('s2@jmu.edu','c1'),
	('s3@jmu.edu','c1'),
	('s4@jmu.edu','c2'),
	('s2@jmu.edu','c3'),
	('s3@jmu.edu','c3')

--Q2.5
insert into professor (p_email,p_name,office)
values ('p3@jmu.edu','p3','o3')
insert into course (c_number, c_name, room, p_email)
values ('c4','facebook','r1', 'p3@jmu.edu')

--Q2.6
update course 
set p_email='p3@jmu.edu'
where p_email='p1@jmu.edu';

delete from professor
where p_email = 'p1@jmu.edu'

--Q2.7
select * from enroll

--Q2.8
select c_number, count(*) as num_student
from enroll 
group by c_number
order by num_student desc
limit 1;

--Q2.9
select professor.p_name, course.c_name
from professor
inner join course
on professor.p_email = course.p_email

--Q2.10
select p_name, count(*) as count_course
from professor
inner join course
on professor.p_email = course.p_email
group by p_name
order by count_course desc
limit 1;
