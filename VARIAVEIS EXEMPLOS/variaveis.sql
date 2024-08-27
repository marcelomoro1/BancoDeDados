--Baseado no banco de dados empresa

--Criando variáveis e exibindo com SELECT e PRINT
DECLARE @idade int,
		@nome varchar(40),
		@data_nasc DATE,
		@dinheiro MONEY;

SET @nome = 'Marcelo Picoli Moro';
SET @data_nasc = '2000-06-12';
SET @idade = 24;
SET @dinheiro = 0;

SELECT @nome as 'Nome Completo', 
	   @idade as 'Idade', 
	   @data_nasc as 'Data de Nascimento', 
	   @dinheiro as 'Dinheiro';

PRINT 'O meu nome é: ' + @nome 
					   +' e eu nasci em: ' + CAST(@data_nasc as VARCHAR(15)) 
					   + ' Minha idade eh: '+ CAST(YEAR(GETDATE())-YEAR(@data_nasc) as VARCHAR(4));
