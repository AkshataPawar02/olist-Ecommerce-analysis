CREATE DATABASE olist_store_analysis;
use olist_store_analysis;

-- Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
select 
    case
    when dayofweek(order_purchase_timestamp) in(1,7) then 'Weekend'
    else 'Weekday'
    end as `Day`,
    round(sum(payment_value),2) as 'Total payment'
from
	olist_orders_dataset
    inner join
    olist_order_payments_dataset
    using (order_id)
    
group by 
	`Day`;
    -- Number of Orders with review score 5 and payment type as credit card. 
   
    select
	count(payment_type) as `Number of Orders` 
from
	olist_order_payments_dataset
where
	payment_type = 'credit_card' and 
    order_id in
				(select 
						order_id
				 from
						olist_order_reviews_dataset
				 where
						review_score = 5);
                        
	-- Average number of days taken for order_delivered_customer_date for pet_shop  
    
SELECT
	round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),0) as `Average Delivery Time`
FROM
	olist_orders_dataset
    left join
    olist_order_items_dataset
    using (order_id)
    left join
    olist_products_dataset
    using (product_id)
where product_category_name = 'pet_shop' and order_delivered_customer_date is not null;

-- 4. Average price and payment values from customers of sao paulo city


select
	round(avg(payment_value),2) as 'Average payment',
    round(avg(price),2) as 'Average Price'
from
	olist_customers_dataset
    left join
    olist_orders_dataset
    using (customer_id)
    left join
    olist_order_payments_dataset
    using (order_id)
    left join
    olist_order_items_dataset
    using (order_id)
where
	customer_city = 'sao paulo';
    
use olist_store_analysis;

-- Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.

SELECT
	distinct(review_score) as 'Review Score',
    round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),0) as 'Average Delivery Time'
FROM
	olist_orders_dataset
    left join
    olist_order_reviews_dataset
    using(order_id)
where
	order_delivered_customer_date is not null and
    review_score is not null
group by
	review_score
order by
	review_score;





                        
                        
                        
    
    