Foi utilizado o banco de dados EMPRESA das aulas

--DISTINCT
SELECT DISTINCT SALARIO 
FROM FUNCIONARIO ;

--WHERE
SELECT * 
FROM FUNCIONARIO 
WHERE PNome = 'João'; --selecionar funcionarios que tem o pnome de joão

--AND
SELECT Pnome, Salario
FROM Funcionario
WHERE Salario >= 30000 AND Sexo = 'M'; --selecionar funcionarios do sexo masc que recebem >= 30.000

--OR
SELECT Pnome
FROM FUNCIONARIO
WHERE ENDERECO LIKE '%São Paulo%' OR ENDERECO LIKE '%Curitiba%'; --selecionar funcionarios que moram ou em são paulo ou em curitiba

--OR
SELECT Pnome
FROM FUNCIONARIO
WHERE NOT ENDERECO LIKE '%São Paulo%'; --selecionar funcionarios que não mora em são paulo

--ORDER BY
SELECT *
FROM FUNCIONARIO
ORDER BY SALARIO DESC; --listar funcionarios por ordem decrescente de salario

--NULL
SELECT * 
FROM FUNCIONARIO
WHERE Cpf_supervisor IS NULL; --funcionarios que não possuem supervisor

--SELECT TOP
SELECT TOP 3 *
FROM FUNCIONARIO
ORDER BY SALARIO DESC; --selecione os top 3 salarios da empresa
