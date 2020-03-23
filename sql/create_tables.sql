-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: eagle_db_v2
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activator`
--

DROP TABLE IF EXISTS `activator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activator` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `sensitivity` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `envs` varchar(255) DEFAULT NULL,
  `platforms` varchar(255) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `user_capacity` int DEFAULT NULL,
  `server_capacity` int DEFAULT NULL,
  `regions` varchar(2000) DEFAULT NULL COMMENT 'list of regions - JSON',
  `hosting` varchar(2000) DEFAULT NULL COMMENT 'list of hosting options - JSON',
  `api_management` varchar(2000) DEFAULT NULL COMMENT 'list of api management options - JSON',
  `cis` varchar(2000) DEFAULT NULL COMMENT 'list of CI options - JSON',
  `cds` varchar(2000) DEFAULT NULL,
  `sourcecontrols` varchar(2000) DEFAULT NULL COMMENT 'list of source control options - JSON',
  `businessunits` varchar(2000) DEFAULT NULL COMMENT 'list of business units - JSON',
  `technology_owner` varchar(255) DEFAULT NULL,
  `technology_owner_email` varchar(255) DEFAULT NULL,
  `billing` varchar(255) DEFAULT NULL,
  `activator` varchar(255) DEFAULT NULL,
  `resources` varchar(2000) DEFAULT NULL COMMENT 'list of resources - JSON',
  `status` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `id` int NOT NULL AUTO_INCREMENT,
  `solution_id` int NOT NULL,
  `activator_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `env` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_solution_fk_idx` (`solution_id`),
  KEY `app_activator_fk_idx` (`activator_id`),
  CONSTRAINT `app_activator_fk` FOREIGN KEY (`activator_id`) REFERENCES `activator` (`id`),
  CONSTRAINT `app_solution_fk` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `businessunit`
--

DROP TABLE IF EXISTS `businessunit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `businessunit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cd`
--

DROP TABLE IF EXISTS `cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cd` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ci`
--

DROP TABLE IF EXISTS `ci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ci` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `environment`
--

DROP TABLE IF EXISTS `environment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `environment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `solution`
--

DROP TABLE IF EXISTS `solution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solution` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `businessunit_id` int DEFAULT NULL,
  `cost_centre` varchar(255) DEFAULT NULL,
  `ci_id` int DEFAULT NULL,
  `cd_id` int DEFAULT NULL,
  `sourcecontrol_id` int DEFAULT NULL,
  `environment_id` int DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT NULL,
  `teams` varchar(255) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  `workspace_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sol_ci_fk_idx` (`ci_id`),
  KEY `sol_cd_fk_idx` (`cd_id`),
  KEY `sol_businessunit_fk_idx` (`businessunit_id`),
  KEY `sol_sourcecontrol_fk_idx` (`sourcecontrol_id`),
  KEY `sol_workspace_fk_idx` (`workspace_id`),
  CONSTRAINT `sol_businessunit_fk` FOREIGN KEY (`businessunit_id`) REFERENCES `businessunit` (`id`),
  CONSTRAINT `sol_cd_fk` FOREIGN KEY (`cd_id`) REFERENCES `cd` (`id`),
  CONSTRAINT `sol_ci_fk` FOREIGN KEY (`ci_id`) REFERENCES `ci` (`id`),
  CONSTRAINT `sol_sourcecontrol_fk` FOREIGN KEY (`sourcecontrol_id`) REFERENCES `sourcecontrol` (`id`),
  CONSTRAINT `sol_workspace_fk` FOREIGN KEY (`workspace_id`) REFERENCES `workspace` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `solution_environment`
--

DROP TABLE IF EXISTS `solution_environment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solution_environment` (
  `solution_id` int NOT NULL,
  `environment_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`solution_id`,`environment_id`),
  KEY `solenv_environment_fk_idx` (`environment_id`),
  CONSTRAINT `solenv_environment_fk` FOREIGN KEY (`environment_id`) REFERENCES `environment` (`id`),
  CONSTRAINT `solenv_solution_fk` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `solution_team`
--

DROP TABLE IF EXISTS `solution_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solution_team` (
  `solution_id` int NOT NULL,
  `team_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`solution_id`,`team_id`),
  KEY `solteam_team_idx` (`team_id`),
  CONSTRAINT `solteam_solution` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`id`),
  CONSTRAINT `solteam_team` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sourcecontrol`
--

DROP TABLE IF EXISTS `sourcecontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sourcecontrol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_user`
--

DROP TABLE IF EXISTS `team_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_user` (
  `team_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`team_id`,`user_id`),
  KEY `teamuser_user_fk_idx` (`user_id`),
  CONSTRAINT `teamuser_team_fk` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`),
  CONSTRAINT `teamuser_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workspace`
--

DROP TABLE IF EXISTS `workspace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workspace` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ci_id` int DEFAULT NULL,
  `cd_id` int DEFAULT NULL,
  `sourcecontrol_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `work_ci_fk_idx` (`ci_id`),
  KEY `work_cd_fk_idx` (`cd_id`),
  KEY `work_sourcecontrol_fk_idx` (`sourcecontrol_id`),
  CONSTRAINT `work_cd_fk` FOREIGN KEY (`cd_id`) REFERENCES `cd` (`id`),
  CONSTRAINT `work_ci_fk` FOREIGN KEY (`ci_id`) REFERENCES `ci` (`id`),
  CONSTRAINT `work_sourcecontrol_fk` FOREIGN KEY (`sourcecontrol_id`) REFERENCES `sourcecontrol` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-23 16:08:48
