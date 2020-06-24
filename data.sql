-- cat ./data.sql | docker exec -i /labjef_db_1 psql -U postgres -d postgres

-- INTO USUARIO
INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (1, 'Daniela Favero', '45755046611', TO_DATE('18/05/2000', 'DD/MM/YYYY'), 'gabrielribeirorodrigues@fleckens.hu', '2181136578', 'Rua Dezesseis 637');
INSERT INTO site_labjef_usuario (id_usuario, instituicao, login, senha)
VALUES (1, 'IME', 'danigf', '654321');

INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (2, 'Felipe Noronha', '13071333048', TO_DATE('22/04/1999', 'DD/MM/YYYY'), 'felipe.castro.noronha@hotmail.com', '11994675341', 'Rua Sol 263');
INSERT INTO site_labjef_usuario (id_usuario, instituicao, login, senha)
VALUES (2, 'IME', 'felipen', '123456');

INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, email)
VALUES (3, 'Bruna Bazaluk', '85141739015', TO_DATE('12/09/1997', 'DD/MM/YYYY'), 'bruna@usp.br');
INSERT INTO site_labjef_usuario (id_usuario, instituicao, login, senha)
VALUES (3, 'IME', 'bzaluk', '11111111');

INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, telefone)
VALUES (4, 'Miguel Owstroviski', '31408134063', TO_DATE('24/08/1999', 'DD/MM/YYYY'), '1171283231');
INSERT INTO site_labjef_usuario (id_usuario, instituicao, login, senha)
VALUES (4, 'IME', 'migogo', 'birl123');

INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (5, 'Ronaldo Amaral', '18256987081', TO_DATE('25/01/1992', 'DD/MM/YYYY'), 'ronaldo@gmail.com', '6356453425', 'Rua Girassol 89');
INSERT INTO site_labjef_usuario (id_usuario, instituicao, login, senha)
VALUES (5, 'FAU', 'ronaldoa', 'asd114');

INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (6, 'Jennifer Sousa', '47683735000', TO_DATE('02/09/1998', 'DD/MM/YYYY'), 'jeje2010@gmail.com', '6465435223', 'Avenida Florencia 98');
INSERT INTO site_labjef_usuario (id_usuario, login, senha)
VALUES (6, 'jennifers', 'dafdg111');

INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (7, 'Gabriela Batista', '15133414056', TO_DATE('28/11/1986', 'DD/MM/YYYY'), 'batiga@gmail.com', '8345634522', 'Travessa T 988');
INSERT INTO site_labjef_usuario (id_usuario, instituicao, login, senha)
VALUES (7, 'UFPR', 'grabrielab', '32132ddd');

-- INTO PERFIL
INSERT INTO site_labjef_perfil (id_perfil, codigo, data_criacao, tipo)
VALUES (1, '0001', TO_DATE('28/10/2018', 'DD/MM/YYYY'), 'aluno');

INSERT INTO site_labjef_perfil (id_perfil, codigo, data_criacao, tipo)
VALUES (2, '0002', TO_DATE('28/10/2018', 'DD/MM/YYYY'), 'pesquisador');

INSERT INTO site_labjef_perfil (id_perfil, codigo, tipo)
VALUES (3, '0003', 'funcionario');

INSERT INTO site_labjef_perfil (id_perfil, codigo, data_criacao, tipo)
VALUES (4, '0004', TO_DATE('28/10/2018', 'DD/MM/YYYY'), 'administrador');

INSERT INTO site_labjef_perfil (id_perfil, codigo, data_criacao, tipo)
VALUES (5, '0005', TO_DATE('01/06/2020', 'DD/MM/YYYY'), 'eventual');

-- INTO ACESSA
INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (1, 2);

INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (1, 4);

INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (2, 1);

INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (3, 1);

INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (4, 1);

INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (5, 1);

INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (6, 3);

INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (6, 4);

INSERT INTO site_labjef_ACESSA (id_usuario, id_perfil)
VALUES (7, 5);

-- INTO SERVICO
INSERT INTO site_labjef_servico (id_servico, nome, classe, descricao)
VALUES (1, 'consulta exame COVID-19', 'visualização', 'recupera dados acerca de um exame de COVID-19');

INSERT INTO site_labjef_servico (id_servico, nome, classe, descricao)
VALUES (2, 'solicita exame COVID-19', 'inserção', 'solicita novo exame de COVID-19');

INSERT INTO site_labjef_servico (id_servico, nome, classe, descricao)
VALUES (3, 'solicita exame Sarampo', 'inserção', 'solicita novo exame de Sarampo');

INSERT INTO site_labjef_servico (id_servico, nome, classe, descricao)
VALUES (4, 'consulta exame Sarampo', 'visualização', 'consulta exame de Sarampo');

INSERT INTO site_labjef_servico (id_servico, nome, classe, descricao)
VALUES (5, 'remove exame', 'remoção', 'remove algum exame');

INSERT INTO site_labjef_servico (id_servico, nome, classe, descricao)
VALUES (6, 'altera exame', 'alteração', 'altera algum exame');

INSERT INTO site_labjef_servico (id_servico, nome, classe, descricao)
VALUES (7, 'insere exame', 'inserção', 'insere algum exame');


-- INTO PODE FAZER
INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (2, 1);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (2, 2);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (1, 1);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (1, 3);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (4, 5);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (4, 6);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (4, 7);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (1, 4);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (2, 3);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (5, 1);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (3, 3);

INSERT INTO site_labjef_pode_fazer (id_perfil, id_servico)
VALUES (3, 2);


-- INTO TUTELAMENTO
INSERT INTO site_labjef_tutelamento (id_tutor, id_tutorado, id_perfil, id_servico, data_inicio) 
VALUES (1, 5, 2, 2, TO_DATE('01/06/2020', 'DD/MM/YYYY'));
UPDATE usuario SET id_tutor = 1 WHERE id_usuario = 5;

INSERT INTO site_labjef_tutelamento (id_tutor, id_tutorado, id_perfil, id_servico, data_inicio) 
VALUES (1, 4, 2, 2, TO_DATE('12/05/2020', 'DD/MM/YYYY'));
UPDATE usuario SET id_tutor = 1 WHERE id_usuario = 4;

INSERT INTO site_labjef_tutelamento (id_tutor, id_tutorado, id_perfil, id_servico, data_inicio) 
VALUES (6, 3, 4, 7, TO_DATE('01/01/2020', 'DD/MM/YYYY'));
UPDATE usuario SET id_tutor = 6 WHERE id_usuario = 3;

-- INTO PACIENTE
INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, endereco)
VALUES (91, 'Carolina Marques', 46261250006, TO_DATE('24/08/2000', 'DD/MM/YYYY'), 'São paulo');
INSERT INTO site_labjef_paciente (id_paciente)
VALUES (91);

INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, endereco)
VALUES (92, 'Bento Pereira', 42151634043, 'Porto alegre');
INSERT INTO site_labjef_paciente (id_paciente)
VALUES (92);

INSERT INTO site_labjef_pessoa (id_pessoa, nome, cpf, data_nasc, endereco)
VALUES (93, 'Luciano Henrique Silva', 88093304045, TO_DATE('14/03/1988', 'DD/MM/YYYY'), 'Barueri');
INSERT INTO site_labjef_paciente (id_paciente)
VALUES (93);

-- INTO EXAME
INSERT INTO site_labjef_exame (id_exame, tipo, virus)
VALUES (1, 'pcr', 'covid-19');

INSERT INTO site_labjef_exame (id_exame, tipo, virus)
VALUES (2, 'anticorpos', 'covid-19');

INSERT INTO site_labjef_exame (id_exame, tipo, virus)
VALUES (3, 'anticorpos', 'sarampo');

-- INTO AMOSTRA
INSERT INTO site_labjef_amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (1, 92, 3, 'cotonete', 'saliva');

INSERT INTO site_labjef_amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (2, 93, 2, 'tubo', 'plasma');

INSERT INTO site_labjef_amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (3, 93, 1, 'tubo', 'plasma');

INSERT INTO site_labjef_amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (4, 91, 1, 'tubo', 'plasma');

INSERT INTO site_labjef_amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (5, 91, 2, 'tubo', 'plasma');

INSERT INTO site_labjef_amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (6, 93, 2, 'tubo', 'plasma');

-- INTO REALIZA 
INSERT INTO site_labjef_realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (92, 3, '2019-10-29 12:24:24-03', '2019-10-29 14:15:55-03', 1);

INSERT INTO site_labjef_realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (93, 1, '2020-03-29 14:54:14-03', '2020-03-29 15:14:13-03', 3);

INSERT INTO site_labjef_realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (93, 2, '2019-04-10 10:20:29-03', '2019-04-10 14:00:56-03', 2);

INSERT INTO site_labjef_realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (91, 1, '2019-05-25 17:49:41-03', '2019-05-25 23:09:16-03', 4);

INSERT INTO site_labjef_realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (91, 2, '2019-05-30 12:22:25-03', '2019-05-30 13:17:44-03', 5);

INSERT INTO site_labjef_realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (93, 2, '2019-06-01 15:42:55-03', '2019-06-01 16:29:31-03', 6);

-- INTO USA
INSERT INTO site_labjef_usa (id_servico, id_exame)
VALUES (1, 1);

INSERT INTO site_labjef_usa (id_servico, id_exame)
VALUES (1, 2);

INSERT INTO site_labjef_usa (id_servico, id_exame)
VALUES (3, 3);

INSERT INTO site_labjef_usa (id_servico, id_exame)
VALUES (2, 2);

INSERT INTO site_labjef_usa (id_servico, id_exame)
VALUES (2, 1);

INSERT INTO site_labjef_usa (id_servico, id_exame)
VALUES (4, 3);

-- INTO UTILIZOU
INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (1, 6, 3, 3, '2019-10-29 14:54:23-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (2, 1, 2, 1, '2020-03-29 15:14:13-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (3, 1, 2, 2, '2019-04-10 14:00:56-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (4, 1, 2, 1, '2019-05-25 23:09:16-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (5, 1, 2, 2, '2019-05-30 13:17:44-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (6, 1, 2, 2, '2019-05-30 16:29:31-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (7, 7, 1, 1, '2020-05-23 20:19:44-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (8, 7, 1, 1, '2020-05-24 20:12:53-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (9, 7, 1, 1, '2020-05-25 20:17:12-03');

INSERT INTO site_labjef_utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (10, 3, 4, 3, '2020-06-02 14:37:41-03');