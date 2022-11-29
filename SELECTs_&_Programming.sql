-- Create function to calculate points for a player (Goals + Assists)
CREATE FUNCTION dbo.getPoints(@playerID int)
RETURNS int AS
BEGIN
	DECLARE @returnValue int -- data type matches "returns" clause
	SELECT @returnValue = Goals + Assists FROM PlayerStats WHERE PlayerID = @playerID
	RETURN @returnValue
END 
GO

-- Business Question 1:
--	What two teams participated in Stanley Cup and who won?
CREATE OR ALTER VIEW StanleyCupResults AS
	SELECT City
	, TeamName
	, ChampionshipStatus 
	FROM Team
	JOIN Championship ON Team.ChampionshipID = Championship.ChampionshipID
Go
-- Explore StanleyCupResults View
SELECT * FROM StanleyCupResults
Go

-- Business Question 2:
---	What player was the leader in points for the Stanley Cup round?
SELECT TOP 1
PlayerFirstName
, PlayerLastName
, Goals
, Assists
, dbo.getPoints(PlayerStats.PlayerID) AS Points
FROM PlayerStats 
JOIN Player ON PlayerStats.PlayerID = Player.PlayerID
ORDER BY 5 DESC

-- Business Question 3:
-- What was the total number of goals scored in the round?
SELECT 
SUM(Goals) AS TotalGoals
FROM PlayerStats
GO

-- Business Question 4:
-- Which players should receive a championship ring? 
CREATE OR ALTER VIEW ChampionshipWinningPlayers AS
	SELECT PlayerFirstName
	, PlayerLastName
	, PlayerNumber
	FROM Player
	JOIN Championship ON Player.ChampionshipID = Championship.ChampionshipID
	WHERE ChampionshipStatus = 'Y'
GO
SELECT * FROM ChampionshipWinningPlayers

-- Business Question 5:
-- Who was the coach of the winning team?
SELECT 
HeadCoachName 
FROM Team 
JOIN Championship ON Championship.ChampionshipID = Team.ChampionshipID 
WHERE ChampionshipStatus = 'Y'
