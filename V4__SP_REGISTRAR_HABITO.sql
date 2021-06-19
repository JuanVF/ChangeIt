USE ChangeIt;

DROP PROCEDURE IF EXISTS sp_register_habit;

-- Este SP es solo para hacer las pruebas con los usuarios de jmeter
-- Pues los usuarios ya están previamente registrados
CREATE PROCEDURE sp_register_habit
	@title NVARCHAR(148),
	@description NVARCHAR(800),
	@imageURL VARCHAR(512)
AS
BEGIN 
	DECLARE @imageId BIGINT;

	BEGIN TRY
		BEGIN TRAN
			INSERT INTO dbo.Images
				(link)
			VALUES
				(@imageURL);

			SET @imageId = @@IDENTITY;

			INSERT INTO dbo.Habit
				(title, description, idImage)
			VALUES
				(@title, @description, @imageId);
		COMMIT;
	END TRY 
	BEGIN CATCH
		ROLLBACK;
	END CATCH
END;