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
