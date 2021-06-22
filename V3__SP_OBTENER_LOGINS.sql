USE ChangeIt;

DROP PROCEDURE IF EXISTS sp_get_logins;

-- Este SP es solo para hacer las pruebas con los usuarios de jmeter
-- Pues los usuarios ya están previamente registrados
CREATE PROCEDURE sp_get_logins
	@Cantidad INT
AS
BEGIN 
	SELECT TOP (@Cantidad)
		id_user
	FROM dbo.InfoPerSocialMedia
END;