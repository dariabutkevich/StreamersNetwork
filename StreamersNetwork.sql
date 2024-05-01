USE master;
GO

DROP DATABASE IF EXISTS StreamersNetwork;
GO

CREATE DATABASE StreamersNetwork;
GO

USE StreamersNetwork;
GO



--Создание таблиц узлов

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



--Создание таблиц ребер

CREATE TABLE Collaboration AS EDGE; 

CREATE TABLE StreamingOn AS EDGE; 

CREATE TABLE SelectCategory AS EDGE; 


--Ограничение таблиц ребер

ALTER TABLE Collaboration
ADD CONSTRAINT EC_Collaboration CONNECTION (Streamer TO Streamer);

ALTER TABLE StreamingOn
ADD CONSTRAINT EC_StreamingOn CONNECTION (Streamer TO [Platform]);

ALTER TABLE SelectCategory
ADD CONSTRAINT EC_SelectCategory CONNECTION (Streamer TO Category);
GO



--Заполнение таблиц узлов

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
VALUES (1, N'YouTube', N'Самый популярный в мире видеохостинговый сайт, позволяющий смотреть, загружать и транслировать видеоролики в прямом эфире'),
       (2, N'Twitch', N'Платформа для стриминга видеоигр и прямых трансляций, которая позволяет пользователям делиться своим геймплеем и общаться со зрителями в режиме реального времени'),
	   (3, N'Kick', N'Потоковая платформа, позиционирует себя как «более свободную» площадку для стримеров'),
	   (4, N'Trovo', N'Интерактивная платформа для потокового вещания, имеет высокий уровень качества стримов и минимальную задержку между зрителем и контентмейкером')
GO

SELECT *
FROM [Platform];


INSERT INTO Category (CategoryID, CategoryName, CategoryDescription)
VALUES (1, N'Roblox', N'Предназначена для стримов, связанных с популярной игрой Роблокс. Можно наблюдать за приключениями, а также узнавать о новых обновлениях и событиях в мире Роблокс'),
       (2, N'Counter-Strike', N'Посвящена стримам, связанным с тактическим шутером Counter-Strike. Проходят профессиональные матчи, стратегии игры, обзоры новых карт и оружия, а также турниры и чемпионаты по CS'),
	   (3, N'Just Chatting', N'Категория для стримов, где стримеры взаимодействуют с аудиторией, смотрят видео, фильмы, обсуждают какие-либо события'),
	   (4, N'Minecraft', N'Категория для любителей игры Майнкрафт. Можно узнавать что-то новое для себя, выживание, приключения в игровом мире')
GO

SELECT *
FROM Category;


--Заполнение таблиц ребер

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

--С кем у bratishkinoff был совместный стрим

SELECT Streamer1.StreamerName
, Streamer2.StreamerName AS [ColleagueName]
FROM Streamer AS Streamer1
	, Collaboration
	, Streamer AS Streamer2
WHERE MATCH(Streamer1-(Collaboration)->Streamer2)
AND Streamer1.StreamerName = N'bratishkinoff';

--С кем проводили прямые потоки коллеги bratishkinoff

SELECT Streamer1.StreamerName + N' стримит с ' + Streamer2.StreamerName AS Level1
	 , Streamer2.StreamerName + N' стримит с ' + Streamer3.StreamerName AS Level2
FROM Streamer AS Streamer1
	, Collaboration AS Colleague1
	, Streamer AS Streamer2
	, Collaboration AS Colleague2
	, Streamer AS Streamer3
WHERE MATCH(Streamer1-(Colleague1)->Streamer2-(Colleague2)->Streamer3)
AND Streamer1.StreamerName = N'bratishkinoff';

--На каких платформах стримят коллеги bratishkinoff

SELECT Streamer2.StreamerName AS Streamer
	, [Platform].PlatformName AS [Platform]
FROM Streamer AS Streamer1
	, Streamer AS Streamer2
	, Collaboration
	, [Platform]
	, StreamingOn
WHERE MATCH(Streamer1-(Collaboration)->Streamer2-(StreamingOn)->[Platform])
AND Streamer1.StreamerName = N'bratishkinoff';

--На каких платформах стримят коллеги коллег bratishkinoff

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

--На какие категории проводят стримы коллеги bratishkinoff

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

--Максимально возможная стримерская сеть для tenderlybae

SELECT Streamer1.StreamerName
	 , STRING_AGG(Streamer2.StreamerName, '->') WITHIN GROUP (GRAPH PATH) AS Colleagues
FROM Streamer AS Streamer1
	, Collaboration FOR PATH AS Co
	, Streamer FOR PATH AS Streamer2
WHERE MATCH(SHORTEST_PATH(Streamer1(-(Co)->Streamer2)+))
	  AND Streamer1.StreamerName = N'tenderlybae';


--С кем может начать стримить tenderlybae, обойдя сеть не более чем на 2 шага

SELECT Streamer1.StreamerName
	 , STRING_AGG(Streamer2.StreamerName, '->') WITHIN GROUP (GRAPH PATH) AS Colleagues
FROM Streamer AS Streamer1
	, Collaboration FOR PATH AS Co
	, Streamer FOR PATH AS Streamer2
WHERE MATCH(SHORTEST_PATH(Streamer1(-(Co)->Streamer2){1,2}))
	  AND Streamer1.StreamerName = N'tenderlybae';