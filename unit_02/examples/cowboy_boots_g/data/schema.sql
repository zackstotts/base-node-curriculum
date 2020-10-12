-- drop database schema
-- DANGER: this is permanent and not recoverable!
drop database if exists cowboy_boots_3;

-- create the database schema
create database cowboy_boots_3 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
use cowboy_boots_3;

-- drop tables if they exist
-- DANGER: this is permanent and not recoverable!
drop table if exists order_items;
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

create fulltext index product_fulltext
  on products (`name`, `category`);
  
create index product_name
  on products (`name`);

create index product_category
  on products (`category`);
  
create index product_price
  on products (`price`);
  
-- create customers table
create table customers (
  `id` int not null auto_increment,
  `given_name` varchar(100) not null,
  `family_name` varchar(100) not null,
  `email` varchar(200) not null,
  `password` text not null,
  primary key (`id`),
  unique (`email`)
);

create fulltext index customer_fulltext
  on customers (`given_name`, `family_name`, `email`);

create index customer_email
  on customers (`email`);

-- create orders table
create table orders (
  `id` int not null auto_increment,
  `customer_id` int not null,
  `payment_date` datetime null,
  `ship_date` datetime null,
  primary key (`id`),
  foreign key (`customer_id`) references customers (`id`)
);

create index order_customer_id
  on orders (`customer_id`);

create index order_payment_date
  on orders (`payment_date`);
  
create index order_ship_date
  on orders (`ship_date`);

-- create order_product bridge table
create table order_items (
  `order_id` int not null,
  `product_id` int not null,
  `quantity` smallint not null default 1,
  `price` decimal(6,2) null,
  primary key (`order_id`, `product_id`),
  foreign key (`order_id`) references orders (`id`),
  foreign key (`product_id`) references products (`id`)
);

create index order_item_order_id
  on order_items (`order_id`);

create index order_item_product_id
  on order_items (`product_id`);

-- populate the tables

set sql_safe_updates = 0;  -- allows you to delete an entire table

delete from customers;
insert into customers (`id`, `given_name`, `family_name`, `email`, `password`) values
(1, 'John', 'Doe', 'john.doe@example.com', 'password');

delete from products;
insert into products (`id`, `name`, `category`, `price`) values
(1, 'Baby Boots', 'Boots', 19.99),
(2, 'Silver Buckle', 'Buckles', 25.00),
(3, 'Wide Brimmed Hat', 'Hats', 50.00);

delete from orders;
insert into orders (`id`, `customer_id`, `payment_date`, `ship_date`) values
(1, 1, null, null),
(2, 1, '2020-09-23 13:00:00', null),
(3, 1, '2020-09-23 15:00:00', '2020-09-23 17:00:00');

delete from order_items;
insert into order_items (`order_id`, `product_id`, `quantity`) values (1, 1, 3);
insert into order_items (`order_id`, `product_id`) values (2, 1), (2, 2);
insert into order_items (`order_id`, `product_id`, `quantity`, `price`) values (3, 1, 2, 10.00), (3, 2, 2, 20.00);

-- check that data is present

select * from products;
select * from customers;
select * from orders;
select * from order_items;

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

-- mockaroo.com generated customers
insert into customers (id, given_name, family_name, email, password) values (2, 'Ilysa', 'Mecozzi', 'imecozzi0@redcross.org', 'ExVs71lC7Ko');
insert into customers (id, given_name, family_name, email, password) values (3, 'Ellene', 'Feye', 'efeye1@multiply.com', 'LBXLL4BU');
insert into customers (id, given_name, family_name, email, password) values (4, 'Kathrine', 'Symper', 'ksymper2@washington.edu', 'vgVpuPHDPv');
insert into customers (id, given_name, family_name, email, password) values (5, 'Cointon', 'Sleany', 'csleany3@nifty.com', 'DplhCHwdau6');
insert into customers (id, given_name, family_name, email, password) values (6, 'Margalo', 'Cyseley', 'mcyseley4@columbia.edu', 'xPK6YEEili');
insert into customers (id, given_name, family_name, email, password) values (7, 'Micky', 'Spear', 'mspear5@tuttocitta.it', 'We3Ns1c6T');
insert into customers (id, given_name, family_name, email, password) values (8, 'Alexio', 'Pryde', 'apryde6@addtoany.com', 'Bjd2eEPtEhC4');
insert into customers (id, given_name, family_name, email, password) values (9, 'Willy', 'Blazeby', 'wblazeby7@51.la', 'xFbRszmh');
insert into customers (id, given_name, family_name, email, password) values (10, 'Arlinda', 'Bladesmith', 'abladesmith8@hatena.ne.jp', 'RkeUWvJk2m');
insert into customers (id, given_name, family_name, email, password) values (11, 'Sela', 'Stidworthy', 'sstidworthy9@wsj.com', 'Qacjqx');
insert into customers (id, given_name, family_name, email, password) values (12, 'Quinn', 'Gwioneth', 'qgwionetha@vinaora.com', 'TEHWXi7sKp');
insert into customers (id, given_name, family_name, email, password) values (13, 'Marna', 'Muggach', 'mmuggachb@disqus.com', 'bX7ceX');
insert into customers (id, given_name, family_name, email, password) values (14, 'Hanny', 'Hamsher', 'hhamsherc@hp.com', '16wQyjy297m');
insert into customers (id, given_name, family_name, email, password) values (15, 'Somerset', 'Mursell', 'smurselld@pen.io', 'FSyuID9Z7Bxs');
insert into customers (id, given_name, family_name, email, password) values (16, 'Janka', 'Colebrook', 'jcolebrooke@irs.gov', 'MmnXHxJ9X7U');
insert into customers (id, given_name, family_name, email, password) values (17, 'Daloris', 'Abelov', 'dabelovf@foxnews.com', '4v61pk5vm7');
insert into customers (id, given_name, family_name, email, password) values (18, 'Ramsey', 'Peyntue', 'rpeyntueg@bloomberg.com', 'dP9gPsw5tTJ');
insert into customers (id, given_name, family_name, email, password) values (19, 'Koo', 'Corns', 'kcornsh@google.fr', 'ZsPLaU');
insert into customers (id, given_name, family_name, email, password) values (20, 'Ranique', 'Stratiff', 'rstratiffi@apache.org', 'dbxTR8iW');
insert into customers (id, given_name, family_name, email, password) values (21, 'Katey', 'Serrurier', 'kserrurierj@desdev.cn', 'xMQ09QvUD1wy');
insert into customers (id, given_name, family_name, email, password) values (22, 'Kristo', 'Ayre', 'kayrek@shutterfly.com', 'JwE2tZDfNH');
insert into customers (id, given_name, family_name, email, password) values (23, 'Iggy', 'Ferreira', 'iferreiral@unesco.org', 'fqmqNOhNaQ');
insert into customers (id, given_name, family_name, email, password) values (24, 'Charlena', 'Buske', 'cbuskem@technorati.com', 'TziIrsWA7');
insert into customers (id, given_name, family_name, email, password) values (25, 'Gilberto', 'Clerke', 'gclerken@newsvine.com', 'zcql3t');
insert into customers (id, given_name, family_name, email, password) values (26, 'Rahel', 'Dutnall', 'rdutnallo@yale.edu', 'P7Dws0yBuQL');
insert into customers (id, given_name, family_name, email, password) values (27, 'Shanda', 'Tiner', 'stinerp@theguardian.com', 'ZgqQh8a8Whe');
insert into customers (id, given_name, family_name, email, password) values (28, 'Ruthi', 'Chappelle', 'rchappelleq@shutterfly.com', 'fzFJE8');
insert into customers (id, given_name, family_name, email, password) values (29, 'Britt', 'Ottam', 'bottamr@cloudflare.com', 'WPgkGXXU');
insert into customers (id, given_name, family_name, email, password) values (30, 'Devinne', 'Purvess', 'dpurvesss@who.int', '93wrwRxg63');
insert into customers (id, given_name, family_name, email, password) values (31, 'Merry', 'Elson', 'melsont@cmu.edu', 'Ao0eO7');
insert into customers (id, given_name, family_name, email, password) values (32, 'Sileas', 'Newbold', 'snewboldu@bandcamp.com', '65ZJURpWXt');
insert into customers (id, given_name, family_name, email, password) values (33, 'Hadlee', 'Mucklow', 'hmucklowv@aboutads.info', 'oHMGnenN');
insert into customers (id, given_name, family_name, email, password) values (34, 'Ainslee', 'Wipper', 'awipperw@wikipedia.org', 'zKSuHyKol');
insert into customers (id, given_name, family_name, email, password) values (35, 'Shandeigh', 'Hengoed', 'shengoedx@linkedin.com', 'bQGO8iEIFld');
insert into customers (id, given_name, family_name, email, password) values (36, 'Isabeau', 'Uzzell', 'iuzzelly@jalbum.net', 'tbhAoETRq');
insert into customers (id, given_name, family_name, email, password) values (37, 'Madelaine', 'Whittick', 'mwhittickz@nih.gov', '26VD6zHDS7');
insert into customers (id, given_name, family_name, email, password) values (38, 'Zsa zsa', 'Guyton', 'zguyton10@opensource.org', '3slkjn8');
insert into customers (id, given_name, family_name, email, password) values (39, 'Pearce', 'Purver', 'ppurver11@phoca.cz', 'RA1Yrmy97');
insert into customers (id, given_name, family_name, email, password) values (40, 'Claude', 'Uzzell', 'cuzzell12@howstuffworks.com', 'aNIMCevumdc');
insert into customers (id, given_name, family_name, email, password) values (41, 'Codee', 'Halbord', 'chalbord13@hostgator.com', 'C0xDmFUJJz');
insert into customers (id, given_name, family_name, email, password) values (42, 'Kinny', 'Kerslake', 'kkerslake14@ebay.co.uk', 'aR0KDvq');
insert into customers (id, given_name, family_name, email, password) values (43, 'Trescha', 'Briers', 'tbriers15@meetup.com', 'CTHwNKdIN');
insert into customers (id, given_name, family_name, email, password) values (44, 'Brannon', 'Lorinez', 'blorinez16@earthlink.net', 'nfcnShp4L7O4');
insert into customers (id, given_name, family_name, email, password) values (45, 'Doralyn', 'Pietrowicz', 'dpietrowicz17@vimeo.com', '11xNvN5i4i');
insert into customers (id, given_name, family_name, email, password) values (46, 'Aaron', 'Cancellieri', 'acancellieri18@wikia.com', '2MYOBOrwOF');
insert into customers (id, given_name, family_name, email, password) values (47, 'Reba', 'Joinson', 'rjoinson19@cbslocal.com', 'nY1cNXU');
insert into customers (id, given_name, family_name, email, password) values (48, 'Susie', 'Wildish', 'swildish1a@digg.com', '38akGRROijn');
insert into customers (id, given_name, family_name, email, password) values (49, 'Rebecca', 'Cribbott', 'rcribbott1b@symantec.com', '178x9o');
insert into customers (id, given_name, family_name, email, password) values (50, 'Dara', 'Canellas', 'dcanellas1c@addthis.com', 'v4Y9qT178P');
insert into customers (id, given_name, family_name, email, password) values (51, 'Jolee', 'Sall', 'jsall1d@cnn.com', '1K2pkYTCts');
insert into customers (id, given_name, family_name, email, password) values (52, 'Julianna', 'Carey', 'jcarey1e@dell.com', 'hf4PP5f');
insert into customers (id, given_name, family_name, email, password) values (53, 'Tarrah', 'Mongan', 'tmongan1f@npr.org', 'pNPwhmx');
insert into customers (id, given_name, family_name, email, password) values (54, 'Wiley', 'Morin', 'wmorin1g@samsung.com', 'f9dRaQP');
insert into customers (id, given_name, family_name, email, password) values (55, 'Annis', 'Beckhurst', 'abeckhurst1h@trellian.com', '7TaX34At');
insert into customers (id, given_name, family_name, email, password) values (56, 'Mathew', 'Foan', 'mfoan1i@comsenz.com', 'pUIpiyFx9');
insert into customers (id, given_name, family_name, email, password) values (57, 'Demott', 'Croad', 'dcroad1j@google.com', 'fiVAebycpP20');
insert into customers (id, given_name, family_name, email, password) values (58, 'Linus', 'Bemlott', 'lbemlott1k@hexun.com', 'R7RFb4');
insert into customers (id, given_name, family_name, email, password) values (59, 'Kean', 'Byram', 'kbyram1l@yahoo.co.jp', '4jbob4L');
insert into customers (id, given_name, family_name, email, password) values (60, 'Minnaminnie', 'Borrett', 'mborrett1m@blogs.com', 'EACIAvNwJJm');
insert into customers (id, given_name, family_name, email, password) values (61, 'Aluino', 'Fuentes', 'afuentes1n@ed.gov', 'MTM7A4QIbm7c');
insert into customers (id, given_name, family_name, email, password) values (62, 'Carry', 'Swindles', 'cswindles1o@cloudflare.com', 'L4n2lGfn');
insert into customers (id, given_name, family_name, email, password) values (63, 'Maggy', 'ffrench Beytagh', 'mffrenchbeytagh1p@census.gov', '7n5l68wo5pu');
insert into customers (id, given_name, family_name, email, password) values (64, 'Wynn', 'Thouless', 'wthouless1q@cpanel.net', '9wP6CVr');
insert into customers (id, given_name, family_name, email, password) values (65, 'Sandra', 'Le Noury', 'slenoury1r@biblegateway.com', 'cGCIhlOC');
insert into customers (id, given_name, family_name, email, password) values (66, 'Glen', 'Bigadike', 'gbigadike1s@constantcontact.com', 'sMedKEakn');
insert into customers (id, given_name, family_name, email, password) values (67, 'Ernestus', 'Jakoub', 'ejakoub1t@walmart.com', 'oP46ilsTG');
insert into customers (id, given_name, family_name, email, password) values (68, 'Meriel', 'Whittlesey', 'mwhittlesey1u@hud.gov', '6ik1SFU6TUP');
insert into customers (id, given_name, family_name, email, password) values (69, 'Isobel', 'Lambdon', 'ilambdon1v@washingtonpost.com', 'BsPZEZEvIGUL');
insert into customers (id, given_name, family_name, email, password) values (70, 'Culley', 'Fellini', 'cfellini1w@amazon.co.jp', 'mzgujysLG2x');
insert into customers (id, given_name, family_name, email, password) values (71, 'Quint', 'Vigietti', 'qvigietti1x@ibm.com', 'nyLtKE50Ikw3');
insert into customers (id, given_name, family_name, email, password) values (72, 'Galina', 'Sherebrook', 'gsherebrook1y@digg.com', '3K8XPwHNJZA');
insert into customers (id, given_name, family_name, email, password) values (73, 'Meta', 'Rubinowitch', 'mrubinowitch1z@techcrunch.com', 'mfIYR9A2Ba2U');
insert into customers (id, given_name, family_name, email, password) values (74, 'Dorolisa', 'Lanphier', 'dlanphier20@studiopress.com', 'hLK9tzR');
insert into customers (id, given_name, family_name, email, password) values (75, 'Val', 'Dalliston', 'vdalliston21@usda.gov', '5U6LbswKuQ9');
insert into customers (id, given_name, family_name, email, password) values (76, 'Ludovico', 'Duny', 'lduny22@people.com.cn', 'Vn48J9x');
insert into customers (id, given_name, family_name, email, password) values (77, 'Linn', 'Gehrts', 'lgehrts23@ed.gov', 'pjiNxil67R');
insert into customers (id, given_name, family_name, email, password) values (78, 'Dani', 'Bill', 'dbill24@digg.com', 'Sl8HSd7Jw');
insert into customers (id, given_name, family_name, email, password) values (79, 'Clemmie', 'Prescote', 'cprescote25@livejournal.com', '17xHZ7zx');
insert into customers (id, given_name, family_name, email, password) values (80, 'Theodoric', 'Blandamere', 'tblandamere26@google.co.uk', '6Z3u8O1a87');
insert into customers (id, given_name, family_name, email, password) values (81, 'Alfi', 'Gordge', 'agordge27@icq.com', '9urUNTNYjcZ');
insert into customers (id, given_name, family_name, email, password) values (82, 'Jojo', 'Crang', 'jcrang28@cam.ac.uk', 'Fr267bn');
insert into customers (id, given_name, family_name, email, password) values (83, 'Luis', 'Maroney', 'lmaroney29@google.es', 'XgUCxCK1l');
insert into customers (id, given_name, family_name, email, password) values (84, 'Diena', 'Lorimer', 'dlorimer2a@dailymotion.com', 'Thv1QStqS');
insert into customers (id, given_name, family_name, email, password) values (85, 'Sybyl', 'Starton', 'sstarton2b@uol.com.br', 'Rv7eaAZX');
insert into customers (id, given_name, family_name, email, password) values (86, 'Milena', 'Borley', 'mborley2c@networkadvertising.org', 'xZlhDE2tRa');
insert into customers (id, given_name, family_name, email, password) values (87, 'Farrel', 'Ryton', 'fryton2d@wordpress.org', 'kXgro7');
insert into customers (id, given_name, family_name, email, password) values (88, 'Andrus', 'Banaszkiewicz', 'abanaszkiewicz2e@reddit.com', 'pwKtg6O');
insert into customers (id, given_name, family_name, email, password) values (89, 'Austen', 'Robens', 'arobens2f@behance.net', '0munTOWjEO');
insert into customers (id, given_name, family_name, email, password) values (90, 'Lissie', 'Heppner', 'lheppner2g@house.gov', 'yxGMvrret6');
insert into customers (id, given_name, family_name, email, password) values (91, 'Anthea', 'Wallace', 'awallace2h@xing.com', 'ZmvusF932bY1');
insert into customers (id, given_name, family_name, email, password) values (92, 'Marianne', 'Musslewhite', 'mmusslewhite2i@cisco.com', 'KjzvN7n0zCP');
insert into customers (id, given_name, family_name, email, password) values (93, 'Dalston', 'Dunkinson', 'ddunkinson2j@vinaora.com', 'C1xpf6tI2');
insert into customers (id, given_name, family_name, email, password) values (94, 'Daphna', 'Kiezler', 'dkiezler2k@oaic.gov.au', '7hbRTZh82D7h');
insert into customers (id, given_name, family_name, email, password) values (95, 'Corry', 'Dominicacci', 'cdominicacci2l@over-blog.com', 'kNPZIheAsA');
insert into customers (id, given_name, family_name, email, password) values (96, 'Jessica', 'Piercey', 'jpiercey2m@yandex.ru', 'UxHn61kwXsdv');
insert into customers (id, given_name, family_name, email, password) values (97, 'Iormina', 'Mack', 'imack2n@blogger.com', 'CjlhzQUQotV');
insert into customers (id, given_name, family_name, email, password) values (98, 'Arron', 'Beernaert', 'abeernaert2o@usatoday.com', '6oxB2YuMv6Xv');
insert into customers (id, given_name, family_name, email, password) values (99, 'Annmaria', 'Coytes', 'acoytes2p@jalbum.net', 'CUhQ5TGHr');
insert into customers (id, given_name, family_name, email, password) values (100, 'Shari', 'Bazire', 'sbazire2q@twitter.com', 'lCEkeegBnk');
insert into customers (id, given_name, family_name, email, password) values (101, 'Ninetta', 'Copins', 'ncopins2r@paginegialle.it', 'Kr0KXPqi');

-- mockaroo.com generated orders
insert into orders (id, customer_id, payment_date, ship_date) values (4, 61, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (5, 88, null, '2020-10-06');
insert into orders (id, customer_id, payment_date, ship_date) values (6, 23, '2020-09-16', '2020-10-08');
insert into orders (id, customer_id, payment_date, ship_date) values (7, 10, '2020-09-01', null);
insert into orders (id, customer_id, payment_date, ship_date) values (8, 42, '2020-09-29', null);
insert into orders (id, customer_id, payment_date, ship_date) values (9, 43, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (10, 41, '2020-09-26', null);
insert into orders (id, customer_id, payment_date, ship_date) values (11, 39, '2020-09-20', null);
insert into orders (id, customer_id, payment_date, ship_date) values (12, 98, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (13, 36, null, '2020-10-11');
insert into orders (id, customer_id, payment_date, ship_date) values (14, 19, '2020-09-25', null);
insert into orders (id, customer_id, payment_date, ship_date) values (15, 23, null, '2020-10-10');
insert into orders (id, customer_id, payment_date, ship_date) values (16, 86, '2020-09-04', null);
insert into orders (id, customer_id, payment_date, ship_date) values (17, 28, '2020-09-27', '2020-10-05');
insert into orders (id, customer_id, payment_date, ship_date) values (18, 1, '2020-09-23', null);
insert into orders (id, customer_id, payment_date, ship_date) values (19, 93, '2020-09-02', '2020-10-11');
insert into orders (id, customer_id, payment_date, ship_date) values (20, 78, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (21, 43, '2020-09-15', null);
insert into orders (id, customer_id, payment_date, ship_date) values (22, 25, null, '2020-10-07');
insert into orders (id, customer_id, payment_date, ship_date) values (23, 79, '2020-09-18', '2020-10-01');
insert into orders (id, customer_id, payment_date, ship_date) values (24, 69, '2020-09-02', null);
insert into orders (id, customer_id, payment_date, ship_date) values (25, 93, '2020-09-03', '2020-10-02');
insert into orders (id, customer_id, payment_date, ship_date) values (26, 46, '2020-09-29', null);
insert into orders (id, customer_id, payment_date, ship_date) values (27, 9, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (28, 42, '2020-09-12', null);
insert into orders (id, customer_id, payment_date, ship_date) values (29, 40, '2020-09-05', null);
insert into orders (id, customer_id, payment_date, ship_date) values (30, 54, '2020-09-14', null);
insert into orders (id, customer_id, payment_date, ship_date) values (31, 27, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (32, 16, '2020-09-16', '2020-10-04');
insert into orders (id, customer_id, payment_date, ship_date) values (33, 46, '2020-09-15', null);
insert into orders (id, customer_id, payment_date, ship_date) values (34, 57, '2020-09-15', '2020-10-02');
insert into orders (id, customer_id, payment_date, ship_date) values (35, 26, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (36, 67, null, '2020-10-11');
insert into orders (id, customer_id, payment_date, ship_date) values (37, 19, '2020-09-03', null);
insert into orders (id, customer_id, payment_date, ship_date) values (38, 92, null, '2020-10-10');
insert into orders (id, customer_id, payment_date, ship_date) values (39, 99, '2020-09-05', null);
insert into orders (id, customer_id, payment_date, ship_date) values (40, 8, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (41, 35, null, '2020-10-09');
insert into orders (id, customer_id, payment_date, ship_date) values (42, 35, '2020-09-03', null);
insert into orders (id, customer_id, payment_date, ship_date) values (43, 10, '2020-09-08', null);
insert into orders (id, customer_id, payment_date, ship_date) values (44, 88, '2020-09-18', null);
insert into orders (id, customer_id, payment_date, ship_date) values (45, 50, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (46, 29, '2020-09-06', null);
insert into orders (id, customer_id, payment_date, ship_date) values (47, 71, '2020-09-19', null);
insert into orders (id, customer_id, payment_date, ship_date) values (48, 11, '2020-09-05', '2020-10-04');
insert into orders (id, customer_id, payment_date, ship_date) values (49, 66, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (50, 61, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (51, 66, '2020-09-20', null);
insert into orders (id, customer_id, payment_date, ship_date) values (52, 47, '2020-09-10', '2020-10-11');
insert into orders (id, customer_id, payment_date, ship_date) values (53, 33, null, '2020-10-04');
insert into orders (id, customer_id, payment_date, ship_date) values (54, 27, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (55, 53, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (56, 66, null, '2020-10-04');
insert into orders (id, customer_id, payment_date, ship_date) values (57, 100, '2020-09-18', '2020-10-05');
insert into orders (id, customer_id, payment_date, ship_date) values (58, 40, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (59, 33, '2020-09-10', null);
insert into orders (id, customer_id, payment_date, ship_date) values (60, 52, '2020-09-28', null);
insert into orders (id, customer_id, payment_date, ship_date) values (61, 10, '2020-09-05', null);
insert into orders (id, customer_id, payment_date, ship_date) values (62, 24, '2020-09-06', null);
insert into orders (id, customer_id, payment_date, ship_date) values (63, 99, '2020-09-24', null);
insert into orders (id, customer_id, payment_date, ship_date) values (64, 33, null, '2020-10-07');
insert into orders (id, customer_id, payment_date, ship_date) values (65, 10, '2020-09-11', null);
insert into orders (id, customer_id, payment_date, ship_date) values (66, 68, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (67, 75, null, '2020-10-01');
insert into orders (id, customer_id, payment_date, ship_date) values (68, 33, '2020-09-20', null);
insert into orders (id, customer_id, payment_date, ship_date) values (69, 73, '2020-09-06', '2020-10-04');
insert into orders (id, customer_id, payment_date, ship_date) values (70, 43, '2020-09-21', null);
insert into orders (id, customer_id, payment_date, ship_date) values (71, 14, null, '2020-10-10');
insert into orders (id, customer_id, payment_date, ship_date) values (72, 75, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (73, 98, '2020-09-29', '2020-10-04');
insert into orders (id, customer_id, payment_date, ship_date) values (74, 34, '2020-09-26', null);
insert into orders (id, customer_id, payment_date, ship_date) values (75, 85, '2020-09-29', null);
insert into orders (id, customer_id, payment_date, ship_date) values (76, 35, '2020-09-22', null);
insert into orders (id, customer_id, payment_date, ship_date) values (77, 59, '2020-09-21', '2020-10-09');
insert into orders (id, customer_id, payment_date, ship_date) values (78, 36, null, '2020-10-06');
insert into orders (id, customer_id, payment_date, ship_date) values (79, 43, '2020-09-23', null);
insert into orders (id, customer_id, payment_date, ship_date) values (80, 24, '2020-09-18', '2020-10-03');
insert into orders (id, customer_id, payment_date, ship_date) values (81, 24, null, '2020-10-09');
insert into orders (id, customer_id, payment_date, ship_date) values (82, 86, '2020-09-11', '2020-10-08');
insert into orders (id, customer_id, payment_date, ship_date) values (83, 16, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (84, 98, null, '2020-10-01');
insert into orders (id, customer_id, payment_date, ship_date) values (85, 14, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (86, 78, '2020-09-09', null);
insert into orders (id, customer_id, payment_date, ship_date) values (87, 65, '2020-09-14', null);
insert into orders (id, customer_id, payment_date, ship_date) values (88, 14, '2020-09-23', null);
insert into orders (id, customer_id, payment_date, ship_date) values (89, 64, '2020-09-28', null);
insert into orders (id, customer_id, payment_date, ship_date) values (90, 33, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (91, 66, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (92, 34, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (93, 41, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (94, 82, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (95, 27, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (96, 54, null, '2020-10-11');
insert into orders (id, customer_id, payment_date, ship_date) values (97, 95, '2020-09-16', null);
insert into orders (id, customer_id, payment_date, ship_date) values (98, 95, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (99, 45, null, null);
insert into orders (id, customer_id, payment_date, ship_date) values (100, 65, '2020-09-11', null);
insert into orders (id, customer_id, payment_date, ship_date) values (101, 36, '2020-09-03', '2020-10-05');
insert into orders (id, customer_id, payment_date, ship_date) values (102, 26, '2020-09-11', null);
insert into orders (id, customer_id, payment_date, ship_date) values (103, 13, '2020-09-10', null);

-- mockaroo.com generated order_items
insert into order_items (order_id, product_id, quantity, price) values (16, 85, 9, 46.6);
insert into order_items (order_id, product_id, quantity, price) values (91, 57, 10, 91.63);
insert into order_items (order_id, product_id, quantity, price) values (62, 68, 8, 16.87);
insert into order_items (order_id, product_id, quantity, price) values (72, 91, 6, 62.54);
insert into order_items (order_id, product_id, quantity, price) values (22, 93, 4, 36.71);
insert into order_items (order_id, product_id, quantity, price) values (65, 100, 8, 21.37);
insert into order_items (order_id, product_id, quantity, price) values (102, 73, 7, 50.4);
insert into order_items (order_id, product_id, quantity, price) values (27, 71, 1, 96.27);
insert into order_items (order_id, product_id, quantity, price) values (31, 69, 5, 31.25);
insert into order_items (order_id, product_id, quantity, price) values (63, 22, 8, 50.52);
insert into order_items (order_id, product_id, quantity, price) values (87, 3, 8, 19.2);
insert into order_items (order_id, product_id, quantity, price) values (67, 23, 6, 43.67);
insert into order_items (order_id, product_id, quantity, price) values (53, 6, 4, 40.31);
insert into order_items (order_id, product_id, quantity, price) values (76, 53, 1, 28.38);
insert into order_items (order_id, product_id, quantity, price) values (31, 10, 3, 47.27);
insert into order_items (order_id, product_id, quantity, price) values (98, 57, 7, 35.4);
insert into order_items (order_id, product_id, quantity, price) values (25, 88, 8, 71.43);
insert into order_items (order_id, product_id, quantity, price) values (52, 69, 6, 55.71);
insert into order_items (order_id, product_id, quantity, price) values (77, 54, 4, 61.01);
insert into order_items (order_id, product_id, quantity, price) values (81, 56, 9, 41.16);
-- insert into order_items (order_id, product_id, quantity, price) values (102, 84, 2, 38.63);
insert into order_items (order_id, product_id, quantity, price) values (65, 70, 8, 78.14);
insert into order_items (order_id, product_id, quantity, price) values (73, 29, 4, 38.52);
insert into order_items (order_id, product_id, quantity, price) values (42, 27, 9, 87.38);
insert into order_items (order_id, product_id, quantity, price) values (36, 66, 5, 41.26);
insert into order_items (order_id, product_id, quantity, price) values (67, 40, 2, 1.35);
insert into order_items (order_id, product_id, quantity, price) values (93, 65, 9, 78.94);
insert into order_items (order_id, product_id, quantity, price) values (22, 49, 1, 14.96);
insert into order_items (order_id, product_id, quantity, price) values (47, 35, 3, 61.68);
insert into order_items (order_id, product_id, quantity, price) values (75, 30, 5, 53.39);
-- insert into order_items (order_id, product_id, quantity, price) values (96, 99, 3, 24.88);
insert into order_items (order_id, product_id, quantity, price) values (64, 20, 7, 67.87);
insert into order_items (order_id, product_id, quantity, price) values (75, 57, 9, 48.95);
insert into order_items (order_id, product_id, quantity, price) values (76, 38, 5, 14.11);
insert into order_items (order_id, product_id, quantity, price) values (17, 15, 1, 79.83);
insert into order_items (order_id, product_id, quantity, price) values (77, 8, 6, 92.5);
insert into order_items (order_id, product_id, quantity, price) values (21, 32, 7, 20.65);
insert into order_items (order_id, product_id, quantity, price) values (76, 46, 8, 81.93);
insert into order_items (order_id, product_id, quantity, price) values (6, 34, 5, 88.45);
insert into order_items (order_id, product_id, quantity, price) values (62, 1, 6, 64.67);
insert into order_items (order_id, product_id, quantity, price) values (41, 66, 5, 60.36);
insert into order_items (order_id, product_id, quantity, price) values (17, 61, 8, 45.06);
insert into order_items (order_id, product_id, quantity, price) values (88, 21, 2, 29.65);
insert into order_items (order_id, product_id, quantity, price) values (56, 100, 4, 50.39);
insert into order_items (order_id, product_id, quantity, price) values (48, 9, 9, 26.99);
insert into order_items (order_id, product_id, quantity, price) values (26, 29, 6, 66.61);
insert into order_items (order_id, product_id, quantity, price) values (76, 14, 9, 88.31);
insert into order_items (order_id, product_id, quantity, price) values (46, 90, 4, 10.92);
insert into order_items (order_id, product_id, quantity, price) values (81, 32, 8, 96.16);
insert into order_items (order_id, product_id, quantity, price) values (16, 65, 4, 24.34);
insert into order_items (order_id, product_id, quantity, price) values (69, 73, 2, 30.49);
insert into order_items (order_id, product_id, quantity, price) values (39, 39, 7, 75.35);
insert into order_items (order_id, product_id, quantity, price) values (93, 50, 9, 87.64);
insert into order_items (order_id, product_id, quantity, price) values (82, 63, 3, 88.33);
insert into order_items (order_id, product_id, quantity, price) values (66, 96, 6, 92.41);
insert into order_items (order_id, product_id, quantity, price) values (26, 43, 7, 85.38);
insert into order_items (order_id, product_id, quantity, price) values (28, 38, 2, 29.08);
-- insert into order_items (order_id, product_id, quantity, price) values (47, 84, 3, 80.2);
insert into order_items (order_id, product_id, quantity, price) values (78, 18, 4, 31.68);
insert into order_items (order_id, product_id, quantity, price) values (52, 33, 6, 33.09);
insert into order_items (order_id, product_id, quantity, price) values (90, 12, 7, 28.87);
insert into order_items (order_id, product_id, quantity, price) values (76, 60, 2, 18.87);
insert into order_items (order_id, product_id, quantity, price) values (51, 38, 1, 17.17);
insert into order_items (order_id, product_id, quantity, price) values (42, 64, 3, 89.06);
insert into order_items (order_id, product_id, quantity, price) values (62, 5, 2, 58.44);
insert into order_items (order_id, product_id, quantity, price) values (17, 18, 2, 10.15);
insert into order_items (order_id, product_id, quantity, price) values (63, 85, 4, 11.21);
insert into order_items (order_id, product_id, quantity, price) values (62, 71, 9, 52.63);
insert into order_items (order_id, product_id, quantity, price) values (27, 83, 5, 30.13);
insert into order_items (order_id, product_id, quantity, price) values (24, 51, 7, 24.88);
insert into order_items (order_id, product_id, quantity, price) values (75, 39, 9, 81.21);
insert into order_items (order_id, product_id, quantity, price) values (102, 72, 7, 78.31);
insert into order_items (order_id, product_id, quantity, price) values (83, 44, 9, 48.14);
insert into order_items (order_id, product_id, quantity, price) values (18, 81, 10, 46.69);
insert into order_items (order_id, product_id, quantity, price) values (46, 60, 9, 43.83);
insert into order_items (order_id, product_id, quantity, price) values (27, 88, 10, 38.28);
-- insert into order_items (order_id, product_id, quantity, price) values (104, 42, 3, 7.81);
insert into order_items (order_id, product_id, quantity, price) values (77, 22, 3, 14.55);
insert into order_items (order_id, product_id, quantity, price) values (70, 76, 1, 75.48);
insert into order_items (order_id, product_id, quantity, price) values (33, 7, 6, 97.82);
insert into order_items (order_id, product_id, quantity, price) values (45, 22, 7, 76.4);
insert into order_items (order_id, product_id, quantity, price) values (28, 14, 5, 14.15);
insert into order_items (order_id, product_id, quantity, price) values (85, 28, 2, 57.19);
insert into order_items (order_id, product_id, quantity, price) values (33, 68, 3, 75.06);
insert into order_items (order_id, product_id, quantity, price) values (60, 69, 7, 48.0);
insert into order_items (order_id, product_id, quantity, price) values (99, 60, 1, 81.4);
insert into order_items (order_id, product_id, quantity, price) values (45, 31, 8, 22.91);
insert into order_items (order_id, product_id, quantity, price) values (29, 21, 3, 73.27);
insert into order_items (order_id, product_id, quantity, price) values (51, 64, 4, 39.7);
insert into order_items (order_id, product_id, quantity, price) values (86, 43, 4, 70.07);
insert into order_items (order_id, product_id, quantity, price) values (93, 67, 4, 99.47);
insert into order_items (order_id, product_id, quantity, price) values (27, 77, 7, 30.26);
insert into order_items (order_id, product_id, quantity, price) values (48, 23, 1, 7.84);
insert into order_items (order_id, product_id, quantity, price) values (86, 96, 9, 94.37);
insert into order_items (order_id, product_id, quantity, price) values (103, 54, 7, 21.08);
insert into order_items (order_id, product_id, quantity, price) values (98, 10, 1, 60.59);
insert into order_items (order_id, product_id, quantity, price) values (20, 81, 7, 84.83);
insert into order_items (order_id, product_id, quantity, price) values (46, 67, 3, 14.28);
insert into order_items (order_id, product_id, quantity, price) values (102, 30, 10, 87.5);
insert into order_items (order_id, product_id, quantity, price) values (68, 61, 5, 28.12);
