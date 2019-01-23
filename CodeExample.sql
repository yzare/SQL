

Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for the Midwest region. Your final table should include three columns: the region name, 
the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT r.name region_name, s.name sales_rep_name, a.name account_name
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
AND r.name ='Midwest'
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name

Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to account name.


SELECT r.name region_name, s.name sales_rep_name, a.name account_name
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE s.name LIKE 'S%' AND r.name ='Midwest'
ORDER BY a.name

Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

Provide the name for each region for every order, as well as the account name and 
the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results
if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account
name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is 
helpful total_amt_usd/(total+0.01).

SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unit_price
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty >100;

Provide the name for each region for every order, as well as the account name and the unit 
price they paid (total_amt_usd/total) for the order. However, you should only provide the results if 
the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table 
should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. 
In order to avoid a division by zero error, adding .01 to the denominator here is helpful 
(total_amt_usd/(total+0.01).

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

Provide the name for each region for every order, as well as the account name and the unit price they
paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard
order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 
columns: region name, account name, and unit price. Sort for the largest unit price first. In order to 
avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;


What are the different channels used by account id 1001? Your final table should have only 2 columns: 
account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only
the unique values.

SELECT DISTINCT w.channel, a.name
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
WHERE w.account_id ='1001';

Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, 
account name, order total, and order total_amt_usd.

SELECT  o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

SELECT * FROM (SELECT a.name, MIN(o.occurred_at) min_occured
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name) AS tb1
ORDER by min_occured
LIMIT 1;

Find the total sales in usd for each account. You should include two columns - 
the total sales for each company's orders in usd and the company name.

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

Via what channel did the most recent (latest) web_event occur, which account was associated with this 
web_event? Your query should return only three values - the date, channel, and account name.

SELECT a.name, w.occurred_at , w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;

Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - the channel and the number of times the channel was used.

SELECT channel, COUNT(channel)
FROM web_events
GROUP BY channel;

Who was the primary contact associated with the earliest web_event?

SELECT w.occurred_at, a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

What was the smallest order placed by each account in terms of total usd. Provide only two columns - 
the account name and the total usd. Order from smallest dollar amounts to largest.

SELECT a.name, MIN(total_amt_usd) min_total
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY min_total;

Find the number of sales reps in each region. Your final table should have two columns - 
the region and the number of sales_reps. Order from fewest reps to most reps.

SELECT r.name, COUNT(s.id)
FROM sales_reps s
JOIN region r
ON r.id = s.region_id
GROUP BY r.name;


For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

SELECT a.name, AVG(o.standard_qty) standard, AVG(o.gloss_qty) gloss, AVG(o.poster_qty) poster
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

For each account, determine the average amount spent per order on each paper type. Your result should 
have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT a.name, AVG(o.standard_amt_usd) standard, AVG(o.gloss_amt_usd) gloss, AVG(o.poster_amt_usd)poster
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

Determine the number of times a particular channel was used in the web_events table for each sales rep. 
Your final table should have three columns - the name of the sales rep, the channel, and the number of 
occurrences. Order your table with the highest number of occurrences first.

SELECT s.name, w.channel, COUNT(w.channel) count
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER by count DESC;

Determine the number of times a particular channel was used in the web_events table for each region. 
Your final table should have three columns - the region name, the channel, and the number of occurrences. 
Order your table with the highest number of occurrences first.

SELECT r.name, w.channel, COUNT(w.channel) count
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER by count DESC;


How many of the sales reps have more than 5 accounts that they manage?

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

1.	Write a query to display for each order, the account ID, total amount of the order, and 
the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or 
smaller than $3000.

SELECT account_id, total, CASE WHEN total >= 3000 THEN 'large' ELSE 'small' END AS level
FROM orders;

Write a query to display the number of orders in each of three categories, based on the 'total' 
amount of each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 
'Less than 1000'.

SELECT CASE WHEN total < 1000 THEN 'less than 1000'
WHEN total >= 1000 AND  total < 2000 THEN 'between'
ELSE  'at least 2000'
END AS level,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;

We would like to understand 3 different branches of customers based on the amount associated 
with their purchases. The top branch includes anyone with a Lifetime Value (total sales of all orders) 
greater than 200,000 usd. The second branch is between 200,000 and 100,000 usd. The lowest branch is 
anyone under 100,000 usd. Provide a table that includes the levelassociated with each account. 
You should provide the account name, the total sales of all orders for the customer, and the level. 
Order with the top spending customers listed first.

SELECT a.name, SUM(total_amt_usd) total_spent,
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY 2 DESC;

Provide the name of the sales_rep in each region with the largest amount of total_amt_usdsales.

SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a
     ON a.sales_rep_id = s.id
     JOIN orders o
     ON o.account_id = a.id
     JOIN region r
     ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;



For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?


SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a
     ON a.sales_rep_id = s.id
     JOIN orders o
     ON o.account_id = a.id
     JOIN region r
     ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;

For the name of the account that purchased the most (in total over their lifetime as a customer) 
standard_qty paper, how many accounts still had more in total purchases?

SELECT a.name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > (SELECT total
                  FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                        FROM accounts a
                        JOIN orders o
                        ON o.account_id = a.id
                        GROUP BY 1
                        ORDER BY 2 DESC
                        LIMIT 1) sub);


For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, 
how many web_events did they have for each channel?

SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id
                     FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
                           FROM orders o
                           JOIN accounts a
                           ON a.id = o.account_id
                           GROUP BY a.id, a.name
                           ORDER BY 3 DESC
                           LIMIT 1) inner_table)
GROUP BY 1, 2
ORDER BY 3 DESC;


What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

SELECT AVG(tot_spent)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
       LIMIT 10) temp;


Provide the name of the sales_rep in each region with the largest amount of total_amt_usdsales.


#Use the accounts table and a CASE statement to create two groups: one group of company names that 
start with a number and a second group of those company names that start with a letter. 
What proportion of company names start with a letter?


SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 1 ELSE 0 END AS num,
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;
