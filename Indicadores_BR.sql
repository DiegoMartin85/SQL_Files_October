/**/================
01o Banco de dados novo
=====================*/

USE master
GO

DROP DATABASE IF EXISTS IndicadoresBR;
GO

CREATE DATABASE IndicadoresBR;
GO

USE IndicadoresBR;
GO

/**/================
02) Tabelas Raw (texto)
Motivo: evita dor de cabe�a com virgula vs ponto
=====================*/

DROP TABLE IF EXISTS Inadimplencia_raw;
CREATE TABLE Inadimplencia_raw (
	data_str VARCHAR(20), --"DD/MM/AAAA"
	valor_str VARCHAR(50)  -- Numero como texto
);

DROP TABLE IF EXISTS Selic_raw;
CREATE TABLE Selic_raw (
	data_str VARCHAR(20),
	valor_str VARCHAR(50)
);

/*================
03) Importar CSVs (Bulk Insert)
=====================*/

BULK INSERT Inadimplencia_raw
FROM 'C:\Users\integral\Desktop\inadimplencia.csv'
WITH (
	FIRSTROW = 2, --Cabe�alho na primeira linha.
	FIELDTERMINATOR = ';', --Separador
	ROWTERMINATOR = '0X0d0a', --este � o c�digo do enter \r\n (terminador do Windows)
	CODEPAGE = '65001', -- utf-8(Permite caracteres especiais)
	TABLOCK --Impede a concorrencia dessa tabela enquanto importamos ela
);

BULK INSERT Selic_raw
FROM 'C:\Users\integral\Desktop\taxa_selic.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ';',
	ROWTERMINATOR = '0X0d0a',
	CODEPAGE = '65001',
	TABLOCK
);

--Conferida rapida se os dados foram importados
SELECT TOP (5) *FROM Inadimplencia_raw;
SELECT TOP (5) *FROM Selic_raw

/*================
04)Tabelas Finais (tipadas)
=====================*/

DROP TABLE IF EXISTS Inadimplencia;
SELECT
	TRY_CONVERT(date, data_str, 103) AS Data,
	TRY_CONVERT(DECIMAL(18,4), REPLACE(valor_str, ',','.')) AS Valor
INTO Inadimplencia
FROM Inadimplencia_raw;

DROP TABLE IF EXISTS Selic;
SELECT
	TRY_CONVERT(date, data_str, 103) AS Data,
	TRY_CONVERT(DECIMAL(18,4), REPLACE(valor_str, ',','.')) AS Valor
INTO Selic
FROM Selic_raw;

/*================
05) Selic Mensal 
- M�dia do m�s 
- Ultimo valor do m�s
=====================*/

--ultima Selic mes
DROP TABLE IF EXISTS Selic_mensal_ultimo;
;WITH s AS (
	SELECT
		data,
		EOMONTH(data) AS mes,
		valor,
		ROW_NUMBER() OVER (
		PARTITION BY EOMONTH(data) ORDER BY data DESC
		) AS rn
		FROM Selic
)
SELECT
	mes AS data,
	valor
INTO Selic_mensal_ultimo
FROM s
WHERE rn = 1;

--Visualizar os dados de amostra da Selic_mensal_ultimo
SELECT TOP (10) * FROM Selic_mensal_ultimo ORDER BY data

--Selic M�dia do mes

DROP TABLE IF EXISTS Selic_mensal_media;
SELECT
	EOMONTH(data) AS data,
	AVG(valor) AS valor
INTO Selic_mensal_media
FROM Selic
GROUP BY EOMONTH(data);

--Visualizar os dad da amostra da Selic_mensal_media
SELECT TOP(10) * FROM Selic_mensal_media ORDER BY data; 

/*================================================
06) Ultimos 12 meses de Inadimplencia
==================================================*/

SELECT TOP (12)*
FROM Inadimplencia
ORDER BY data DESC;	

/*================================================
07) Varia��o MoM (Mes sobre Mes) da inadimplencia
==================================================*/

;WITH b AS(
	SELECT
		data,
		valor,
		LAG(valor) OVER (order by DATA) AS prev_valor
	FROM Inadimplencia
)
SELECT
	data,
	valor,
	CASE
		WHEN prev_valor IS NULL OR prev_valor = 0 THEN NULL
		ELSE (valor - prev_valor)/prev_valor
	END AS variacao_mm
FROM b
ORDER BY data 

/*===========================================================================
08) Inadimplencia vs Selic (M�dia) nos ultimos 24 Meses - atividade dificil
============================================================================*/
SET LANGUAGE English
SELECT TOP 24
	i.data,
	DATENAME(MONTH, i.data) AS 'Mes por extenso',
	i.valor AS Inadimplencia,
	s.valor AS selic
FROM Inadimplencia i 
LEFT JOIN Selic_mensal_media s ON s.data = EOMONTH(I.data)
ORDER BY i.data DESC