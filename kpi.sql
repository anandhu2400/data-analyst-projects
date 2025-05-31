select*from pizza_sales;
-- the total revenue
select sum(total_price) as total_revenue from pizza_sales;

select*from pizza_sales;
-- average order value
select sum(total_price) / count(distinct order_id) as average_order_value from pizza_sales;

-- total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales;
-- total orders placed
select count(distinct order_id) as Total_orders from pizza_sales;
-- avrerage pizza per order
select sum(quantity) / count(distinct order_id) as Average_pizza_perorder from pizza_sales
