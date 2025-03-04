BEGIN TRANSACTION
	INSERT INTO FUNCIONARIO VALUES ( 'AAAAAA', 'S', 'Souza', '18765432168', '1931-06-20', 'Av Arthur de Lima, 54, Santo André, SP', 'F', 43000, '88866555576' , 4 );
	INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('AAAAA', 5);

	IF @@ERROR <> 0
		ROLLBACK TRANSACTION;
	ELSE
		COMMIT TRANSACTION;


--------------------------------

BEGIN TRANSACTION
	BEGIN TRY
		
		INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('AAAAA', 7);
		INSERT INTO FUNCIONARIO VALUES ( 'AAAAAA', 'S', 'Souza', '18765432168', '1931-06-20', 'Av Arthur de Lima, 54, Santo André, SP', 'F', 43000, '88866555576' , 7 );

		COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION;
		PRINT ERROR_MESSAGE();

	END CATCH;

---------------------------------

BEGIN TRANSACTION;
DECLARE @Dnr int = 1;
DECLARE @Percent_Aum FLOAT = 1.15;

UPDATE FUNCIONARIO
SET Salario = Salario * @Percent_Aum
WHERE Dnr = @Dnr;

IF @@ERROR <> 0
BEGIN
	ROLLBACK TRANSACTION;
	PRINT 'ERRO DETECTADO';
END
ELSE 
BEGIN
	COMMIT TRANSACTION;
	PRINT 'Transacao realizada';
END


--------------------------------

	CREATE TABLE PRODUTO(
		id int primary key,
		quantidade int not null,
		nome varchar(255) not null
	);

	INSERT INTO PRODUTO VALUES (1,5,'PEIXE');

	BEGIN TRANSACTION;
	DECLARE @produto_id int = 1;
	DECLARE @qtd_compra int = 2;

	BEGIN TRY
		IF (SELECT quantidade FROM PRODUTO WHERE @produto_id = id) >= @qtd_compra
		BEGIN
			SELECT * FROM PRODUTO
			UPDATE PRODUTO
			SET quantidade = quantidade - @qtd_compra
			WHERE id = @produto_id;
			COMMIT TRANSACTION;
			print 'compra realizada meu parceiro';
		END
		ELSE
			BEGIN 
			ROLLBACK TRANSACTION;
			PRINT 'ESTOQUE INSUFICIENTE';
			END
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		PRINT 'DEU ERRO NO IF';
		PRINT ERROR_MESSAGE();
	END CATCH

------------------------------------
	CREATE TABLE CONTA(
	id INT PRIMARY KEY,
	saldo DECIMAL(10,2) not null,
	nome varchar(255) not null
	);
	INSERT INTO CONTA VALUES (1,1500.25,'jose');
	INSERT INTO CONTA VALUES (2,4200.25,'sdfaa');
	INSERT INTO CONTA VALUES (3,8100.25,'ccccccc');

	CREATE PROCEDURE sp_Transferencia
	@contaOrigem INT,
	@contaDestino INT,
	@valorTransferencia DECIMAL(10,2)
	AS
	BEGIN
		BEGIN TRANSACTION;

		--removendo
		UPDATE CONTA
		SET saldo = saldo - @valorTransferencia
		WHERE id = @contaOrigem;
		SELECT * FROM CONTA;

		--depositando
		UPDATE CONTA
		SET saldo = saldo + @valorTransferencia
		WHERE id = @contaDestino;
		SELECT * FROM CONTA;

		IF (SELECT saldo FROM CONTA WHERE id = @contaOrigem) <0
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'DINHEIRO INSUFICIENTE';
		END

		ELSE
		BEGIN
			COMMIT TRANSACTION;
			PRINT 'TRANSFERENCIA REALIZADA COM SUCESSO';
		END
	END
	EXEC sp_Transferencia @contaOrigem = 1, @contaDestino = 2, @valorTransferencia = 10;
	SELECT * FROM CONTA
