USE ChangeIt;

exec sp_register_habit_location 'Usar energia solar26693431', 'US', 'SONIC Drive In', 20

DROP PROCEDURE IF EXISTS sp_register_habit_location;

CREATE PROCEDURE sp_register_habit_location
	@habitTitle NVARCHAR(148),
	@country NVARCHAR(148),
	@locationName NVARCHAR(148),
	@price DECIMAL(10, 2)
AS
BEGIN 
	DECLARE @HabitId BIGINT;
	DECLARE @LocationId BIGINT;
	DECLARE @idLocationPerHabit BIGINT;

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
	
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO dbo.LocationsPerHabit
				(idHabit, idLocation)
			VALUES
				(@HabitId, @LocationId);

			SET @idLocationPerHabit = @@IDENTITY;

			INSERT INTO dbo.Prices
				(price, idLocationPerHabit)
			VALUES
				(@price, @idLocationPerHabit);
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH
END;