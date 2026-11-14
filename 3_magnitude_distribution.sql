/*
Purpose:
    Categorizes all recorded seismic events into standard Richter magnitude classes:
      - Minor (< 4.0)
      - Light (4.0 - 4.9)
      - Moderate (5.0 - 5.9)
      - Strong (6.0+)
    
Techniques Used:
    - Conditional CASE binning
    - Window Functions: SUM(COUNT(*)) OVER () for overall percentage calculation
===============================================================================
*/

WITH classified AS (
    SELECT
        CASE
            WHEN mag IS NULL THEN 'Unknown'
            WHEN mag < 4.0  THEN 'Minor (<4.0)'
            WHEN mag < 5.0  THEN 'Light (4.0-4.9)'
            WHEN mag < 6.0  THEN 'Moderate (5.0-5.9)'
            ELSE 'Strong (6.0+)'
        END AS magnitude_class
    FROM earthquakes
)
SELECT
    magnitude_class,
    COUNT(*) AS event_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM classified
GROUP BY magnitude_class
ORDER BY event_count DESC;
