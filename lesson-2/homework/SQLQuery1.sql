create table test_identity(
	customer_id int identity,
	customer_name varchar(255)
);

insert into test_identity
values 
	('John'),
	('Adam'),
	('Jacob'),
	('Michael'),
	('Nicolas');

delete test_identity
select * from test_identity

/* 
When we use DELETE the columns will stay even if the data was deleted and identity will not start from beginning, it just continues
*/ 

truncate table test_identity
select * from test_identity

/* 
When we use	TRUNCATE the columns will stay also but it also restarts the function of IDENTITY
*/ 

drop table test_identity
/* When we use DROP everything will be deleted including our table */