
DROP TABLE enrollment;
DROP TABLE course;
DROP TABLE student;

CREATE TABLE student(
    studentID INTEGER, 
    name VARCHAR(50), 
    age INTEGER, 
    department VARCHAR(10),
    PRIMARY KEY(studentID)
);

CREATE TABLE course(
  courseID INTEGER,
  course VARCHAR(50),
  credits INTEGER,
  PRIMARY KEY(courseID)
); 


CREATE TABLE enrollment(
  eID INTEGER, 
  sID INTEGER,
  cID INTEGER,
  grade INTEGER,
  FOREIGN KEY (sID) REFERENCES student(studentID),
  FOREIGN KEY (cID) REFERENCES course(courseID)
);  

INSERT INTO student  (studentID, name, age, department)
VALUES (12345678, 'Dave', 20, 'math'); 
INSERT INTO student  (studentID, name, age, department)
VALUES (23456789, 'Bob', 20, 'sci'); 

INSERT INTO course (courseID, course, credits)
VALUES (87654321, 'CALC 2', 4); 
INSERT INTO course (courseID, course, credits)
VALUES (98765432, 'CHEM', 4); 

INSERT INTO enrollment (eID, sID, cID, grade)
VALUES (13572468, 12345678, 87654321, 83);
INSERT INTO enrollment (eID, sID, cID, grade)
VALUES (13572468, 23456789, 98765432, 83);

SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM enrollment;

SELECT student.name, course.course FROM enrollment
INNER JOIN student ON student.studentid = enrollment.sid
INNER JOIN course  ON course.courseid = enrollment.cid;

INSERT INTO course (courseID, course, credits)
VALUES (12121212, 'BIO', 4);

SELECT student.name, course.course
FROM enrollment
LEFT JOIN student ON student.studentID = enrollment.sID
LEFT JOIN course  ON course.courseID = enrollment.cID

UNION

-- RIGHT JOIN part: All rows from enrollment that might be missed in the LEFT JOIN (if any)
SELECT student.name, course.course
FROM enrollment
RIGHT JOIN student ON student.studentID = enrollment.sID
RIGHT JOIN course  ON course.courseID = enrollment.cID;