from django.db import models

# models following our physical model

class Pessoa(models.Model):
    id_pessoa = models.IntegerField(primary_key=True)
    cpf = models.CharField(max_length=11, unique=True)
    nome = models.CharField(max_length=255)
    data_nasc = models.DateField(blank=True, null=True)
    email = models.CharField(max_length=255, blank=True, null=True)
    telefone = models.CharField(max_length=15, blank=True, null=True)
    endereco = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.nome}"

class Usuario(models.Model):
    id_usuario = models.OneToOneField(
        'Pessoa', 
        primary_key=True,
        on_delete=models.CASCADE, 
        db_column='id_usuario'
    )
    instituicao = models.CharField(max_length=255, blank=True, null=True)
    login = models.CharField(max_length=255, unique=True)
    senha = models.CharField(max_length=255)
    id_tutor = models.ForeignKey(
        'self', 
        on_delete=models.PROTECT, 
        blank=True, 
        null=True,
        db_column='id_tutor'
    )
    perfis = models.ManyToManyField('Perfil', through='Acessa')

    def __str__(self):
        return f"{self.login}"

class Paciente(models.Model):
    id_paciente = models.OneToOneField(
        'Pessoa', 
        primary_key=True,
        on_delete=models.CASCADE,
        db_column='id_paciente'
    )

    def __str__(self):
        return f"{self.id_paciente}"

class Perfil(models.Model):
    id_perfil = models.IntegerField(primary_key=True)
    codigo = models.CharField(max_length=255, unique=True)
    data_criacao = models.DateField(blank=True, null=True)
    tipo = models.CharField(max_length=255)
    servicos = models.ManyToManyField('Servico', through='Pode_fazer')

    class Meta:
        verbose_name_plural = "perfis"

    def __str__(self):
        return f"{self.codigo} ({self.tipo})"

class Acessa(models.Model):
    id_usuario = models.ForeignKey('Usuario', on_delete=models.PROTECT, db_column='id_usuario')
    id_perfil =  models.ForeignKey('Perfil', on_delete=models.PROTECT, db_column='id_perfil')

    class Meta:
        unique_together = (('id_usuario', 'id_perfil'),)

    def __str__(self):
        return f"usuario {self.id_usuario} acessa perfil {self.id_perfil}"

class Servico(models.Model):
    CLASSES = [
        ('V', 'visualização'),
        ('I', 'inserção'),
        ('A', 'alteração'),
        ('R', 'remoção'),
    ]
    id_servico = models.IntegerField(primary_key=True)
    nome = models.CharField(max_length=255)
    classe = models.CharField(max_length=1, choices=CLASSES)
    descricao = models.CharField(max_length=255, blank=True, null=True)
    exames = models.ManyToManyField('Exame', through='Usa')

    class Meta:
        unique_together = (('nome', 'classe'),)

    def __str__(self):
        return f"{self.nome} ({self.classe})"

class Pode_fazer(models.Model):
    id_perfil = models.ForeignKey('Perfil', on_delete=models.PROTECT, db_column='id_perfil')
    id_servico = models.ForeignKey('Servico', on_delete=models.PROTECT, db_column='id_servico')

    class Meta:
        unique_together = (('id_perfil', 'id_servico'),)

    def __str__(self):
        return f"pefil {self.id_perfil} pode fazer servico {self.id_servico}"

class Tutelamento(models.Model):
    id_tutor = models.ForeignKey(
        'Usuario', 
        on_delete=models.CASCADE, 
        related_name='id_atutor',
        db_column='id_tutor'
    )
    id_tutorado = models.ForeignKey(
        'Usuario', 
        on_delete=models.CASCADE, 
        related_name='id_btutorado', 
        db_column='id_tutorado'
    )
    id_perfil = models.ForeignKey(
        Perfil, 
        on_delete=models.CASCADE, 
        db_column='id_perfil'
    )
    id_servico = models.ForeignKey(
        Servico, 
        on_delete=models.CASCADE, 
        db_column='id_servico'
    )
    data_inicio = models.DateField()
    data_fim = models.DateField(blank=True, null=True)

    class Meta:
        unique_together = (('id_tutor', 'id_tutorado', 'id_perfil', 'id_servico'),)

    def __str__(self):
        return f"usuario {self.id_tutor} tutela {self.id_tutorado} (servico {self.id_servico})"

class Exame(models.Model):
    id_exame = models.IntegerField(primary_key=True)
    tipo = models.CharField(max_length=255)
    virus = models.CharField(max_length=255)

    class Meta:
        unique_together = (('tipo', 'virus'),)

    def __str__(self):
        return f"{self.tipo} {self.virus}"

class Realiza(models.Model):
    id_paciente = models.ForeignKey('Paciente', models.CASCADE, db_column='id_paciente')
    id_exame = models.ForeignKey('Exame', models.CASCADE, db_column='id_exame')
    data_realizacao = models.DateTimeField(blank=True, null=True)
    data_solicitacao = models.DateTimeField(blank=True, null=True)
    codigo_amostra = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        unique_together = (('id_paciente', 'id_exame', 'data_realizacao'),)

    def __str__(self):
        return f"paciente {self.id_paciente} realiza exame {self.id_exame}"

class Amostra(models.Model):
    codigo_amostra = models.CharField(max_length=255)
    id_paciente = models.ForeignKey('Paciente', models.CASCADE, db_column='id_paciente')
    id_exame = models.ForeignKey('Exame', models.CASCADE, db_column='id_exame')
    metodo_coleta = models.CharField(max_length=255)
    tipo_material = models.CharField(max_length=255)
 
    class Meta:
        unique_together = (('id_paciente', 'id_exame', 'codigo_amostra'),)

    def __str__(self):
        return f"{self.codigo_amostra} - {self.id_exame}"

class Usa(models.Model):
    id_servico = models.ForeignKey('Servico', on_delete=models.CASCADE, db_column='id_servico')
    id_exame = models.ForeignKey('Exame', on_delete=models.CASCADE, db_column='id_exame')

    class Meta:
        unique_together = (('id_servico', 'id_exame'),)

    def __str__(self):
        return f"servico {self.id_servico} usa exame {self.id_exame}"

class Utilizou(models.Model):
    id_utilizacao = models.IntegerField(primary_key=True, db_column='id_utilizacao')
    id_usuario = models.ForeignKey('Usuario', models.CASCADE, db_column='id_usuario')
    id_servico = models.ForeignKey('Servico', models.CASCADE, db_column='id_servico')
    id_exame = models.ForeignKey('Exame', models.CASCADE, db_column='id_exame')
    data_utilizacao = models.DateTimeField()

    class Meta:
        unique_together = (('id_utilizacao', 'id_usuario', 'data_utilizacao'),)

    def __str__(self):
        return f"usuario {self.id_usuario} utilizou servico {self.id_servico} em {self.data_utilizacao}"