USE vehicle_rider;

CREATE TABLE IF NOT EXISTS owner_dav_balance (
    id uuid,
    dav_balance_delta counter,

    PRIMARY KEY (id)
);