--1. Total revenue
select 
date_part ('year', o.order_purchase_timestamp) as year,
sum(revenue_per_order) as total_revenue
from 
	( select 
		order_id,
		sum(price+freight_value) as revenue_per_order -- soma do preço + transporte 
	 from order_items_dataset as oi
	 group by 1
	 ) as subq
join orders_dataset as o
on o.order_id = subq.order_id 
where o.order_status = 'delivered' -- ordens entregues 
group by 1
order by 1; 

-- 2. total cancel order per year 
select 
date_part ('year', order_purchase_timestamp) as year, 
count(order_status) as count_cancel_orders
from orders_dataset 
where order_status = 'canceled'
group by 1
order by 1; 

select distinct order_status from orders_dataset; -- para validar as categorias que existem 

-- 3. best selling product category per year 
select 
year,
product_category_name,
revenue
from 
	( select 
		date_part( 'year', o.order_purchase_timestamp) as year, 
		p.product_category_name,
		sum(price + freight_value) as revenue,
		rank() over( 
				partition by date_part ('year', o.order_purchase_timestamp)
				order by sum(price+freight_value) desc) as rk
	from orders_dataset as o join order_items_dataset as oi 
	on o.order_id = oi.order_id
	join products_dataset as p 
	on oi.product_id = p.product_id
	where o.order_status = 'delivered'
	group by 1,2
		) as subq
where rk = 1; --queremos a categoria de produtos que vendeu melhor em cada ano 

-- 4. most cancelled product category per year 
select 
year, 
product_category_name,
total_cancel
from 
	(select 
		date_part ('year', o.order_purchase_timestamp) as year,
	 	p.product_category_name,
	 	count(o.order_id) as total_cancel,
	 	rank() over(
			partition by date_part ('year', o.order_purchase_timestamp)
			order by count(o.order_id) desc) as rk 
	 from orders_dataset as o join order_items_dataset as oi 
	 on o.order_id = oi.order_id 
	 join products_dataset as p
	 on oi.product_id = p.product_id
	 where order_status = 'canceled'
	 group by 1,2
	) as subq 
where rk = 1 -- só queremos a categoria mais cancelada de cada ano 
order by 1;

-- 5. Create a CTE (Common Table Expression) and combine all previous results 
with total_revenue as(
select 
date_part ('year', o.order_purchase_timestamp) as year,
sum(revenue_per_order) as total_revenue
from 
	( select 
		order_id,
		sum(price+freight_value) as revenue_per_order -- soma do preço + transporte 
	 from order_items_dataset as oi
	 group by 1
	 ) as subq
join orders_dataset as o
on o.order_id = subq.order_id 
where o.order_status = 'delivered' -- ordens entregues 
group by 1
order by 1), 

cancel_order as(
select 
date_part ('year', order_purchase_timestamp) as year, 
count(order_status) as count_cancel_orders
from orders_dataset 
where order_status = 'canceled'
group by 1
order by 1),

best_product as (
select 
year,
product_category_name,
revenue
from 
	( select 
		date_part( 'year', o.order_purchase_timestamp) as year, 
		p.product_category_name,
		sum(price + freight_value) as revenue,
		rank() over( 
				partition by date_part ('year', o.order_purchase_timestamp)
				order by sum(price+freight_value) desc) as rk
	from orders_dataset as o join order_items_dataset as oi 
	on o.order_id = oi.order_id
	join products_dataset as p 
	on oi.product_id = p.product_id
	where o.order_status = 'delivered'
	group by 1,2
		) as subq
where rk = 1), 

most_canceled as (
select 
year, 
product_category_name,
total_cancel
from 
	(select 
		date_part ('year', o.order_purchase_timestamp) as year,
	 	p.product_category_name,
	 	count(o.order_id) as total_cancel,
	 	rank() over(
			partition by date_part ('year', o.order_purchase_timestamp)
			order by count(o.order_id) desc) as rk 
	 from orders_dataset as o join order_items_dataset as oi 
	 on o.order_id = oi.order_id 
	 join products_dataset as p
	 on oi.product_id = p.product_id
	 where order_status = 'canceled'
	 group by 1,2
	) as subq 
where rk = 1 -- só queremos a categoria mais cancelada de cada ano 
order by 1)

select 
tr.year, 
tr.total_revenue,
co.count_cancel_orders, 
bp.product_category_name as best_category_product,
bp.revenue as best_category_revenue,
mc.product_category_name as most_cancel_category_product,
mc.total_cancel as total_cancel 
from
total_revenue as tr join cancel_order as co
on tr.year = co.year 
join best_product as bp 
on co.year = bp.year 
join most_canceled as mc
on bp.year = mc.year; 










