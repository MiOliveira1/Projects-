--copiar dados
-- 1ª tabela products
-- 2ª tabela geolocation
-- 3ª criação da tabela unique_zip_code para consegiur relacionar 
-- 4ª criação da tabela temporária para merge dos códigos postais não existentes na tabela unique_zip_code
-- 5ª tabela customers 
-- 6ª orders
-- 7ª orders_payment
-- 8ª orders_review 
-- 9ª orders_items 


copy sellers_dataset(
	seller_id,
	"seller_zip_code_prefix",
	"seller_city",
	"seller_state")
from 'C:\Users\Public\Documents\E-commerce Business Performance\sellers_dataset.csv'
with (format csv, header, delimiter ',');

select * from sellers_dataset;

copy orders_dataset(
	order_id,
	"customer_id",
	"order_status",
	"order_purchase_timestamp",
	"order_approved_at",
	"order_delivered_carrier_date",
	"order_delivered_customer_date",
	"order_estimated_delivery_date")
from 'C:\Users\Public\Documents\E-commerce Business Performance\orders_dataset.csv'
with (format csv, header, delimiter ',');

select * from orders_dataset;

copy payments_dataset(
	order_id,
	"payment_sequential",
	"payment_type",
	"payment_installments",
	"payment_value")
from 'C:\Users\Public\Documents\E-commerce Business Performance\order_payments_dataset.csv'
with (format csv, header, delimiter ',');

select * from payments_dataset;

--a review_id não podia ser chave primária pois estava repetida, então considerei como chave primária 
--a review_id e a order_id 

alter table order_reviews_dataset
add constraint pk_order_review
primary key (review_id, order_id);

copy order_reviews_dataset(
	review_id,
	"order_id",
	"review_score",
	"review_comment_title",
	"review_comment_message",
	"review_creation_date",
	"review_answer_timestamp")
from 'C:\Users\Public\Documents\E-commerce Business Performance\order_reviews_dataset.csv'
with (format csv, header, delimiter ',');

select * from payments_dataset;

copy order_items_dataset(
	order_id,
	"order_item_id",
	"product_id",
	"seller_id",
	"shipping_limit_date",
	"price",
	"freight_value")
from 'C:\Users\Public\Documents\E-commerce Business Performance\order_items_dataset.csv'
with (format csv, header, delimiter ',');

select * from order_items_dataset;