CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    user_name   VARCHAR(30) NOT NULL UNIQUE,
    roles   	VARCHAR(30),
    age         int,
    state       VARCHAR(30)
);

CREATE TABLE categories (
    id          SERIAL PRIMARY KEY,
    category_name   VARCHAR(30) NOT NULL UNIQUE,
    description   	VARCHAR(250)
);

CREATE TABLE products
(
  id	SERIAL PRIMARY KEY,
  product_name 	VARCHAR(30) NOT NULL,
  sku    integer NOT NULL UNIQUE,
  price  integer NOT NULL,
  category   VARCHAR(30)  references categories(category_name) NOT NULL
);

CREATE TABLE shopping_cart (
    id          SERIAL PRIMARY KEY,
    name   	VARCHAR(30) NOT NULL,
    amount   	VARCHAR(30),
    price       VARCHAR(30)
);

CREATE TABLE history (
    id          SERIAL PRIMARY KEY,
    data		VARCHAR(30),
    amount   	VARCHAR(30),
    price       VARCHAR(30),
    product_id  int references products(id) NOT NULL,
    user_name 	VARCHAR(30) references users(user_name) NOT NULL
);

insert into products (name, sku, price, category) values('good', '1232', '123', 'book')