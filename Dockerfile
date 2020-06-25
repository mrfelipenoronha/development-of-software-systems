
# python version
FROM python:3

# envoriment variables
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SUPERUSER_PASSWORD admin

RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/

# instalando coisas como jungle
RUN apt-get update
RUN pip install -r requirements.txt
RUN apt-get install -y python3-dev graphviz libgraphviz-dev pkg-config
RUN pip install pygraphviz
COPY . /code/