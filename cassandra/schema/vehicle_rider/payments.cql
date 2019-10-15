USE vehicle_rider;

CREATE TABLE IF NOT EXISTS payments (
    owner_id uuid,
    rider_id uuid,
    transaction_time timestamp,

    transaction_id text,
    vaulted_shopper_id text,
    vendor_id text,
    commission_factor decimal,
    currency_code text,
    amount decimal,

    PRIMARY KEY((rider_id), transaction_time, owner_id)
);

ALTER TABLE payments ADD commission_factor_for_dav_reward decimal;