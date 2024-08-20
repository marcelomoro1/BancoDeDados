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

--Funcao min (com select aninhado e variável)
SELECT MIN(Salario)
FROM FUNCIONARIO; --seleciona o salario minimo dos funcionarios

SELECT * 
FROM FUNCIONARIO
WHERE SALARIO = (SELECT MIN(Salario)
FROM FUNCIONARIO); --Seleciona todas informações dos funcionarios que tem o salário minimo

--Outra forma de realizar o mesmo exemplo com a variável
DECLARE @Salario_Min DECIMAL(10,2); --Crio uma variavel salario minimo
SET @Salario_Min = (SELECT MIN(Salario) FROM FUNCIONARIO); --Atribuo o valor na variável

SELECT * 
FROM FUNCIONARIO
WHERE SALARIO = @Salario_Min; --Seleciona todas informações dos funcionarios que tem o salário minimo

--Funcao Max (com select aninhado e variável)
SELECT * 
FROM FUNCIONARIO
WHERE SALARIO = (SELECT MAX(Salario)
FROM FUNCIONARIO);

--Outra forma de realizar o mesmo exemplo com a variável
DECLARE @Salario_Max DECIMAL(10,2); --Crio uma variavel salario maximo
SET @Salario_Max = (SELECT MAX(Salario) FROM FUNCIONARIO); --Atribuo o valor na variável

SELECT * 
FROM FUNCIONARIO
WHERE SALARIO = @Salario_Max; --Seleciona todas informações dos funcionarios que tem o salário maximo

--Count
SELECT COUNT(Cpf)
FROM FUNCIONARIO;

--Media
SELECT AVG(Salario)
FROM FUNCIONARIO; -- media salarial dos funcionarios

SELECT Salario
FROM FUNCIONARIO
WHERE Cpf_supervisor IS NULL; --Quanto o jorge ganha

--Seleciona o salario do jorge (chefe) menos a media salarial da empresa pra ver a diferença salarial (Forma não tão correta)
SELECT (SELECT Salario FROM FUNCIONARIO WHERE Cpf_supervisor IS NULL) - (SELECT AVG(Salario) FROM FUNCIONARIO); 

--Forma correta do exercicio acima
DECLARE @Salario_Media DECIMAL(10,2); 
SET @Salario_Media = (SELECT AVG(Salario) FROM FUNCIONARIO); --Declaro a media salarial
DECLARE @Salario_Maximo DECIMAL(10,2); 
SET @Salario_Maximo = (SELECT MAX(Salario) FROM FUNCIONARIO); --Declaro o salario maximo
SELECT(@Salario_Maximo - @Salario_Media); --Realizo a conta

--LIKE
SELECT *
FROM FUNCIONARIO
WHERE Datanasc LIKE '__72%';

--IN
SELECT *
FROM FUNCIONARIO
WHERE SALARIO IN (25000,30000); --Seleciona todos valores entre 25000 e 30000

--SELECT
SELECT Horas, Pnr 
FROM TRABALHA_EM
WHERE Fcpf = '33344555587'; --fernando

SELECT DISTINCT F.Pnome,T1.Fcpf
FROM TRABALHA_EM AS T1, TRABALHA_EM AS T2, FUNCIONARIO AS F
WHERE T1.Pnr = T2.Pnr 
AND F.Cpf = T1.Fcpf
AND T1.Horas = T2.Horas
AND T2.Fcpf = '33344555587'
AND T1.Fcpf <> '33344555587'; -- Seleciona as pessoas que trabalham no mesmo projeto do fernando e no mesmo numero de horas 

--BETWEEN
SELECT F.Pnome 
FROM Funcionario as F
WHERE F.Dnr = 5 
AND F.Salario BETWEEN 30000 AND 40000; --Seleciona os funcionarios do departamento 5 que recebem entre 30 a 40k

--ALIASES
SELECT F.Pnome as 'Nome', F.Unome as 'Sobrenome' 
FROM Funcionario as F, Departamento as D
WHERE F.Dnr = D.Dnumero
AND D.Dnome='Pesquisa'; --Selecionar o nome e sobrenome dos funcionarios que trabalham no departamento Pesquisa
