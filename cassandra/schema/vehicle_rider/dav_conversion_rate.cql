USE vehicle_rider;

CREATE TABLE IF NOT EXISTS dav_conversion_rate (
    currency_code text,
    updated_timestamp timestamp,
    price decimal,
    PRIMARY KEY((currency_code))
);
