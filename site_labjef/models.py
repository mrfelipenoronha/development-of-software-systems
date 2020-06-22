from django.db import models

# relação PESSOA
class Pessoa(models.Model):
    id_pessoa = models.IntegerField(primary_key=True)
    cpf =       models.CharField(max_length=11, unique=True)
    nome =      models.CharField(max_length=255)
    data_nasc = models.DateField(blank=True)
    email =     models.CharField(max_length=255, blank=True)
    telefone =  models.CharField(max_length=15, blank=True)
    endereco =  models.CharField(max_length=255, blank=True)

    def __str__(self):
        return self.nome

# relação PERFIL
class Perfil(models.Model):
    id_perfil =    models.IntegerField(primary_key=True)
    codigo =       models.CharField(max_length=255, unique=True)
    data_criacao = models.DateField(blank=True)
    tipo =         models.CharField(max_length=255)

    def __str__(self):
        return self.codigo +','+ self.tipo

# relação USUARIO
class Usuario(models.Model):
    id_usuario =  models.ForeignKey(Pessoa, primary_key=True, unique=True, on_delete=models.CASCADE) #one-to-one relation
    instituicao = models.CharField(max_length=255, blank=True)
    login =       models.CharField(max_length=255, unique=True)
    senha =       models.CharField(max_length=255)
    id_tutor =    models.ForeignKey("self", on_delete=models.PROTECT, blank=True)
    perfis =      models.ManyToManyField(Perfil, through='Acessa')
    
    #class Meta:
    #    constraints = [models.UniqueConstraint(fields=['login'], name='unique_login')]

    def __str__(self):
        return self.login

# relação ACESSA
class Acessa(models.Model):
    id_usuario = models.ForeignKey(Usuario, on_delete=models.PROTECT)
    id_perfil =  models.ForeignKey(Perfil, on_delete=models.PROTECT)
    
    class Meta:
        constraints = [models.UniqueConstraint(fields=['id_usuario', 'id_perfil'], name='unique_usuario_perfil')]