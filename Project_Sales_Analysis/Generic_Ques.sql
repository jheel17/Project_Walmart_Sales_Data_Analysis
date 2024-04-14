
-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM sales;


-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM sales;
