from django.db import models

# models following our physical model

class Pessoa(models.Model):
    id_pessoa = models.IntegerField(primary_key=True, verbose_name='ID Pessoa')
    cpf = models.CharField(max_length=11, unique=True, verbose_name='CPF')
    nome = models.CharField(max_length=255)
    data_nasc = models.DateField(
        blank=True,
        null=True,
        verbose_name='Data de nascimento'
    )
    email = models.CharField(max_length=255, blank=True, null=True)
    telefone = models.CharField(max_length=15, blank=True, null=True)
    endereco = models.CharField(
        max_length=255,
        blank=True,
        null=True,
        verbose_name='Endereço'
    )

    def __str__(self):
        return f"{self.nome}"

    class Meta:
        verbose_name = "Pessoa"

class Usuario(models.Model):
    id_usuario = models.OneToOneField(
        'Pessoa', 
        primary_key=True,
        on_delete=models.CASCADE, 
        db_column='id_usuario',
        verbose_name='ID Usuário'
    )
    instituicao = models.CharField(
        max_length=255,
        blank=True,
        null=True,
        verbose_name='Instituição'
    )
    login = models.CharField(max_length=255, unique=True)
    senha = models.CharField(max_length=255)
    id_tutor = models.ForeignKey(
        'self', 
        on_delete=models.PROTECT, 
        blank=True, 
        null=True,
        db_column='id_tutor',
        verbose_name='ID Tutor'
    )
    perfis = models.ManyToManyField('Perfil', through='Acessa')

    def __str__(self):
        return f"@{self.login}"

    class Meta:
        verbose_name = "Usuário"

class Paciente(models.Model):
    id_paciente = models.OneToOneField(
        'Pessoa', 
        primary_key=True,
        on_delete=models.CASCADE,
        db_column='id_paciente',
        verbose_name='ID Paciente'
    )

    def __str__(self):
        return f"{self.id_paciente}"

class Perfil(models.Model):
    id_perfil = models.IntegerField(primary_key=True, verbose_name='ID Perfil')
    codigo = models.CharField(max_length=255, unique=True)
    data_criacao = models.DateField(blank=True, null=True)
    tipo = models.CharField(max_length=255)
    servicos = models.ManyToManyField('Servico', through='Pode_fazer')

    class Meta:
        verbose_name = "Perfil"
        verbose_name_plural = "Perfis"

    def __str__(self):
        return f"{self.codigo} ({self.tipo})"

class Acessa(models.Model):
    id_usuario = models.ForeignKey(
        'Usuario', 
        on_delete=models.PROTECT, 
        db_column='id_usuario',
        verbose_name='Usuários'
    )
    id_perfil =  models.ForeignKey(
        'Perfil', 
        on_delete=models.PROTECT, 
        db_column='id_perfil',
        verbose_name='Perfis'
    )

    class Meta:
        unique_together = (('id_usuario', 'id_perfil'),)
        verbose_name = "Acesso de usuário a um perfil"
        verbose_name_plural = "Acessos de usuários a perfis"

    def __str__(self):
        return f"O usuário {self.id_usuario} acessa o perfil {self.id_perfil}"

class Servico(models.Model):
    CLASSES = [
        ('V', 'visualização'),
        ('I', 'inserção'),
        ('A', 'alteração'),
        ('R', 'remoção'),
    ]
    id_servico = models.IntegerField(primary_key=True, verbose_name='Id serviço')
    nome = models.CharField(max_length=255)
    classe = models.CharField(max_length=1, choices=CLASSES)
    descricao = models.CharField(
        max_length=255,
        blank=True,
        null=True,
        verbose_name='descrição'
    )
    exames = models.ManyToManyField('Exame', through='Usa')

    class Meta:
        unique_together = (('nome', 'classe'),)
        verbose_name = "Serviço"

    def __str__(self):
        return self.nome

class Pode_fazer(models.Model):
    id_perfil = models.ForeignKey(
        'Perfil', on_delete=models.PROTECT,
        db_column='id_perfil',
        verbose_name='Perfis'
    )
    id_servico = models.ForeignKey(
        'Servico', 
        on_delete=models.PROTECT,
        db_column='id_servico',
        verbose_name='Serviços'
    )

    class Meta:
        unique_together = (('id_perfil', 'id_servico'),)
        verbose_name = "Permissão de serviço para um perfil"
        verbose_name_plural = "Permissões de serviço para perfis"

    def __str__(self):
        return f"O perfil {self.id_perfil} pode fazer o serviço '{self.id_servico}'"

class Tutelamento(models.Model):
    id_tutor = models.ForeignKey(
        'Usuario', 
        on_delete=models.CASCADE, 
        related_name='id_atutor',
        db_column='id_tutor',
        verbose_name='Tutores'
    )
    id_tutorado = models.ForeignKey(
        'Usuario', 
        on_delete=models.CASCADE, 
        related_name='id_btutorado', 
        db_column='id_tutorado',
        verbose_name='Tutorados'
    )
    id_perfil = models.ForeignKey(
        Perfil, 
        on_delete=models.CASCADE, 
        db_column='id_perfil',
        verbose_name='Perfil'
    )
    id_servico = models.ForeignKey(
        Servico, 
        on_delete=models.CASCADE, 
        db_column='id_servico',
        verbose_name='Serviço'
    )
    data_inicio = models.DateField()
    data_fim = models.DateField(blank=True, null=True)

    class Meta:
        unique_together = (('id_tutor', 'id_tutorado', 'id_perfil', 'id_servico'),)
        verbose_name = "Tutelamento"

    def __str__(self):
        return f"O usuário {self.id_tutor} tutela {self.id_tutorado} (Serviço: {self.id_servico})"

class Exame(models.Model):
    id_exame = models.IntegerField(primary_key=True, verbose_name='ID Exame')
    tipo = models.CharField(max_length=255)
    virus = models.CharField(max_length=255, verbose_name='Vírus')

    class Meta:
        unique_together = (('tipo', 'virus'),)

    def __str__(self):
        return f"{self.tipo} - {self.virus}"

class Realiza(models.Model):
    id_paciente = models.ForeignKey('Paciente', models.CASCADE, db_column='id_paciente')
    id_exame = models.ForeignKey('Exame', models.CASCADE, db_column='id_exame')
    data_realizacao = models.DateTimeField(blank=True, null=True)
    data_solicitacao = models.DateTimeField(blank=True, null=True)
    codigo_amostra = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        unique_together = (('id_paciente', 'id_exame', 'data_realizacao'),)
        verbose_name = "Realização de exame"
        verbose_name_plural = "Realização de exames"

    def __str__(self):
        return f"O paciente {self.id_paciente} realiza o exame '{self.id_exame}''"

class Amostra(models.Model):
    codigo_amostra = models.CharField(max_length=255)
    id_paciente = models.ForeignKey('Paciente', models.CASCADE, db_column='id_paciente', verbose_name='ID Paciente')
    id_exame = models.ForeignKey('Exame', models.CASCADE, db_column='id_exame', verbose_name='ID Exame')
    metodo_coleta = models.CharField(max_length=255)
    tipo_material = models.CharField(max_length=255)
 
    class Meta:
        unique_together = (('id_paciente', 'id_exame', 'codigo_amostra'),)
        verbose_name = "Amostra"
        verbose_name_plural = "Amostras para exames"

    def __str__(self):
        return f"{self.codigo_amostra} - {self.id_exame}"

class Usa(models.Model):
    id_servico = models.ForeignKey(
        'Servico', 
        on_delete=models.CASCADE, 
        db_column='id_servico', 
        verbose_name='Serviços'
    )
    id_exame = models.ForeignKey(
        'Exame', 
        on_delete=models.CASCADE, 
        db_column='id_exame',
        verbose_name='Exames'
    )

    class Meta:
        unique_together = (('id_servico', 'id_exame'),)
        verbose_name = "Uso"

    def __str__(self):
        return f"O serviço '{self.id_servico}' usa o exame '{self.id_exame}''"

class Utilizou(models.Model):
    id_utilizacao = models.IntegerField(primary_key=True, db_column='id_utilizacao')
    id_usuario = models.ForeignKey('Usuario', models.CASCADE, db_column='id_usuario')
    id_servico = models.ForeignKey('Servico', models.CASCADE, db_column='id_servico')
    id_exame = models.ForeignKey('Exame', models.CASCADE, db_column='id_exame')
    data_utilizacao = models.DateTimeField()

    class Meta:
        unique_together = (('id_utilizacao', 'id_usuario', 'data_utilizacao'),)
        verbose_name_plural = "Histórico do utilização"
        verbose_name = "Utilização"

    def __str__(self):
        return f"O usuário {self.id_usuario} utilizou o serviço '{self.id_servico}'' em {self.data_utilizacao}"