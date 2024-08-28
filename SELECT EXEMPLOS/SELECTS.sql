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

--NOT
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

--COUNT
SELECT COUNT(Cpf)
FROM FUNCIONARIO; --Quantidade de funcionarios existentes

--MEDIA
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

--CONCAT e AUTORELACIONAMENTO
SELECT CONCAT(F1.Pnome, ' ',F1.Unome) as 'Nome Completo', F2.Pnome as 'Supervisor'
FROM FUNCIONARIO AS F1, FUNCIONARIO AS F2
WHERE F2.Cpf = F1.Cpf_supervisor; --Seleciona todos funcionarios e seus respectivos gerentes

--INNER JOIN 
SELECT F.*, D.*
FROM FUNCIONARIO AS F
INNER JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero --Seleciona funcionarios que fazem parte de algum departamento vinculado

--INNER JOIN COM WHERE
SELECT F.Pnome, F.Unome, F.Endereco
FROM FUNCIONARIO AS F
INNER JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
WHERE D.Dnome = 'Pesquisa'; --Seleciona os funcionarios que trabalham no departamento Pesquisa

--INNER JOIN COM 3 TABELAS
SELECT F.Pnome, F.Unome
FROM FUNCIONARIO AS F
INNER JOIN TRABALHA_EM AS TE
ON TE.Fcpf = F.Cpf  --Ponto de conexão da tabela TRABALHA_EM com a tabela FUNCIONARIO
INNER JOIN PROJETO AS P
ON TE.Pnr = P.Projnumero --Ponto de conexão da tabela TRABALHA_EM com a tabela PROJETO
WHERE P.Projnome = 'ProdutoX'; --Seleciona os funcionarios que trabalham no Produto X

--INNER JOIN COM 3 TABELAS
SELECT P.Projnumero, D.Dnumero, F.Unome, F.Endereco, F.Datanasc
FROM FUNCIONARIO AS F
INNER JOIN DEPARTAMENTO AS D
ON D.Cpf_gerente = F.Cpf
INNER JOIN PROJETO AS P
ON D.Dnumero = P.Dnum
WHERE P.Projlocal = 'Mauá'; --Seleciona o gerente que coordena os projetos que estão situados em Mauá

--LEFT JOIN 
SELECT F.*, D.*
FROM FUNCIONARIO AS F
LEFT JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero --Funcionario fica a esquerda pq queremos o funcionarios com departamento
ORDER BY F.Pnome ASC; -- Seleciona os funcionarios com e sem departamento

--LEFT JOIN 
SELECT *
FROM FUNCIONARIO AS F
LEFT JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero 
WHERE F.Dnr IS NULL; --Seleciona apenas os funcionarios que NÃO possuem departamento

--NOT EXISTS
SELECT *
FROM DEPARTAMENTO AS D
WHERE NOT EXISTS (SELECT 1 FROM FUNCIONARIO AS F WHERE F.Dnr = D.Dnumero); --Seleciona todos departamento que não existem funcionarios, o 1 serve para dizer que departamentos que possuem mais de 1 funcionario serão excluidos

--UNION
SELECT D.Dnome
FROM DEPARTAMENTO AS D
UNION
SELECT P.Projnome
FROM PROJETO AS P -- Junta dois selects em um só, esse seleciona o nome de todos departamentos e o nome de todos projetos

--INTERSECT
SELECT Cpf
FROM FUNCIONARIO
INTERSECT
SELECT Cpf_gerente
FROM DEPARTAMENTO; --Intersect pega apenas o que tem de igual nas duas tabelas e mostra, no caso esse seleciona os funcionarios que SÃO gerentes em departamentos

--EXCEPT
SELECT Cpf
FROM FUNCIONARIO
EXCEPT
SELECT Cpf_gerente
FROM DEPARTAMENTO; --Except pega apenas o que tem de DIFERENTE nas duas tabelas e mostra, no caso esse seleciona os funcionarios que não são gerentes em departamentos

--GROUP BY com COUNT
SELECT D.Dnome as 'Nome Departamento', COUNT(F.Cpf) as 'N_Funcionarios'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
GROUP BY D.Dnome --Seleciona quantas pessoas tem em cada departamento

--GROUP BY com SUM
SELECT D.Dnome as 'Nome Departamento', SUM(F.Salario) as 'Salario Total'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
GROUP BY D.Dnome --Seleciona os departamentos e a soma de salario dos funcionarios em cada departamento

--GROUP BY com AVG
SELECT P.Projnome as 'Nome do Projeto', AVG(TE.Horas) as 'Horas totais'
FROM TRABALHA_EM AS TE
JOIN PROJETO AS P
ON P.Projnumero = TE.Pnr
GROUP BY P.Projnome; --Seleciona a media de horas trabalhadas por projeto, o group by tem que ser sempre por um dos campos utilizados no select, se der erro tenta com outro

--GROUP BY simples
SELECT COUNT(F.Cpf) as 'Qtd funcionarios', F.Sexo as 'Sexo'
FROM FUNCIONARIO AS F
GROUP BY F.Sexo --Seleciona quantas funcionarios tem por sexo

--GROUP BY
SELECT COUNT(*) as 'Numero de Projetos', P.Projlocal as 'Local' 
FROM PROJETO AS P
GROUP BY P.Projlocal --Seleciona o numero de projetos em cada local

--HAVING 
SELECT D.Dnome as 'Departamento', COUNT(F.cpf) as 'Quantidade'
FROM FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
GROUP BY D.Dnome
HAVING COUNT(F.Cpf)>3
ORDER BY D.Dnome ; --Seleciona departamentos com mais de 3 funcionarios

--HAVING com SUM
SELECT P.Projnome as 'Projeto', SUM(TE.Horas) as 'Horas'
FROM PROJETO AS P
JOIN TRABALHA_EM AS TE
ON TE.Pnr = P.Projnumero
GROUP BY P.Projnome
HAVING SUM(TE.Horas) > 50
ORDER BY P.Projnome; --Seleciona os projetos que tem mais de 50 horas trabalhadas

--EXISTS
SELECT F.*
FROM FUNCIONARIO AS F
WHERE EXISTS (SELECT 1 FROM DEPARTAMENTO AS D WHERE D.Cpf_gerente = F.Cpf ) --Seleciona os funcionarios que são gerente em algum departamento

-- CAST
SELECT 'O funcionario ' + F.pnome + ' Tem um salario de ' + CAST(F.Salario as VARCHAR(30)) 
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Jennifer';

-- CONVERT
SELECT 'O funcionario ' + F.pnome + ' Tem um salario de ' + CONVERT(VARCHAR(30), F.Salario) 
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Jennifer';

-- CONVERTENDO DATA AMERICANA PARA BRASILEIRA
SELECT CONVERT(VARCHAR(30), FUNCIONARIO.Datanasc, 103)
FROM FUNCIONARIO
WHERE FUNCIONARIO.Pnome = 'Jennifer';
