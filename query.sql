-- PostgreSQL

CREATE TABLE Student
(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    sex VARCHAR(1)
);

INSERT INTO Student (first_name, last_name, birth_date, sex)
VALUES
    ('Петя', 'Васечкин', '2010-05-14', 'M'),
    ('Юля', 'Петрова', '2011-01-01', 'F'),
    ('Гена', 'Ватрушкин', '2010-12-22', 'M'),
    ('Маша', 'Фролова', '2010-08-29', 'F');


CREATE TABLE Classroom
(
    id SERIAL PRIMARY KEY,
    classroom_name VARCHAR(50),
    capacity INT
);

INSERT INTO Classroom (classroom_name, capacity)
VALUES
    ('101', 30),
    ('102', 30),
    ('103a', 20),
    ('103b', 15);

CREATE TABLE Desk
(
    id SERIAL PRIMARY KEY,
    number INT,
    line INT,
    variant INT
);

INSERT INTO Desk (number, line, variant)
VALUES
    (1, 1, 1),
    (2, 1, 1),
    (3, 1, 1),
    (4, 2, 2),
    (5, 2, 2),
    (6, 2, 2);

CREATE TABLE Lesson
(
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Student(id),
    classroom_id INT REFERENCES Classroom(id),
    desk_id INT REFERENCES Desk(id),
    start_time TIMESTAMP,
    end_time TIMESTAMP
);

INSERT INTO Lesson (student_id, classroom_id, desk_id, start_time, end_time)
VALUES
    (1, 3, 1, '2023-09-01 08:30:00+3', '2023-09-01 09:15:00+3'),
    (2, 3, 2, '2023-09-01 08:30:00+3', '2023-09-01 09:15:00+3'),
    (3, 3, 5, '2023-09-01 08:30:00+3', '2023-09-01 09:15:00+3'),
    (4, 3, 6, '2023-09-01 08:30:00+3', '2023-09-01 09:15:00+3'),

    (1, 1, 1, '2023-09-02 08:30:00+3', '2023-09-02 09:15:00+3'),
    (2, 1, 2, '2023-09-02 08:30:00+3', '2023-09-02 09:15:00+3'),
    (3, 1, 3, '2023-09-02 08:30:00+3', '2023-09-02 09:15:00+3'),
    (4, 1, 4, '2023-09-02 08:30:00+3', '2023-09-02 09:15:00+3');


SELECT s.first_name, s.last_name, l.start_time, l.end_time FROM student s
JOIN lesson l ON s.id=l.student_id
JOIN classroom c ON l.classroom_id=c.id
JOIN desk d ON l.desk_id=d.id
WHERE c.classroom_name='103a'
AND d.number=6;

--  first_name | last_name |     start_time      |      end_time       
-- ------------+-----------+---------------------+---------------------
--  Маша       | Фролова   | 2023-09-01 08:30:00 | 2023-09-01 09:15:00


SELECT s.first_name, s.last_name, l.start_time, l.end_time FROM student s
JOIN lesson l ON s.id=l.student_id
JOIN classroom c ON l.classroom_id=c.id
JOIN desk d ON l.desk_id=d.id
WHERE c.classroom_name='101'
AND d.number=2;

-- first_name | last_name |     start_time      |      end_time       
-- ------------+-----------+---------------------+---------------------
--  Юля        | Петрова   | 2023-09-02 08:30:00 | 2023-09-02 09:15:00
