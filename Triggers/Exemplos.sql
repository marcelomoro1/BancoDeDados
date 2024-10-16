CREATE TRIGGER trg_after_insert_funcionario
ON FUNCIONARIO
AFTER INSERT 
AS
BEGIN
	DECLARE @Cpf CHAR(11),
			@Pnome VARCHAR(15),
			@Unome VARCHAR (15),
			@Salario DECIMAL (10,2);

	SELECT @Cpf = I.Cpf, @Pnome = I.Pnome, @Unome = I.Unome, @Salario = I.Salario
	FROM inserted as I

	PRINT 'Funcionarios INSERIDOS: ';
	PRINT 'CPF: ' + @Cpf;
	PRINT 'Nome: '+ @Pnome;
	PRINT 'Unome: '+ @Unome;
	PRINT 'Salario: '+ CAST(@Salario AS VARCHAR(20));
END

INSERT INTO FUNCIONARIO (Cpf, Pnome, Unome) VALUES ( '12345676543', 'Mffdf', 'dfhfh');

-----------------------------------------------------------------------------------------

CREATE TRIGGER teste_trigger_instead_of
ON FUNCIONARIO
INSTEAD OF INSERT
AS
PRINT 'Olá de novo, não inseri os registros dessa vez!';

INSERT INTO FUNCIONARIO (Cpf, Pnome, Unome) VALUES ( '12345676543', 'Mffdf', 'dfhfh');

----------------------------------------------------------------------------------------

CREATE TRIGGER trg_pessoas_duplicadas
ON FUNCIONARIO
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @Pnome VARCHAR(15),
			@Unome VARCHAR(15),
			@CPF CHAR(11);

	--setando os valores das variáveis
	SELECT @Pnome = I.Pnome, @Unome = I.Unome, @CPF = I.Cpf
	FROM inserted as I;

	--verificando se existe alguem com o mesmo Pnome e Unome
	IF EXISTS(SELECT * FROM FUNCIONARIO AS F WHERE @Pnome = F.Pnome AND @Unome = F.Unome)
		PRINT 'Está inserindo uma pessoa duplicada!';
	ELSE
		BEGIN
		INSERT INTO FUNCIONARIO (Cpf, Pnome, Unome) VALUES (@CPF, @Pnome, @Unome);
		PRINT 'PESSOA INSERIDA COM SUCESSO';
		END
END

INSERT INTO FUNCIONARIO (Cpf, Pnome, Unome) VALUES ( '18345676545', 'aeeeee', 'dfhfh');

------------------------------------------------------------------------------------------

SELECT * FROM sys.triggers WHERE is_disabled = 0 OR is_disabled = 1;

------------------------------------------------------------------------------------------

CREATE TRIGGER trigger_after_autores
ON FUNCIONARIO
AFTER INSERT, UPDATE
AS
	IF UPDATE(Pnome)
		BEGIN
		PRINT 'O nome foi alterado';
		END
	ELSE
		BEGIN
		PRINT 'Nome não foi modificado';
		END

------------------------------------------------------------------------------------------

--insere na tabela Log_Funcionario os dados após inserir um funcionario
CREATE TABLE Log_Funcionario(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	Cpf CHAR(11),
	Operacao VARCHAR(10),
	Data_Hora DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER funcionario_log 
ON FUNCIONARIO
AFTER INSERT
AS
BEGIN
	INSERT INTO LOG_FUNCIONARIO (Cpf, Operacao) SELECT I.Cpf, 'Insert' FROM inserted as I;

END
INSERT INTO FUNCIONARIO (Cpf, Pnome, Unome) VALUES ( '18343276545', 'afdfde', 'tthhh');

