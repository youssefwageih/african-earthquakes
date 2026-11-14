/*
Purpose:
    Tracks annual seismic event counts and intensity over time (2010–2026),
    calculating year-over-year changes and percentage shifts using window functions.
    
Techniques Used:
    - Common Table Expressions (CTEs)
    - Window Functions: LAG() OVER (ORDER BY event_year)
    - Conditional CASE logic for trend labeling
===============================================================================
*/

WITH yearly AS (
    SELECT
        event_year,
        COUNT(*) AS quake_count,
        ROUND(AVG(mag), 3) AS avg_magnitude,
        MAX(mag) AS peak_magnitude
    FROM earthquakes
    WHERE event_year IS NOT NULL
    GROUP BY event_year
),
with_change AS (
    SELECT
        event_year,
        quake_count,
        avg_magnitude,
        peak_magnitude,
        LAG(quake_count) OVER (ORDER BY event_year) AS prev_year_count,
        quake_count - LAG(quake_count) OVER (ORDER BY event_year) AS yoy_change
    FROM yearly
)
SELECT
    event_year,
    quake_count,
    avg_magnitude,
    peak_magnitude,
    prev_year_count,
    yoy_change,
    ROUND(100.0 * yoy_change / NULLIF(prev_year_count, 0), 2) AS yoy_pct_change,
    CASE
        WHEN prev_year_count IS NULL THEN 'First year in range'
        WHEN event_year = 2026 THEN 'PARTIAL YEAR - do not compare'
        WHEN yoy_change > 0 THEN 'Increase'
        WHEN yoy_change < 0 THEN 'Decrease'
        ELSE 'Flat'
    END AS trend_label
FROM with_change
ORDER BY event_year;
