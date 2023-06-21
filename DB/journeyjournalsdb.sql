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
  `image_url` VARCHAR(5000) NULL,
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
  `created_at` DATETIME NOT NULL,
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
  `created_at` DATETIME NOT NULL,
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
-- Table `blog_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blog_category` ;

CREATE TABLE IF NOT EXISTS `blog_category` (
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
-- Table `user_follower`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_follower` ;

CREATE TABLE IF NOT EXISTS `user_follower` (
  `followed_id` INT NOT NULL,
  `follower_id` INT NOT NULL,
  PRIMARY KEY (`followed_id`, `follower_id`),
  INDEX `fk_user_has_user_user2_idx` (`follower_id` ASC),
  INDEX `fk_user_has_user_user1_idx` (`followed_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`followed_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`follower_id`)
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
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `about`, `image_url`, `created_at`, `updated_at`, `role`, `enabled`) VALUES (1, 'admin', 'Chip', 'Chipperson', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Hello there, folks! Allow me to introduce myself—my name is Chip Chipperson. I\'m a one-of-a-kind character with a unique blend of wit, humor, and a dash of mischief. Born and raised in the fictional town of Comedyville, I\'ve made it my mission to bring laughter to people\'s lives through my quick wit and comedic charm.\n\nI\'ve always had a knack for making people laugh, even as a young chipmunk. From my early days of cracking jokes with my family in the treehouse to performing stand-up comedy at the prestigious Acorn Comedy Club, comedy has been my passion and calling. I love to see the joy on people\'s faces and hear their laughter—it\'s music to my ears.\n\nWith my charismatic personality and a clever repertoire of one-liners, I\'ve become a household name in the comedy world. I\'ve had the pleasure of performing at comedy festivals, sold-out theaters, and even headlining my own comedy specials. Whether it\'s on stage, in movies, or on television, I\'m always ready to bring the funny and entertain audiences wherever I go.\n\nBut comedy isn\'t the only thing that defines me. When I\'m not making people chuckle, you can find me exploring the great outdoors. I\'m an avid hiker and camper, always seeking new adventures in the wilderness. There\'s something magical about being surrounded by nature—it helps me recharge and find inspiration for my next comedic masterpiece.\n\nIn addition to my love for nature, I\'m a firm believer in giving back. I actively support various charitable causes, particularly those that focus on providing laughter therapy to children in hospitals. Laughter is a powerful medicine, and if I can bring smiles to the faces of those in need, then I consider it a job well done.\n\nSo, whether you catch me performing on stage, hiking through the woods, or lending a hand to those in need, one thing is for sure—Chip Chipperson is here to brighten your day and keep you laughing. Join me on this wild and hilarious journey, and let\'s spread laughter one joke at a time!', '', '2023-06-21 11:11:11', NULL, 'admin', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `continent`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (1, 'North America', 'North America: North America, the third-largest continent, is a land of vast possibilities and breathtaking natural wonders. From the rugged Rocky Mountains to the stunning coastlines of California, North America\'s landscapes are as diverse as they are awe-inspiring. It is home to iconic landmarks such as the Grand Canyon, Niagara Falls, and the Statue of Liberty. The continent also boasts vibrant cities like New York, Los Angeles, and Toronto, where diverse cultures thrive and innovation flourishes. Whether exploring the wilderness of Alaska, indulging in the vibrant food scene of Mexico, or immersing oneself in the jazz culture of New Orleans, North America offers a myriad of experiences for every taste.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (2, 'South America', 'South America: South America, a continent of vibrant colors and rhythms, is a captivating destination brimming with natural wonders and cultural richness. From the ancient ruins of Machu Picchu in Peru to the awe-inspiring Iguazu Falls on the border of Brazil and Argentina, South America is a playground for adventurers and nature lovers alike. The continent is renowned for its passionate dance forms like the tango and samba, as well as its rich indigenous heritage. Whether exploring the Amazon rainforest, indulging in the flavors of Argentinean cuisine, or immersing oneself in the energetic streets of Rio de Janeiro, South America offers a sensory feast that leaves a lasting impression.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (3, 'Antartica', 'It\'s cold there.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (4, 'Europe', 'Europe: Europe, a continent steeped in history and charm, is a tapestry of picturesque landscapes, fascinating cultures, and architectural wonders. From the romantic canals of Venice to the majestic castles of Scotland, Europe\'s beauty knows no bounds. It is a treasure trove of art, literature, and music, having been the birthplace of renowned artists, philosophers, and composers. With its diverse cuisines, vibrant festivals, and a rich tapestry of languages and traditions, Europe offers a delightful blend of old-world charm and contemporary sophistication, inviting visitors to immerse themselves in its timeless allure.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (5, 'Asia', 'Asia: Asia, the largest and most populous continent, is a captivating blend of ancient traditions and modern marvels. From the iconic Great Wall of China to the bustling streets of Tokyo, Asia boasts a tapestry of diverse cultures, languages, and cuisines. It is a land of contrasts, where serene temples coexist with towering skyscrapers, and tranquil rice paddies meet bustling metropolises. With its rich history, architectural wonders, and breathtaking natural landscapes such as the Himalayas and the tropical beaches of Southeast Asia, Asia offers an endless array of experiences for adventurous travelers.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (6, 'Africa', 'Africa: Africa, the second-largest continent, is a land of diversity and enchantment. From the vast Sahara Desert to the lush rainforests of the Congo Basin, Africa\'s landscapes are breathtaking. It is home to an array of iconic wildlife, including majestic elephants, graceful giraffes, and powerful lions. Rich in culture and history, Africa is a tapestry of vibrant traditions, ancient civilizations, and resilient communities. Whether exploring the bustling markets of Marrakech, embarking on a safari in the Serengeti, or immersing oneself in the rhythmic beats of African music, this continent offers a truly immersive and awe-inspiring experience.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (7, 'Australia', 'Australia: Australia, a vast and diverse continent-country, is a land of awe-inspiring landscapes and unique wildlife. From the iconic Great Barrier Reef to the breathtaking Uluru in the heart of the Outback, Australia\'s natural wonders are unparalleled. It is home to fascinating creatures like kangaroos, koalas, and the elusive platypus. Australia\'s coastal cities, including Sydney and Melbourne, offer a vibrant blend of urban sophistication and laid-back beach culture. With its indigenous heritage, thriving arts scene');

COMMIT;


-- -----------------------------------------------------
-- Data for table `country`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (1, 'United States', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (2, 'Argentina', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (3, 'South Shetland Islands', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (4, 'Germany', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (5, 'Japan', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (6, 'Africa', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (7, 'Queensland', 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (1, 'Los Angeles', 'California', 1, 'Los Angeles', '', 1, 'Los Angeles County, officially the County of Los Angeles (Spanish: Condado de Los Ángeles),[7] and sometimes abbreviated as L.A. County, is the most populous county in the United States, with 9,861,224 residents estimated in 2022.[1] Its population is greater than that of 40 individual U.S. states. Comprising 88 incorporated cities and many unincorporated areas within a total area of 4,083 square miles (10,570 km2), it is home to more than a quarter of Californians and is one of the most ethnically diverse U.S. counties.[8] The county\'s seat, Los Angeles, is the second most populous city in the United States, with about 3.9 million residents. The county government is the largest non state level government entity in the United States, as well as being the home of the American film and television industry, a distinction it has held since the early 20th century, which has given the county global prominence.', 1);
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (2, 'Buenos Aires', 'Buenos Aires Province', 1, 'Buenoes Aires', '', 2, 'Argentina (Spanish pronunciation: [aɾxenˈtina] (listen)), officially the Argentine Republic[A] (Spanish: República Argentina), is a country in the southern half of South America. Argentina covers an area of 2,780,400 km2 (1,073,500 sq mi),[B] making it the second-largest country in South America after Brazil, the fourth-largest country in the Americas, and the eighth-largest country in the world. It shares the bulk of the Southern Cone with Chile to the west, and is also bordered by Bolivia and Paraguay to the north, Brazil to the northeast, Uruguay and the South Atlantic Ocean to the east, and the Drake Passage to the south. Argentina is a federal state subdivided into twenty-three provinces, and one autonomous city, which is the federal capital and largest city of the nation, Buenos Aires. The provinces and the capital have their own constitutions, but exist under a federal system. Argentina claims sovereignty over the Falkland Islands, South Georgia and the South Sandwich Islands, and a part of Antarctica.', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `place`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `place` (`id`, `name`, `street`, `zipcode`, `description`, `image_url`, `enabled`, `destination_id`, `user_id`) VALUES (1, 'Los Angeles', '5th Street', '90068', 'Big sign that says \"Hollywood\"', '', 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `blog` (`id`, `title`, `description`, `trip_start`, `trip_end`, `image_url`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`) VALUES (1, 'Things to do in Los Angeles', 'Hollywood sign', '2023-06-01', '2023-06-16', '', '2023-06-21 11:11:11', NULL, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `category` (`id`, `name`) VALUES (1, 'Outdoors');
INSERT INTO `category` (`id`, `name`) VALUES (2, 'Culture');
INSERT INTO `category` (`id`, `name`) VALUES (3, 'Entertainment');
INSERT INTO `category` (`id`, `name`) VALUES (4, 'Food');
INSERT INTO `category` (`id`, `name`) VALUES (5, 'Music');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `comment` (`id`, `title`, `body`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `inreplyto_id`) VALUES (1, 'Awesome!', 'Great pics! I want to visit one day.', '2023-06-21 11:11:11', NULL, 1, 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `destination_image` (`id`, `image_url`, `enabled`, `destination_id`, `user_id`, `created_at`, `updated_at`) VALUES (1, '', 1, 1, 1, '2023-06-21 11:11:11', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `blog_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `rating_comment`) VALUES (5, '2023-06-21', NULL, 1, 1, 1, 'Love your blog Chip!');

COMMIT;


-- -----------------------------------------------------
-- Data for table `place_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `place_image` (`id`, `image_url`, `enabled`, `place_id`, `user_id`, `created_at`, `updated_at`) VALUES (1, '', 1, 1, 1, '2023-06-21 11:11:11', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `place_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `place_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`, `rating_comment`) VALUES (5, '2023-06-21 11:11:11', NULL, 1, 1, 1, 'Cool!');

COMMIT;

