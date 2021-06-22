USE ChangeIt;

-- Esto es para probar datos
INSERT INTO dbo.Merchants
	(name, url, enabled)
VALUES 
	('Stripe', 'https://stripe.com/', 1),
	('PayPal', 'https://www.paypal.com/', 1);

INSERT INTO dbo.PaymentStatus
	(status)
VALUES
	('Accepted'), ('Declined'), ('Processing');

INSERT INTO dbo.TransactionTypes
	(name)
VALUES
	('Sponsor'), ('Ad Payment');

INSERT INTO dbo.TransactionSubTypes
	(name)
VALUES
	('Comida Rapida'), ('Ahorro energetico'), ('Ahorro de agua');
	
DECLARE @spt DATETIME = CAST('2015-11-06 00:00:00.000' AS DATETIME)
DECLARE @pt DATETIME = CAST('2015-12-06 00:00:00.000' AS DATETIME)

exec sp_register_habit_payment 1500, 1, '', 5, 0, 'iPhone X', 'Juan81363Fletes787683850614', '192.168.1.1', 
	'Stripe', 'Accepted', 'Usar energia solar26693431', 'US', 'SONIC Drive In', 'Ahorro energetico', 10.5, 
	@spt, @pt;

SELECT * FROM dbo.PaymentAttempts;
SELECT * FROM dbo.Sponsors;
SELECT * FROM dbo.PaymentTransactions;

-- Aqui esta el SP
DROP PROCEDURE IF EXISTS sp_register_habit_payment;

CREATE PROCEDURE sp_register_habit_payment
	@amount DECIMAL(10, 2),
	@merchantTransNumber INT,
	@description NVARCHAR(148),
	@referenceNumber INT,
	@errorNumber INT,
	@computerName VARCHAR(148),
	@userName VARCHAR(256),
	@ipAddress VARCHAR(14),
	@merchantName VARCHAR(148),
	@paymentStatus VARCHAR(148),
	@habitTitle NVARCHAR(148),
	@country NVARCHAR(148),
	@locationName NVARCHAR(148),
	@transactionSubType VARCHAR(45),
	@radius DECIMAL(10, 2),
	@startSponsor DATETIME,
	@endSponsor DATETIME
AS
BEGIN 
	DECLARE @SponsorId BIGINT;
	DECLARE @postTime DATETIME;
	DECLARE @LocationId BIGINT;
	DECLARE @HabitId BIGINT;
	DECLARE @idLocationPerHabit BIGINT;
	DECLARE @userId BIGINT;
	DECLARE @checksum BINARY(256);
	DECLARE @checksumTrans BINARY(256);
	DECLARE @transactionTypeId INT;
	DECLARE @transactionSubTypeId INT;
	DECLARE @paymentAttemptsId BIGINT;
	DECLARE @idMerchant INT;
	DECLARE @idPaymentStatus INT;

	-- Obtenemos el id del payment status
	SELECT
		@idPaymentStatus = idPaymentStatus
	FROM dbo.PaymentStatus
	WHERE status = @paymentStatus;

	-- Obtenemos el id del merchant
	SELECT
		@idMerchant = idMerchants
	FROM dbo.Merchants
	WHERE name = @merchantName;

	-- Obtenemos el transaction sub type id
	SELECT
		@transactionTypeId = idTransactionType
	FROM dbo.TransactionTypes
	WHERE name = 'Sponsor';

	-- Obtenemos el transaction type id
	SELECT
		@transactionSubTypeId = idTransactionSubType
	FROM dbo.TransactionSubTypes
	WHERE name = @transactionSubType;

	-- Obtenemos el user id por su id de loggeo
	SELECT TOP 1
		@userId = us.idUser
	FROM dbo.InfoPerSocialMedia ips
	INNER JOIN dbo.Users us
		ON ips.idUser = us.idUser
	WHERE 
		ips.id_user = @userName;
	
	-- Obtener el idLocationPerHabit
	SELECT 
		@LocationId = idLocation
	FROM dbo.Locations
	WHERE
		dbo.Locations.country = @country AND dbo.Locations.name = @locationName;

	SELECT 
		@HabitId = idHabit
	FROM dbo.Habit
	WHERE
		dbo.Habit.title = @habitTitle;

	SELECT 
		@idLocationPerHabit = dbo.LocationsPerHabit.idLocationsPerHabit
	FROM dbo.LocationsPerHabit
	WHERE 
		dbo.LocationsPerHabit.idLocation = @LocationId AND dbo.LocationsPerHabit.idHabit = @HabitId;

	-- Setteamos la fecha de la transaccion
	SET @postTime = GETDATE();

	-- Hacemos el checksum
	SET @checksum = HASHBYTES('SHA2_256', CONCAT(
		@postTime, 
		'Habia una vez...', 
		@amount,
		@ipAddress, 
		@userName,
		@idMerchant,
		@description,
		@merchantTransNumber))

	-- Empieza la transaccion
	BEGIN TRY
		BEGIN TRANSACTION
			-- Insertamos los payments
			INSERT INTO dbo.PaymentAttempts
				(postTime, amount, merchanTransNumber, description, referenceNumber,
				errorNumber, computerName, userName, ipAddress, checksum, idMerchant, idUser, idPaymentStatus)
			VALUES	
				(@postTime, @amount, @merchantTransNumber, @description, @referenceNumber, 
				@errorNumber, @computerName, CAST(@userName AS VARCHAR(148)), @ipAddress, @checksum, @idMerchant, @userId, @idPaymentStatus);

			SET @paymentAttemptsId = @@IDENTITY;

			-- Insertamos el sponsor que hace el pago
			INSERT INTO dbo.Sponsors
				(idLocationsPerHabit, radius, idUser, startSponsor, endSponsor)
			VALUES
				(@idLocationPerHabit, @radius, @userId, @startSponsor, @endSponsor);

			SET @SponsorId = @@IDENTITY;

			-- Se necesita que el sponsor id sea parte del checksum
			-- Por eso se settea en la transaccion
			SET @checksumTrans = HASHBYTES('SHA2_256', CONCAT(
				@postTime,
				@amount,
				@SponsorId,
				'Dos hadas bailarinas para hacer mas seguro el checksum',
				@description,
				@paymentAttemptsId));

			-- Guardamos la transaccion
			INSERT INTO dbo.PaymentTransactions
				(postTime, description, computerName, ipAddress, checksum, amount, referenceID,
				idUser, idTransactionType, idTransactionSubType, idPaymentAttempts)
			VALUES
				(@postTime, @description, @computerName, @ipAddress, @checksumTrans, @amount, @SponsorId, 
				@userId, @transactionTypeId, @transactionSubTypeId, @paymentAttemptsId);
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SELECT   
			ERROR_NUMBER() AS ErrorNumber  
		   ,ERROR_MESSAGE() AS ErrorMessage;  
	END CATCH
END;