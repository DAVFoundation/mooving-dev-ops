CREATE KEYSPACE IF NOT EXISTS vehicle_rider
    WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 3}
    AND durable_writes = true;
