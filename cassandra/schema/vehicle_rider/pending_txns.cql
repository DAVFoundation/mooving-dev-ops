USE vehicle_rider;

CREATE TABLE IF NOT EXISTS pending_txns (
    from_address text,
    to_address text,
    owner_id uuid,
    amount decimal,
    txn_type text,
    insertion_time timestamp,

    PRIMARY KEY(from_address)
);