USE vehicle_rider;

CREATE TABLE IF NOT EXISTS user_jobs (
    id uuid,
    state text,
    type text,

    PRIMARY KEY (id)
);