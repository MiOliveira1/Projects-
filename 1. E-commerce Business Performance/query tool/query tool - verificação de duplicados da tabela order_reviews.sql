alter table order_reviews_dataset 
add constraint pk_reviews
primary key (review_id);

select * from order_reviews_dataset
where review_id = '9e25d6e3025e9b9a0fc7f03588d33e2b'; --são duplicados 

select * from orders_dataset
where order_id in('869997fbe01f39d184956b5c6bccfdbe', '0d3adebce4bebc1f80a7f36e9833f497','52b7fa35b1e5c8bdea5869804dced415');
-- verifico que são 3 duplicados sendo que 2 foram cancelados e têm missing values 

delete from orders_dataset
where order_id in ('869997fbe01f39d184956b5c6bccfdbe','0d3adebce4bebc1f80a7f36e9833f497');

--tenho que apagar estes estes registos nas outras tabelas, senão dá erro 
select * from payments_dataset
where order_id in ('0d3adebce4bebc1f80a7f36e9833f497', '869997fbe01f39d184956b5c6bccfdbe');

delete from payments_dataset
where order_id in ( '0d3adebce4bebc1f80a7f36e9833f497', '869997fbe01f39d184956b5c6bccfdbe');

select * from order_reviews_dataset
where order_id in ('0d3adebce4bebc1f80a7f36e9833f497', '869997fbe01f39d184956b5c6bccfdbe');

delete from order_reviews_dataset
where order_id in ( '0d3adebce4bebc1f80a7f36e9833f497', '869997fbe01f39d184956b5c6bccfdbe');

--criar as relações entre as tabelas com orders_dataset 
alter table payments_dataset
add constraint fk_order_id
foreign key (order_id)
references orders_dataset(order_id);

alter table order_reviews_dataset
add constraint fk_order_id 
foreign key (order_id)
references orders_dataset(order_id);

alter table order_reviews_dataset
add constraint pk_review_id
primary key (review_id);

-- não deixa, tem mais duplicados

--verificar os duplicados da tabela orders_reviews
SELECT review_id, COUNT(*) as num_duplicados
FROM order_reviews_dataset
GROUP BY review_id
HAVING COUNT(*) > 1; --788 duplicados 

--criar chave primária como estava 
alter table order_reviews_dataset
add constraint pk_review_id
primary key (review_id, order_id);




