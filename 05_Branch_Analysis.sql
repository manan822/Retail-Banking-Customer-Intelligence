/*==========================================================

PROJECT  : Retail Banking Customer Intelligence Platform
05       : Branch Analysis
TABLE    : Customers_Data

PURPOSE  : Evaluate branch operational performance,
           identify business opportunities, measure
           portfolio quality and support branch strategy.

==========================================================*/
/* Section 1 ? Branch Portfolio Analysis

Section 2 ? Branch Digital Transformation

Section 3 ? Branch Product Strategy

Section 4 ? Branch Operational Opportunities

Section 5 ? Executive Branch Scorecard */

/*==========================================================

SECTION 1

BRANCH PORTFOLIO ANALYSIS

Business Goal

Evaluate the overall quality and maturity of customer
portfolios managed by each branch.

==========================================================*/
/*----------------------------------------------------------

Query 1

Business Question

Which branch manages customers with the highest average
product portfolio?

Business Objective

Evaluate portfolio maturity across branches.

----------------------------------------------------------*/

SELECT

Branch,

AVG(

CAST(CreditCard AS INT)+
CAST(Online AS INT)+
CAST(CD_Account AS INT)+
CAST(Securities_Account AS INT)+
CAST(Personal_Loan AS INT)

) AS Average_Product_Portfolio

FROM Customers_Data

GROUP BY Branch

ORDER BY Average_Product_Portfolio DESC;


/* Query 2
Business Question
Which branch has the highest concentration of mature customers? */

SELECT

Branch,

COUNT(*) AS Mature_Customers

FROM Customers_Data

WHERE

(
CAST(CreditCard AS INT)+
CAST(Online AS INT)+
CAST(CD_Account AS INT)+
CAST(Securities_Account AS INT)+
CAST(Personal_Loan AS INT)

)>=4

GROUP BY Branch

ORDER BY Mature_Customers DESC;


/* SECTION 2
DIGITAL BRANCH PERFORMANCE
====================================== 

Query 3
Business Question

Which branches are most digitally enabled? */
SELECT

Branch,

ROUND(

AVG(CAST(Online AS FLOAT))*100,

2

)

AS Digital_Adoption_Percentage

FROM Customers_Data

GROUP BY Branch

ORDER BY Digital_Adoption_Percentage DESC;


/* Query 4
Business Question
Which branches still depend heavily on offline banking? */

SELECT

Branch,

COUNT(*) AS Offline_Customers

FROM Customers_Data

WHERE Online=0

GROUP BY Branch

ORDER BY Offline_Customers DESC;


/* SECTION 3
PRODUCT MIX ANALYSIS
====================================== 

Query 5
Business Question
Which branches have the strongest investment portfolio? */
SELECT

Branch,

SUM(CAST(CD_Account AS INT)+CAST(Securities_Account AS INT))

AS Investment_Customers

FROM Customers_Data

GROUP BY Branch

ORDER BY Investment_Customers DESC;



/* Query 6
Business Question
Which branches have the strongest lending portfolio? */

SELECT

Branch,

SUM(CAST(Personal_Loan AS INT))

AS Loan_Customers,

AVG(Mortgage)

AS Average_Mortgage

FROM Customers_Data

GROUP BY Branch

ORDER BY Loan_Customers DESC;



/* SECTION 4
BRANCH OPPORTUNITY ANALYSIS
======================================
Query 7
Business Question
Which branches have the highest untapped product potential? */

SELECT

Branch,

AVG(

5-

(

CAST(CreditCard AS INT)+
CAST(Online AS INT)+
CAST(CD_Account AS INT)+
CAST(Securities_Account AS INT)+
CAST(Personal_Loan AS INT)

)

)

AS Average_Remaining_Product_Potential

FROM Customers_Data

GROUP BY Branch

ORDER BY Average_Remaining_Product_Potential DESC;


/* Query 8

Business Question
Which branches have the highest Next Best Product implementation opportunity? */

SELECT

Branch,

COUNT(DISTINCT Next_Best_Product)

AS Recommendation_Diversity

FROM Customers_Data

GROUP BY Branch

ORDER BY Recommendation_Diversity DESC;


/* SECTION 5
EXECUTIVE BRANCH SCORECARD
====================================== */
/*----------------------------------------------------------

Query 9

Business Question

Generate executive branch performance KPIs.

Business Objective

Summarize operational performance of every branch.

----------------------------------------------------------*/

SELECT

Branch,

COUNT(*) AS Customers,

AVG(Income) AS Avg_Income,

AVG(Customer_Lifetime_Value_CLV) AS Avg_CLV,

AVG(

CAST(CreditCard AS FLOAT)+
CAST(Online AS FLOAT)+
CAST(CD_Account AS FLOAT)+
CAST(Securities_Account AS FLOAT)+
CAST(Personal_Loan AS FLOAT)

) AS Avg_Product_Portfolio,

ROUND(

AVG(CAST(Online AS FLOAT))*100,

2

)

AS Digital_Adoption

FROM Customers_Data

GROUP BY Branch

ORDER BY Avg_CLV DESC;

/*==========================================================

BRANCH ANALYSIS SUMMARY

Portfolio maturity evaluated.

Branch digital readiness measured.

Investment and lending specialization identified.

Cross-selling opportunity measured.

Recommendation diversity evaluated.

Executive branch scorecard generated.

Business Impact

Supports branch expansion strategy,
resource allocation,
digital transformation,
wealth management planning,
and executive reporting.

==========================================================*/





