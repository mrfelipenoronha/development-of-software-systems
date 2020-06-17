-- Daniela Favero - 10277443
-- Felipe Noronha - 10737032

-- QUERY 4.1
SELECT ex.id_exame,
       ex.tipo,
       pc.cpf,
       pc.nome,
       rl.data_solicitacao,
       rl.data_realizacao
FROM realiza AS rl
JOIN paciente AS pc ON rl.id_paciente = pc.id_paciente
JOIN exame AS ex ON rl.id_exame = ex.id_exame; 

-- QUERY 4.2
SELECT e.id_exame, 
       e.tipo,
       e.virus,
       r.data_solicitacao,
       r.data_realizacao
FROM exame AS e
JOIN realiza AS r ON e.id_exame = r.id_exame
ORDER BY (r.data_realizacao - r.data_solicitacao) ASC
LIMIT 5;

-- QUERY 4.3
SELECT DISTINCT s.id_servico,
                s.nome
FROM servico AS s
JOIN pode_fazer AS pf ON pf.id_servico = s.id_servico
JOIN acessa AS ac ON ac.id_perfil = pf.id_perfil;

-- QUERY 4.4
SELECT DISTINCT s.id_servico,
                s.nome
FROM tutelamento AS tu 
JOIN servico AS s ON tu.id_servico = s.id_servico;

-- QUERY 4.5
SELECT sv.classe,
       ac.id_perfil,
       COUNT(ut.id_utilizacao) AS count
FROM servico AS sv
JOIN utilizou AS ut ON ut.id_servico = sv.id_servico
JOIN usuario AS us ON us.id_usuario = ut.id_usuario
JOIN acessa AS ac ON ac.id_usuario = us.id_usuario
GROUP BY sv.classe, ac.id_perfil
ORDER BY count ASC;