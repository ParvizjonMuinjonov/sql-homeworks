create table orders(
	order_id int primary key,
	customer_name varchar(255),
	order_date date
);

alter table orders
drop constraint [PK__orders__46596229CD1B3326];

alter table orders
add constraint PK_orders primary key (order_id);