# 🛒 Zepto Product Analytics Dashboard

A complete end-to-end Product Analytics project built using **Python (Pandas & Matplotlib), SQL, and Tableau** to analyze customer orders, revenue, delivery performance, promotions, and payment behavior for a simulated Zepto grocery dataset from Kaggle (real world data may vary, the entire project is for education purpose to study real-world analytics pipeline).

The project demonstrates the complete analytics workflow followed by Product Analysts and Business Analysts—from data cleaning and KPI generation to SQL business analysis and interactive Tableau dashboard creation.

---

# 📌 Project Overview

This project analyzes **650,000+ grocery orders** placed across multiple cities, stores, brands, and payment methods.

The objective was to answer important business questions such as:

- How much revenue is the business generating?
- Which product categories generate maximum revenue?
- Which brands perform the best?
- Are promotions increasing sales?
- What is the average order value?
- What percentage of orders get cancelled?
- Which payment methods are preferred?
- How has revenue changed over time?

The project follows a real-world analytics pipeline:

Raw CSV Files
↓

Python Data Cleaning & Feature Engineering
↓

Exploratory Data Analysis (Pandas + Matplotlib)
↓

SQL Business Analysis
↓

Interactive Tableau Dashboard

---

# 🎯 Business Objective

A Product Analyst at Zepto wants to monitor overall business health by tracking:

- Revenue
- Customer purchasing behaviour
- Order trends
- Delivery performance
- Promotion effectiveness
- Product performance
- Payment preferences

The final deliverable is an interactive Tableau dashboard supported by SQL insights and Python analysis.

---
## 📂 Dataset

This project uses a publicly available retail grocery dataset sourced from **Kaggle** and models a Zepto-like quick commerce business for analytical purposes.

The dataset was used to simulate real-world product analytics workflows, including SQL-based business analysis, exploratory data analysis, KPI development, and dashboard creation.

> **Note:** The dataset is intended for educational and portfolio purposes. Business metrics, customer behavior, and operational insights presented in this project are based on the sample dataset and may not accurately reflect Zepto's actual business performance or internal data.

The project uses multiple relational datasets:

- Customers Information
- Products Information
- Sales Data
- Stores Information
- Promotions Information
- Payments Information

After cleaning and merging, a **Master Dataset** containing over **650,000 records** was created for analysis.

---
# Skills Demonstrated

- Data Cleaning
- Data Wrangling
- Feature Engineering
- Exploratory Data Analysis
- SQL Aggregations
- SQL Window Functions
- SQL Joins
- KPI Development
- Business Analytics
- Dashboard Design
- Data Visualization
- Product Analytics
- Storytelling with Data

---

# 🛠 Tech Stack

| Tool | Purpose |
|-------|----------|
| Python | Data Cleaning & Feature Engineering |
| Pandas | Data Manipulation |
| Matplotlib | Data Visualization |
| SQL | Business Analysis |
| Tableau | Interactive Dashboard |
| VS Code | Development |
| Git & GitHub | Version Control |

---

# 🔄 Project Workflow

## 1. Data Cleaning (Python)

Performed using **Pandas**

### Tasks Performed

- Imported multiple CSV datasets
- Merged relational datasets
- Converted DateTime columns
- Removed duplicate records
- Checked missing values
- Validated null values
- Created Master Dataset
- Generated business features

### Feature Engineering

Created:

- Year
- Month
- Month Name
- Quarter
- Day
- Hour

Created custom business metrics:

- Cancellation Rate
- Delivery Bucket
- Promotion Applied Flag

---

# 📊 Exploratory Data Analysis (Python + Matplotlib)

The following visualizations were created.

---

## Monthly Revenue Trend

Shows revenue growth over time.

![](visuals/monthly_revenue.png)

---

## Revenue by City

Compares city-wise revenue contribution.

![](visuals/revenuebycity.png)

---

## Revenue by Customer Segment

Shows which customer segments generate the highest revenue.

![](visuals/revenuebycustomersegment.png)

---

## Revenue by Brand

Identifies top-performing brands.

![](visuals/revenuebybrand.png)

---

## Top Product Categories

Highlights highest revenue generating product categories.

![](visuals/top10categories.png)

---

## Order Status Distribution

Distribution of completed vs cancelled orders.

![](visuals/orderstatusdist.png)

---

## Payment Method Distribution

Shows customer payment preferences.

![](visuals/paymentmethoddistribution.png)

---

## Delivery Time Distribution

Analyzes delivery performance.

![](visuals/deltime.png)

---

## Promotion Performance

Measures revenue generated under promotional campaigns.

![](visuals/promtype.png)

---

# 🗄 SQL Business Analysis

SQL was used to answer business questions through aggregation, joins and window functions.

## KPI Analysis
### 📊 Executive KPI Summary

| KPI |  Result |
|------|--------:|
| **Total Revenue** | **₹1,308,844,068** |
| **Total Orders** |  **650,000** |
| **Average Order Value (AOV)** |  **₹2,014** |
| **Average Delivery Time** |  **21.01 min** |
| **Cancellation Rate**  | **5.02%** |

---

Calculated:

### 1.Total Revenue
#### SQL Query
```sql
SELECT
ROUND(SUM(NetAmount),2) AS Total_Revenue
FROM sales_data
WHERE OrderStatus='Delivered';
```
---

### 2.Total orders
#### SQL Query
```sql
SELECT
COUNT(*) AS TotalOrders,
COUNT(DISTINCT OrderID) AS UniqueOrders
FROM sales_data;
```
---

### 3.Average Order Value
#### SQL Query
```sql
SELECT
ROUND(AVG(NetAmount),2) AS AOV
FROM sales_data
WHERE OrderStatus='Delivered';
```

### 4.Average Delivery Time
#### SQL Query
```sql
SELECT
ROUND(AVG(DeliveryMinutes),2) Avg_Delivery_Time
FROM sales_data
WHERE OrderStatus='Delivered';
```
---

### 5.Cancellation rate
#### SQL Query
```sql
SELECT
ROUND(
100 * SUM(OrderStatus='Cancelled') / COUNT(*),2
) AS Cancellation_Rate from sales_data;
```

---

## Revenue Analysis

Calculated:

### 1.Revenue by month
#### SQL Query
```sql
SELECT
    DATE_FORMAT(OrderDateTime, '%Y-%m') AS Month,
    ROUND(SUM(NetAmount), 2) AS Revenue
FROM sales_data
WHERE OrderStatus = 'Delivered'
GROUP BY DATE_FORMAT(OrderDateTime, '%Y-%m')
ORDER BY Month;
```
#### output
📄 [View Full SQL Output](visuals/revenuebymonth.csv)

---
### 2.Revenue by Quarter
#### SQL Query
```sql
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

```
#### output
📄 [View Full SQL Output](visuals/revenuebyquarter.csv)

---
### 3.Revenue by year
#### SQL Query
```sql
SELECT
    YEAR(OrderDateTime) AS Year,
    ROUND(SUM(NetAmount), 2) AS Revenue
FROM sales_data
WHERE OrderStatus = 'Delivered'
GROUP BY YEAR(OrderDateTime)
ORDER BY Year;
```
#### output
📄 [View Full SQL Output](visuals/revenuebyyear.csv)

---
### 4.Monthly revenue trend
#### SQL Query
```sql
SELECT
    DATE_FORMAT(OrderDateTime, '%Y-%m') AS Month,
    ROUND(SUM(NetAmount), 2) AS Revenue
FROM sales_data
WHERE OrderStatus = 'Delivered'
GROUP BY DATE_FORMAT(OrderDateTime, '%Y-%m')
ORDER BY DATE_FORMAT(OrderDateTime, '%Y-%m');

```
#### output
📄 [View Full SQL Output](visuals/monthlytrend.csv)

---
### 4.Month-over-Month Revenue Growth
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/momrevenue.csv)

------
### 5.Running Cummulative Revenue 
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/runningcumrevenue.csv)

---

## Product Analysis

Calculated:

### 1.Revenue by category
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/revenuebycat.csv)

---
### 2.Revenue by brand
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/revenuebybrand.csv)

---
### 3.Top Selling Product
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/topselling.csv)

---
### 4.Quantity sold by Product
#### SQL Query
```sql
SELECT
    p.ProductName,
    SUM(s.Quantity) AS Total_Quantity_Sold
FROM sales_data s
JOIN products_information p
ON s.ProductID = p.ProductID
WHERE s.OrderStatus = 'Delivered'
GROUP BY p.ProductName
ORDER BY Total_Quantity_Sold DESC;
```
#### output
📄 [View Full SQL Output](visuals/quantitybyproduct.csv)

---
### 5.Average Selling Price
#### SQL Query
```sql
SELECT
    p.ProductName,
    ROUND(SUM(s.NetAmount) / SUM(s.Quantity), 2) AS Average_Selling_Price
FROM sales_data s
JOIN products_information p
ON s.ProductID = p.ProductID
WHERE s.OrderStatus = 'Delivered'
GROUP BY p.ProductName
ORDER BY Average_Selling_Price DESC;
```
#### output
📄 [View Full SQL Output](visuals/avgsellingprice.csv)

---

## Customer Analysis

Calculated:

### 1.Revenue by city
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/revenuebycity.csv)

---
### 2.Revenue by customer segment
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/revenuebycusseg.csv)

---
### 3.Orders per Customer
#### SQL Query
```sql
SELECT
    c.CustomerName,
    COUNT(s.OrderID) AS Total_Orders
FROM sales_data s
JOIN customers_information c
ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY Total_Orders DESC;
```
#### output
📄 [View Full SQL Output](visuals/orderspercustomer.csv)

---
### 4.Repeat Customer Behaviour
#### SQL Query
```sql
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
) t;merName
ORDER BY Total_Orders DESC;
```
#### output
📄 [View Full SQL Output](visuals/repeatcustomer.csv)

---
### 5.Customer Ranking By Revenue
#### SQL Query
```sql
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

```
#### output
📄 [View Full SQL Output](visuals/customerrank.csv)


---

## Promotion Analysis

Calculated:

### 1.Promotion wise Revenue
#### SQL Query
```sql
SELECT
    p.PromotionType,
    ROUND(SUM(s.NetAmount), 2) AS Revenue
FROM sales_data s
JOIN promotions_information p
ON s.PromotionID = p.PromotionID
WHERE s.OrderStatus = 'Delivered'
GROUP BY p.PromotionType
ORDER BY Revenue DESC;
```
#### output
📄 [View Full SQL Output](visuals/promwiserev.csv)


---
### 2.Promotion Usage
#### SQL Query
```sql
SELECT
    p.PromotionType,
    COUNT(s.OrderID) AS Orders_Using_Promotion
FROM sales_data s
JOIN promotions_information p
ON s.PromotionID = p.PromotionID
GROUP BY p.PromotionType
ORDER BY Orders_Using_Promotion DESC;
```
#### output
📄 [View Full SQL Output](visuals/promotionusage.csv)


---
### 3.Promotion Discount
#### SQL Query
```sql
SELECT
    p.PromotionType,
    ROUND(SUM(s.DiscountAmount), 2) AS Total_Discount
FROM sales_data s
JOIN promotions_information p
ON s.PromotionID = p.PromotionID
GROUP BY p.PromotionType
ORDER BY Total_Discount DESC;
```
#### output
📄 [View Full SQL Output](visuals/promotiondiscount.csv)


---
### 4.Promotion Performance
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/promotionperformance.csv)


---

## Payment Analysis

Calculated:

### 1.Orders by Payment Method
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/orderbypaymentmethod.csv)


---
### 2.Revenue by Payment Method
#### SQL Query
```sql

SELECT
    p.PaymentMethod,
    ROUND(SUM(s.NetAmount), 2) AS Revenue
FROM sales_data s
JOIN payments_information p
ON s.PaymentID = p.PaymentID
WHERE s.OrderStatus = 'Delivered'
GROUP BY p.PaymentMethod
ORDER BY Revenue DESC;
```
#### output
📄 [View Full SQL Output](visuals/revbymethod.csv)


---
### 3.Payment Method Share
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/orderbypaymentmethod.csv)


---

## Delivery Analysis

Calculated:

### 1.Average Delivery Time
#### SQL Query
```sql
SELECT
ROUND(AVG(DeliveryMinutes),2) AS Avg_Delivery_Time
FROM sales_data
WHERE OrderStatus='Delivered';
```
#### output
📄 [View Full SQL Output](visuals/visuals/deltimedist.csv)

---
### 2.Delivery Time Distribution
#### SQL Query
```sql
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

```
#### output
📄 [View Full SQL Output](visuals/deltimedist.csv)


---
### 3.Delivery Perfomance
#### SQL Query
```sql
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
```
#### output
📄 [View Full SQL Output](visuals/adt.csv)

---
# 📈 Tableau Dashboard

Built an executive dashboard containing:

### KPI Cards

- Total Revenue
- Total Orders
- Average Order Value
- Average Delivery Time
- Cancellation Rate

### Charts

- Revenue Trend
- Revenue by Category
- Revenue by Brand
- Payment Method Distribution

Dashboard Screenshot

![](dashboards/dashboard.png)

---

# 💡 Key Business Insights


## 📈 Revenue & Growth

- Generated **₹1.30 Billion** in revenue across **650,000+ orders**, with an **Average Order Value (AOV) of ₹2,014**, indicating healthy basket sizes for a quick-commerce platform.
- Month-over-Month (MoM) revenue remained relatively stable, fluctuating within **±12%** over **27 months (Jan 2023 – Apr 2025)**, suggesting a mature but largely flat growth trajectory.
- Revenue consistently dipped during **February** (−11.66% in 2023 and −9.30% in 2025), likely due to the shorter calendar month rather than reduced customer demand.
- Monthly revenue never exceeded **₹48.3 Million**, indicating potential saturation under the current acquisition and retention strategy.

---

## 🌍 City Performance

- **Chennai** emerged as the highest revenue-generating city with **₹203 Million** across **101K orders**, outperforming both **Delhi (₹182M)** and **Mumbai (₹173M)**.
- **Kolkata, Noida, and Hyderabad** each generated approximately **₹102 Million**, suggesting potential opportunities for geographic expansion through additional dark stores and improved logistics.
- Average delivery time remained remarkably consistent across all cities (**20.93–21.05 minutes**), indicating either highly standardized operations or limited variability in the sample dataset.

---

## 🛍️ Category Performance

- Revenue distribution was highly balanced across all **8 product categories**, with **Beverages (₹160.5M)** leading and **Dairy (₹136.7M)** contributing the least—a difference of only about **15%**.
- Such uniform category performance is uncommon in grocery retail, where staples usually dominate, suggesting either a well-balanced product catalog or characteristics of the sample dataset.
- **Frozen Foods** generated relatively high revenue despite fewer orders, indicating a higher average order value and potential premium product opportunity.

---

## 👥 Customer Segments

- Customer segment analysis indicates a possible **data quality limitation**.
- **Regular customers** generated significantly higher revenue than **Premium customers**, which contradicts typical customer value patterns.
- This suggests that the segment labels may not follow standard RFM segmentation, so product decisions based solely on this segmentation should be interpreted with caution.

---

## 🎯 Promotion Performance

- All four promotion types (**Flat Discount, Percentage Discount, BOGO, and Free Delivery**) delivered nearly identical average discounts (**₹287–289**) and Average Order Values (**₹2,006–2,019**).
- **Free Delivery** generated the highest order volume (**182,994 orders**) but the lowest AOV, indicating strong customer acquisition but limited basket expansion.
- **Flat Discounts** achieved a similar order volume while maintaining the highest AOV, making them the most efficient promotion type in this dataset.
- The minimal performance difference across promotion types suggests opportunities for **A/B testing discount strategies** rather than applying similar incentives across all campaigns.

---

## 🚚 Delivery Performance

- Approximately **48.9%** of delivered orders were completed within **11–30 minutes**, aligning with Zepto's quick-commerce promise.
- Only **10.9%** of orders were delivered within **10 minutes**, while **14.5%** required more than **30 minutes**, representing a potential source of customer dissatisfaction.
- Delivery times showed minimal variation across cities, which may indicate highly standardized operations or a limitation of the underlying dataset.

---

## 💳 Payment Behaviour

- **UPI** dominated customer transactions, accounting for approximately **65%** of all orders, reflecting India's digital payment ecosystem.
- **Cash on Delivery** still represented around **5%** of orders, highlighting the importance of maintaining a reliable COD experience.
- **Credit Cards** and **Wallets** together contributed approximately **22%** of all transactions, representing a customer segment that may respond well to cashback and loyalty initiatives.


---

# ▶️ How to Run

## Clone Repository

```bash
git clone https://github.com/yourusername/zepto-product-analytics.git
```

---

## Install Dependencies

```bash
pip install pandas matplotlib notebook
```

---

## Run Notebook

```bash
jupyter notebook
```

Open:

```
Product_Analytics.ipynb
```

---

## Open Dashboard

Open

```
zepto_product_dashboard.twb
```

using Tableau Public Desktop.

---

# 🚀 Product Recommendations

The insights generated from this analytics project served as the foundation for a separate Product Management case study, where business problems were translated into product opportunities and feature recommendations.

Using the findings from this analysis, the following Product Management frameworks were applied:

- 📌 Product Opportunity Mapping (POM)
- 📈 AARRR Funnel Analysis
- ⭐ North Star Metric (NSM)
- 🎯 RICE Prioritization Framework
- 📄 Product Roadmap
- 📝 Product Requirements Document (PRD)

The objective was to move beyond descriptive analytics and demonstrate how data-driven insights can be converted into product decisions, prioritization, and execution planning.

This repository focuses on generating business insights from data. The companion Product Management repository demonstrates how these insights were transformed into actionable product initiatives, prioritized using industry-standard frameworks

➡️ **Continue to the Product Management Repository:**

🔗 [Product Recommendation](https://github.com/rohan17dtu/zepto-ai-product-strategy)

---

# 👨‍💻 Author

**Rohan Sharma**

DTU | Civil Engineering

Aspiring Product Analyst | Business Analyst | Data Analyst

Tech Stack:

Python • SQL • Tableau • Excel • Pandas • Matplotlib
