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
