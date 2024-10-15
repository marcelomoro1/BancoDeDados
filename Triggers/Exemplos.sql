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
	
	SELECT @Pnome = I.Pnome, @Unome = I.Unome, @CPF = I.Cpf
	FROM inserted as I;
	
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

