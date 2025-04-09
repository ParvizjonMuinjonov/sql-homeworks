CREATE TABLE student (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    classes INT,
    tuition_per_class DECIMAL(7,2),
    total_tuition AS (classes * tuition_per_class)
);

INSERT INTO student (classes, tuition_per_class)
VALUES 
    (6, 3250.75),
    (7, 3690.20),
    (8, 4200.50);

SELECT * FROM student;