/*==========================================================

PROJECT  : Retail Banking Customer Intelligence Platform

MODULE   : 07 - Advanced SQL

AUTHOR   : Manan Tulsyan

DATABASE : Retail_Banking

TABLE    : Customers_Data

PURPOSE  : Demonstrate advanced SQL concepts such as
            Window Functions, CTEs, Ranking, Views,
            Analytical Functions and CASE statements
            using real banking business scenarios.

==========================================================*/
/*
Section 1 ? Ranking Functions

Section 2 ? Window Functions

Section 3 ? Common Table Expressions (CTE)

Section 4 ? Views

Section 5 ? Advanced CASE & Analytical Queries */

/*----------------------------------------------------------

Query 1

Business Question

Rank all customers according to CLV.

Business Objective

Identify the position of every customer within the bank.

----------------------------------------------------------*/

SELECT

ID,

Customer_Lifetime_Value_CLV,

RANK() OVER
(
ORDER BY Customer_Lifetime_Value_CLV DESC
)

AS CLV_Rank

FROM Customers_Data;

/*----------------------------------------------------------

Query 2

Business Question

Identify the highest-income customer within each branch.

Business Objective

Recognize the most valuable customer in every branch.

----------------------------------------------------------*/

WITH RankedCustomers AS
(
SELECT

ID,

Branch,

Income,

ROW_NUMBER() OVER
(
PARTITION BY Branch
ORDER BY Income DESC
)

AS Branch_Rank

FROM Customers_Data
)

SELECT *

FROM RankedCustomers

WHERE Branch_Rank=1;

/* SECTION 2
WINDOW FUNCTIONS
====================================== */
/*----------------------------------------------------------

Query 3

Business Question

Compare customer income against the branch average.

Business Objective

Identify customers earning above or below branch average.

----------------------------------------------------------*/

SELECT

ID,

Branch,

Income,

AVG(Income) OVER
(
PARTITION BY Branch
)

AS Branch_Average_Income

FROM Customers_Data;

/* Query 4
Business Question
Calculate cumulative CLV within each branch. */

SELECT

Branch,

ID,

Customer_Lifetime_Value_CLV,

SUM(Customer_Lifetime_Value_CLV)

OVER

(

PARTITION BY Branch

ORDER BY Customer_Lifetime_Value_CLV DESC

)

AS Running_CLV

FROM Customers_Data;

/* SECTION 3
COMMON TABLE EXPRESSIONS
====================================== */
/* Query 5
Business Question

Identify customers earning above the overall average income. */

WITH IncomeCTE AS
(
SELECT

ID,

Income

FROM Customers_Data
)

SELECT *

FROM IncomeCTE

WHERE Income>

(

SELECT AVG(Income)

FROM IncomeCTE

);

/* Query 6
Business Question
Identify branches whose average CLV exceeds the bank average.*/

WITH BranchPerformance AS
(

SELECT

Branch,

AVG(Customer_Lifetime_Value_CLV) AS Branch_CLV

FROM Customers_Data

GROUP BY Branch

)

SELECT *

FROM BranchPerformance

WHERE Branch_CLV>

(

SELECT AVG(Branch_CLV)

FROM BranchPerformance

);

/* SECTION 4
SQL VIEWS
====================================== */

/* Query 7
Business Question
Create a reusable Premium Customer View. */

GO

CREATE VIEW Premium_Customers_ AS

SELECT
    ID,
    Income,
    Customer_Lifetime_Value_CLV,
    Customer_Segment,
    Branch

FROM Customers_Data

WHERE Income >
(
    SELECT AVG(Income)
    FROM Customers_Data
)

AND Customer_Lifetime_Value_CLV >
(
    SELECT AVG(Customer_Lifetime_Value_CLV)
    FROM Customers_Data
);

GO 
SELECT *

FROM Premium_Customers_;

/* SECTION 5
ADVANCED ANALYTICAL SQL
====================================== */

/* Query 8
Business Question
Classify customers into value tiers. */

SELECT

ID,

Customer_Lifetime_Value_CLV,

CASE

WHEN Customer_Lifetime_Value_CLV>=150

THEN 'Platinum'

WHEN Customer_Lifetime_Value_CLV>=100

THEN 'Gold'

WHEN Customer_Lifetime_Value_CLV>=60

THEN 'Silver'

ELSE 'Bronze'

END

AS Customer_Value_Tier

FROM Customers_Data;

/* Query 9
Business Question
Identify customers performing above the bank average in all key metrics. */

SELECT

ID,

Income,

Customer_Lifetime_Value_CLV,

Financial_Health_Score

FROM Customers_Data

WHERE Income>

(

SELECT AVG(Income)

FROM Customers_Data

)

AND Customer_Lifetime_Value_CLV>

(

SELECT AVG(Customer_Lifetime_Value_CLV)

FROM Customers_Data

)

AND Financial_Health_Score>

(

SELECT AVG(Financial_Health_Score)

FROM Customers_Data

);

/*==========================================================

ADVANCED SQL SUMMARY

Advanced Concepts Demonstrated

RANK()

ROW_NUMBER()

PARTITION BY

Window Aggregates

Running Totals

Common Table Expressions (CTEs)

SQL Views

Advanced CASE Statements

Analytical SQL Queries

Business Impact

These techniques enable advanced reporting,
customer ranking,
branch benchmarking,
reusable business logic,
and analytical decision-making.

==========================================================*/



