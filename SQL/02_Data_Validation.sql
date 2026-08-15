/*==========================================================
PROJECT  : Retail Banking Customer Intelligence Platform
02       : Data Validation
TABLE    : Customers_Data

PURPOSE  : Validate the quality and consistency of customer
           data before performing business analysis.
==========================================================*/

/*----------------------------------------------------------
Query 1

Business Question:
How many customer records are present?
----------------------------------------------------------*/

USE Retail_Banking;
GO

SELECT COUNT(*) AS Total_Customers
FROM Customers_Data;

/*----------------------------------------------------------
Query 2

Business Question:
Check whether duplicate Customer IDs exist.
----------------------------------------------------------*/

SELECT ID,
    COUNT(*) AS Duplicate_Count
FROM Customers_Data
GROUP BY ID
HAVING COUNT(*) > 1;

/*----------------------------------------------------------
Query 3

Business Question:
Identify missing values in important columns.
----------------------------------------------------------*/

SELECT
SUM(CASE WHEN ID IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_ID,

SUM(CASE WHEN Income IS NULL THEN 1 ELSE 0 END) AS Missing_Income,

SUM(CASE WHEN Customer_Lifetime_Value_CLV IS NULL THEN 1 ELSE 0 END) AS Missing_CLV,

SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS Missing_City

FROM Customers_Data;

/*----------------------------------------------------------
Query 4

Business Question:
Identify customers with negative income.
----------------------------------------------------------*/

SELECT *
FROM Customers_Data
WHERE Income < 0;

/*----------------------------------------------------------
Query 5

Business Question:
Identify customers with unrealistic ages.
----------------------------------------------------------*/

SELECT *
FROM Customers_Data
WHERE Age < 18
OR Age > 100;

/*----------------------------------------------------------
Query 6

Business Question:
Calculate minimum, maximum and average income.
----------------------------------------------------------*/

SELECT

MIN(Income) AS Minimum_Income,

MAX(Income) AS Maximum_Income,

AVG(Income) AS Average_Income

FROM Customers_Data;

/*----------------------------------------------------------
Query 7

Business Question:
Calculate minimum, maximum and average CLV.
----------------------------------------------------------*/

SELECT

MIN(Customer_Lifetime_Value_CLV) AS Minimum_CLV,

MAX(Customer_Lifetime_Value_CLV) AS Maximum_CLV,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV

FROM Customers_Data;

/*----------------------------------------------------------
Query 8

Business Question:
Count customers in each customer segment.
----------------------------------------------------------*/

SELECT

Customer_Segment,

COUNT(*) AS Total_Customers

FROM Customers_Data

GROUP BY Customer_Segment

ORDER BY Total_Customers DESC;

SELECT

City,

COUNT(*) AS Total_Customers

FROM Customers_Data

GROUP BY City

ORDER BY Total_Customers DESC;

SELECT

Branch,

COUNT(*) AS Total_Customers

FROM Customers_Data

GROUP BY Branch

ORDER BY Total_Customers DESC;

/*==========================================================

DATA VALIDATION SUMMARY

 Total records verified

 No duplicate Customer IDs

 No missing values detected

 No negative income values

 No unrealistic ages

 Customer segments validated

 Branch and city names verified

 Dataset is ready for business analysis.

==========================================================*/