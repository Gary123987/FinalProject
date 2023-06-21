-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema journeyjournalsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `journeyjournalsdb` ;

-- -----------------------------------------------------
-- Schema journeyjournalsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `journeyjournalsdb` DEFAULT CHARACTER SET utf8 ;
USE `journeyjournalsdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `password` VARCHAR(200) NOT NULL,
  `about` TEXT NULL,
  `image_url` VARCHAR(5000) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `role` VARCHAR(45) NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `continent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `continent` ;

CREATE TABLE IF NOT EXISTS `continent` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country` ;

CREATE TABLE IF NOT EXISTS `country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `flag_image_url` VARCHAR(3000) NULL,
  `continent_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_country_continent1_idx` (`continent_id` ASC),
  CONSTRAINT `fk_country_continent1`
    FOREIGN KEY (`continent_id`)
    REFERENCES `continent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `destination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `destination` ;

CREATE TABLE IF NOT EXISTS `destination` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(150) NULL,
  `state_province` VARCHAR(2000) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `name` VARCHAR(100) NULL,
  `image_url` VARCHAR(3000) NULL,
  `country_id` INT NOT NULL,
  `description` TEXT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_destination_country1_idx` (`country_id` ASC),
  INDEX `fk_destination_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_destination_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_destination_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `place` ;

CREATE TABLE IF NOT EXISTS `place` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(2000) NULL,
  `street` VARCHAR(2000) NULL,
  `zipcode` VARCHAR(10) NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(5000) NULL,
  `enabled` TINYINT NOT NULL,
  `destination_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_destination1_idx` (`destination_id` ASC),
  INDEX `fk_location_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_location_destination1`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog` ;

CREATE TABLE IF NOT EXISTS `blog` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `trip_start` DATE NULL,
  `trip_end` DATE NULL,
  `image_url` VARCHAR(5000) NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `user_id` INT NOT NULL,
  `place_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blog_user1_idx` (`user_id` ASC),
  INDEX `fk_blog_location1_idx` (`place_id` ASC),
  CONSTRAINT `fk_blog_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blog_location1`
    FOREIGN KEY (`place_id`)
    REFERENCES `place` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL,
  `body` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `user_id` INT NOT NULL,
  `blog_id` INT NOT NULL,
  `inreplyto_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_comment_blog1_idx` (`blog_id` ASC),
  INDEX `fk_comment_comment1_idx` (`inreplyto_id` ASC),
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_blog1`
    FOREIGN KEY (`blog_id`)
    REFERENCES `blog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`inreplyto_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `destination_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `destination_image` ;

CREATE TABLE IF NOT EXISTS `destination_image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(5000) NULL,
  `enabled` TINYINT NOT NULL,
  `destination_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_destination_image_destination1_idx` (`destination_id` ASC),
  INDEX `fk_destination_image_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_destination_image_destination1`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_destination_image_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blog_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog_rating` ;

CREATE TABLE IF NOT EXISTS `blog_rating` (
  `rating_value` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `user_id` INT NOT NULL,
  `blog_id` INT NOT NULL,
  `rating_comment` TEXT NULL,
  PRIMARY KEY (`blog_id`, `user_id`),
  INDEX `fk_rating_user_idx` (`user_id` ASC),
  INDEX `fk_rating_blog1_idx` (`blog_id` ASC),
  CONSTRAINT `fk_rating_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_blog1`
    FOREIGN KEY (`blog_id`)
    REFERENCES `blog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `place_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `place_image` ;

CREATE TABLE IF NOT EXISTS `place_image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(5000) NULL,
  `enabled` TINYINT NOT NULL,
  `place_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_image_location1_idx` (`place_id` ASC),
  INDEX `fk_location_image_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_location_image_location1`
    FOREIGN KEY (`place_id`)
    REFERENCES `place` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_image_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category_has_blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category_has_blog` ;

CREATE TABLE IF NOT EXISTS `category_has_blog` (
  `category_id` INT NOT NULL,
  `blog_id` INT NOT NULL,
  PRIMARY KEY (`category_id`, `blog_id`),
  INDEX `fk_category_has_blog_blog1_idx` (`blog_id` ASC),
  INDEX `fk_category_has_blog_category1_idx` (`category_id` ASC),
  CONSTRAINT `fk_category_has_blog_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_has_blog_blog1`
    FOREIGN KEY (`blog_id`)
    REFERENCES `blog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `place_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `place_rating` ;

CREATE TABLE IF NOT EXISTS `place_rating` (
  `rating_value` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `user_id` INT NOT NULL,
  `place_id` INT NOT NULL,
  `rating_comment` TEXT NULL,
  PRIMARY KEY (`user_id`, `place_id`),
  INDEX `fk_rating_user_idx` (`user_id` ASC),
  INDEX `fk_location_rating_location1_idx` (`place_id` ASC),
  CONSTRAINT `fk_rating_user0`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_rating_location1`
    FOREIGN KEY (`place_id`)
    REFERENCES `place` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_user` ;

CREATE TABLE IF NOT EXISTS `user_has_user` (
  `user_id` INT NOT NULL,
  `followed_user_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `followed_user_id`),
  INDEX `fk_user_has_user_user2_idx` (`followed_user_id` ASC),
  INDEX `fk_user_has_user_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`followed_user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_destination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_destination` ;

CREATE TABLE IF NOT EXISTS `favorite_destination` (
  `destination_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`destination_id`, `user_id`),
  INDEX `fk_destination_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_destination_has_user_destination1_idx` (`destination_id` ASC),
  CONSTRAINT `fk_destination_has_user_destination1`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_destination_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS journeyjournals@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'journeyjournals'@'localhost' IDENTIFIED BY 'journeyjournals';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'journeyjournals'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `about`, `image_url`, `created_at`, `updated_at`, `role`, `enabled`) VALUES (1, 'admin', 'Chip', 'Chipperson', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', NULL, NULL, NULL, NULL, NULL, 1);

COMMIT;

