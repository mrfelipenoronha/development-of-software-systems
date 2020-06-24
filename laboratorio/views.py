from django.db import connection
from django.template import loader
from django.http import HttpResponse
from collections import namedtuple

def index(request):
    template = loader.get_template('laboratorio/index.html')
    return HttpResponse(template.render())

def named_tuple_fetchall(cursor):
    desc = cursor.description
    nt_result = namedtuple('Result', [col[0] for col in desc])
    result = [nt_result(*row) for row in cursor.fetchall()]

    return result

def query1(request):
    with connection.cursor() as cursor:
        cursor.execute('\
            SELECT ex.id_exame,\
            ex.tipo,\
            ps.cpf,\
            ps.nome,\
            rl.data_solicitacao,\
            rl.data_realizacao\
            FROM laboratorio_realiza AS rl\
            JOIN laboratorio_paciente AS pc ON rl.id_paciente = pc.id_paciente\
            JOIN laboratorio_pessoa AS ps on ps.id_pessoa = pc.id_paciente\
            JOIN laboratorio_exame AS ex ON rl.id_exame = ex.id_exame;\
        ')
        result = named_tuple_fetchall(cursor)
    
    print(result)
    template = loader.get_template('laboratorio/query1.html')
    context = {'query1_result_list': result,}
    
    return HttpResponse(template.render(context, request))

def query2(request):
    with connection.cursor() as cursor:
        cursor.execute('\
            SELECT e.id_exame,\
            e.tipo,\
            e.virus,\
            r.data_solicitacao,\
            r.data_realizacao\
            FROM laboratorio_exame AS e\
            JOIN laboratorio_realiza AS r ON e.id_exame = r.id_exame\
            ORDER BY (r.data_realizacao - r.data_solicitacao) ASC\
            LIMIT 5;\
        ')
        result = named_tuple_fetchall(cursor)
    
    print(result)
    template = loader.get_template('laboratorio/query2.html')
    context = {'query2_result_list': result,}
    
    return HttpResponse(template.render(context, request))

def query3(request):
    with connection.cursor() as cursor:
        cursor.execute('\
            SELECT DISTINCT s.id_servico,\
            s.nome\
            FROM laboratorio_servico AS s\
            JOIN laboratorio_pode_fazer AS pf ON pf.id_servico = s.id_servico\
            JOIN laboratorio_acessa AS ac ON ac.id_perfil = pf.id_perfil;\
        ')
        result = named_tuple_fetchall(cursor)
    
    print(result)
    template = loader.get_template('laboratorio/query3.html')
    context = {'query3_result_list': result,}
    
    return HttpResponse(template.render(context, request))

def query4(request):
    with connection.cursor() as cursor:
        cursor.execute('\
            SELECT DISTINCT s.id_servico,\
            s.nome\
            FROM laboratorio_tutelamento AS tu\
            JOIN laboratorio_servico AS s ON tu.id_servico = s.id_servico;\
        ')
        result = named_tuple_fetchall(cursor)
    
    print(result)
    template = loader.get_template('laboratorio/query4.html')
    context = {'query4_result_list': result,}
    
    return HttpResponse(template.render(context, request))

def query5(request):
    with connection.cursor() as cursor:
        cursor.execute('\
            SELECT sv.classe,\
                ac.id_perfil,\
            COUNT(ut.id_utilizacao) AS count\
            FROM laboratorio_servico AS sv\
            JOIN laboratorio_utilizou AS ut ON ut.id_servico = sv.id_servico\
            JOIN laboratorio_usuario AS us ON us.id_usuario = ut.id_usuario\
            JOIN laboratorio_acessa AS ac ON ac.id_usuario = us.id_usuario\
            GROUP BY sv.classe, ac.id_perfil\
            ORDER BY count ASC;\
        ')
        result = named_tuple_fetchall(cursor)
    
    print(result)
    template = loader.get_template('laboratorio/query5.html')
    context = {'query5_result_list': result,}
    
    return HttpResponse(template.render(context, request))
