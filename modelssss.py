# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Acessa(models.Model):
    id_usuario = models.ForeignKey('Usuario', models.DO_NOTHING, db_column='id_usuario')
    id_perfil = models.ForeignKey('Perfil', models.DO_NOTHING, db_column='id_perfil')

    class Meta:
        managed = False
        db_table = 'acessa'
        unique_together = (('id_usuario', 'id_perfil'),)


class Amostra(models.Model):
    codigo_amostra = models.CharField(max_length=255)
    id_paciente = models.ForeignKey('Paciente', models.DO_NOTHING, db_column='id_paciente')
    id_exame = models.ForeignKey('Exame', models.DO_NOTHING, db_column='id_exame')
    metodo_coleta = models.CharField(max_length=255)
    tipo_material = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'amostra'
        unique_together = (('id_paciente', 'id_exame', 'codigo_amostra'),)


class Exame(models.Model):
    id_exame = models.IntegerField(primary_key=True)
    tipo = models.CharField(max_length=255)
    virus = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'exame'
        unique_together = (('tipo', 'virus'),)


class Paciente(models.Model):
    id_paciente = models.OneToOneField('Pessoa', models.DO_NOTHING, db_column='id_paciente', primary_key=True)

    class Meta:
        managed = False
        db_table = 'paciente'


class Perfil(models.Model):
    id_perfil = models.IntegerField(primary_key=True)
    codigo = models.CharField(unique=True, max_length=255)
    data_criacao = models.DateField(blank=True, null=True)
    tipo = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'perfil'


class Pessoa(models.Model):
    id_pessoa = models.IntegerField(primary_key=True)
    cpf = models.CharField(unique=True, max_length=11)
    nome = models.CharField(max_length=255)
    data_nasc = models.DateField(blank=True, null=True)
    email = models.CharField(max_length=255, blank=True, null=True)
    telefone = models.CharField(max_length=15, blank=True, null=True)
    endereco = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pessoa'


class PodeFazer(models.Model):
    id_perfil = models.ForeignKey(Perfil, models.DO_NOTHING, db_column='id_perfil')
    id_servico = models.ForeignKey('Servico', models.DO_NOTHING, db_column='id_servico')

    class Meta:
        managed = False
        db_table = 'pode_fazer'
        unique_together = (('id_perfil', 'id_servico'),)


class Realiza(models.Model):
    id_paciente = models.ForeignKey(Paciente, models.DO_NOTHING, db_column='id_paciente')
    id_exame = models.ForeignKey(Exame, models.DO_NOTHING, db_column='id_exame')
    data_realizacao = models.DateTimeField(blank=True, null=True)
    data_solicitacao = models.DateTimeField(blank=True, null=True)
    codigo_amostra = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'realiza'
        unique_together = (('id_paciente', 'id_exame', 'data_realizacao'),)


class Servico(models.Model):
    id_servico = models.IntegerField(primary_key=True)
    nome = models.CharField(max_length=255)
    classe = models.CharField(max_length=255)
    descricao = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'servico'
        unique_together = (('nome', 'classe'),)

class Tutelamento(models.Model):
    id_tutor = models.ForeignKey('Usuario', models.DO_NOTHING, db_column='id_tutor')
    id_tutorado = models.ForeignKey('Usuario', models.DO_NOTHING, db_column='id_tutorado')
    id_perfil = models.ForeignKey(Perfil, models.DO_NOTHING, db_column='id_perfil')
    id_servico = models.ForeignKey(Servico, models.DO_NOTHING, db_column='id_servico')
    data_inicio = models.DateField()
    data_fim = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tutelamento'
        unique_together = (('id_tutor', 'id_tutorado', 'id_perfil', 'id_servico'),)


class Usa(models.Model):
    id_servico = models.ForeignKey(Servico, models.DO_NOTHING, db_column='id_servico')
    id_exame = models.ForeignKey(Exame, models.DO_NOTHING, db_column='id_exame')

    class Meta:
        managed = False
        db_table = 'usa'
        unique_together = (('id_servico', 'id_exame'),)


class Usuario(models.Model):
    id_usuario = models.OneToOneField(Pessoa, models.DO_NOTHING, db_column='id_usuario', primary_key=True)
    instituicao = models.CharField(max_length=255, blank=True, null=True)
    login = models.CharField(unique=True, max_length=255)
    senha = models.CharField(max_length=255)
    id_tutor = models.ForeignKey('self', models.DO_NOTHING, db_column='id_tutor', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'usuario'


class Utilizou(models.Model):
    id_utilizacao = models.IntegerField(primary_key=True)
    id_usuario = models.ForeignKey(Usuario, models.DO_NOTHING, db_column='id_usuario')
    id_servico = models.ForeignKey(Servico, models.DO_NOTHING, db_column='id_servico')
    id_exame = models.ForeignKey(Exame, models.DO_NOTHING, db_column='id_exame')
    data_utilizacao = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'utilizou'
        unique_together = (('id_utilizacao', 'id_usuario', 'data_utilizacao'),)
