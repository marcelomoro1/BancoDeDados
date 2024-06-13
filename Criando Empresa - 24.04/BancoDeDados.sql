CREATE DATABASE IF NOT EXISTS EMPRESA;
DROP DATABASE EMPRESA;
CREATE TABLE EMPRESA.FUNCIONARIO (
	Pnome VARCHAR(50) NOT NULL,
    Minicial CHAR,
    Unome VARCHAR(15) NOT NULL,
    Cpf CHAR(11) PRIMARY KEY,
    DataNascimento DATE NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Sexo CHAR NOT NULL,
    Cpf_supervisor CHAR(11),
	Dnr INT,
    Salario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);

DESC EMPRESA.FUNCIONARIO;  #Descrição da tabela

CREATE TABLE EMPRESA.DEPARTAMENTO(
	Dnome VARCHAR(20) NOT NULL UNIQUE,
    Dnumero INT PRIMARY KEY,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(Cpf_supervisor)
);

DESC EMPRESA.DEPARTAMENTO;

ALTER TABLE	EMPRESA.FUNCIONARIO
ADD FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO(Dnumero);

CREATE TABLE EMPRESA.LOCALIZACAO(
	Dnumero INT NOT NULL,
    Dlocal VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO(Dnumero)
);

CREATE TABLE EMPRESA.PROJETO(
	Projnome VARCHAR(15) NOT NULL UNIQUE,
    Projnumero INT PRIMARY KEY,
    Projlocal VARCHAR(15),
    Dnum INT,
    FOREIGN KEY (Dnum) references DEPARTAMENTO(Dnumero)
);

CREATE TABLE EMPRESA.TRABALHA_EM(
	Fcpf CHAR(11) NOT NULL,
    Pnr INT NOT NULL,
    PRIMARY KEY (Fcpf, Pnr),
    Horas DECIMAL (3,1) NOT NULL,
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO (Cpf),
    FOREIGN KEY (Pnr) REFERENCES PROJETO(Projnumero)
);

DESC EMPRESA.TRABALHA_EM;

USE EMPRESA;

CREATE TABLE DEPENDENTE(
	Fcpf CHAR(11) NOT NULL,
    Nome_dependente VARCHAR(15),
    Sexo CHAR, 
    Datanascimento DATE NOT NULL,
    Parentesco VARCHAR(8),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);

ALTER TABLE FUNCIONARIO
	MODIFY COLUMN SALARIO DECIMAL(10,2) CHECK (SALARIO>0);

DESC FUNCIONARIO;

INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Pesquisa',5);

SELECT * FROM DEPARTAMENTO;

INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Administração',4);

INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Matriz',1);

DESC FUNCIONARIO;

INSERT INTO FUNCIONARIO (Pnome, Unome, Cpf, DataNascimento, Endereco, Sexo)
VALUES ('João','Silva','12345678999','1965-01-09','Rua das flores, patronato','M');



SELECT * FROM FUNCIONARIO;

INSERT INTO FUNCIONARIO (Pnome, Unome, Cpf, DataNascimento, Endereco, Sexo, Salario)
VALUES ('Fernando','Wong','51512512','1955-11-01','asdasdsasds, pdasdasdnato','M', 40.000);

SELECT * FROM FUNCIONARIO WHERE Pnome = "Joao";

SELECT * FROM funcionario WHERE Sexo = "M" AND Salario >= 30000;

SELECT * FROM FUNCIONARIO WHERE ENDERECO LIKE "%São Paulo%" OR ENDERECO LIKE"%Curitiba%";

SELECT * FROM FUNCIONARIO WHERE NOT ENDERECO  LIKE "%São Paulo%";

SELECT * FROM FUNCIONARIO ORDER BY Salario DESC;

SELECT * FROM FUNCIONARIO WHERE Cpf_supervisor IS NULL;

SELECT * FROM FUNCIONARIO WHERE Cpf_supervisor IS NOT NULL;

SELECT * FROM FUNCIONARIO WHERE Cpf_supervisor IS NOT NULL ORDER BY Salario DESC LIMIT 3;

SELECT MIN(Salario) FROM FUNCIONARIO;
SELECT MAX(Salario) FROM FUNCIONARIO;

SELECT * FROM FUNCIONARIO WHERE SALARIO = (SELECT MAX(Salario) FROM FUNCIONARIO);
SELECT * FROM FUNCIONARIO ORDER BY SALARIO DESC LIMIT 1; 

SELECT * FROM FUNCIONARIO WHERE SALARIO = (SELECT MIN(Salario) FROM FUNCIONARIO);
SELECT * FROM FUNCIONARIO ORDER BY SALARIO ASC LIMIT 1;

SELECT COUNT(Pnome) FROM FUNCIONARIO;
SELECT AVG(Salario) FROM FUNCIONARIO;
SELECT SUM(Salario) FROM FUNCIONARIO;

SELECT * FROM FUNCIONARIO WHERE DATANASC LIKE '__72%'; 

SELECT * FROM FUNCIONARIO WHERE SALARIO IN (25000,30000);
SELECT * FROM FUNCIONARIO WHERE SEXO = 'F';
SELECT MIN(Salario) FROM FUNCIONARIO;
SELECT * FROM FUNCIONARIO WHERE SALARIO IN (SELECT MIN(Salario) FROM FUNCIONARIO) AND SEXO = 'F';


SELECT Pnr, Horas FROM trabalha_em WHERE Fcpf = '33344555587';
SELECT DISTINCT Fcpf FROM TRABALHA_EM WHERE (Pnr, Horas) IN (SELECT Pnr, Horas FROM trabalha_em WHERE Fcpf = '33344555587');


SELECT * FROM FUNCIONARIO WHERE Dnr = 5 AND Salario between 30000 AND 40000;

SELECT Pnome AS 'Nome', Unome AS 'Sobrenome' FROM FUNCIONARIO;

#Relação FUNCIONARIO com seu DEPARTAMENTO (sendo o de pesquisa)           
SELECT Pnome as 'Nome', Minicial as 'Meio', Unome as 'Ultimo nome' FROM FUNCIONARIO as f, DEPARTAMENTO as d WHERE f.Dnr = d.Dnumero AND Dnome = 'Pesquisa';

#Relação FUNCIONARIO com seus DEPEDENTES
SELECT Pnome,Minicial,Unome, Nome_dependente FROM FUNCIONARIO as f, DEPENDENTE as d WHERE f.Cpf = d.Fcpf;

SELECT * FROM departamento as d, projeto as p WHERE d.Dnumero = p.Dnum;

#RELAÇÃO TABELA FUNCIONARIO COM PROJETO E ONDE ELES TRABALHAM
SELECT Pnome,Projnome, Horas
FROM FUNCIONARIO, PROJETO, TRABALHA_EM
WHERE TRABALHA_EM.Fcpf = FUNCIONARIO.Cpf AND TRABALHA_EM.Pnr = PROJETO.Projnumero;


#INNER JOIN
SELECT Pnome, Unome, Endereco FROM FUNCIONARIO INNER JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero WHERE DEPARTAMENTO.Dnome = 'Pesquisa' ORDER BY Pnome ASC;

SELECT Pnome, Unome FROM FUNCIONARIO, PROJETO, TRABALHA_EM WHERE TRABALHA_EM.Fcpf = FUNCIONARIO.Cpf AND TRABALHA_EM.Pnr = PROJETO.Projnumero AND PROJETO.Projnome = 'ProdutoX'; #SEM INNER JOIN
SELECT Pnome, Unome FROM FUNCIONARIO INNER JOIN TRABALHA_EM ON FUNCIONARIO.Cpf = TRABALHA_EM.Fcpf INNER JOIN PROJETO ON TRABALHA_EM.Pnr = PROJETO.Projnumero WHERE PROJETO.Projnome = 'ProdutoX'; #COM INNER JOIN

SELECT Projnumero, Dnumero, Unome, Endereco, Datanasc FROM FUNCIONARIO INNER JOIN DEPARTAMENTO ON FUNCIONARIO.Cpf = DEPARTAMENTO.Cpf_gerente INNER JOIN PROJETO ON DEPARTAMENTO.Dnumero = PROJETO.Dnum WHERE PROJETO.Projlocal = 'Mauá';

#LEFT JOIN
#Quero pegar o ultimo nome dos funcionarios e o ultimo nome dos seus gerentes
SELECT F.Unome as 'Funcionario' , G.Unome as 'Gerente' FROM FUNCIONARIO as F LEFT JOIN FUNCIONARIO as G ON G.CPF = F.Cpf_supervisor;

#RIGHT JOIN -> SÓ MUDA OS LADOS
SELECT F.Unome as 'Funcionario' , G.Unome as 'Gerente' FROM FUNCIONARIO as F RIGHT JOIN FUNCIONARIO as G ON G.CPF = F.Cpf_supervisor;

#CROSS JOIN (Forma errada de usar)
SELECT * FROM FUNCIONARIO CROSS JOIN DEPENDENTE;


