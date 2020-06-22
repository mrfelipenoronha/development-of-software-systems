from django.contrib import admin

# Register your models here.
from .models import Pessoa, Usuario, Perfil, Acessa

class PerfilInline(admin.TabularInline):
    model = Acessa
    extra = 1

class UsuarioAdmin(admin.ModelAdmin):
    inlines = (PerfilInline,)

admin.site.register(Pessoa)
admin.site.register(Usuario, UsuarioAdmin)
admin.site.register(Perfil)
