USE vehicle_rider;

CREATE TABLE IF NOT EXISTS vehicle_stats_daily (
    vehicle_id uuid,
    owner_id uuid,
    date date,

    total_rides_count_accumulate int,
    total_dav_revenue_accumulate decimal,
    total_fiat_revenue_accumulate decimal,

    total_rides_count int,
    total_dav_revenue decimal,
    total_fiat_revenue decimal,
    currency_code text,

    rating_1_count int,
    rating_2_count int,
    rating_3_count int,
    rating_4_count int,
    rating_5_count int,

    last_parking_image_url text,

    PRIMARY KEY ((owner_id), date, vehicle_id)
);

CREATE MATERIALIZED VIEW IF NOT EXISTS vehicle_stats_daily_date AS
    SELECT * FROM vehicle_stats_daily
    WHERE vehicle_id IS NOT NULL
    AND owner_id IS NOT NULL
    AND date IS NOT NULL
    PRIMARY KEY ((date),vehicle_id,owner_id);
