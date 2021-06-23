USE ChangeIt;

-- Store procedure para llenar LocationsPerHabit
DROP PROCEDURE IF EXISTS fill_habits_per_locations;

CREATE PROCEDURE fill_habits_per_locations
	@Cantidad INT
AS
BEGIN
	DECLARE @idHabit BIGINT;
	DECLARE @idLocation BIGINT;
	DECLARE @idLocationsPerHabit BIGINT;
	DECLARE @amount DECIMAL(10, 2);

	DECLARE @Max BIGINT;
	DECLARE @Min BIGINT;

	WHILE @Cantidad > 0
	BEGIN
		-- Seleccionamos un habito aleatorio
		SELECT
			@Max = MAX(idHabit),
			@Min = MIN(idHabit)
		FROM dbo.Habit;

		SELECT TOP 1
			@idHabit = idHabit
		FROM dbo.Habit
		WHERE idHabit >= RAND() * (@Max - @Min) + @Min;

		-- Seleccionamos un lugar aleatorio
		SELECT
			@Max = MAX(idLocation),
			@Min = MIN(idLocation)
		FROM dbo.Locations;

		SELECT TOP 1
			@idLocation = idLocation
		FROM dbo.Locations
		WHERE idLocation >= RAND() * (@Max - @Min) + @Min;

		INSERT INTO dbo.LocationsPerHabit
			(idHabit, idLocation)
		VALUES
			(@idHabit, @idLocation);

		SET @idLocationsPerHabit = @@IDENTITY;

		SET @amount = RAND()*500;

		INSERT INTO dbo.Prices
			(price, idLocationPerHabit)
		VALUES
			(@amount, @idLocationsPerHabit);

		SET @Cantidad = @Cantidad  - 1;
	END	
END

-- Store procedure para llenar HabitosPorPost
DROP PROCEDURE IF EXISTS fill_posts_per_habits;

EXEC fill_posts_per_habits 10000

CREATE PROCEDURE fill_posts_per_habits
	@Cantidad INT
AS 
BEGIN
	DECLARE @idPost BIGINT;
	DECLARE @idLocationPerHabit BIGINT;

	DECLARE @Max BIGINT;
	DECLARE @Min BIGINT;

	WHILE @Cantidad > 0
	BEGIN
		-- Seleccionamos un post aleatorio
		SELECT
			@Max = MAX(idPost),
			@Min = MIN(idPost)
		FROM dbo.Posts;

		SELECT TOP 1
			@idPost = idPost
		FROM dbo.Posts
		WHERE idPost >= RAND() * (@Max - @Min) + @Min;

		-- Seleccionamos un habito aleatorio
		SELECT
			@Max = MAX(idLocationsPerHabit),
			@Min = MIN(idLocationsPerHabit)
		FROM dbo.LocationsPerHabit;

		SELECT TOP 1
			@idLocationPerHabit = idLocationsPerHabit
		FROM dbo.LocationsPerHabit
		WHERE idLocationsPerHabit >= RAND() * (@Max - @Min) + @Min;
		
		INSERT INTO dbo.HabitsPerPosts
			(idPost, idLocationPerHabit)
		VALUES
			(@idPost, @idLocationPerHabit);

		SET @Cantidad = @Cantidad - 1;
	END
END;

-- Store procedure para insertar pagos de habitos
DROP PROCEDURE IF EXISTS fill_habit_payment;

exec fill_habit_payment 2000

SELECT * FROM dbo.PaymentAttempts;

CREATE PROCEDURE fill_habit_payment
	@Cantidad INT
AS
BEGIN
	DECLARE @Max BIGINT;
	DECLARE @Min BIGINT;
	DECLARE @desc NVARCHAR(148);
	DECLARE @computerName VARCHAR(148);
	DECLARE @ipAddress VARCHAR(14);
	DECLARE @idPost BIGINT;
	DECLARE @locationName NVARCHAR(148);
	DECLARE @locationCountry NVARCHAR(148);
	DECLARE @habitName NVARCHAR(148);
	DECLARE @amount DECIMAL(10, 2);
	DECLARE @FromDate date = '2015-01-01';
	DECLARE @ToDate date = '2019-12-31';
	DECLARE @startDate DATETIME;
	DECLARE @endDate DATETIME;
	DECLARE @merchantName VARCHAR(148);
	DECLARE @paymentStatus VARCHAR(148);
	DECLARE @transactionSubType VARCHAR(148);
	DECLARE @username VARCHAR(256);
	DECLARE @RandData TABLE
	(
		description NVARCHAR(148),
		computerName VARCHAR(148),
		ipAddress VARCHAR(14)
	);

	INSERT INTO @RandData
		(description,computerName,ipAddress)
	VALUES
		('Recycle...', 'iPhone X', '192.168.1.5'),
		('Sponsor habit...', 'Poco M3', '112.148.1.4'),
		('Sponsor electric...', 'Motorola One Vision', '102.16.10.56'),
		('McDonalds...', 'Windows 10', '100.200.54.45'),
		('Lorem ipsum', 'Ubuntu 20.04 LTS', '90.70.54.45'),
		('Lorem ipsum', 'Mac OS', '145.200.23.5');

	WHILE @Cantidad > 0
	BEGIN
		-- Seleccionamos un info de pago aleatoria
		SELECT
			@desc = description,
			@computerName = computerName,
			@ipAddress = ipAddress
		FROM @RandData
		ORDER BY NEWID();
		
		-- Seleccionamos un post aleatorio (para que los datos tengan sentido)
		SELECT
			@Max = MAX(idPost),
			@Min = MIN(idPost)
		FROM dbo.Posts;

		SELECT TOP 1
			@idPost = idPost
		FROM dbo.Posts
		WHERE idPost >= RAND() * (@Max - @Min) + @Min;

		-- Seleccionamos un habito y un location
		SELECT TOP 1
			@locationName = dbo.Locations.name,
			@locationCountry = dbo.Locations.country,
			@habitName = dbo.Habit.title
		FROM dbo.HabitsPerPosts
		INNER JOIN dbo.LocationsPerHabit
			ON dbo.HabitsPerPosts.idLocationPerHabit = dbo.LocationsPerHabit.idLocationsPerHabit
		INNER JOIN dbo.Habit
			ON dbo.Habit.idHabit = dbo.LocationsPerHabit.idHabit
		INNER JOIN dbo.Locations
			ON dbo.Locations.idLocation = dbo.LocationsPerHabit.idLocation
		WHERE idPost = @idPost;

		-- Seleccionamos el precio de puja de ese habito en ese lugar
		SELECT @startDate = CAST(dateadd(day, 
					   rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), 
					   @FromDate) AS DATETIME)

		SELECT @endDate = CAST(dateadd(day, 
					   rand(checksum(newid()))*(1+datediff(day, CAST(@startDate AS DATE), @ToDate)), 
					   @FromDate) AS DATETIME);
		
		EXEC sp_get_price_habit @habitName, @locationCountry, @locationName, @startDate, @endDate, @amount_rst = @amount OUTPUT; 

		-- Obtenemos un usuario aleatorio
		SELECT TOP 1
			@userName = id_user
		FROM dbo.InfoPerSocialMedia
		ORDER BY NEWID();

		-- Datos extras aleatorios para los pagos
		SELECT TOP 1
			@merchantName = name
		FROM dbo.Merchants
		ORDER BY NEWID();

		SELECT TOP 1
			@paymentStatus = status
		FROM dbo.PaymentStatus
		ORDER BY NEWID();

		SELECT TOP 1
			@transactionSubType = name
		FROM dbo.TransactionSubTypes
		ORDER BY NEWID();		

		-- Registramos el pago
		EXEC sp_register_habit_payment @amount, 1, @desc, 2, 
		3, @computerName, @userName, @ipAddress, @merchantName, @paymentStatus,
		@habitName, @locationCountry, @locationName, @transactionSubType, 20, 
		@startDate, @endDate;

		SET @Cantidad = @Cantidad - 1;
	END
END;

-- Fill data para pago de sponsors
-- Este fill data tiene un porcentaje de error, pues, se basa en asumir
-- que en un rango de fechas existe un post, sin embargo, no necesariamente lo hace
DROP PROCEDURE IF EXISTS sp_fill_sponsors_payment;

exec sp_fill_sponsors_payment 500;

SELECT * FROM dbo.SponsorsPayment;
DELETE FROM dbo.PaymentFromAd;
DELETE FROM dbo.SponsorsPayment;

CREATE PROCEDURE sp_fill_sponsors_payment 
	@Cantidad INT
AS
BEGIN
	DECLARE @RandData TABLE
	(
		description NVARCHAR(148),
		computerName VARCHAR(148),
		ipAddress VARCHAR(14)
	);
	DECLARE @amount DECIMAL(10, 2);
	DECLARE @Max BIGINT;
	DECLARE @Min BIGINT;
	DECLARE @desc NVARCHAR(148);
	DECLARE @computerName VARCHAR(148);
	DECLARE @ipAddress VARCHAR(14);
	DECLARE @merchantName VARCHAR(148);
	DECLARE @paymentStatus VARCHAR(148);
	DECLARE @transactionSubType VARCHAR(148);
	DECLARE @username VARCHAR(256);
	DECLARE @postLink VARCHAR(512);
	DECLARE @startSponsor DATETIME;
	DECLARE @endSponsor DATETIME;
	DECLARE @FromDate date = '2015-01-01';
	DECLARE @ToDate date = '2019-12-31';
	DECLARE @postId BIGINT;
	DECLARE @locationName NVARCHAR(148);
	DECLARE @locationCountry NVARCHAR(148);
	DECLARE @habitName NVARCHAR(148);
	-- Aqui estamos diciendo que ChangeIt se va a llevar 20%
	DECLARE @ChangeItPercentage DECIMAL(5, 2) = 20.0;

	INSERT INTO @RandData
		(description,computerName,ipAddress)
	VALUES
		('Recycle...', 'iPhone X', '192.168.1.5'),
		('Sponsor habit...', 'Poco M3', '112.148.1.4'),
		('Sponsor electric...', 'Motorola One Vision', '102.16.10.56'),
		('McDonalds...', 'Windows 10', '100.200.54.45'),
		('Lorem ipsum', 'Ubuntu 20.04 LTS', '90.70.54.45'),
		('Lorem ipsum', 'Mac OS', '145.200.23.5');

	WHILE @Cantidad > 0
	BEGIN
		-- Generamos un amount entre los 1k a 5k dolares
		-- O sea, esto genero un sponsor
		SET @amount = RAND() * (5000 - 1000) + 1000;

		-- Seleccionamos un info de pago aleatoria
		SELECT
			@desc = description,
			@computerName = computerName,
			@ipAddress = ipAddress
		FROM @RandData
		ORDER BY NEWID();

		-- Datos extras aleatorios para los pagos
		SELECT TOP 1
			@merchantName = name
		FROM dbo.Merchants
		ORDER BY NEWID();

		SELECT TOP 1
			@paymentStatus = status
		FROM dbo.PaymentStatus
		ORDER BY NEWID();

		SELECT TOP 1
			@transactionSubType = name
		FROM dbo.TransactionSubTypes
		ORDER BY NEWID();		

		-- Obtenemos un usuario aleatorio
		SELECT TOP 1
			@userName = id_user
		FROM dbo.InfoPerSocialMedia
		ORDER BY NEWID();

		-- Obtenemos fechas aleatorias (coherentes con la progra) para obtener un post
		SELECT @startSponsor = CAST(dateadd(day, 
					   rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), 
					   @FromDate) AS DATETIME)

		SELECT @endSponsor = CAST(dateadd(day, 
					   rand(checksum(newid()))*(1+datediff(day, CAST(@startSponsor AS DATE), @ToDate)), 
					   @FromDate) AS DATETIME);

		-- Obtenemos un post aleatorio que se encuentre en esas fechas
		SELECT TOP 1
			@postId = idPost,
			@postLink = link
		FROM dbo.Posts
		WHERE dbo.Posts.postTime BETWEEN @startSponsor AND @endSponsor;

		-- Seleccionamos un habito que tenga ese post
		SELECT TOP 1
			@locationName = dbo.Locations.name,
			@locationCountry = dbo.Locations.country,
			@habitName = dbo.Habit.title
		FROM dbo.HabitsPerPosts
		INNER JOIN dbo.LocationsPerHabit
			ON dbo.HabitsPerPosts.idLocationPerHabit = dbo.LocationsPerHabit.idLocationsPerHabit
		INNER JOIN dbo.Habit
			ON dbo.Habit.idHabit = dbo.LocationsPerHabit.idHabit
		INNER JOIN dbo.Locations
			ON dbo.Locations.idLocation = dbo.LocationsPerHabit.idLocation
		WHERE idPost = @postId;

		EXEC sp_register_ad_payment @amount, 2, @desc, 1, 0, @computerName, @username, @ipAddress, @merchantName,
			@paymentStatus, @transactionSubType, @postLink, @startSponsor, @endSponsor, @habitName, @locationCountry,
			@locationName, @ChangeItPercentage; 

		SET @Cantidad = @Cantidad - 1;
	END;
END;