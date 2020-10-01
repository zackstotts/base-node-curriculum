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
insert into products (`id`, `name`, `category`, `price`) values
(1, 'Baby Boots', 'Boots', 19.99),
(2, 'Silver Buckle', 'Buckles', 25.00),
(3, 'Wide Brimmed Hat', 'Hats', 50.00);

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

-- mockaroo.com generated products
insert into products (id, category, price, name) values (4, 'Boots', 251.99, 'Spotted deer Boots');
insert into products (id, category, price, name) values (5, 'Buckles', 180.99, 'Four-spotted skimmer Buckles');
insert into products (id, category, price, name) values (6, 'Hats', 867.99, 'Possum Hats');
insert into products (id, category, price, name) values (7, 'Boots', 526.99, 'Thirteen-lined squirrel Boots');
insert into products (id, category, price, name) values (8, 'Buckles', 436.99, 'Kangaroo Buckles');
insert into products (id, category, price, name) values (9, 'Hats', 649.99, 'Silver-backed jackal Hats');
insert into products (id, category, price, name) values (10, 'Boots', 191.99, 'Gray langur Boots');
insert into products (id, category, price, name) values (11, 'Buckles', 856.99, 'Squirrel Buckles');
insert into products (id, category, price, name) values (12, 'Hats', 165.99, 'Lappet-faced vulture Hats');
insert into products (id, category, price, name) values (13, 'Boots', 571.99, 'Dragon Boots');
insert into products (id, category, price, name) values (14, 'Buckles', 62.99, 'Great kiskadee Buckles');
insert into products (id, category, price, name) values (15, 'Hats', 403.99, 'Secretary bird Hats');
insert into products (id, category, price, name) values (16, 'Boots', 530.99, 'Frogmouth Boots');
insert into products (id, category, price, name) values (17, 'Buckles', 591.99, 'Turtle Buckles');
insert into products (id, category, price, name) values (18, 'Hats', 589.99, 'Heron Hats');
insert into products (id, category, price, name) values (19, 'Boots', 687.99, 'Gambel''s quail Boots');
insert into products (id, category, price, name) values (20, 'Buckles', 488.99, 'Dunnart Buckles');
insert into products (id, category, price, name) values (21, 'Hats', 283.99, 'American racer Hats');
insert into products (id, category, price, name) values (22, 'Boots', 324.99, 'Goose Boots');
insert into products (id, category, price, name) values (23, 'Buckles', 692.99, 'Collared peccary Buckles');
insert into products (id, category, price, name) values (24, 'Hats', 860.99, 'Common eland Hats');
insert into products (id, category, price, name) values (25, 'Boots', 263.99, 'African wild dog Boots');
insert into products (id, category, price, name) values (26, 'Buckles', 298.99, 'Southern sea lion Buckles');
insert into products (id, category, price, name) values (27, 'Hats', 374.99, 'Starling Hats');
insert into products (id, category, price, name) values (28, 'Boots', 748.99, 'Puku Boots');
insert into products (id, category, price, name) values (29, 'Buckles', 986.99, 'Otter Buckles');
insert into products (id, category, price, name) values (30, 'Hats', 272.99, 'Purple grenadier Hats');
insert into products (id, category, price, name) values (31, 'Boots', 659.99, 'Arctic tern Boots');
insert into products (id, category, price, name) values (32, 'Buckles', 63.99, 'Little brown dove Buckles');
insert into products (id, category, price, name) values (33, 'Hats', 931.99, 'Pine siskin Hats');
insert into products (id, category, price, name) values (34, 'Boots', 699.99, 'Southern hairy-nosed wombat Boots');
insert into products (id, category, price, name) values (35, 'Buckles', 652.99, 'Blue duck Buckles');
insert into products (id, category, price, name) values (36, 'Hats', 150.99, 'Agile wallaby Hats');
insert into products (id, category, price, name) values (37, 'Boots', 75.99, 'Yak Boots');
insert into products (id, category, price, name) values (38, 'Buckles', 900.99, 'Phalarope Buckles');
insert into products (id, category, price, name) values (39, 'Hats', 124.99, 'Ring-tailed gecko Hats');
insert into products (id, category, price, name) values (40, 'Boots', 358.99, 'Wallaroo Boots');
insert into products (id, category, price, name) values (41, 'Buckles', 870.99, 'Silver-backed jackal Buckles');
insert into products (id, category, price, name) values (42, 'Hats', 146.99, 'Peccary Hats');
insert into products (id, category, price, name) values (43, 'Boots', 916.99, 'Camel Boots');
insert into products (id, category, price, name) values (44, 'Buckles', 853.99, 'American Virginia opossum Buckles');
insert into products (id, category, price, name) values (45, 'Hats', 811.99, 'Darwin ground finch (unidentified) Hats');
insert into products (id, category, price, name) values (46, 'Boots', 998.99, 'Black kite Boots');
insert into products (id, category, price, name) values (47, 'Buckles', 856.99, 'Blue racer Buckles');
insert into products (id, category, price, name) values (48, 'Hats', 59.99, 'Flamingo Hats');
insert into products (id, category, price, name) values (49, 'Boots', 740.99, 'Manatee Boots');
insert into products (id, category, price, name) values (50, 'Buckles', 820.99, 'Possum Buckles');
insert into products (id, category, price, name) values (51, 'Hats', 14.99, 'Sloth Hats');
insert into products (id, category, price, name) values (52, 'Boots', 919.99, 'Water moccasin Boots');
insert into products (id, category, price, name) values (53, 'Buckles', 969.99, 'Colobus Buckles');
insert into products (id, category, price, name) values (54, 'Hats', 352.99, 'Arctic lemming Hats');
insert into products (id, category, price, name) values (55, 'Boots', 828.99, 'North American beaver Boots');
insert into products (id, category, price, name) values (56, 'Buckles', 444.99, 'Black-throated butcher bird Buckles');
insert into products (id, category, price, name) values (57, 'Hats', 668.99, 'Snowy sheathbill Hats');
insert into products (id, category, price, name) values (58, 'Boots', 950.99, 'Jungle cat Boots');
insert into products (id, category, price, name) values (59, 'Buckles', 339.99, 'European red squirrel Buckles');
insert into products (id, category, price, name) values (60, 'Hats', 558.99, 'Legaan Hats');
insert into products (id, category, price, name) values (61, 'Boots', 961.99, 'Lily trotter Boots');
-- insert into products (id, category, price, name) values (62, 'Buckles', 192.99, 'Squirrel Buckles');
insert into products (id, category, price, name) values (63, 'Hats', 325.99, 'Tortoise Hats');
insert into products (id, category, price, name) values (64, 'Boots', 975.99, 'African black crake Boots');
insert into products (id, category, price, name) values (65, 'Buckles', 257.99, 'White-tailed jackrabbit Buckles');
insert into products (id, category, price, name) values (66, 'Hats', 792.99, 'Tokay gecko Hats');
insert into products (id, category, price, name) values (67, 'Boots', 219.99, 'Hornbill Boots');
insert into products (id, category, price, name) values (68, 'Buckles', 825.99, 'Black-throated cardinal Buckles');
insert into products (id, category, price, name) values (69, 'Hats', 309.99, 'Savanna baboon Hats');
insert into products (id, category, price, name) values (70, 'Boots', 636.99, 'Red howler monkey Boots');
insert into products (id, category, price, name) values (71, 'Buckles', 61.99, 'Tsessebe Buckles');
insert into products (id, category, price, name) values (72, 'Hats', 779.99, 'Asian elephant Hats');
insert into products (id, category, price, name) values (73, 'Boots', 446.99, 'Greater kudu Boots');
insert into products (id, category, price, name) values (74, 'Buckles', 778.99, 'Goose Buckles');
insert into products (id, category, price, name) values (75, 'Hats', 358.99, 'Cormorant Hats');
insert into products (id, category, price, name) values (76, 'Boots', 570.99, 'Small-clawed otter Boots');
insert into products (id, category, price, name) values (77, 'Buckles', 379.99, 'Red-headed woodpecker Buckles');
insert into products (id, category, price, name) values (78, 'Hats', 851.99, 'Wildebeest Hats');
insert into products (id, category, price, name) values (79, 'Boots', 878.99, 'Ibex Boots');
insert into products (id, category, price, name) values (80, 'Buckles', 878.99, 'Crane Buckles');
insert into products (id, category, price, name) values (81, 'Hats', 400.99, 'Rhinoceros Hats');
insert into products (id, category, price, name) values (82, 'Boots', 121.99, 'Silver-backed fox Boots');
insert into products (id, category, price, name) values (83, 'Buckles', 190.99, 'Great cormorant Buckles');
-- insert into products (id, category, price, name) values (84, 'Hats', 139.99, 'Snowy sheathbill Hats');
insert into products (id, category, price, name) values (85, 'Boots', 470.99, 'Small Indian mongoose Boots');
insert into products (id, category, price, name) values (86, 'Buckles', 533.99, 'Asian false vampire bat Buckles');
insert into products (id, category, price, name) values (87, 'Hats', 888.99, 'Dabchick Hats');
insert into products (id, category, price, name) values (88, 'Boots', 180.99, 'Starfish Boots');
insert into products (id, category, price, name) values (89, 'Buckles', 883.99, 'Polar bear Buckles');
insert into products (id, category, price, name) values (90, 'Hats', 420.99, 'Eagle Hats');
insert into products (id, category, price, name) values (91, 'Boots', 131.99, 'Lapwing (unidentified) Boots');
insert into products (id, category, price, name) values (92, 'Buckles', 147.99, 'Swainson''s francolin Buckles');
insert into products (id, category, price, name) values (93, 'Hats', 315.99, 'Mountain duck Hats');
insert into products (id, category, price, name) values (94, 'Boots', 83.99, 'Otter Boots');
insert into products (id, category, price, name) values (95, 'Buckles', 281.99, 'Feral rock pigeon Buckles');
insert into products (id, category, price, name) values (96, 'Hats', 221.99, 'Hoffman''s sloth Hats');
insert into products (id, category, price, name) values (97, 'Boots', 862.99, 'Woodrat (unidentified) Boots');
insert into products (id, category, price, name) values (98, 'Buckles', 554.99, 'Lion Buckles');
-- insert into products (id, category, price, name) values (99, 'Hats', 78.99, 'Eagle Hats');
insert into products (id, category, price, name) values (100, 'Boots', 431.99, 'Common brushtail possum Boots');
-- insert into products (id, category, price, name) values (101, 'Buckles', 46.99, 'Silver-backed jackal Buckles');
insert into products (id, category, price, name) values (102, 'Hats', 767.99, 'Egret Hats');
insert into products (id, category, price, name) values (103, 'Boots', 127.99, 'Western palm tanager (unidentified) Boots');


