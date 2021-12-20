CREATE TABLE classrooms (
 room_id SERIAL NOT NULL,
 description VARCHAR(2000),
 zip VARCHAR(500),
 street VARCHAR(500),
 city VARCHAR(500)
);

ALTER TABLE classrooms ADD CONSTRAINT PK_classrooms PRIMARY KEY (room_id);


CREATE TABLE instructor (
 instructor_id SERIAL NOT NULL,
 person_number VARCHAR(500) NOT NULL UNIQUE,
 address VARCHAR(500),
 name VARCHAR(500),
 teach_ensembles VARCHAR(500),
 age INT,
 zip VARCHAR(500),
 city VARCHAR(500)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instrument (
 id SERIAL NOT NULL,
 type VARCHAR(500) NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE price_scheme (
 price_type_id SERIAL NOT NULL,
 lesson_type_price INT,
 skill_level_price INT,
 discount INT,
 teacher_salary INT,
 type VARCHAR(500)
);

ALTER TABLE price_scheme ADD CONSTRAINT PK_price_scheme PRIMARY KEY (price_type_id);


CREATE TABLE student (
 student_id SERIAL NOT NULL,
 person_number VARCHAR(12) NOT NULL UNIQUE,
 name VARCHAR(500),
 address VARCHAR(500),
 age INT,
 zip VARCHAR(500),
 city VARCHAR(500)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_email (
 student_id SERIAL NOT NULL,
 email VARCHAR(500) NOT NULL
);

ALTER TABLE student_email ADD CONSTRAINT PK_student_email PRIMARY KEY (student_id);


CREATE TABLE student_phone (
 student_id SERIAL NOT NULL,
 phone_number VARCHAR(100) NOT NULL
);

ALTER TABLE student_phone ADD CONSTRAINT PK_student_phone PRIMARY KEY (student_id);


CREATE TABLE teacher_instrument (
 instructor_id SERIAL NOT NULL,
 id SERIAL NOT NULL
);

ALTER TABLE teacher_instrument ADD CONSTRAINT PK_teacher_instrument PRIMARY KEY (instructor_id,id);


CREATE TABLE lesson (
 lesson_id SERIAL NOT NULL,
 instructor_id INT,
 room_id INT,
 price_type_id INT,
 time TIMESTAMP(10) NOT NULL,
 genre VARCHAR(500),
 amount_students INT,
 min_students INT,
 max_students INT,
 instrument_type  VARCHAR(500),
 lesson_type VARCHAR(500),
 skill_level VARCHAR(500)
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE parent_email (
 student_id SERIAL NOT NULL,
 email VARCHAR(500) NOT NULL
);

ALTER TABLE parent_email ADD CONSTRAINT PK_parent_email PRIMARY KEY (student_id);


CREATE TABLE parent_phone (
 student_id SERIAL NOT NULL,
 phone_number VARCHAR(100) NOT NULL
);

ALTER TABLE parent_phone ADD CONSTRAINT PK_parent_phone PRIMARY KEY (student_id);


CREATE TABLE renting_instruments (
 instrument_id SERIAL NOT NULL,
 time_rented TIMESTAMP(10),
 type VARCHAR(500),
 brand VARCHAR(500),
 price INT,
 student_id INT
);

ALTER TABLE renting_instruments ADD CONSTRAINT PK_renting_instruments PRIMARY KEY (instrument_id);


CREATE TABLE sibling (
 student_id SERIAL NOT NULL,
 person_number VARCHAR(500) NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (student_id);

CREATE TABLE student_lesson (
 student_id SERIAL NOT NULL,
 lesson_id SERIAL NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (student_id,lesson_id);


ALTER TABLE student_email ADD CONSTRAINT FK_student_email_0 FOREIGN KEY (student_id) REFERENCES student (student_id) on DELETE CASCADE;


ALTER TABLE student_phone ADD CONSTRAINT FK_student_phone_0 FOREIGN KEY (student_id) REFERENCES student (student_id) on DELETE CASCADE;


ALTER TABLE teacher_instrument ADD CONSTRAINT FK_teacher_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) on DELETE CASCADE;
ALTER TABLE teacher_instrument ADD CONSTRAINT FK_teacher_instrument_1 FOREIGN KEY (id) REFERENCES instrument (id) on DELETE CASCADE;


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) on DELETE SET NULL;
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (room_id) REFERENCES classrooms (room_id) on DELETE SET NULL;
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_2 FOREIGN KEY (price_type_id) REFERENCES price_scheme (price_type_id) on DELETE SET NULL;


ALTER TABLE parent_email ADD CONSTRAINT FK_parent_email_0 FOREIGN KEY (student_id) REFERENCES student (student_id) on DELETE CASCADE;


ALTER TABLE parent_phone ADD CONSTRAINT FK_parent_phone_0 FOREIGN KEY (student_id) REFERENCES student (student_id) on DELETE CASCADE;


ALTER TABLE renting_instruments ADD CONSTRAINT FK_renting_instruments_0 FOREIGN KEY (student_id) REFERENCES student (student_id) on DELETE SET NULL;


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (student_id) on DELETE CASCADE;


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id) on DELETE CASCADE;
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id) on DELETE CASCADE;
