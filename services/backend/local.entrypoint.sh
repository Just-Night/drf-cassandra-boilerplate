#!/bin/sh

if [ "$DATABASE" = "cassandra" ]
then
    echo "Waiting for cassandra..."

    while ! nc -z $CASSANDRA_HOST $CASSANDRA_PORT; do
      sleep 0.1
    done

    echo "Cassandra started"
fi

# python manage.py migrate --no-input
# python manage.py collectstatic --no-input
# python manage.py createsuperuser --username $DJANGO_SUPERUSER_LOGIN --email $DJANGO_SUPERUSER_EMAIL --noinput

python manage.py runserver 0.0.0.0:8000
