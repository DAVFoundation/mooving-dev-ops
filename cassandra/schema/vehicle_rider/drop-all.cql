DROP INDEX IF EXISTS vehicle_rider.idx_vehicles_status;

DROP MATERIALIZED VIEW IF EXISTS vehicle_rider.vehicle_active_rides;
DROP TABLE IF EXISTS vehicle_rider.rider_active_rides;

DROP TABLE IF EXISTS vehicle_rider.dav_conversion_rates;

DROP TABLE IF EXISTS vehicle_rider.failed_txns;

DROP TABLE IF EXISTS vehicle_rider.model_battery_params;

DROP TABLE IF EXISTS vehicle_rider.owner_dav_balance;

DROP TABLE IF EXISTS vehicle_rider.owner_stats_daily;

DROP MATERIALIZED VIEW IF EXISTS vehicle_rider.owners_phone;
DROP TABLE IF EXISTS vehicle_rider.owners;

DROP TABLE IF EXISTS vehicle_rider.payments;

DROP TABLE IF EXISTS vehicle_rider.pending_txns;

DROP MATERIALIZED VIEW IF EXISTS vehicle_rider.riders_phone;
DROP TABLE IF EXISTS vehicle_rider.riders;

DROP TABLE IF EXISTS vehicle_rider.rides_summary_effective_date;

DROP TABLE IF EXISTS vehicle_rider.rides_summary;

DROP TABLE IF EXISTS vehicle_rider.user_jobs;

DROP TABLE IF EXISTS vehicle_rider.vehicle_location_search_results;

DROP TABLE IF EXISTS vehicle_rider.vehicle_stats_daily;

DROP MATERIALIZED VIEW IF EXISTS vehicle_rider.vehicles_qr_code;
DROP MATERIALIZED VIEW IF EXISTS vehicle_rider.owner_vehicles;
DROP TABLE IF EXISTS vehicle_rider.vehicles;

DROP KEYSPACE IF EXISTS vehicle_rider;
