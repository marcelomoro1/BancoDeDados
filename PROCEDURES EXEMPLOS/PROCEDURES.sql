CREATE PROCEDURE ExibirNome 
(@Nome VARCHAR(50))
AS
BEGIN
	SELECT @Nome as 'Nome';
END
EXEC ExibirNome @Nome = 'Marcelo'; --exibe o nome Marcelo

CREATE PROCEDURE listar_funcionarios_por_departamento
AS
BEGIN
	SELECT F.Pnome, F.Unome, D.Dnome
	FROM FUNCIONARIO AS F
	INNER JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
END
EXEC listar_funcionarios_por_departamento --exibe todos os funcionarios e seus respectivos departamentos

CREATE PROCEDURE sp_Funcionario
WITH ENCRYPTION
AS
BEGIN
	SELECT *
	FROM FUNCIONARIO
END --cria um procedure que não consegue ser visualizado pelo sp_helptext por conta do encryption


ALTER PROCEDURE info -- alter procedure para mudar a informação de uma procedure já criada
@Nome_departamento VARCHAR(50)
AS
BEGIN
	SELECT CONCAT(F.Pnome, ' ',F.Unome) as 'Nome Completo',D.Dnome 
	FROM FUNCIONARIO AS F
	INNER JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
	WHERE D.Dnome = @Nome_departamento

END
EXEC info @Nome_departamento = 'Pesquisa' --exibe todos os funcionarios e de um departamento especifico


CREATE PROCEDURE atualiza_salario
@Cpf CHAR(11),
@Novo_Salario DECIMAL(10,2)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM FUNCIONARIO AS F WHERE F.Cpf = @Cpf)
		BEGIN

			UPDATE FUNCIONARIO
			SET Salario = @Novo_Salario
			WHERE Cpf = @Cpf;

		END
	ELSE
		PRINT 'Nao existe alguem com esse cpf';

END
EXEC atualiza_salario @Cpf = '33344555587', @Novo_Salario = 25000.00; -- Atualiza o salario de alguem com o cpf especifico e caso o cpf não exista de uma mensagem
SELECT * FROM FUNCIONARIO WHERE FUNCIONARIO.Cpf = '33344555587';


ALTER PROCEDURE atualiza_salario --outra forma mais facil de realizar o exercicio acima, utlizando rowcount
@Cpf CHAR(11),
@Novo_Salario DECIMAL(10,2)
AS
BEGIN
	UPDATE FUNCIONARIO
	SET Salario = @Novo_Salario
	WHERE Cpf = @Cpf;

	IF @@ROWCOUNT= 0 --caso nenhuma linha tenha sido alterada (nenhum cpf foi modificado, faça mostre que nao deu certo)
		PRINT 'Nao existe alguem com esse cpf'

END
EXEC atualiza_salario @Cpf = '33344555587', @Novo_Salario = 25000.00;
SELECT * FROM FUNCIONARIO WHERE FUNCIONARIO.Cpf = '33344555587';


CREATE PROCEDURE sp_Inserir_Funcionario
    @Pnome VARCHAR(15),
    @Minicial CHAR(1),
    @Unome VARCHAR(15),
    @Cpf CHAR(11)
AS
BEGIN
	INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf) VALUES (@Pnome, @Minicial, @Unome, @Cpf);
END
DROP PROCEDURE sp_Inserir_Funcionario
EXEC sp_Inserir_Funcionario @Pnome = 'Juca', @Minicial = 'm', @Unome = 'brabo', @Cpf = '12345678911'; --inserindo um funcionario na tabela


CREATE PROCEDURE sp_funcionario_departamento
	@Pnome VARCHAR(15),
    @Minicial CHAR(1),
    @Unome VARCHAR(15),
    @Cpf CHAR(11),
	@Dnumero INT,
	@Dnome VARCHAR(15)
AS
BEGIN
	--insere um novo departamento
	INSERT INTO DEPARTAMENTO (Dnumero, Dnome) VALUES (@Dnumero, @Dnome);
	--insere um novo funcionario desse mesmo departamento
	INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Dnr) VALUES (@Pnome, @Minicial, @Unome, @Cpf, @Dnumero);

	--faz com que esse funcionario seja gerente desse departamento
	UPDATE DEPARTAMENTO
	SET Cpf_gerente = @Cpf, Data_inicio_gerente = GETDATE()
	WHERE Dnumero = @Dnumero;
END

EXEC sp_funcionario_departamento @Pnome = 'Welington', @Minicial= 'F',@Unome= 'Silva', @Cpf= '98454376543', @Dnumero = 91, @Dnome = 'Engenharia'
SELECT * FROM DEPARTAMENTO WHERE Dnumero = 91;



CREATE PROCEDURE sp_add_funcionario
	@Pnome VARCHAR(15),
    @Minicial CHAR(1),
    @Unome VARCHAR(15),
	@Cpf VARCHAR(11)

AS
BEGIN

	--insere um novo funcionario desse mesmo departamento
	IF NOT EXISTS(SELECT 1 FROM FUNCIONARIO AS F WHERE F.Pnome = @Pnome AND F.Minicial = @Minicial AND F.Unome = @Unome)
	BEGIN
		INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf) VALUES (@Pnome, @Minicial, @Unome, @Cpf);
	END
	ELSE
	BEGIN
		print 'ja existe';

	END
END
DROP PROCEDURE sp_add_funcionario
EXEC sp_add_funcionario @Pnome = 'mito', @Minicial = 'm', @Unome = 'uaas', @Cpf = '12475642389'--Inserir novo funcionario mas antes verificar se existe um funcionario com o mesmo nome completo
