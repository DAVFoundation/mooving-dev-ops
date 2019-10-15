USE vehicle_rider;

CREATE TABLE IF NOT EXISTS owners (
    id uuid,
    email text,

    phone_number text,
    phone_confirmed boolean,

    first_name text,
    last_name text,
    company_name text,

    support_phone_number text,
    support_email text,
    support_link text,

    profile_image_id text,

    eth_addr text,
    private_key blob,

    payment_dav_factor decimal,
    fiat_currency_code text,

    pricing_using_fiat boolean,

    commission_factor decimal,

    vendor_id text,

    PRIMARY KEY (id)
);

CREATE MATERIALIZED VIEW IF NOT EXISTS owners_phone AS
    SELECT * FROM owners
    WHERE phone_number IS NOT NULL
    PRIMARY KEY (phone_number, id);

ALTER TABLE owners ADD dav_balance_base decimal;
