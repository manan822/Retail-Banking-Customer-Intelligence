/*==========================================================
PROJECT  : Retail Banking Customer Intelligence Platform
01       : Basic SQL Queries
TABLE    : Customers_Data
==========================================================*/

/*----------------------------------------------------------
Query 1

Business Question:
Display all customer records.
----------------------------------------------------------*/

USE Retail_Banking;
GO

SELECT *
FROM Customers_Data;

/*----------------------------------------------------------
Query 2

Business Question:
Display Customer ID, Income and Customer Lifetime Value.
----------------------------------------------------------*/
SELECT
    ID,
    Income,
    Customer_Lifetime_Value_CLV
FROM Customers_Data;
/*----------------------------------------------------------
Query 3

Business Question:
Display the first 10 customer records.
----------------------------------------------------------*/

SELECT TOP 10 *
FROM Customers_Data;
/*----------------------------------------------------------
Query 4

Business Question:
Display the first 20 customer records.
----------------------------------------------------------*/

SELECT TOP 20 *
FROM Customers_Data;
