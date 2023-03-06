--importar os dados das tabelas, como deu erro de não reconhecimento do ficheiro tive que o colocar na pasta public
copy public.tabela_2018(
	hotel,
	is_canceled, 
	lead_time,
	arrival_date_year,
	arrival_date_month,
	arrival_date_week_number,
	arrival_date_day_of_month,
	stays_in_weekend_nights,
	stays_in_week_nights,
	adults,
	children,
	babies,
	meal,
	country,
	market_segment,
	distribution_channel,
	is_repeated_guest,
	previous_cancellations,
	previous_bookings_not_canceled,
	reserved_room_type,
	assigned_room_type,
	booking_changes,
	deposit_type,
	agent,
	company,
	days_in_waiting_list,
	customer_type,
	adr,
	required_car_parking_spaces,
	total_of_special_requests,
	reservation_status,
	reservation_status_date )
from 'C:\Users\Public\Documents\tabela_2018.csv'
delimiter ';' 
csv header;

alter table tabela_2018
alter column company TYPE varchar;

alter table tabela_2018
alter column agent TYPE varchar;

alter table tabela_2018
alter column children TYPE varchar;

--também tive que alterar a dimensão de 2 colunas varchar e alterar a coluna adr para money porque dava erro em numeric (5,2)

--verificação 
select * from tabela_2018;

--tabela_2019

alter table tabela_2019
alter column company TYPE varchar;

alter table tabela_2019
alter column agent TYPE varchar;

alter table tabela_2019
alter column children TYPE varchar;


copy public.tabela_2019(
	hotel,
	is_canceled, 
	lead_time,
	arrival_date_year,
	arrival_date_month,
	arrival_date_week_number,
	arrival_date_day_of_month,
	stays_in_weekend_nights,
	stays_in_week_nights,
	adults,
	children,
	babies,
	meal,
	country,
	market_segment,
	distribution_channel,
	is_repeated_guest,
	previous_cancellations,
	previous_bookings_not_canceled,
	reserved_room_type,
	assigned_room_type,
	booking_changes,
	deposit_type,
	agent,
	company,
	days_in_waiting_list,
	customer_type,
	adr,
	required_car_parking_spaces,
	total_of_special_requests,
	reservation_status,
	reservation_status_date )
from 'C:\Users\Public\Documents\tabela_2019.csv'
delimiter ';' 
csv header;

--verificação 
select * from tabela_2019;

--tabela_2020

alter table tabela_2020
alter column company TYPE varchar;

alter table tabela_2020
alter column agent TYPE varchar;

alter table tabela_2020
alter column children TYPE varchar;

copy public.tabela_2020(
	hotel,
	is_canceled, 
	lead_time,
	arrival_date_year,
	arrival_date_month,
	arrival_date_week_number,
	arrival_date_day_of_month,
	stays_in_weekend_nights,
	stays_in_week_nights,
	adults,
	children,
	babies,
	meal,
	country,
	market_segment,
	distribution_channel,
	is_repeated_guest,
	previous_cancellations,
	previous_bookings_not_canceled,
	reserved_room_type,
	assigned_room_type,
	booking_changes,
	deposit_type,
	agent,
	company,
	days_in_waiting_list,
	customer_type,
	adr,
	required_car_parking_spaces,
	total_of_special_requests,
	reservation_status,
	reservation_status_date )
from 'C:\Users\Public\Documents\tabela_2020.csv'
delimiter ';' 
csv header;

select * from tabela_2020;

--market_segment 
copy public.market_segment(
	discount,
	market_segment)
from 'C:\Users\Public\Documents\market_segment.csv'
delimiter ';' 
csv header;

--estava a dar erro quando queria importar a coluna discount, alterei para money e deu 

--verificação 
select * from market_segment;

--voltei a alterar para numeric 
alter table market_segment
alter column discount type numeric; 

--verificação 
select * from market_segment; 

--meal_cost 
copy public.meal_cost(
	cost,
	meal)
from 'C:\Users\Public\Documents\meal_cost.csv'
delimiter ';' 
csv header;

--verificação
select * from meal_cost; 

--merge das três tabelas 2018, 2019 e 2020
create table hotels as 
		select * from tabela_2018
		union
		select * from tabela_2019
		union 
		select * from tabela_2020;

--verificação 
select * from hotels;

--criar as relações entre as tabelas 
alter table hotels
add constraint fk_meal 
foreign key (meal)
references meal_cost(meal);

alter table hotels
add constraint fk_market_segment
foreign key (market_segment)
references market_segment(market_segment);

