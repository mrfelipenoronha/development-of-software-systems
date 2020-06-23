from django.contrib import admin
from .models import (
    Pessoa, 
    Usuario, 
    Perfil, 
    Servico, 
    Exame, 
    Acessa,
    # Pode_fazer,
    # Usa,
    )

class PerfilInline(admin.TabularInline):
    model = Acessa
    extra = 1

class UsuarioAdmin(admin.ModelAdmin):
    inlines = (PerfilInline,)

admin.site.register(Pessoa)
admin.site.register(Usuario, UsuarioAdmin)
admin.site.register(Perfil)
admin.site.register(Servico)
admin.site.register(Exame)
