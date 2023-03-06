--1. Calculate average monthly active users per year
select 
year,
round(avg(total_customers),0) as avg_active_user --para arredondar a zero casas decimais 
from 
	(select 
	 		date_part ('year', od.order_purchase_timestamp) as year,
			date_part ('month', od.order_purchase_timestamp) as month,
			count (distinct c.customer_unique_id) as total_customers
	from orders_dataset as od join customers_dataset as c 
	on od.customer_id=c.customer_id
	group by 1,2
	) as a 	-- group by de year e month (1ª e 2ª linha)
group by 1;

--2. Calculate the new customers by year 
select 
date_part ('year', first_time_order) as year,
count(a.customer_unique_id) as new_customers
from 
	(select 
	 		c.customer_unique_id, 
	 		min(od.order_purchase_timestamp) as first_time_order
	 from orders_dataset as od join customers_dataset as c 
	 on od.customer_id = c.customer_id
	 group by 1
	) as a
group by 1
order by 1;

--3. Calculate the number of customers who placed a repeat order per year
select 
year, 
count(total_customers) as repeat_order
from
	(select 
	 		date_part ('year', od.order_purchase_timestamp) as year,
	 		c.customer_unique_id,
	 		count (c.customer_unique_id) as total_customers,
	 		count (od.order_id) as total_orders
	 from orders_dataset as od join customers_dataset as c
	 on od.customer_id = c.customer_id
	 group by 1,2
	 having count(order_id) >1
	) as a 
group by 1
order by 1;

--4. Calculate average orders by customer per year
select 
year, 
round(avg(total_orders),2) as avg_frequency_order --2 casas decimais 
from
	(select 
	 		date_part ('year', od.order_purchase_timestamp) as year,
	 		count (od.order_id) as total_orders,
	 		c.customer_unique_id
	 from orders_dataset as od join customers_dataset as c 
	 on od.customer_id = c.customer_id
	 group by 1,3
	 ) as a 
group by 1
order by 1; 

--5. Create a CTE (Common Table Expression) and combine all previous results
with count_mau as (
select 
year,
round(avg(total_customers),0) as avg_active_user --para arredondar a zero casas decimais 
from 
	(select 
	 		date_part ('year', od.order_purchase_timestamp) as year,
			date_part ('month', od.order_purchase_timestamp) as month,
			count (distinct c.customer_unique_id) as total_customers
	from orders_dataset as od join customers_dataset as c 
	on od.customer_id=c.customer_id
	group by 1,2
	) as a 	-- group by de year e month (1ª e 2ª linha)
group by 1
), 

new_customers as (
select 
date_part ('year', first_time_order) as year,
count(a.customer_unique_id) as new_customers
from 
	(select 
	 		c.customer_unique_id, 
	 		min(od.order_purchase_timestamp) as first_time_order
	 from orders_dataset as od join customers_dataset as c 
	 on od.customer_id = c.customer_id
	 group by 1
	) as a
group by 1
order by 1
), 

count_repeat_orders as (
select 
year, 
count(total_customers) as repeat_orders
from
	(select 
	 		date_part ('year', od.order_purchase_timestamp) as year,
	 		c.customer_unique_id,
	 		count (c.customer_unique_id) as total_customers,
	 		count (od.order_id) as total_orders
	 from orders_dataset as od join customers_dataset as c
	 on od.customer_id = c.customer_id
	 group by 1,2
	 having count(order_id) >1
	) as a 
group by 1
order by 1
), 

avg_orders as (
select 
year, 
round(avg(total_orders),2) as avg_frequency_order --2 casas decimais 
from
	(select 
	 		date_part ('year', od.order_purchase_timestamp) as year,
	 		count (od.order_id) as total_orders,
	 		c.customer_unique_id
	 from orders_dataset as od join customers_dataset as c 
	 on od.customer_id = c.customer_id
	 group by 1,3
	 ) as a 
group by 1
order by 1
)

select 
cm.year, 
cm.avg_active_user, 
nc.new_customers, 
ro.repeat_orders, 
ao.avg_frequency_order
from 
count_mau as cm join new_customers as nc
on cm.year=nc.year 
join count_repeat_orders as ro 
on nc.year=ro.year 
join avg_orders as ao 
on ro.year=ao.year;


