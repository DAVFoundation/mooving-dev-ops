USE vehicle_rider;

CREATE TABLE IF NOT EXISTS dav_conversion_rates (
    update_date date,
    update_time time,
    updated_timestamp timestamp,

    usd_price decimal,
    ils_price decimal,
    eur_price decimal,
    gbp_price decimal,
    php_price decimal,
    idr_price decimal,
    huf_price decimal,
    pln_price decimal,

    PRIMARY KEY((update_date),update_time)
);
