USE Escola;
GO

--Inner Join:
--Mostrar apenas alunos matriculados

SELECT a.Nome, a.Email, NomeCurso, m.DataInscricao
FROM Alunos a

INNER JOIN Matriculas m ON a.id = m.AlunoId
INNER JOIN Cursos c ON c.id = m.CursoId

ORDER BY a.Nome

INSERT INTO Alunos (Nome, Idade, Email, DataMatricula)
VALUES
	(N'Thamires', 32, 'thamires@gmail.com', '2025-02-12'),
	(N'Antonio', 28, 'antonio@gmail.com', '2025-01-03');

--Left Join
--mostrar todos os alunos mesmo sem matricula

SELECT a.Nome, c.NomeCurso, m.DataInscricao
FROM Alunos a

LEFT JOIN Matriculas m ON a.id = m.AlunoId
LEFT JOIN Cursos c ON c.id= m.CursoId

ORDER BY m.DataInscricao

--Tabela de professores

DROP TABLE IF EXISTS Professores;
CREATE TABLE Professores (
	id INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100)
	);

INSERT INTO Professores(Nome, Email)
VALUES
	('Katia','katia@gmail.com'),
	('Ricardo','ricardo@gmail.com'),
	('Sibeli','Sibeli@gmail.com');

SELECT * FROM Professores

--Tabela de Notas

DROP TABLE IF EXISTS Notas;
CREATE TABLE Notas (
	id INT PRIMARY KEY IDENTITY(1,1),
	AlunoId INT NOT NULL,
	CursoId INT NOT NULL,
	Nota INT NOT NULL,
	DataAvaliacao DATE NOT NULL,

FOREIGN KEY (AlunoId) REFERENCES Alunos(id),
FOREIGN KEY (CursoId) REFERENCES Cursos(id)
);

INSERT INTO Notas (AlunoId, CursoId, Nota, DataAvaliacao)
VALUES
	(1,1,8,'2024-02-01'),
	(5,2,6,'2024-02-07'),
	(6,3,5,'2024-03-07'),
	(7,4,9,'2024-04-07'),
	(11,5,9,'2024-05-07'),
	(15,1,4,'2024-06-09'),
	(16,2,8,'2024-02-07'),
	(17,3,7,'2024-02-07');

SELECT * FROM Notas;

---Tabela de Pagamentos
DROP TABLE IF EXISTS Pagamentos
CREATE TABLE Pagamentos(
	id INT PRIMARY KEY IDENTITY(1,1),
	AlunoId INT NOT NULL,
	Valor INT NOT NULL,
	DataPagamento DATE NOT NULL,
	Situacao NVARCHAR(10) NOT NULL

FOREIGN KEY (AlunoId) REFERENCES Alunos(id),
	);

INSERT INTO Pagamentos (AlunoId, Valor, DataPagamento, Situacao)
VALUES
	(1,300,'2024-01-01','Pendente'),
	(5,500,'2024-02-01','Atrasado'),
	(6,200,'2024-07-01','Pago'),
	(7,700,'2024-06-01','Atrasado'),
	(11,250,'2024-10-01','Atrasado'),
	(15,355,'2024-05-01','Pago'),
	(16,455,'2024-10-01','Atrasado'),
	(17,300,'2024-05-01','Pago');

SELECT * FROM Pagamentos

--- Mostrar notas dos alunos em cada curso
SELECT
	a.Nome AS Aluno,
	c.NomeCurso AS Curso,
	n.Nota,
	n.DataAvaliacao AS Data
FROM Notas n

INNER JOIN Alunos a ON a.id = n.AlunoId
INNER JOIN Cursos c ON c.id = n.CursoId

ORDER BY n.DataAvaliacao DESC

--media de notas por curso
SELECT c.NomeCurso, AVG(n.Nota) AS 'Media de Notas'
FROM Notas n 
INNER JOIN Cursos c ON c.id = n.CursoId
GROUP BY c.NomeCurso
ORDER BY 'Media de Notas' DESC;

--visualizar a situação de pagamento por aluno
SELECT a.Nome, p.Valor, p.DataPagamento, p.Situacao
FROM Pagamentos p
INNER JOIN Alunos a ON a.id = p. AlunoId
ORDER BY p.DataPagamento DESC;

--quantidade de alunos por sitacao de pagamento
SELECT p.Situacao, COUNT(*) AS Quantidade
FROM Pagamentos p
GROUP BY p.Situacao
ORDER BY Quantidade DESC;

