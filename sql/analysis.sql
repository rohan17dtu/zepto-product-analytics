CREATE DATABASE zepto_analysis;
USE zepto_analysis;
SHOW TABLES;

SELECT
SUM(OrderID IS NULL) AS OrderID,
SUM(OrderDateTime IS NULL) AS OrderDateTime,
SUM(CustomerID IS NULL) AS CustomerID,
SUM(ProductID IS NULL) AS ProductID,
SUM(StoreID IS NULL) AS StoreID,
SUM(NetAmount IS NULL) AS NetAmount FROM sales_data;

## Total Revenue
SELECT SUM(NetAmount) AS Total_Revenue FROM sales_data;

## Total Orders
SELECT COUNT(*) AS TotalOrders, COUNT(DISTINCT OrderID) AS UniqueOrders FROM sales_data;

## orders status
SELECT OrderStatus,
COUNT(*) AS Orders
FROM sales_data
GROUP BY OrderStatus;

##revenue-bymonth
    SELECT
    DATE_FORMAT(OrderDateTime, '%Y-%m') AS Month,
    ROUND(SUM(NetAmount), 2) AS Revenue
FROM sales_data
WHERE OrderStatus = 'Delivered'
GROUP BY DATE_FORMAT(OrderDateTime, '%Y-%m')
ORDER BY Month;

##revenue byquater
  WITH quarterly_revenue AS (
SELECT
    YEAR(OrderDateTime) AS Year,
    QUARTER(OrderDateTime) AS Quarter,
    SUM(NetAmount) AS Revenue
FROM sales_data
WHERE OrderStatus='Delivered'
GROUP BY
    YEAR(OrderDateTime),
    QUARTER(OrderDateTime)
    )
SELECT
    CONCAT(Year,'-Q',Quarter) AS Quarter,
    ROUND(Revenue,2) AS Revenue
FROM quarterly_revenue
ORDER BY Year, Quarter;

##revenue byyear
    SELECT
    YEAR(OrderDateTime) AS Year,
    ROUND(SUM(NetAmount), 2) AS Revenue
FROM sales_data
WHERE OrderStatus = 'Delivered'
GROUP BY YEAR(OrderDateTime)
ORDER BY Year;

##monthlytrend
    SELECT
    DATE_FORMAT(OrderDateTime, '%Y-%m') AS Month,
    ROUND(SUM(NetAmount), 2) AS Revenue
FROM sales_data
WHERE OrderStatus = 'Delivered'
GROUP BY DATE_FORMAT(OrderDateTime, '%Y-%m')
ORDER BY DATE_FORMAT(OrderDateTime, '%Y-%m');


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

## average orders value
SELECT
ROUND(AVG(NetAmount),2) AS AOV
FROM sales_data
WHERE OrderStatus='Delivered';

##revenuebycat
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

##TOP SELLING
SELECT
p.ProductName,
ROUND(SUM(s.NetAmount),2) AS Revenue,
COUNT(*) AS Orders
FROM sales_data s
JOIN products_information p
ON s.ProductID=p.ProductID
WHERE s.OrderStatus='Delivered'
GROUP BY p.ProductName
ORDER BY Orders DESC
LIMIT 10;

##quantityby product
SELECT
    p.ProductName,
    SUM(s.Quantity) AS Total_Quantity_Sold
FROM sales_data s
JOIN products_information p
ON s.ProductID = p.ProductID
WHERE s.OrderStatus = 'Delivered'
GROUP BY p.ProductName
ORDER BY Total_Quantity_Sold DESC;

##revenuebybrand
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

##avg selling price
SELECT
    p.ProductName,
    ROUND(SUM(s.NetAmount) / SUM(s.Quantity), 2) AS Average_Selling_Price
FROM sales_data s
JOIN products_information p
ON s.ProductID = p.ProductID
WHERE s.OrderStatus = 'Delivered'
GROUP BY p.ProductName
ORDER BY Average_Selling_Price DESC;

## cancellation rate 
SELECT
ROUND(
100 * SUM(OrderStatus='Cancelled') / COUNT(*),2
) AS Cancellation_Rate from sales_data;

## orders per customer
SELECT
    c.CustomerName,
    COUNT(s.OrderID) AS Total_Orders
FROM sales_data s
JOIN customers_information c
ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY Total_Orders DESC;

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

## average delivery time
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

##repeat purchase rate
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

#revenuebycusseg
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

## avg del time
SELECT
ROUND(AVG(DeliveryMinutes),2) AS Avg_Delivery_Time
FROM sales_data
WHERE OrderStatus='Delivered';

## del time dist
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

## del perfomance
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

##ordersby payment method 
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

##revenue by payment method
SELECT
    p.PaymentMethod,
    ROUND(SUM(s.NetAmount), 2) AS Revenue
FROM sales_data s
JOIN payments_information p
ON s.PaymentID = p.PaymentID
WHERE s.OrderStatus = 'Delivered'
GROUP BY p.PaymentMethod
ORDER BY Revenue DESC;

##prom wise rev
SELECT
    p.PromotionType,
    ROUND(SUM(s.NetAmount), 2) AS Revenue
FROM sales_data s
JOIN promotions_information p
ON s.PromotionID = p.PromotionID
WHERE s.OrderStatus = 'Delivered'
GROUP BY p.PromotionType
ORDER BY Revenue DESC;

##prom usage
    SELECT
    p.PromotionType,
    COUNT(s.OrderID) AS Orders_Using_Promotion
FROM sales_data s
JOIN promotions_information p
ON s.PromotionID = p.PromotionID
GROUP BY p.PromotionType
ORDER BY Orders_Using_Promotion DESC;

#prom discount
SELECT
    p.PromotionType,
    ROUND(SUM(s.DiscountAmount), 2) AS Total_Discount
FROM sales_data s
JOIN promotions_information p
ON s.PromotionID = p.PromotionID
GROUP BY p.PromotionType
ORDER BY Total_Discount DESC;

##prom performance
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

#revenuebycity
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

#month-over-month revenue growth
    
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(OrderDateTime,'%Y-%m') AS Month,
        SUM(NetAmount) AS Revenue
    FROM sales_data
    GROUP BY DATE_FORMAT(OrderDateTime,'%Y-%m')
)

SELECT
    Month,
    Revenue,
    LAG(Revenue) OVER(ORDER BY Month) AS Previous_Month_Revenue,

    ROUND(
        (
            Revenue - LAG(Revenue) OVER(ORDER BY Month)
        )
        /
        LAG(Revenue) OVER(ORDER BY Month)
        *100,
        2
    ) AS MoM_Growth_Percentage

FROM monthly_revenue;

##customer rank by revenue generated
SELECT
    c.CustomerName,
    SUM(s.NetAmount) AS Total_Revenue,

    RANK() OVER(
        ORDER BY SUM(s.NetAmount) DESC
    ) AS Revenue_Rank

FROM sales_data s

JOIN customers_information c
ON s.CustomerID = c.CustomerID

GROUP BY c.CustomerID,c.CustomerName;


##running revenue
WITH daily_revenue AS (

SELECT

DATE(OrderDateTime) AS OrderDate,

SUM(NetAmount) AS Revenue

FROM sales_data

GROUP BY DATE(OrderDateTime)

)

SELECT

OrderDate,

Revenue,

SUM(Revenue)
OVER(
ORDER BY OrderDate
) AS Running_Revenue

FROM daily_revenue;
