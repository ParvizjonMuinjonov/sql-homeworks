CREATE TABLE data_types_demo (
    student_id SMALLINT PRIMARY KEY,
    student_name VARCHAR(50),
    student_birth DATE,
    student_grade DECIMAL(5,2),
);


INSERT INTO data_types_demo
VALUES
    (256, 'Brahim', '2006-08-12', 85.75),
    (2001, 'John', '2005-09-13', 92.00);


