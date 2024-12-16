CREATE TABLE `matches` (
  `Match_id` int NOT NULL,
  `Date` date NOT NULL,
  `Venue` varchar(45) NOT NULL,
  `Team_id 1` int NOT NULL,
  `Team_id 2` int NOT NULL,
  `Result` int NOT NULL,
  PRIMARY KEY (`Match_id`),
  KEY `fk_team_id1_idx` (`Team_id 1`),
  KEY `fk_team_id2_idx` (`Team_id 2`),
  KEY `fk_team_id3_idx` (`Result`),
  CONSTRAINT `fk_team_id1` FOREIGN KEY (`Team_id 1`) REFERENCES `teams` (`Team_Id`),
  CONSTRAINT `fk_team_id2` FOREIGN KEY (`Team_id 2`) REFERENCES `teams` (`Team_Id`),
  CONSTRAINT `fk_team_id3` FOREIGN KEY (`Result`) REFERENCES `teams` (`Team_Id`)
) 