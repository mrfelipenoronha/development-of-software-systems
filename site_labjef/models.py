from django.db import models

# relaçã
# o EXAME
class Exame(models.Model):
    id_exame = models.IntegerField(primary_key=True)
    tipo = models.CharField(max_length=255, unique=True)
    virus = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.tipo


# relação SERVIÇO
class Servico(models.Model):
    CLASSES = [
        ('V', 'visualização'),
        ('I', 'inserção'),
        ('A', 'alteração'),
        ('R', 'remoção'),
    ]
    id_servico = models.IntegerField(primary_key=True)
    nome = models.CharField(max_length=255, unique=True)
    classe = models.CharField(max_length=1, choices=CLASSES, unique=True)
    descricao = models.CharField(max_length=255, blank=True)
    exames = models.ManyToManyField(Exame, through='Usa')

    def __str__(self):
        return f"{self.nome} ({self.classe})"


# relação PESSOA
class Pessoa(models.Model):
    id_pessoa = models.IntegerField(primary_key=True)
    cpf = models.CharField(max_length=11, unique=True)
    nome = models.CharField(max_length=255)
    data_nasc = models.DateField(blank=True)
    email = models.CharField(max_length=255, blank=True)
    telefone = models.CharField(max_length=15, blank=True)
    endereco = models.CharField(max_length=255, blank=True)

    def __str__(self):
        return self.nome


# relação PERFIL
class Perfil(models.Model):
    id_perfil = models.IntegerField(primary_key=True)
    codigo = models.CharField(max_length=255, unique=True)
    data_criacao = models.DateField(blank=True)
    tipo = models.CharField(max_length=255)
    servicos = models.ManyToManyField(Servico, through='Pode_fazer')

    class Meta:
        verbose_name_plural = "perfis"

    def __str__(self):
        return f"{self.codigo}, {self.tipo}"


# relação USUARIO
class Usuario(models.Model):
    id_usuario = models.OneToOneField(
        Pessoa, 
        primary_key=True,
        on_delete=models.CASCADE
    )
    instituicao = models.CharField(max_length=255, blank=True)
    login = models.CharField(max_length=255, unique=True)
    senha = models.CharField(max_length=255)
    id_tutor = models.ForeignKey("self", on_delete=models.PROTECT, blank=True)
    perfis = models.ManyToManyField(Perfil, through='Acessa')
    
    #class Meta:
    #    constraints = [models.UniqueConstraint(fields=['login'], name='unique_login')]

    def __str__(self):
        return self.login


# relação ACESSA
class Acessa(models.Model):
    id_usuario = models.ForeignKey(Usuario, on_delete=models.PROTECT)
    id_perfil =  models.ForeignKey(Perfil, on_delete=models.PROTECT)

    class Meta:
        constraints = [models.UniqueConstraint(
            fields=['id_usuario', 'id_perfil'],
            name='unique_usuario_perfil')
        ]


# relação PODE_FAZER
class Pode_fazer(models.Model):
    id_perfil = models.ForeignKey(Perfil, on_delete=models.PROTECT)
    id_servico = models.ForeignKey(Servico, on_delete=models.PROTECT)

    class Meta:
        constraints = [models.UniqueConstraint(
            fields=['id_perfil', 'id_servico'],
            name='unique_perfil_servico')
        ]


# relação USA
class Usa(models.Model):
    id_servico = models.ForeignKey(Servico, on_delete=models.PROTECT)
    id_exame = models.ForeignKey(Exame, on_delete=models.PROTECT)

    class Meta:
        constraints = [models.UniqueConstraint(
            fields=['id_servico', 'id_exame'],
            name='unique_servico_exame')
        ]
