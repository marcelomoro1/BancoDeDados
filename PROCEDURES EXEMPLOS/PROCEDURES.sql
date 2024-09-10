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
