-- I imported data from excel file into stagging tables

--Inserts from stagging tables
--Championship table
INSERT INTO Championship(ChampionshipStatus)
	SELECT ChampionshipStatus FROM Championship$

-- Game table
INSERT INTO Game (GameDate, GameNumInSeries)
	SELECT GameDate, GameNumInSeries FROM GAME$

-- Team table
INSERT INTO Team (City, TeamName, HeadCoachName, ChampionshipID)
	SELECT City, TeamName, HeadCoachName, ChampionshipID FROM Team$

-- Player table
INSERT INTO Player (PlayerFirstName, PlayerLastName, PlayerNumber, TeamID, ChampionshipID)
SELECT PlayerFirstName, PlayerLastName, PlayerNumber, TeamID, ChampionshipID FROM Player$

-- Roster table
INSERT INTO Roster (GameID, TeamID, PlayerID, ShotsFor, ShotsAgainst, GoalsFor, GoalsAgainst)
	SELECT GameID, TeamID, PlayerID, ShotsFor, ShotsAgainst, GoalsFor, GoalsAgainst FROM Roster$

-- Player Stats table
INSERT INTO PlayerStats (PlayerID, Goals, Assists)
SELECT PlayerID, Goals, Assits FROM PlayerStats$ --typo in excel file under 'Assits'

-- To drop stagging tables once data is inserted
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Roster$')
	BEGIN DROP TABLE Roster$
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PlayerStats$')
	BEGIN DROP TABLE PlayerStats$
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Game$')
	BEGIN DROP TABLE Game$
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Player$')
	BEGIN DROP TABLE Player$
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Team$')
	BEGIN DROP TABLE Team$
END 
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Championship$')
	BEGIN DROP TABLE Championship$
END GO