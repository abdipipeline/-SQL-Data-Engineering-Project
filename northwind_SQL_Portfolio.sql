 --Show all customers
SELECT * FROM customers;


--Show only company name and country
SELECT company_name, country FROM customers;


--Show all employees
select *
from employees;

----Show only firstname, title and city from employees table
select first_name, title, city
from employees;


-- Show only customers from Germany
SELECT * 
FROM customers
WHERE country = 'Germany';

-- Sort customers A to Z by country
SELECT company_name, country 
FROM customers 
ORDER BY country;


-- Sort Z to A
SELECT company_name, country 
FROM customers 
ORDER BY country DESC;

--Show only top 5 customers
SELECT company_name, country 
FROM customers 
ORDER BY country 
LIMIT 5;


-- show only Germany
SELECT * FROM customers 
WHERE country = 'Germany';

-- SHOW ORDERS FRIEGHT BETWEEN 10 AND 50
SELECT * FROM orders 
WHERE freight BETWEEN 10 AND 50;


-- show Germany and berlin its Two condition
SELECT * FROM customers 
WHERE country = 'Germany' AND city = 'Berlin';


-- show Ger and france only
SELECT * FROM customers 
WHERE country = 'Germany' OR country = 'France';

-- SHOW ME FRANCE GER AND USA
SELECT * FROM customers 
WHERE country IN ('Germany', 'France', 'USA');

-- DO NOT SHOW ME GERMANY 
SELECT * FROM customers 
WHERE country != 'Germany';


-- Hide UK, also hide NULLs
SELECT * FROM customers 
WHERE country != 'UK' 
AND country IS NOT NULL;

-- HIDE UK AND SHOW ALL NULL COUNTRIES 
SELECT * FROM customers 
WHERE country != 'UK' or country is null;


--Show countries that start with the letter A
SELECT * FROM customers 
WHERE country LIKE 'A%';


--Show countries that end with "land"
select * from customers
where country LIKE '%land'

--Show countries that have "land" anywhere in the name
select * from customers
where country LIKE '%land%'


-- Show countries that start with U and have exactly one more character (like "UK")
select * from customers
where country like 'U_'

-- show me null in region
select country, region
from customers
where region is null;

select country, region
from customers
where region is not null;

-- Show 'No region' instead of empty
select country,
COALESCE (region, 'No region') as region
from customers;


-- Group by+ Having

-- How many customers per country?
SELECT country, COUNT(*) AS total
FROM customers
GROUP BY country;

-- Sort biggest to smallest
SELECT country, COUNT(*) AS total
FROM customers
GROUP BY country
ORDER BY total DESC;

-- Only show countries with more than 10 customers
SELECT country, COUNT(*) AS total
FROM customers
GROUP BY country
HAVING COUNT(*) > 10
ORDER BY total DESC;

-- Total freight per ship country.ALL delivery fees for each country.
SELECT ship_country, SUM(freight) AS total
FROM orders
GROUP BY ship_country
ORDER BY total DESC;

--Average freight per ship country
SELECT ship_country, AVG(freight) AS avg_freight
FROM orders
GROUP BY ship_country
ORDER BY avg_freight DESC;



--DATE functions 

-- Get current date
SELECT CURRENT_DATE;

-- Extract year, month, day
SELECT order_id, 
       EXTRACT(YEAR FROM order_date) AS year,
       EXTRACT(MONTH FROM order_date) AS month,
       EXTRACT(DAY FROM order_date) AS day
FROM orders;


-- Orders from 1997 only

SELECT * FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 1997;


-- Days between order and shipped date

SELECT order_id,
       order_date,
       shipped_date,
       shipped_date - order_date AS days_to_ship
FROM orders;


--  String functions

--trim removes hidden spaces from all the value in this column 
SELECT TRIM(company_name) FROM customers;


-- it makes lower case
SELECT LOWER(company_name) FROM customers;

-- CONCAT
SELECT CONCAT(city, ' - ', country) AS location
FROM customers;

SELECT REPLACE(country, 'UK', 'United Kingdom') 
FROM customers;



-- CAST: changes data type

-- See all column types in a table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'customers';


SELECT 
    order_id,
    quantity,
    unit_price,
    CAST(unit_price AS INT) AS price_no_decimal
FROM order_details;



-- JOINS. INNER JOINS

SELECT *
FROM CUSTOMERS;

SELECT *
FROM ORDERS;


-- Only show customers who HAVE  an order,  Link = customer_id exists in both tables
SELECT customers.company_name, orders.order_id
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id;


SELECT *
FROM EMPLOYEES;


-- Show which employee handled which order
SELECT employees.first_name, orders.order_id
FROM employees
INNER JOIN orders
ON employees.employee_id = orders.employee_id;


SELECT *
FROM PRODUCTS;

SELECT *
FROM CATEGORIES;


--Show me each product and which category it belongs to


SELECT PRODUCTS.PRODUCT_NAME, CATEGORIES.CATEGORY_NAME
FROM PRODUCTS
INNER JOIN CATEGORIES
ON PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY_ID;


--Show me each order and which employee processed it — include the employee city"

SELECT ORDERS.ORDER_ID, EMPLOYEES.LAST_NAME, EMPLOYEES.CITY
FROM ORDERS
INNER JOIN EMPLOYEES
ON ORDERS.EMPLOYEE_ID = EMPLOYEES.EMPLOYEE_ID


-- LEFT JOINS 

-- Show ALL customers even if they never ordered
SELECT customers.company_name, orders.order_id
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;


--Show me ALL categories and their products — even categories with no products"

SELECT CATEGORIES.CATEGORY_NAME, PRODUCTS.PRODUCT_NAME
FROM CATEGORIES
LEFT JOIN PRODUCTS 
ON CATEGORIES.CATEGORY_ID = PRODUCTS.CATEGORY_ID;


-- Show me ALL employees and the orders they handled — even employees who handled nothing?

SELECT EMPLOYEES. FIRST_NAME, EMPLOYEES.TITLE, ORDERS.ORDER_ID
FROM EMPLOYEES
LEFT JOIN ORDERS
ON EMPLOYEES.EMPLOYEE_ID = ORDERS.EMPLOYEE_ID;



-- RIGHT JOINS

--Show me ALL orders and the customers who made them — even if customer info is missing"
SELECT ORDERS.ORDER_ID, ORDERS.ORDER_DATE, CUSTOMERS.COMPANY_NAME, CUSTOMERS.CITY
FROM ORDERS
RIGHT JOIN CUSTOMERS
ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID;


-- FULL OUTER JOINS
--Show me ALL customers and ALL orders — even if they don't match each other
SELECT CUSTOMERS.COMPANY_NAME, CUSTOMERS.CITY, ORDERS.ORDER_ID, ORDERS.ORDER_DATE
FROM CUSTOMERS
FULL OUTER JOIN ORDERS
ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID;



-- Multiple JOINS TOGTHER

--Show me each order, the customer who made it, and the employee who handled it"

SELECT ORDERS.ORDER_ID, CUSTOMERS.COMPANY_NAME, EMPLOYEES.FIRST_NAME
FROM ORDERS
JOIN CUSTOMERS
ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID
JOIN EMPLOYEES
ON ORDERS.EMPLOYEE_ID = EMPLOYEES.EMPLOYEE_ID;


SELECT * FROM ORDER_DETAILS;
SELECT * FROM PRODUCTS;
SELECT * FROM categories;

--Show me each order, the product in it, and the category of that product"

SELECT ORDER_DETAILS.ORDER_ID, PRODUCTS.PRODUCT_NAME, CATEGORIES.CATEGORY_NAME
FROM ORDER_DETAILS
JOIN PRODUCTS
ON ORDER_DETAILS.PRODUCT_ID = PRODUCTS.PRODUCT_ID
JOIN CATEGORIES
ON PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY_ID;


SELECT * FROM CUSTOMERS
SELECT * FROM ORDERS;
SELECT * FROM EMPLOYEES;
SELECT * FROM PRODUCTS;


--Show me ALL customers and their orders, the employee who handled it, and the product in the order — even if some data is missing"

SELECT CUSTOMERS.COMPANY_NAME, ORDERS.ORDER_ID, 
       EMPLOYEES.FIRST_NAME, PRODUCTS.PRODUCT_NAME
FROM CUSTOMERS
JOIN ORDERS
ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
JOIN EMPLOYEES 
ON ORDERS.EMPLOYEE_ID = EMPLOYEES.EMPLOYEE_ID
JOIN ORDER_DETAILS
ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID
JOIN PRODUCTS
ON ORDER_DETAILS.PRODUCT_ID = PRODUCTS.PRODUCT_ID;




-- UNIONS

-- SHOW ME ALL CITIES WHERE HAVE CUSTOMERS OR EMPLOYEES?

SELECT city, 'Customer' AS type
FROM customers
UNION
SELECT city, 'Employee' AS type
FROM employees;


SELECT city FROM customers
UNION ALL
SELECT city FROM employees;


--Show all countries from customers and suppliers combined


SELECT  COUNTRY, 'CUSTOMER' AS TYPE FROM CUSTOMERS
UNION
SELECT COUNTRY, 'SUPPLIERS' AS TYPE FROM SUPPLIERS;


--Show all countries from customers and suppliers

SELECT COUNTRY FROM CUSTOMERS
UNION ALL
SELECT COUNTRY FROM SUPPLIERS





-- CASE

--Label each order as High, Medium or Low based on the price

SELECT order_id, unit_price,
CASE 
    WHEN unit_price > 100 THEN 'High'
    WHEN unit_price > 50  THEN 'Medium'
    ELSE 'Low'
END AS price_label
FROM order_details;


--Label each customer by country — if they are from UK show 'Local',

SELECT 
* FROM CUSTOMERS;

SELECT COMPANY_NAME, COUNTRY,
 CASE
    WHEN country = 'UK' THEN 'LOCAL'
    WHEN country IN ('France', 'Germany', 'Spain') THEN 'EU'
    WHEN country IN ('USA', 'Mexico', 'Canada') THEN 'NORTH_AMERICA'
    WHEN country IN ('Finland', 'Poland') THEN 'AFRICA'
    WHEN country = 'Brazil' THEN 'ASIA'
    ELSE 'OtherS'
END AS COUNTRY_LABEL
FROM CUSTOMERS;


-- CASE WITH GROUPBY

 -- How many customers are in each price group — High, Medium, Low?"
 
SELECT 
CASE 
    WHEN unit_price > 100 THEN 'High'
    WHEN unit_price > 50  THEN 'Medium'
    ELSE 'Low'
END AS price_label,
COUNT(*) AS total
FROM order_details
GROUP BY 
CASE 
    WHEN unit_price > 100 THEN 'High'
    WHEN unit_price > 50  THEN 'Medium'
    ELSE 'Low'
END;


--How many customers are in each region — UK, EU, or Other — show the count


SELECT 
 CASE
  WHEN COUNTRY in ('Uk','Spain', 'France') then 'EU'
  WHEN COUNTRY IN ('Usa', 'Brazil', 'Canda') Then 'NORTH_AMERICA'
  ELSE 'OTHERS'
  END AS Country_label,
COUNT(*) AS TOTAL
FROM CUSTOMERS 
GROUP BY
 CASE 
   WHEN COUNTRY in ('Uk','Spain', 'France') then 'EU'
   WHEN COUNTRY IN('Usa', 'Brazil', 'Canda') Then 'NORTH_AMERICA'
   ELSE 'OTHERS'
 END




 --Subqueries

 --Show me products that cost more than the average price?

SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products);


--Show me products that cost more than the most expensive product in category 1"


SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT MAX(unit_price) 
                   FROM products 
                   WHERE category_id = 1);
				  

				   
--Find the lowest price in category 1  → then show everything more expensive than that

SELECT product_name, unit_price
FROM products
WHERE unit_price > 
   (SELECT MIN(unit_price) 
        FROM products 
     WHERE category_id = 1);


--"Show me orders where the freight is higher than the average freight"


select order_id, freight
from orders
where freight > (select avg(freight)
            from orders);


--Show me customers who are from the same country as customer 'ALFKI'

SELECT company_name, country
FROM customers
WHERE country = (SELECT country 
                 FROM customers 
                 WHERE customer_id = 'ALFKI');




-- CTE

--  Show me customers who placed more than 5 orders

WITH order_counts AS (
    SELECT customer_id, COUNT(*) AS total
    FROM orders
    GROUP BY customer_id
)
-- Step 2: use it like a normal table
SELECT customer_id, total
FROM order_counts
WHERE total > 5;

select * from orders;


---Show me each customer and how many orders they placed

WITH order_counts AS (
    SELECT customer_id, COUNT(*) AS total
    FROM orders
    GROUP BY customer_id
)
    SELECT customer_id, total
    from order_counts;


--Show me each employee and how many orders they handled

with order_counts AS (
    select employee_id, count(*) As total
	from orders
	group by employee_id
)
    select employee_id, total
	from order_counts;


-- CTE + JOINS

--Show me each employee's full name and how many orders they handled

   
-- Step 1: count orders per employee (CTE)
WITH order_counts AS (
    SELECT employee_id, COUNT(*) AS total
    FROM orders
    GROUP BY employee_id
)
-- Step 2: join to get employee names
SELECT employees.first_name, employees.last_name, order_counts.total
FROM order_counts
JOIN employees 
ON order_counts.employee_id = employees.employee_id;

SELECT * FROM PRODUCTS;
SELECT * FROM  ORDER_DETAILS;


--Show me each product name and total quantity ordered

 WITH total_quantity  AS(
    SELECT PRODUCT_ID, SUM(QUANTITY) AS TOTAL
	FROM ORDER_DETAILS
	GROUP BY PRODUCT_ID
 )
 SELECT PRODUCTS.PRODUCT_NAME,  total_quantity.TOTAL
 FROM  total_quantity
 JOIN PRODUCTS
 ON PRODUCTS.PRODUCT_ID =  total_quantity.PRODUCT_ID;
 

 --Show me each category name and total products in it


   WITH PRODUCTS_COUNT AS(
    SELECT CATEGORY_ID, COUNT(*)AS TOTAL
	FROM PRODUCTS
	GROUP BY CATEGORY_ID
   )
   SELECT  CATEGORIES.CATEGORY_NAME,PRODUCTS_COUNT.TOTAL
   FROM PRODUCTS_COUNT
   JOIN CATEGORIES
   ON PRODUCTS_COUNT.CATEGORY_ID = CATEGORIES.CATEGORY_ID;


--Show me each supplier name and total products they supply?

SELECT * FROM SUPPLIERS;

      WITH PRODUCTS_COUNT AS (
	  SELECT SUPPLIER_ID, COUNT(*) AS TOTAL
	  FROM PRODUCTS
	  GROUP BY SUPPLIER_ID
	  )
   SELECT SUPPLIERS.COMPANY_NAME, PRODUCTS_COUNT.TOTAL
   FROM PRODUCTS_COUNT
   JOIN SUPPLIERS
   ON SUPPLIERS.SUPPLIER_ID = PRODUCTS_COUNT.SUPPLIER_ID;





--Window functions 


 -- Rank products by price within each category
SELECT product_name, category_id, unit_price,
RANK() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS price_rank
FROM products;
  
   
--Rank customers by how many orders they placed — highest first

select customer_id, order_id,
rank() over (partition by customer_id order by order_id desc) as order_rank
from orders;




--Give each order a unique number ordered by order date"

select order_id, order_date,
ROW_NUMBER() OVER (ORDER BY order_date DESC)
from orders;

-- LAG: show previous order freight
SELECT order_id, freight,
LAG(freight) OVER (ORDER BY order_id) AS previous_freight
FROM orders;

-- LEAD: show next order freight  
SELECT order_id, freight,
LEAD(freight) OVER (ORDER BY order_id) AS next_freight
FROM orders;




---- ================================
-- DATA ENGINEERING — DDL COMMANDS
-- ================================



--Create a table to store orders — include order ID, customer ID, order date and freight cost

create table new_orders (
order_id int,
customer_id varchar (10),
order_date date,
frieght Decimal(10,2) 
);

--insert 2 rows into new_orders table

insert into new_orders (order_id, customer_id, order_date, frieght)
 values (12, 'Abdul', '2026-06-10',31.5),
        (24, 'Hafid', '2026-06-11', 45.5);

 select * from new_orders;


-- update

--Change freight from 31.5 to 99.99

update new_orders
set frieght = 99.9
WHERE order_id = 12;


--Change the customer_id to 'NEWID' where order_id is 24

update new_orders
set customer_id = 'Hassan'
where order_id = 24;


update new_orders
set order_date ='2026-05-15'
where order_id = 12;


-- deleting

-- DELETE specific row
DELETE FROM new_orders
WHERE order_id = 12;

TRUNCATE TABLE new_orders;
DROP TABLE new_orders;



-- INDEXES
-- ================================

-- Speeds up queries on filtered columns
CREATE INDEX idx_customer_country 
ON customers(country);

DROP INDEX idx_customer_country;
