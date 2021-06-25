USE ChangeIt;

DROP PROCEDURE IF EXISTS sp_get_users_locations;

-- Este SP es solo para hacer las pruebas con los usuarios de jmeter
-- Pues los usuarios ya están previamente registrados
CREATE PROCEDURE sp_get_users_locations
AS
BEGIN 
	SELECT
		 lgs.latitude, lgs.longitude, lgs.expire_date, cast (us.email as VARCHAR(256))  FROM dbo.LoginSessions lgs
		 left join dbo.Users us on us.idUser=lgs.idUser
		 Order by expire_date desc
END;

exec sp_get_users_locations
