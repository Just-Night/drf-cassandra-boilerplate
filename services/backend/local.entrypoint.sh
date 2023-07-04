#!/bin/sh

if [ "$DATABASE_01" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $DB_HOST $DB_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi


if [ "$DATABASE_02" = "cassandra" ]; then
    echo "Waiting for Cassandra..."

    while ! nc -z $CASSANDRA_HOST $CASSANDRA_PORT; do
        sleep 0.1
    done

    echo "Checking Cassandra keyspace..."

    until cqlsh -h $CASSANDRA_HOST -p $CASSANDRA_PORT -u $CASSANDRA_USER -p $CASSANDRA_PASSWORD -e "DESCRIBE KEYSPACE $CASSANDRA_KEYSPACE_NAME" > /dev/null 2>&1; do

        echo "test"
        sleep 0.1
    done

    echo "Cassandra started"
fi


# python manage.py migrate --no-input
# python manage.py collectstatic --no-input
# python manage.py createsuperuser --username $DJANGO_SUPERUSER_LOGIN --email $DJANGO_SUPERUSER_EMAIL --noinput

python manage.py runserver 0.0.0.0:8000
