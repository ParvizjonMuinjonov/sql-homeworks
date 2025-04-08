create table book(
	book_id int identity(1,1) primary key,
	title varchar(255),
	author varchar(255),
	published_year int

);

create table Member(
	member_id int identity(1,1) primary key,
	name varchar(255),
	email varchar(255),
	phone_number varchar(255)

);


create table Loan(
	loan_id int identity(1,1) primary key,
	book_id int foreign key references book(book_id),
	member_id int foreign key references Member(member_id),
	loan_date date,
	return_date date 
);

INSERT INTO book (title, author, published_year) VALUES ('1984', 'George Orwell', 1949);
INSERT INTO Member (name, email, phone_number) VALUES ('John Doe', 'john@email.com', '555-1234');
INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES (1, 1, '2025-04-01', NULL);


SELECT * FROM book;
SELECT * FROM Member;
SELECT * FROM Loan;