-- Drop tables if they exist
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Roster')
	BEGIN DROP TABLE Roster
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PlayerStats')
	BEGIN DROP TABLE PlayerStats
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Game')
	BEGIN DROP TABLE Game
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Player')
	BEGIN DROP TABLE Player
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Team')
	BEGIN DROP TABLE Team
END GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Championship')
	BEGIN DROP TABLE Championship
END GO

--Creating tables
-- Championship table
CREATE TABLE Championship(
	ChampionshipID int identity primary key
	, ChampionshipStatus char(1) not null
)GO

-- Game table
CREATE TABLE Game(
	GameID int identity primary key
	, GameDate Date not null
	, GameNumInSeries int not null
)GO

-- Team table
CREATE TABLE Team(
	TeamID int identity primary key
	, City varchar(50) not null
	, TeamName varchar(50) unique not null
	, HeadCoachName varchar(50) unique not null
	, ChampionshipID int foreign key REFERENCES Championship
)GO

-- Player table
CREATE TABLE Player(
	PlayerID int identity primary key
	, PlayerFirstName varchar(50) not null
	, PlayerLastName varchar(50) unique not null
	, PlayerNumber int not null
	, TeamID int foreign key REFERENCES Team
	, ChampionshipID int foreign key REFERENCES Championship
)GO

-- PlayerStats table
CREATE TABLE PlayerStats (
	PlayerStatsID int identity primary key
	, PlayerID int foreign key REFERENCES Player
	, Goals int not null
	, Assists int not null
)GO

-- Roster table
CREATE TABLE Roster (
	RosterID int identity primary key
	, GameID int foreign key REFERENCES Game
	, TeamID int foreign key REFERENCES Team
	, PlayerID int foreign key REFERENCES Player
	, ShotsFor int
	, ShotsAgainst int
	, GoalsFor int
	, GoalsAgainst int
)GO
