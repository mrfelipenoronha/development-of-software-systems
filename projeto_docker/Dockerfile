
# python version
FROM python:3

# envoriment variables
ENV PYTHONUNBUFFERED 1

RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/

# instalando coisas como jungle
RUN pip install -r requirements.txt
COPY . /code/