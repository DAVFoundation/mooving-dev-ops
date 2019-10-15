USE vehicle_rider;

CREATE TABLE IF NOT EXISTS vehicles_last_transmits (
    vehicle_id uuid,
    last_5_transmits list<frozen<tuple<decimal, decimal>>>,

    PRIMARY KEY (vehicle_id)
);
