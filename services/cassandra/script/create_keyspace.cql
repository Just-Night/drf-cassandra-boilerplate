CREATE KEYSPACE IF NOT EXISTS cassandra
    WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
