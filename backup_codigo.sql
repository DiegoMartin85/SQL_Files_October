USE Escola;
GO

DECLARE @arquivo NVARCHAR(260) = N'C:\Users\integral\Desktop\Full_bkp_Escola.bak';

BACKUP DATABASE Escola
TO DISK = @arquivo
WITH	INIT,--sobreescrever o arquivo de bakcup anterior se ja existir
		COMPRESSION, --torna o arquivo menor
		STATS = 10; --progresso a cada 10%


DECLARE @arquivo_diff NVARCHAR(260) = N'C:\Users\integral\Desktop\diff_bkp_Escola.bak';

BACKUP DATABASE Escola
TO DISK = @arquivo_diff
WITH	DIFFERENTIAL,
		INIT,
		COMPRESSION, --torna o arquivo menor
		STATS = 10; --progresso a cada 10%