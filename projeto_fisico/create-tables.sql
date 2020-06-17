-- Daniela Favero - 10277443
-- Felipe Noronha - 10737032

-- USUARIO
CREATE TABLE usuario (
    id_usuario          INT NOT NULL PRIMARY KEY,
    nome                VARCHAR(255) NOT NULL,
    cpf                 VARCHAR(11) NOT NULL,
    data_nasc           DATE,
    email               VARCHAR(255),
    telefone            VARCHAR(15),
    endereco            VARCHAR(255),
    instituicao         VARCHAR(255),
    login               VARCHAR(255) NOT NULL,
    senha               VARCHAR(255) NOT NULL,
    id_tutor            INT references usuario(id_usuario),
    UNIQUE (cpf)
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

-- PACIENTE
CREATE TABLE paciente (
    id_paciente         INT NOT NULL PRIMARY KEY,
    nome                VARCHAR(255) NOT NULL,
    cpf                 VARCHAR(15) NOT NULL,
    data_nasc           DATE,
    idade               INT,
    email               VARCHAR(255),
    telefone            VARCHAR(15),
    endereco            VARCHAR(255) NOT NULL,
    UNIQUE (cpf)
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
