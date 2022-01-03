/*1. Проанализировать бизнес-логику приложения и создать структуру базы данных, которая может использоваться для хранения данных этого приложения. В базе данных должно быть минимум десять таблиц. Если таблиц получается более двадцати то рекомендуется ограничиться частью функционала приложения и не превышать это количество. В качестве отчета по этой части проекта необходимо приложить команды создания таблиц.*/

DROP DATABASE shop;
CREATE DATABASE shop;

-- Создаем таблицу с пользователями
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    password_hash VARCHAR(100) NOT NULL
);

-- Создаем таблицу с расширенной информацией по пользователям
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id INT,
	date_of_birth DATE,
	gender CHAR(1),
	country VARCHAR(100),
	city VARCHAR(100),
    address VARCHAR(255),
    created_at TIMESTAMP
);

-- Создаем таблицу продуктов, предварительно создав тип ENUM
CREATE TYPE gender_of_persons AS ENUM ('man', 'woman', 'kids');
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	gender gender_of_persons,
	descripton TEXT,
	category_id INT NOT NULL,
	photo_name VARCHAR(150) NOT NULL UNIQUE,
	material_id INT NOT NULL,
	designer_id INT NOT NULL	
);

-- Создаем справочник материалов
DROP TABLE IF EXISTS materials;
CREATE TABLE materials (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) UNIQUE 	
);

-- Создаем справочник дизайнеров
DROP TABLE IF EXISTS designers;
CREATE TABLE designers (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) UNIQUE	
);

-- Создаем справочник категорий
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) UNIQUE	
);

-- Каждый товар может иметь несколько размеров и цветов. Создаем таблицу с товарами и его атрибутами, предварительно создав тип ENUM
CREATE TYPE color_products AS ENUM ('red', 'orange', 'yellow', 'green', 'blue', 'violet', 'pink', 'black', 'white', 'brown', 'multicolor');
CREATE TYPE size_products AS ENUM ('XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL');
DROP TABLE IF EXISTS items_products;
CREATE TABLE items_products (
	id SERIAL PRIMARY KEY,
	product_id INT NOT NULL,
	color color_products,
	size size_products,
	price NUMERIC(9,2) NOT NULL
);

-- Создаем таблицу с корзиной товаров
DROP TABLE IF EXISTS carts;
CREATE TABLE carts (
	id SERIAL PRIMARY KEY,
	user_id INT NOT NULL,
	item_product_id INT NOT NULL,
	quantity INT NOT NULL
);

-- Создаем таблицу заказов, предварительно создав тип ENUM
CREATE TYPE status_of_orders AS ENUM ('in processing', 'awaiting payment', 'assembly', 'sent', 'received', 'canceled');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id INT NOT NULL,
	created_at TIMESTAMP,
	status status_of_orders
);

-- Создаем таблицу c детализацией заказов,
DROP TABLE IF EXISTS orders_details;
CREATE TABLE orders_details(
	order_id INT NOT NULL,
	item_product_id INT NOT NULL,
	quantity INT NOT NULL
);

-- Создаем таблицу с отзывами, предварительно создав тип ENUM
CREATE TYPE grade_of_product AS ENUM ('1', '2', '3', '4', '5');
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
	id SERIAL PRIMARY KEY,
	user_id INT NOT NULL,
	order_id INT NOT NULL,
	item_product_id INT NOT NULL,
	review_text TEXT,
	grade grade_of_product,
	created_at TIMESTAMP
);



/*3. Создать внешние ключи, если они не были созданы на шаге 1 в командах создания таблиц. В качестве отчета приложить команды создания внешних ключей. */

ALTER TABLE profiles
ADD CONSTRAINT profiles_user_id_fk
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE products
ADD CONSTRAINT products_category_id_fk
FOREIGN KEY (category_id)
REFERENCES categories (id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE products
ADD CONSTRAINT products_material_id_fk
FOREIGN KEY (material_id)
REFERENCES materials (id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE products
ADD CONSTRAINT products_designer_id_fk
FOREIGN KEY (designer_id)
REFERENCES designers (id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE items_products
ADD CONSTRAINT items_products_product_id_fk
FOREIGN KEY (product_id)
REFERENCES products (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE carts
ADD CONSTRAINT carts_user_id_fk
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE carts
ADD CONSTRAINT carts_item_product_id_fk
FOREIGN KEY (item_product_id)
REFERENCES items_products (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE orders
ADD CONSTRAINT orders_user_id_fk
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE orders_details
ADD CONSTRAINT orders_details_order_id_fk
FOREIGN KEY (order_id)
REFERENCES orders (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE orders_details
ADD CONSTRAINT orders_details_item_product_id_fk
FOREIGN KEY (item_product_id)
REFERENCES items_products (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE reviews
ADD CONSTRAINT reviews_user_id_fk
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE reviews
ADD CONSTRAINT reviews_order_id_fk
FOREIGN KEY (order_id)
REFERENCES orders (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE reviews
ADD CONSTRAINT reviews_item_product_id_fk
FOREIGN KEY (item_product_id)
REFERENCES items_products (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;



/*5. Создать два сложных (многотабличных) запроса с использованием подзапросов.*/
-- Запрос, позволяющий увидеть 5 последних оформленных заказов и их статус
SELECT
  (SELECT users.id FROM users WHERE orders.user_id = users.id) AS user_id,
  (SELECT CONCAT(users.first_name, ' ', users.last_name) FROM users WHERE orders.user_id = users.id) AS user,
   orders.created_at,
   orders.status
FROM orders
      ORDER BY orders.created_at DESC
	  LIMIT 5;
	  
-- Запрос, позволяющий увидеть самый дорогой товар, его название, стоимость, категорию товара, дизайнера
SELECT 
  products.id,
  products.name,
  (SELECT items_products.price FROM items_products ORDER BY items_products.price DESC LIMIT 1),
  products.gender,
  (SELECT categories.name FROM categories WHERE products.category_id = categories.id) AS product_category,
  (SELECT designers.name FROM designers WHERE products.designer_id = designers.id) AS product_designer
FROM products
WHERE products.id = 
  (SELECT items_products.product_id FROM items_products ORDER BY items_products.price DESC LIMIT 1);
  
  

/*6. Создать два сложных запроса с использованием объединения JOIN и без использования подзапросов.*/
-- Запрос, выводящий список пользователей, количество их заказов и их ранг
WITH users_with_count_orders AS (
  SELECT DISTINCT
	users.id,
	users.first_name,
	users.last_name,
	COUNT(DISTINCT orders.id) AS orders_count
  FROM users
	LEFT JOIN orders
	  ON users.id = orders.user_id
  GROUP BY users.id)
SELECT 
  id,
  first_name,
  last_name,
  orders_count,
  DENSE_RANK () OVER (ORDER BY orders_count DESC) AS user_rank_orders
FROM users_with_count_orders
ORDER BY user_rank_orders;

-- Запрос, позволяющий увидеть общую сумму всех заказанных товаров по категориям
WITH orders_with_price_and_categories AS (
  SELECT
    orders.id AS order_id,
    orders_details.item_product_id AS item_product_id,
    orders_details.quantity AS quantity,
    items_products.price AS price,
    products.category_id AS category_id,
    categories.name AS category_name
  FROM orders
    JOIN orders_details
      ON orders.id = orders_details.order_id
    LEFT JOIN items_products
      ON orders_details.item_product_id = items_products.id 
    JOIN products
      ON items_products.product_id = products.id
    JOIN categories
      ON products.category_id = categories.id
  ORDER BY orders.id)
SELECT DISTINCT
  category_id,
  SUM (price * quantity) OVER (PARTITION BY category_id ORDER BY category_id)
FROM orders_with_price_and_categories
  ORDER BY category_id;


/*7. Создать два представления, в основе которых лежат сложные запросы.*/
-- Представление, которое выводит сумму за каждый заказ, который был получен покупателем
CREATE VIEW total_sum_order AS (
  SELECT
	orders.id AS order_id,
    SUM (orders_details.quantity * items_products.price) AS total_sum
  FROM orders
  JOIN orders_details
    ON orders.id = orders_details.order_id
  JOIN items_products
    ON orders_details.item_product_id = items_products.id
  WHERE orders.status = 'received'
    GROUP BY orders.id
      ORDER BY orders.id
);

-- Представление, которое выводит информацию по доставленным заказам (id заказа, id товаров, id заказчика). Это информация понадобится в дальнейшем, при создании триггера
CREATE VIEW received_order AS (
  SELECT
	orders_details.order_id,
	orders_details.item_product_id,
	orders.user_id
FROM orders
  JOIN orders_details
    ON orders.id = orders_details.order_id
WHERE orders.status = 'received'
);



/*8. Создать пользовательскую функцию.*/
-- Создаем функцию, которая по введенному статусу подсчитывает общее количество заказов с этим статусом
CREATE FUNCTION count_orders_with_certain_status (status_name status_of_orders) 
RETURNS BIGINT AS
$$
  SELECT 
    COUNT (*)EXPLAIN WITH users_with_count_orders AS (
  SELECT DISTINCT
	users.id,
	users.first_name,
	users.last_name,
	COUNT(DISTINCT orders.id) AS orders_count
  FROM users
	LEFT JOIN orders
	  ON users.id = orders.user_id
  GROUP BY users.id)
SELECT 
  id,
  first_name,
  last_name,
  orders_count,
  DENSE_RANK () OVER (ORDER BY orders_count DESC) AS user_rank_orders
FROM users_with_count_orders
ORDER BY user_rank_orders;
 
  FROM orders
  WHERE orders.status = status_name;
$$
LANGUAGE SQL;

--Проверяем функцию
SELECT count_orders_with_certain_status('awaiting payment');



/*9. Создать триггер.*/
-- Для создания триггера используем представление received_order, созданное ранее

-- Создаем функцию
CREATE OR REPLACE FUNCTION insert_rewiews_trigger()
  RETURNS TRIGGER AS
  $$
    DECLARE 
	  is_found BOOLEAN;
	BEGIN  
  	  is_found := EXISTS(
	  	SELECT *
		FROM received_order
		WHERE 
		  NEW.user_id = received_order.user_id AND
		  NEW.order_id = received_order.order_id AND
		  NEW.item_product_id = received_order.item_product_id
	  );
	  IF is_found THEN
		NEW.user_id := NEW.user_id;
		NEW.order_id := NEW.order_id;
		NEW.item_product_id := NEW.item_product_id;
      ELSE 
        RAISE EXCEPTION 'order not found';
      END IF;
	  RETURN NEW;
    END
  $$
  LANGUAGE PLPGSQL;
	  
-- Сoздаем триггер
CREATE TRIGGER check_orders_on_insert_rewiews
  BEFORE INSERT ON reviews
    FOR EACH ROW
      EXECUTE FUNCTION insert_rewiews_trigger();
	  
--Проверка работы триггера со вставкой записей с некорректным значением
INSERT INTO reviews (user_id,order_id,item_product_id,review_text,grade) 
VALUES
  (93, 49, 3, 'Lorem ipsum', '5');

-- Проверка работы триггера со вставкой записей с корректным значением
INSERT INTO reviews (user_id,order_id,item_product_id,review_text,grade) 
VALUES
  (93, 69, 48, 'Lorem ipsum', '5');
  


/*10. Для одного из запросов, созданных в пункте 6, провести оптимизацию. В качестве отчета приложить планы выполнения запроса, ваш анализ и показать действия, которые улучшили эффективность запроса.*/ 
-- Создаем план и анализ выполнения запроса
EXPLAIN ANALYZE WITH users_with_count_orders AS (
  SELECT DISTINCT
	users.id,
	users.first_name,
	users.last_name,
	COUNT(DISTINCT orders.id) AS orders_count
  FROM users
	LEFT JOIN orders
	  ON users.id = orders.user_id
  GROUP BY users.id)
SELECT 
  id,
  first_name,
  last_name,
  orders_count,
  DENSE_RANK () OVER (ORDER BY orders_count DESC) AS user_rank_orders
FROM users_with_count_orders
ORDER BY user_rank_orders;
 
 -- Полученный результат
 Sort  (cost=22.99..23.24 rows=100 width=32) (actual time=25.097..25.107 rows=100 loops=1)
   Sort Key: (dense_rank() OVER (?))
   Sort Method: quicksort  Memory: 32kB
   ->  WindowAgg  (cost=17.92..19.67 rows=100 width=32) (actual time=24.952..25.040 rows=100 loops=1)
         ->  Sort  (cost=17.92..18.17 rows=100 width=24) (actual time=24.927..24.937 rows=100 loops=1)
               Sort Key: users_with_count_orders.orders_count DESC
               Sort Method: quicksort  Memory: 32kB
               ->  Subquery Scan on users_with_count_orders  (cost=12.60..14.60 rows=100 width=24) (actual time=24.863..24.895 rows=100 loops=1)
                     ->  HashAggregate  (cost=12.60..13.60 rows=100 width=24) (actual time=24.861..24.882 rows=100 loops=1)
                           Group Key: users.id, users.first_name, users.last_name, count(DISTINCT orders.id)
                           ->  GroupAggregate  (cost=9.85..11.60 rows=100 width=24) (actual time=24.625..24.797 rows=100 loops=1)
                                 Group Key: users.id
                                 ->  Sort  (cost=9.85..10.10 rows=100 width=20) (actual time=24.567..24.582 rows=142 loops=1)
                                       Sort Key: users.id
                                       Sort Method: quicksort  Memory: 35kB
                                       ->  Hash Right Join  (cost=4.25..6.52 rows=100 width=20) (actual time=24.412..24.473 rows=142 loops=1)
                                             Hash Cond: (orders.user_id = users.id)
                                             ->  Seq Scan on orders  (cost=0.00..2.00 rows=100 width=8) (actual time=5.851..5.861 rows=100 loops=1)
                                             ->  Hash  (cost=3.00..3.00 rows=100 width=16) (actual time=18.533..18.534 rows=100 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 13kB
                                                   ->  Seq Scan on users  (cost=0.00..3.00 rows=100 width=16) (actual time=18.453..18.479 rows=100 loops=1)
 Planning Time: 0.315 ms
 Execution Time: 25.219 ms
(23 строки)
 
 -- Действия по оптимизации:
 1. В данном запросе не использутся вложенные запросы (только JOIN), поэтому оптимизировать структуру с этой точки зрения не получится
 2. Проверяем, какие индексы созданы для таблиц, которые учавствую в запросе и результат
 SELECT indexname FROM pg_indexes WHERE tablename = 'users';
 
 indexname    
-----------------
 users_pkey
 users_email_key
 users_phone_key
(3 строки)
 
 SELECT indexname FROM pg_indexes WHERE tablename = 'orders';
 
 indexname  
-------------
 orders_pkey
(1 строка)

Из запроса мы видим, что у таблицы orders не создан индекс для столбца orders.user_id. Создаем индекс
CREATE INDEX orders_user_id_fk ON orders (user_id);  
 
3. Проверяем результат при повторном построении анализа 
---------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=22.99..23.24 rows=100 width=32) (actual time=0.696..0.704 rows=100 loops=1)
   Sort Key: (dense_rank() OVER (?))
   Sort Method: quicksort  Memory: 32kB
   ->  WindowAgg  (cost=17.92..19.67 rows=100 width=32) (actual time=0.543..0.640 rows=100 loops=1)
         ->  Sort  (cost=17.92..18.17 rows=100 width=24) (actual time=0.536..0.545 rows=100 loops=1)
               Sort Key: users_with_count_orders.orders_count DESC
               Sort Method: quicksort  Memory: 32kB
               ->  Subquery Scan on users_with_count_orders  (cost=12.60..14.60 rows=100 width=24) (actual time=0.408..0.504 rows=100 loops=1)
                     ->  HashAggregate  (cost=12.60..13.60 rows=100 width=24) (actual time=0.408..0.493 rows=100 loops=1)
                           Group Key: users.id, users.first_name, users.last_name, count(DISTINCT orders.id)
                           ->  GroupAggregate  (cost=9.85..11.60 rows=100 width=24) (actual time=0.198..0.359 rows=100 loops=1)
                                 Group Key: users.id
                                 ->  Sort  (cost=9.85..10.10 rows=100 width=20) (actual time=0.183..0.196 rows=142 loops=1)
                                       Sort Key: users.id
                                       Sort Method: quicksort  Memory: 35kB
                                       ->  Hash Right Join  (cost=4.25..6.52 rows=100 width=20) (actual time=0.086..0.133 rows=142 loops=1)
                                             Hash Cond: (orders.user_id = users.id)
                                             ->  Seq Scan on orders  (cost=0.00..2.00 rows=100 width=8) (actual time=0.005..0.014 rows=100 loops=1)
                                             ->  Hash  (cost=3.00..3.00 rows=100 width=16) (actual time=0.058..0.058 rows=100 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 13kB
                                                   ->  Seq Scan on users  (cost=0.00..3.00 rows=100 width=16) (actual time=0.014..0.030 rows=100 loops=1)
 Planning Time: 0.698 ms
 Execution Time: 0.907 ms
(23 строки)

Время исполнения сократилось с 25.219 ms до 0.907 ms

4. Планировщик использует последовательное сканирование таблиц и не использует индексы. попробуем отключить последовательное сканирование:
SET enable_seqscan TO OFF;

Проверяем результат:
 Sort  (cost=42.68..42.93 rows=100 width=32) (actual time=0.578..0.586 rows=100 loops=1)
   Sort Key: (dense_rank() OVER (?))
   Sort Method: quicksort  Memory: 32kB
   ->  WindowAgg  (cost=37.61..39.36 rows=100 width=32) (actual time=0.471..0.555 rows=100 loops=1)
         ->  Sort  (cost=37.61..37.86 rows=100 width=24) (actual time=0.465..0.473 rows=100 loops=1)
               Sort Key: users_with_count_orders.orders_count DESC
               Sort Method: quicksort  Memory: 32kB
               ->  Subquery Scan on users_with_count_orders  (cost=32.28..34.28 rows=100 width=24) (actual time=0.405..0.434 rows=100 loops=1)
                     ->  HashAggregate  (cost=32.28..33.28 rows=100 width=24) (actual time=0.404..0.423 rows=100 loops=1)
                           Group Key: users.id, users.first_name, users.last_name, count(DISTINCT orders.id)
                           ->  GroupAggregate  (cost=0.29..31.29 rows=100 width=24) (actual time=0.026..0.343 rows=100 loops=1)
                                 Group Key: users.id
                                 ->  Merge Left Join  (cost=0.29..29.79 rows=100 width=20) (actual time=0.012..0.140 rows=142 loops=1)
                                       Merge Cond: (users.id = orders.user_id)
                                       ->  Index Scan using users_pkey on users  (cost=0.14..14.64 rows=100 width=16) (actual time=0.006..0.041 rows=100 loops=1)
                                       ->  Index Scan using orders_user_id_fk on orders  (cost=0.14..13.64 rows=100 width=8) (actual time=0.003..0.038 rows=100 loops=1)
 Planning Time: 0.291 ms
 Execution Time: 0.647 ms
(18 строк)
 
 Время исполнения сократилось незначительно: с 0.907 ms до 0.647 ms
 
 
 
 
 
 
 
 
 
 
