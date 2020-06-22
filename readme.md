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

## Coisas feitas hoje (22/06)

- Adicionei um pacote no dockerfile (pra gerar a visualização do banco), então tive que dar um `docker-compose build`
- Executei `docker-compose run web python manage.py migrate` pra fazer a migração inicial do banco, setando umas tables que são usadas pelo django, é o que ele fala pra ser feito [aqui](https://docs.djangoproject.com/en/3.0/intro/tutorial02/#database-setup)
- Criei as models em `site_labjef/models.py`
    - Dani, decida se deixa ou não os tabs la no model
    - Eu dei uma olhada [aqui](https://docs.djangoproject.com/en/3.0/topics/db/models/) pra ver certinhos os tipos dentro das models
    - Eu disse ao django que tinhamos o aplicativo site_labjeft ([segui isso](https://docs.djangoproject.com/en/3.0/intro/tutorial02/#activating-models)). Para isso eu modifiquei o arquivo `project_labjef/settings.py`
    - Criei as migrações a serem feitas com `docker-compose run web python manage.py makemigrations site_labjef`
    - Dei um _commit_ na migração criada com `docker-compose run web python manage.py migrate`
    - Executei `docker-compose run web python manage.py graph_models --pygraphviz -a -g -o relational.png` para gerar a imagem do banco
- Criei um superusuario com o comando `docker-compose run web python manage.py createsuperuser`
    - Usuario e senha são `admin`, basta acessar [http://0.0.0.0:8000/admin/](http://0.0.0.0:8000/admin/)
    - Segui [esse guia aqui](https://docs.djangoproject.com/en/3.0/intro/tutorial02/#introducing-the-django-admin)
    - Fiz umas alterações no `site_labjef/admin.py`, não sei muito bem o que fiz, mas aparentemente funciona