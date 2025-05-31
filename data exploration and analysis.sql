select*from pizza_sales;



-- daily trend

SELECT 
    DAYNAME(STR_TO_DATE(TRIM(order_date), '%d-%m-%Y')) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
WHERE 
    STR_TO_DATE(TRIM(order_date), '%d-%m-%Y') IS NOT NULL
GROUP BY 
    DAYNAME(STR_TO_DATE(TRIM(order_date), '%d-%m-%Y')),
    DAYOFWEEK(STR_TO_DATE(TRIM(order_date), '%d-%m-%Y'))
ORDER BY 
    DAYOFWEEK(STR_TO_DATE(TRIM(order_date), '%d-%m-%Y'));


-- hourly trend
select*from pizza_sales;

SELECT 
    HOUR(order_time) AS order_hours,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    HOUR(order_time)
ORDER BY 
    order_hours;
    
    
  -- percentage of sales by catagory
  

  
  select pizza_category,sum(total_price)as total_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales where month(STR_TO_DATE(TRIM(order_date), '%d-%m-%Y'))= 1) as PCT
  from pizza_sales 
  where month(STR_TO_DATE(TRIM(order_date), '%d-%m-%Y'))= 1
  group by pizza_category;
  
  
-- percentage of sales by pizza size

select pizza_size,sum(total_price)as total_sales, sum(total_price)*100/
(select sum(total_price) from pizza_sales WHERE QUARTER(STR_TO_DATE(TRIM(order_date), '%d-%m-%Y'))= 1) as percentage_sales_size
  from pizza_sales 
  WHERE QUARTER(STR_TO_DATE(TRIM(order_date), '%d-%m-%Y'))= 1

  
  group by pizza_size
  order by percentage_sales_size;
  
  -- pizza sold with respect to cattagory
  select pizza_category,sum(quantity)as total_pizza_sold
  from pizza_sales
  group by pizza_category;
  
  -- top5 best sellers 
  select  pizza_name , sum(quantity) as total_pizza_sold
  from pizza_sales
  group by pizza_name
  order by total_pizza_sold desc limit 5;
  
  -- top 5 worst sellers
  
  select  pizza_name , sum(quantity) as total_pizza_sold
  from pizza_sales
  group by pizza_name
  order by total_pizza_sold  limit 5;
  