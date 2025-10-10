BACKUP DATABASE [Escola]
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\meu_backup'
WITH NOFORMAT,
NOINIT,
NAME = N'Escola-Completo Banco de Dados Backup',
SKIP,
NOREWIND,
NOUNLOAD,
STATS = 10
GO
