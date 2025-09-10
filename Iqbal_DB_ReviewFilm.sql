-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DB_ReviewFilm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DB_ReviewFilm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DB_ReviewFilm` DEFAULT CHARACTER SET utf8 ;
USE `DB_ReviewFilm` ;

-- -----------------------------------------------------
-- Table `DB_ReviewFilm`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_ReviewFilm`.`user` (
  `id` CHAR(5) NOT NULL,
  `username` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `password` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_ReviewFilm`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_ReviewFilm`.`profile` (
  `id` CHAR(5) NOT NULL,
  `address` VARCHAR(50) NULL,
  `age` INT NULL,
  `biodata` VARCHAR(50) NULL,
  `user_id` CHAR(5) NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_profile_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_profile_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `DB_ReviewFilm`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_ReviewFilm`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_ReviewFilm`.`review` (
  `id` CHAR(5) NOT NULL,
  `rating` VARCHAR(45) NULL,
  `critics` VARCHAR(100) NULL,
  `user_id` CHAR(5) NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_review_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `DB_ReviewFilm`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_ReviewFilm`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_ReviewFilm`.`genre` (
  `id` CHAR(5) NOT NULL,
  `nama` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_ReviewFilm`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_ReviewFilm`.`movie` (
  `id` CHAR(5) NOT NULL,
  `year` DATE NULL,
  `tittle` VARCHAR(50) NULL,
  `poster` VARCHAR(50) NULL,
  `summary` VARCHAR(50) NULL,
  `review_id` CHAR(5) NOT NULL,
  `review_user_id` CHAR(5) NOT NULL,
  `genre_id` CHAR(5) NOT NULL,
  PRIMARY KEY (`id`, `review_id`, `review_user_id`, `genre_id`),
  INDEX `fk_movie_review1_idx` (`review_id` ASC, `review_user_id` ASC) VISIBLE,
  INDEX `fk_movie_genre1_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_review1`
    FOREIGN KEY (`review_id` , `review_user_id`)
    REFERENCES `DB_ReviewFilm`.`review` (`id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `DB_ReviewFilm`.`genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_ReviewFilm`.`cast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_ReviewFilm`.`cast` (
  `id` CHAR(5) NOT NULL,
  `name` VARCHAR(50) NULL,
  `biodata` VARCHAR(50) NULL,
  `age` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_ReviewFilm`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_ReviewFilm`.`role` (
  `id` CHAR(5) NOT NULL,
  `name` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_ReviewFilm`.`cast_has_movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_ReviewFilm`.`cast_has_movie` (
  `cast_id` CHAR(5) NOT NULL,
  `movie_id` CHAR(5) NOT NULL,
  `role_id` CHAR(5) NOT NULL,
  PRIMARY KEY (`cast_id`, `movie_id`, `role_id`),
  INDEX `fk_cast_has_movie_movie1_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_cast_has_movie_cast1_idx` (`cast_id` ASC) VISIBLE,
  INDEX `fk_cast_has_movie_role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_cast_has_movie_cast1`
    FOREIGN KEY (`cast_id`)
    REFERENCES `DB_ReviewFilm`.`cast` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cast_has_movie_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `DB_ReviewFilm`.`movie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cast_has_movie_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `DB_ReviewFilm`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
