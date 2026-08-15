/*==========================================================

PROJECT  : Retail Banking Customer Intelligence Platform
06      : Business Case Studies
TABLE    : Customers_Data

PURPOSE  : Solve real-world banking business problems
           using SQL and provide actionable insights
           for management.

==========================================================*/

/*----------------------------------------------------------

Business Case 1

Business Question

Which customers should receive dedicated Relationship
Managers?

Business Objective

Identify customers with the greatest strategic value.

----------------------------------------------------------*/

SELECT TOP 100

ID,

Branch,

Customer_Segment,

Income,

Customer_Lifetime_Value_CLV,

Financial_Health_Score,

Relationship_Priority_Score

FROM Customers_Data

ORDER BY

Relationship_Priority_Score DESC,

Financial_Health_Score DESC,

Customer_Lifetime_Value_CLV DESC;


/*----------------------------------------------------------

Business Case 2

Business Question

Which city is the best candidate for opening a
Premium Banking Branch?

Business Objective

Identify cities with strong premium banking potential.

----------------------------------------------------------*/

SELECT

City,

COUNT(*) AS Customers,

AVG(Income) AS Average_Income,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV

FROM Customers_Data

GROUP BY City

HAVING COUNT(*)>=100

ORDER BY

Average_CLV DESC,

Average_Income DESC;

/*----------------------------------------------------------

Business Case 3

Business Question

Which branches require digital transformation?

Business Objective

Identify branches with the lowest digital banking adoption.

----------------------------------------------------------*/

SELECT TOP 10

Branch,

ROUND(

AVG(CAST(Online AS FLOAT))*100,

2

)

AS Digital_Adoption

FROM Customers_Data

GROUP BY Branch

ORDER BY Digital_Adoption ASC;


/*----------------------------------------------------------

Business Case 4

Business Question

Which product should be promoted in the next marketing
campaign?

Business Objective

Prioritize marketing based on recommendation demand.

----------------------------------------------------------*/

SELECT

Next_Best_Product,

COUNT(*) AS Recommended_Customers,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV

FROM Customers_Data

GROUP BY Next_Best_Product

ORDER BY

Recommended_Customers DESC,

Average_CLV DESC;


/*----------------------------------------------------------

Business Case 5

Business Question

Generate an executive summary of the bank.

Business Objective

Provide key portfolio metrics in one report.

----------------------------------------------------------*/

SELECT

    COUNT(*) AS Total_Customers,

    COUNT(DISTINCT Branch) AS Total_Branches,

    COUNT(DISTINCT City) AS Total_Cities,

    AVG(Income) AS Average_Income,

    AVG(Customer_Lifetime_Value_CLV) AS Average_CLV,

    AVG(Financial_Health_Score) AS Average_Financial_Health,

    AVG(Relationship_Priority_Score) AS Average_Relationship_Score

FROM Customers_Data;

/*==========================================================

BUSINESS CASE STUDIES SUMMARY

Business Cases Solved

Priority Customer Retention

Premium Branch Expansion

Digital Transformation Strategy

Product Campaign Strategy

Executive Portfolio Summary

Business Impact

These SQL solutions demonstrate practical business
decision-making rather than simple reporting.

The queries simulate real management requests and
show how SQL can be used to support strategic
banking decisions.

==========================================================*/