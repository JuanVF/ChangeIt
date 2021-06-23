USE ChangeIt;

-- Aqui esta el SP
DROP PROCEDURE IF EXISTS sp_register_ad_payment;

CREATE PROCEDURE sp_register_ad_payment
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
	@transactionSubType VARCHAR(45),
	@postLink VARCHAR(512),
	@startDate DATETIME,
	@endDate DATETIME,
	@habitTitle NVARCHAR(148),
	@country NVARCHAR(148),
	@locationName NVARCHAR(148),
	@changeItPercentage DECIMAL(5, 2)
AS
BEGIN 
	DECLARE @postTime DATETIME;
	DECLARE @userId BIGINT;
	DECLARE @checksum BINARY(256);
	DECLARE @checksumTrans BINARY(256);
	DECLARE @transactionTypeId INT;
	DECLARE @transactionSubTypeId INT;
	DECLARE @paymentAttemptsId BIGINT;
	DECLARE @idMerchant INT;
	DECLARE @idPaymentStatus INT;
	DECLARE @idPost BIGINT;
	DECLARE @LocationId BIGINT;
	DECLARE @HabitId BIGINT;
	DECLARE @idLocationPerHabit BIGINT;
	DECLARE @idPaymentFromAd BIGINT;
	DECLARE @tamount DECIMAL(10, 2);
	DECLARE @amountPart DECIMAL(10, 2);
	DECLARE @cursor_idSponsor BIGINT;
	DECLARE @cursor_amount DECIMAL(10, 2);
	DECLARE @tempSponsorsT TABLE
	(
		idPaymentFromAd BIGINT,
		idSponsor BIGINT, 
		amount DECIMAL(10, 2),
		postTime DATETIME
	);

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
	WHERE name = 'Ad Payment';

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

	-- Obtenemos el id del post
	SELECT TOP 1
		@idPost = idPost
	FROM dbo.Posts
	WHERE link = @postLink;
	
	-- Obtenemos el id del location
	SELECT 
		@LocationId = idLocation
	FROM dbo.Locations
	WHERE
		dbo.Locations.country = @country AND dbo.Locations.name = @locationName;
	-- obtenemos el id del habito
	SELECT 
		@HabitId = idHabit
	FROM dbo.Habit
	WHERE
		dbo.Habit.title = @habitTitle;
		
	-- Obtenemos el idLocationPerHabit
	SELECT 
		@idLocationPerHabit = dbo.LocationsPerHabit.idLocationsPerHabit
	FROM dbo.LocationsPerHabit
	WHERE 
		dbo.LocationsPerHabit.idLocation = @LocationId AND dbo.LocationsPerHabit.idHabit = @HabitId;

	-- Obtenemos el monto total
	SELECT
		@tamount = SUM(amount)
	FROM dbo.Sponsors spon
	INNER JOIN dbo.LocationsPerHabit lph
		ON spon.idLocationsPerHabit = lph.idLocationsPerHabit
	WHERE 
		spon.idLocationsPerHabit = @idLocationPerHabit

	-- Obtenemos los usuarios a los que se les va a pagar
	-- Se usa un cursor para leer cada usuario
	SET @postTime = GETDATE();

	DECLARE sponsorsInfo CURSOR READ_ONLY FOR 
	(
		SELECT
			spon.idSponsor,
			spon.amount
		FROM dbo.Sponsors spon
		INNER JOIN dbo.LocationsPerHabit lph
			ON spon.idLocationsPerHabit = lph.idLocationsPerHabit
		WHERE 
			spon.idLocationsPerHabit = @idLocationPerHabit
	);

	-- Vamos a leer cada sponsor para guardarlos en una tabla
	OPEN sponsorsInfo;

	FETCH NEXT FROM sponsorsInfo INTO @cursor_idSponsor, @cursor_amount;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @amountPart = (@amount - @amount*(@changeItPercentage/100.0))*(@cursor_amount / @tamount)

		INSERT INTO @tempSponsorsT
			(idPaymentFromAd, idSponsor, amount, postTime)
		VALUES
			(@idPaymentFromAd, @cursor_idSponsor, @amountPart, @postTime);

	FETCH NEXT FROM sponsorsInfo INTO @cursor_idSponsor, @cursor_amount;
	END

	CLOSE sponsorsInfo;
	DEALLOCATE sponsorsInfo;

	-- Inicializamos el checksum
	SET @checksum = HASHBYTES('SHA2_256', CONCAT(
		@postTime, 
		'Habia una vez...', 
		@amount,
		@ipAddress, 
		@userName,
		@idMerchant,
		@description,
		@merchantTransNumber));

	-- Iniciamos el transaction
	-- Hay que tomar en cuente que este SP no se ejecuta muchas veces seguidas o durante el dia
	-- Solo cuando se paga un ad, entonces, por eso el transaction es un poco mas largo de lo habitual (ya que lo requiere)
	BEGIN TRY
		BEGIN TRANSACTION
			-- Insertamos el registro de payment desde un ad
			INSERT INTO dbo.PaymentFromAd
				(idPost, amount, postTime, ChangeItPercentage)
			VALUES
				(@idPost, @amount, @postTime, @changeItPercentage);

			SET @idPaymentFromAd = @@IDENTITY;

			UPDATE @tempSponsorsT SET idPaymentFromAd = @idPaymentFromAd;

			-- Insertamos el pago de todos los sponsors transaccionalmente
			INSERT INTO dbo.SponsorsPayment
			SELECT
				idPaymentFromAd, idSponsor, amount, postTime
			FROM @tempSponsorsT;

			-- Insertamos los payments
			INSERT INTO dbo.PaymentAttempts
				(postTime, amount, merchanTransNumber, description, referenceNumber,
				errorNumber, computerName, userName, ipAddress, checksum, idMerchant, idUser, idPaymentStatus)
			VALUES	
				(@postTime, @amount, @merchantTransNumber, @description, @referenceNumber, 
				@errorNumber, @computerName, CAST(@userName AS VARCHAR(148)), @ipAddress, @checksum, @idMerchant, @userId, @idPaymentStatus);

			SET @paymentAttemptsId = @@IDENTITY;

			-- Se necesita que el registro de payment sea parte del checksum
			-- Por eso se settea en la transaccion
			SET @checksumTrans = HASHBYTES('SHA2_256', CONCAT(
				@postTime,
				@amount,
				@idPaymentFromAd,
				'Dos hadas bailarinas para hacer mas seguro el checksum',
				@description,
				@paymentAttemptsId));

			-- Guardamos la transaccion
			INSERT INTO dbo.PaymentTransactions
				(postTime, description, computerName, ipAddress, checksum, amount, referenceID,
				idUser, idTransactionType, idTransactionSubType, idPaymentAttempts)
			VALUES
				(@postTime, @description, @computerName, @ipAddress, @checksumTrans, @amount, @idPaymentFromAd, 
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