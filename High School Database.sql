-- DDL FILE:
CREATE DATABASE IF NOT EXISTS assignment02;
USE assignment02;

DROP TABLE IF EXISTS StandardizedTestingResult;
DROP TABLE IF EXISTS Activity_has_Student;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS PositionHeld_has_student;
DROP TABLE IF EXISTS PositionHeld;
DROP TABLE IF EXISTS Unenrollment;
DROP TABLE IF EXISTS DisciplinaryAction_has_Student;
DROP TABLE IF EXISTS DisciplinaryAction;
DROP TABLE IF EXISTS HigherEducation;
DROP TABLE IF EXISTS Grade;
DROP TABLE IF EXISTS Student_has_Course;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Student_has_Guardian;
DROP TABLE IF EXISTS Guardian;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Address;

CREATE TABLE Address(
	AddressID INT NOT NULL,
    StreetNo INT(5) NOT NULL,
    StreetName VARCHAR(50) NOT NULL,
    PostalCode CHAR(6) NOT NULL,
    CONSTRAINT Address_PK PRIMARY KEY (AddressID)    
);

CREATE TABLE Student (
    StudentID INTEGER NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(1) NOT NULL,
    AcademicYear INTEGER(2) NOT NULL,
    DateEnrolled DATE NOT NULL,
    DateUnenrolled DATE,
    Birthday DATE NOT NULL,
    Address_AddressID INTEGER NOT NULL,    
    CONSTRAINT Student_PK PRIMARY KEY (StudentID),
    CONSTRAINT Student_Address_FK FOREIGN KEY (Address_AddressID) REFERENCES Address(AddressID)
);

 CREATE TABLE Guardian (
    GuardianID INTEGER NOT NULL AUTO_INCREMENT,
    Address_AddressID INTEGER NOT NULL,
    Name VARCHAR(50) NOT NULL,
    PhoneNumber BIGINT NOT NULL,
    BirthDate DATE NOT NULL,    
    CONSTRAINT Guardian_PK PRIMARY KEY (GuardianID),
    CONSTRAINT Guardian_Address_FK FOREIGN KEY (Address_AddressID) REFERENCES Address(AddressID)
);

CREATE TABLE Student_has_Guardian(
	Student_StudentID INT NOT NULL,
    Guardian_ParentID INT NOT NULL,
    CONSTRAINT Student_has_Guardian_PK PRIMARY KEY (Student_StudentID, Guardian_ParentID),
    CONSTRAINT Student_has_Guardian_Student_FK FOREIGN KEY (Student_StudentID) REFERENCES Student(StudentID),
    CONSTRAINT Student_has_Guardian_Guardian_FK FOREIGN KEY (Guardian_ParentID) REFERENCES Guardian(GuardianID)
);

CREATE TABLE Teacher(
	TeacherID INT NOT NULL,
    TeacherName VARCHAR(50) NOT NULL,
    HomeRoomLocation VARCHAR(50) NOT NULL,
    CONSTRAINT Teacher_PK PRIMARY KEY (TeacherID)
);

CREATE TABLE Course (
    CourseID INTEGER NOT NULL AUTO_INCREMENT,
    Teacher_TeacherID INTEGER NOT NULL,
    CourseName VARCHAR(50) NOT NULL,
    CourseLocation INTEGER(4) NOT NULL,    
    CONSTRAINT Course_PK PRIMARY KEY (CourseID),
    CONSTRAINT Course_Teacher_FK FOREIGN KEY (Teacher_TeacherID) REFERENCES Teacher(TeacherID)
);

CREATE TABLE Student_has_Course (
	Student_StudentID INT NOT NULL,
    Course_CourseID INT NOT NULL,
    CONSTRAINT Student_has_Course_PK PRIMARY KEY (Student_StudentID, Course_CourseID),
    CONSTRAINT Student_has_Course_Student_FK FOREIGN KEY (Student_StudentID) REFERENCES Student(StudentID),
    CONSTRAINT Student_has_Course_Course_FK FOREIGN KEY (Course_CourseID) REFERENCES COURSE(CourseID)
);

CREATE TABLE Grade (
  Student_StudentId INT NOT NULL,
  Course_CourseID INT NOT NULL,
  GradingPeriod INT(1) NOT NULL,
  Grade INT(3) NULL,
  CONSTRAINT Grade_PK PRIMARY KEY (Student_StudentId, Course_CourseID, GradingPeriod),
  CONSTRAINT Grade_Student_FK FOREIGN KEY (Student_StudentId) REFERENCES Student (StudentID),
  CONSTRAINT Grade_Course_FK FOREIGN KEY (Course_CourseID) REFERENCES Course (CourseID)
);

CREATE TABLE HigherEducation (
    Student_StudentID INTEGER NOT NULL,
    HigherEducationID INTEGER NOT NULL AUTO_INCREMENT,
    ApplicationDate DATE,
    ApplicationResult VARCHAR(50),
    OfferAccepted VARCHAR(5),    
    CONSTRAINT HigherEducation_PK PRIMARY KEY (HigherEducationID),
    CONSTRAINT HigherEducation_Student_FK FOREIGN KEY (Student_StudentID) REFERENCES Student(StudentID)
);

CREATE TABLE DisciplinaryAction(
	IncidentID INT NOT NULL,
	IncidentDate DATE NOT NULL,
	IncidentType VARCHAR(50),
	DisciplinaryAction VARCHAR(50),
	CONSTRAINT DisciplinaryActionPK PRIMARY KEY(IncidentID)
);

CREATE TABLE DisciplinaryAction_has_Student(
	DisciplinaryAction_IncidentID INT NOT NULL,
    Student_StudentID INT NOT NULL,
    CONSTRAINT DisciplinaryAction_has_Student_PK PRIMARY KEY (DisciplinaryAction_IncidentID, Student_StudentID),
    CONSTRAINT DisciplinaryAction_has_Student_DisciplinaryAction_FK FOREIGN KEY (DisciplinaryAction_IncidentID) REFERENCES DisciplinaryAction (IncidentId),
    CONSTRAINT DisciplinaryAction_has_Student_Student_FK FOREIGN KEY (Student_StudentID) REFERENCES Student (StudentID)
  );
  
CREATE TABLE Unenrollment(
	UnenrollmentID INT NOT NULL,
    Student_StudentID INT NOT NULL,
    Reason VARCHAR(50) NOT NULL,
    UnenrollmentDate DATE NOT NULL,
	CONSTRAINT UnenrollmentPK PRIMARY KEY(UnenrollmentID),
	CONSTRAINT Unenrollment_Student_FK FOREIGN KEY(Student_StudentID) REFERENCES Student(StudentID)
	ON UPDATE NO ACTION
	ON DELETE CASCADE
);

CREATE TABLE PositionHeld(
	PositionID INT NOT NULL,
	NAME VARCHAR(45) NOT NULL,
	CONSTRAINT PositionHeldPK PRIMARY KEY(PositionID)
);

CREATE TABLE PositionHeld_has_student(
	PositionHeld_PositionID INT NOT NULL,
	Student_StudentID INT NOT NULL,
	CONSTRAINT PositionHeld_has_student_PositionHeld_FK FOREIGN KEY(PositionHeld_PositionID) REFERENCES PositionHeld(PositionID),
	CONSTRAINT PositionHeld_has_student_Student FOREIGN KEY(Student_StudentID) REFERENCES Student(StudentID)
);

CREATE TABLE Activity(
	ActivityID INT NOT NULL,
	ActivityName VARCHAR(50) NOT NULL,
	CONSTRAINT ActivityPK PRIMARY KEY(ActivityID)
);

CREATE TABLE Activity_has_Student(
	Activity_ActivityID INT NOT NULL,
	Student_StudentID INT NOT NULL,
	CONSTRAINT Activity_has_Student_Activity_FK FOREIGN KEY(Activity_ActivityID) REFERENCES Activity(ActivityID),
	CONSTRAINT Activity_has_Student_Student_FK FOREIGN KEY(Student_StudentID) REFERENCES Student(StudentID)
);

CREATE TABLE StandardizedTestingResult (
    TestID INTEGER NOT NULL AUTO_INCREMENT,
    Student_StudentID INT NOT NULL,
    TestName VARCHAR(50) NOT NULL,
    TestDate DATE NOT NULL,
    TestResult INT(3),    
    CONSTRAINT StandardizedTestingResult_PK PRIMARY KEY (TestID),
    CONSTRAINT StandardizedTestingResult_Student_FK FOREIGN KEY (Student_StudentID) REFERENCES Student(StudentID)
); 

-- DML FILE:
INSERT INTO Address (AddressID, StreetNo, StreetName, PostalCode)
VALUES
	(1,7188,"Non St.","E2H2C5"),
	(2,2394,"Libero. Ave","H3H8L2"),
	(3,4970,"Pede Street","M3E7K0"),
	(4,2240,"Nec Av.","B1H6R4"),
	(5,2503,"Laoreet Rd.","M7L2X7"),
	(6,9643,"Vitae, Av.","T4W7T7"),
	(7,182,"A Ave","Y9A9J7"),
	(8,9010,"Ipsum Avenue","m3C1Y4"),
	(9,8702,"Auctor. Rd.","B5X6X6"),
	(10,8220,"Erat Av.","Y2L7T5");
  
INSERT INTO Student(FirstName, LastName, Gender, AcademicYear, DateEnrolled, DateUnenrolled, Birthday,Address_AddressID)
VALUES 
	("Bob", "Smith", 'M', 22, "2019-09-06", NULL, "2007-02-13", 1),
	("Rebecca", "Smith", 'F', 22, "2018-10-07", NULL, "2006-09-11", 2),
	("Jim", "Bob", 'M', 21, "2017-09-07", "2021-06-24", "2005-12-13", 3),
	("Joseph", "MacDonald", 'M', 22, "2020-09-05", NULL, "2008-11-01", 4),
	("Emily", "McIntyre", 'F', 20, "2016-09-08", "2020-06-27", "2004-02-13", 5),
	("Zoe", "Boudreau", 'F', 22, "2021-09-05", NULL, "2009-12-13", 6),
	("Cassandra", "Johnson", 'F', 22, "2022-09-07", NULL, "2010-06-02", 7),
	("Billy", "Johnson", 'M', 22, "2022-09-07", NULL, "2010-06-02", 8),
	("George", "Jones", 'M', 22, "2019-09-07", NULL, "2007-10-25", 9),
	("Tony", "Miller", 'M', 22, "2022-09-07", NULL, "2010-12-09", 10);

INSERT INTO Guardian(Address_AddressID, Name, PhoneNumber, Birthdate)
VALUES 
	(1, "Rebecca Johnson", 6132679812, "1966-01-23"),
	(2, "Tony Jefferson",6135556712, "1978-12-24"),
	(3, "Jim Davis",6139990909, "1981-12-04"),
	(4, "George McIntyre",6132123145, "1964-12-04"),
	(5, "Cameron Michaels",6138672211, "1990-01-12"),
	(6, "Jessa Jeffries",6139177786, "1976-07-12"),
	(7, "Michael Davids",6131112146, "1982-12-09"),
	(8, "Billy Bob",6135618720, "1962-01-14"),
	(9, "John Johnson",6130902310, "1993-12-05"),
	(10, "Emily Sawyer",6138887261, "1959-06-28");

INSERT INTO Student_has_Guardian (Student_StudentID, Guardian_ParentID)
VALUES 
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7),
	(8, 8),
	(9, 9),
	(10, 10);

INSERT INTO Teacher (TeacherID,TeacherName,HomeRoomLocation)
VALUES
	(1,"Catherine Nicholson","1201,"),
	(2,"Gregory Carter","0921,"),
	(3,"Hoyt Garza","0021,"),
	(4,"Damon Solis","0202,"),
	(5,"Aline Morrow","1212,"),
	(6,"Althea Holloway","0015,"),
	(7,"Dustin Peterson","0089,"),
	(8,"Imelda Jordan","01294,"),
	(9,"Lisandra Deleon","0921,"),
	(10,"Addison Robles","2210,");


INSERT INTO Course(Teacher_TeacherID, CourseName, CourseLocation)
VALUES 
	(1, "Calculus", 1201),
	(2, "Physics", 0921),
	(3, "English", 0021),
	(4, "French", 0202),
	(5, "Calculus II", 1212),
	(6, "English", 0015),
	(7, "French", 0089),
	(8, "Calculus", 01294),
	(9, "French", 0921),
	(10, "English", 2210);

INSERT INTO Student_has_Course (Student_StudentID,Course_CourseID)
VALUES
  (1,1),
  (2,2),
  (3,3),
  (4,4),
  (5,5),
  (6,6),
  (7,7),
  (8,8),
  (9,9),
  (10,10);

INSERT INTO Grade (Student_StudentId, Course_CourseID, GradingPeriod, Grade)
VALUES
	(1,1,2,24),
	(2,2,1,79),
	(3,3,2,1),
	(4,4,3,11),
	(5,5,2,53),
	(6,6,2,20),
	(7,7,2,100),
	(8,8,3,23),
	(9,9,3,45),
	(10,10,1,10);
    
    -- HIGHER ED
INSERT INTO HigherEducation(Student_StudentID, ApplicationDate, ApplicationResult, OfferAccepted) 
VALUES 
	(1, "2022-11-12", NULL, NULL),
	(2, "2022-09-22", "accepted", "yes"),
	(3, NULL, NULL, NULL),
	(4, "2021-07-12", "accepted", "no"),
	(5, "2020-02-25", "rejected", "no"),
	(6, "2020-02-25", "accepted", "no"),
	(7, "2022-11-24", "accepted", NULL),
	(8, "2019-11-12", "accepted", "yes"),
	(9, "2018-03-27", "accepted", "no"),
	(10,"2022-03-22", NULL, NULL);

INSERT INTO DisciplinaryAction(IncidentID, IncidentDate, IncidentType, DisciplinaryAction) 
VALUES
	(01, 20220101, 'tardiness', 'warning'),
	(02, 20220102, 'violence', 'expulsion'),
	(03, 20220103, 'smoking', 'calling their parents'),
	(04, 20220104, 'absence', 'calling their parents'),
	(05, 20220105, 'verbal abuse', 'suspension'),
	(06, 20220106, 'sleeping', 'warning'),
	(07, 20220107, 'being disruptive', 'warning'),
	(08, 20220108, 'inappropriate clothing', 'suspension'),
	(09, 20220109, 'drinking', 'calling their parents'),
	(10, 20220110, 'damaging school property', 'fine');

INSERT INTO DisciplinaryAction_has_Student (DisciplinaryAction_IncidentID, Student_StudentID)
VALUES 
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1);

INSERT INTO Unenrollment(UnenrollmentID, Reason, UnenrollmentDate, Student_StudentID) 
VALUES
  (1,"Expelled,","2022-12-01", 1),
  (2,"Graduated,","2021-12-01", 2),
  (3,"Graduated,","2022-10-17", 3),
  (4,"Graduated,","2021-01-12", 4),
  (5,"Expelled,","2021-03-09", 5),
  (6,"Transferred,","2021-12-12", 6),
  (7,"Expelled,","2022-10-09", 7),
  (8,"Deceased,","2021-09-11", 8),
  (9,"Transferred,","2022-11-16", 9),
  (10,"Expelled,","2022-11-16", 10);

INSERT INTO PositionHeld(PositionID, Name) 
VALUES
	(1,'Class President'),
	(2,'Treasurer'),
	(3,'Event Coordinator'),
	(4,'Fundraising Lead'),
	(5,'Basketball Captain'),
	(6,'Chess Club President'),
	(7,'Board Game Club Presient'),
	(8,'D&D Club President'),
	(9,'Track and Field Captain'),
	(10,'Head Cheerleader');

INSERT INTO PositionHeld_has_student(PositionHeld_PositionID, Student_StudentID) 
VALUES
	(01,01),
	(02,02),
	(03,03),
	(04,04),
	(05,05),
	(06,06),
	(07,07),
	(08,08),
	(09,09),
	(10,10);

INSERT INTO Activity(ActivityID, ActivityName) 
VALUES
	(01,'football'),
	(02,'guitar'),
	(03,'piano'),
	(04,'dance'),
	(05,'basketball'),
	(06,'baseball'),
	(07,'art'),
	(08,'swimming'),
	(09,'bowling'),
	(10,'photography');

INSERT INTO Activity_has_Student (Activity_ActivityID, Student_StudentID) 
VALUES
	(01,01),
	(02,02),
	(03,03),
	(04,04),
	(05,05),
	(06,06),
	(07,07),
	(08,08),
	(09,09),
	(10,10);

INSERT INTO StandardizedTestingResult(Student_StudentID, TestName, TestDate, TestResult)
VALUES 
  (1, "Math", "2022-02-19", 87),
  (2, "English", "2021-12-19", 23),
  (3, "Science", "2019-01-09", 75),
  (4, "Math", "2022-09-03", 74),
  (5, "French", "2022-12-05", 82),
  (6, "English", "2018-04-17", 99),
  (7, "Science", "2019-03-10", 42),
  (8, "Geography", "2018-01-12", 78),
  (9, "Geography", "2020-11-10", 100),
  (10, "English", "2022-01-12", 78);
  
  -- QUERIES:
-- 1: A simple query that pulls all columns and rows from a table
SELECT * FROM student;
  
-- 2: A query to display a subset of columns
SELECT StudentID, FirstName, LastName FROM Student;

-- query 3, A query that displays a subset of columns with a single clause (predicate) WHERE statement
SELECT IncidentDate, IncidentType
FROM DisciplinaryAction
WHERE IncidentType = 'violence';

-- 4: A query that displays a subset of columns with a multi-clause(predicate)WHERE statement using AND/OR
SELECT *
FROM student
WHERE gender="F" AND AcademicYear > 20;

-- 5: A query to join 2 tables
SELECT * FROM Student NATURAL JOIN Guardian;

-- 6: A query that performs a multi-table join. In other words, you are joining 3 or more tables
SELECT d.IncidentID, d.DisciplinaryAction, p.PositionID, p.name, a.ActivityID, a.ActivityName
FROM DisciplinaryAction d
JOIN PositionHeld p ON d.IncidentID = p.PositionID
JOIN Activity a ON p.PositionID=a.ActivityID; 

-- 7: A query that performs an aggregate (count, min, max, sum, avg, etc.). (David)
SELECT AVG(Grade)
FROM grade;

-- 8: A query that performs an aggregate with a group by
SELECT AVG(TestResult), TestName FROM StandardizedTestingResult 
GROUP BY TestName;

-- 9: A query that performs an aggregate (count, min, max, sum, avg, etc.). with a GROUP BY and a HAVING clause
select TestID, TestName, max(TestResult) from StandardizedTestingResult group by TestName having count(TestID)<10;

-- 10: A query that performs a subquery either as part of the WHERE clause or as a derived/virtual table.(David)
SELECT grade
FROM grade
WHERE (Student_StudentId = (SELECT StudentID FROM student WHERE FirstName = "Bob"));

-- 11. A query that performs an aggregate with a join and a group by.
SELECT s.StudentID, d.DisciplinaryAction, COUNT(FirstName) AS student
FROM Student s
JOIN DisciplinaryAction d
ON s.StudentID = d.IncidentID
GROUP BY d.DisciplinaryAction;

-- views

-- A dynamic view for query 4 in the previous task
CREATE VIEW dynamic_view1 AS
SELECT *
FROM student
WHERE gender="F" AND AcademicYear > 20;

select * from dynamic_view2;

 -- view 2, A materialized view for query 9 in the previous task
drop view if exists dynamic_view2;
CREATE VIEW dynamic_view2 AS
select TestID, TestName, max(TestResult) 
from StandardizedTestingResult
group by TestName
having count(TestID)<10;

select * from dynamic_view2;
