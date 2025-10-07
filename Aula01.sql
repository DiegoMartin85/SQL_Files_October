CREATE DATABASE db0610_Cadastro;

USE db0610_Cadastro;

-- Criando uma tabela de pessoas!

CREATE TABLE tb_alunos(
	id_aluno INT IDENTITY(1,1) PRIMARY KEY, 
	nome VARCHAR(50) NOT NULL,
	idade VARCHAR(3),
	uf CHAR(2) NOT NULL
);

-- Inserir algns dados na tabela
INSERT INTO tb_alunos (nome, idade, uf)
VALUES ('Diego', 38, 'SP')

SELECT * FROM tb_alunos;

INSERT INTO tb_alunos (nome, idade, uf)
VALUES ('Antonio', 42, 'RS')

SELECT * FROM tb_alunos;

--Adicionando uma coluna de cidade
ALTER TABLE tb_alunos ADD cidade VARCHAR(30);

ALTER TABLE tb_alunos DROP COLUMN cidade

--selecionar apenas nome e idade
SELECT nome, idade FROM tb_alunos;

-- Mostra apenas pessoas de SP
SELECT * FROM tb_alunos WHERE uf = 'SP';

--mostra apenas pessoas com idade maior que 30]
SELECT * FROM tb_alunos WHERE idade >= 30;