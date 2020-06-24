# Trabalho de merda

## Docker setupping

- Para criar o docker com django/postgressql usei [este tutorial](https://docs.docker.com/compose/django/).
- Primeiro comando executado `sudo docker-compose run web django-admin startproject project_labjef .`, com isso criei o projeto em si
- Pra rodar o bixo basta invocar `docker-compose up` e acessar [http://0.0.0.0:8000/](http://0.0.0.0:8000/)
- Sempre que quisermos invocar algum comando do _django_ podemos fazer com `docker-compose run web <comando>`
- Invocar `docker-compose build` se eu quiser instalar mais alguma porrinha do _requirements.txt_
- (talvez não seja tão seguro rodar isso) Tem que dar `sudo chown -R $USER:$USER .` pra arrumar as permissões das coisas que são criadas dentro do docker

## Django stuff 

- Aqui comecei a seguir [o tutorial do próprio João Goulart](https://docs.djangoproject.com/en/3.0/intro/tutorial01/).
- Para criar o site dentro do projeto, executei `docker-compose run web python manage.py startapp site_labjef`
- Talves [este link tenha que ser visitado depois com os models](https://stackoverflow.com/questions/33992867/how-do-you-perform-django-database-migrations-when-using-docker-compose)

## DB stuff

- Inserindo na classe pai caso ela não exista vai ser feito [usando isso](https://stackoverflow.com/questions/4069718/postgres-insert-if-does-not-exist-already)
- A herança [pode ser vista aqui](https://www.postgresql.org/docs/10/tutorial-inheritance.html)
- Talvez oq a gente va fazer é chamado de [partitioning](https://zaiste.net/posts/table-inheritance-partitioning-postgresql/)
