USE vehicle_rider;

CREATE TABLE IF NOT EXISTS rides_summary_effective_date (
    owner_id uuid,
    rider_id uuid,
    vehicle_id uuid,

    start_time timestamp,
    end_time timestamp,

    parking_image_url text,

    effective_date date,

    price decimal,
    currency_code text,
    conversion_rate decimal,

    commission_factor decimal,
    commission decimal,

    payment_dav_factor decimal,
    payment_method_dav boolean,

    rating tinyint,
    feedback_tags set<text>,

    PRIMARY KEY((effective_date),rider_id,vehicle_id,start_time)
);
