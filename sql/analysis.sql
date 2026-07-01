CREATE DATABASE zepto_analysis;
USE zepto_analysis;
SHOW TABLES;
SELECT

SUM(OrderID IS NULL) AS OrderID,

SUM(OrderDateTime IS NULL) AS OrderDateTime,

SUM(CustomerID IS NULL) AS CustomerID,

SUM(ProductID IS NULL) AS ProductID,

SUM(StoreID IS NULL) AS StoreID,

SUM(NetAmount IS NULL) AS NetAmount

FROM sales_data;
SELECT

COUNT(*) AS TotalOrders,

COUNT(DISTINCT OrderID) AS UniqueOrders

FROM sales_data;

SELECT OrderStatus,
COUNT(*) AS Orders
FROM sales_data
GROUP BY OrderStatus;

SELECT PaymentMethod,
COUNT(*)
FROM sales_data s
JOIN payments_information p
ON s.PaymentID = p.PaymentID
GROUP BY PaymentMethod;

ALTER TABLE sales_data
MODIFY OrderDateTime DATETIME;

ALTER TABLE customers_information
MODIFY SignupDate DATE;

SELECT
ROUND(SUM(NetAmount),2) AS Total_Revenue
FROM sales_data
WHERE OrderStatus='Delivered';
SELECT

COUNT(*) AS Total_Orders

FROM sales_data

WHERE OrderStatus='Delivered';

SELECT
ROUND(AVG(NetAmount),2) AS AOV
FROM sales_data
WHERE OrderStatus='Delivered';

SELECT

p.Category,

ROUND(SUM(s.NetAmount),2) AS Revenue,

COUNT(*) AS Orders

FROM sales_data s

JOIN products_information p

ON s.ProductID=p.ProductID

WHERE s.OrderStatus='Delivered'

GROUP BY p.Category

ORDER BY Revenue DESC;

SELECT
st.City,
ROUND(SUM(s.NetAmount),2) AS Revenue,
COUNT(*) AS Orders
FROM sales_data s
JOIN stores_information st
ON s.StoreID=st.StoreID
WHERE s.OrderStatus='Delivered'
GROUP BY st.City
ORDER BY Revenue DESC;

SELECT
p.ProductName,
ROUND(SUM(s.NetAmount),2) AS Revenue,
COUNT(*) AS Orders
FROM sales_data s
JOIN products_information p
ON s.ProductID=p.ProductID
WHERE s.OrderStatus='Delivered'
GROUP BY p.ProductName
ORDER BY Revenue DESC
LIMIT 10;

SELECT
p.Brand,
ROUND(SUM(s.NetAmount),2) AS Revenue,
COUNT(*) AS Orders
FROM sales_data s
JOIN products_information p
ON s.ProductID=p.ProductID
WHERE s.OrderStatus='Delivered'
GROUP BY p.Brand
ORDER BY Revenue DESC;


SELECT
ROUND(
100 * SUM(OrderStatus='Cancelled') / COUNT(*),2
) AS Cancellation_Rate from sales_data;

SELECT
ROUND(
100 * SUM(OrderStatus='Returned') / COUNT(*),2
) AS Return_Rate from sales_data;

SELECT
OrderStatus,
COUNT(*) Orders,
ROUND(100*COUNT(*)/(SELECT COUNT(*) FROM sales_data),2) Percentage
FROM sales_data
GROUP BY OrderStatus;

SELECT
ROUND(AVG(DeliveryMinutes),2) Avg_Delivery_Time
FROM sales_data
WHERE OrderStatus='Delivered';

SELECT
ROUND(
100 * SUM(DeliveryMinutes<=10)/COUNT(*),2
) AS On_Time_Delivery
FROM sales_data
WHERE OrderStatus='Delivered';

SELECT
ROUND(SUM(NetAmount),2) Revenue_Lost
FROM sales_data
WHERE OrderStatus='Cancelled';

SELECT
ROUND(SUM(NetAmount),2) Revenue_Lost
FROM sales_data
WHERE OrderStatus='Returned';

-- SELECT
-- ROUND(AVG(DiscountAmount),2) Avg_Discount,
-- ROUND(AVG(DiscountAmount/NULLIF(GrossAmount,0))*100,2) Avg_Discount_Percentage
-- FROM sales_data

SELECT COUNT(DISTINCT CustomerID) AS Total_Customers
FROM sales_data;

SELECT

ROUND(COUNT(*)/COUNT(DISTINCT CustomerID),2) AS Avg_Orders_Per_Customer

FROM sales_data;

SELECT
ROUND(
100.0 *
COUNT(DISTINCT CASE WHEN orders > 1 THEN CustomerID END) /
COUNT(DISTINCT CustomerID),2
) AS Repeat_Purchase_Rate
FROM (
    SELECT CustomerID, COUNT(*) AS orders
    FROM sales_data
    GROUP BY CustomerID
) t;

SELECT
ROUND(AVG(Quantity),2) AS Avg_Items_Per_Order
FROM sales_data
WHERE OrderStatus='Delivered';

SELECT
CustomerID,
COUNT(*) AS Orders,
ROUND(SUM(NetAmount),2) AS Revenue
FROM sales_data
WHERE OrderStatus='Delivered'
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 10;

SELECT
CustomerSegment,
COUNT(*) Customers
FROM customers_information
GROUP BY CustomerSegment;

SELECT
c.CustomerSegment,
ROUND(SUM(s.NetAmount),2) Revenue,
COUNT(*) Orders
FROM sales_data s
JOIN customers_information c
ON s.CustomerID=c.CustomerID
WHERE s.OrderStatus='Delivered'
GROUP BY c.CustomerSegment
ORDER BY Revenue DESC;


SELECT
ROUND(AVG(DeliveryMinutes),2) AS Avg_Delivery_Time
FROM sales_data
WHERE OrderStatus='Delivered';

SELECT
CASE
WHEN DeliveryMinutes <= 10 THEN '0-10 min'
WHEN DeliveryMinutes <= 20 THEN '11-20 min'
WHEN DeliveryMinutes <= 30 THEN '21-30 min'
ELSE '30+ min'
END AS Delivery_Bucket,
COUNT(*) AS Orders
FROM sales_data
WHERE OrderStatus='Delivered'
GROUP BY Delivery_Bucket
ORDER BY Delivery_Bucket;

SELECT
st.City,
ROUND(AVG(s.DeliveryMinutes),2) AS Avg_Delivery_Time,
COUNT(*) AS Orders
FROM sales_data s
JOIN stores_information st
ON s.StoreID=st.StoreID
WHERE s.OrderStatus='Delivered'
GROUP BY st.City
ORDER BY Avg_Delivery_Time;

SELECT
p.PaymentMethod,
COUNT(*) AS Orders,
ROUND(COUNT(*)*100.0/
(SELECT COUNT(*) FROM sales_data),2) AS Percentage
FROM sales_data s
JOIN payments_information p
ON s.PaymentID=p.PaymentID
GROUP BY p.PaymentMethod
ORDER BY Orders DESC;

SELECT
pr.PromotionType,
ROUND(AVG(s.DiscountAmount),2) AS Avg_Discount,
ROUND(AVG(s.NetAmount),2) AS Avg_Order_Value,
COUNT(*) AS Orders
FROM sales_data s
JOIN promotions_information pr
ON s.PromotionID=pr.PromotionID
GROUP BY pr.PromotionType
ORDER BY Avg_Discount DESC;

SELECT
st.City,
COUNT(*) AS Orders,
ROUND(SUM(s.NetAmount),2) AS Revenue,
ROUND(AVG(s.DeliveryMinutes),2) AS Avg_Delivery
FROM sales_data s
JOIN stores_information st
ON s.StoreID=st.StoreID
GROUP BY st.City
ORDER BY Revenue DESC;