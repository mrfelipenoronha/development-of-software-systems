-- Daniela Favero - 10277443
-- Felipe Noronha - 10737032

---------------------------------------------------------------
-- ~THE CREATION
---------------------------------------------------------------

-- PESSOA
CREATE TABLE pessoa (
    id_pessoa           INT NOT NULL PRIMARY KEY,
    cpf                 VARCHAR(11) NOT NULL,
    nome                VARCHAR(255) NOT NULL,
    data_nasc           DATE,
    email               VARCHAR(255),
    telefone            VARCHAR(15),
    endereco            VARCHAR(255),
    UNIQUE (cpf)
);

-- USUARIO
CREATE TABLE usuario (
    id_usuario          INT NOT NULL PRIMARY KEY references pessoa(id_pessoa),
    instituicao         VARCHAR(255),
    login               VARCHAR(255) NOT NULL,
    senha               VARCHAR(255) NOT NULL,
    id_tutor            INT references usuario(id_usuario),
    UNIQUE (login)
);

-- PACIENTE
CREATE TABLE paciente (
    id_paciente         INT NOT NULL PRIMARY KEY references pessoa(id_pessoa)
);

-- PERFIL
CREATE TABLE perfil (
    id_perfil           INT NOT NULL PRIMARY KEY,
    codigo              VARCHAR(255) NOT NULL,
    data_criacao        DATE,
    tipo                VARCHAR(255) NOT NULL,
    UNIQUE (codigo)
);

-- ACESSA
CREATE TABLE acessa (
    id_usuario          INT NOT NULL references usuario(id_usuario),
    id_perfil           INT NOT NULL references perfil(id_perfil),
    UNIQUE (id_usuario, id_perfil)
);

-- SERVIÇO
CREATE TABLE servico (
    id_servico          INT NOT NULL PRIMARY KEY,
    nome                VARCHAR(255) NOT NULL,
    classe              VARCHAR(255) NOT NULL CHECK (classe IN ('visualização', 'inserção', 'alteração', 'remoção')),
    descricao           VARCHAR(255),
    UNIQUE (nome, classe)
);

-- PODE_FAZER
CREATE TABLE pode_fazer (
    id_perfil           INT NOT NULL references perfil(id_perfil),
    id_servico          INT NOT NULL references servico(id_servico),
    UNIQUE (id_perfil, id_servico)
);

-- TUTELAMENTO
CREATE TABLE tutelamento (
    id_tutor            INT NOT NULL references usuario(id_usuario),
    id_tutorado         INT NOT NULL references usuario(id_usuario),
    id_perfil           INT NOT NULL references perfil(id_perfil),
    id_servico          INT NOT NULL references servico(id_servico),
    data_inicio         DATE NOT NULL,
    data_fim            DATE,
    UNIQUE (id_tutor, id_tutorado, id_perfil, id_servico)
);

-- EXAME
CREATE TABLE exame (
    id_exame            INT NOT NULL PRIMARY KEY,
    tipo                VARCHAR(255) NOT NULL,
    virus               VARCHAR(255) NOT NULL,
    UNIQUE (tipo, virus)
);

-- REALIZA 
CREATE TABLE realiza (
    id_paciente         INT NOT NULL references paciente(id_paciente),
    id_exame            INT NOT NULL references exame(id_exame),
    data_realizacao     TIMESTAMP,
    data_solicitacao    TIMESTAMP,
    codigo_amostra      VARCHAR(255),
    UNIQUE (id_paciente, id_exame, data_realizacao)
);

-- AMOSTRA
CREATE TABLE amostra (
    codigo_amostra      VARCHAR(255) NOT NULL,    
    id_paciente         INT NOT NULL references paciente(id_paciente),
    id_exame            INT NOT NULL references exame(id_exame),
    metodo_coleta       VARCHAR(255) NOT NULL,
    tipo_material       VARCHAR(255) NOT NULL,
    UNIQUE (id_paciente, id_exame, codigo_amostra)
);

-- USA
CREATE TABLE usa (
    id_servico          INT NOT NULL references servico(id_servico),
    id_exame            INT NOT NULL references exame(id_exame),
    UNIQUE (id_servico, id_exame)
);

-- UTILIZOU
CREATE TABLE utilizou (
    id_utilizacao       INT NOT NULL PRIMARY KEY,
    id_usuario          INT NOT NULL references usuario(id_usuario),
    id_servico          INT NOT NULL references servico(id_servico),
    id_exame            INT NOT NULL references exame(id_exame),
    data_utilizacao     TIMESTAMP NOT NULL,
    UNIQUE (id_utilizacao, id_usuario, data_utilizacao)
);


---------------------------------------------------------------
-- ~THE POPULATION
---------------------------------------------------------------

-- INTO USUARIO
INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (1, 'Daniela Favero', '45755046611', TO_DATE('18/05/2000', 'DD/MM/YYYY'), 'gabrielribeirorodrigues@fleckens.hu', '2181136578', 'Rua Dezesseis 637');
INSERT INTO usuario (id_usuario, instituicao, login, senha)
VALUES (1, 'IME', 'danigf', '654321');

INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (2, 'Felipe Noronha', '13071333048', TO_DATE('22/04/1999', 'DD/MM/YYYY'), 'felipe.castro.noronha@hotmail.com', '11994675341', 'Rua Sol 263');
INSERT INTO usuario (id_usuario, instituicao, login, senha)
VALUES (2, 'IME', 'felipen', '123456');

INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, email)
VALUES (3, 'Bruna Bazaluk', '85141739015', TO_DATE('12/09/1997', 'DD/MM/YYYY'), 'bruna@usp.br');
INSERT INTO usuario (id_usuario, instituicao, login, senha)
VALUES (3, 'IME', 'bzaluk', '11111111');

INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, telefone)
VALUES (4, 'Miguel Owstroviski', '31408134063', TO_DATE('24/08/1999', 'DD/MM/YYYY'), '1171283231');
INSERT INTO usuario (id_usuario, instituicao, login, senha)
VALUES (4, 'IME', 'migogo', 'birl123');

INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (5, 'Ronaldo Amaral', '18256987081', TO_DATE('25/01/1992', 'DD/MM/YYYY'), 'ronaldo@gmail.com', '6356453425', 'Rua Girassol 89');
INSERT INTO usuario (id_usuario, instituicao, login, senha)
VALUES (5, 'FAU', 'ronaldoa', 'asd114');

INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (6, 'Jennifer Sousa', '47683735000', TO_DATE('02/09/1998', 'DD/MM/YYYY'), 'jeje2010@gmail.com', '6465435223', 'Avenida Florencia 98');
INSERT INTO usuario (id_usuario, login, senha)
VALUES (6, 'jennifers', 'dafdg111');

INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, email, telefone, endereco)
VALUES (7, 'Gabriela Batista', '15133414056', TO_DATE('28/11/1986', 'DD/MM/YYYY'), 'batiga@gmail.com', '8345634522', 'Travessa T 988');
INSERT INTO usuario (id_usuario, instituicao, login, senha)
VALUES (7, 'UFPR', 'grabrielab', '32132ddd');

-- INTO PERFIL
    INSERT INTO perfil (id_perfil, codigo, data_criacao, tipo)
    VALUES (1, '0001', TO_DATE('28/10/2018', 'DD/MM/YYYY'), 'aluno');

    INSERT INTO perfil (id_perfil, codigo, data_criacao, tipo)
    VALUES (2, '0002', TO_DATE('28/10/2018', 'DD/MM/YYYY'), 'pesquisador');

    INSERT INTO perfil (id_perfil, codigo, tipo)
    VALUES (3, '0003', 'funcionario');

    INSERT INTO perfil (id_perfil, codigo, data_criacao, tipo)
    VALUES (4, '0004', TO_DATE('28/10/2018', 'DD/MM/YYYY'), 'administrador');

    INSERT INTO perfil (id_perfil, codigo, data_criacao, tipo)
    VALUES (5, '0005', TO_DATE('01/06/2020', 'DD/MM/YYYY'), 'eventual');

-- INTO ACESSA
INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (1, 2);

INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (1, 4);

INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (2, 1);

INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (3, 1);

INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (4, 1);

INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (5, 1);

INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (6, 3);

INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (6, 4);

INSERT INTO ACESSA (id_usuario, id_perfil)
VALUES (7, 5);

-- INTO SERVICO
INSERT INTO servico (id_servico, nome, classe, descricao)
VALUES (1, 'consulta exame COVID-19', 'visualização', 'recupera dados acerca de um exame de COVID-19');

INSERT INTO servico (id_servico, nome, classe, descricao)
VALUES (2, 'solicita exame COVID-19', 'inserção', 'solicita novo exame de COVID-19');

INSERT INTO servico (id_servico, nome, classe, descricao)
VALUES (3, 'solicita exame Sarampo', 'inserção', 'solicita novo exame de Sarampo');

INSERT INTO servico (id_servico, nome, classe, descricao)
VALUES (4, 'consulta exame Sarampo', 'visualização', 'consulta exame de Sarampo');

INSERT INTO servico (id_servico, nome, classe, descricao)
VALUES (5, 'remove exame', 'remoção', 'remove algum exame');

INSERT INTO servico (id_servico, nome, classe, descricao)
VALUES (6, 'altera exame', 'alteração', 'altera algum exame');

INSERT INTO servico (id_servico, nome, classe, descricao)
VALUES (7, 'insere exame', 'inserção', 'insere algum exame');


-- INTO PODE FAZER
INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (2, 1);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (2, 2);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (1, 1);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (1, 3);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (4, 5);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (4, 6);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (4, 7);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (1, 4);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (2, 3);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (5, 1);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (3, 3);

INSERT INTO pode_fazer (id_perfil, id_servico)
VALUES (3, 2);


-- INTO TUTELAMENTO
INSERT INTO tutelamento (id_tutor, id_tutorado, id_perfil, id_servico, data_inicio) 
VALUES (1, 5, 2, 2, TO_DATE('01/06/2020', 'DD/MM/YYYY'));
UPDATE usuario SET id_tutor = 1 WHERE id_usuario = 5;

INSERT INTO tutelamento (id_tutor, id_tutorado, id_perfil, id_servico, data_inicio) 
VALUES (1, 4, 2, 2, TO_DATE('12/05/2020', 'DD/MM/YYYY'));
UPDATE usuario SET id_tutor = 1 WHERE id_usuario = 4;

INSERT INTO tutelamento (id_tutor, id_tutorado, id_perfil, id_servico, data_inicio) 
VALUES (6, 3, 4, 7, TO_DATE('01/01/2020', 'DD/MM/YYYY'));
UPDATE usuario SET id_tutor = 6 WHERE id_usuario = 3;

-- INTO PACIENTE
INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, endereco)
VALUES (91, 'Carolina Marques', 46261250006, TO_DATE('24/08/2000', 'DD/MM/YYYY'), 'São paulo');
INSERT INTO paciente (id_paciente)
VALUES (91);

INSERT INTO pessoa (id_pessoa, nome, cpf, endereco)
VALUES (92, 'Bento Pereira', 42151634043, 'Porto alegre');
INSERT INTO paciente (id_paciente)
VALUES (92);

INSERT INTO pessoa (id_pessoa, nome, cpf, data_nasc, endereco)
VALUES (93, 'Luciano Henrique Silva', 88093304045, TO_DATE('14/03/1988', 'DD/MM/YYYY'), 'Barueri');
INSERT INTO paciente (id_paciente)
VALUES (93);

-- INTO EXAME
INSERT INTO exame (id_exame, tipo, virus)
VALUES (1, 'pcr', 'covid-19');

INSERT INTO exame (id_exame, tipo, virus)
VALUES (2, 'anticorpos', 'covid-19');

INSERT INTO exame (id_exame, tipo, virus)
VALUES (3, 'anticorpos', 'sarampo');

-- INTO AMOSTRA
INSERT INTO amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (1, 92, 3, 'cotonete', 'saliva');

INSERT INTO amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (2, 93, 2, 'tubo', 'plasma');

INSERT INTO amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (3, 93, 1, 'tubo', 'plasma');

INSERT INTO amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (4, 91, 1, 'tubo', 'plasma');

INSERT INTO amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (5, 91, 2, 'tubo', 'plasma');

INSERT INTO amostra (codigo_amostra, id_paciente, id_exame, metodo_coleta, tipo_material)
VALUES (6, 93, 2, 'tubo', 'plasma');

-- INTO REALIZA 
INSERT INTO realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (92, 3, '2019-10-29 12:24:24-03', '2019-10-29 14:15:55-03', 1);

INSERT INTO realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (93, 1, '2020-03-29 14:54:14-03', '2020-03-29 15:14:13-03', 3);

INSERT INTO realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (93, 2, '2019-04-10 10:20:29-03', '2019-04-10 14:00:56-03', 2);

INSERT INTO realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (91, 1, '2019-05-25 17:49:41-03', '2019-05-25 23:09:16-03', 4);

INSERT INTO realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (91, 2, '2019-05-30 12:22:25-03', '2019-05-30 13:17:44-03', 5);

INSERT INTO realiza (id_paciente, id_exame, data_solicitacao, data_realizacao, codigo_amostra)
VALUES (93, 2, '2019-06-01 15:42:55-03', '2019-06-01 16:29:31-03', 6);

-- INTO USA
INSERT INTO usa (id_servico, id_exame)
VALUES (1, 1);

INSERT INTO usa (id_servico, id_exame)
VALUES (1, 2);

INSERT INTO usa (id_servico, id_exame)
VALUES (3, 3);

INSERT INTO usa (id_servico, id_exame)
VALUES (2, 2);

INSERT INTO usa (id_servico, id_exame)
VALUES (2, 1);

INSERT INTO usa (id_servico, id_exame)
VALUES (4, 3);

-- INTO UTILIZOU
INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (1, 6, 3, 3, '2019-10-29 14:54:23-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (2, 1, 2, 1, '2020-03-29 15:14:13-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (3, 1, 2, 2, '2019-04-10 14:00:56-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (4, 1, 2, 1, '2019-05-25 23:09:16-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (5, 1, 2, 2, '2019-05-30 13:17:44-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (6, 1, 2, 2, '2019-05-30 16:29:31-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (7, 7, 1, 1, '2020-05-23 20:19:44-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (8, 7, 1, 1, '2020-05-24 20:12:53-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (9, 7, 1, 1, '2020-05-25 20:17:12-03');

INSERT INTO utilizou (id_utilizacao, id_usuario, id_servico, id_exame, data_utilizacao)
VALUES (10, 3, 4, 3, '2020-06-02 14:37:41-03');

---------------------------------------------------------------
-- ~THE QUESTIONING
---------------------------------------------------------------

-- QUERY 4.1
SELECT ex.id_exame,
       ex.tipo,
       ps.cpf,
       ps.nome,
       rl.data_solicitacao,
       rl.data_realizacao
FROM realiza AS rl
JOIN paciente AS pc ON rl.id_paciente = pc.id_paciente
JOIN pessoa AS ps on ps.id_pessoa = pc.id_paciente
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

-- drop table pessoa, perfil, usuario, pode_fazer, servico, tutelamento, acessa, paciente, realiza, exame, utilizou, amostra, usa cascade;