-- 1.Favorite payment type and
select
payment_type,
count(o.order_id) as num_used 
from 
payments_dataset as p join orders_dataset as o
on p.order_id = o.order_id 
group by 1
order by 2 desc;


--2. Amount of usage for each type payment by year
with 
tmp as (
select 
	date_part('year', o.order_purchase_timestamp) as year,
	p.payment_type,
	count(1) as num_used --número de vezes que o tipo de pagamento foi utilizado 
from payments_dataset p join orders_dataset o 
on p.order_id = o.order_id
group by 1, 2
) 

select *,
	case when year_2017 = 0 then NULL -- porque não temos dados anteriores a 2017 
		else round((year_2018 - year_2017) / year_2017, 2) --com 2 casas decimais 
	end as pct_change_2017_2018
from (
select 
  payment_type,
  sum(case when year = '2016' then num_used else 0 end) as year_2016,
  sum(case when year = '2017' then num_used else 0 end) as year_2017,
  sum(case when year = '2018' then num_used else 0 end) as year_2018
from tmp 
group by 1) subq
order by 2 desc;