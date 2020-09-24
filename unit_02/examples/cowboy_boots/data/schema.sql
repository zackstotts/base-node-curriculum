-- create the database schema
drop database if exists cowboy_boots_3;
create database cowboy_boots_3 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
use cowboy_boots_3;

-- drop tables if they exist
-- DANGER: this is permanent and not recoverable!
drop table if exists order_product;
drop table if exists products;
drop table if exists orders;

-- create products table
create table products (
  `id` int not null auto_increment,
  `name` varchar(100) not null,
  `category` varchar(7) not null,
  `price` decimal(6,2) not null,
  primary key (`id`),
  unique (`name`)
);

create index product_category
  on products (`category`);
  
create index product_price
  on products (`price`);

create fulltext index product_name
  on products (`name`);

-- create orders table
create table orders (
  `id` int not null auto_increment,
  `payment_date` datetime null,
  `ship_date` datetime null,
  primary key (`id`)
);

create index order_payment_date
  on orders (`payment_date`);
  
create index order_ship_date
  on orders (`ship_date`);

-- create order_product bridge table
create table order_product (
  `order_id` int not null,
  `product_id` int not null,
  `quantity` smallint not null default 1,
  `price` decimal(6,2) null,
  primary key (`order_id`, `product_id`),
  foreign key (`order_id`) references orders (`id`),
  foreign key (`product_id`) references products (`id`)
);

create index order_product_order_id
  on order_product (`order_id`);

create index order_product_product_id
  on order_product (`product_id`);

-- populate the tables

set sql_safe_updates = 0;  -- allows you to delete an entire table

delete from products;
insert into products (`name`, `category`, `price`) values
('Baby Boots', 'Boots', 19.99),
('Silver Buckle', 'Buckles', 25.00),
('Wide Brimmed Hat', 'Hats', 50.00);

delete from orders;
insert into orders (`id`, `payment_date`, `ship_date`) values
(1, null, null),
(2, '2020-09-23 13:00:00', null),
(3, '2020-09-23 15:00:00', '2020-09-23 17:00:00');

delete from order_product;
insert into order_product (`order_id`, `product_id`, `quantity`) values (1, 1, 3);
insert into order_product (`order_id`, `product_id`) values (2, 1), (2, 2);
insert into order_product (`order_id`, `product_id`, `quantity`, `price`) values (3, 1, 2, 10.00), (3, 2, 2, 20.00);

-- check that data is present

select * from products;
select * from orders;
select * from order_product;
