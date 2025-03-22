-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: mybankbd
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
-- Table structure for table `account_data`
--

DROP TABLE IF EXISTS `account_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `balance` decimal(10,2) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_data`
--

LOCK TABLES `account_data` WRITE;
/*!40000 ALTER TABLE `account_data` DISABLE KEYS */;
INSERT INTO `account_data` VALUES (1,12599550.00,'Wesley O','De Oliveira1','St Benedict2'),(3,100800.00,'Cainho Chupe chupe','boca de veludinho','Dorsert1'),(103,102058.00,'NATHY','caldeira','KKKKKKKK'),(108,1050000.00,'Yanni','Zao','Bejing'),(112,52500.00,'Patricia','Smith','Belfast'),(135,350.00,'Darren1','Gik','AMPR'),(141,100134.00,'Eric2','Bond2','Dubin'),(142,900.00,'Pedroa alvarez','Cabral','Rua Sexo de Almeida');
/*!40000 ALTER TABLE `account_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_account`
--

DROP TABLE IF EXISTS `api_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_number` varchar(20) NOT NULL,
  `account_holder` varchar(100) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_number` (`account_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_account`
--

LOCK TABLES `api_account` WRITE;
/*!40000 ALTER TABLE `api_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_account_old`
--

DROP TABLE IF EXISTS `api_account_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_account_old` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_number` varchar(20) NOT NULL,
  `account_holder` varchar(100) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_number` (`account_number`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_account_old`
--

LOCK TABLES `api_account_old` WRITE;
/*!40000 ALTER TABLE `api_account_old` DISABLE KEYS */;
INSERT INTO `api_account_old` VALUES (103,'123456','Ewing',2058.00);
/*!40000 ALTER TABLE `api_account_old` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_logindetails`
--

DROP TABLE IF EXISTS `api_logindetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_logindetails` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_logindetails`
--

LOCK TABLES `api_logindetails` WRITE;
/*!40000 ALTER TABLE `api_logindetails` DISABLE KEYS */;
INSERT INTO `api_logindetails` VALUES (1,'wes','somsm123');
/*!40000 ALTER TABLE `api_logindetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_transaction`
--

DROP TABLE IF EXISTS `api_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_type` varchar(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_date` datetime(6) NOT NULL,
  `account_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `api_transaction_account_id_e6b49b9a_fk_api_account_id` (`account_id`),
  CONSTRAINT `api_transaction_account_id_e6b49b9a_fk_api_account_id` FOREIGN KEY (`account_id`) REFERENCES `api_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_transaction`
--

LOCK TABLES `api_transaction` WRITE;
/*!40000 ALTER TABLE `api_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_userinfo`
--

DROP TABLE IF EXISTS `api_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_userinfo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123123125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_userinfo`
--

LOCK TABLES `api_userinfo` WRITE;
/*!40000 ALTER TABLE `api_userinfo` DISABLE KEYS */;
INSERT INTO `api_userinfo` VALUES (1,'Wesley De Oliveira','St Benedicts Garden'),(2,'janper1','somsm123'),(3,'Alice','Wonderland'),(4,'Alice','Wonderland'),(5,'Wesley','De Oliveira'),(6,'Wpkpodsop','aokpdsopdkpoas'),(7,'testenew123','123@gmail.com'),(123,'wes','asidasi@gmail.com'),(123123124,'wes','asidasi@gmail.com');
/*!40000 ALTER TABLE `api_userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add user info',7,'add_userinfo'),(26,'Can change user info',7,'change_userinfo'),(27,'Can delete user info',7,'delete_userinfo'),(28,'Can view user info',7,'view_userinfo'),(29,'Can add login details',8,'add_logindetails'),(30,'Can change login details',8,'change_logindetails'),(31,'Can delete login details',8,'delete_logindetails'),(32,'Can view login details',8,'view_logindetails'),(33,'Can add transaction',9,'add_transaction'),(34,'Can change transaction',9,'change_transaction'),(35,'Can delete transaction',9,'delete_transaction'),(36,'Can view transaction',9,'view_transaction'),(37,'Can add account',10,'add_account'),(38,'Can change account',10,'change_account'),(39,'Can delete account',10,'delete_account'),(40,'Can view account',10,'view_account');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$FZ563TNc9VluLdPonY59K2$Y6NUtud69mBOKdT1tFqovm8IKDOecJvZ4RloveLYzyM=','2025-03-12 15:15:24.803972',1,'janper123','','','janper.oliveira@gmail.com',1,1,'2025-03-10 14:30:32.682849'),(2,'pbkdf2_sha256$720000$PG7iIM2noSXXNmVpE6dCzb$Fk8lNhT7ZojP9TsGyP4Ettu/NLXEbvSkNg4uBX31I0o=','2025-03-13 11:51:11.337093',1,'wes','','','janper.oliveira@gmail.com',1,1,'2025-03-12 15:17:02.378716');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-03-13 10:57:31.646320','7','testenew123',1,'[{\"added\": {}}]',7,2);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(10,'api','account'),(8,'api','logindetails'),(9,'api','transaction'),(7,'api','userinfo'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-03-10 14:26:26.537425'),(2,'auth','0001_initial','2025-03-10 14:26:44.943074'),(3,'admin','0001_initial','2025-03-10 14:26:48.243002'),(4,'admin','0002_logentry_remove_auto_add','2025-03-10 14:26:48.292889'),(5,'admin','0003_logentry_add_action_flag_choices','2025-03-10 14:26:48.544947'),(6,'contenttypes','0002_remove_content_type_name','2025-03-10 14:26:51.555786'),(7,'auth','0002_alter_permission_name_max_length','2025-03-10 14:26:53.700166'),(8,'auth','0003_alter_user_email_max_length','2025-03-10 14:26:54.029587'),(9,'auth','0004_alter_user_username_opts','2025-03-10 14:26:54.059317'),(10,'auth','0005_alter_user_last_login_null','2025-03-10 14:26:55.044306'),(11,'auth','0006_require_contenttypes_0002','2025-03-10 14:26:55.086793'),(12,'auth','0007_alter_validators_add_error_messages','2025-03-10 14:26:55.296096'),(13,'auth','0008_alter_user_username_max_length','2025-03-10 14:26:56.519012'),(14,'auth','0009_alter_user_last_name_max_length','2025-03-10 14:26:57.731246'),(15,'auth','0010_alter_group_name_max_length','2025-03-10 14:26:57.878503'),(16,'auth','0011_update_proxy_permissions','2025-03-10 14:26:57.947923'),(17,'auth','0012_alter_user_first_name_max_length','2025-03-10 14:26:59.123492'),(18,'sessions','0001_initial','2025-03-10 14:26:59.732154'),(19,'api','0001_initial','2025-03-10 15:04:37.937607'),(20,'api','0002_account_logindetails_transaction','2025-03-11 10:36:43.348003'),(21,'api','0002_rename_address_userinfo_email','2025-03-13 10:52:45.161386'),(22,'api','0003_account_logindetails_transaction','2025-03-13 11:49:40.739388');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('o1z9cbeoavzumwlzljuqx0ezsdszq59u','.eJxVjDsOwjAQBe_iGlm24y8lPWewdrNrHECOFCcV4u4QKQW0b2beS2TY1pq3zkueSJyFEaffDWF8cNsB3aHdZjnObV0mlLsiD9rldSZ-Xg7376BCr996wAgQIhl2umgqiRELFAXJRhrIUUjecixgrFEpgPeKSPuUdEAPDsT7AwsNOHI:1tsh5j:cJVMTORdz62ZLOiuMKV7B8hccLVqtdlgGFOdxbGjQ0s','2025-03-27 11:51:11.538195'),('qwftk5p5kzqrfsajszs5c59ebnsreebj','.eJxVjMsOwiAQRf-FtSHDYyC4dO83EJihUjWQlHZl_Hdt0oVu7znnvkRM21rjNsoSZxZnocTpd8uJHqXtgO-p3bqk3tZlznJX5EGHvHYuz8vh_h3UNOq3Bq2Ds1gIfEBwNhuyPiFOKrigiwcD1jggQI-KLWdiZUz2vqhJJ8fi_QGhkjal:1tsNno:_6bGPzoLICmz3Fnh-azI60bobxfYxlgMKs3ts-jE_-c','2025-03-26 15:15:24.723424'),('vac5s4ax1nedfzf75rlenxagp22g5ks3','.eJxVjEEOwiAQRe_C2hAYKQwu3XsGMgyjVA1NSrsy3l2bdKHb_977L5VoXWpau8xpLOqkrDr8bpn4IW0D5U7tNmme2jKPWW-K3mnXl6nI87y7fweVev3WYgYXKKI4jw6DN-WYvWMpA7FjRPDROMsQM4IUABGxLJCvHCIBonp_ANPRN-g:1treIb:eJ3L5TYXPq2IN5A0mc7ZwlYGwrHPl6b3ClpLD6V-N1E','2025-03-24 14:40:09.225431'),('vdqojr2vf8iel6qisece4lwcuiwsl2zi','.eJxVjDsOwjAQBe_iGlm24y8lPWewdrNrHECOFCcV4u4QKQW0b2beS2TY1pq3zkueSJyFEaffDWF8cNsB3aHdZjnObV0mlLsiD9rldSZ-Xg7376BCr996wAgQIhl2umgqiRELFAXJRhrIUUjecixgrFEpgPeKSPuUdEAPDsT7AwsNOHI:1tsRPx:aTMt9pfzh73ph82mU1rZAaJHbIv5MkiwG5magkeS3jA','2025-03-26 19:07:01.435309'),('zfrui7xqzrd7mk23mdqbivaz3b21sdry','.eJxVjEEOwiAQRe_C2hAYKQwu3XsGMgyjVA1NSrsy3l2bdKHb_977L5VoXWpau8xpLOqkrDr8bpn4IW0D5U7tNmme2jKPWW-K3mnXl6nI87y7fweVev3WYgYXKKI4jw6DN-WYvWMpA7FjRPDROMsQM4IUABGxLJCvHCIBonp_ANPRN-g:1treIb:eJ3L5TYXPq2IN5A0mc7ZwlYGwrHPl6b3ClpLD6V-N1E','2025-03-24 14:40:09.310079');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_details`
--

DROP TABLE IF EXISTS `login_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_details`
--

LOCK TABLES `login_details` WRITE;
/*!40000 ALTER TABLE `login_details` DISABLE KEYS */;
INSERT INTO `login_details` VALUES (1,'admin','admin123'),(4,'admin1','admin123');
/*!40000 ALTER TABLE `login_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `source_id` int DEFAULT NULL,
  `destination_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `transaction_type` enum('deposit','withdrawal','transfer') NOT NULL,
  `balance_after_transaction` decimal(10,2) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `source_id` (`source_id`),
  KEY `destination_id` (`destination_id`),
  CONSTRAINT `fk_destination_id` FOREIGN KEY (`destination_id`) REFERENCES `account_data` (`id`),
  CONSTRAINT `fk_source_id` FOREIGN KEY (`source_id`) REFERENCES `account_data` (`id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `account_data` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`destination_id`) REFERENCES `account_data` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,3,400.00,'2025-03-14 14:23:03','deposit',0.00,0),(2,1,141,100000.00,'2025-03-15 16:24:38','deposit',NULL,NULL),(3,1,3,100000.00,'2025-03-15 16:25:04','deposit',NULL,NULL),(4,1,103,100000.00,'2025-03-15 16:25:18','deposit',NULL,NULL),(5,1,108,1000000.00,'2025-03-15 16:25:34','deposit',NULL,NULL),(6,135,135,10.00,'2025-03-21 14:35:04','deposit',10.00,NULL),(7,135,135,10.00,'2025-03-21 14:35:20','deposit',10.00,NULL),(8,135,135,-30.00,'2025-03-21 14:51:36','deposit',300.00,NULL),(9,142,135,-100.00,'2025-03-21 14:52:02','deposit',900.00,NULL),(10,142,135,100.00,'2025-03-21 14:52:02','deposit',400.00,NULL),(11,135,135,-50.00,'2025-03-21 14:52:16','deposit',350.00,NULL);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-22 16:12:51
