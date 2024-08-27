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


--Atualizando o salário de um funcionario
DECLARE @nome_funcionario VARCHAR(100),
		@salario DECIMAL(10,2),
		@aumento DECIMAL (10,2),
		@novo_salario DECIMAL (10,2);

--usando o select como um set
SELECT @nome_funcionario = F.Pnome, 
       @salario = F.Salario
FROM FUNCIONARIO as F
WHERE F.Pnome = 'Jennifer';

--modificando os valores
SET @aumento = 0.10;
SET @novo_salario = @salario + (@salario * @aumento);

--exibindo o novo salario do funcionario
SELECT @nome_funcionario, @novo_salario;

--criando uma tabela provisória
DECLARE @ALUNO TABLE (
	Id INT IDENTITY PRIMARY KEY,
	Nome VARCHAR(50),
	Data_nasc DATE,
	Curso CHAR (2)
);

--inserindo os valores e mostrando
INSERT INTO @ALUNO 
VALUES ('Juca da silva', '1999-10-10', 'SI');
SELECT * FROM @ALUNO;

