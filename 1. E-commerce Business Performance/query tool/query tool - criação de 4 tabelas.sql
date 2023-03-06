CREATE TABLE IF NOT EXISTS order_reviews_dataset(
	review_id VARCHAR (40),
	"order_id" VARCHAR (40),
	"review_score" int,
	"review_comment_title" VARCHAR (40),
	"review_comment_message" VARCHAR(500),
	"review_creation_date" TIMESTAMP,
	"review_answer_timestamp" TIMESTAMP
);

COPY order_reviews_dataset(
	review_id,
	"order_id",
	"review_score",
	"review_comment_title",
	"review_comment_message",
	"review_creation_date",
	"review_answer_timestamp")
FROM 'C:\Users\Public\Documents\E-commerce Business Performance\order_reviews_dataset.csv'
with (FORMAT CSV, HEADER,DELIMITER ','); 

select * from order_reviews_dataset;

CREATE TABLE IF NOT EXISTS orders_dataset(
	order_id VARCHAR (40),
	"customer_id" VARCHAR(40),
	"order_status" VARCHAR (20),
	"order_purchase_timestamp" TIMESTAMP,
	"order_approved_at" TIMESTAMP,
	"order_delivered_carrier_date" TIMESTAMP,
	"order_delivered_customer_date" TIMESTAMP,
	"order_estimated_delivery_date" TIMESTAMP
); 

COPY orders_dataset(
	order_id,
	"customer_id",
	"order_status",
	"order_purchase_timestamp",
	"order_approved_at",
	"order_delivered_carrier_date",
	"order_delivered_customer_date",
	"order_estimated_delivery_date")
FROM 'C:\Users\Public\Documents\E-commerce Business Performance\orders_dataset.csv'
with (FORMAT CSV, HEADER,DELIMITER ','); 

select * from orders_dataset;

CREATE TABLE IF NOT EXISTS product_dataset(
	id serial, --id é sequencial 
	product_id VARCHAR(40),
	product_category_name VARCHAR(100),
	product_name_lenght numeric,
	product_description_lenght numeric,
	product_photos_qty numeric,
	product_weight_g numeric,
	product_length_cm numeric,
	product_height_cm numeric,
	product_width_cm numeric 
);

COPY product_dataset(
	id,
	product_id,
	product_category_name,
	product_name_lenght,
	product_description_lenght,
	product_photos_qty,
	product_weight_g,
	product_length_cm,
	product_height_cm,
	product_width_cm)
FROM 'C:\Users\Public\Documents\E-commerce Business Performance\product_dataset.csv'
with (FORMAT CSV, HEADER,DELIMITER ','); 

select * from product_dataset;

CREATE TABLE IF NOT EXISTS sellers_dataset(
	seller_id VARCHAR (40),
	"seller_zip_code_prefix" int,
	"seller_city" VARCHAR(40),
	"seller_state" VARCHAR(10)
);


COPY sellers_dataset(
	seller_id,
	"seller_zip_code_prefix",
	"seller_city",
	"seller_state")
FROM 'C:\Users\Public\Documents\E-commerce Business Performance\sellers_dataset.csv'
with (FORMAT CSV, HEADER,DELIMITER ','); 

SELECT * FROM sellers_dataset; 
