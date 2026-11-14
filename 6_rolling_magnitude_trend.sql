/*
Purpose:
    Smooths seasonal noise and sensor spikes by calculating a 3-month moving
    average of seismic magnitude and rolling quarterly event counts.
    
Techniques Used:
    - Monthly aggregation CTE
    - Moving window frames: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
===============================================================================
*/

WITH month_grid AS (
    SELECT DISTINCT
        event_year,
        event_month
    FROM earthquakes
    WHERE event_year IS NOT NULL AND event_month IS NOT NULL
),
monthly AS (
    SELECT
        g.event_year AS yr,
        g.event_month AS mo,
        COUNT(e.id) AS events_in_month,
        ROUND(AVG(e.mag), 3) AS avg_monthly_mag
    FROM month_grid g
    LEFT JOIN earthquakes e
           ON e.event_year = g.event_year
          AND e.event_month = g.event_month
    GROUP BY g.event_year, g.event_month
)
SELECT
    yr,
    mo,
    events_in_month,
    avg_monthly_mag,
    ROUND(AVG(avg_monthly_mag) OVER (ORDER BY yr, mo ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 3) AS rolling_3_month_avg_mag,
    SUM(events_in_month) OVER (ORDER BY yr, mo ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS events_in_3_month_window
FROM monthly
ORDER BY yr, mo;
