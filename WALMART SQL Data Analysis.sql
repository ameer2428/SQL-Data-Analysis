select * from Sales;
--- Feature Engineering------
----time of day--------------


		  SELECT
    time,
    CASE 
        WHEN CAST(time AS TIME) BETWEEN '00:00:00' AND '12:00:00' THEN 'morning'
        WHEN CAST(time AS TIME) BETWEEN '12:01:00' AND '16:00:00' THEN 'afternoon'
        ELSE 'evening'
    END AS time_of_day
FROM Sales;

----Adding this column to the table--------

ALTER TABLE sales ADD  time_of_day VARCHAR(20);

------  TO insert data into that that column-------

UPDATE sales
   SET time_of_day = CASE 
        WHEN CAST(time AS TIME) BETWEEN '00:00:00' AND '12:00:00' THEN 'morning'
        WHEN CAST(time AS TIME) BETWEEN '12:01:00' AND '16:00:00' THEN 'afternoon'
        ELSE 'evening'
		END;

--------day_name-------------

SELECT date,
       DATENAME(weekday, date) as day_name
FROM sales;

----- adding the column-------

ALTER TABLE sales add day_name VARCHAR(10);

----- to insert data into that column-------

UPDATE sales
         SET day_name = DATENAME(weekday, date);

------ month_name--------------

SELECT date,
         DATENAME(month, date) as month_name
FROM sales;
       
-------- ADDINGTHE COLUMN--------

ALTER TABLE sales ADD month_name VARCHAR(10);

-------- to add data into that column------

UPDATE sales
     SET month_name = DATENAME(month, date);

-------- BUSINESS QUESTIONS ------------------
-------- GENERIC QUESTIONS -------------------
-------- HOW MANY UNIQUE CITIES DOES THE DATA HAVE ----------

SELECT 
      DISTINCT city
	  FROM sales;

-------- IN WHICH CITY EACH BRANCH --------------------------

SELECT 
      DISTINCT city, branch
	  FROM sales;

-------- PRODUCT QUESTIONS ----------------------------------
-------- HOW MANY UNIQUE PODUCT LINE DOES DATA HAVE ---------

SELECT 
      DISTINCT product_line
	  FROM sales;

SELECT 
      COUNT(DISTINCT product_line)
	  FROM sales;

------- WHAT IS THE MOST COMMON PAYMENT METHOD ---------------

SELECT 
    Payment,
    COUNT(Payment) AS cnt
FROM sales
GROUP BY Payment
ORDER BY cnt DESC;

------- WHAT IS THE MOST SELLNG PRODUCT LINE ----------------

SELECT 
      Product_line,
	  COUNT(Product_line) AS plt
	  FROM sales
	  GROUP BY Product_line
	  ORDER BY plt;

-------- WHAT IS THE TOTAL REVENUE BY MONTH -----------------

SELECT 
      month_name AS month,
	  SUM(total) AS total_revenue
	  FROM sales
	  GROUP BY month_name
	  ORDER BY total_revenue DESC;

-------- WHICH MONTH HAS LARGEST COGS -----------------------

SELECT 
      month_name AS month,
	  SUM(cogs) AS cogs
	  FROM sales
	  GROUP BY month_name
	  ORDER BY cogs DESC;

-------- WHICH PRODUCT LINE HAS THE LARGEST REVENUE ----------

SELECT 
      Product_line AS Product,
	  SUM(total) AS total_revenue
	  FROM sales
	  GROUP BY Product_line
	  ORDER BY total_revenue DESC;

-------- WHAT IS THE CITY WITH LARGEST REVENUE ------------------

SELECT 
      Branch, City,
	  SUM(total) AS total_revenue
	  FROM sales
	  GROUP BY Branch, City
	  ORDER BY total_revenue DESC;

------- WHICH PRODUCT IS HAVING HIGHEST VAT( value added tax) --------

SELECT 
      Product_line,
	  AVG(Tax_5) AS tax_avg
	  FROM sales
	  GROUP BY Product_line
	  ORDER BY tax_avg DESC;

-------- WHICH BRANCH SOLD MORE PRODUCTS THAN AVERAGE PRODUCTS SOLD ----------

SELECT 
      Branch,
	  SUM(Quantity) AS qty
	  FROM sales
	  GROUP BY Branch
	  HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM sales);

----------- WHAT IS THE MOST COMMON PRODUCT LINE BY THE GENDER ----------------

SELECT
       Product_line,
	  COUNT(Gender) AS total
	  FROM sales
	  GROUP BY  Product_line, Gender
	  ORDER BY total;

----------- WHAT IS THE AVERAGE RATING OF EACH PRODUCT ---------------------------

SELECT 
       Product_line,
	   AVG(Rating) as avg_rating
	   FROM sales
	   GROUP BY  Product_line
	   ORDER BY avg_rating;


---------------------------------- SALES ----------------------------------------
------------ Number of sales made in each time of the day -----------------------

SELECT 
      time_of_day,
	  COUNT(*) AS total_sales
	  FROM Sales
	  GROUP BY time_of_day
	  ORDER BY total_sales DESC;

----------- which customer type brings the most revenue ---------------------------

SELECT
      Customer_type,
	  SUM(Total) AS total_revenue
	  FROM Sales
	  GROUP BY Customer_type
	  ORDER BY total_revenue DESC;

------------ which city has the largest tax percentage -----------------------------

SELECT 
      City,
	  AVG(Tax_5) AS vat
	  FROM Sales
	  GROUP BY City
	  ORDER BY vat DESC;

------------- which customer type pays the most tax ---------------------------------

SELECT 
     Customer_type,
	 AVG(tax_5)AS vat
	 FROM Sales
	 GROUP BY customer_type
	 ORDER BY vat DESC;

------------------------- CUSTOMER ------------------------------------------------

----------- how many unique customer types does the data have ---------------------

SELECT
      DISTINCT customer_type FROM Sales;

----------- how many unique payments does the data have ---------------------------

SELECT 
     DISTINCT payment
	 FROM Sales;

---------- which customer type buys the more --------------------------------------

SELECT 
      Customer_type,
	  COUNT(*) AS cnt
	  FROM sales
	  GROUP BY Customer_type
	  ORDER BY cnt DESC;