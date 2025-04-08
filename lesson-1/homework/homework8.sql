drop table if exists books
CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY, 
    title VARCHAR(255) CHECK (title <> ''), 
    price DECIMAL CHECK (price > 0),        
    genre VARCHAR(255) DEFAULT 'Unknown'     
);

-- Insert valid data to test constraints
INSERT INTO books (title, price, genre) VALUES ('The Great Gatsby', 15.99, 'Fiction');
INSERT INTO books (title, price) VALUES ('1984', 12.50);  -- genre defaults to 'Unknown'
INSERT INTO books (title, price, genre) VALUES ('Dune', 25.00, 'Sci-Fi');

-- Test constraints with invalid data (these should fail)
-- Test empty title
INSERT INTO books (title, price, genre) VALUES ('', 10.00, 'Fiction');  -- Should fail: title empty

-- Test price <= 0
INSERT INTO books (title, price, genre) VALUES ('Test Book', 0, 'Fiction');  -- Should fail: price = 0
INSERT INTO books (title, price, genre) VALUES ('Test Book', -5.50, 'Fiction');  -- Should fail: price < 0


SELECT * FROM books;