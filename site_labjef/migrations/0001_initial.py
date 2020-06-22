# Generated by Django 3.0.7 on 2020-06-22 19:42

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Perfil',
            fields=[
                ('id_perfil', models.IntegerField(primary_key=True, serialize=False)),
                ('codigo', models.CharField(max_length=255, unique=True)),
                ('data_criacao', models.DateField(blank=True)),
                ('tipo', models.CharField(max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='Pessoa',
            fields=[
                ('id_pessoa', models.IntegerField(primary_key=True, serialize=False)),
                ('cpf', models.CharField(max_length=11, unique=True)),
                ('nome', models.CharField(max_length=255)),
                ('data_nasc', models.DateField(blank=True)),
                ('email', models.CharField(blank=True, max_length=255)),
                ('telefone', models.CharField(blank=True, max_length=15)),
                ('endereco', models.CharField(blank=True, max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='Acessa',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('id_perfil', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='site_labjef.Perfil')),
            ],
        ),
        migrations.CreateModel(
            name='Usuario',
            fields=[
                ('id_usuario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='site_labjef.Pessoa', unique=True)),
                ('instituicao', models.CharField(blank=True, max_length=255)),
                ('login', models.CharField(max_length=255, unique=True)),
                ('senha', models.CharField(max_length=255)),
                ('id_tutor', models.ForeignKey(blank=True, on_delete=django.db.models.deletion.PROTECT, to='site_labjef.Usuario')),
                ('perfis', models.ManyToManyField(through='site_labjef.Acessa', to='site_labjef.Perfil')),
            ],
        ),
        migrations.AddField(
            model_name='acessa',
            name='id_usuario',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='site_labjef.Usuario'),
        ),
        migrations.AddConstraint(
            model_name='acessa',
            constraint=models.UniqueConstraint(fields=('id_usuario', 'id_perfil'), name='unique_usuario_perfil'),
        ),
    ]
