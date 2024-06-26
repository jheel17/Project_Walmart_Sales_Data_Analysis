# Walmart Sales Data Analysis

## About the Project

This analytical project delves into a comprehensive Walmart sales dataset with the objective of extracting actionable insights that could steer strategic decision-making towards optimizing sales operations. By evaluating the performance of different branches, product lines, and consumer buying patterns, we aim to sharpen sales strategies for enhanced profitability. 

The data was sourced from the renowned Kaggle Walmart Sales Forecasting Competition https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting, which encompasses historical sales figures across various store departments and incorporates the impact of strategic markdown events.

## Dataset Overview

The dataset, a rich compilation of transactions from three distinct Walmart branches, was curated for the Kaggle Walmart Sales Forecasting Competition. With a granular breakdown across 17 attributes and spanning over 1000 records, the dataset is a potent resource for a multifaceted sales analysis.

## Data Schema

**Here's an overview of the dataset structure:**

| Column                     | Description                                  | Data Type         |
|----------------------------|----------------------------------------------|-------------------|
| `invoice_id`               | Unique invoice identifier                    | `VARCHAR(30)`     |
| `branch`                   | Branch identifier                            | `VARCHAR(5)`      |
| `city`                     | Branch location                              | `VARCHAR(30)`     |
| `customer_type`            | Categorization of customer                   | `VARCHAR(30)`     |
| `gender`                   | Gender of the customer                       | `VARCHAR(10)`     |
| `product_line`             | Category of the product sold                 | `VARCHAR(100)`    |
| `unit_price`               | Price per unit of the product                | `DECIMAL(10, 2)`  |
| `quantity`                 | Quantity of product sold                     | `INT`             |
| `VAT`                      | Tax value added to the COGS                  | `FLOAT(6, 4)`     |
| `total`                    | Total purchase cost                          | `DECIMAL(10, 2)`  |
| `date`                     | Date of the transaction                      | `DATE`            |
| `time`                     | Time of the transaction                      | `TIMESTAMP`       |
| `payment_method`           | Payment method utilized                      | `DECIMAL(10, 2)`  |
| `cogs`                     | Cost of goods sold                           | `DECIMAL(10, 2)`  |
| `gross_margin_percentage`  | Gross margin represented as a percentage     | `FLOAT(11, 9)`    |
| `gross_income`             | Gross income from the transaction            | `DECIMAL(10, 2)`  |
| `rating`                   | Customer satisfaction rating                 | `FLOAT(2, 1)`     |

## Project Goals

The core mission of this endeavor is to decode the underlying factors influencing the sales dynamics at different Walmart branches, with an intent to:

- Identify high-performing and underachieving product lines.
- Observe sales trends and patterns across various product categories.
- Understand customer demographics and purchase behavior.
- Evaluate and refine sales and marketing strategies for revenue maximization.

## Analytical Perspectives

The project is segmented into various analyses, each focusing on specific aspects:

- **Product Analysis**: Evaluates performance across different product lines and identifies areas for improvement.

- **Sales Analysis**: Gauges the trends in product sales, aiding in the assessment and refinement of sales strategies.

- **Customer Analysis**: Dissects customer segments to reveal purchase trends and segment profitability.

## Methodological Approach

- **Data Wrangling**: Initial data examination for anomalies like missing values and employing data replacement techniques as necessary.

- **Database Construction**: Implementation of SQL tables and integration of data.

- **Feature Engineering**: Derivation of new insightful attributes from existing data fields.

- **Exploratory Data Analysis (EDA)**: In-depth data probing to respond to the investigative queries listed.

# Product Analysis: 

Conducted analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

## Business Questions Answered:

1. How many unique product lines does the data have?
2. What is the most selling product line?
3. What is the total revenue by month?
4. What month had the largest COGS?
5. What product line had the largest revenue?
6. What is the city with the largest revenue?
7. What product line had the largest VAT?
8. Categorize each product line as "Good" or "Bad" based on its average sales     compared to the overall average sales of all product lines.
9. Which branch sold more products than average product sold?
10. What is the most common product line by gender?
11. What is the average rating of each product line?
12. What is the most common payment method?

```sql
-- 1.How many unique product lines does the data have?
SELECT
	DISTINCT product_line
FROM sales;

-- 2.What is the most selling product line?
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- 3.What is the total revenue by month?
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;

-- 4.What month had the largest COGS?
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs;

-- 5.What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- 6.What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

-- 7.What product line had the largest VAT?
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- 8.Categorize each product line as "Good" or "Bad" based on its 
--average sales compared to the overall average sales of all product line

SELECT 
  product_line,
  CASE
    WHEN AVG(quantity) > (SELECT AVG(quantity) FROM sales) THEN 'Good'
    ELSE 'Bad'
  END AS remark
FROM sales
GROUP BY product_line;

-- 9.Which branch sold more products than average product sold?
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- 10.What is the most common product line by gender?
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- 11.What is the average rating of each product line?
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- 12.What is the most common payment method?
SELECT Payment, COUNT(*) AS NumberOfTransactions
FROM sales
GROUP BY Payment
ORDER BY NumberOfTransactions DESC;
```
## Insights: 

**1.Product Variety:** Walmart's diverse range of product lines demonstrates its commitment to meeting diverse consumer needs, enhancing market penetration and customer contentment.

![query1result](Project_Sales_Analysis/assets1/Prod1.PNG)


**2.Top Seller:** Electronic accessories emerge as Walmart's top-selling category, indicating a strong market preference and highlighting the importance of focused inventory management in this high-demand sector.

![query2result](Project_Sales_Analysis/assets1/Prod2.PNG)


**3.Revenue Trends:** January leads in sales for Walmart, indicating a post-holiday surge in revenue, which could inform strategic stock and marketing plans for future years.

![query3result](Project_Sales_Analysis/assets1/Prod3.PNG)


**4.Cost Analysis:** January's highest COGS suggests a potential inventory buildup in anticipation of holiday sales, highlighting opportunities for more efficient inventory management.

![query4result](Project_Sales_Analysis/assets1/Prod4.PNG)


**5.Revenue Leaders:** Food and beverages lead Walmart's revenue, suggesting a high turnover sector that may benefit from focused promotional strategies and inventory optimization.

![query5result](Project_Sales_Analysis/assets1/Prod5.PNG)


**6.City Performance:** Naypyitaw's branch leads in revenue, indicating a potential hotspot for Walmart's sales and a prime candidate for further investment and market analysis.

![query6result](Project_Sales_Analysis/assets1/Prod6.PNG)


**7.Tax Insights:** Home and lifestyle products face the highest VAT rates, suggesting a need for Walmart to possibly reevaluate pricing strategies within this category to maintain customer appeal.

![query7result](Project_Sales_Analysis/assets1/Prod7.PNG)


**8.Sales Performance:** Home and lifestyle, along with electronic accessories, stand out with 'Good' sales performance, while food and fashion accessories may require strategic enhancements to boost sales. 

![query8result](Project_Sales_Analysis/assets1/Prod8.PNG)


**9.Branch Analysis:** Branch A leads in quantity sold, suggesting successful sales strategies or a strong market presence.

![query9result](Project_Sales_Analysis/assets1/Prod9.PNG)


**10.Gender Preferences:** Fashion accessories are particularly popular among female shoppers, while health and beauty products are favored by males, highlighting gender-specific market trends for targeted advertising.

![query10result](Project_Sales_Analysis/assets1/Prod10.PNG)


**11.Customer Satisfaction:** Average product line ratings are indicative of customer satisfaction and can inform quality improvements or highlight strengths.Food and beverages receive the highest customer ratings at Walmart, indicating strong satisfaction.

![query11result](Project_Sales_Analysis/assets1/Prod11.PNG)


**12.Payment Methods:** The most common payment method can influence transaction processing improvements and customer experience initiatives. We can see that cash and eWallet are nearly tied as the preferred payment methods, signaling a potential shift in payment trends.

![query12result](Project_Sales_Analysis/assets1/Prod12.PNG)


# Customer Analysis:

This analysis seeks to decipher the sales trends across various product categories, providing insights into the efficacy of current sales strategies. The findings will guide necessary adjustments to enhance sales performance and drive revenue growth.

## Business Questions Answered:


1. What is the most common customer type?
2. Which customer type buys the most?
3. What is the gender of most of the customers?
4. What is the gender distribution per branch?
5. Which time of the day do customers give most ratings?
6. Which time of the day do customers give most ratings per branch?
7. Which day fo the week has the best avg ratings?
8. Which day of the week has the best average ratings per branch?

```sql
-- 1. Which are the most common customer types?
SELECT
  customer_type,
  COUNT(*) AS count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- 2. Which customer type buys the most?
SELECT
  customer_type,
  SUM(quantity) AS total_quantity
FROM sales
GROUP BY customer_type
ORDER BY total_quantity DESC
LIMIT 1;

-- 3. What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- 4. What is the gender distribution per branch?
SELECT
  branch,
  gender,
  COUNT(*) as gender_count
FROM sales
GROUP BY branch, gender
ORDER BY branch, gender_count DESC;

-- 5. Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- 6. Which time of the day do customers give most ratings per branch?
SELECT
  branch,
  time_of_day,
  AVG(rating) AS avg_rating
FROM sales
GROUP BY branch, time_of_day
ORDER BY branch, avg_rating DESC;

-- 7. Which day fo the week has the best avg ratings?
SELECT 
  day_name,
  AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC

-- 8. Which day of the week has the best average ratings per branch?
SELECT 
  branch,
  day_name,
  AVG(rating) AS avg_rating
FROM sales
GROUP BY branch, day_name
ORDER BY branch, avg_rating DESC;
```

## Insights:

 **1.Most Common Customer Type:** Membership programs appear to edge out slightly, indicating potential for loyalty-driven sales strategies.

 ![query1](Project_Sales_Analysis/assets2/Cust1.PNG)

 **2.Which Customer Type Buys the Most:** Members lead in purchase volume, highlighting the success of membership incentives in driving sales.

![query2](Project_Sales_Analysis/assets2/Cust2.PNG)


 **3.Gender of Most Customers:** Gender distribution among customers is balanced, suggesting an inclusive market appeal across products.

 ![quer3](Project_Sales_Analysis/assets2/Cust3.PNG)

 **4.Gender Distribution Per Branch:** Gender ratios across branches are consistent, indicating uniform marketing effectiveness.

![query4](Project_Sales_Analysis/assets2/Cust4.PNG)


**5.Time of Day with Most Ratings:** Afternoon sessions see higher customer engagement, suggesting an opportune time for soliciting feedback.

![query](Project_Sales_Analysis/assets2/Cust5.PNG)


**6.Ratings Per Time of Day per Branch:** Evening ratings peak at Branch C, implying customer satisfaction aligns with end-of-day shopping experiences.

![query6](Project_Sales_Analysis/assets2/Cust6.PNG)


 **7.Best Average Ratings by Day of the Week:** Mondays receive the highest ratings, pointing to a strong start of the week in customer satisfaction.

 ![query7](Project_Sales_Analysis/assets2/Cust7.PNG)


 **8.Best Average Ratings by Day of the Week Per Branch:** Each branch shows distinct peak days for customer ratings, indicating varying customer behaviors by location.

 ![query8](Project_Sales_Analysis/assets2/Cust8.PNG)


# Sales Analysis:

This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

## Business Questions Answered:

1. Number of sales made in each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/ VAT (Value Added Tax)?
4. Which customer type pays the most in VAT?
5. Which hour of the day experiences the highest sales volume?
6. Which product line is the most profitable?
7. Which product line had the single highest-value transaction?
9. On which day of the week are sales the highest?
10. Which product lines have above-average customer ratings?
12. Which branch has the highest average daily sales?

```sql
-- 1.Number of sales made in each time of the day per weekday:
SELECT 
  DAYNAME(date) AS weekday, 
  time_of_day, 
  COUNT(*) AS sales_count
FROM sales
GROUP BY weekday, time_of_day
ORDER BY weekday, sales_count DESC;

-- 2.Which of the customer types brings the most revenue?
SELECT 
  customer_type, 
  SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- 3.Which city has the largest tax/VAT percent?
SELECT 
  city, 
  (SUM(tax_pct)/SUM(total)) * 100 AS average_tax_percent
FROM sales
GROUP BY city
ORDER BY average_tax_percent DESC;

-- 4.Which customer type pays the most in VAT?
SELECT 
  customer_type, 
  SUM(tax_pct) AS total_tax_paid
FROM sales
GROUP BY customer_type
ORDER BY total_tax_paid DESC;

-- 5. Which hour of the day experiences the highest sales volume?

SELECT HOUR(time) AS hour, SUM(total) AS sales_volume
FROM sales
GROUP BY hour
ORDER BY sales_volume DESC;

-- 6. Which product line is the most profitable?

SELECT product_line, SUM(total - cogs) AS profit
FROM sales
GROUP BY product_line
ORDER BY profit DESC;

-- 7. Which product line had the single highest-value transaction?

SELECT product_line, MAX(total) AS highest_sale
FROM sales
GROUP BY product_line
ORDER BY highest_sale DESC;

-- 8. On which day of the week are sales the highest?

SELECT DAYNAME(date) AS weekday, SUM(total) AS total_sales
FROM sales
GROUP BY weekday
ORDER BY total_sales DESC;

-- 9. Which product lines have above-average customer ratings?

SELECT product_line, AVG(rating) AS avg_rating
FROM sales
GROUP BY product_line
HAVING avg_rating > (SELECT AVG(rating) FROM sales);

-- 10. Which branch has the highest average daily sales?

SELECT branch, SUM(total) / COUNT(DISTINCT date) AS avg_daily_sales
FROM sales
GROUP BY branch;
```

## Insights:    

Certainly! Here are the revised insights with concise titles:

**1.Peak Sales Times:** Weekends, especially Saturday evenings, are the busiest sales periods, indicating potential for targeted promotions during these times.

![query1](Project_Sales_Analysis/assets3/sales1.PNG)


**2.Top Revenue Customers:** Members contribute more to the revenue, suggesting loyalty programs could be effective.

![query2](Project_Sales_Analysis/assets3/sales2.PNG)

**3.Tax Consistency Across Cities:** The tax percentage is consistent across cities, indicating uniform pricing strategies can be maintained.

![query3](Project_Sales_Analysis/assets3/sales3.PNG)

**4.VAT Contributions:** Members pay slightly more in VAT than normal customers, possibly due to purchasing higher-priced or more items.

![query4](Project_Sales_Analysis/assets3/sales4.PNG)


**5.Sales Volume by Hour:** Late afternoons and early evenings, particularly around 7 PM, show peak sales activity, a key time for staffing and customer engagement.

![query5](Project_Sales_Analysis/assets3/sales5.PNG)

**6.Profitable Product Lines:** Food and beverages lead in profitability, suggesting inventory and marketing investment in this area may yield higher returns.

![query6](Project_Sales_Analysis/assets3/sales6.PNG)

**7.Highest Value Sales:** Fashion accessories had the highest single transaction value, highlighting potential for high-ticket sales in this category.

![query7](Project_Sales_Analysis/assets3/sales7.PNG)


**8.Best Sales Days:** Saturdays lead in total sales, aligning with common leisure shopping habits.

![query8](Project_Sales_Analysis/assets3/sales8.PNG)


**9.Customer Satisfaction:** Food and beverages, along with fashion accessories, have high customer satisfaction ratings, indicating strong market acceptance.

![query9](Project_Sales_Analysis/assets3/sales9.PNG)

**10.Branch Performance:**  Branch C shows the highest average daily sales, suggesting effective sales strategies or a prime location.

![query10](Project_Sales_Analysis/assets3/sales10.PNG)


# Business Insights:

- This in-depth analysis of Walmart's sales data offers valuable insights into the nuances of customer behavior, product popularity, and sales performance across various branches and times. 

- Key findings reveal that electronic accessories and food and beverages are standout categories, driving both volume and profitability. 

- Customer loyalty, as reflected in the purchasing patterns of members, appears to be a significant driver of revenue, advocating for a strengthened focus on loyalty programs. 

- Moreover, the consistency in tax percentages across cities simplifies the pricing strategy across regions.

- Saturday emerged as the prime day for sales, indicating the importance of strategic staff scheduling and targeted promotions to leverage these peak periods. 

- Evening hours were consistently the busiest across all branches, providing a window of opportunity for maximized sales efforts.

- The gender distribution was notably balanced, suggesting an all-inclusive market appeal of Walmart's product assortment. 

- However, distinct preferences in product lines between genders highlight opportunities for personalized marketing campaigns.

# Conclusion:

Throughout this Walmart Sales Data Analysis project, I've expanded my skill set in several key areas. By leveraging MySQL, I've deepened my understanding of database queries and data analysis, gleaning insights from complex data sets. Visual Studio Code was an excellent ally, enhancing my code-writing efficiency, while GitHub played a crucial role in version control and repository management, teaching me the intricacies of collaboration and project tracking in a real-world tech environment. This hands-on experience has not only broadened my technical expertise but also sharpened my problem-solving and analytical thinking abilities.

