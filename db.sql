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
    description   	VARCHAR(250),
);

CREATE TABLE products
(
  name text,
  sku    integer PRIMARY KEY ,
  price  integer NOT NULL,
  category   VARCHAR(30)  references categories(category_name) NOT NULL
);
CREATE TABLE shopping_cart (
    id          SERIAL PRIMARY KEY,
    name   	VARCHAR(30) NOT NULL,
    amount   	VARCHAR(30),
    price       VARCHAR(30)
);
insert into products (name, sku, price, category) values('good', '1232', '123', 'book')