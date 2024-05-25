-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: cooking_competition
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `cook_x_national_cuisines`
--

DROP TABLE IF EXISTS `cook_x_national_cuisines`;
/*!50001 DROP VIEW IF EXISTS `cook_x_national_cuisines`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `cook_x_national_cuisines` AS SELECT
 1 AS `contact_number`,
  1 AS `first_name`,
  1 AS `last_name`,
  1 AS `national_cuisine` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cooks`
--

DROP TABLE IF EXISTS `cooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cooks` (
  `contact_number` varchar(20) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `birth_date` date NOT NULL,
  `years_of_experience` int(11) NOT NULL,
  `vocational_training` varchar(25) NOT NULL,
  PRIMARY KEY (`contact_number`),
  KEY `cooks_training_levels_FK` (`vocational_training`),
  CONSTRAINT `cooks_training_levels_FK` FOREIGN KEY (`vocational_training`) REFERENCES `training_levels` (`training_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `episodes`
--

DROP TABLE IF EXISTS `episodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `episodes` (
  `season` int(11) NOT NULL,
  `episode` int(11) NOT NULL,
  `judge` varchar(20) NOT NULL,
  `score` int(11) NOT NULL,
  `participant` varchar(20) NOT NULL,
  `cuisine` varchar(50) DEFAULT NULL,
  `recipe` varchar(50) NOT NULL,
  PRIMARY KEY (`season`,`episode`,`judge`,`participant`),
  KEY `FK_episodesnew_cooks` (`judge`) USING BTREE,
  KEY `FK_episodesnew_cooks_2` (`participant`) USING BTREE,
  KEY `episodes_recipes_FK` (`recipe`),
  CONSTRAINT `FK_episodes_cooks` FOREIGN KEY (`judge`) REFERENCES `cooks` (`contact_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_episodes_cooks_2` FOREIGN KEY (`participant`) REFERENCES `cooks` (`contact_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `episodes_recipes_FK` FOREIGN KEY (`recipe`) REFERENCES `recipes` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `name` varchar(30) NOT NULL,
  `description` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment_for_recipes`
--

DROP TABLE IF EXISTS `equipment_for_recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment_for_recipes` (
  `recipe` varchar(50) NOT NULL,
  `equipment` varchar(30) NOT NULL,
  PRIMARY KEY (`recipe`,`equipment`),
  KEY `equipment_for_recipes_equipment_FK` (`equipment`),
  CONSTRAINT `equipment_for_recipes_equipment_FK` FOREIGN KEY (`equipment`) REFERENCES `equipment` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `equipment_for_recipes_recipes_FK` FOREIGN KEY (`recipe`) REFERENCES `recipes` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `food_groups`
--

DROP TABLE IF EXISTS `food_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food_groups` (
  `name` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients` (
  `ingredient` varchar(30) NOT NULL,
  `food_group` varchar(50) NOT NULL,
  PRIMARY KEY (`ingredient`),
  KEY `FK_grouped_food_groups` (`food_group`) USING BTREE,
  CONSTRAINT `ingredients_grouped_food_groups_FK` FOREIGN KEY (`food_group`) REFERENCES `food_groups` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredients_of_recipes`
--

DROP TABLE IF EXISTS `ingredients_of_recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients_of_recipes` (
  `recipe` varchar(50) NOT NULL,
  `ingredient` varchar(30) NOT NULL,
  `quantity` varchar(50) DEFAULT '0',
  PRIMARY KEY (`recipe`,`ingredient`),
  KEY `ingredients_of_recipes_ingredients_grouped_FK` (`ingredient`),
  CONSTRAINT `ingredients_of_recipes_ingredients_grouped_FK` FOREIGN KEY (`ingredient`) REFERENCES `ingredients` (`ingredient`),
  CONSTRAINT `ingredients_of_recipes_recipes_FK` FOREIGN KEY (`recipe`) REFERENCES `recipes` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `national_cuisines_specialization`
--

DROP TABLE IF EXISTS `national_cuisines_specialization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `national_cuisines_specialization` (
  `cook_contact` varchar(20) NOT NULL,
  `national_cuisine` varchar(20) NOT NULL,
  PRIMARY KEY (`cook_contact`,`national_cuisine`),
  CONSTRAINT `national_cuisines_specialization_cooks_FK` FOREIGN KEY (`cook_contact`) REFERENCES `cooks` (`contact_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nutritional_information`
--

DROP TABLE IF EXISTS `nutritional_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nutritional_information` (
  `recipe` varchar(50) NOT NULL,
  `serving_size` varchar(50) DEFAULT NULL,
  `fat_per_serving` decimal(5,2) NOT NULL,
  `protein_per_serving` decimal(5,2) NOT NULL,
  `carbs_per_serving` decimal(5,2) NOT NULL,
  `calories_per_serving` decimal(6,2) GENERATED ALWAYS AS (`fat_per_serving` * 9 + `protein_per_serving` * 4 + `carbs_per_serving` * 4) STORED,
  PRIMARY KEY (`recipe`),
  CONSTRAINT `nutritional_information_ibfk_1` FOREIGN KEY (`recipe`) REFERENCES `recipes` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipes` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(20) NOT NULL DEFAULT '',
  `national_cuisine` varchar(20) NOT NULL DEFAULT '',
  `difficulty` int(11) NOT NULL DEFAULT 0,
  `description` varchar(200) NOT NULL DEFAULT '',
  `classification` varchar(20) NOT NULL DEFAULT '',
  `execution time` tinytext NOT NULL,
  `servings` int(11) NOT NULL DEFAULT 0,
  `core ingredient` varchar(15) NOT NULL DEFAULT '0',
  `identified as` varchar(20) NOT NULL DEFAULT '0',
  `instructions` varchar(100) DEFAULT 'Instructions need to be added.',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `recipe` varchar(50) NOT NULL,
  `tag` varchar(50) NOT NULL,
  PRIMARY KEY (`recipe`,`tag`) USING BTREE,
  CONSTRAINT `tags_recipes_FK` FOREIGN KEY (`recipe`) REFERENCES `recipes` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `thematic_sections`
--

DROP TABLE IF EXISTS `thematic_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thematic_sections` (
  `name` varchar(25) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `thematic_sections_of_recipes`
--

DROP TABLE IF EXISTS `thematic_sections_of_recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thematic_sections_of_recipes` (
  `recipe` varchar(50) NOT NULL,
  `thematic_section` varchar(25) NOT NULL,
  PRIMARY KEY (`recipe`,`thematic_section`),
  KEY `thematic_sections_of_recipes_thematic_sections_FK` (`thematic_section`),
  CONSTRAINT `thematic_sections_of_recipes_recipes_FK` FOREIGN KEY (`recipe`) REFERENCES `recipes` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `thematic_sections_of_recipes_thematic_sections_FK` FOREIGN KEY (`thematic_section`) REFERENCES `thematic_sections` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tips`
--

DROP TABLE IF EXISTS `tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tips` (
  `recipe` varchar(50) NOT NULL,
  `tip` varchar(200) NOT NULL,
  PRIMARY KEY (`recipe`,`tip`) USING BTREE,
  CONSTRAINT `FK__recipe` FOREIGN KEY (`recipe`) REFERENCES `recipes` (`name`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tips_before_insert` BEFORE INSERT ON `tips` FOR EACH ROW BEGIN
    DECLARE tip_count INT;
    SELECT COUNT(*) INTO tip_count FROM tips  WHERE `recipe` = NEW.`recipe`;
    IF tip_count >= 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert more than 3 tips per recipe';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `training_levels`
--

DROP TABLE IF EXISTS `training_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_levels` (
  `training_name` varchar(25) NOT NULL,
  `training_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`training_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `cook_x_national_cuisines`
--

/*!50001 DROP VIEW IF EXISTS `cook_x_national_cuisines`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cook_x_national_cuisines` AS select `cooks`.`contact_number` AS `contact_number`,`cooks`.`first_name` AS `first_name`,`cooks`.`last_name` AS `last_name`,`national_cuisines_specialization`.`national_cuisine` AS `national_cuisine` from (`national_cuisines_specialization` join `cooks` on(`cooks`.`contact_number` = `national_cuisines_specialization`.`cook_contact`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-25 17:51:54
