CREATE TABLE invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,  
    amount DECIMAL
);


INSERT INTO invoice (amount) VALUES (10.50);
INSERT INTO invoice (amount) VALUES (25.75);
INSERT INTO invoice (amount) VALUES (15.00);
INSERT INTO invoice (amount) VALUES (30.20);
INSERT INTO invoice (amount) VALUES (45.90);

SET IDENTITY_INSERT invoice ON;


INSERT INTO invoice (invoice_id, amount) VALUES (100, 99.99);

SET IDENTITY_INSERT invoice OFF;

