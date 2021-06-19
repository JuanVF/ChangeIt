USE ChangeIt;

DROP PROCEDURE IF EXISTS sp_register_reaction;

INSERT INTO dbo.Interactions
	(type)
VALUES
	('Like'), ('Share'), ('Comment'), ('Views');

-- Este SP es solo para hacer las pruebas con los usuarios de jmeter
-- Pues los usuarios ya están previamente registrados
CREATE PROCEDURE sp_register_reaction
	@idPost BIGINT,
	@Interaccion VARCHAR(148),
	@value DECIMAL(10, 2),
	@postTime DATETIME,
	@user_id_rs VARCHAR(256)
AS
BEGIN 
	DECLARE @idInteraction INT;
	DECLARE @idUser BIGINT;

	SELECT TOP 1
		@idUser = us.idUser
	FROM dbo.InfoPerSocialMedia ips
	INNER JOIN dbo.Users us
		ON ips.idUser = us.idUser
	WHERE 
		ips.id_user = @user_id_rs;

	SELECT 
		@idInteraction = idInteraction
	FROM dbo.Interactions
	WHERE type = @Interaccion;

	INSERT INTO dbo.BitacoraPosts
		(idPost, idInteraction, value, postTime, idUser)
	VALUES
		(@idPost, @idInteraction, @value, @postTime, @idUser);
END;