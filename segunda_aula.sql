USE master; 
GO

DROP DATABASE IF EXISTS Escola;
GO

CREATE DATABASE Escola;
GO

USE Escola;
GO

--idempotencia para criar tabela escolar
DROP TABLE IF EXISTS Alunos;
CREATE TABLE Alunos(
	id INT IDENTITY(1,1) PRIMARY KEY,
	Nome NVARCHAR(100) NOT NULL,
	Idade INT,
	Email NVARCHAR(100),
	DataMatricula DATE NOT NULL
	);

INSERT INTO Alunos (Nome, Idade, Email, DataMatricula)
VALUES 
(N'Caio', 38, N'kio199@gmail.com', '2025-02-12'),
(N'Diego', 40, N'diego@gmail.com', '2022-02-02'),
(N'Rafaélla', 20, N'rafa@gmail.com', '2024-01-09'),
(N'Juliana', 21, N'juliana@gmail.com', '2020-09-03'),
(N'Marcela', 29, N'marcela@gmail.com', '2010-02-01');

SELECT * FROM Alunos;

-- mostrando alunos com idades menores que 26 anos
SELECT *FROM Alunos WHERE Idade <= 26;

--mostrar alunos mais novos primeiro
SELECT *FROM Alunos ORDER BY Idade ASC;
--ordenar por nome de aluno
SELECT *FROM Alunos ORDER BY Nome ASC;

----- Atualizando os dados (UPDATE) -----
UPDATE Alunos
SET Email = N'diegomartin@gmail.com'
WHERE id = 2;

SELECT id, Nome, Email FROM Alunos
WHERE id = 2;

UPDATE Alunos
SET Idade = Idade + 1;

---------Remoção de dados (DELETE) --------

DELETE FROM Alunos
WHERE id = 2;

DELETE FROM Alunos
WHERE Idade < 30;

----- Mostrar todos os alunos que começam com uma letra específica----
SELECT * FROM Alunos
WHERE Nome LIKE 'D%';

---Mostrar apenas os 3 alunos mais novos----
SELECT TOP 3 * FROM Alunos
ORDER BY Idade ASC;


----quero ver o aluno mais velho---
SELECT * FROM Alunos
SELECT TOP 1 * FROM Alunos
ORDER BY Idade DESC;

--- quero contar quantos alunos temos na tabela ----
SELECT COUNT(*) AS 'Total Alunos' FROM Alunos; 

----- calcular a media de idade dos alunos ----
SELECT AVG(Idade) AS 'Idade Média' FROM Alunos;