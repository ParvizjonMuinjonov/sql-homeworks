CREATE TABLE photos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    image_data VARBINARY(MAX)
);


INSERT INTO photos (image_data)
SELECT *
FROM OPENROWSET(BULK 'C:\Users\Defender\OneDrive\Dokumenti\background\1387209.jpg', SINGLE_BLOB) AS ImageData;

