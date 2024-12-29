CREATE database ecommerce;
use ecommerce;
SELECT * FROM e_commerce_customer_analytics LIMIT 10;
#--Track retention and revenue trends by cohort (based on Cohort_Month)--
SELECT Cohort_Month, 
       COUNT(DISTINCT Customer_ID) AS Total_Customers,
       SUM(Order_Amount) AS Total_Revenue,
       AVG(Conversion_Rate) AS Avg_Conversion_Rate
FROM e_commerce_customer_analytics
GROUP BY Cohort_Month
ORDER BY Cohort_Month;


#---Analyze the customer journey (Signup → Purchase → Return)--
SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers_Signed_Up,
       COUNT(DISTINCT CASE WHEN Return_Status = 'Not Returned' THEN Customer_ID END) AS Total_Customers_Converted,
       COUNT(DISTINCT CASE WHEN Return_Status = 'Returned' THEN Customer_ID END) AS Total_Customers_Returned
FROM e_commerce_customer_analytics;

#---Segment customers based on their purchase behavior--

SELECT Customer_ID,
       DATEDIFF(CURRENT_DATE, MAX(STR_TO_DATE(Order_Date, '%m/%d/%Y'))) AS Recency,
       COUNT(Order_ID) AS Frequency,
       SUM(Order_Amount) AS Monetary
FROM e_commerce_customer_analytics
GROUP BY Customer_ID;

#---Analyze the conversion rate from signup to purchase--
SELECT Cohort_Month, 
       AVG(Conversion_Rate) AS Avg_Conversion_Rate
FROM e_commerce_customer_analytics
GROUP BY Cohort_Month
ORDER BY Cohort_Month;

#--Analyze the return rate based on the Return_Status--
SELECT Product_Category, 
       COUNT(CASE WHEN Return_Status = 'Returned' THEN 1 END) AS Returned_Orders,
       COUNT(Order_ID) AS Total_Orders,
       (COUNT(CASE WHEN Return_Status = 'Returned' THEN 1 END) / COUNT(Order_ID)) * 100 AS Return_Rate
FROM e_commerce_customer_analytics
GROUP BY Product_Category;

#--Check if the Order_Date is always after Signup_Dat--
SELECT Customer_ID, Order_ID, Signup_Date, Order_Date
FROM e_commerce_customer_analytics
WHERE Order_Date < Signup_Date;
















