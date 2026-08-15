/*==========================================================

PROJECT  : Retail Banking Customer Intelligence Platform
03      : Customer Analysis
TABLE    : Customers_Data

PURPOSE  : Analyze customer demographics, customer segments,
           financial behaviour and customer value to support
           business decision making.

==========================================================*/
/*----------------------------------------------------------

Query 1

Business Question:
Who are the Top 20 customers based on Customer Lifetime Value?

Business Objective:
Identify the bank's most valuable customers for
relationship management and premium banking services.

----------------------------------------------------------*/
SELECT TOP 20

ID,

Customer_Segment,

City,

Income,

Customer_Lifetime_Value_CLV

FROM Customers_Data

ORDER BY Customer_Lifetime_Value_CLV DESC;


/*Query 2
Business Question

Who are the Top 20 customers by Income?*/

SELECT TOP 20

ID,

Customer_Segment,

Income,

Customer_Lifetime_Value_CLV,

City

FROM Customers_Data

ORDER BY Income DESC;

/*Query 3
Business Question

Which high-income customers have relatively low CLV?*/
SELECT

ID,

Customer_Segment,

Income,

Customer_Lifetime_Value_CLV

FROM Customers_Data

WHERE Income > 120

AND Customer_Lifetime_Value_CLV <
(
SELECT AVG(Customer_Lifetime_Value_CLV)

FROM Customers_Data
);

/*Query 4
Business Question

Who are the customers with both High Income and High Relationship Priority?

These are customers Relationship Managers should focus on first.*/
SELECT

ID,

Income,

Relationship_Priority_Score,

Customer_Segment

FROM Customers_Data

WHERE Income >
(
SELECT AVG(Income)

FROM Customers_Data
)

AND Relationship_Priority_Score >
(
SELECT AVG(Relationship_Priority_Score)

FROM Customers_Data
)

ORDER BY Relationship_Priority_Score DESC;

/*Query 5
Business Question
Which customers have the highest Financial Health Score?*/

SELECT TOP 20

ID,

Customer_Segment,

Financial_Health_Score,

Income

FROM Customers_Data

ORDER BY Financial_Health_Score DESC;

/*==========================================================

SECTION 2

CUSTOMER DEMOGRAPHIC ANALYSIS

Business Goal

Analyze customer demographics such as age, education,
experience and family size to understand customer
characteristics and support targeted marketing strategies.

==========================================================*/
/*----------------------------------------------------------

Query 6

Business Question

Which age group contributes the highest average
Customer Lifetime Value?

Business Objective

Identify high-value age groups for customer retention.

----------------------------------------------------------*/

SELECT

Age,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV

FROM Customers_Data

GROUP BY Age

ORDER BY Average_CLV DESC;


/*----------------------------------------------------------

Query 7

Business Question

Which education level has the highest average income?

Business Objective

Understand income variation across education levels.

----------------------------------------------------------*/

SELECT

Education,

AVG(Income) AS Average_Income

FROM Customers_Data

GROUP BY Education

ORDER BY Average_Income DESC;


/*----------------------------------------------------------

Query 8

Business Question

Which family size contributes the highest average CLV?

Business Objective

Identify customer families with greater long-term value.

----------------------------------------------------------*/

SELECT

Family,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV

FROM Customers_Data

GROUP BY Family

ORDER BY Average_CLV DESC;

/*----------------------------------------------------------

Query 9

Business Question

Which experience level has the highest average income?

Business Objective

Understand how professional experience impacts income.

----------------------------------------------------------*/

SELECT

Experience,

AVG(Income) AS Average_Income

FROM Customers_Data

GROUP BY Experience

ORDER BY Average_Income DESC;

/*----------------------------------------------------------

Query 10

Business Question

Which cities generate the highest average CLV?

Business Objective

Identify high-value cities for strategic expansion
and marketing.

----------------------------------------------------------*/

SELECT

City,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV

FROM Customers_Data

GROUP BY City

ORDER BY Average_CLV DESC;

/*----------------------------------------------------------

Query 11

Business Question

Which cities have the highest average income?

Business Objective

Identify cities with strong purchasing power.

----------------------------------------------------------*/

SELECT

City,

AVG(Income) AS Average_Income

FROM Customers_Data

GROUP BY City

ORDER BY Average_Income DESC;

/*----------------------------------------------------------

Query 12

Business Question

Which branches manage customers with the highest
average Customer Lifetime Value?

Business Objective

Identify high-performing branches.

----------------------------------------------------------*/

SELECT

Branch,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV

FROM Customers_Data

GROUP BY Branch

ORDER BY Average_CLV DESC;

/*==========================================================

SECTION 3

CUSTOMER BEHAVIOUR ANALYSIS

Business Goal

Analyze customer banking behavior by studying product
adoption, digital banking usage, loan acceptance, and
account ownership. The insights will help identify
cross-selling opportunities, improve customer engagement,
and support product strategy.

==========================================================*/

/*----------------------------------------------------------

Query 13

Business Question

What is the adoption rate of each banking product?

Business Objective

Measure customer adoption across major banking products
to identify highly adopted and underutilized services.

----------------------------------------------------------*/

SELECT
    SUM(CONVERT(INT, CreditCard)) AS CreditCard_Customers,
    SUM(CONVERT(INT, [Online])) AS Online_Banking_Customers,
    SUM(CONVERT(INT, CD_Account)) AS CD_Account_Customers,
    SUM(CONVERT(INT, Securities_Account)) AS Securities_Customers,
    SUM(CONVERT(INT, Personal_Loan)) AS Personal_Loan_Customers
FROM Customers_Data;

/*----------------------------------------------------------

Query 14

Business Question

Which customer segment has the highest Credit Card adoption?

Business Objective

Identify customer segments with the strongest credit card
usage for future product expansion.

----------------------------------------------------------*/

SELECT
    Customer_Segment,
    COUNT(*) AS Total_Customers,
    SUM(convert(INT,CreditCard)) AS CreditCard_Holders,
    ROUND(
        SUM(convert(INT,CreditCard)) * 100.0 / COUNT(*),
        2
    ) AS CreditCard_Adoption_Percentage
FROM Customers_Data
GROUP BY Customer_Segment
ORDER BY CreditCard_Adoption_Percentage DESC;

/*----------------------------------------------------------

Query 15

Business Question

Which customer segment has the highest Online Banking adoption?

Business Objective

Identify digitally engaged customer segments.

----------------------------------------------------------*/

SELECT
    Customer_Segment,
    COUNT(*) AS Total_Customers,
    SUM(convert(INT,Online)) AS Online_Users,
    ROUND(
        SUM(CONVERT(INT,Online)) * 100.0 / COUNT(*),
        2
    ) AS Online_Adoption_Percentage
FROM Customers_Data
GROUP BY Customer_Segment
ORDER BY Online_Adoption_Percentage DESC;

/*----------------------------------------------------------

Query 16

Business Question

Which customer segment has accepted the highest number
of Personal Loans?

Business Objective

Identify customer segments most responsive to loan products.

----------------------------------------------------------*/

SELECT
    Customer_Segment,

    SUM(CONVERT(INT, Personal_Loan)) AS Personal_Loan_Customers,

    ROUND(
        SUM(CONVERT(INT, Personal_Loan)) * 100.0 / COUNT(*),
        2
    ) AS Loan_Percentage

FROM Customers_Data
GROUP BY Customer_Segment
ORDER BY Personal_Loan_Customers DESC;

/*----------------------------------------------------------

Query 17

Business Question

Identify customers using Online Banking but not owning
a Credit Card.

Business Objective

Identify cross-selling opportunities for Credit Cards.

----------------------------------------------------------*/

SELECT
    ID,
    Customer_Segment,
    Income,
    City
FROM Customers_Data
WHERE Online = 1
AND CreditCard = 0;

/*----------------------------------------------------------

Query 18

Business Question

Identify high-income customers without a CD Account.

Business Objective

Find customers suitable for CD Account cross-selling.

----------------------------------------------------------*/

SELECT
    ID,
    Customer_Segment,
    Income,
    Customer_Lifetime_Value_CLV
FROM Customers_Data
WHERE Income >
(
    SELECT AVG(Income)
    FROM Customers_Data
)
AND CD_Account = 0;

/*----------------------------------------------------------

Query 19

Business Question

Identify customers having a Mortgage but no Securities Account.

Business Objective

Recommend investment and wealth management services.

----------------------------------------------------------*/

SELECT
    ID,
    Mortgage,
    Income,
    Customer_Segment
FROM Customers_Data
WHERE Mortgage > 0
AND Securities_Account = 0;

/*----------------------------------------------------------

Query 20

Business Question

Which customer segment demonstrates the highest
overall product engagement?

Business Objective

Measure customer engagement across all banking products.

----------------------------------------------------------*/
SELECT
    Customer_Segment,

    AVG(
        CAST(CreditCard AS INT) +
        CAST([Online] AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)
    ) AS Average_Product_Engagement

FROM Customers_Data

GROUP BY Customer_Segment

ORDER BY Average_Product_Engagement DESC;

/*==========================================================

SECTION 4

CUSTOMER OPPORTUNITY ANALYSIS

Business Goal

Identify customers who present opportunities for
cross-selling, upselling, premium banking, wealth
management, and customer retention.

The objective is to increase customer lifetime value,
product penetration, and overall profitability.
==========================================================*/

/*----------------------------------------------------------

Query 21

Business Question

Identify high-income customers without a Credit Card.

Business Objective

Identify customers suitable for premium Credit Card
cross-selling.

----------------------------------------------------------*/

SELECT

ID,

Customer_Segment,

Income,

Customer_Lifetime_Value_CLV,

City

FROM Customers_Data

WHERE Income >
(
SELECT AVG(Income)

FROM Customers_Data
)

AND CreditCard = 0

ORDER BY Income DESC;

/*----------------------------------------------------------

Query 22

Business Question

Identify high-income customers who do not have
a Personal Loan.

Business Objective

Identify customers suitable for Personal Loan
marketing campaigns.

----------------------------------------------------------*/

SELECT

ID,

Income,

Customer_Segment,

Financial_Health_Score

FROM Customers_Data

WHERE Income >
(
SELECT AVG(Income)

FROM Customers_Data
)

AND Personal_Loan = 0

ORDER BY Income DESC;

/*----------------------------------------------------------

Query 23

Business Question

Identify high-value customers with low product engagement.

Business Objective

Identify customers suitable for cross-selling.

----------------------------------------------------------*/

WITH Customer_Engagement AS
(
    SELECT
        ID,
        Customer_Segment,
        Customer_Lifetime_Value_CLV,

        (
            CAST(CreditCard AS INT) +
            CAST(Online AS INT) +
            CAST(CD_Account AS INT) +
            CAST(Securities_Account AS INT) +
            CAST(Personal_Loan AS INT)
        ) AS Product_Engagement

    FROM Customers_Data
)

SELECT *
FROM Customer_Engagement

WHERE Customer_Lifetime_Value_CLV >
(
    SELECT AVG(Customer_Lifetime_Value_CLV)
    FROM Customers_Data
)
AND Product_Engagement <= 2

ORDER BY Customer_Lifetime_Value_CLV DESC;


/*----------------------------------------------------------

Query 24

Business Question

Identify customers eligible for Premium Banking.

Business Objective

Recommend customers for premium banking services.

----------------------------------------------------------*/

SELECT

ID,

Income,

Customer_Lifetime_Value_CLV,

Relationship_Priority_Score,

Customer_Segment

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
)

AND Relationship_Priority_Score >
(
SELECT AVG(Relationship_Priority_Score)

FROM Customers_Data
)

ORDER BY Customer_Lifetime_Value_CLV DESC;


/*----------------------------------------------------------

Query 25

Business Question

Identify customers suitable for Wealth Management.

Business Objective

Recommend Wealth Management services to financially
strong customers.

----------------------------------------------------------*/

SELECT

ID,

Income,

Financial_Health_Score,

Customer_Segment

FROM Customers_Data

WHERE Income >
(
SELECT AVG(Income)

FROM Customers_Data
)

AND Financial_Health_Score >
(
SELECT AVG(Financial_Health_Score)

FROM Customers_Data
)

ORDER BY Income DESC;

/*----------------------------------------------------------

Query 26

Business Question

Identify customers requiring immediate Relationship
Manager attention.

Business Objective

Prioritize customer retention.

----------------------------------------------------------*/

SELECT TOP 25

ID,

Customer_Segment,

Customer_Lifetime_Value_CLV,

Relationship_Priority_Score

FROM Customers_Data

ORDER BY

Relationship_Priority_Score DESC,

Customer_Lifetime_Value_CLV DESC;

/*----------------------------------------------------------

Query 27

Business Question

Identify customers with the highest revenue opportunity.

Business Objective

Create a priority list for future marketing campaigns.

----------------------------------------------------------*/

SELECT TOP 30

ID,

Customer_Segment,

Income,

Customer_Lifetime_Value_CLV,

Financial_Health_Score,

Relationship_Priority_Score

FROM Customers_Data

ORDER BY

Income DESC,

Customer_Lifetime_Value_CLV DESC,

Relationship_Priority_Score DESC;

/*==========================================================

SECTION 4 SUMMARY

Key Insights

 Identified customers suitable for Credit Card campaigns.

 Identified customers suitable for Personal Loan campaigns.

 Identified premium banking opportunities.

 Identified Wealth Management opportunities.

 Identified high-value customers requiring relationship
  management.

 Created a prioritized customer list for future
  marketing campaigns.

Business Value

This analysis enables targeted marketing,
improves product penetration,
supports customer retention,
and helps maximize customer lifetime value.

==========================================================*/
/*==========================================================

SECTION 5

EXECUTIVE CUSTOMER INSIGHTS

Business Goal

Provide strategic customer insights for senior management.
These queries summarize the customer portfolio and identify
key business opportunities to support decision making,
resource allocation and revenue growth.

==========================================================*/
/*----------------------------------------------------------

Query 28

Business Question

Who are the Top 10 Overall Customers of the Bank?

Business Objective

Identify the most valuable customers based on multiple
business metrics.

----------------------------------------------------------*/

SELECT TOP 10

ID,

Customer_Segment,

Income,

Customer_Lifetime_Value_CLV,

Relationship_Priority_Score,

Financial_Health_Score

FROM Customers_Data

ORDER BY

Customer_Lifetime_Value_CLV DESC,

Relationship_Priority_Score DESC,

Income DESC;

/*----------------------------------------------------------

Query 29

Business Question

Which cities contribute the highest total CLV?

Business Objective

Identify high-value markets for business expansion.

----------------------------------------------------------*/

SELECT

City,

SUM(Customer_Lifetime_Value_CLV) AS Total_CLV

FROM Customers_Data

GROUP BY City

ORDER BY Total_CLV DESC;

/*----------------------------------------------------------

Query 30

Business Question

Which branches generate the highest total CLV?

Business Objective

Evaluate branch performance.

----------------------------------------------------------*/

SELECT

Branch,

SUM(Customer_Lifetime_Value_CLV) AS Total_CLV

FROM Customers_Data

GROUP BY Branch

ORDER BY Total_CLV DESC;
/*----------------------------------------------------------

Query 31

Business Question

Which customer segments generate the highest total
Customer Lifetime Value?

Business Objective

Measure the contribution of each customer segment.

----------------------------------------------------------*/

SELECT

Customer_Segment,

SUM(Customer_Lifetime_Value_CLV) AS Total_CLV

FROM Customers_Data

GROUP BY Customer_Segment

ORDER BY Total_CLV DESC;
/*----------------------------------------------------------

Query 32

Business Question

Which cities have the highest number of Premium Banking
customers?

Business Objective

Identify cities with strong premium banking potential.

----------------------------------------------------------*/

SELECT

City,

COUNT(*) AS Premium_Customers

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
)

GROUP BY City

ORDER BY Premium_Customers DESC;
/*----------------------------------------------------------

Query 33

Business Question

Which branch serves the most financially healthy
customers?

Business Objective

Identify branches managing financially strong customers.

----------------------------------------------------------*/

SELECT

Branch,

AVG(Financial_Health_Score) AS Average_Financial_Health

FROM Customers_Data

GROUP BY Branch

ORDER BY Average_Financial_Health DESC;
/*----------------------------------------------------------

Query 34

Business Question

How are Premium Banking customers distributed across
customer segments?

Business Objective

Understand which customer segments contribute most
to premium banking.

----------------------------------------------------------*/

SELECT

Customer_Segment,

COUNT(*) AS Premium_Customers

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
)

GROUP BY Customer_Segment

ORDER BY Premium_Customers DESC;
/*----------------------------------------------------------

Query 35

Business Question

Generate an Executive Priority Customer List.

Business Objective

Provide management with a prioritized list of customers
requiring strategic attention.

----------------------------------------------------------*/

SELECT TOP 50

ID,

Customer_Segment,

City,

Branch,

Income,

Customer_Lifetime_Value_CLV,

Financial_Health_Score,

Relationship_Priority_Score

FROM Customers_Data

ORDER BY

Relationship_Priority_Score DESC,

Customer_Lifetime_Value_CLV DESC,

Income DESC;
/*==========================================================

CUSTOMER ANALYSIS SUMMARY

Key Achievements

 Identified high-value customers.

 Analyzed customer demographics.

 Evaluated customer banking behaviour.

 Identified cross-selling and upselling opportunities.

 Recommended Premium Banking customers.

 Generated executive customer insights.

Business Impact

This analysis supports:

• Customer Segmentation
• Premium Banking Strategy
• Cross-Selling Campaigns
• Wealth Management
• Branch Performance Evaluation
• Executive Decision Making

==========================================================*/