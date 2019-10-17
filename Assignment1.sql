--create database 
USE BIKESTORE
--CREATE SCHEMA SALES
--CREATE SCHEMA PRODUCTION
CREATE TABLE SALES.CUSTOMERS
(
 Customer_id int identity primary key,
 first_name nvarchar(20) not null,
 last_name nvarchar(20) not null,
 phone numeric(10) null,
 [email] [varchar](100) unique NULL,
 street nvarchar(100) null,
[city] [varchar](100) NULL,
[state] [varchar](50) NULL,
[zip_code] [varchar](10) NULL
)

CREATE TABLE SALES.ORDERS
(
 order_id int identity primary key,
  Customer_id int FOREIGN KEY REFERENCES SALES.CUSTOMERS(Customer_id), 
 order_status nvarchar(20)  null,
 order_date date null,
 required_date date null,
 shipped_date date null,
 store_id int FOREIGN KEY REFERENCES SALES.STORES(store_id),
 staff_id int FOREIGN KEY REFERENCES SALES.STAFFS(staff_id),
)
CREATE TABLE SALES.STORES
(
 store_id int identity primary key,
 store_name nvarchar(50) not null,
 phone numeric(10) null,
 [email] [varchar](100)  NULL,
 street nvarchar(100) null,
[city] [varchar](100) NULL,
[state] [varchar](50) NULL,
[zip_code] [varchar](10) NULL
)
CREATE TABLE SALES.STAFFS  --SELECT *  FROM SALES.STAFFS
(
 staff_id int identity primary key,
 first_name varchar(20) not null,
 last_name varchar(20) not null,
 [email] [varchar](100) unique NULL,
 [phone] [varchar](100) unique NULL,
 active varchar(20) null,
 store_id int FOREIGN KEY REFERENCES SALES.STORES(store_id),
 managed_id int null
 )
 CREATE TABLE SALES.ORDER_ITEMS
 (
  order_id int FOREIGN KEY REFERENCES SALES.ORDERS(order_id),
  item_id int not null,
  product_id int FOREIGN KEY REFERENCES PRODUCTION.PRODUCTS(product_id),
  quantity int check(quantity > 0) not null,
  list_price int check(list_price > 0) not null
 )

 create table PRODUCTION.PRODUCTS
 (
    product_id int identity primary key,
	product_name varchar(50) not null,
	  brand_id int  FOREIGN KEY references PRODUCTION.BRANDS(brand_id),
	 category_id int FOREIGN KEY references PRODUCTION.CATEGORIES(category_id),
	model_year date null,
	list_price int null
 )

 CREATE TABLE PRODUCTION.CATEGORIES
 (
  category_id int identity primary key,
  category_name varchar(50) null
  )
  create table PRODUCTION.BRANDS
  (
	brand_id int identity primary key,
	brand_name varchar(50) null
  )
  CREATE TABLE PRODUCTION.STOCKS
  (
     store_id int FOREIGN KEY REFERENCES SALES.STORES(store_id),
	  product_id int FOREIGN KEY REFERENCES PRODUCTION.PRODUCTS(product_id),
	  quantity int not null
  )
  ALTER TABLE SALES.ORDER_ITEMS
  ADD discount int null

  ALTER TABLE SALES.ORDER_ITEMS
  ADD item_amount as ((quantity*list_price)-discount)


  SELECT * FROM SALES.ORDERS
  SELECT * FROM SALES.CUSTOMERS
  SELECT * FROM SALES.ORDER_ITEMS
  SELECT * FROM SALES.STAFFS
  SELECT * FROM SALES.STORES
  SELECT * FROM PRODUCTION.STOCKS
  SELECT * FROM PRODUCTION.BRANDS
  SELECT * FROM PRODUCTION.PRODUCTS
  SELECT * FROM PRODUCTION.CATEGORIES
