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

-- Gender per branch is more or less the same hence, I don't think has
-- an effect of the sales per branch and other factors.

-- 5. Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.


-- 6. Which time of the day do customers give most ratings per branch?
SELECT
  branch,
  time_of_day,
  AVG(rating) AS avg_rating
FROM sales
GROUP BY branch, time_of_day
ORDER BY branch, avg_rating DESC;

-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.


-- 7. Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?


-- 8. Which day of the week has the best average ratings per branch?
SELECT 
  branch,
  day_name,
  AVG(rating) AS avg_rating
FROM sales
GROUP BY branch, day_name
ORDER BY branch, avg_rating DESC;
