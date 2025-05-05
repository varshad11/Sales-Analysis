create database project;
use project;

select * from superstore_data;

-- 1️.SQL Task – Data Extraction & Manipulation
-- - Retrieve total sales per region.
select region, round(sum(sales), 2) as total_sales from superstore_data
group by region;

-- - Find the top 5 best-selling products.
select productname, round(sum(sales), 2) as total_sales from superstore_data
group by productname
order by total_sales desc limit 5;

-- - Calculate monthly revenue.
select distinct orderdate from superstore_data;

select orderdate,
  date_format(
    case
      when orderdate like '%/%' then STR_TO_DATE(orderdate, '%m/%d/%Y')
      when orderdate like '%-%' then str_to_date(orderdate, '%d-%m-%Y')
      else null
    end, 
    '%Y-%m-%d'
  ) as standardized_orderdate
from superstore_data;

update superstore_data
set orderdate = date_format(
  case
    when orderdate like '%/%' then str_to_date(orderdate, '%m/%d/%Y')
    when orderdate like '%-%' then str_to_date(orderdate, '%d-%m-%Y')
    else null
  end, '%Y-%m-%d'
);

select * from superstore_data;

select distinct shipdate from superstore_data;

update superstore_data
set shipdate = date_format(
  case
    when shipdate like '%/%' then str_to_date(shipdate, '%m/%d/%Y')
    when shipdate like '%-%' then str_to_date(shipdate, '%d-%m-%Y')
    else null
  end, '%Y-%m-%d'
);

select * from superstore_data;

select 
date_format(orderdate, '%Y-%m') as month,
round(sum(sales), 2) as total_revenue
from superstore_data
group by month
order by month;

-- - Identify repeat customers.
select CustomerID,CustomerName,
count(OrderID) as total_orders
from superstore_data
group by CustomerID, CustomerName
having total_orders > 1
order by total_orders desc;