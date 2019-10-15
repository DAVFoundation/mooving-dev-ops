USE vehicle_rider;

CREATE TABLE IF NOT EXISTS vehicles (
    id uuid,
    owner_id uuid,
    operator_name text,
    vehicle_name text,
    status text,
    in_transition boolean,
    battery_percentage tinyint,
    model text,
    qr_code text,
    device_id text,

    base_price decimal,
    price_per_minute decimal,

    geo_hash text,
    geo_hash_1 text,
    geo_hash_2 text,
    geo_hash_3 text,
    geo_hash_4 text,
    geo_hash_5 text,
    geo_hash_6 text,
    geo_hash_7 text,
    geo_hash_8 text,
    geo_hash_9 text,
    geo_hash_10 text,

    PRIMARY KEY (id)
);

CREATE CUSTOM INDEX IF NOT EXISTS idx_vehicles_status
    ON vehicles (status)
    USING 'org.apache.cassandra.index.sasi.SASIIndex';

CREATE MATERIALIZED VIEW IF NOT EXISTS vehicles_qr_code AS
    SELECT * FROM vehicles
    WHERE qr_code IS NOT NULL
    AND id IS NOT NULL
    PRIMARY KEY ((qr_code),id);

CREATE MATERIALIZED VIEW IF NOT EXISTS owner_vehicles AS
    SELECT * FROM vehicles
    WHERE owner_id IS NOT NULL
    PRIMARY KEY ((owner_id),id);

ALTER TABLE vehicles ADD reward_base decimal;
ALTER TABLE vehicles ADD reward_factor decimal;
ALTER TABLE vehicles ADD model_image_url text;

ALTER TABLE vehicles ADD vendor text;
ALTER TABLE vehicles ADD device_state text;

ALTER TABLE vehicles ADD battery_voltage_factor_alpha decimal;
ALTER TABLE vehicles ADD battery_voltage_factor_beta decimal;
