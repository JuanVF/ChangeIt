USE ChangeIt;

-- Datos para testing
DECLARE @spt DATETIME = CAST('2015-09-06 00:00:00.000' AS DATETIME)
DECLARE @ept DATETIME = CAST('2015-10-06 00:00:00.000' AS DATETIME)

exec sp_get_price_habit 'Usar energia solar26693431', 'US', 'SONIC Drive In', @spt, @ept

DROP PROCEDURE IF EXISTS sp_get_price_habit;

CREATE PROCEDURE sp_get_price_habit
	@habitTitle NVARCHAR(148),
	@country NVARCHAR(148),
	@locationName NVARCHAR(148),
	@startDate DATETIME,
	@endDate DATETIME
AS
BEGIN 
	DECLARE @HabitId BIGINT;
	DECLARE @LocationId BIGINT;
	DECLARE @LocationPerHabitId BIGINT;
	DECLARE @amount BIGINT;
	DECLARE @count BIGINT;

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
		@LocationPerHabitId = dbo.LocationsPerHabit.idLocationsPerHabit
	FROM dbo.LocationsPerHabit
	WHERE 
		dbo.LocationsPerHabit.idLocation = @LocationId AND dbo.LocationsPerHabit.idHabit = @HabitId;

	SELECT
		@amount = SUM(dbo.PaymentTransactions.amount),
		@count = COUNT(dbo.PaymentTransactions.amount)
	FROM
		dbo.Sponsors
	INNER JOIN dbo.PaymentTransactions
		ON dbo.PaymentTransactions.referenceID = dbo.Sponsors.idSponsor
	WHERE
		dbo.Sponsors.idLocationsPerHabit = @LocationPerHabitId AND
		dbo.Sponsors.startSponsor BETWEEN @startDate AND @endDate;

	IF @count = 0
		SELECT 
			price
		FROM dbo.Prices
		WHERE dbo.Prices.idLocationPerHabit = @LocationPerHabitId
	ELSE
		SELECT @amount / @count AS price;
END;