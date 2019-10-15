USE vehicle_rider;

CREATE TABLE IF NOT EXISTS vehicle_location_search_results (
    geo_hash_prefix text,
    search_prefix_length tinyint,
    search_prefix text,
    search_results text,

    PRIMARY KEY ((geo_hash_prefix),search_prefix_length)
) WITH default_time_to_live=600;
