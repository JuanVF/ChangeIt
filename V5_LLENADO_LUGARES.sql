USE ChangeIt;

DECLARE @Lugares TABLE
(
	name NVARCHAR(148), 
	country NVARCHAR(148),
	latitude DECIMAL(10, 8),
	longitude DECIMAL(11, 8),
	population INT
);

DECLARE @Country NVARCHAR(148) = 'US';

INSERT INTO @Lugares 
	(latitude, longitude, name, country, population)
VALUES
	(29.814697, -90.814742, 'SONIC Drive In', @Country, floor(999999*rand())),
	(35.803788,	-83.580553,	'Taco Bell', @Country, floor(999999*rand())),
	(35.782339,	-83.551408, 'Arby''s', @Country, floor(999999*rand())),
	(33.562738,	-84.321143, 'Steak ''n Shake', @Country, floor(999999*rand())),
	(42.368823,	-83.138251, 'Wendy''s', @Country, floor(999999*rand())),
	(42.416819,	-83.180444, 'Burger King', @Country, floor(999999*rand())),
	(33.205722,	-117.288645, 'Chipotle Mexican Grill', @Country, floor(999999*rand())),
	(40.937359,	-72.650142, '7-Eleven', @Country, floor(999999*rand())),
	(31.580721,	-102.891455, 'Dairy Queen', @Country, floor(999999*rand())),
	(41.005682,	-81.555774, 'Mr. Hero', @Country, floor(999999*rand())),
	(32.401088,	-98.790162, 'Golden Chick', @Country, floor(999999*rand())),
	(34.133291,	-117.924566, 'Carl''s Jr', @Country, floor(999999*rand())),
	(41.627298,	-83.502436, 'Rally''s', @Country, floor(999999*rand())),
	(33.955923,	-118.396443, 'Togo''s', @Country, floor(999999*rand()));

INSERT INTO dbo.Locations SELECT * FROM @Lugares

SELECT * FROM dbo.Locations