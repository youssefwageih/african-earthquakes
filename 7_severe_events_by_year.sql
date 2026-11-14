/*
Purpose:
    Isolates genuinely severe African earthquakes (Richter magnitude >= 6.0)
    to analyze annual occurrence, peak magnitude, average focal depth, and affected
    countries.
    
Techniques Used:
    - Threshold filtering (mag >= 6.0)
    - PostgreSQL STRING_AGG(DISTINCT ...) string aggregation
===============================================================================
*/

SELECT
    event_year,
    COUNT(*) AS strong_events,
    MAX(mag) AS peak_magnitude,
    ROUND(AVG(depth_km), 1) AS avg_depth_km,
    STRING_AGG(DISTINCT country_display, ', ') AS countries
FROM earthquakes
WHERE mag >= 6.0
GROUP BY event_year
ORDER BY event_year;
