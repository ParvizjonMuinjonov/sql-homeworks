create table account(
	account_id int primary key,
	balance decimal check(balance >=0),
	account_type varchar(255) check(account_type in ('Saving', 'Checking'))
	
);


alter table account
drop constraint [CK__account__account__70DDC3D8];

alter table account 
drop constraint [CK__account__balance__6FE99F9F];

alter table account
add constraint CH_balance check (balance >=0);

alter table account
add constraint Ch_accountType check (account_type in ('Saving', 'Checking'));