USE vehicle_rider;

CREATE TABLE IF NOT EXISTS owner_stats_daily (
    owner_id uuid,
    date date, 

    total_rides_count_accumulate int,
    total_dav_revenue_accumulate decimal,
    total_fiat_revenue_accumulate decimal,

    total_rides_count int,
    total_dav_revenue decimal,
    total_fiat_revenue decimal,
    currency_code text,

    PRIMARY KEY ((owner_id), date)
);
