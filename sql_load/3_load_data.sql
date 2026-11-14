-- Direct COPY command (Update file path to your absolute local path)
COPY public.earthquakes
FROM '"D:\african-earthquakes-2010-2026\earthquakes_africa.csv"'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- check
SELECT COUNT(*) AS total_loaded_records FROM public.earthquakes;
SELECT * FROM public.earthquakes LIMIT 5;