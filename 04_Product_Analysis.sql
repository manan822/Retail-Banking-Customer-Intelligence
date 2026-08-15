/*==========================================================

PROJECT  : Retail Banking Customer Intelligence Platform
04      :Product Analysis
TABLE    : Customers_Data

PURPOSE  : Analyze the performance of banking products,
           identify product gaps, understand customer
           product portfolios, and recommend strategies
           to improve product penetration.

==========================================================*/

/*==========================================================

SECTION 1

PRODUCT PORTFOLIO OVERVIEW

Business Goal

Understand the overall product portfolio of the bank,
including customer ownership patterns and product
distribution.

==========================================================*/
/*----------------------------------------------------------

Query 1

Business Question

How many banking products does each customer own?

Business Objective

Understand the size of each customer's product portfolio.

----------------------------------------------------------*/

SELECT
    ID,
    Customer_Segment,

    (
        CAST(CreditCard AS INT) +
        CAST(Online AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)
    ) AS Total_Products_Owned

FROM Customers_Data

ORDER BY Total_Products_Owned DESC;


/*----------------------------------------------------------

Query 2

Business Question

How many customers own each number of banking products?

Business Objective

Understand overall product portfolio distribution.

----------------------------------------------------------*/

SELECT
    (
        CAST(CreditCard AS INT) +
        CAST(Online AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)
    ) AS Products_Owned,

    COUNT(*) AS Total_Customers

FROM Customers_Data

GROUP BY
    (
        CAST(CreditCard AS INT) +
        CAST(Online AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)
    )

ORDER BY Products_Owned;

/*----------------------------------------------------------

Query 3

Business Question

What is the average product portfolio size?

Business Objective

Measure average customer product ownership.

----------------------------------------------------------*/

SELECT

AVG(

        CAST(CreditCard AS INT) +
        CAST(Online AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)

)

AS Average_Product_Portfolio

FROM Customers_Data;


/*SECTION 2

PRODUCT PERFORMANCE ANALYSIS

Query 4
Business Question

Which banking product contributes the highest customer adoption?*/

SELECT
    'Credit Card' AS Product,
    SUM(CAST(CreditCard AS INT)) AS Customers
FROM Customers_Data

UNION ALL

SELECT
    'Online Banking',
    SUM(CAST(Online AS INT))
FROM Customers_Data

UNION ALL

SELECT
    'CD Account',
    SUM(CAST(CD_Account AS INT))
FROM Customers_Data

UNION ALL

SELECT
    'Securities Account',
    SUM(CAST(Securities_Account AS INT))
FROM Customers_Data

UNION ALL

SELECT
    'Personal Loan',
    SUM(CAST(Personal_Loan AS INT))
FROM Customers_Data

ORDER BY Customers DESC;

/*==========================================================

SECTION 3

PRODUCT BUNDLING ANALYSIS

Business Goal

Understand product combinations frequently owned by
customers to identify bundling opportunities and improve
cross-selling strategies.

==========================================================*/
/*----------------------------------------------------------

Query 6

Business Question

Which banking product combinations are most common?

Business Objective

Identify frequently occurring product bundles to
support bundled product offerings.

----------------------------------------------------------*/

SELECT

CONCAT(
CASE WHEN CreditCard=1 THEN 'CreditCard | ' ELSE '' END,
CASE WHEN Online=1 THEN 'Online | ' ELSE '' END,
CASE WHEN CD_Account=1 THEN 'CD Account | ' ELSE '' END,
CASE WHEN Securities_Account=1 THEN 'Securities | ' ELSE '' END,
CASE WHEN Personal_Loan=1 THEN 'Personal Loan' ELSE '' END
) AS Product_Bundle,

COUNT(*) AS Total_Customers

FROM Customers_Data

GROUP BY

CONCAT(
CASE WHEN CreditCard=1 THEN 'CreditCard | ' ELSE '' END,
CASE WHEN Online=1 THEN 'Online | ' ELSE '' END,
CASE WHEN CD_Account=1 THEN 'CD Account | ' ELSE '' END,
CASE WHEN Securities_Account=1 THEN 'Securities | ' ELSE '' END,
CASE WHEN Personal_Loan=1 THEN 'Personal Loan' ELSE '' END
)

ORDER BY Total_Customers DESC;


/*----------------------------------------------------------

Query 7

Business Question

Which single banking product is most commonly owned
by customers?

Business Objective

Identify products acting as customer entry points.

----------------------------------------------------------*/

SELECT

CASE

    WHEN CreditCard = 1
         AND (
                CAST(Online AS INT) +
                CAST(CD_Account AS INT) +
                CAST(Securities_Account AS INT) +
                CAST(Personal_Loan AS INT)
             ) = 0
    THEN 'Credit Card'

    WHEN Online = 1
         AND (
                CAST(CreditCard AS INT) +
                CAST(CD_Account AS INT) +
                CAST(Securities_Account AS INT) +
                CAST(Personal_Loan AS INT)
             ) = 0
    THEN 'Online Banking'

    WHEN CD_Account = 1
         AND (
                CAST(CreditCard AS INT) +
                CAST(Online AS INT) +
                CAST(Securities_Account AS INT) +
                CAST(Personal_Loan AS INT)
             ) = 0
    THEN 'CD Account'

    WHEN Securities_Account = 1
         AND (
                CAST(CreditCard AS INT) +
                CAST(Online AS INT) +
                CAST(CD_Account AS INT) +
                CAST(Personal_Loan AS INT)
             ) = 0
    THEN 'Securities Account'

    WHEN Personal_Loan = 1
         AND (
                CAST(CreditCard AS INT) +
                CAST(Online AS INT) +
                CAST(CD_Account AS INT) +
                CAST(Securities_Account AS INT)
             ) = 0
    THEN 'Personal Loan'

END AS First_Product,

COUNT(*) AS Customers

FROM Customers_Data

GROUP BY

CASE

    WHEN CreditCard = 1
         AND (
                CAST(Online AS INT) +
                CAST(CD_Account AS INT) +
                CAST(Securities_Account AS INT) +
                CAST(Personal_Loan AS INT)
             ) = 0
    THEN 'Credit Card'

    WHEN Online = 1
         AND (
                CAST(CreditCard AS INT) +
                CAST(CD_Account AS INT) +
                CAST(Securities_Account AS INT) +
                CAST(Personal_Loan AS INT)
             ) = 0
    THEN 'Online Banking'

    WHEN CD_Account = 1
         AND (
                CAST(CreditCard AS INT) +
                CAST(Online AS INT) +
                CAST(Securities_Account AS INT) +
                CAST(Personal_Loan AS INT)
             ) = 0
    THEN 'CD Account'

    WHEN Securities_Account = 1
         AND (
                CAST(CreditCard AS INT) +
                CAST(Online AS INT) +
                CAST(CD_Account AS INT) +
                CAST(Personal_Loan AS INT)
             ) = 0
    THEN 'Securities Account'

    WHEN Personal_Loan = 1
         AND (
                CAST(CreditCard AS INT) +
                CAST(Online AS INT) +
                CAST(CD_Account AS INT) +
                CAST(Securities_Account AS INT)
             ) = 0
    THEN 'Personal Loan'

END

ORDER BY Customers DESC;
/*----------------------------------------------------------

Query 8

Business Question

Which product bundles generate the highest average CLV?

Business Objective

Identify profitable product combinations.

----------------------------------------------------------*/

SELECT

(
    CAST(CreditCard AS INT) +
    CAST(Online AS INT) +
    CAST(CD_Account AS INT) +
    CAST(Securities_Account AS INT) +
    CAST(Personal_Loan AS INT)
)

AS Products_Owned,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV

FROM Customers_Data

GROUP BY

(
    CAST(CreditCard AS INT) +
    CAST(Online AS INT) +
    CAST(CD_Account AS INT) +
    CAST(Securities_Account AS INT) +
    CAST(Personal_Loan AS INT)
)

ORDER BY Average_CLV DESC;

/*Query 9
Business Question
Which product combination has the highest Financial Health Score?*/

SELECT

(
    CAST(CreditCard AS INT) +
    CAST(Online AS INT) +
    CAST(CD_Account AS INT) +
    CAST(Securities_Account AS INT) +
    CAST(Personal_Loan AS INT)
)

AS Products_Owned,

AVG(Financial_Health_Score) AS Average_Financial_Health

FROM Customers_Data

GROUP BY

(
    CAST(CreditCard AS INT) +
    CAST(Online AS INT) +
    CAST(CD_Account AS INT) +
    CAST(Securities_Account AS INT) +
    CAST(Personal_Loan AS INT)
)

ORDER BY Average_Financial_Health DESC;
/*----------------------------------------------------------

Query 10

Business Question

Identify customers with the highest remaining product
potential.

Business Objective

Estimate cross-selling opportunities.

----------------------------------------------------------*/

SELECT

    ID,

    Customer_Segment,

    5 -
    (
        CAST(CreditCard AS INT) +
        CAST(Online AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)
    )

    AS Remaining_Product_Potential

FROM Customers_Data

ORDER BY Remaining_Product_Potential DESC;



/*==========================================================

SECTION 4

PRODUCT GAP ANALYSIS

Business Goal

Identify gaps in customers' banking product portfolios
and recommend the most suitable next products based on
their current banking relationships.

The insights generated from this section will support
cross-selling campaigns and improve overall product
penetration.

==========================================================*/

/*----------------------------------------------------------

Query 11

Business Question

Which digitally active customers have not adopted any
investment products?

Business Objective

Identify customers suitable for digital investment campaigns.

----------------------------------------------------------*/

SELECT

ID,
Customer_Segment,
City,
Income

FROM Customers_Data

WHERE Online = 1
AND CD_Account = 0
AND Securities_Account = 0

ORDER BY Income DESC;


/*----------------------------------------------------------

Query 12

Business Question

Which investment customers are not using Online Banking?

Business Objective

Increase digital adoption among investment customers.

----------------------------------------------------------*/

SELECT

ID,
Customer_Segment,
CD_Account,
Securities_Account

FROM Customers_Data

WHERE Online = 0
AND
(
CD_Account = 1
OR Securities_Account = 1
);


/*----------------------------------------------------------

Query 13

Business Question

Which customers own multiple banking products but still
do not own a Credit Card?

Business Objective

Identify mature customers suitable for Credit Card sales.

----------------------------------------------------------*/

SELECT

    ID,

    (
        CAST(Online AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)
    ) AS Existing_Products,

    Income

FROM Customers_Data

WHERE CreditCard = 0
AND
(
    CAST(Online AS INT) +
    CAST(CD_Account AS INT) +
    CAST(Securities_Account AS INT) +
    CAST(Personal_Loan AS INT)
) >= 2

ORDER BY Existing_Products DESC,
         Income DESC;


/*----------------------------------------------------------

Query 14

Business Question

Which customers own only one banking product?

Business Objective

Identify customers with significant cross-selling potential.

----------------------------------------------------------*/

SELECT

    ID,

    Customer_Segment,

    (
        CAST(CreditCard AS INT) +
        CAST(Online AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)
    ) AS Products_Owned

FROM Customers_Data

WHERE
(
    CAST(CreditCard AS INT) +
    CAST(Online AS INT) +
    CAST(CD_Account AS INT) +
    CAST(Securities_Account AS INT) +
    CAST(Personal_Loan AS INT)
) = 1

ORDER BY Customer_Segment;



/*----------------------------------------------------------

Query 15

Business Question

Recommend the next best banking product for each customer.

Business Objective

Support personalized product recommendations.

----------------------------------------------------------*/

SELECT

ID,

Next_Best_Product,

Income,

Customer_Segment

FROM Customers_Data

ORDER BY Income DESC;

/*==========================================================

SECTION 4 SUMMARY

Key Insights

Identified digitally active customers without investments.

Identified investment customers not using digital channels.

Identified mature customers without Credit Cards.

Identified customers owning only one product.

Leveraged Next_Best_Product recommendations for
personalized marketing.

Business Value

This section helps the bank improve product penetration,
digital adoption, personalized marketing, and customer
retention while minimizing redundant sales efforts.

==========================================================*/

/*==========================================================

SECTION 5

EXECUTIVE PRODUCT INSIGHTS

Business Goal

Summarize strategic product insights that help management
understand customer portfolio maturity, evaluate product
recommendations, and prioritize future product strategies.

==========================================================*/

/*----------------------------------------------------------

Query 16

Business Question

What is the maturity level of customer product portfolios?

Business Objective

Classify customers according to the depth of their
banking relationship.

----------------------------------------------------------*/

SELECT

CASE

WHEN
(
CAST(CreditCard AS INT)+
CAST(Online AS INT)+
CAST(CD_Account AS INT)+
CAST(Securities_Account AS INT)+
CAST(Personal_Loan AS INT)
)<=1

THEN 'New Customer'

WHEN
(
CAST(CreditCard AS INT)+
CAST(Online AS INT)+
CAST(CD_Account AS INT)+
CAST(Securities_Account AS INT)+
CAST(Personal_Loan AS INT)
)<=3

THEN 'Growing Customer'

ELSE 'Mature Customer'

END AS Portfolio_Status,

COUNT(*) AS Total_Customers

FROM Customers_Data

GROUP BY

CASE

WHEN
(
CAST(CreditCard AS INT)+
CAST(Online AS INT)+
CAST(CD_Account AS INT)+
CAST(Securities_Account AS INT)+
CAST(Personal_Loan AS INT)
)<=1

THEN 'New Customer'

WHEN
(
CAST(CreditCard AS INT)+
CAST(Online AS INT)+
CAST(CD_Account AS INT)+
CAST(Securities_Account AS INT)+
CAST(Personal_Loan AS INT)
)<=3

THEN 'Growing Customer'

ELSE 'Mature Customer'

END

ORDER BY Total_Customers DESC;


/*----------------------------------------------------------

Query 17

Business Question

Which recommended product is associated with customers
having the highest average CLV?

Business Objective

Prioritize marketing campaigns based on customer value.

----------------------------------------------------------*/

SELECT

Next_Best_Product,

COUNT(*) AS Recommended_Customers,

AVG(Customer_Lifetime_Value_CLV) AS Average_CLV,

AVG(Income) AS Average_Income

FROM Customers_Data

GROUP BY Next_Best_Product

ORDER BY Average_CLV DESC;



/*----------------------------------------------------------

Query 18

Business Question

Which banking products are most frequently absent from
customer portfolios?

Business Objective

Identify products requiring stronger market penetration.

----------------------------------------------------------*/

SELECT
'Credit Card' AS Product,
SUM(CASE WHEN CreditCard=0 THEN 1 ELSE 0 END) AS Customers_Without_Product
FROM Customers_Data

UNION ALL

SELECT
'Online Banking',
SUM(CASE WHEN Online=0 THEN 1 ELSE 0 END)
FROM Customers_Data

UNION ALL

SELECT
'CD Account',
SUM(CASE WHEN CD_Account=0 THEN 1 ELSE 0 END)
FROM Customers_Data

UNION ALL

SELECT
'Securities Account',
SUM(CASE WHEN Securities_Account=0 THEN 1 ELSE 0 END)
FROM Customers_Data

UNION ALL

SELECT
'Personal Loan',
SUM(CASE WHEN Personal_Loan=0 THEN 1 ELSE 0 END)
FROM Customers_Data

ORDER BY Customers_Without_Product DESC;


/*----------------------------------------------------------

Query 20

Business Question

Generate strategic product KPIs for executive reporting.

Business Objective

Provide management with a concise overview of product
portfolio performance.

----------------------------------------------------------*/

SELECT
    COUNT(*) AS Total_Customers,

    AVG(
        1.0 * (
            CAST(CreditCard AS INT) +
            CAST(Online AS INT) +
            CAST(CD_Account AS INT) +
            CAST(Securities_Account AS INT) +
            CAST(Personal_Loan AS INT)
        )
    ) AS Average_Product_Portfolio,

    MAX(
        CAST(CreditCard AS INT) +
        CAST(Online AS INT) +
        CAST(CD_Account AS INT) +
        CAST(Securities_Account AS INT) +
        CAST(Personal_Loan AS INT)
    ) AS Maximum_Products_Owned

FROM Customers_Data;

/*==========================================================

PRODUCT ANALYSIS SUMMARY

Key Achievements

Measured product portfolio depth.

Identified common product bundles.

Identified product portfolio gaps.

Evaluated Next Best Product recommendations.

Classified customers by portfolio maturity.

Identified products with the largest penetration gap.

Generated executive product KPIs.

The Product Analysis module enables:

• Better product strategy
• Improved cross-selling campaigns
• Product portfolio optimization
• Executive decision-making
• Strong Power BI KPI reporting */




