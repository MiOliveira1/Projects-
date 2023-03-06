--1. Is our hotel revenue growing by year?
select 
arrival_date_year,
sum((stays_in_weekend_nights+stays_in_week_nights)*adr*discount) as total_revenue 
from hotels as h join market_segment as m
on h.market_segment = m.market_segment
group by arrival_date_year;

alter table hotels 
alter column arrival_date_year type varchar;

--tenho que alterar adr para numeric, caso contrário, não consigo fazer o gráfico de barras 
alter table hotels
alter column adr type numeric; 

--2.The client has also asked to analyze hotel revenue by hotel type
--City Hotel 
select 
arrival_date_year,
sum((stays_in_weekend_nights+stays_in_week_nights)*adr*discount) as city_revenue
from hotels as h join market_segment as m
on h.market_segment = m.market_segment
where hotel = 'City Hotel'
group by arrival_date_year;

--Resort Hotel 
select 
arrival_date_year,
sum((stays_in_weekend_nights+stays_in_week_nights)*adr*discount) as resort_revenue 
from hotels as h join market_segment as m
on h.market_segment = m.market_segment
where hotel = 'Resort Hotel'
group by arrival_date_year;

--Combinar as duas querys numa só 
with city_rev as 
( 
	select 
		arrival_date_year,
		sum((stays_in_weekend_nights+stays_in_week_nights)*adr*discount) as city_hotel_revenue
	from hotels as h join market_segment as m
	on h.market_segment = m.market_segment
	where hotel = 'City Hotel'
	group by arrival_date_year
	order by 1
),

resort_rev as 
(
	select 
		arrival_date_year,
		sum((stays_in_weekend_nights+stays_in_week_nights)*adr*discount) as resort_hotel_revenue 
	from hotels as h join market_segment as m
	on h.market_segment = m.market_segment
	where hotel = 'Resort Hotel'
	group by arrival_date_year
	order by 1
)

select 
c.arrival_date_year as year,
c.city_hotel_revenue,
r.resort_hotel_revenue 
from city_rev as c join resort_rev as r
on c.arrival_date_year = r.arrival_date_year;

--3. Should we increase our parking lot space?

--per year 
select 
arrival_date_year,
sum(required_car_parking_spaces) as parking_space
from hotels
group by arrival_date_year;

--per hotel, per year 
with city_park as 
( 
	select 
		arrival_date_year,
		sum(required_car_parking_spaces) as city_hotel_parking
	from hotels
	where hotel = 'City Hotel'
	group by arrival_date_year
),

resort_park as 
(
	select 
		arrival_date_year,
		sum(required_car_parking_spaces) as resort_hotel_parking 
	from hotels
	where hotel = 'Resort Hotel'
	group by arrival_date_year
)

select 
c.arrival_date_year as year,
c.city_hotel_parking,
r.resort_hotel_parking 
from city_park as c join resort_park as r
on c.arrival_date_year = r.arrival_date_year;


--per month 
select 
arrival_date_month,
sum(required_car_parking_spaces) as parking_space
from hotels
group by arrival_date_month;

--per hotel, per month  
with city_park as 
( 
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as city_hotel_parking
	from hotels
	where hotel = 'City Hotel' 
	group by arrival_date_month
	order by arrival_date_month
),

resort_park as 
(
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as resort_hotel_parking 
	from hotels
	where hotel = 'Resort Hotel'
	group by arrival_date_month
	order by arrival_date_month
)

select 
c.arrival_date_month,
c.city_hotel_parking,
r.resort_hotel_parking 
from city_park as c join resort_park as r
on c.arrival_date_month = r.arrival_date_month;

--per hotel, per month in 2018 
with city_park as 
( 
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as city_hotel_parking
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2018'
	group by arrival_date_month
	order by arrival_date_month
),

resort_park as 
(
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as resort_hotel_parking 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2018'
	group by arrival_date_month
	order by arrival_date_month
)

select 
c.arrival_date_month,
c.city_hotel_parking,
r.resort_hotel_parking 
from city_park as c join resort_park as r
on c.arrival_date_month = r.arrival_date_month;

--per hotel, per month in 2019 
with city_park as 
( 
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as city_hotel_parking
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2019'
	group by arrival_date_month
	order by arrival_date_month
),

resort_park as 
(
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as resort_hotel_parking 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2019'
	group by arrival_date_month
	order by arrival_date_month
)

select 
c.arrival_date_month,
c.city_hotel_parking,
r.resort_hotel_parking 
from city_park as c join resort_park as r
on c.arrival_date_month = r.arrival_date_month;

--per hotel, per month in 2020
with city_park as 
( 
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as city_hotel_parking
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2020'
	group by arrival_date_month
	order by arrival_date_month
),

resort_park as 
(
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as resort_hotel_parking 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2020'
	group by arrival_date_month
	order by arrival_date_month
)

select 
c.arrival_date_month,
c.city_hotel_parking,
r.resort_hotel_parking 
from city_park as c join resort_park as r
on c.arrival_date_month = r.arrival_date_month;

--combine all results for parking in 2018, 2019, 2020 per hotel 
with city_park_2018 as 
( 
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as city_hotel_parking_2018
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2018'
	group by arrival_date_month
),

resort_park_2018 as 
(
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as resort_hotel_parking_2018 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2018'
	group by arrival_date_month
), 

city_park_2019 as 
( 
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as city_hotel_parking_2019
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2019'
	group by arrival_date_month
	order by arrival_date_month
),

resort_park_2019 as 
(
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as resort_hotel_parking_2019 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2019'
	group by arrival_date_month
	order by arrival_date_month
), 

city_park_2020 as 
( 
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as city_hotel_parking_2020
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2020'
	group by arrival_date_month
),

resort_park_2020 as 
(
	select 
		arrival_date_month as arrival_date_month,
		sum(required_car_parking_spaces) as resort_hotel_parking_2020 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2020'
	group by arrival_date_month
)

select 
c2019.arrival_date_month,
c2018.city_hotel_parking_2018,
r2018.resort_hotel_parking_2018,
c2019.city_hotel_parking_2019,
r2019.resort_hotel_parking_2019,
c2020.city_hotel_parking_2020,
r2020.resort_hotel_parking_2020
from city_park_2018 as c2018 
left join resort_park_2018 as r2018 on c2018.arrival_date_month = r2018.arrival_date_month
right join city_park_2019 as c2019 on r2018.arrival_date_month = c2019.arrival_date_month
left join resort_park_2019 as r2019 on c2019.arrival_date_month = r2019.arrival_date_month
left join city_park_2020 as c2020 on r2019.arrival_date_month = c2020.arrival_date_month
left join resort_park_2020 as r2020 on r2020.arrival_date_month = c2020.arrival_date_month; 

--alterei os meses para números para conseguir ordenar os gráficos 
update hotels
set arrival_date_month = 2 where arrival_date_month = 'February';

--verificação
select distinct arrival_date_month from hotels;

alter table hotels
alter column arrival_date_month type integer USING arrival_date_month::integer; 

--4. What kind of trends can we see in the data?
--analisar bookings 
--analisar que tipo de clientes visita mais os hotéis 

-- Cancel bookings per year and per hotel 
with total_cancel as 
	(
	select 
		arrival_date_year,
		count(is_canceled) as total_cancel_bookings 
		from hotels 
		where is_canceled = 1 
		group by 1
		order by 1
	),

city_cancel as 
	(select
		
	 	arrival_date_year,
		count (is_canceled) as city_cancel_bookings
		from hotels 
		where is_canceled = 1 and hotel = 'City Hotel'
		group by 1
		order by 1
	), 
		
resort_cancel as 
	(select 
		
	 	arrival_date_year,
		count (is_canceled) as resort_cancel_bookings
		from hotels 
		where is_canceled = 1 and hotel = 'Resort Hotel'
		group by 1
		order by 1
	)
		
select 

tc.arrival_date_year as year,
tc.total_cancel_bookings, 
c.city_cancel_bookings, 
r.resort_cancel_bookings
from total_cancel as tc join city_cancel as c 
on tc.arrival_date_year = c.arrival_date_year
join resort_cancel as r
on c.arrival_date_year =r.arrival_date_year;

--confirmed bookings per month 
--total_bookings
select 
	arrival_date_year, 
	arrival_date_month,
	count(is_canceled) as total_confirmed_bookings
from hotels 
	where is_canceled = 0 
	group by 1,2
	order by 1,2;

-- City Hotel bookings 
select 
	arrival_date_year, 
	arrival_date_month,
	count(is_canceled) as city_confirmed_bookings
from hotels 
	where is_canceled = 0 and hotel = 'City Hotel'
	group by 1,2
	order by 1,2;

-- Resort Hotel bookings 
select 
	arrival_date_year, 
	arrival_date_month,
	count(is_canceled) as resort_confirmed_bookings
from hotels 
	where is_canceled = 0 and hotel = 'Resort Hotel'
	group by 1,2
	order by 1,2;

--combine all results for booking in 2018, 2019, 2020 per hotel 
with city_bookings_2018 as 
( 
	select 
		arrival_date_month as arrival_date_month,
		count(is_canceled) as city_bookings_2018
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2018' and is_canceled = 0
	group by arrival_date_month
),

resort_bookings_2018 as 
(
	select 
		arrival_date_month as arrival_date_month,
		count(is_canceled) as resort_bookings_2018 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2018' and is_canceled = 0
	group by arrival_date_month
), 

city_bookings_2019 as 
( 
	select 
		arrival_date_month as arrival_date_month,
		count(is_canceled) as city_bookings_2019
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2019' and is_canceled = 0 
	group by arrival_date_month
	order by arrival_date_month
),

resort_bookings_2019 as 
(
	select 
		arrival_date_month as arrival_date_month,
		count(is_canceled) as resort_bookings_2019 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2019' and is_canceled = 0 
	group by arrival_date_month
	order by arrival_date_month
), 

city_bookings_2020 as 
( 
	select 
		arrival_date_month as arrival_date_month,
		count(is_canceled) as city_bookings_2020
	from hotels
	where hotel = 'City Hotel' and arrival_date_year = '2020' and is_canceled = 0 
	group by arrival_date_month
),

resort_bookings_2020 as 
(
	select 
		arrival_date_month as arrival_date_month,
		count(is_canceled) as resort_bookings_2020 
	from hotels
	where hotel = 'Resort Hotel' and arrival_date_year = '2020' and is_canceled = 0
	group by arrival_date_month
)

select 
c2019.arrival_date_month,
c2018.city_bookings_2018,
r2018.resort_bookings_2018,
c2019.city_bookings_2019,
r2019.resort_bookings_2019,
c2020.city_bookings_2020,
r2020.resort_bookings_2020
from city_bookings_2018 as c2018 
left join resort_bookings_2018 as r2018 on c2018.arrival_date_month = r2018.arrival_date_month
right join city_bookings_2019 as c2019 on r2018.arrival_date_month = c2019.arrival_date_month
left join resort_bookings_2019 as r2019 on c2019.arrival_date_month = r2019.arrival_date_month
left join city_bookings_2020 as c2020 on r2019.arrival_date_month = c2020.arrival_date_month
left join resort_bookings_2020 as r2020 on r2020.arrival_date_month = c2020.arrival_date_month; 


--who are the clients? 
--total customer segment per year 
select 
		arrival_date_year,
		market_segment,
		count(market_segment) as total_clients_segment
		from hotels 
		group by 1,2
		order by 1, 3 desc ;

-- city customer segment 
select
		arrival_date_year,
		market_segment,
		count(market_segment) as city_clients_segment
		from hotels 
		where hotel = 'City Hotel'
		group by 1,2
		order by 1,3 desc;
	
-- resort customer segment 
select 
		arrival_date_year,
		market_segment,
		count(market_segment) as resort_clients_segment
		from hotels
		where hotel = 'Resort Hotel'
		group by 1,2
		order by 1,3 desc;
		

--repeated guests 
with total_repeated_guests as
(select 
arrival_date_year, 
count(is_repeated_guest) as total_repeated_guest
from hotels
where is_repeated_guest = 1
group by 1
order by 1,2),

city_repeated_guests as 
(select 
arrival_date_year, 
count(is_repeated_guest) as city_repeated_guest
from hotels
where is_repeated_guest = 1 and hotel = 'City Hotel'
group by 1
order by 1,2),

resort_repeated_guests as 
(select 
arrival_date_year, 
count(is_repeated_guest) as resort_repeated_guest
from hotels
where is_repeated_guest = 1 and hotel = 'Resort Hotel'
group by 1
order by 1,2) 

select 
t.arrival_date_year as year,
t.total_repeated_guest,
c.city_repeated_guest,
r.resort_repeated_guest
from total_repeated_guests as t join city_repeated_guests as c
on t.arrival_date_year = c.arrival_date_year 
join resort_repeated_guests as r 
on c.arrival_date_year = r.arrival_date_year;

--nacionality 
--ano 2018 
select 
country,
count(country) as contagem_nacionalidades
from hotels 
where is_canceled = 0 and arrival_date_year = '2018' 
group by 1
order by 2 desc
limit 5;

--ano 2019 
select 
country,
count(country) as contagem_nacionalidades
from hotels 
where is_canceled = 0 and arrival_date_year = '2019' 
group by 1
order by 2 desc
limit 5;

--ano 2020
select 
country,
count(country) as contagem_nacionalidades
from hotels 
where is_canceled = 0 and arrival_date_year = '2020' 
group by 1
order by 2 desc
limit 5;

 
UPDATE hotels 
SET arrival_date_month = 
CASE 
    WHEN arrival_date_month = 'January' THEN 1
    WHEN arrival_date_month = 'February' THEN 2
    WHEN arrival_date_month = 'March' THEN 3
    WHEN arrival_date_month = 'April' THEN 4
    WHEN arrival_date_month = 'May' THEN 5
    WHEN arrival_date_month = 'June' THEN 6
    WHEN arrival_date_month = 'July' THEN 7
    WHEN arrival_date_month = 'August' THEN 8
    WHEN arrival_date_month = 'September' THEN 9
    WHEN arrival_date_month = 'October' THEN 10
    WHEN arrival_date_month = 'November' THEN 11
    WHEN arrival_date_month = 'December' THEN 12
END
WHERE arrival_date_month IN ('January','February','March','April','May','June','July','August','September','October','November','December');

update hotels
set arrival_date_month = 10 where arrival_date_month = 'October';

alter table hotels
alter column arrival_date_month type integer using arrival_date_month::integer; 

select distinct arrival_date_month 
from hotels;

--exportar a tabela hotels 
copy hotels to 
'C:\Users\Public\Documents\hotels.csv'
delimiter ';' csv header;