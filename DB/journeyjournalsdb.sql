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
  `inreplyto_id` INT NULL DEFAULT NULL,
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
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `about`, `image_url`, `created_at`, `updated_at`, `role`, `enabled`) VALUES (1, 'admin', 'Chip', 'Chipperson', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Hello there, folks! Allow me to introduce myself—my name is Chip Chipperson. I\'m a one-of-a-kind character with a unique blend of wit, humor, and a dash of mischief. Born and raised in the fictional town of Comedyville, I\'ve made it my mission to bring laughter to people\'s lives through my quick wit and comedic charm.\n\nI\'ve always had a knack for making people laugh, even as a young chipmunk. From my early days of cracking jokes with my family in the treehouse to performing stand-up comedy at the prestigious Acorn Comedy Club, comedy has been my passion and calling. I love to see the joy on people\'s faces and hear their laughter—it\'s music to my ears.\n\nWith my charismatic personality and a clever repertoire of one-liners, I\'ve become a household name in the comedy world. I\'ve had the pleasure of performing at comedy festivals, sold-out theaters, and even headlining my own comedy specials. Whether it\'s on stage, in movies, or on television, I\'m always ready to bring the funny and entertain audiences wherever I go.\n\nBut comedy isn\'t the only thing that defines me. When I\'m not making people chuckle, you can find me exploring the great outdoors. I\'m an avid hiker and camper, always seeking new adventures in the wilderness. There\'s something magical about being surrounded by nature—it helps me recharge and find inspiration for my next comedic masterpiece.\n\nIn addition to my love for nature, I\'m a firm believer in giving back. I actively support various charitable causes, particularly those that focus on providing laughter therapy to children in hospitals. Laughter is a powerful medicine, and if I can bring smiles to the faces of those in need, then I consider it a job well done.\n\nSo, whether you catch me performing on stage, hiking through the woods, or lending a hand to those in need, one thing is for sure—Chip Chipperson is here to brighten your day and keep you laughing. Join me on this wild and hilarious journey, and let\'s spread laughter one joke at a time!', 'https://www.cameo.com/cdn-cgi/image/fit=cover,format=auto,width=500,height=500/https://cdn.cameo.com/resizer/iCmwNX0W-57AA029C-F0D3-43E2-A737-807A1C95B83D.jpg', '2023-06-21 11:11:11', NULL, 'admin', 1);
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `about`, `image_url`, `created_at`, `updated_at`, `role`, `enabled`) VALUES (2, 'ItsMadness', 'Ally', 'Law', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Welcome to my travel world! I\'m Ally Law, a passionate adventurer, content creator, and travel enthusiast. From a young age, I\'ve been captivated by the allure of exploration and the thrill of stepping into the unknown. Traveling has become my ultimate passion, and I\'ve made it my mission to inspire others to embrace adventure and discover the wonders of the world.\n\nI believe that travel is not just about ticking off destinations on a map, but about immersing oneself in new cultures, connecting with people from different walks of life, and experiencing the world in a way that broadens our perspectives. Whether it\'s climbing ancient ruins in Machu Picchu, wandering through bustling markets in Marrakech, or diving into the crystal-clear waters of the Maldives, I seek out unique and off-the-beaten-path experiences that ignite my sense of wonder.', 'https://www.famousbirthdays.com/headshots/ally-law-1.jpg', '2023-06-22 07:16:10', NULL, 'user', 1);
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `about`, `image_url`, `created_at`, `updated_at`, `role`, `enabled`) VALUES (3, 'comrade', 'Joseph', 'Pasaye', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Greetings, fellow wanderers! I am Joseph Pasaye, a globetrotting philanthropist, and an ardent explorer. Join me as we traverse the globe, unlocking the secrets that lie beyond the ordinary. Through my adventures, I aim to inspire others to explore, appreciate diverse cultures, and make a positive impact wherever they go. From ancient ruins to bustling metropolises, I seek out destinations that offer a blend of natural beauty, cultural heritage, and unique experiences. Traveling  provides me with an opportunity to connect with local communities, support their endeavors, and promote responsible travel. Let\'s step outside our comfort zones, embrace the unknown, and discover our own remarkable stories. Together, let us cultivate a spirit of adventure, promote sustainability, and leave a positive legacy for future generations of travelers. With me as your guide, let us embark on a transformative journey that transcends boundaries and leaves an indelible mark on our souls.', 'https://images.saymedia-content.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTc0NDc1NDc5NzQxNDQxNjcw/joseph-stalin-quick-facts.jpg', '2023-06-22 06:56:56', NULL, 'admin', 1);
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `about`, `image_url`, `created_at`, `updated_at`, `role`, `enabled`) VALUES (4, 'gfultz', 'Gary', 'Fultz', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'Greetings, fellow travelers! As an avid explorer, I embark on journeys that take me to the far corners of our planet, seeking extraordinary destinations and immersing myself in the diverse tapestry of cultures and landscapes that make our world truly captivating. From tranquil beaches to towering mountain peaks, bustling city streets to remote wilderness, I embrace the thrill of discovery, forging connections with locals, and unearthing hidden gems along the way. Join me on this transformative voyage as we unlock the secrets of our remarkable world, one adventure at a time.\n\n\n\n\n', 'https://www.looper.com/img/gallery/things-you-get-wrong-about-clark-kent/intro-1612453541.jpg', '2023-06-22 06-57-57', NULL, 'admin', 1);
INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `password`, `about`, `image_url`, `created_at`, `updated_at`, `role`, `enabled`) VALUES (5, 'jvanderlaan', 'Jacob', 'Vanderlaan', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 'I just really like travelling. Life\'s a garden, dig it.', 'https://content.internetvideoarchive.com/content/hdphotos/489/000489/000489_448x336_861915_011.jpg', '2023-06-22 05-58-58', NULL, 'admin', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `continent`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (4, 'North America', 'North America, the third-largest continent, is a land of vast possibilities and breathtaking natural wonders. From the rugged Rocky Mountains to the stunning coastlines of California, North America\'s landscapes are as diverse as they are awe-inspiring. It is home to iconic landmarks such as the Grand Canyon, Niagara Falls, and the Statue of Liberty. The continent also boasts vibrant cities like New York, Los Angeles, and Toronto, where diverse cultures thrive and innovation flourishes. Whether exploring the wilderness of Alaska, indulging in the vibrant food scene of Mexico, or immersing oneself in the jazz culture of New Orleans, North America offers a myriad of experiences for every taste.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (6, 'South America', 'South America, a continent of vibrant colors and rhythms, is a captivating destination brimming with natural wonders and cultural richness. From the ancient ruins of Machu Picchu in Peru to the awe-inspiring Iguazu Falls on the border of Brazil and Argentina, South America is a playground for adventurers and nature lovers alike. The continent is renowned for its passionate dance forms like the tango and samba, as well as its rich indigenous heritage. Whether exploring the Amazon rainforest, indulging in the flavors of Argentinean cuisine, or immersing oneself in the energetic streets of Rio de Janeiro, South America offers a sensory feast that leaves a lasting impression.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (7, 'Antarctica', 'It\'s cold.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (3, 'Europe', 'Europe, a continent steeped in history and charm, is a tapestry of picturesque landscapes, fascinating cultures, and architectural wonders. From the romantic canals of Venice to the majestic castles of Scotland, Europe\'s beauty knows no bounds. It is a treasure trove of art, literature, and music, having been the birthplace of renowned artists, philosophers, and composers. With its diverse cuisines, vibrant festivals, and a rich tapestry of languages and traditions, Europe offers a delightful blend of old-world charm and contemporary sophistication, inviting visitors to immerse themselves in its timeless allure.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (2, 'Asia', 'Asia, the largest and most populous continent, is a captivating blend of ancient traditions and modern marvels. From the iconic Great Wall of China to the bustling streets of Tokyo, Asia boasts a tapestry of diverse cultures, languages, and cuisines. It is a land of contrasts, where serene temples coexist with towering skyscrapers, and tranquil rice paddies meet bustling metropolises. With its rich history, architectural wonders, and breathtaking natural landscapes such as the Himalayas and the tropical beaches of Southeast Asia, Asia offers an endless array of experiences for adventurous travelers.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (1, 'Africa', 'Africa, the second-largest continent, is a land of diversity and enchantment. From the vast Sahara Desert to the lush rainforests of the Congo Basin, Africa\'s landscapes are breathtaking. It is home to an array of iconic wildlife, including majestic elephants, graceful giraffes, and powerful lions. Rich in culture and history, Africa is a tapestry of vibrant traditions, ancient civilizations, and resilient communities. Whether exploring the bustling markets of Marrakech, embarking on a safari in the Serengeti, or immersing oneself in the rhythmic beats of African music, this continent offers a truly immersive and awe-inspiring experience.');
INSERT INTO `continent` (`id`, `name`, `description`) VALUES (5, 'Australia', 'Australia, a vast and diverse continent-country, is a land of awe-inspiring landscapes and unique wildlife. From the iconic Great Barrier Reef to the breathtaking Uluru in the heart of the Outback, Australia\'s natural wonders are unparalleled. It is home to fascinating creatures like kangaroos, koalas, and the elusive platypus. Australia\'s coastal cities, including Sydney and Melbourne, offer a vibrant blend of urban sophistication and laid-back beach culture. With its indigenous heritage, thriving arts scene');

COMMIT;


-- -----------------------------------------------------
-- Data for table `country`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (2, 'Angola', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (3, 'Benin', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (4, 'Botswana', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (5, 'Burkina Faso', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (6, 'Burundi', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (7, 'Cabo Verde', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (8, 'Cameroon', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (9, 'Central African Republic', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (10, 'Chad', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (11, 'Comoros', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (12, 'Democratic Republic of the Congo', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (13, 'Republic of the Congo', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (14, 'Cote d\'Ivoire', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (15, 'Djibouti', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (16, 'Egypt', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (17, 'Equatorial Guinea', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (18, 'Eritrea', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (19, 'Eswatini', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (20, 'Ethiopia', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (21, 'Gabon', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (22, 'Gambia', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (23, 'Ghana', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (24, 'Guinea', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (25, 'Guinea-Bissau', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (26, 'Kenya', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (27, 'Lesotho', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (28, 'Liberia', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (29, 'Libya', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (30, 'Madagascar', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (31, 'Malawi', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (32, 'Mali', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (33, 'Mauritania', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (34, 'Mauritius', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (35, 'Morocco', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (36, 'Mozambique', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (37, 'Namibia', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (38, 'Niger', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (39, 'Nigeria', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (40, 'Rwanda', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (41, 'Sao Tome and Principe', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (42, 'Senegal', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (43, 'Seychelles', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (44, 'Sierra Leone', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (45, 'Somalia', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (46, 'South Africa', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (47, 'South Sudan', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (48, 'Sudan', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (49, 'Tanzania', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (50, 'Togo', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (51, 'Tunisia', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (52, 'Uganda', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (53, 'Zambia', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (54, 'Zimbabwe', 1);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (55, 'Afghanistan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (56, 'Armenia', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (57, 'Azerbaijan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (58, 'Bahrain', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (59, 'Bangladesh', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (60, 'Bhutan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (61, 'Brunei', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (62, 'Cambodia', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (63, 'China', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (64, 'Cyprus', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (65, 'Georgia', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (66, 'India', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (67, 'Indonesia', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (68, 'Iran', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (69, 'Iraq', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (70, 'Israel', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (71, 'Japan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (72, 'Jordan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (73, 'Kazakhstan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (74, 'Kuwait', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (75, 'Kyrgyzstan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (76, 'Laos', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (77, 'Lebanon', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (78, 'Malaysia', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (79, 'Maldives', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (80, 'Mongolia', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (81, 'Myanmar (Burma)', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (82, 'Nepal', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (83, 'North Korea', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (84, 'Oman', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (85, 'Pakistan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (86, 'Palestine', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (87, 'Philippines', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (88, 'Qatar', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (89, 'Russia', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (90, 'Saudi Arabia', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (91, 'Singapore', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (92, 'South Korea', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (93, 'Sri Lanka', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (94, 'Syria', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (95, 'Taiwan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (96, 'Tajikistan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (97, 'Thailand', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (98, 'Timor-Leste', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (99, 'Turkey', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (100, 'Turkmenistan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (101, 'United Arab Emirates', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (102, 'Uzbekistan', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (103, 'Vietnam', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (104, 'Yemen', 2);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (105, 'Albania', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (106, 'Andorra', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (107, 'Austria', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (108, 'Belarus', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (109, 'Belgium', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (110, 'Bosnia and Herzegovina', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (111, 'Bulgaria', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (112, 'Croatia', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (113, 'Czech Republic', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (114, 'Denmark', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (115, 'Estonia', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (116, 'Finland', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (117, 'France', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (118, 'Germany', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (119, 'Greece', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (120, 'Hungary', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (121, 'Iceland', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (122, 'Ireland', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (123, 'Italy', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (124, 'Kosovo', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (125, 'Latvia', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (126, 'Liechtenstein', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (127, 'Lithuania', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (128, 'Luxembourg', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (129, 'Malta', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (130, 'Moldova', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (131, 'Monaco', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (132, 'Montenegro', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (133, 'Netherlands', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (134, 'North Macedonia (formerly Macedonia)', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (135, 'Norway', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (136, 'Poland', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (137, 'Portugal', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (138, 'Romania', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (139, 'Russia', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (140, 'San Marino', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (141, 'Serbia', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (142, 'Slovakia', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (143, 'Slovenia', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (144, 'Spain', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (145, 'Sweden', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (146, 'Switzerland', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (147, 'Ukraine', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (148, 'United Kingdom', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (149, 'Vatican City', 3);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (150, 'Antigua and Barbuda', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (151, 'Bahamas', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (152, 'Barbados', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (153, 'Belize', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (154, 'Canada', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (155, 'Costa Rica', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (156, 'Cuba', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (157, 'Dominica', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (158, 'Dominican Republic', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (159, 'El Salvador', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (160, 'Grenada', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (161, 'Guatemala', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (162, 'Haiti', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (163, 'Honduras', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (164, 'Jamaica', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (165, 'Mexico', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (166, 'Nicaragua', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (167, 'Panama', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (168, 'Saint Kitts and Nevis', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (169, 'Saint Lucia', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (170, 'Saint Vincent and the Grenadines', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (171, 'Trinidad and Tobago', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (172, 'United States of America', 4);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (173, 'Australia', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (174, 'Fiji', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (175, 'Kiribati', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (176, 'Marshall Islands', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (177, 'Micronesia', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (178, 'Nauru', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (179, 'New Zealand', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (180, 'Palau', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (181, 'Papua New Guinea', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (182, 'Samoa', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (183, 'Solomon Islands', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (184, 'Tonga', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (185, 'Tuvalu', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (186, 'Vanuatu', 5);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (187, 'Argentina', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (188, 'Bolivia', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (189, 'Brazil', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (190, 'Chile', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (191, 'Colombia', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (192, 'Ecuador', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (193, 'Guyana', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (194, 'Paraguay', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (195, 'Peru', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (196, 'Suriname', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (197, 'Uruguay', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (198, 'Venezuela', 6);
INSERT INTO `country` (`id`, `name`, `continent_id`) VALUES (1, 'Antarctica', 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (1, 'Los Angeles', 'California', 1, 'Los Angeles', 'https://media.timeout.com/images/105718842/750/422/image.jpg', 172, 'Los Angeles County, officially the County of Los Angeles, and sometimes abbreviated as L.A. County, is the most populous county in the United States, with 9,861,224 residents estimated in 2022. Its population is greater than that of 40 individual U.S. states. Comprising 88 incorporated cities and many unincorporated areas within a total area of 4,083 square miles, it is home to more than a quarter of Californians and is one of the most ethnically diverse U.S. counties. The county\'s seat, Los Angeles, is the second most populous city in the United States, with about 3.9 million residents. The county government is the largest non state level government entity in the United States, as well as being the home of the American film and television industry, a distinction it has held since the early 20th century, which has given the county global prominence.', 1);
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (2, 'Buenos Aires', 'Buenos Aires Province', 1, 'Buenoes Aires', 'https://www.livelikeitstheweekend.com/wp-content/uploads/2020/03/Is-Buenos-Aires-Safe-13-700x875.jpg', 187, 'Argentina (Spanish pronunciation: [aɾxenˈtina]), officially the Argentine Republic (Spanish: República Argentina), is a country in the southern half of South America. Argentina covers an area of 2,780,400 km2 (1,073,500 sq mi), making it the second-largest country in South America after Brazil, the fourth-largest country in the Americas, and the eighth-largest country in the world. It shares the bulk of the Southern Cone with Chile to the west, and is also bordered by Bolivia and Paraguay to the north, Brazil to the northeast, Uruguay and the South Atlantic Ocean to the east, and the Drake Passage to the south. Argentina is a federal state subdivided into twenty-three provinces, and one autonomous city, which is the federal capital and largest city of the nation, Buenos Aires. The provinces and the capital have their own constitutions, but exist under a federal system. Argentina claims sovereignty over the Falkland Islands, South Georgia and the South Sandwich Islands, and a part of Antarctica.', 1);
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (3, 'Lerwick', 'South Shetland Islands', 1, 'South Shetland Islands', 'https://www.coolantarctica.com/pics-slider/ravas51-CC-BY-SA-2-slider.jpg', 1, 'Centred 123 miles off the north coast of the Scottish mainland and on the east coast of the Shetland Mainland, Lerwick lies 211 miles north-by-northeast of Aberdeen; 222 miles west of the similarly sheltered port of Bergen in Norway; and 228 miles south east of Tórshavn in the Faroe Islands. One of the UK\'s coastal weather stations is situated there, with the local climate having small seasonal variation due to the maritime influence. Being located further north than Saint Petersburg and the three mainland Nordic capitals, Lerwick\'s nights in the middle of summer only get dark twilight and winters have below six hours of complete daylight.', 1);
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (4, 'Sydney', 'New South Wales', 1, 'Sydney', 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/11/07/16/sydney-overview.jpg', 173, 'Sydney is the largest and most populous city in Australia and the state capital of New South Wales. Sydney is located on Australia\'s south-east coast of the Tasman Sea. Inhabitants of Sydney are called Sydneysiders, comprising a cosmopolitan and international population of people from numerous places around the world.\nThe city is built on hills surrounding Port Jackson which is commonly known as Sydney Harbour, where the iconic Sydney Opera House and the Harbour Bridge feature prominently. The hinterland of the metropolitan area is surrounded by national parks, and the coastal regions feature many bays, rivers, inlets and beaches including the famous Bondi Beach.', 4);
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (5, 'Chiang Mai', 'Nakomping', 1, 'Chiang Mai', 'https://cdn.britannica.com/07/192407-050-548620BE/Sunset-view-Chiang-Mai-Thailand.jpg', 97, 'Chiang Mai, also spelled Chiengmai, largest city in northern Thailand and the third largest city in the nation after metropolitan Bangkok and Nakhon Ratchasima. It is located on the Ping River, a major tributary of the Chao Phraya River, near the centre of a fertile intermontane basin at an elevation of 1,100 feet. It serves as the religious, economic, cultural, educational, and transportation centre for both northern Thailand and part of neighbouring Myanmar (Burma). Once the capital of an independent kingdom, the city also has strong cultural ties with Laos.  The settlement, founded as a royal residence in 1292 and as a town in 1296, served as the capital of the Lanna Thai kingdom until 1558, when it fell to the Myanmar. In 1774 the Siamese king Taksin drove out the Myanmar; but Chiang Mai retained a degree of independence from Bangkok until the late 19th century.', 5);
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (6, 'Moscow', 'Kitay Gorod', 1, 'Moscow', 'https://images.skyscrapercenter.com/uploads/Moscow_Moscow-City-2017_(CC__BY)Deensel210126-020103.jpg', 139, 'Moscow is the capital city and the most populous federal subject of Russia. The city is a major political, economic, cultural and scientific center in Russia and in Eastern Europe. According to Forbes 2013, Moscow has been ranked as the ninth most expensive city in the world by Mercer and is one of the world\'s largest urban economies, being ranked as an alpha global city according to the Globalization and World Cities Research Network and is also one of the fastest growing tourist destinations in the world according to the MasterCard Global Destination Cities Index. Moscow is the northernmost and coldest megacity and metropolis on Earth, one of the most populous in Europe and the 8th largest city proper in the world, as well as the largest amongst high income economies. It is home to the Ostankino Tower, the tallest free standing structure in Europe; Mercury City Tower, the tallest skyscraper in Europe and the Moscow International Business Center. It is the largest city in Russia, with a population of 12,197,596 people (2015). By its territorial expansion on 1 July 2012 southwest into the Moscow Oblast, the capital increased its area 2.5 times; from about 1,000 square kilometres up to 2,511 square kilometres, and gained an additional population of 233,000 people.', 3);
INSERT INTO `destination` (`id`, `city`, `state_province`, `enabled`, `name`, `image_url`, `country_id`, `description`, `user_id`) VALUES (7, 'Berlin', 'Brandenburg', 1, 'Berlin', 'https://www.aljazeera.com/wp-content/uploads/2016/02/0509fc09e2cb4cf9ac675aca77e39cd2_18.jpeg?resize=770%2C513&quality=80', 118, 'In fact, the city is best known for its striking contrasts. Historical buildings stand alongside modern architecture as the past and present intermingle. The sights Berlin has to offer, from the Brandenburg Gate to the Chancellor\'s Office, bear witness to the history of an entire nation. Germany\'s capital is home to all the main government buildings, including the historical Reichstag building as the seat of the German parliament.\n\nBerlin is the city of art, artists and museums. In fact, precious artefacts from all over the world are showcased at more than 170 museums here, some of which can be found on the internationally renowned Museum Island. Berlin is a popular destination for classical music fans from every corner of the globe thanks to its leading orchestras, such as the globally popular Berlin Philharmonic, and the city\'s three huge opera houses, where spectacular operas and ballets are performed. And there is no end of theatre venues specialising in variety performances, revue, cabaret and more to ensure that there is something to keep everyone entertained.', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `place`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `place` (`id`, `name`, `street`, `zipcode`, `description`, `image_url`, `enabled`, `destination_id`, `user_id`) VALUES (1, 'Hollywood Sign', '5th Street', '90068', 'The Hollywood Sign is an American landmark and cultural icon overlooking Hollywood, Los Angeles, California. Originally the Hollywoodland Sign, it is situated on Mount Lee, in the Beachwood Canyon area of the Santa Monica Mountains. Spelling out the word “HOLLYWOOD” in 50-foot-tall (15.2 m) white uppercase letters and 450 feet (137.2 m) long, it was originally erected in 1923 as a temporary advertisement for a local real estate development, but due to increasing recognition the sign was left up, and replaced in 1978 with a more durable all-steel structure.', 'https://wallpapers.com/images/featured-full/hollywood-sign-background-qnufrpnpkgsvy3cc.jpg', 1, 1, 1);
INSERT INTO `place` (`id`, `name`, `street`, `zipcode`, `description`, `image_url`, `enabled`, `destination_id`, `user_id`) VALUES (2, 'Plaza de la República', 'Corrients Avenue', '1865', 'Located at the intersection of two of the city’s most important avenues, 9 de Julio Avenue and Corrientes Avenue, this will be one of the first postcards that you will recognise when you get to the city center coming from the international airport. \n\nIt was built to mark the 4th centenary of the city’s first foundation, and it also marks the spot where the Argentine national flag was raised in the city for the first time. It was designed by the Argentine architect Alberto Prebisch and it is 67m high. \n\nThe obelisk is much more than a symbolic icon of the city: it is also a strategic spot for everything from sporting celebrations to political demonstrations. ', 'https://fh-sites.imgix.net/sites/3006/2022/04/21152126/obelisk-in-buenos-aires.jpg', 1, 2, 2);
INSERT INTO `place` (`id`, `name`, `street`, `zipcode`, `description`, `image_url`, `enabled`, `destination_id`, `user_id`) VALUES (3, 'Penguin Island', 'Bridgeman Street', '447769', 'The South Shetland Islands are a group of Antarctic islands with a total area of 3,687 km2 (1,424 sq mi). They lie about 120 kilometres north of the Antarctic Peninsula, and between 430 and 900 km southwest of the nearest point of the South Orkney Islands. By the Antarctic Treaty of 1959, the islands\' sovereignty is neither recognized nor disputed by the signatories and they are free for use by any signatory for non-military purposes.  The islands have been claimed by the United Kingdom since 1908 and as part of the British Antarctic Territory since 1962. They are also claimed by the governments of Chile (since 1940, as part of the Antártica Chilena province) and Argentina (since 1943, as part of Argentine Antarctica, Tierra del Fuego Province).  Several countries maintain research stations on the islands. Most of them are situated on King George Island, benefitting from the airfield of the Chilean base Eduardo Frei.  Sixteen research stations are in different parts of the islands, with Chilean stations being the greatest in number.', 'https://www.joannamaclean.com/wp-content/uploads/2020/02/Antarc_blog_52.jpg', 1, 3, 1);
INSERT INTO `place` (`id`, `name`, `street`, `zipcode`, `description`, `image_url`, `enabled`, `destination_id`, `user_id`) VALUES (4, 'Sydney Opera House', 'Bennelong Point', '4274', 'A masterpiece of architecture, the Sydney Opera House is one of the world’s most famous buildings. You can take a photo on the steps of the Opera House, explore it majestic exterior and splendid interior on daily tours, and enjoy performances held under its iconic white sails.\n\nOn the edge of Sydney Harbour, one of the world’s great natural harbours, the Sydney Opera House is a UNESCO World Heritage site. It was evaluated as “one of the indisputable masterpieces of human creativity, not only in the 20th century but in the history of humankind”.\n\nThe Sydney Opera House hosts 1,600 performances every year including ballet, opera, theatre, dance, music and comedy as well as children’s shows and more. You can combine shows with delicious food at the Opera Kitchen and Bennelong Restaurant, or enjoy pre-show drinks at the Opera Bar.', 'https://images.strang-inc.com/wp-content/uploads/2019/04/01193109/Sydenyopera.jpg', 1, 4, 4);
INSERT INTO `place` (`id`, `name`, `street`, `zipcode`, `description`, `image_url`, `enabled`, `destination_id`, `user_id`) VALUES (5, 'Wat Phra That Doi Suthep', 'Route 1004', '50200', 'Wat Phra That Doi Suthep (widely known as just Wat Doi Suthep) holds the title of the most-visited, most famous, and most highly revered temple in Chiang Mai. The journey up the winding mountain road to the entrance is an experience in itself, whether you’re doing it on a rented scooter, as part of a private excursion or sitting in a packed-out songthaew with the locals. The final leg of the journey requires you to climb 309 steps up to reach the 600-year-old golden chedi at the top, which towers above the surrounding temple building, the monks’ living quarters and the city of Chiang Mai.', 'https://a.cdn-hotels.com/gdcs/production9/d679/184d7edf-5c3a-470c-8529-b0085d6d5b0e.jpg', 1, 5, 5);
INSERT INTO `place` (`id`, `name`, `street`, `zipcode`, `description`, `image_url`, `enabled`, `destination_id`, `user_id`) VALUES (6, 'The Red Square', 'Krasnaya ploshchad', '103132', 'Red Square (Russian: Красная площадь, romanized: Krasnaya ploshchad\', IPA: [ˈkrasnəjə ˈploɕːɪtʲ]) is one of the oldest and largest squares in Moscow, the capital of Russia. Owing to its historical significance and the adjacent historical buildings, it is regarded as one of the most notable and important squares in Europe and the world. It is located in Moscow\'s historic centre, in the eastern walls of the Kremlin. It is the city landmark of Moscow, with famous buildings such as Saint Basil\'s Cathedral, Lenin\'s Mausoleum and the GUM. In addition, it has been a UNESCO World Heritage Site since 1990.', 'https://expatexplore.com/blog/wp-content/uploads/2016/11/red-square-russia-europe-explore-expat.jpg', 1, 6, 3);
INSERT INTO `place` (`id`, `name`, `street`, `zipcode`, `description`, `image_url`, `enabled`, `destination_id`, `user_id`) VALUES (7, 'Löwenbräu', '32nd straße', '10115', 'Wiggerl Hagn, who ran the tent of the Löwen brewery until 2018, was the most senior landlord at Oktoberfest. Even before taking over the Löwenbräuzelt in 1979, his family served Oktoberfest visitors at Schützenzelt from 1953 on. In 2019, his daughter who has already been his official co-host for years, fully took over after The tent’s longest-serving employee, however, greets his guests even longer: since 1949 a lion above the main entrance has been making sure, that everyone knows, they are drinking “Löööööwenbräääääu”.\n\nThe essential look of the tent dates back to 1956, the current building was constructed in 1999. Unfortunately, the traditional paintings on the front were replaced by large windows in 2012. Fortunately, in 2016 a slightly modified facade premiered, at least removing the shabby shutters. Also, the tower was rebuilt in the same year. In 2011 the 16500 light bulbs illuminating the interior were replaced by LEDs.\n\nThe Löwenbräu-Festzelt is very popular among tourists. If you are looking for international party people, you may want to give it a shot. In the evening, the music is almost exclusively English-speaking. At times, it may resemble an English pub more than a beer tent.', 'https://www.oktoberfestticketsmunich.com/wp-content/uploads/2015/04/lowen.jpg', 1, 7, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `blog` (`id`, `title`, `description`, `trip_start`, `trip_end`, `image_url`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`) VALUES (1, 'Things to do in Los Angeles', 'Hollywood sign', '2023-06-01', '2023-06-16', 'https://wallpapers.com/images/featured-full/hollywood-sign-background-qnufrpnpkgsvy3cc.jpg', '2023-06-21 11:11:11', NULL, 1, 1, 1);
INSERT INTO `blog` (`id`, `title`, `description`, `trip_start`, `trip_end`, `image_url`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`) VALUES (2, 'Buenos Aires Unveiled: A Captivating Journey into the Heart of Argentina', 'Intro:\nWelcome, fellow travelers, to my captivating journey through the enchanting streets of Buenos Aires. Join me as I delve into the vibrant culture, savor the delectable flavors, and immerse myself in the passionate rhythms of this remarkable city. From the moment I stepped foot on its soil, Buenos Aires cast its spell on me, revealing a tapestry of history, art, and captivating energy that left an indelible mark on my soul.\n\nExploring the Neighborhoods:\nI began my adventure by wandering through the diverse neighborhoods that give Buenos Aires its distinct character. The cobblestone streets of San Telmo transported me back in time, with its charming colonial buildings, bohemian atmosphere, and the lively Sunday market, where tango dancers swirled to the melancholic tunes. Palermo captivated me with its trendy cafes, boutique shops, and sprawling parks, where locals gathered to enjoy lazy afternoons and vibrant nightlife. Recoleta, with its elegant architecture and iconic cemetery, offered a glimpse into the city\'s aristocratic past, while La Boca\'s colorful houses and the famed Caminito street ignited my senses with their lively hues.\n\nThe Passionate Tango:\nNo visit to Buenos Aires would be complete without experiencing the soul-stirring passion of the tango. I found myself drawn to the intimate milongas, where locals and visitors alike danced the night away, their movements an expression of raw emotion and connection. From the nostalgic melodies of traditional tango to the modern interpretations, the dance enveloped me in its intoxicating embrace, leaving me with a newfound appreciation for this art form that is so deeply ingrained in the city\'s identity.\n\nCultural Riches:\nBuenos Aires is a treasure trove of cultural delights, and I eagerly immersed myself in its offerings. The magnificent Teatro Colon, with its grandeur and acoustics, transported me to a world of captivating performances. Museo Nacional de Bellas Artes showcased a stunning collection of Latin American and European art, while the vibrant street art of Palermo and Villa Crespo unveiled the city\'s contemporary creative spirit. The literary charm of El Ateneo Grand Splendid, a former theater transformed into a bookstore, invited me to lose myself in its pages amidst the opulence of its surroundings.\n\nCulinary Delights:\nEvery corner of Buenos Aires tantalized my taste buds with its culinary delights. From sizzling asados (barbecues) and mouthwatering empanadas to the aromatic mate tea, I indulged in the flavors that define Argentine cuisine. Local parrillas (steakhouses) satisfied my carnivorous cravings with their perfectly grilled cuts of meat, while the enticing aromas of fresh pastries lured me into the charming cafés for a dose of medialunas (croissants) and café con leche.\n\nEpilogue:\nAs I bid farewell to Buenos Aires, my heart overflowed with gratitude for the unforgettable experiences, warm hospitality, and the deep sense of connection I had forged with this remarkable city. Buenos Aires had truly opened its doors and shared its soul with me, leaving me forever captivated by its charm, its people, and the passionate embrace of the tango. Until we meet again, Buenos Aires, I carry your spirit within me, forever longing to return to the enchantment you bestowed upon me.', '2023-05-05', '2023-05-22', 'https://fh-sites.imgix.net/sites/3006/2022/04/21152126/obelisk-in-buenos-aires.jpg', '2023-06-22 06:33:01', NULL, 1, 2, 2);
INSERT INTO `blog` (`id`, `title`, `description`, `trip_start`, `trip_end`, `image_url`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`) VALUES (3, 'Exploring the Enchanting South Shetland Islands: A Polar Paradise', 'The allure of untouched wilderness, breathtaking landscapes, and incredible wildlife has always fascinated adventurers from around the world. Nestled in the Southern Ocean, the South Shetland Islands form an archipelago that serves as the gateway to Antarctica, offering an unparalleled experience for those seeking an encounter with the pristine beauty of the polar region. Join me as I recount my awe-inspiring journey to the South Shetland Islands, a place where nature reigns supreme and the spirit of exploration is truly alive.\n\nA Gateway to Antarctica:\nAs our expedition ship sailed through the notorious Drake Passage, the anticipation grew. The South Shetland Islands, located just off the Antarctic Peninsula, were our first introduction to the mesmerizing world of ice and wonder. These volcanic islands, with their jagged peaks and icy shores, provided an ideal introduction to the unique environment that awaited us further south.\n\nMajestic Landscapes:\nThe South Shetland Islands boast a landscape that defies imagination. As we approached the islands, towering glaciers and ice cliffs greeted us, their icy blue hues contrasting against the stark white of the snow-covered peaks. The pristine beauty of these landscapes left us in awe, as if we had stepped foot into another world entirely. We explored the breathtaking ice formations, wandered along windswept beaches, and marveled at the dramatic fjords that carved their way through the rugged terrain.\n\nWildlife Encounters:\nOne of the most captivating aspects of the South Shetland Islands is the abundance of wildlife that call this region home. From the moment we disembarked, we were surrounded by an array of captivating creatures. Adorable chinstrap and gentoo penguins waddled along the shores, their playful antics a constant source of entertainment. Massive elephant seals lounged lazily on the beaches, their deep roars reverberating through the air. And the graceful albatrosses soared overhead, their wingspan leaving us in awe.\n\nResearch Stations and Human Presence:\nThe South Shetland Islands also provide a glimpse into the human exploration and scientific research that takes place in Antarctica. Several research stations, operated by different countries, dot the islands. These bases serve as vital hubs for scientific study, allowing researchers to unravel the mysteries of the polar region. Visiting these stations, we gained insight into the challenges faced by scientists working in this extreme environment and their efforts to understand and protect the delicate Antarctic ecosystem.\n\nEnvironmental Sensitivity and Conservation:\nOur journey to the South Shetland Islands highlighted the importance of environmental sensitivity and conservation in this fragile region. The effects of climate change were unmistakable, as melting glaciers and shrinking sea ice serve as stark reminders of the urgent need for action. It is crucial for visitors and explorers to approach this pristine environment with respect and prioritize sustainable practices, ensuring the preservation of this unique ecosystem for generations to come.\n\nConclusion:\nMy visit to the South Shetland Islands was a transformative experience, immersing me in the awe-inspiring beauty of Antarctica and deepening my understanding of our planet\'s delicate ecosystems. From the striking landscapes and captivating wildlife encounters to the research stations and environmental consciousness, every aspect of this journey was a testament to the grandeur and fragility of the polar region. The South Shetland Islands, with their untouched wilderness and raw natural beauty, have etched an indelible memory in my heart—a reminder of the power and importance of safeguarding our planet\'s last frontiers.', '2023-04-01', '2023-04-07', 'https://www.joannamaclean.com/wp-content/uploads/2020/02/Antarc_blog_52.jpg', '2023-04-08 06:33:33', NULL, 1, 1, 3);
INSERT INTO `blog` (`id`, `title`, `description`, `trip_start`, `trip_end`, `image_url`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`) VALUES (4, 'Unveiling the Majestic Sydney Opera House: A Cultural Marvel', 'A Striking Architectural Masterpiece:\nApproaching the Sydney Opera House, I was instantly captivated by its striking design. The soaring sail-like roofs, envisioned by Danish architect Jørn Utzon, create an awe-inspiring silhouette against the backdrop of the glistening harbor. As I ventured closer, I marveled at the intricacy of the white ceramic tiles that adorn the exterior, a testament to the craftsmanship that went into bringing this vision to life.\n\nImmersion in Art and Culture:\nStepping inside the Sydney Opera House was like entering a sanctuary of artistic brilliance. The venue is home to multiple performance spaces, including the iconic Concert Hall, Drama Theatre, and Opera Theatre. During my visit, I had the privilege of attending a mesmerizing performance by a world-class orchestra. The acoustics of the Concert Hall were flawless, allowing every note to resonate with unparalleled clarity and fill the air with pure magic.\n\nBehind the Scenes: Guided Tour:\nTo gain deeper insights into the Opera House\'s history and inner workings, I joined a guided tour that took me behind the scenes. As I walked through the hallowed halls, the knowledgeable guide shared fascinating anecdotes about the construction process and the challenges faced during its creation. I was able to peek into the rehearsal rooms, admire the elaborate stage machinery, and even stand on the iconic Concert Hall stage—a truly humbling experience.\n\nUnforgettable Views:\nThe Sydney Opera House not only offers artistic experiences but also breathtaking views of the harbor and the city skyline. I climbed the steps to the Opera House\'s elevated terrace and was rewarded with a panoramic vista that took my breath away. The sparkling waters of Sydney Harbour stretched before me, the Harbor Bridge framing the scene, and the vibrant cityscape providing a vibrant backdrop—an ideal spot for capturing postcard-perfect memories.\n\nA Hub of Cultural Offerings:\nBeyond its renowned performances, the Sydney Opera House serves as a vibrant hub for cultural activities. From art exhibitions and photography displays to talks and workshops, there is always something captivating happening within its walls. I had the opportunity to immerse myself in an interactive art installation and engage with artists, further deepening my connection to the creative pulse that thrives within this cultural icon.\n\nConclusion:\nMy visit to the Sydney Opera House was a truly unforgettable experience, allowing me to revel in the intersection of architectural brilliance, artistic expression, and cultural vibrancy. The grandeur of its design, the power of its performances, and the richness of its history combine to create an atmosphere that resonates with creativity and inspiration. The Sydney Opera House stands as a testament to the transformative power of the arts and the enduring legacy of human achievement. It is a place where dreams take flight and where the beauty of our shared cultural heritage finds its voice.', '2023-05-27', '2023-06-09', 'https://images.strang-inc.com/wp-content/uploads/2019/04/01193109/Sydenyopera.jpg', '2023-05-09 09:11:01', NULL, 1, 4, 4);
INSERT INTO `blog` (`id`, `title`, `description`, `trip_start`, `trip_end`, `image_url`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`) VALUES (5, 'Exploring the Enchanting Cultural Hub of Northern Thailand', 'Nestled among misty mountains and verdant landscapes, Chiang Mai in northern Thailand exudes a charm and allure that captivates the hearts of travelers. Join me as I embark on a journey to this enchanting city, where ancient temples, vibrant markets, and rich traditions converge, creating an experience that is both awe-inspiring and soul-nourishing.\n\nTemple Tranquility:\nChiang Mai boasts over 300 temples, each with its own unique character and architectural splendor. From the revered Wat Phra That Doi Suthep, perched on a mountainside with panoramic views, to the serene Wat Chedi Luang, housing the famous Emerald Buddha, these sacred sites transport visitors to a realm of peace and spiritual introspection. Exploring the intricate designs, witnessing monks in prayer, and feeling the serenity of these hallowed grounds is an experience that touches the soul.\n\nTraditional Lanna Culture:\nChiang Mai serves as a gateway to the ancient Lanna Kingdom, and its rich cultural heritage permeates every aspect of the city. From traditional dance performances and mesmerizing music to vibrant festivals, such as the famous Yi Peng Lantern Festival, the spirit of Lanna comes alive in Chiang Mai. Embrace the opportunity to learn traditional arts and crafts, visit local workshops, and immerse yourself in the warm hospitality of the locals—a gateway to a world steeped in tradition and grace.\n\nExploring the Old City:\nThe heart of Chiang Mai lies within its Old City walls, where history blends seamlessly with modern life. As I strolled through the narrow, winding streets, I discovered charming temples, quaint cafes, and boutique shops offering exquisite handicrafts. The city\'s distinct architecture and well-preserved moat add to the ambiance, inviting visitors to take leisurely walks, rent bicycles, or hop on a tuk-tuk to uncover hidden gems at every turn.\n\nCulinary Delights:\nChiang Mai is a haven for food lovers, offering a tantalizing array of flavors and aromas that ignite the taste buds. From street-side vendors dishing out delectable local delicacies to bustling night markets and renowned restaurants, the city\'s culinary scene is a gastronomic adventure. Don\'t miss the opportunity to savor traditional dishes like Khao Soi, explore the vibrant flavors of the local street food, and even participate in cooking classes to bring the flavors of Chiang Mai back home.\n\nNature\'s Playground:\nSurrounded by lush mountains and verdant landscapes, Chiang Mai is an outdoor enthusiast\'s paradise. Embark on a trek through the jungles, encounter majestic elephants at ethical sanctuaries, or take a peaceful bamboo raft ride along serene rivers—nature beckons at every corner. The nearby Doi Inthanon National Park, known as the \"Roof of Thailand,\" offers breathtaking vistas, cascading waterfalls, and a chance to connect with the region\'s rich biodiversity.\n\nConclusion:\nChiang Mai, with its blend of ancient traditions, vibrant cultural experiences, and natural beauty, casts an enchanting spell on all who visit. This city embraces you with open arms, inviting you to immerse yourself in its rich tapestry of history, spirituality, and warm hospitality. Whether exploring sacred temples, savoring mouthwatering cuisine, or immersing oneself in the captivating traditions of the Lanna Kingdom, Chiang Mai is a destination that leaves an indelible mark on the soul. Prepare to be enthralled by the beauty, serenity, and boundless wonders that await you in this captivating cultural hub of northern Thailand.', '2023-06-02', '2023-06-18', 'https://a.cdn-hotels.com/gdcs/production9/d679/184d7edf-5c3a-470c-8529-b0085d6d5b0e.jpg', '2023-06-20 10:10:10', NULL, 1, 5, 5);
INSERT INTO `blog` (`id`, `title`, `description`, `trip_start`, `trip_end`, `image_url`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`) VALUES (6, 'Embracing History at Red Square', 'Nestled in the heart of Moscow, Red Square stands as a vibrant symbol of Russia\'s complex history, embracing both triumphs and challenges. Join me, a subtle communist, as I delve into this iconic square, exploring its historic landmarks and immersing myself in the atmosphere of a bygone era. Through my lens, I invite you to appreciate the rich tapestry of the past, offering a nuanced perspective on this enigmatic place.\n\nThe Allure of Soviet Architecture:\nWalking into Red Square, I am immediately greeted by architectural marvels that reflect the Soviet era\'s grandeur. The imposing red walls of the Kremlin and the elegant façade of the State Historical Museum evoke a sense of pride and strength, while the intricate details of St. Basil\'s Cathedral transport me to a time of artistic expression and cultural identity. Each structure holds a story, a testament to the vision and craftsmanship of the past.\n\nLenin\'s Mausoleum: A Contemplative Visit:\nA visit to Red Square is incomplete without paying respects to Vladimir Lenin, a figure who shaped the course of Russian history. As a subtle communist, I approach Lenin\'s Mausoleum with reverence and contemplation. Standing in line, surrounded by fellow visitors, I reflect on the ideals that shaped the Soviet Union and the ongoing dialogue surrounding its legacy. It is a moment to remember the struggles and achievements that have defined the country\'s path.\n\nHistorical Significance: From Parades to Protests:\nRed Square has been witness to both glorious celebrations and significant protests throughout its history. From the grand military parades during Soviet times to the more recent demonstrations that embody the changing landscape of Russia, the square has been a stage for expressions of power, discontent, and hope. I take a moment to imagine the echoes of the past reverberating through these iconic surroundings, acknowledging the complexities of history.\n\nGUM Department Store: A Contrast of Eras:\nIn the midst of Red Square\'s historical landmarks, the GUM Department Store stands as a testament to the evolving nature of society. Once a symbol of Soviet retail, it now houses high-end luxury brands, offering a stark contrast between the past and present. I stroll through its elegant halls, observing the interplay of capitalism and consumerism, acknowledging the changing landscape of ideals while cherishing the remnants of a different era.\n\nPreserving Historical Heritage:\nAs a subtle communist, I believe in the preservation of historical heritage as a means of understanding and learning from the past. Red Square, with its evocative symbolism, serves as a reminder of the collective journey of a nation. It is crucial to approach this space with respect, acknowledging the diverse perspectives and narratives it encompasses. By embracing history in all its complexities, we can strive for a more nuanced understanding of the present.\n\nConclusion:\nMy visit to Red Square as a subtle communist was a thought-provoking experience, inviting reflection on the intersections of ideology, history, and personal perspectives. As I immersed myself in the aura of the square, I was reminded that the echoes of the past continue to resonate in the present, shaping the ongoing narrative of a nation. Red Square\'s iconic landmarks and contrasting elements provided me with an opportunity to explore history from a unique vantage point, embracing the complexities while appreciating the endurance of human spirit. It is through such journeys that we can broaden our perspectives, fostering a deeper understanding of the world around us.', '2023-05-22', '2023-06-01', 'https://expatexplore.com/blog/wp-content/uploads/2016/11/red-square-russia-europe-explore-expat.jpg', '2023-06-02 11:12:16', NULL, 1, 3, 6);
INSERT INTO `blog` (`id`, `title`, `description`, `trip_start`, `trip_end`, `image_url`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`) VALUES (7, 'Berlin: A Fusion of History, Culture, and Creative Energy', 'The Berlin Wall: Unveiling Historical Significance:\nNo visit to Berlin is complete without exploring the remnants of the Berlin Wall, a powerful symbol of division and unity. Standing before the East Side Gallery, adorned with colorful murals and poignant artwork, I couldn\'t help but reflect on the resilience of the human spirit and the triumph of reunification. Visiting Checkpoint Charlie and the Berlin Wall Memorial provided a somber reminder of the city\'s turbulent past and the importance of embracing peace and unity in our interconnected world.\n\nMuseumsinsel: A Haven for Art and History:\nImmerse yourself in a world of cultural treasures at Museumsinsel, a UNESCO World Heritage site and home to five world-class museums. From the awe-inspiring antiquities at the Pergamon Museum to the iconic Nefertiti bust at the Neues Museum, each museum offers a fascinating glimpse into human history and artistic achievement. Strolling through these hallowed halls, I was transported through time, gaining a deeper understanding of our shared heritage.\n\nAlternative Berlin: Embracing Creativity and Expression:\nBerlin\'s creative spirit is palpable in its vibrant neighborhoods and street art scene. Exploring districts like Kreuzberg and Friedrichshain, I discovered a multitude of colorful street murals, hidden art galleries, and unique boutiques. The East Side Gallery, with its thought-provoking graffiti and street art, showcased the city\'s commitment to freedom of expression. Embracing the alternative side of Berlin allowed me to tap into the city\'s dynamic energy and appreciate the diversity of voices that make it truly unique.\n\nTiergarten and Reichstag: Nature and Politics:\nEscape the urban buzz and find serenity in the heart of Berlin at Tiergarten, a sprawling park that offers a tranquil retreat. Walking along its meandering paths, I marveled at the picturesque landscapes and lush greenery. Nearby, the Reichstag building, home to the German parliament, beckoned with its iconic glass dome. Ascending to its rooftop terrace, I was rewarded with panoramic views of the city, a powerful reminder of Germany\'s democratic journey and its commitment to transparency.\n\nFood and Nightlife: A Culinary Adventure:\nBerlin\'s vibrant food scene offers a culinary adventure for every palate. From traditional German cuisine to international flavors, the city\'s diverse eateries cater to all tastes. Exploring the bustling food markets and trendy cafes, I indulged in delectable street food, savored traditional German sausages, and embraced the city\'s love for vegan and vegetarian options. As night fell, Berlin\'s nightlife came alive with eclectic bars, underground clubs, and live music venues, ensuring that the city never sleeps.\n\nConclusion:\nBerlin is a city that pulsates with history, creativity, and a spirit of resilience. From its poignant reminders of the past to its vibrant cultural scene, every corner of the city tells a story waiting to be discovered. Embracing Berlin\'s rich heritage, diverse neighborhoods, and vibrant energy allowed me to experience a city that is constantly evolving while remaining deeply rooted in its past. Berlin leaves an indelible mark on those who visit, inspiring a deeper appreciation for history, culture, and the boundless possibilities of human expression.', '2023-01-23', '2023-01-26', 'https://www.aljazeera.com/wp-content/uploads/2016/02/0509fc09e2cb4cf9ac675aca77e39cd2_18.jpeg?resize=770%2C513&quality=80', '2023-03-22 3:33:07', NULL, 1, 5, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `category` (`id`, `name`) VALUES (1, 'Outdoors');
INSERT INTO `category` (`id`, `name`) VALUES (2, 'Culture');
INSERT INTO `category` (`id`, `name`) VALUES (3, 'Entertainment');
INSERT INTO `category` (`id`, `name`) VALUES (4, 'Food & Beverage');
INSERT INTO `category` (`id`, `name`) VALUES (5, 'Music');
INSERT INTO `category` (`id`, `name`) VALUES (6, 'Buisness');
INSERT INTO `category` (`id`, `name`) VALUES (7, 'Educational');
INSERT INTO `category` (`id`, `name`) VALUES (8, 'History');

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `comment` (`id`, `title`, `body`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `inreplyto_id`) VALUES (1, 'Awesome!', 'Great pics! I want to visit one day.', '2023-06-21 11:11:11', NULL, 1, 1, 1, null);
INSERT INTO `comment` (`id`, `title`, `body`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `inreplyto_id`) VALUES (2, 'Oh, Buenos Aires!', 'The mere mention of this vibrant city fills me with an irresistible desire to explore its eclectic neighborhoods, dance to the passionate beats of tango, indulge in mouthwatering empanadas, and get lost in the enchanting blend of European charm and Latin American flair. From its stunning architecture to its lively street art scene, Buenos Aires beckons me with promises of unforgettable experiences and a vibrant cultural tapestry that I simply cannot resist.', '2023-06-22 15:33:36', NULL, 1, 2, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `destination_image` (`id`, `image_url`, `enabled`, `destination_id`, `user_id`, `created_at`, `updated_at`) VALUES (1, 'https://media.timeout.com/images/105718842/750/422/image.jpg', 1, 1, 1, '2023-06-21 11:11:11', NULL);
INSERT INTO `destination_image` (`id`, `image_url`, `enabled`, `destination_id`, `user_id`, `created_at`, `updated_at`) VALUES (2, 'https://www.livelikeitstheweekend.com/wp-content/uploads/2020/03/Is-Buenos-Aires-Safe-13-700x875.jpg', 1, 2, 2, ' 2023-05-16 12:23:51', NULL);
INSERT INTO `destination_image` (`id`, `image_url`, `enabled`, `destination_id`, `user_id`, `created_at`, `updated_at`) VALUES (3, 'https://www.coolantarctica.com/pics-slider/ravas51-CC-BY-SA-2-slider.jpg', 1, 3, 1, '2023-04-08 08:43:20', NULL);
INSERT INTO `destination_image` (`id`, `image_url`, `enabled`, `destination_id`, `user_id`, `created_at`, `updated_at`) VALUES (4, 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/11/07/16/sydney-overview.jpg', 1, 4, 4, '2023-06-22 04:08:15', NULL);
INSERT INTO `destination_image` (`id`, `image_url`, `enabled`, `destination_id`, `user_id`, `created_at`, `updated_at`) VALUES (5, 'https://cdn.britannica.com/07/192407-050-548620BE/Sunset-view-Chiang-Mai-Thailand.jpg', 1, 5, 5, '2023-06-22 19:43:10', NULL);
INSERT INTO `destination_image` (`id`, `image_url`, `enabled`, `destination_id`, `user_id`, `created_at`, `updated_at`) VALUES (6, 'https://images.skyscrapercenter.com/uploads/Moscow_Moscow-City-2017_(CC__BY)Deensel210126-020103.jpg', 1, 6, 3, '2023-06-22 19:30:09', NULL);
INSERT INTO `destination_image` (`id`, `image_url`, `enabled`, `destination_id`, `user_id`, `created_at`, `updated_at`) VALUES (7, 'https://www.aljazeera.com/wp-content/uploads/2016/02/0509fc09e2cb4cf9ac675aca77e39cd2_18.jpeg?resize=770%2C513&quality=80', 1, 7, 5, '2023-03-22 16:56:33', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `blog_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `rating_comment`) VALUES (5, '2023-06-21', NULL, 1, 1, 1, 'Love your blog Chip!');
INSERT INTO `blog_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `rating_comment`) VALUES (5, '2023-06-22', NULL, 1, 2, 2, 'Your travels are amazing!');
INSERT INTO `blog_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `rating_comment`) VALUES (4, '2023-06-23', NULL, 1, 3, 3, 'I learned a lot from your blog. Who knew that people could actually live in parts of Antarctica?!');
INSERT INTO `blog_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `rating_comment`) VALUES (5, '2023-06-23', NULL, 1, 5, 4, 'g\'day mate!');
INSERT INTO `blog_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `rating_comment`) VALUES (5, '2023-06-24', NULL, 1, 4, 5, 'Thailand looks like a cool place to visit. Thanks for the great post.');
INSERT INTO `blog_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `rating_comment`) VALUES (5, '2023-06-24', NULL, 1, 4, 6, 'The Red Square is an iconic landmark that beautifully showcases Russia\'s rich history and architectural grandeur. Its vibrant atmosphere and historical significance make it a must-visit destination for anyone exploring Moscow.');
INSERT INTO `blog_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `blog_id`, `rating_comment`) VALUES (5, '2023-06-24', NULL, 1, 3, 7, 'Deutschland über alle!');

COMMIT;


-- -----------------------------------------------------
-- Data for table `place_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `place_image` (`id`, `image_url`, `enabled`, `place_id`, `user_id`, `created_at`, `updated_at`) VALUES (1, 'https://wallpapers.com/images/featured-full/hollywood-sign-background-qnufrpnpkgsvy3cc.jpg', 1, 1, 1, '2023-06-21 11:11:11', NULL);
INSERT INTO `place_image` (`id`, `image_url`, `enabled`, `place_id`, `user_id`, `created_at`, `updated_at`) VALUES (2, 'https://fh-sites.imgix.net/sites/3006/2022/04/21152126/obelisk-in-buenos-aires.jpg', 1, 2, 2, '2023-06-22 06:33:01', NULL);
INSERT INTO `place_image` (`id`, `image_url`, `enabled`, `place_id`, `user_id`, `created_at`, `updated_at`) VALUES (3, 'https://www.joannamaclean.com/wp-content/uploads/2020/02/Antarc_blog_52.jpg', 1, 3, 1, '2023-04-08 17:55:10', NULL);
INSERT INTO `place_image` (`id`, `image_url`, `enabled`, `place_id`, `user_id`, `created_at`, `updated_at`) VALUES (4, 'https://images.strang-inc.com/wp-content/uploads/2019/04/01193109/Sydenyopera.jpg', 1, 4, 4, '2023-05-10 14:33:30', NULL);
INSERT INTO `place_image` (`id`, `image_url`, `enabled`, `place_id`, `user_id`, `created_at`, `updated_at`) VALUES (5, 'https://a.cdn-hotels.com/gdcs/production9/d679/184d7edf-5c3a-470c-8529-b0085d6d5b0e.jpg', 1, 5, 5, '2023-06-20 10:10:10', NULL);
INSERT INTO `place_image` (`id`, `image_url`, `enabled`, `place_id`, `user_id`, `created_at`, `updated_at`) VALUES (6, 'https://expatexplore.com/blog/wp-content/uploads/2016/11/red-square-russia-europe-explore-expat.jpg', 1, 6, 3, '2023-06-22 16:56:09', NULL);
INSERT INTO `place_image` (`id`, `image_url`, `enabled`, `place_id`, `user_id`, `created_at`, `updated_at`) VALUES (7, 'https://www.oktoberfestticketsmunich.com/wp-content/uploads/2015/04/lowen.jpg', 1, 7, 5, '2023-03-22 16:30:09', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blog_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `blog_category` (`category_id`, `blog_id`) VALUES (1, 1);
INSERT INTO `blog_category` (`category_id`, `blog_id`) VALUES (1, 2);
INSERT INTO `blog_category` (`category_id`, `blog_id`) VALUES (1, 3);
INSERT INTO `blog_category` (`category_id`, `blog_id`) VALUES (4, 4);
INSERT INTO `blog_category` (`category_id`, `blog_id`) VALUES (8, 5);
INSERT INTO `blog_category` (`category_id`, `blog_id`) VALUES (8, 6);
INSERT INTO `blog_category` (`category_id`, `blog_id`) VALUES (2, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `place_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `place_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`, `rating_comment`) VALUES (5, '2023-06-21 11:11:11', NULL, 1, 1, 1, 'Cool!');
INSERT INTO `place_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`, `rating_comment`) VALUES (5, '2023-06-22 17:32:12', NULL, 1, 2, 2, 'Very Nice!');
INSERT INTO `place_rating` (`rating_value`, `created_at`, `updated_at`, `enabled`, `user_id`, `place_id`, `rating_comment`) VALUES (3, '2023-04-08 17:55:01', NULL, 1, 1, 3, 'Looks cold af.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_follower`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `user_follower` (`followed_id`, `follower_id`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `journeyjournalsdb`;
INSERT INTO `favorite_destination` (`destination_id`, `user_id`) VALUES (1, 1);
INSERT INTO `favorite_destination` (`destination_id`, `user_id`) VALUES (2, 2);

COMMIT;

