USE vehicle_rider;

CREATE TABLE IF NOT EXISTS riders (
    id uuid,

    email text,

    phone_number text,
    phone_confirmed boolean,

    first_name text,
    last_name text,

    profile_image_id text,

    eth_addr text,
    private_key blob,

    payment_method_customer text,
    payment_method_id text,

    PRIMARY KEY (id)
);

CREATE MATERIALIZED VIEW IF NOT EXISTS riders_phone AS
    SELECT * FROM riders
    WHERE phone_number IS NOT NULL
    PRIMARY KEY (phone_number, id);

ALTER TABLE riders ADD dav_balance decimal;
