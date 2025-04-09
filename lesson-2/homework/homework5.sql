create table worker(
	 id int,
	 name varchar(255)

);

bulk insert worker
from 'D:\SQL\sql-homeworks\lesson-2\homework\workers.csv'
with (
	fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 2,
	format = 'csv'

);

select * from worker