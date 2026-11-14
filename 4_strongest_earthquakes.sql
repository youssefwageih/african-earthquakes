/*
Purpose:
    Identifies the ten most powerful seismic events recorded in the African
    continent and surrounding boundary zones over the 16-year analysis window.
    
Metrics Analyzed:
    - Event timestamp
    - Place description
    - Country
    - Magnitude (Richter)
    - Hypocentral depth (km)
    - Magnitude classification tier
===============================================================================
*/

SELECT
    event_time,
    place,
    country_display AS country,
    mag,
    depth_km,
    magnitude_class
FROM earthquakes
WHERE event_time >= DATE '2010-01-01'
ORDER BY mag DESC
LIMIT 10;
