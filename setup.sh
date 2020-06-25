#!/bin/bash

# build stuff in primary docker
docker-compose build
# build the rest
docker-compose up -d
docker-compose down
# creating the database
docker-compose run web python manage.py migrate
docker-compose run web python manage.py makemigrations
docker-compose run web python manage.py migrate
# populating database
cat ./data.sql | docker exec -i /labjef_db_1 psql -U postgres -d postgres
# creating super user
docker-compose run web python manage.py createsuperuser --no-input --username admin --email oi@oi.com

# opening page
docker-compose up -d
xdg-open http://0.0.0.0:8000/laboratorio