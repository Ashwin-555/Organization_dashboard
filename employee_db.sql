-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: employee_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `performance_rating` int DEFAULT NULL,
  `feedback` text,
  `working_hours` float DEFAULT NULL,
  `attendance_status` enum('Present','Absent','On Leave') DEFAULT NULL,
  `department` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  CONSTRAINT `employees_chk_1` CHECK ((`performance_rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'1','Ashwin','engineer',4,'good',5,'Present','finance'),(9,'5','Ashwin','engineer',3,'yes',5,'Present','human_resources'),(16,'19','Ashwin','doctor',3,'fun',3,'Present','human_resources'),(18,'90','ash','senior',3,'dummy',45,'Present','human_resources'),(26,'32','david warner','pushpa',5,'the stylish star',100,'Present','marketing'),(29,'89','shah rukh khan','actor',5,'king of bollywood',500,'Present','operations'),(30,'45','david warner','junior',2,'fun',45,'Absent','operations'),(35,'74','leenus','developer',4,'he is great in developing websites',55,'Present','technologies'),(38,'44','boaz','lead',4,'he is good',45,'Present','human_resources'),(41,'95','logan','sales executive',4,'good in work',45,'Present','customer_support'),(42,'50','Lakshmi','senior associate',4,'good',56,'Absent','finance'),(43,'59','tharun','developer',4,'the problem solving for tharun is exceptional',90,'On Leave','human_resources');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees_department`
--

DROP TABLE IF EXISTS `employees_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees_department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_department`
--

LOCK TABLES `employees_department` WRITE;
/*!40000 ALTER TABLE `employees_department` DISABLE KEYS */;
INSERT INTO `employees_department` VALUES (3,'customer_support'),(2,'finance'),(1,'human_resources'),(4,'marketing'),(5,'operations'),(6,'technologies');
/*!40000 ALTER TABLE `employees_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees_employee`
--

DROP TABLE IF EXISTS `employees_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees_employee` (
  `employee_id` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `department_name` varchar(255) NOT NULL,
  `performance_rating` int DEFAULT NULL,
  `feedback` text,
  `working_hours` float DEFAULT NULL,
  `attendance_status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `department_name` (`department_name`),
  CONSTRAINT `employees_employee_ibfk_1` FOREIGN KEY (`department_name`) REFERENCES `employees_department` (`name`),
  CONSTRAINT `employees_employee_chk_1` CHECK ((`performance_rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_employee`
--

LOCK TABLES `employees_employee` WRITE;
/*!40000 ALTER TABLE `employees_employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employees_employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-28 13:53:53
