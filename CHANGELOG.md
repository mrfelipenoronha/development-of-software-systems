# Old readme

## Docker setupping

- Para criar o docker com django/postgressql usei [este tutorial](https://docs.docker.com/compose/django/).
- Primeiro comando executado `sudo docker-compose run web django-admin startproject project .`, com isso criei o projeto em si
- Pra rodar o bixo basta invocar `docker-compose up` e acessar [http://0.0.0.0:8000/](http://0.0.0.0:8000/)
- Sempre que quisermos invocar algum comando do _django_ podemos fazer com `docker-compose run web <comando>`
- Invocar `docker-compose build` se eu quiser instalar mais alguma porrinha do _requirements.txt_
- (talvez não seja tão seguro rodar isso) Tem que dar `sudo chown -R $USER:$USER .` pra arrumar as permissões das coisas que são criadas dentro do docker

## Django stuff 

- Aqui comecei a seguir [o tutorial do próprio João Goulart](https://docs.djangoproject.com/en/3.0/intro/tutorial01/).
- Para criar o site dentro do projeto, executei `docker-compose run web python manage.py startapp laboratorio`
- Talves [este link tenha que ser visitado depois com os models](https://stackoverflow.com/questions/33992867/how-do-you-perform-django-database-migrations-when-using-docker-compose)

## DB stuff

- Inserindo na classe pai caso ela não exista vai ser feito [usando isso](https://stackoverflow.com/questions/4069718/postgres-insert-if-does-not-exist-already)
- A herança [pode ser vista aqui](https://www.postgresql.org/docs/10/tutorial-inheritance.html)
- Talvez oq a gente va fazer é chamado de [partitioning](https://zaiste.net/posts/table-inheritance-partitioning-postgresql/)

# CHANGELOG

## Coisas feitas hoje (22/06)

- Adicionei um pacote no dockerfile (pra gerar a visualização do banco), então tive que dar um `docker-compose build`
- Executei `docker-compose run web python manage.py migrate` pra fazer a migração inicial do banco, setando umas tables que são usadas pelo django, é o que ele fala pra ser feito [aqui](https://docs.djangoproject.com/en/3.0/intro/tutorial02/#database-setup)
- Criei as models em `laboratorio/models.py`
    - Pessoa, Perfil, Usuario, Acessa
    - Dani, decida se deixa ou não os tabs la no model
    - Eu dei uma olhada [aqui](https://docs.djangoproject.com/en/3.0/topics/db/models/) pra ver certinhos os tipos dentro das models
    - Eu disse ao django que tinhamos o aplicativo laboratoriot ([segui isso](https://docs.djangoproject.com/en/3.0/intro/tutorial02/#activating-models)). Para isso eu modifiquei o arquivo `project/settings.py`
    - Criei as migrações a serem feitas com `docker-compose run web python manage.py makemigrations laboratorio`
    - Dei um _commit_ na migração criada com `docker-compose run web python manage.py migrate`
    - Executei `docker-compose run web python manage.py graph_models laboratorio -o relational.png` para gerar a imagem do banco
- Criei um superusuario com o comando `docker-compose run web python manage.py createsuperuser`
    - Usuario e senha são `admin`, basta acessar [http://0.0.0.0:8000/admin/](http://0.0.0.0:8000/admin/)
    - Segui [esse guia aqui](https://docs.djangoproject.com/en/3.0/intro/tutorial02/#introducing-the-django-admin)
    - Fiz umas alterações no `laboratorio/admin.py`, não sei muito bem o que fiz, mas aparentemente funciona

## Coisas feitas hoje (23/06)

- Buildei, fiz o migrate, permiti acesso ao admin
- Continuação da criação dos models em `laboratorio/models.py`
    - Servico, Exame, Pode_Fazer, Usa
    - Tirei os tabs
    - PF PASSOU POR AQUI KKK: não passamos mais de 89 colunas
    - Rodei `makemigrations` e `migrate`
    - Gerei a imagem do banco pelo pygraphviz no arquivo `relational2.png`
    - Mudanças no `admin.py`
- Questões
    - `Pessoa` é classe abstrata? -> Herança de Pessoa pra Usuario e Paciente (?)
    - Não entendi muito bem como funciona a `admin.py` pra relacionamentos, só registrei as entidades

## Coisas feitas hoje (24/06 madruga)

- Arrumei o admin.py pra exibir as colunas certinho
- Arrumei o model do usuário pra ser OneToOneField
- Arrumei alguns models pra incluir campos de ManyToMany
- Rodei `makemigrations` e `migrate`
- Gerei a imagem do banco pelo pygraphviz no arquivo `relational2.png`
- Arrumei o visuzalição e o plural de Perfil
- Problemas no banco:
    - Não é possível visualizar/editar/remover um perfil nem um serviço. Nem criar um deles com o campo `pode_fazer` preenchido.   
    ``` 
        ProgrammingError at /admin/laboratorio/perfil/2/change/
            relation "laboratorio_pode_fazer" does not exist
            LINE 1: ...d", "laboratorio_pode_fazer"."id_servico_id" FROM "site_labj...
    ```

    ``` 
        ProgrammingError at /admin/laboratorio/servico/add/
            relation "laboratorio_pode_fazer" does not exist
            LINE 1: SELECT (1) AS "a" FROM "laboratorio_pode_fazer" WHERE ("site...
    ```
    - Vê se vc consegue replicar esse erro aí, ou se é só no meu pc que essa caca ocorreu

## Coisas feitas hoje (24/06)

- Completei os models com as tabelas que faltavam do modelo físico
    - Mudei o metodo usado para as restrições unique
    - Complementei as `__str__` das classes
    - Rodei `makemigration` e o `migrate`
    - Imagem nova do banco ja pode ser vista em `relational.png`
        - Descobri que o comando `docker-compose run web python manage.py graph_models laboratorio -o relational.png` é muito superior
- Resetei o DB
    - comentei todas as nossas linhas de codigo de `models.py` e `admin.py`, fiz e commitei a migração
    - apaguei as migrations da pasta migrations
    - descomentei as coisas comentadas, e fiz a migração
    - Executei ` docker-compose run web python manage.py sqlmigrate laboratorio 0001 > oi.sql` para gerar um arquivo sql da criação do banco, so pra conferir que tudo tava certo
    - Obviamente não tava -
        - Complemente o atributo `blank` com `null`
        - Algumas colunas ficaram com nome estranho, tive que mudar isso no script
- Mudei o nome da aplicação para **laboratorio** e o do projeto para **project**
- Adicionei e formatei a pagina `index.html`
    - Criei um templete e um estil
- Criei paginas e metodos pras queries da etapa 2