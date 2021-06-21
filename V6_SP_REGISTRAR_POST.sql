USE ChangeIt;

DROP PROCEDURE IF EXISTS sp_register_post;

INSERT INTO dbo.PostType
	(type)
VALUES
	('Publicacion'), ('Ad'), ('Resumen');

-- Ese user id corresponde al que da la red social a la app,
-- no es de la tabla
CREATE PROCEDURE sp_register_post
	@SocialMedia NVARCHAR(70),
	@link VARCHAR(512),
	@description NVARCHAR(148),
	@user_id_rs VARCHAR(256),
	@post_type VARCHAR(70),
	@post_time VARCHAR(70),
	@linkAction VARCHAR(512)
AS
BEGIN
	DECLARE @SocialMediaId INT;
	DECLARE @idUser BIGINT;
	DECLARE @idPostType INT;

	SELECT TOP 1
		@SocialMediaId = idSocialMedia
	FROM dbo.SocialMedia
	WHERE dbo.SocialMedia.name = @SocialMedia;

	SELECT TOP 1
		@idUser = us.idUser
	FROM dbo.InfoPerSocialMedia ips
	INNER JOIN dbo.Users us
		ON ips.idUser = us.idUser
	WHERE 
		ips.id_user = @user_id_rs;

	SELECT TOP 1
		@idPostType = idPostType
	FROM dbo.PostType
	WHERE type = @post_type;

	INSERT INTO dbo.Posts
		(idSocialMedia, link, description, idUser, idPostType, postTime, linkAction)
	VALUES
		(@SocialMediaId, @link, @description, @idUser, @idPostType, CAST(@post_time AS DATETIME), @linkAction);
END;

DROP PROCEDURE IF EXISTS sp_get_post;

CREATE PROCEDURE sp_get_post
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad)
		idPost,
		link,
		description,
		postTime,
		linkAction
	FROM dbo.Posts;
END;

CREATE PROCEDURE sp_register_habit_post
	@idPost BIGINT,
	@title NVARCHAR(148)
AS
BEGIN
	DECLARE @idHabit BIGINT
	
	SELECT TOP 1
		@idHabit = idHabit
	FROM dbo.Habit
	WHERE 
		title = @title;

	INSERT INTO dbo.HabitsPerPosts
		(idPost, idHabit)
	VALUES	
		(@idPost, @idHabit);
END