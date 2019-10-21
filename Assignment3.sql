-------------Question 1-----------------

create view sales_info
as
select P.product_name,soi.list_price,soi.order_id from production.products P
inner join sales.order_items soi on P.product_id=soi.product_id 
inner join sales.orders so on soi.order_id=so.order_id

select * from sales_info

-------------Question 2-----------------


alter view staff_sales
as
select ss.first_name,ss.last_name,sum(soi.quantity*soi.list_price) as 'ordervalue' --,so.order_date,so.order_status,soi.list_price 
from sales.order_items soi
inner join sales.orders so on soi.order_id=so.order_id
inner join sales.staffs ss on so.staff_id=ss.staff_id
group by ss.first_name,ss.last_name

select * from staff_sales

-------------Question 3-----------------

alter proc usp_add_store
--@store_id int,
@store_name nvarchar(50),
@phone NVARCHAR(10),
@email nvarchar(50),
@street nvarchar(50),
@city nvarchar(50),
@state nvarchar(50),
@zip_code nvarchar(50),
@store_count int output
as
begin
insert into sales.stores(store_name,phone,email,street,city,state,zip_code) 
values(@store_name,@phone,@email,@street,@city,@state,@zip_code)
select @store_count=count(*) from sales.stores
end

declare @count int;
EXEC usp_add_store
@store_name='ABC',
@phone ='81728718',
@email='fdga@gmail.com',
@street='kharadi road',
@city ='pune',
@state='maharas',
@zip_code='262',
@store_count=@count output
select @count as 'store count'


select * from sales.stores

-------------Question 4-----------------

alter proc usp_store_wise_sales
@store_name nvarchar(50),
@city nvarchar(50),
@store_count int output
as
begin
insert into sales.stores(store_name,city) 
values(@store_name,@city)
select @store_count=count(*) from sales.stores
select count(so.order_id),so.store_id,ss.store_name from sales.orders so
left join sales.stores ss on so.store_id=ss.store_id
--left join sales.order_items soi on so.order_id=soi.order_id
group by so.order_id,ss.store_name,so.store_id--,soi.list_price
end

declare @count int;
EXEC usp_store_wise_sales
@store_name='ABC',
@city ='pune',
@store_count=@count output
select @count as 'store count'

select * from sales.stores

-------------Question 5-----------------

create function udf_avg_qty
(
@customer_id int,
@year int
)
RETURNS int
AS
BEGIN
declare @order_count decimal(10,2)
select @order_count=sum(quantity* list_price)
from sales.order_items oi 
inner join sales.orders so on oi.order_id=so.order_id
where customer_id=@customer_id
and year(order_date)=@year
return @order_count
end;

select dbo.udf_avg_qty(279,2017) as 'order sum'


