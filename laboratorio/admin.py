from django.contrib import admin

from .models import (
    Usuario, 
    Perfil, 
    Servico, 
    Exame,
    Pessoa
    )

class AcessoInline(admin.TabularInline):
    model = Usuario.perfis.through
    extra = 1

class UsaInline(admin.TabularInline):
    model = Servico.exames.through
    extra = 1

class Pode_fazerInline(admin.TabularInline):
    model = Perfil.servicos.through
    extra = 1

class PerfilAdmin(admin.ModelAdmin):
    inlines = (AcessoInline, Pode_fazerInline,)
    list_display = ('id_perfil', 'codigo', 'tipo', 'data_criacao')
    list_display_links = ('id_perfil', 'codigo')

class UsuarioAdmin(admin.ModelAdmin):
    inlines = (AcessoInline,)
    list_display = ('id_usuario', 'login', 'instituicao', 'id_tutor')
    list_display_link = ('id_usuario', 'login')

class ServicoAdmin(admin.ModelAdmin):
    inlines = (UsaInline, Pode_fazerInline)
    list_display = ('id_servico', 'nome', 'classe', 'descricao')
    list_display_links = ('id_servico', 'nome')

class ExameAdmin(admin.ModelAdmin):
    inlines = (UsaInline,)
    list_display = ('id_exame', 'tipo', 'virus')

class PessoaAdmin(admin.ModelAdmin):
    list_display = ('id_pessoa', 'nome', 'cpf', 'data_nasc')
    list_display_links = ('id_pessoa', 'nome', 'cpf')

admin.site.register(Pessoa, PessoaAdmin)
admin.site.register(Usuario, UsuarioAdmin)
admin.site.register(Perfil, PerfilAdmin)
admin.site.register(Servico, ServicoAdmin)
admin.site.register(Exame, ExameAdmin)
