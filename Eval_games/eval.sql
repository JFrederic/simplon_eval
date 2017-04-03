
CREATE DATABASE IF NOT EXISTS `eval_games` CHARACTER SET 'utf8';
USE `eval_games` ;

CREATE TABLE IF NOT EXISTS `Players` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `gender`  VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Teams` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `Players_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Teams_Players`
    FOREIGN KEY (`Players_id`)
    REFERENCES `Players` (`id`)
  )
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Leagues` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Games` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `platform` (
  `id` INT NOT NULL  AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS matches (
  `id` int(11) NOT NULL,
  `result` varchar(45) NOT NULL,
  `winner` varchar(45) NOT NULL,
  `player1_id` int(11) NOT NULL,
  `player2_id` int(11) NOT NULL,
  `games_id` int(11) NOT NULL,
  `platform_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_Matches_Player1
    FOREIGN KEY (`player1_id`)
    REFERENCES Players(id),
  CONSTRAINT fk_Matches_Player2
    FOREIGN KEY (`player2_id`)
    REFERENCES Players(id),
  CONSTRAINT fk_Matches_Games
    FOREIGN KEY (`games_id`)
    REFERENCES `Games`(id),
  CONSTRAINT fk_Matches_Platform
    FOREIGN KEY (`platform_id`)
    REFERENCES `platform`(id)
    )
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `rank` (
  `Players_id` INT NOT NULL,
  `Games_id` INT NOT NULL,
  `rank` varchar(45) NOT NULL,
  PRIMARY KEY (`Players_id`,`Games_id`),
  CONSTRAINT `fk_rank_Players_id`
    FOREIGN KEY (`Players_id`)
    REFERENCES `Players`(`id`),
  CONSTRAINT `fk_rank_Games_id`
    FOREIGN KEY (`Games_id`)
    REFERENCES `Games`(`id`)
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Players_teams` (
  `Players_id` INT NOT NULL,
  `Teams_id` INT NOT NULL,
  `date_entry` DATE NOT NULL,
  `date_release` DATE NOT NULL,
  PRIMARY KEY (`Players_id`, `Teams_id`),
  CONSTRAINT `fk_Players_has_Teams_Players`
    FOREIGN KEY (`Players_id`)
    REFERENCES `Players` (`id`),
  CONSTRAINT `fk_Players_has_Teams_Teams`
    FOREIGN KEY (`Teams_id`)
    REFERENCES `Teams` (`id`)
    )
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Games_has_Leagues` (
  `Games_id` INT NOT NULL,
  `Leagues_id` INT NOT NULL,
  PRIMARY KEY (`Games_id`, `Leagues_id`),
  CONSTRAINT `fk_Games_has_Leagues_Games`
    FOREIGN KEY (`Games_id`)
    REFERENCES `Games`(`id`),
  CONSTRAINT `fk_Games_has_Leagues_Leagues`
    FOREIGN KEY (`Leagues_id`)
    REFERENCES `Leagues` (`id`)
  )
ENGINE = InnoDB;
