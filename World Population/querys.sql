--criar a tabela 
create table if not exists world_population (
	Rank int primary key,
	CCA3 varchar (10),
	"Country/Territory" varchar (20),
	Capital varchar (20),
	Continent varchar (20),
	"2022 Population" integer,
	"2020 Population" integer,
	"2015 Population" integer,
	"2010 Population" integer,
	"2000 Population" integer,
	"1990 Population" integer,
	"1980 Population" integer,
	"1970 Population" integer,
	"Area (kmÂ²)" numeric,
	"Density (per kmÂ²)" numeric,
	"Growth Rate" numeric,
	"World Population Percentage" numeric
);

select * from world_population;

--importar dados 
copy world_population (
	Rank,
	CCA3,
	"Country/Territory",
	Capital,
	Continent,
	"2022 Population",
	"2020 Population",
	"2015 Population",
	"2010 Population",
	"2000 Population",
	"1990 Population",
	"1980 Population",
	"1970 Population",
	"Area (kmÂ²)",
	"Density (per kmÂ²)",
	"Growth Rate",
	"World Population Percentage"
)
from 'C:\Users\Public\Documents\world_population.csv'
delimiter ',' csv header;

--verificação
select * from world_population
order by rank; 

--colunas e tipos de dados da tabela criada 
SELECT
column_name,
data_type,
table_catalog,
table_name,
ordinal_position,
is_nullable,
table_schema
FROM
information_schema.columns
WHERE table_name = 'world_population';

--só soluna e tipo de dados 
SELECT
column_name,
data_type
FROM
information_schema.columns
WHERE table_name = 'world_population';

select "Area (kmÂ²)" from world_population;

--vou alterar o nome de algumas das colunas para facilitar a elaboração das querys 
ALTER TABLE world_population
RENAME COLUMN "Country/Territory" TO Country;

ALTER TABLE world_population
RENAME COLUMN "Area (kmÂ²)" TO Area;

ALTER TABLE world_population
RENAME COLUMN "Density (per kmÂ²)" TO Density;

--verificação
select * from world_population;

--how many disctinct coutries are contained in the table? 
select 
count (distinct country)
from world_population; --234 

--what will be the average population of each continent in 2022? 
select 
Continent,
round(avg("2022 Population"),0) as average_population_22
from world_population
group by 1
order by 2 desc;

--what is the highest and lowest population size in 2022? 
select 
max("2022 Population") as highest_population_22,
min("2022 Population") as lowest_population_22
from world_population;

select 
country
from world_population
where "2022 Population" = 1425887337; -- China 

select 
country
from world_population
where "2022 Population" = 510; -- Vatican City 

--what are the top 10 most populated countries in 2015?
select 
country,
"2015 Population"
from world_population
order by 2 desc
limit 10;

--what are the 10 least populated countries in 2015? 
select
country,
"2015 Population"
from world_population
order by 2
limit 10;

--order continents by its population in 2022
select 
continent,
sum("2022 Population") as population_per_continent_22
from world_population
group by continent
order by 2 desc;

--what countries have a total population that is greater than the average population? 
select 
country, 
"2022 Population" 
from world_population
where "2022 Population" > (
	select avg("2022 Population")
	from world_population
	)
order by 2 desc;

	
--what is the fastest and slowest rate of population growth? 
select 
max("Growth Rate") as max_growth,  
min("Growth Rate") as min_growth 
from world_population;

select 
country
from world_population
where "Growth Rate" = 1.0691; -- Moldova

select 
country
from world_population
where "Growth Rate" = 0.912; -- Ukraine 

--what is the largest and smallest area? 
select 
max(area) as max_area,
min(area) as min_area
from world_population;

select 
country
from world_population
where area = 17098242; --Russia 

select 
country 
from world_population
where area = 1;  --Vatican City 

--create a new field for area sizes and return the country, continent, country code, and area. Order them in descending order
select 
country,
continent,
cca3,
area,
case 
	when area > 2000000 then 'large'
	when area > 4000 then 'medium'
	else 'small'
	end as area_sizes 
from world_population
order by area_sizes;
