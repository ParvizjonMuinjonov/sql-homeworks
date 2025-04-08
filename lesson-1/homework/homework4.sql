create table category(
	category_id int primary key,
	category_name varchar(255)
);

create table item(
	item_id int primary key,
	item_name varchar(255),
	category_id int foreign key references category(category_id)
);

alter table item
drop constraint [FK__item__category_i__619B8048];

alter table item
add foreign key (category_id) references category(category_id)