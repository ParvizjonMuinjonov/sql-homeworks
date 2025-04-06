drop table if exists product;
create table product(
	product_id int unique,
	product_name varchar(255),
	price decimal
);

alter table product
drop constraint UQ__product__47027DF49DFCF6FB;

alter table product
add constraint UNIQUENESS unique(product_id, product_name);