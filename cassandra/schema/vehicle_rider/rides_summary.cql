USE vehicle_rider;

CREATE TABLE IF NOT EXISTS rides_summary (
    owner_id uuid,
    rider_id uuid,
    vehicle_id uuid,

    start_time timestamp,
    end_time timestamp,

    effective_date date,

    start_geohash text,
    end_geohash text,
    distance decimal,

    parking_image_url text,
    rating tinyint,
    feedback_tags set<text>,

    price decimal,
    currency_code text,
    conversion_rate decimal,

    commission_factor decimal,
    commission decimal,

    payment_dav_factor decimal,
    payment_method_dav boolean,

    auth_transaction_id text,
    capture_transaction_id text,

    dav_rider_transaction text,
    fiat_rider_transaction text,
    dav_owner_transaction text,
    fiat_owner_transaction text,

    PRIMARY KEY((rider_id,vehicle_id),start_time)
);

CREATE MATERIALIZED VIEW IF NOT EXISTS vehicle_rides_summary AS
    SELECT * FROM rides_summary
    WHERE vehicle_id IS NOT NULL AND start_time IS NOT NULL AND rider_id IS NOT NULL
    PRIMARY KEY ((vehicle_id),start_time,rider_id)
    WITH CLUSTERING ORDER BY (start_time DESC);

CREATE MATERIALIZED VIEW IF NOT EXISTS rider_rides_summary AS
    SELECT * FROM rides_summary
    WHERE vehicle_id IS NOT NULL AND start_time IS NOT NULL AND rider_id IS NOT NULL
    PRIMARY KEY ((rider_id),start_time,vehicle_id)
    WITH CLUSTERING ORDER BY (start_time DESC);

ALTER TABLE rides_summary ADD dav_awarded decimal;