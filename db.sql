CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    user_name   VARCHAR(30) NOT NULL UNIQUE,
    roles   	VARCHAR(30),
    age         integer,
    state       VARCHAR(30)
);

CREATE TABLE categories (
    id          	SERIAL PRIMARY KEY,
    category_name   VARCHAR(30) NOT NULL UNIQUE,
    description   	VARCHAR(250)
);

CREATE TABLE products
(
  	id				SERIAL PRIMARY KEY,
  	product_name 	VARCHAR(30) NOT NULL,
  	sku    			integer NOT NULL UNIQUE,
  	price  			integer NOT NULL,
  	category_id  	integer  references categories(id) NOT NULL
);

CREATE TABLE shopping_cart (
    id          	SERIAL PRIMARY KEY,
    name   			VARCHAR(30) NOT NULL,
    amount   		integer,
    price       	integer,
    user_id			integer references users(id) NOT NULL
);

CREATE TABLE history (
    id          	SERIAL PRIMARY KEY,
    data			VARCHAR(30),
    amount   		integer,
    price       	integer,
    product_id  	int references products(id) NOT NULL,
    user_name_id 	int references users(id) NOT NULL
);

insert into users (user_name, roles, age, state) values('kevin', 	'onwer', 	'22', 'CA');
insert into users (user_name, roles, age, state) values('ray', 		'onwer', 	'23', 'NY');
insert into users (user_name, roles, age, state) values('weng', 	'customer', '24', 'CA');

insert into categories (category_name, description) values('labtop', 	'this is for labtop categories.');
insert into categories (category_name, description) values('book', 		'this is for book categories.');

insert into products (product_name, sku, price, category_id) values('mac pro', 	'1111', '1000', '1');
insert into products (product_name, sku, price, category_id) values('lenovo', 	'2222', '2000', '1');
insert into products (product_name, sku, price, category_id) values('hunter', 	'3333', '50', 	'2');
insert into products (product_name, sku, price, category_id) values('happy', 	'4444', '60', 	'2');




