/*
Purpose:
    Identifies records with high uncertainty or measurement error flags:
      - Horizontal error > 10.0 km
      - Focal depth error > 10.0 km
      - Azimuthal station gap > 180 degrees (sparse sensor coverage)
    
Techniques Used:
    - Multi-condition CTEs
    - Boolean breach flags
    - String concatenation for unevaluable fields (CONCAT_WS)
===============================================================================
*/

WITH evaluated AS (
    SELECT
        id,
        event_time,
        place,
        country_display AS country,
        mag,
        horizontalError,
        depthError,
        gap,
        flag_horizontal_error,
        flag_depth_error,
        flag_gap_over_180,
        any_measurement_flag,
        record_completeness_pct,
        COALESCE(horizontalError, 0) > 10.0 AS breach_horizontal,
        COALESCE(depthError, 0)      > 10.0 AS breach_depth,
        COALESCE(gap, 0)             > 180.0 AS breach_gap,
        CONCAT_WS(', ',
            CASE WHEN horizontalError IS NULL THEN 'horizontalError' END,
            CASE WHEN depthError IS NULL THEN 'depthError' END,
            CASE WHEN gap IS NULL THEN 'gap' END
        ) AS checks_not_evaluable
    FROM earthquakes
)
SELECT
    id,
    event_time,
    place,
    country,
    mag,
    horizontalError,
    depthError,
    gap,
    flag_horizontal_error,
    flag_depth_error,
    flag_gap_over_180,
    any_measurement_flag,
    record_completeness_pct,
    NULLIF(checks_not_evaluable, '') AS checks_not_evaluable
FROM evaluated
WHERE breach_horizontal OR breach_depth OR breach_gap
ORDER BY COALESCE(horizontalError, 0) DESC, mag DESC;
