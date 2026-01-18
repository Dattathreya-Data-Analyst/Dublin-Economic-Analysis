Create database project;
use project;
SELECT 
    Quarter AS 'Reporting_Period',
    `National Unemployment Rate SA (%)` AS 'National_Rate',
    `Dublin Unemployment Rate SA (%)` AS 'Dublin_Rate',
    `Dublin Employed SA (000)` AS 'Workforce_Thousands'
FROM dublin_unemployment_clean;

WITH RollingStats AS (
    SELECT 
        Quarter, 
        `Dublin Unemployment Rate SA (%)` AS Dublin_Rate,
        -- We use the original Quarter column for ordering
        AVG(`Dublin Unemployment Rate SA (%)`) OVER (
            ORDER BY Quarter 
            ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
        ) AS Moving_Avg
    FROM dublin_unemployment_clean
)
SELECT 
    Quarter AS 'Reporting_Period', 
    Dublin_Rate AS 'Actual_Rate', 
    ROUND(Moving_Avg, 2) AS 'Trend_Line'
FROM RollingStats;

SELECT 
    Quarter AS 'Reporting_Period',
    `Dublin Employed SA (000)` AS 'Current_Workforce',
    -- Look back 4 rows (1 year) to get the previous year's number
    LAG(`Dublin Employed SA (000)`, 4) OVER (ORDER BY Quarter) AS 'Prev_Year_Workforce',
    (`Dublin Employed SA (000)` - LAG(`Dublin Employed SA (000)`, 4) OVER (ORDER BY Quarter)) AS 'Jobs_Created_Thousands'
FROM dublin_unemployment_clean;

SELECT 
    Quarter AS 'Reporting_Period',
    `Dublin Employed SA (000)` AS 'Current_Workforce',
    -- Look back 4 rows (1 year) to get the previous year's number
    LAG(`Dublin Employed SA (000)`, 4) OVER (ORDER BY Quarter) AS 'Prev_Year_Workforce',
    (`Dublin Employed SA (000)` - LAG(`Dublin Employed SA (000)`, 4) OVER (ORDER BY Quarter)) AS 'Jobs_Created_Thousands'
FROM dublin_unemployment_clean;

SELECT 
    Quarter,
    `National Unemployment Rate SA (%)` AS 'National_Rate',
    `Dublin Unemployment Rate SA (%)` AS 'Dublin_Rate',
    (`Dublin Unemployment Rate SA (%)` - `National Unemployment Rate SA (%)`) AS 'Rate_Gap',
    CASE 
        WHEN (`Dublin Unemployment Rate SA (%)` - `National Unemployment Rate SA (%)`) < -1.0 THEN 'Dublin Resilience'
        WHEN (`Dublin Unemployment Rate SA (%)` - `National Unemployment Rate SA (%)`) > 1.0 THEN 'City Vulnerability'
        ELSE 'Neutral'
    END AS 'Market_Status'
FROM dublin_unemployment_clean
WHERE `National Unemployment Rate SA (%)` IS NOT NULL
ORDER BY Rate_Gap ASC;

USE project;

CREATE OR REPLACE VIEW view_dublin_economic_health AS
WITH RollingStats AS (
    SELECT 
        Quarter,
        `National Unemployment Rate SA (%)` AS Nat_Rate,
        `Dublin Unemployment Rate SA (%)` AS Dub_Rate,
        `Dublin Employed SA (000)` AS Dub_Employed,
        -- This calculates the 1-year trend automatically
        AVG(`Dublin Unemployment Rate SA (%)`) OVER (
            ORDER BY Quarter 
            ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
        ) AS Moving_Avg
    FROM dublin_unemployment_clean
)
SELECT 
    Quarter AS 'Reporting_Period',
    Nat_Rate,
    Dub_Rate,
    ROUND((Dub_Rate - Nat_Rate), 2) AS 'Rate_Gap',
    Dub_Employed AS 'Workforce_K',
    ROUND(Moving_Avg, 2) AS 'Trend_Line'
FROM RollingStats;
 SELECT * FROM view_dublin_economic_health LIMIT 1000;

-- Now you can simply call your analysis like this:
SELECT * FROM view_dublin_economic_health;
