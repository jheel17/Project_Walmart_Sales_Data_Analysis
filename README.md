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

### Business Questions Answered:

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

**1.Product Variety:** A diverse range of product lines suggests Walmart caters to a broad customer base, which is critical for market reach and consumer satisfaction.

![query1result](Project_Sales_Analysis/assets/Prod1.PNG)

**2.Top Seller:** Identifying the most sold product line allows Walmart to focus on keeping popular items in stock and managing inventory efficiently.

![query2result](Project_Sales_Analysis/assets/Prod2.PNG)

**3.Revenue Trends:** Monthly revenue figures can pinpoint peak sales periods, guiding inventory and marketing efforts to capitalize on these times.

![query3result](Project_Sales_Analysis/assets/Prod3.PNG)

**4.Cost Analysis:** Knowing which months have higher COGS can aid in budgeting and cost-saving strategies.

![query4result](Project_Sales_Analysis/assets/Prod4.PNG)

**5.Revenue Leaders:** Recognizing product lines with the highest revenue can help prioritize marketing and sales efforts.

![query5result](Project_Sales_Analysis/assets/Prod5.PNG)

**6.City Performance:** Cities generating more revenue might reveal successful regional strategies or market preferences.

![query6result](Project_Sales_Analysis/assets/Prod6.PNG)

**7.Tax Insights:** Products with higher VAT implications may affect pricing strategies and customer purchasing decisions.

![query7result](Project_Sales_Analysis/assets/Prod7.PNG)

**8.Sales Performance:** Classifying product lines as 'Good' or 'Bad' based on sales can direct focus to improving or promoting certain lines.

![query8result](Project_Sales_Analysis/assets/Prod8.PNG)

**9.Branch Analysis:** Branches selling above average can provide insights into successful sales tactics or customer preferences.

![query9result](Project_Sales_Analysis/assets/Prod9.PNG)

**10.Gender Preferences:** Different product popularity among genders can guide targeted marketing campaigns.

![query10result](Project_Sales_Analysis/assets/Prod10.PNG)


**11.Customer Satisfaction:** Average product line ratings are indicative of customer satisfaction and can inform quality improvements or highlight strengths.

![query11result](Project_Sales_Analysis/assets/Prod11.PNG)


**12.Payment Methods:** The most common payment method can influence transaction processing improvements and customer experience initiatives.

![query12result](Project_Sales_Analysis/assets/Prod12.PNG)





















## Conclusions and Business Insights

Through meticulous analysis, the project addresses a suite of pertinent business queries, providing vital insights for strategic sales and marketing alignment.

## Revenue and Profit Calculations

The project incorporates a detailed financial computation framework, from calculating the COGS to deducing the Gross Margin percentage, a critical metric for evaluating sales profitability.

## Acknowledgements

The data utilized in this project is accredited to the Kaggle Walmart Sales Forecasting Competition. The insights generated here are intended to supplement Walmart's strategic sales initiatives and are a testament to the power of data in guiding business strategy.

---

For more insights and a complete overview of the analysis, visit the project repository [here](<insert your GitHub repository link>).

```

Feel free to replace `<insert your GitHub repository link>` with the actual URL to your repository. This README is designed to provide a comprehensive and professional introduction to your project, perfect for stakeholders looking to understand your work at a glance.
