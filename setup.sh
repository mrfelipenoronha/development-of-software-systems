#!/bin/bash

echo -e '\n\nBUILDING PRIMARY DOCKER CONTAINER\n\n'
docker-compose build
echo -e '\n\nBUILDING DATABASE CONTAINER\n\n' 
docker-compose up -d --build db
docker-compose up -d --build web
docker-compose down
echo -e '\n\nCREATING DATABASE STRUCTURE\n\n'
docker-compose run web python manage.py migrate
docker-compose run web python manage.py makemigrations
docker-compose run web python manage.py migrate
echo -e '\n\nPOPULATING DATABASE\n\n'
cat ./data.sql | docker exec -i development-of-software-systems_db_1 psql -U postgres -d postgres
echo -e '\n\nCREATING DJANGO SUPER USER\n\n'
docker-compose run web python manage.py createsuperuser --no-input --username admin --email oi@oi.com
echo -e '\n\nOPENING SYSTEM PAGE\n\n'
docker-compose up -d
sleep 2
xdg-open http://0.0.0.0:8000/laboratorio