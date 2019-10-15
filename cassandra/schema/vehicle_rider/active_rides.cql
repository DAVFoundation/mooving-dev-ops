USE vehicle_rider;

CREATE TABLE IF NOT EXISTS rider_active_rides (
    rider_id uuid,
    vehicle_id uuid,

    start_time timestamp,
    last_time timestamp,

    start_geohash text,
    last_geohash text,
    distance decimal,

    start_battery_percentage tinyint,
    last_battery_percentage tinyint,

    transaction_id text,

    PRIMARY KEY(rider_id)
);

CREATE MATERIALIZED VIEW IF NOT EXISTS vehicle_active_rides AS
    SELECT * FROM rider_active_rides
    WHERE vehicle_id IS NOT NULL
    PRIMARY KEY ((vehicle_id),rider_id);
