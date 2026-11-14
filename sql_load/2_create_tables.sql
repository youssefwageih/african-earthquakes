-- Create earthquakes table with primary key
CREATE TABLE public.earthquakes
(
    id VARCHAR(50) PRIMARY KEY,
    event_time TIMESTAMPTZ,
    event_date DATE,
    event_year INT,
    event_quarter VARCHAR(10),
    event_month INT,
    event_month_name VARCHAR(20),
    event_ym VARCHAR(10),
    latitude NUMERIC(9, 6),
    longitude NUMERIC(9, 6),
    depth_km NUMERIC(7, 2),
    depth_class VARCHAR(50),
    depth_reference_flag VARCHAR(50),
    mag NUMERIC(4, 2),
    magnitude_class VARCHAR(50),
    magnitude_class_order INT,
    country_display VARCHAR(100),
    country_clean VARCHAR(100),
    country_spatial VARCHAR(100),
    region VARCHAR(100),
    location_type VARCHAR(50),
    nearest_africa_km NUMERIC(9, 2),
    place TEXT,
    city VARCHAR(100),
    country_input VARCHAR(100),
    country_status VARCHAR(50),
    gap NUMERIC(6, 2),
    dmin NUMERIC(7, 3),
    rms NUMERIC(6, 3),
    horizontalError NUMERIC(7, 3),
    depthError NUMERIC(7, 3),
    magError NUMERIC(6, 3),
    magNst INT,
    flag_horizontal_error VARCHAR(10),
    flag_depth_error VARCHAR(10),
    flag_gap_over_180 VARCHAR(10),
    any_measurement_flag VARCHAR(30),
    fields_populated INT,
    record_completeness_pct NUMERIC(6, 2),
    spatial_country VARCHAR(100),
    scope_reason VARCHAR(100),
    continent VARCHAR(50)
);

-- Set ownership of the table
ALTER TABLE public.earthquakes OWNER to postgres;

-- Create index on event_time, country_display, and mag for query optimization
CREATE INDEX idx_earthquakes_event_time ON public.earthquakes (event_time);
CREATE INDEX idx_earthquakes_country ON public.earthquakes (country_display);
CREATE INDEX idx_earthquakes_mag ON public.earthquakes (mag);
CREATE INDEX idx_earthquakes_year ON public.earthquakes (event_year);
