CREATE DATABASE finance_expense_db;
USE finance_expense_db;
describe expences;

SHOW COLUMNS FROM expenses;

ALTER TABLE expenses
CHANGE `ï»¿Expense_ID` expense_id INT,
CHANGE Expense_Date expense_date DATE,
CHANGE Category category VARCHAR(50),
CHANGE Description description VARCHAR(100),
CHANGE Payment_Mode payment_mode VARCHAR(30),
CHANGE Amount amount DECIMAL(10,2),
CHANGE Subcategory subcategory VARCHAR(50),
CHANGE Location location VARCHAR(50),
CHANGE Recurring recurring VARCHAR(5),
CHANGE Vendor vendor VARCHAR(50),
CHANGE Payment_Status payment_status VARCHAR(20),
CHANGE Notes notes VARCHAR(150),
CHANGE Month month VARCHAR(15),
CHANGE YEAR year INT,
CHANGE `Hgh-Value-Flag` high_value_flag VARCHAR(15);

UPDATE expenses
SET Expense_Date = STR_TO_DATE(Expense_Date, '%d-%m-%Y');
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

/* Total expenses */
SELECT SUM(amount) AS total_expense 
FROM expenses;

/*Expense by category*/
SELECT category, SUM(amount) AS total_amount
FROM expenses
GROUP BY category;

/*Monthly expense trend*/
SELECT 
    MONTH(expense_date) AS month,
    SUM(amount) AS total_amount
FROM expenses
GROUP BY MONTH(expense_date)
ORDER BY month;

/*High value transactions*/
SELECT *
FROM expenses
WHERE amount > (
    SELECT AVG(amount) FROM expenses
);
/*Count of high-value transactions*/
SELECT COUNT(*) AS high_value_txn_count
FROM expenses
WHERE amount > (
    SELECT AVG(amount) FROM expenses
);

/*High-value count by category*/
SELECT category, COUNT(*) AS high_value_count
FROM expenses
WHERE amount > (
    SELECT AVG(amount) FROM expenses
)
GROUP BY category;

/*Count by value type*/
SELECT high_value_flag, COUNT(*) AS txn_count
FROM expenses
GROUP BY high_value_flag;

/*Top spending categories*/
SELECT category, SUM(amount) AS total_spend
FROM expenses
GROUP BY category
ORDER BY total_spend DESC
LIMIT 5;

/*Payment mode analysis*/
SELECT payment_mode, SUM(amount) AS total_amount
FROM expenses
GROUP BY payment_mode;

/*Monthly trend*/
SELECT 
    MONTH(expense_date) AS month,
    SUM(amount) AS total_amount
FROM expenses
GROUP BY MONTH(expense_date)
ORDER BY month;

/*Total amount by Category & Subcategory*/
SELECT 
    category,
    subcategory,
    SUM(amount) AS total_amount
FROM expenses
GROUP BY category, subcategory
ORDER BY total_amount DESC;










