BEGIN;
--
-- Create model Exame
--
CREATE TABLE "site_labjef_exame" ("id_exame" integer NOT NULL PRIMARY KEY, "tipo" varchar(255) NOT NULL, "virus" varchar(255) NOT NULL);
--
-- Create model Perfil
--
CREATE TABLE "site_labjef_perfil" ("id_perfil" integer NOT NULL PRIMARY KEY, "codigo" varchar(255) NOT NULL UNIQUE, "data_criacao" date NULL, "tipo" varchar(255) NOT NULL);
--
-- Create model Pessoa
--
CREATE TABLE "site_labjef_pessoa" ("id_pessoa" integer NOT NULL PRIMARY KEY, "cpf" varchar(11) NOT NULL UNIQUE, "nome" varchar(255) NOT NULL, "data_nasc" date NULL, "email" varchar(255) NULL, "telefone" varchar(15) NULL, "endereco" varchar(255) NULL);
--
-- Create model Servico
--
CREATE TABLE "site_labjef_servico" ("id_servico" integer NOT NULL PRIMARY KEY, "nome" varchar(255) NOT NULL, "classe" varchar(1) NOT NULL, "descricao" varchar(255) NULL);
--
-- Create model Paciente
--
CREATE TABLE "site_labjef_paciente" ("id_paciente" integer NOT NULL PRIMARY KEY);
--
-- Create model Usa
--
CREATE TABLE "site_labjef_usa" ("id" serial NOT NULL PRIMARY KEY, "id_exame" integer NOT NULL, "id_servico" integer NOT NULL);
--
-- Add field exames to servico
--
--
-- Create model Pode_fazer
--
CREATE TABLE "site_labjef_pode_fazer" ("id" serial NOT NULL PRIMARY KEY, "id_perfil" integer NOT NULL, "id_servico" integer NOT NULL);
--
-- Add field servicos to perfil
--
--
-- Create model Acessa
--
CREATE TABLE "site_labjef_acessa" ("id" serial NOT NULL PRIMARY KEY, "id_perfil" integer NOT NULL);
--
-- Create model Usuario
--
CREATE TABLE "site_labjef_usuario" ("id_usuario" integer NOT NULL PRIMARY KEY, "instituicao" varchar(255) NULL, "login" varchar(255) NOT NULL UNIQUE, "senha" varchar(255) NOT NULL, "id_tutor" integer NULL);
--
-- Alter unique_together for servico (1 constraint(s))
--
ALTER TABLE "site_labjef_servico" ADD CONSTRAINT "site_labjef_servico_nome_classe_1471939b_uniq" UNIQUE ("nome", "classe");
--
-- Add field id_usuario to acessa
--
ALTER TABLE "site_labjef_acessa" ADD COLUMN "id_usuario" integer NOT NULL CONSTRAINT "site_labjef_acessa_id_usuario_4fb9e9b6_fk_site_labj" REFERENCES "site_labjef_usuario"("id_usuario") DEFERRABLE INITIALLY DEFERRED; SET CONSTRAINTS "site_labjef_acessa_id_usuario_4fb9e9b6_fk_site_labj" IMMEDIATE;
--
-- Create model Utilizou
--
CREATE TABLE "site_labjef_utilizou" ("id_utilizacao" integer NOT NULL PRIMARY KEY, "data_utilizacao" timestamp with time zone NOT NULL, "id_exame" integer NOT NULL, "id_servico" integer NOT NULL, "id_usuario" integer NOT NULL);
--
-- Create model Tutelamento
--
CREATE TABLE "site_labjef_tutelamento" ("id" serial NOT NULL PRIMARY KEY, "data_inicio" date NOT NULL, "data_fim" date NULL, "id_perfil" integer NOT NULL, "id_servico" integer NOT NULL, "id_tutor" integer NOT NULL, "id_tutorado" integer NOT NULL);
--
-- Create model Realiza
--
CREATE TABLE "site_labjef_realiza" ("id" serial NOT NULL PRIMARY KEY, "data_realizacao" timestamp with time zone NULL, "data_solicitacao" timestamp with time zone NULL, "codigo_amostra" varchar(255) NULL, "id_exame" integer NOT NULL, "id_paciente" integer NOT NULL);
--
-- Create model Amostra
--
CREATE TABLE "site_labjef_amostra" ("id" serial NOT NULL PRIMARY KEY, "codigo_amostra" varchar(255) NOT NULL, "metodo_coleta" varchar(255) NOT NULL, "tipo_material" varchar(255) NOT NULL, "id_exame" integer NOT NULL, "id_paciente" integer NOT NULL);
--
-- Alter unique_together for acessa (1 constraint(s))
--
ALTER TABLE "site_labjef_acessa" ADD CONSTRAINT "site_labjef_acessa_id_usuario_id_perfil_b5423c7e_uniq" UNIQUE ("id_usuario", "id_perfil");
ALTER TABLE "site_labjef_exame" ADD CONSTRAINT "site_labjef_exame_tipo_virus_f773047b_uniq" UNIQUE ("tipo", "virus");
CREATE INDEX "site_labjef_perfil_codigo_1ea9df33_like" ON "site_labjef_perfil" ("codigo" varchar_pattern_ops);
CREATE INDEX "site_labjef_pessoa_cpf_3387b26c_like" ON "site_labjef_pessoa" ("cpf" varchar_pattern_ops);
ALTER TABLE "site_labjef_paciente" ADD CONSTRAINT "site_labjef_paciente_id_paciente_9e6de7a8_fk_site_labj" FOREIGN KEY ("id_paciente") REFERENCES "site_labjef_pessoa" ("id_pessoa") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_usa" ADD CONSTRAINT "site_labjef_usa_id_servico_id_exame_39741b96_uniq" UNIQUE ("id_servico", "id_exame");
ALTER TABLE "site_labjef_usa" ADD CONSTRAINT "site_labjef_usa_id_exame_a8b65456_fk_site_labjef_exame_id_exame" FOREIGN KEY ("id_exame") REFERENCES "site_labjef_exame" ("id_exame") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_usa" ADD CONSTRAINT "site_labjef_usa_id_servico_14d4e014_fk_site_labj" FOREIGN KEY ("id_servico") REFERENCES "site_labjef_servico" ("id_servico") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "site_labjef_usa_id_exame_a8b65456" ON "site_labjef_usa" ("id_exame");
CREATE INDEX "site_labjef_usa_id_servico_14d4e014" ON "site_labjef_usa" ("id_servico");
ALTER TABLE "site_labjef_pode_fazer" ADD CONSTRAINT "site_labjef_pode_fazer_id_perfil_id_servico_86b32a41_uniq" UNIQUE ("id_perfil", "id_servico");
ALTER TABLE "site_labjef_pode_fazer" ADD CONSTRAINT "site_labjef_pode_faz_id_perfil_29b0fd67_fk_site_labj" FOREIGN KEY ("id_perfil") REFERENCES "site_labjef_perfil" ("id_perfil") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_pode_fazer" ADD CONSTRAINT "site_labjef_pode_faz_id_servico_18152fa9_fk_site_labj" FOREIGN KEY ("id_servico") REFERENCES "site_labjef_servico" ("id_servico") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "site_labjef_pode_fazer_id_perfil_29b0fd67" ON "site_labjef_pode_fazer" ("id_perfil");
CREATE INDEX "site_labjef_pode_fazer_id_servico_18152fa9" ON "site_labjef_pode_fazer" ("id_servico");
ALTER TABLE "site_labjef_acessa" ADD CONSTRAINT "site_labjef_acessa_id_perfil_851db264_fk_site_labj" FOREIGN KEY ("id_perfil") REFERENCES "site_labjef_perfil" ("id_perfil") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "site_labjef_acessa_id_perfil_851db264" ON "site_labjef_acessa" ("id_perfil");
ALTER TABLE "site_labjef_usuario" ADD CONSTRAINT "site_labjef_usuario_id_usuario_5f53ab3a_fk_site_labj" FOREIGN KEY ("id_usuario") REFERENCES "site_labjef_pessoa" ("id_pessoa") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_usuario" ADD CONSTRAINT "site_labjef_usuario_id_tutor_dfa1a8b2_fk_site_labj" FOREIGN KEY ("id_tutor") REFERENCES "site_labjef_usuario" ("id_usuario") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "site_labjef_usuario_login_4b1f84d5_like" ON "site_labjef_usuario" ("login" varchar_pattern_ops);
CREATE INDEX "site_labjef_usuario_id_tutor_dfa1a8b2" ON "site_labjef_usuario" ("id_tutor");
CREATE INDEX "site_labjef_acessa_id_usuario_4fb9e9b6" ON "site_labjef_acessa" ("id_usuario");
ALTER TABLE "site_labjef_utilizou" ADD CONSTRAINT "site_labjef_utilizou_id_utilizacao_id_usuario_d6b74bf4_uniq" UNIQUE ("id_utilizacao", "id_usuario", "data_utilizacao");
ALTER TABLE "site_labjef_utilizou" ADD CONSTRAINT "site_labjef_utilizou_id_exame_b0487f0b_fk_site_labj" FOREIGN KEY ("id_exame") REFERENCES "site_labjef_exame" ("id_exame") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_utilizou" ADD CONSTRAINT "site_labjef_utilizou_id_servico_cdad2dda_fk_site_labj" FOREIGN KEY ("id_servico") REFERENCES "site_labjef_servico" ("id_servico") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_utilizou" ADD CONSTRAINT "site_labjef_utilizou_id_usuario_6def72cd_fk_site_labj" FOREIGN KEY ("id_usuario") REFERENCES "site_labjef_usuario" ("id_usuario") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "site_labjef_utilizou_id_exame_b0487f0b" ON "site_labjef_utilizou" ("id_exame");
CREATE INDEX "site_labjef_utilizou_id_servico_cdad2dda" ON "site_labjef_utilizou" ("id_servico");
CREATE INDEX "site_labjef_utilizou_id_usuario_6def72cd" ON "site_labjef_utilizou" ("id_usuario");
ALTER TABLE "site_labjef_tutelamento" ADD CONSTRAINT "site_labjef_tutelamento_id_tutor_id_tutorado_id__6c7dca89_uniq" UNIQUE ("id_tutor", "id_tutorado", "id_perfil", "id_servico");
ALTER TABLE "site_labjef_tutelamento" ADD CONSTRAINT "site_labjef_tutelame_id_perfil_0332ead5_fk_site_labj" FOREIGN KEY ("id_perfil") REFERENCES "site_labjef_perfil" ("id_perfil") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_tutelamento" ADD CONSTRAINT "site_labjef_tutelame_id_servico_fd2620c9_fk_site_labj" FOREIGN KEY ("id_servico") REFERENCES "site_labjef_servico" ("id_servico") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_tutelamento" ADD CONSTRAINT "site_labjef_tutelame_id_tutor_41bc36bc_fk_site_labj" FOREIGN KEY ("id_tutor") REFERENCES "site_labjef_usuario" ("id_usuario") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_tutelamento" ADD CONSTRAINT "site_labjef_tutelame_id_tutorado_ae572c38_fk_site_labj" FOREIGN KEY ("id_tutorado") REFERENCES "site_labjef_usuario" ("id_usuario") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "site_labjef_tutelamento_id_perfil_0332ead5" ON "site_labjef_tutelamento" ("id_perfil");
CREATE INDEX "site_labjef_tutelamento_id_servico_fd2620c9" ON "site_labjef_tutelamento" ("id_servico");
CREATE INDEX "site_labjef_tutelamento_id_tutor_41bc36bc" ON "site_labjef_tutelamento" ("id_tutor");
CREATE INDEX "site_labjef_tutelamento_id_tutorado_ae572c38" ON "site_labjef_tutelamento" ("id_tutorado");
ALTER TABLE "site_labjef_realiza" ADD CONSTRAINT "site_labjef_realiza_id_paciente_id_exame_dat_81e9db05_uniq" UNIQUE ("id_paciente", "id_exame", "data_realizacao");
ALTER TABLE "site_labjef_realiza" ADD CONSTRAINT "site_labjef_realiza_id_exame_0c989872_fk_site_labj" FOREIGN KEY ("id_exame") REFERENCES "site_labjef_exame" ("id_exame") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_realiza" ADD CONSTRAINT "site_labjef_realiza_id_paciente_93f9db03_fk_site_labj" FOREIGN KEY ("id_paciente") REFERENCES "site_labjef_paciente" ("id_paciente") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "site_labjef_realiza_id_exame_0c989872" ON "site_labjef_realiza" ("id_exame");
CREATE INDEX "site_labjef_realiza_id_paciente_93f9db03" ON "site_labjef_realiza" ("id_paciente");
ALTER TABLE "site_labjef_amostra" ADD CONSTRAINT "site_labjef_amostra_id_paciente_id_exame_cod_8d37c679_uniq" UNIQUE ("id_paciente", "id_exame", "codigo_amostra");
ALTER TABLE "site_labjef_amostra" ADD CONSTRAINT "site_labjef_amostra_id_exame_db0c1742_fk_site_labj" FOREIGN KEY ("id_exame") REFERENCES "site_labjef_exame" ("id_exame") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "site_labjef_amostra" ADD CONSTRAINT "site_labjef_amostra_id_paciente_8d47df31_fk_site_labj" FOREIGN KEY ("id_paciente") REFERENCES "site_labjef_paciente" ("id_paciente") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "site_labjef_amostra_id_exame_db0c1742" ON "site_labjef_amostra" ("id_exame");
CREATE INDEX "site_labjef_amostra_id_paciente_8d47df31" ON "site_labjef_amostra" ("id_paciente");
COMMIT;
