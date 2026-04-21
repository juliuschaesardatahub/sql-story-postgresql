-- Reload core learning tables without recreating the Docker volume.
-- This script is intended to be executed with psql inside the postgres container.

-- Recreate periode if it does not exist yet.
CREATE TABLE IF NOT EXISTS periode (
    date_actual DATE,
    date_actual_time timestamp,
    day_suffix VARCHAR(10),
    day_name VARCHAR(20),
    day_of_week INTEGER,
    day_of_month INTEGER,
    day_of_quarter INTEGER,
    day_of_year INTEGER,
    week_of_month INTEGER,
    week_of_year INTEGER,
    week_of_year_iso VARCHAR(10),
    month_actual INTEGER,
    month_name VARCHAR(20),
    month_name_abbreviated VARCHAR(10),
    quarter_actual INTEGER,
    quarter_name VARCHAR(10),
    year_actual INTEGER,
    first_day_of_week DATE,
    last_day_of_week DATE,
    first_day_of_month DATE,
    last_day_of_month DATE,
    first_day_of_quarter DATE,
    last_day_of_quarter DATE,
    first_day_of_year DATE,
    last_day_of_year DATE,
    weekend_flag INTEGER,
    load_timestamp TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'Asia/Jakarta')
);

-- Recreate superstore if it does not exist yet.
CREATE TABLE IF NOT EXISTS superstore (
    row_id INTEGER PRIMARY KEY,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country_code VARCHAR(10),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    state_code VARCHAR(10),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(12, 4),
    quantity INTEGER,
    discount DECIMAL(4, 2),
    profit DECIMAL(12, 4),
    load_timestamp TIMESTAMP DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'Asia/Jakarta')
);

-- Remove existing rows so COPY can be rerun safely.
TRUNCATE TABLE superstore, periode;

SET datestyle = 'MDY';

COPY periode (
    date_actual,
    date_actual_time,
    day_suffix,
    day_name,
    day_of_week,
    day_of_month,
    day_of_quarter,
    day_of_year,
    week_of_month,
    week_of_year,
    week_of_year_iso,
    month_actual,
    month_name,
    month_name_abbreviated,
    quarter_actual,
    quarter_name,
    year_actual,
    first_day_of_week,
    last_day_of_week,
    first_day_of_month,
    last_day_of_month,
    first_day_of_quarter,
    last_day_of_quarter,
    first_day_of_year,
    last_day_of_year,
    weekend_flag
) FROM '/data/period.csv' DELIMITER ',' CSV HEADER;

COPY superstore (
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country_code,
    country,
    city,
    state,
    state_code,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
) FROM '/data/superstore.csv' DELIMITER ',' CSV HEADER;
