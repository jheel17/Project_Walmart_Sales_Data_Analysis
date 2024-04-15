
-- 1.Number of sales made in each time of the day per weekday:
SELECT 
  DAYNAME(date) AS weekday, 
  time_of_day, 
  COUNT(*) AS sales_count
FROM sales
GROUP BY weekday, time_of_day
ORDER BY weekday, sales_count DESC;

-- Evenings experience most sales, the stores are 
-- filled during the evening hours

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
