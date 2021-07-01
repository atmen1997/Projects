USE Momo;
SELECT 
    user_id,
    order_id,
    Date,
    Amount,
    Purchase_status,
    Partner_id,
    Merchant_name,
    c.Merchant_id,
    Rate_pct,
    (CAST(Amount * (Rate_pct / 100) AS UNSIGNED)) AS Revenue_Per_Order
FROM
    data_transactions AS t
        LEFT JOIN
    data_commission AS c ON t.Merchant_id = c.Merchant_id
;

SELECT 
    month, total_revenue AS total_revenue_Jan
FROM
    (SELECT 
        DATE_FORMAT(DATE, '%M') AS 'month',
            SUM((CAST(Amount * (Rate_pct / 100) AS UNSIGNED))) AS total_revenue
    FROM
        data_transactions AS t
    LEFT JOIN data_commission AS c 
		ON t.Merchant_id = c.Merchant_id
    GROUP BY month
    ) AS total_months_rev
WHERE
    month = 'January'
GROUP BY month
;

SELECT 
    t.user_id,
    order_id,
    Date,
    First_tran_date,
    Amount,
    Purchase_status,
    Partner_id,
    Age,
    Location,
    Gender,
    CASE WHEN First_tran_date BETWEEN '2020-01-01' AND '2020-01-31' THEN 'New'
    ELSE 'Current' END AS Type_user
FROM
    data_transactions AS t
        LEFT JOIN
	data_user_inf AS u ON t.user_id = u.User_id
WHERE First_tran_date < '2020-02-01'
;

SELECT month, COUNT(Type_user) AS 'Total_new_user_Jan'
FROM
(
SELECT 
	DATE_FORMAT(DATE, '%M') AS 'month',
    CASE TRUE WHEN First_tran_date BETWEEN '2020-01-01' AND '2020-01-31' THEN 'New'
    ELSE 'Current' END AS Type_user
FROM
    data_user_inf AS u
        LEFT JOIN
	data_transactions AS t ON t.user_id = u.User_id
WHERE First_tran_date < '2020-02-01'
) AS New_user_Jan
WHERE Type_user = 'New' and month = 'January'
Group By month
;

SELECT 
    t.user_id,
    order_id,
    Date,
	DATE_FORMAT(Date, '%M') AS 'Month',
    Amount,
    Purchase_status,
    Partner_id,
    Merchant_name,
    c.Merchant_id,
    Rate_pct,
    (CAST(Amount * (Rate_pct / 100) AS UNSIGNED)) AS Revenue_Per_Order,
    Age,
    Location,
    Gender
FROM
    data_transactions AS t
        LEFT JOIN
    data_commission AS c ON t.Merchant_id = c.Merchant_id
        LEFT JOIN
    data_user_inf AS u ON t.user_id = u.User_id
;




