USE master;
GO

DROP DATABASE IF EXISTS StreamersNetwork;
GO

CREATE DATABASE StreamersNetwork;
GO

USE StreamersNetwork;
GO



--�������� ������ �����

CREATE TABLE Streamer
(
StreamerID INT NOT NULL PRIMARY KEY,
StreamerName NVARCHAR(50) NOT NULL,
StreamerAge INT NOT NULL,
) AS NODE;
GO

CREATE TABLE [Platform]
(
PlatformID INT NOT NULL PRIMARY KEY,
PlatformName NVARCHAR(50) NOT NULL,
PlatformDescription NVARCHAR(250) NOT NULL
) AS NODE;
GO

CREATE TABLE Category
(
CategoryID INT NOT NULL PRIMARY KEY,
CategoryName NVARCHAR(50) NOT NULL,
CategoryDescription NVARCHAR(250) NOT NULL
) AS NODE;
GO



--�������� ������ �����

CREATE TABLE Collaboration AS EDGE; 

CREATE TABLE StreamingOn AS EDGE; 

CREATE TABLE SelectCategory AS EDGE; 


--����������� ������ �����

ALTER TABLE Collaboration
ADD CONSTRAINT EC_Collaboration CONNECTION (Streamer TO Streamer);

ALTER TABLE StreamingOn
ADD CONSTRAINT EC_StreamingOn CONNECTION (Streamer TO [Platform]);

ALTER TABLE SelectCategory
ADD CONSTRAINT EC_SelectCategory CONNECTION (Streamer TO Category);
GO



--���������� ������ �����

INSERT INTO Streamer (StreamerID, StreamerName, StreamerAge)
VALUES (1, N'bratishkinoff', 25),
       (2, N'sindics', 27),
	   (3, N'egorkreed', 29),
	   (4, N'shadowkekw', 25),
	   (5, N'kuplinov', 35),
	   (6, N'deepins02', 21),
	   (7, N'tenderlybae', 21),
	   (8, N'mazellovvv', 25);
GO

SELECT *
FROM Streamer;


INSERT INTO [Platform] (PlatformID, PlatformName, PlatformDescription)
VALUES (1, N'YouTube', N'����� ���������� � ���� ���������������� ����, ����������� ��������, ��������� � ������������� ����������� � ������ �����'),
       (2, N'Twitch', N'��������� ��� ��������� �������� � ������ ����������, ������� ��������� ������������� �������� ����� ��������� � �������� �� ��������� � ������ ��������� �������'),
	   (3, N'Kick', N'��������� ���������, ������������� ���� ��� ������ ���������� �������� ��� ���������'),
	   (4, N'Trovo', N'������������� ��������� ��� ���������� �������, ����� ������� ������� �������� ������� � ����������� �������� ����� �������� � ���������������')
GO

SELECT *
FROM [Platform];


INSERT INTO Category (CategoryID, CategoryName, CategoryDescription)
VALUES (1, N'Roblox', N'������������� ��� �������, ��������� � ���������� ����� �������. ����� ��������� �� �������������, � ����� �������� � ����� ����������� � �������� � ���� �������'),
       (2, N'Counter-Strike', N'��������� �������, ��������� � ����������� ������� Counter-Strike. �������� ���������������� �����, ��������� ����, ������ ����� ���� � ������, � ����� ������� � ���������� �� CS'),
	   (3, N'Just Chatting', N'��������� ��� �������, ��� �������� ��������������� � ����������, ������� �����, ������, ��������� �����-���� �������'),
	   (4, N'Minecraft', N'��������� ��� ��������� ���� ���������. ����� �������� ���-�� ����� ��� ����, ���������, ����������� � ������� ����')
GO

SELECT *
FROM Category;


--���������� ������ �����

INSERT INTO Collaboration ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Streamer WHERE StreamerID = 1),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 4)),
       ((SELECT $node_id FROM Streamer WHERE StreamerID = 1),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 8)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 2),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 1)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 2),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 4)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 3),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 6)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 6),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 1)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 6),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 8)),
       ((SELECT $node_id FROM Streamer WHERE StreamerID = 7),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 1)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 7),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 3)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 8),
	     (SELECT $node_id FROM Streamer WHERE StreamerID = 2));
GO

SELECT *
FROM Collaboration


INSERT INTO StreamingOn ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Streamer WHERE StreamerID = 1),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 2)),
       ((SELECT $node_id FROM Streamer WHERE StreamerID = 2),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 1)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 2),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 2)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 3),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 2)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 3),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 3)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 3),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 4)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 4),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 2)),
       ((SELECT $node_id FROM Streamer WHERE StreamerID = 5),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 1)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 5),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 2)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 6),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 2)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 7),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 2)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 7),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 3)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 8),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 2)),
       ((SELECT $node_id FROM Streamer WHERE StreamerID = 8),
	     (SELECT $node_id FROM [Platform] WHERE PlatformID = 4));
GO

SELECT *
FROM StreamingOn


INSERT INTO SelectCategory ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Streamer WHERE StreamerID = 1),
	     (SELECT $node_id FROM Category WHERE CategoryID = 1)),
       ((SELECT $node_id FROM Streamer WHERE StreamerID = 1),
	     (SELECT $node_id FROM Category WHERE CategoryID = 1)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 2),
	     (SELECT $node_id FROM Category WHERE CategoryID = 2)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 2),
	     (SELECT $node_id FROM Category WHERE CategoryID = 3)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 3),
	     (SELECT $node_id FROM Category WHERE CategoryID = 3)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 4),
	     (SELECT $node_id FROM Category WHERE CategoryID = 2)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 4),
	     (SELECT $node_id FROM Category WHERE CategoryID = 3)),
       ((SELECT $node_id FROM Streamer WHERE StreamerID = 5),
	     (SELECT $node_id FROM Category WHERE CategoryID = 3)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 6),
	     (SELECT $node_id FROM Category WHERE CategoryID = 1)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 6),
	     (SELECT $node_id FROM Category WHERE CategoryID = 3)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 6),
	     (SELECT $node_id FROM Category WHERE CategoryID = 4)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 7),
	     (SELECT $node_id FROM Category WHERE CategoryID = 3)),
	   ((SELECT $node_id FROM Streamer WHERE StreamerID = 7),
	     (SELECT $node_id FROM Category WHERE CategoryID = 4)),
       ((SELECT $node_id FROM Streamer WHERE StreamerID = 8),
	     (SELECT $node_id FROM Category WHERE CategoryID = 3));
GO

SELECT *
FROM SelectCategory



--MATCH

--� ��� � bratishkinoff ��� ���������� �����

SELECT Streamer1.StreamerName
, Streamer2.StreamerName AS [ColleagueName]
FROM Streamer AS Streamer1
	, Collaboration
	, Streamer AS Streamer2
WHERE MATCH(Streamer1-(Collaboration)->Streamer2)
AND Streamer1.StreamerName = N'bratishkinoff';

--� ��� ��������� ������ ������ ������� bratishkinoff

SELECT Streamer1.StreamerName + N' ������� � ' + Streamer2.StreamerName AS Level1
	 , Streamer2.StreamerName + N' ������� � ' + Streamer3.StreamerName AS Level2
FROM Streamer AS Streamer1
	, Collaboration AS Colleague1
	, Streamer AS Streamer2
	, Collaboration AS Colleague2
	, Streamer AS Streamer3
WHERE MATCH(Streamer1-(Colleague1)->Streamer2-(Colleague2)->Streamer3)
AND Streamer1.StreamerName = N'bratishkinoff';

--�� ����� ���������� ������� ������� bratishkinoff

SELECT Streamer2.StreamerName AS Streamer
	, [Platform].PlatformName AS [Platform]
FROM Streamer AS Streamer1
	, Streamer AS Streamer2
	, Collaboration
	, [Platform]
	, StreamingOn
WHERE MATCH(Streamer1-(Collaboration)->Streamer2-(StreamingOn)->[Platform])
AND Streamer1.StreamerName = N'bratishkinoff';

--�� ����� ���������� ������� ������� ������ bratishkinoff

SELECT Streamer3.StreamerName AS Streamer
	, [Platform].PlatformName AS [Platform]
FROM Streamer AS Streamer1
	, Streamer AS Streamer2
	, Streamer AS Streamer3
	, Collaboration AS Colleague1
	, Collaboration AS Colleague2
	, [Platform]
	, StreamingOn
WHERE MATCH(Streamer1-(Colleague1)->Streamer2-(Colleague2)->Streamer3-(StreamingOn)->[Platform])
AND Streamer1.StreamerName = N'bratishkinoff';

--�� ����� ��������� �������� ������ ������� bratishkinoff

SELECT Streamer2.StreamerName AS Streamer
	, Category.CategoryName AS Category
FROM Streamer AS Streamer1
	, Streamer AS Streamer2
	, Collaboration
	, Category
	, SelectCategory
WHERE MATCH(Streamer1-(Collaboration)->Streamer2-(SelectCategory)->Category)
AND Streamer1.StreamerName = N'bratishkinoff';



--SHORTEST_PATH

--����������� ��������� ����������� ���� ��� tenderlybae

SELECT Streamer1.StreamerName
	 , STRING_AGG(Streamer2.StreamerName, '->') WITHIN GROUP (GRAPH PATH) AS Colleagues
FROM Streamer AS Streamer1
	, Collaboration FOR PATH AS Co
	, Streamer FOR PATH AS Streamer2
WHERE MATCH(SHORTEST_PATH(Streamer1(-(Co)->Streamer2)+))
	  AND Streamer1.StreamerName = N'tenderlybae';


--� ��� ����� ������ �������� tenderlybae, ������ ���� �� ����� ��� �� 2 ����

SELECT Streamer1.StreamerName
	 , STRING_AGG(Streamer2.StreamerName, '->') WITHIN GROUP (GRAPH PATH) AS Colleagues
FROM Streamer AS Streamer1
	, Collaboration FOR PATH AS Co
	, Streamer FOR PATH AS Streamer2
WHERE MATCH(SHORTEST_PATH(Streamer1(-(Co)->Streamer2){1,2}))
	  AND Streamer1.StreamerName = N'tenderlybae';