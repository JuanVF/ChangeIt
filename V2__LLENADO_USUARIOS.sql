USE ChangeIt;

DROP PROCEDURE IF EXISTS sp_fill_users;

CREATE PROCEDURE sp_fill_users
	@cantidad INT
AS 
BEGIN
	DECLARE @Usuarios Table
	(
		name NVARCHAR(70),
		lastName NVARCHAR(70),
		birthday DATETIME,
		urlPP VARCHAR(512),
		idGender TINYINT,
		email VARCHAR(256),
		enabled BIT
	);
	
	DECLARE @name NVARCHAR(70);
	DECLARE @lastName NVARCHAR(70);
	DECLARE @birthday DATETIME;
	DECLARE @urlPP VARCHAR(512);
	DECLARE @idGender TINYINT;
	DECLARE @email VARCHAR(256);
	DECLARE @enabled BIT;

	DECLARE @ImageId BIGINT;

	INSERT INTO @Usuarios
		(name, lastName, birthday, urlPP, idGender, email, enabled)
	VALUES
		('Juan', 'Fletes', CAST('07-03-2001 00:00:00' AS datetime), 'https://bit.ly/35ADSob', 1, 'juanvfletes@gmail.com', 1),
		('Tifanny', 'Dias', CAST('02-04-2002 00:00:00' AS datetime), 'https://bit.ly/35AEgmD', 2, 'db5@gmail.com', 1),
		('Gerald', 'Zamora', CAST('04-05-2001 00:00:00' AS datetime), 'https://bit.ly/35D7EbL', 1, 'gzam@gmail.com', 1),
		('Taylor', 'Hernandez', CAST('11-06-2001 00:00:00' AS datetime), 'https://bit.ly/2SBFJ9v', 1, 'thernandez@gmail.com', 1),
		('Daniel', 'Bejarano', CAST('12-14-2001 00:00:00' AS datetime), 'https://bit.ly/3gM9gFk', 1, 'dbejarano@gmail.com', 1),
		('Ale', 'Araya', CAST('01-22-2001 00:00:00' AS datetime), 'https://bit.ly/3zBDQKs', 1, 'aaraya@gmail.com', 1);

	WHILE @cantidad > 0 BEGIN
		SELECT TOP 1
			@name = name, 
			@lastName = lastName,
			@birthday = birthday,
			@urlPP = urlPP,
			@idGender = idGender,
			@email = email,
			@enabled = enabled
		FROM @Usuarios
		ORDER BY newid();

		SET @name = CONVERT(NVARCHAR(70), CONCAT(@name, floor(999999*rand())));
		SET @lastName = CONVERT(NVARCHAR(70), CONCAT(@lastName, floor(999999*rand())));
		
		INSERT INTO dbo.Images
			(link)
		VALUES
			(@urlPP);

		SET @ImageId = @@IDENTITY;

		INSERT INTO dbo.Users
			(name, lastName, birthday, idProfilePicture, idGender, email, enabled)
		VALUES 
			(@name, @lastName, @birthday, @ImageId, @idGender, @email, @enabled);

		SET @cantidad = @cantidad - 1;
	END;
END;

exec sp_fill_users 100000;

SELECT * FROM dbo.Users;