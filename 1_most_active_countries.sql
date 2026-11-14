/*
Purpose:
    Identifies the African countries experiencing the highest frequency of
    earthquakes between 2010 and 2026.
    
    - Total recorded earthquake count
    - Average Richter magnitude
    - Peak (maximum) magnitude
    - Minimum recorded magnitude
    - Percentage of records flagged with measurement errors
===============================================================================
*/

SELECT
    country_display AS country,
    COUNT(*) AS total_earthquakes,
    ROUND(AVG(mag), 2) AS avg_magnitude,
    MAX(mag) AS max_magnitude,
    MIN(mag) AS min_magnitude,
    ROUND(100.0 * SUM(CASE WHEN any_measurement_flag = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_low_quality_records
FROM earthquakes
GROUP BY country_display
HAVING COUNT(*) >= 20
ORDER BY total_earthquakes DESC;
