CREATE DATABASE IF NOT EXISTS `openmrs`;

USE `openmrs`;

-- MySQL dump 10.13  Distrib 5.6.51, for Linux (x86_64)
-- ------------------------------------------------------
-- Server version	5.6.51

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `allergy`
--

DROP TABLE IF EXISTS `allergy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergy` (
  `allergy_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `severity_concept_id` int(11) DEFAULT NULL,
  `coded_allergen` int(11) NOT NULL,
  `non_coded_allergen` varchar(255) DEFAULT NULL,
  `allergen_type` varchar(50) NOT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '1',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`allergy_id`),
  UNIQUE KEY `allergy_id` (`allergy_id`),
  KEY `allergy_changed_by_fk` (`changed_by`),
  KEY `allergy_coded_allergen_fk` (`coded_allergen`),
  KEY `allergy_creator_fk` (`creator`),
  KEY `allergy_patient_id_fk` (`patient_id`),
  KEY `allergy_severity_concept_id_fk` (`severity_concept_id`),
  KEY `allergy_voided_by_fk` (`voided_by`),
  CONSTRAINT `allergy_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_coded_allergen_fk` FOREIGN KEY (`coded_allergen`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_severity_concept_id_fk` FOREIGN KEY (`severity_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergy`
--

LOCK TABLES `allergy` WRITE;
/*!40000 ALTER TABLE `allergy` DISABLE KEYS */;
/*!40000 ALTER TABLE `allergy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allergy_reaction`
--

DROP TABLE IF EXISTS `allergy_reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergy_reaction` (
  `allergy_reaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `allergy_id` int(11) NOT NULL,
  `reaction_concept_id` int(11) NOT NULL,
  `reaction_non_coded` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`allergy_reaction_id`),
  UNIQUE KEY `allergy_reaction_id` (`allergy_reaction_id`),
  KEY `allergy_reaction_allergy_id_fk` (`allergy_id`),
  KEY `allergy_reaction_reaction_concept_id_fk` (`reaction_concept_id`),
  CONSTRAINT `allergy_reaction_allergy_id_fk` FOREIGN KEY (`allergy_id`) REFERENCES `allergy` (`allergy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_reaction_reaction_concept_id_fk` FOREIGN KEY (`reaction_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergy_reaction`
--

LOCK TABLES `allergy_reaction` WRITE;
/*!40000 ALTER TABLE `allergy_reaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `allergy_reaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `care_setting`
--

DROP TABLE IF EXISTS `care_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `care_setting` (
  `care_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `care_setting_type` varchar(50) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`care_setting_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `care_setting_changed_by` (`changed_by`),
  KEY `care_setting_creator` (`creator`),
  KEY `care_setting_retired_by` (`retired_by`),
  CONSTRAINT `care_setting_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `care_setting_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `care_setting_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `care_setting`
--

LOCK TABLES `care_setting` WRITE;
/*!40000 ALTER TABLE `care_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `care_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clob_datatype_storage`
--

DROP TABLE IF EXISTS `clob_datatype_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clob_datatype_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clob_datatype_storage`
--

LOCK TABLES `clob_datatype_storage` WRITE;
/*!40000 ALTER TABLE `clob_datatype_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `clob_datatype_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort`
--

DROP TABLE IF EXISTS `cohort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort` (
  `cohort_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`cohort_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `cohort_creator` (`creator`),
  KEY `user_who_changed_cohort` (`changed_by`),
  KEY `user_who_voided_cohort` (`voided_by`),
  CONSTRAINT `cohort_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort`
--

LOCK TABLES `cohort` WRITE;
/*!40000 ALTER TABLE `cohort` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort_member`
--

DROP TABLE IF EXISTS `cohort_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort_member` (
  `cohort_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `cohort_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`cohort_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `cohort_member_creator` (`creator`),
  KEY `member_patient` (`patient_id`),
  KEY `parent_cohort` (`cohort_id`),
  CONSTRAINT `cohort_member_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `member_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_cohort` FOREIGN KEY (`cohort_id`) REFERENCES `cohort` (`cohort_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort_member`
--

LOCK TABLES `cohort_member` WRITE;
/*!40000 ALTER TABLE `cohort_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept`
--

DROP TABLE IF EXISTS `concept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept` (
  `concept_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `short_name` varchar(255) DEFAULT NULL,
  `description` text,
  `form_text` text,
  `datatype_id` int(11) NOT NULL DEFAULT '0',
  `class_id` int(11) NOT NULL DEFAULT '0',
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_classes` (`class_id`),
  KEY `concept_creator` (`creator`),
  KEY `concept_datatypes` (`datatype_id`),
  KEY `user_who_changed_concept` (`changed_by`),
  KEY `user_who_retired_concept` (`retired_by`),
  CONSTRAINT `concept_classes` FOREIGN KEY (`class_id`) REFERENCES `concept_class` (`concept_class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_datatypes` FOREIGN KEY (`datatype_id`) REFERENCES `concept_datatype` (`concept_datatype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept`
--

LOCK TABLES `concept` WRITE;
/*!40000 ALTER TABLE `concept` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_answer`
--

DROP TABLE IF EXISTS `concept_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_answer` (
  `concept_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `answer_concept` int(11) DEFAULT NULL,
  `answer_drug` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_answer_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `answer` (`answer_concept`),
  KEY `answer_answer_drug_fk` (`answer_drug`),
  KEY `answer_creator` (`creator`),
  KEY `answers_for_concept` (`concept_id`),
  CONSTRAINT `answer` FOREIGN KEY (`answer_concept`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_answer_drug_fk` FOREIGN KEY (`answer_drug`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answers_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_answer`
--

LOCK TABLES `concept_answer` WRITE;
/*!40000 ALTER TABLE `concept_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_attribute`
--

DROP TABLE IF EXISTS `concept_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_attribute` (
  `concept_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `concept_attribute_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_concept_fk` (`concept_id`),
  KEY `concept_attribute_creator_fk` (`creator`),
  KEY `concept_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `concept_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `concept_attribute_type` (`concept_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_concept_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_attribute`
--

LOCK TABLES `concept_attribute` WRITE;
/*!40000 ALTER TABLE `concept_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_attribute_type`
--

DROP TABLE IF EXISTS `concept_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_attribute_type` (
  `concept_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_type_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_type_creator_fk` (`creator`),
  KEY `concept_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `concept_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_attribute_type`
--

LOCK TABLES `concept_attribute_type` WRITE;
/*!40000 ALTER TABLE `concept_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_class`
--

DROP TABLE IF EXISTS `concept_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_class` (
  `concept_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_class_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_class_changed_by` (`changed_by`),
  KEY `concept_class_creator` (`creator`),
  KEY `concept_class_name_index` (`name`),
  KEY `concept_class_retired_status` (`retired`),
  KEY `user_who_retired_concept_class` (`retired_by`),
  CONSTRAINT `concept_class_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_class_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_class`
--

LOCK TABLES `concept_class` WRITE;
/*!40000 ALTER TABLE `concept_class` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_complex`
--

DROP TABLE IF EXISTS `concept_complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_complex` (
  `concept_id` int(11) NOT NULL,
  `handler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `concept_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_complex`
--

LOCK TABLES `concept_complex` WRITE;
/*!40000 ALTER TABLE `concept_complex` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_complex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_datatype`
--

DROP TABLE IF EXISTS `concept_datatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_datatype` (
  `concept_datatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `hl7_abbreviation` varchar(3) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_datatype_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_datatype_creator` (`creator`),
  KEY `concept_datatype_name_index` (`name`),
  KEY `concept_datatype_retired_status` (`retired`),
  KEY `user_who_retired_concept_datatype` (`retired_by`),
  CONSTRAINT `concept_datatype_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_datatype`
--

LOCK TABLES `concept_datatype` WRITE;
/*!40000 ALTER TABLE `concept_datatype` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_datatype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_description`
--

DROP TABLE IF EXISTS `concept_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_description` (
  `concept_description_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_description_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `description_for_concept` (`concept_id`),
  KEY `user_who_changed_description` (`changed_by`),
  KEY `user_who_created_description` (`creator`),
  CONSTRAINT `description_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_description`
--

LOCK TABLES `concept_description` WRITE;
/*!40000 ALTER TABLE `concept_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_map_type`
--

DROP TABLE IF EXISTS `concept_map_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_map_type` (
  `concept_map_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_map_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_user_changed_concept_map_type` (`changed_by`),
  KEY `mapped_user_creator_concept_map_type` (`creator`),
  KEY `mapped_user_retired_concept_map_type` (`retired_by`),
  CONSTRAINT `mapped_user_changed_concept_map_type` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator_concept_map_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_retired_concept_map_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_map_type`
--

LOCK TABLES `concept_map_type` WRITE;
/*!40000 ALTER TABLE `concept_map_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_map_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name`
--

DROP TABLE IF EXISTS `concept_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name` (
  `concept_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `locale` varchar(50) NOT NULL DEFAULT '',
  `locale_preferred` tinyint(1) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `concept_name_type` varchar(50) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_name_changed_by` (`changed_by`),
  KEY `name_for_concept` (`concept_id`),
  KEY `name_of_concept` (`name`),
  KEY `user_who_created_name` (`creator`),
  KEY `user_who_voided_this_name` (`voided_by`),
  CONSTRAINT `concept_name_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `name_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name`
--

LOCK TABLES `concept_name` WRITE;
/*!40000 ALTER TABLE `concept_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag`
--

DROP TABLE IF EXISTS `concept_name_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag` (
  `concept_name_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) NOT NULL,
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_tag_id`),
  UNIQUE KEY `tag` (`tag`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_name_tag_changed_by` (`changed_by`),
  KEY `user_who_created_name_tag` (`creator`),
  KEY `user_who_voided_name_tag` (`voided_by`),
  CONSTRAINT `concept_name_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag`
--

LOCK TABLES `concept_name_tag` WRITE;
/*!40000 ALTER TABLE `concept_name_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag_map`
--

DROP TABLE IF EXISTS `concept_name_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag_map` (
  `concept_name_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_name` (`concept_name_id`),
  KEY `mapped_concept_name_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_name_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag_map`
--

LOCK TABLES `concept_name_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_name_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_numeric`
--

DROP TABLE IF EXISTS `concept_numeric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_numeric` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `hi_absolute` double DEFAULT NULL,
  `hi_critical` double DEFAULT NULL,
  `hi_normal` double DEFAULT NULL,
  `low_absolute` double DEFAULT NULL,
  `low_critical` double DEFAULT NULL,
  `low_normal` double DEFAULT NULL,
  `units` varchar(50) DEFAULT NULL,
  `allow_decimal` tinyint(1) DEFAULT NULL,
  `display_precision` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `numeric_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_numeric`
--

LOCK TABLES `concept_numeric` WRITE;
/*!40000 ALTER TABLE `concept_numeric` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_numeric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal`
--

DROP TABLE IF EXISTS `concept_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal` (
  `concept_proposal_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `original_text` varchar(255) NOT NULL DEFAULT '',
  `final_text` varchar(255) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `obs_concept_id` int(11) DEFAULT NULL,
  `state` varchar(32) NOT NULL DEFAULT 'UNMAPPED',
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_proposal_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_for_proposal` (`concept_id`),
  KEY `encounter_for_proposal` (`encounter_id`),
  KEY `proposal_obs_concept_id` (`obs_concept_id`),
  KEY `proposal_obs_id` (`obs_id`),
  KEY `user_who_changed_proposal` (`changed_by`),
  KEY `user_who_created_proposal` (`creator`),
  CONSTRAINT `concept_for_proposal` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_for_proposal` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `proposal_obs_concept_id` FOREIGN KEY (`obs_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `proposal_obs_id` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal`
--

LOCK TABLES `concept_proposal` WRITE;
/*!40000 ALTER TABLE `concept_proposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal_tag_map`
--

DROP TABLE IF EXISTS `concept_proposal_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal_tag_map` (
  `concept_proposal_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_proposal` (`concept_proposal_id`),
  KEY `mapped_concept_proposal_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_proposal` FOREIGN KEY (`concept_proposal_id`) REFERENCES `concept_proposal` (`concept_proposal_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_proposal_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal_tag_map`
--

LOCK TABLES `concept_proposal_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_proposal_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_map`
--

DROP TABLE IF EXISTS `concept_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_map` (
  `concept_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_reference_term_id` int(11) NOT NULL,
  `concept_map_type_id` int(11) NOT NULL DEFAULT '1',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `map_creator` (`creator`),
  KEY `map_for_concept` (`concept_id`),
  KEY `mapped_concept_map_type` (`concept_map_type_id`),
  KEY `mapped_concept_reference_term` (`concept_reference_term_id`),
  KEY `mapped_user_changed_ref_term` (`changed_by`),
  CONSTRAINT `map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `map_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_map_type` FOREIGN KEY (`concept_map_type_id`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_reference_term` FOREIGN KEY (`concept_reference_term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed_ref_term` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_map`
--

LOCK TABLES `concept_reference_map` WRITE;
/*!40000 ALTER TABLE `concept_reference_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_source`
--

DROP TABLE IF EXISTS `concept_reference_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_source` (
  `concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `hl7_code` varchar(50) DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `unique_id` varchar(250) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `hl7_code` (`hl7_code`),
  UNIQUE KEY `unique_id` (`unique_id`),
  KEY `concept_reference_source_changed_by` (`changed_by`),
  KEY `concept_source_creator` (`creator`),
  KEY `user_who_retired_concept_source` (`retired_by`),
  CONSTRAINT `concept_reference_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_source`
--

LOCK TABLES `concept_reference_source` WRITE;
/*!40000 ALTER TABLE `concept_reference_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_term`
--

DROP TABLE IF EXISTS `concept_reference_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_term` (
  `concept_reference_term_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_source_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_reference_term_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `idx_code_concept_reference_term` (`code`),
  KEY `mapped_concept_source` (`concept_source_id`),
  KEY `mapped_user_changed` (`changed_by`),
  KEY `mapped_user_creator` (`creator`),
  KEY `mapped_user_retired` (`retired_by`),
  CONSTRAINT `mapped_concept_source` FOREIGN KEY (`concept_source_id`) REFERENCES `concept_reference_source` (`concept_source_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_retired` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_term`
--

LOCK TABLES `concept_reference_term` WRITE;
/*!40000 ALTER TABLE `concept_reference_term` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_term` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_term_map`
--

DROP TABLE IF EXISTS `concept_reference_term_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_term_map` (
  `concept_reference_term_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `term_a_id` int(11) NOT NULL,
  `term_b_id` int(11) NOT NULL,
  `a_is_to_b_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_reference_term_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_concept_map_type_ref_term_map` (`a_is_to_b_id`),
  KEY `mapped_term_a` (`term_a_id`),
  KEY `mapped_term_b` (`term_b_id`),
  KEY `mapped_user_changed_ref_term_map` (`changed_by`),
  KEY `mapped_user_creator_ref_term_map` (`creator`),
  CONSTRAINT `mapped_concept_map_type_ref_term_map` FOREIGN KEY (`a_is_to_b_id`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_term_a` FOREIGN KEY (`term_a_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_term_b` FOREIGN KEY (`term_b_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed_ref_term_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator_ref_term_map` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_term_map`
--

LOCK TABLES `concept_reference_term_map` WRITE;
/*!40000 ALTER TABLE `concept_reference_term_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_term_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_set`
--

DROP TABLE IF EXISTS `concept_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_set` (
  `concept_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `concept_set` int(11) NOT NULL DEFAULT '0',
  `sort_weight` double DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `has_a` (`concept_set`),
  KEY `idx_concept_set_concept` (`concept_id`),
  KEY `user_who_created` (`creator`),
  CONSTRAINT `has_a` FOREIGN KEY (`concept_set`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_set`
--

LOCK TABLES `concept_set` WRITE;
/*!40000 ALTER TABLE `concept_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_state_conversion`
--

DROP TABLE IF EXISTS `concept_state_conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_state_conversion` (
  `concept_state_conversion_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT '0',
  `program_workflow_id` int(11) DEFAULT '0',
  `program_workflow_state_id` int(11) DEFAULT '0',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_state_conversion_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_workflow_concept_in_conversion` (`program_workflow_id`,`concept_id`),
  KEY `concept_triggers_conversion` (`concept_id`),
  KEY `conversion_to_state` (`program_workflow_state_id`),
  CONSTRAINT `concept_triggers_conversion` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `conversion_involves_workflow` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `conversion_to_state` FOREIGN KEY (`program_workflow_state_id`) REFERENCES `program_workflow_state` (`program_workflow_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_state_conversion`
--

LOCK TABLES `concept_state_conversion` WRITE;
/*!40000 ALTER TABLE `concept_state_conversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_state_conversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_stop_word`
--

DROP TABLE IF EXISTS `concept_stop_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_stop_word` (
  `concept_stop_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(50) NOT NULL,
  `locale` varchar(50) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_stop_word_id`),
  UNIQUE KEY `Unique_StopWord_Key` (`word`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_stop_word`
--

LOCK TABLES `concept_stop_word` WRITE;
/*!40000 ALTER TABLE `concept_stop_word` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_stop_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT,
  `additional_detail` varchar(255) DEFAULT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `condition_coded` int(11) DEFAULT NULL,
  `condition_non_coded` varchar(255) DEFAULT NULL,
  `condition_coded_name` int(11) DEFAULT NULL,
  `clinical_status` varchar(50) NOT NULL,
  `verification_status` varchar(50) DEFAULT NULL,
  `onset_date` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`condition_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `condition_changed_by_fk` (`changed_by`),
  KEY `condition_condition_coded_fk` (`condition_coded`),
  KEY `condition_condition_coded_name_fk` (`condition_coded_name`),
  KEY `condition_creator_fk` (`creator`),
  KEY `condition_patient_fk` (`patient_id`),
  KEY `condition_previous_version_fk` (`previous_version`),
  KEY `condition_voided_by_fk` (`voided_by`),
  CONSTRAINT `condition_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_condition_coded_fk` FOREIGN KEY (`condition_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_condition_coded_name_fk` FOREIGN KEY (`condition_coded_name`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_previous_version_fk` FOREIGN KEY (`previous_version`) REFERENCES `conditions` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `combination` tinyint(1) NOT NULL DEFAULT '0',
  `dosage_form` int(11) DEFAULT NULL,
  `maximum_daily_dose` double DEFAULT NULL,
  `minimum_daily_dose` double DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `strength` varchar(255) DEFAULT NULL,
  `dose_limit_units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `dosage_form_concept` (`dosage_form`),
  KEY `drug_changed_by` (`changed_by`),
  KEY `drug_creator` (`creator`),
  KEY `drug_dose_limit_units_fk` (`dose_limit_units`),
  KEY `drug_retired_by` (`retired_by`),
  KEY `primary_drug_concept` (`concept_id`),
  KEY `route_concept` (`route`),
  CONSTRAINT `dosage_form_concept` FOREIGN KEY (`dosage_form`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_dose_limit_units_fk` FOREIGN KEY (`dose_limit_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `primary_drug_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug`
--

LOCK TABLES `drug` WRITE;
/*!40000 ALTER TABLE `drug` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_ingredient`
--

DROP TABLE IF EXISTS `drug_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_ingredient` (
  `drug_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `uuid` char(38) NOT NULL,
  `strength` double DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`,`ingredient_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `drug_ingredient_ingredient_id_fk` (`ingredient_id`),
  KEY `drug_ingredient_units_fk` (`units`),
  CONSTRAINT `drug_ingredient_drug_id_fk` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_ingredient_ingredient_id_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_ingredient_units_fk` FOREIGN KEY (`units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_ingredient`
--

LOCK TABLES `drug_ingredient` WRITE;
/*!40000 ALTER TABLE `drug_ingredient` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_order`
--

DROP TABLE IF EXISTS `drug_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `drug_inventory_id` int(11) DEFAULT NULL,
  `dose` double DEFAULT NULL,
  `as_needed` tinyint(1) DEFAULT NULL,
  `dosing_type` varchar(255) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `as_needed_condition` varchar(255) DEFAULT NULL,
  `num_refills` int(11) DEFAULT NULL,
  `dosing_instructions` text,
  `duration` int(11) DEFAULT NULL,
  `duration_units` int(11) DEFAULT NULL,
  `quantity_units` int(11) DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `dose_units` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `brand_name` varchar(255) DEFAULT NULL,
  `dispense_as_written` tinyint(1) NOT NULL DEFAULT '0',
  `drug_non_coded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `drug_order_dose_units` (`dose_units`),
  KEY `drug_order_duration_units_fk` (`duration_units`),
  KEY `drug_order_frequency_fk` (`frequency`),
  KEY `drug_order_quantity_units` (`quantity_units`),
  KEY `drug_order_route_fk` (`route`),
  KEY `inventory_item` (`drug_inventory_id`),
  CONSTRAINT `drug_order_dose_units` FOREIGN KEY (`dose_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_duration_units_fk` FOREIGN KEY (`duration_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_quantity_units` FOREIGN KEY (`quantity_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_route_fk` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `extends_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `inventory_item` FOREIGN KEY (`drug_inventory_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_order`
--

LOCK TABLES `drug_order` WRITE;
/*!40000 ALTER TABLE `drug_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_reference_map`
--

DROP TABLE IF EXISTS `drug_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_reference_map` (
  `drug_reference_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `concept_map_type` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`drug_reference_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_map_type_for_drug_reference_map` (`concept_map_type`),
  KEY `concept_reference_term_for_drug_reference_map` (`term_id`),
  KEY `drug_for_drug_reference_map` (`drug_id`),
  KEY `drug_reference_map_creator` (`creator`),
  KEY `user_who_changed_drug_reference_map` (`changed_by`),
  KEY `user_who_retired_drug_reference_map` (`retired_by`),
  CONSTRAINT `concept_map_type_for_drug_reference_map` FOREIGN KEY (`concept_map_type`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_reference_term_for_drug_reference_map` FOREIGN KEY (`term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_for_drug_reference_map` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_reference_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_reference_map`
--

LOCK TABLES `drug_reference_map` WRITE;
/*!40000 ALTER TABLE `drug_reference_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_reference_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_type` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT NULL,
  `form_id` int(11) DEFAULT NULL,
  `encounter_datetime` datetime NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_changed_by` (`changed_by`),
  KEY `encounter_datetime_idx` (`encounter_datetime`),
  KEY `encounter_form` (`form_id`),
  KEY `encounter_ibfk_1` (`creator`),
  KEY `encounter_location` (`location_id`),
  KEY `encounter_patient` (`patient_id`),
  KEY `encounter_type_id` (`encounter_type`),
  KEY `encounter_visit_id_fk` (`visit_id`),
  KEY `user_who_voided_encounter` (`voided_by`),
  CONSTRAINT `encounter_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_form` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `encounter_type_id` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_visit_id_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_diagnosis`
--

DROP TABLE IF EXISTS `encounter_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_diagnosis` (
  `diagnosis_id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_coded` int(11) DEFAULT NULL,
  `diagnosis_non_coded` varchar(255) DEFAULT NULL,
  `diagnosis_coded_name` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `condition_id` int(11) DEFAULT NULL,
  `certainty` varchar(255) NOT NULL,
  `rank` int(11) NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`diagnosis_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_diagnosis_changed_by_fk` (`changed_by`),
  KEY `encounter_diagnosis_coded_fk` (`diagnosis_coded`),
  KEY `encounter_diagnosis_coded_name_fk` (`diagnosis_coded_name`),
  KEY `encounter_diagnosis_condition_id_fk` (`condition_id`),
  KEY `encounter_diagnosis_creator_fk` (`creator`),
  KEY `encounter_diagnosis_encounter_id_fk` (`encounter_id`),
  KEY `encounter_diagnosis_patient_fk` (`patient_id`),
  KEY `encounter_diagnosis_voided_by_fk` (`voided_by`),
  CONSTRAINT `encounter_diagnosis_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_coded_fk` FOREIGN KEY (`diagnosis_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_coded_name_fk` FOREIGN KEY (`diagnosis_coded_name`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_condition_id_fk` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_diagnosis`
--

LOCK TABLES `encounter_diagnosis` WRITE;
/*!40000 ALTER TABLE `encounter_diagnosis` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_provider`
--

DROP TABLE IF EXISTS `encounter_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_provider` (
  `encounter_provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `encounter_role_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_id_fk` (`encounter_id`),
  KEY `encounter_provider_changed_by` (`changed_by`),
  KEY `encounter_provider_creator` (`creator`),
  KEY `encounter_provider_voided_by` (`voided_by`),
  KEY `encounter_role_id_fk` (`encounter_role_id`),
  KEY `provider_id_fk` (`provider_id`),
  CONSTRAINT `encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_id_fk` FOREIGN KEY (`encounter_role_id`) REFERENCES `encounter_role` (`encounter_role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_provider`
--

LOCK TABLES `encounter_provider` WRITE;
/*!40000 ALTER TABLE `encounter_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_role`
--

DROP TABLE IF EXISTS `encounter_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_role` (
  `encounter_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_role_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_role_changed_by_fk` (`changed_by`),
  KEY `encounter_role_creator_fk` (`creator`),
  KEY `encounter_role_retired_by_fk` (`retired_by`),
  CONSTRAINT `encounter_role_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_role`
--

LOCK TABLES `encounter_role` WRITE;
/*!40000 ALTER TABLE `encounter_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_type`
--

DROP TABLE IF EXISTS `encounter_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_type` (
  `encounter_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `view_privilege` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_type_changed_by` (`changed_by`),
  KEY `encounter_type_retired_status` (`retired`),
  KEY `privilege_which_can_edit_encounter_type` (`edit_privilege`),
  KEY `privilege_which_can_view_encounter_type` (`view_privilege`),
  KEY `user_who_created_type` (`creator`),
  KEY `user_who_retired_encounter_type` (`retired_by`),
  CONSTRAINT `encounter_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_edit_encounter_type` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_view_encounter_type` FOREIGN KEY (`view_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_type`
--

LOCK TABLES `encounter_type` WRITE;
/*!40000 ALTER TABLE `encounter_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `field_type` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  `default_value` text,
  `select_multiple` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_for_field` (`concept_id`),
  KEY `field_retired_status` (`retired`),
  KEY `type_of_field` (`field_type`),
  KEY `user_who_changed_field` (`changed_by`),
  KEY `user_who_created_field` (`creator`),
  KEY `user_who_retired_field` (`retired_by`),
  CONSTRAINT `concept_for_field` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_answer`
--

DROP TABLE IF EXISTS `field_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_answer` (
  `field_id` int(11) NOT NULL DEFAULT '0',
  `answer_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_id`,`answer_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `field_answer_concept` (`answer_id`),
  KEY `user_who_created_field_answer` (`creator`),
  CONSTRAINT `answers_for_field` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `field_answer_concept` FOREIGN KEY (`answer_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_answer`
--

LOCK TABLES `field_answer` WRITE;
/*!40000 ALTER TABLE `field_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_type`
--

DROP TABLE IF EXISTS `field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_type` (
  `field_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_who_created_field_type` (`creator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_type`
--

LOCK TABLES `field_type` WRITE;
/*!40000 ALTER TABLE `field_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(50) NOT NULL DEFAULT '',
  `build` int(11) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `xslt` text,
  `template` text,
  `description` text,
  `encounter_type` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `form_encounter_type` (`encounter_type`),
  KEY `form_published_and_retired_index` (`published`,`retired`),
  KEY `form_published_index` (`published`),
  KEY `form_retired_index` (`retired`),
  KEY `user_who_created_form` (`creator`),
  KEY `user_who_last_changed_form` (`changed_by`),
  KEY `user_who_retired_form` (`retired_by`),
  CONSTRAINT `form_encounter_type` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_field` (
  `form_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL DEFAULT '0',
  `field_number` int(11) DEFAULT NULL,
  `field_part` varchar(5) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `parent_form_field` int(11) DEFAULT NULL,
  `min_occurs` int(11) DEFAULT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `sort_weight` float DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_field_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `field_within_form` (`field_id`),
  KEY `form_containing_field` (`form_id`),
  KEY `form_field_hierarchy` (`parent_form_field`),
  KEY `user_who_created_form_field` (`creator`),
  KEY `user_who_last_changed_form_field` (`changed_by`),
  CONSTRAINT `field_within_form` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_containing_field` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_field_hierarchy` FOREIGN KEY (`parent_form_field`) REFERENCES `form_field` (`form_field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_field`
--

LOCK TABLES `form_field` WRITE;
/*!40000 ALTER TABLE `form_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_resource`
--

DROP TABLE IF EXISTS `form_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_resource` (
  `form_resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value_reference` text NOT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`form_resource_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_form_and_name` (`form_id`,`name`),
  KEY `form_resource_changed_by` (`changed_by`),
  CONSTRAINT `form_resource_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_resource_form_fk` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_resource`
--

LOCK TABLES `form_resource` WRITE;
/*!40000 ALTER TABLE `form_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_property`
--

DROP TABLE IF EXISTS `global_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_property` (
  `property` varchar(255) NOT NULL DEFAULT '',
  `property_value` text,
  `description` text,
  `uuid` char(38) NOT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`property`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `global_property_changed_by` (`changed_by`),
  CONSTRAINT `global_property_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_property`
--

LOCK TABLES `global_property` WRITE;
/*!40000 ALTER TABLE `global_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `global_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_archive`
--

DROP TABLE IF EXISTS `hl7_in_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_archive` (
  `hl7_in_archive_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` varchar(255) DEFAULT NULL,
  `hl7_data` text NOT NULL,
  `date_created` datetime NOT NULL,
  `message_state` int(11) DEFAULT '2',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_archive_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `hl7_in_archive_message_state_idx` (`message_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_archive`
--

LOCK TABLES `hl7_in_archive` WRITE;
/*!40000 ALTER TABLE `hl7_in_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_error`
--

DROP TABLE IF EXISTS `hl7_in_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_error` (
  `hl7_in_error_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` text NOT NULL,
  `error` varchar(255) NOT NULL DEFAULT '',
  `error_details` mediumtext,
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_error_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_error`
--

LOCK TABLES `hl7_in_error` WRITE;
/*!40000 ALTER TABLE `hl7_in_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_queue`
--

DROP TABLE IF EXISTS `hl7_in_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_queue` (
  `hl7_in_queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` text NOT NULL,
  `message_state` int(11) NOT NULL DEFAULT '0',
  `date_processed` datetime DEFAULT NULL,
  `error_msg` text,
  `date_created` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_queue_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `hl7_source_with_queue` (`hl7_source`),
  CONSTRAINT `hl7_source_with_queue` FOREIGN KEY (`hl7_source`) REFERENCES `hl7_source` (`hl7_source_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_queue`
--

LOCK TABLES `hl7_in_queue` WRITE;
/*!40000 ALTER TABLE `hl7_in_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_source`
--

DROP TABLE IF EXISTS `hl7_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_source` (
  `hl7_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_who_created_hl7_source` (`creator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_source`
--

LOCK TABLES `hl7_source` WRITE;
/*!40000 ALTER TABLE `hl7_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangelog`
--

DROP TABLE IF EXISTS `liquibasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangelog` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangelog`
--

LOCK TABLES `liquibasechangelog` WRITE;
/*!40000 ALTER TABLE `liquibasechangelog` DISABLE KEYS */;
INSERT INTO `liquibasechangelog` VALUES ('1582473628795-1','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:17:58',1,'EXECUTED','8:238fe3f03c37d18fd5117d58579b728e','createTable tableName=allergy','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-2','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:17:59',2,'EXECUTED','8:66bfc8234785132bb19d738a38149dac','createTable tableName=allergy_reaction','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-3','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:00',3,'EXECUTED','8:a1cf873fe69c959aac6a8bc560123db3','createTable tableName=care_setting','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-4','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:02',4,'EXECUTED','8:08dd21485e374a9c23ba168f86e688d8','createTable tableName=clob_datatype_storage','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-5','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:06',5,'EXECUTED','8:98cad85af2e0bb7a64b85d4b476095a7','createTable tableName=cohort','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-6','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:07',6,'EXECUTED','8:4df18ea17f9c077a6c66cf1609c031dd','createTable tableName=cohort_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-7','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:09',7,'EXECUTED','8:439539bcb3d94c4d0e269296b23ef70b','createTable tableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-8','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:09',8,'EXECUTED','8:c34dc6adc6f35bd0c9051ba65a015005','createTable tableName=concept_answer','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-9','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:09',9,'EXECUTED','8:ef8fd51526a17665cadd10c91742740f','createTable tableName=concept_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-10','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:10',10,'EXECUTED','8:142ed55c82ea3c39531b89202caf1bc1','createTable tableName=concept_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-11','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:10',11,'EXECUTED','8:f44a280ff3f4b390728c61c709126fbd','createTable tableName=concept_class','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-12','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:11',12,'EXECUTED','8:9095b0e88b571c2edd43af0e662c9d54','createTable tableName=concept_complex','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-13','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:12',13,'EXECUTED','8:3679f7729afe800446d8cedf68fd3c26','createTable tableName=concept_datatype','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-14','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:12',14,'EXECUTED','8:006e0e83f27be58d38265254c4c73a18','createTable tableName=concept_description','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-15','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:14',15,'EXECUTED','8:201f1eee264b3524160f726e2bb01ad4','createTable tableName=concept_map_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-16','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:15',16,'EXECUTED','8:496f72fa38dba348042ab0cf169341cb','createTable tableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-17','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:15',17,'EXECUTED','8:ef87738c7dadd667412bfa1d9b334ee0','createTable tableName=concept_name_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-18','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:16',18,'EXECUTED','8:2ad1f3969d4447ec88134a92452372cc','createTable tableName=concept_name_tag_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-19','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:17',19,'EXECUTED','8:5c452fab1bf82808191c0e716b21495d','createTable tableName=concept_numeric','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-20','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:18',20,'EXECUTED','8:19ca40eebcedeaaa6a79f23969cff287','createTable tableName=concept_proposal','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-21','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:19',21,'EXECUTED','8:32485f3a60b8038b6bec0697ec1925c8','createTable tableName=concept_proposal_tag_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-22','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:20',22,'EXECUTED','8:6e89e74287cb308de5f82102413a0439','createTable tableName=concept_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-23','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:21',23,'EXECUTED','8:8c39f2171bac697c43c1aec40549978b','createTable tableName=concept_reference_source','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-24','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:23',24,'EXECUTED','8:2311a8ad536e93f51f23b6330144974c','createTable tableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-25','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:27',25,'EXECUTED','8:db7361e2e3134136d7311020e001dfe3','createTable tableName=concept_reference_term_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-26','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:28',26,'EXECUTED','8:6d84f3d7e12a72c45f6a9be7eb4b36a7','createTable tableName=concept_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-27','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:29',27,'EXECUTED','8:ec244808f1b0894a53f3c73acdd09692','createTable tableName=concept_state_conversion','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-28','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:30',28,'EXECUTED','8:03eb15e1b88a1c9f5d95079011881fcb','createTable tableName=concept_stop_word','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-29','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:31',29,'EXECUTED','8:dd9d9e6b445cbced1ae746e0bc039cd5','createTable tableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-30','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:33',30,'EXECUTED','8:75fe79aac8155c708d4d886d97edc2ad','createTable tableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-31','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:33',31,'EXECUTED','8:fa53b9d6b5ca90f4f1dd3f9b7dc6ac7b','createTable tableName=drug_ingredient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-32','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:34',32,'EXECUTED','8:e1931d61b5e0d3f19ca14dd4a3f8d470','createTable tableName=drug_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-33','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:35',33,'EXECUTED','8:789061a8116ebbcc436e7184ea642fc0','createTable tableName=drug_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-34','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:36',34,'EXECUTED','8:e01652d1cc10267c54c08aa6c69fa267','createTable tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-35','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:37',35,'EXECUTED','8:327278fc23b24c74246bc786b3aa86d9','createTable tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-36','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:38',36,'EXECUTED','8:d39433ac66c5db9697439993cd37745d','createTable tableName=encounter_provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-37','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:39',37,'EXECUTED','8:2ea2d318a7d4712bb4ec4ac5a23acb95','createTable tableName=encounter_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-38','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:42',38,'EXECUTED','8:23ef531c5e1cfa984985d17897f153c8','createTable tableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-39','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:45',39,'EXECUTED','8:948f7dfe7f7d954636d2ddceba471b2d','createTable tableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-40','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:49',40,'EXECUTED','8:dd5b1cadb5a56575a7e8cd8462fbb7e1','createTable tableName=field_answer','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-41','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:50',41,'EXECUTED','8:9d0f4e40b82245078bcd22174f82452f','createTable tableName=field_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-42','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:51',42,'EXECUTED','8:62cab75a02e38a79d1cf948219d8189a','createTable tableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-43','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:52',43,'EXECUTED','8:3de5017a3753d3a6e0a7593c6411e260','createTable tableName=form_field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-44','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:54',44,'EXECUTED','8:91e80c748bf1462e41411ac3feadfd57','createTable tableName=form_resource','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-45','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:54',45,'EXECUTED','8:a295f3ad50a0faab26d885e4a3ffc386','createTable tableName=global_property','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-46','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:55',46,'EXECUTED','8:02ce7a54be6683048b3bfd01944c0303','createTable tableName=hl7_in_archive','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-47','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:18:59',47,'EXECUTED','8:089a56e623784de5510d377e1a5c0fb7','createTable tableName=hl7_in_error','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-48','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:01',48,'EXECUTED','8:ca099d7b4600624db7b78b762b0a3b02','createTable tableName=hl7_in_queue','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-49','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:03',49,'EXECUTED','8:0c39e5581a2dd23a769b82b1a0377d3a','createTable tableName=hl7_source','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-52','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:04',50,'EXECUTED','8:e8848a5f02cf220d27fb281cb8cc858c','createTable tableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-53','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:06',51,'EXECUTED','8:f0ad9d30f2a4eb80b5d14f22fb2414e8','createTable tableName=location_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-54','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:07',52,'EXECUTED','8:51c85eeebcc3a9312db41105fe3dca49','createTable tableName=location_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-55','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:09',53,'EXECUTED','8:b9360b112a62e90b0014e49f835c5d3d','createTable tableName=location_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-56','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:10',54,'EXECUTED','8:c1c62de3067d99bd88bd0ddda1e4ff19','createTable tableName=location_tag_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-57','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:14',55,'EXECUTED','8:81ceb9f89c4271def4031a92a4c93664','createTable tableName=note','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-58','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:15',56,'EXECUTED','8:eace5025507e76a3678701a1382782c4','createTable tableName=notification_alert','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-59','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:16',57,'EXECUTED','8:295b72dcc114cfa85d967adc8b27a01a','createTable tableName=notification_alert_recipient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-60','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:17',58,'EXECUTED','8:e9e05b5a3371d945f2e773f3d1ada6c1','createTable tableName=notification_template','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-61','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:19',59,'EXECUTED','8:9ec0fb1d838b0a5fdfed897f841c6c2e','createTable tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-62','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:20',60,'EXECUTED','8:53a44b946d8ca5c27930fa1b821a9c0b','createTable tableName=order_frequency','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-63','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:21',61,'EXECUTED','8:f21d6287908349a10902b5ddad46a444','createTable tableName=order_group','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-64','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:22',62,'EXECUTED','8:b0e480c587aad19df5fe32c3e8de3026','createTable tableName=order_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-65','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:23',63,'EXECUTED','8:51966d28f8d45998212887fc2d6658e0','createTable tableName=order_set_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-66','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:24',64,'EXECUTED','8:f65d4f171b22df2632798a54d9d71bc5','createTable tableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-67','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:25',65,'EXECUTED','8:3617a5326201bdd34ee64548fa81f670','createTable tableName=order_type_class_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-68','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:26',66,'EXECUTED','8:16b1d52d372ef877b87c83683a6f412e','createTable tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-69','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:28',67,'EXECUTED','8:8954c91117bc5b5d8c4e035c59f2d3f5','createTable tableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-70','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:29',68,'EXECUTED','8:8079e93f1a5eb390c72f60f03ea38633','createTable tableName=patient_identifier','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-71','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:29',69,'EXECUTED','8:45adf630810c6bc7baedc9e80f3fa78f','createTable tableName=patient_identifier_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-72','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:30',70,'EXECUTED','8:6441e3670907d81ad00d689d1b84a44b','createTable tableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-73','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:31',71,'EXECUTED','8:05b0103e4d69508557b17249ff869b0c','createTable tableName=patient_program_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-74','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:32',72,'EXECUTED','8:c6e7edf42161c56fcab9d2cefb8053a8','createTable tableName=patient_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-75','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:34',73,'EXECUTED','8:2d5da170c140d7e80e2f9e8b6c0ea2f4','createTable tableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-76','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:35',74,'EXECUTED','8:47e57060ce4d4799b75ed23a8c8d5069','createTable tableName=person_address','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-77','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:36',75,'EXECUTED','8:5403117950f628ee69d642012e32ed76','createTable tableName=person_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-78','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:38',76,'EXECUTED','8:805580f60917bb3713db9bf2bce7b8c5','createTable tableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-79','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:40',77,'EXECUTED','8:ef9fa12dd20b6d69932251edf73787aa','createTable tableName=person_merge_log','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-80','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:43',78,'EXECUTED','8:bfd52cee713336403616d1c16ecfff94','createTable tableName=person_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-81','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:45',79,'EXECUTED','8:bc93a477857f42a0a2f5ce0cf130c06f','createTable tableName=privilege','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-82','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:46',80,'EXECUTED','8:6d47747541bf72c208d48bd34639725d','createTable tableName=program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-83','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:47',81,'EXECUTED','8:0b8b7645ef730dba3a0845533b18d2cf','createTable tableName=program_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-84','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:49',82,'EXECUTED','8:52d5ade33710854bcdf137920a600e33','createTable tableName=program_workflow','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-85','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:50',83,'EXECUTED','8:6165bf55147465316ff8a4db11aa3d7e','createTable tableName=program_workflow_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-86','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:51',84,'EXECUTED','8:aad0b2a94e29051a379ec9d731994627','createTable tableName=provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-87','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:53',85,'EXECUTED','8:e707b8ba8979f2e6161dc9b2c3789165','createTable tableName=provider_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-88','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:54',86,'EXECUTED','8:b0ef5d173d29f94047ae72eaa975ec0e','createTable tableName=provider_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-89','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:55',87,'EXECUTED','8:028a98c61666a9ef47936fd43f604f74','createTable tableName=relationship','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-90','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:55',88,'EXECUTED','8:b9a14edd7429c747153832947b450e8f','createTable tableName=relationship_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-91','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:19:57',89,'EXECUTED','8:206b767bb1c039465101506583b16269','createTable tableName=report_object','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-92','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:00',90,'EXECUTED','8:0d190523553cd8b01deffceac791821a','createTable tableName=report_schema_xml','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-93','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:03',91,'EXECUTED','8:aeae38f3d61d4fa234c16de406c8ce5a','createTable tableName=role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-94','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:04',92,'EXECUTED','8:262d2a3bec8ed138c8341604ed61623b','createTable tableName=role_privilege','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-95','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:04',93,'EXECUTED','8:08f5e5ca18573dc55e4b21c1310ea6a1','createTable tableName=role_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-96','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:06',94,'EXECUTED','8:795792e2c4a34a1b14e315c33c26aad7','createTable tableName=scheduler_task_config','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-97','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:06',95,'EXECUTED','8:9417a129dd10a6b5084c58753a8d7e8e','createTable tableName=scheduler_task_config_property','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-98','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:08',96,'EXECUTED','8:af1fe94b4ccbbcb29ded2279e2b21e95','createTable tableName=serialized_object','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-99','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:08',97,'EXECUTED','8:43237f7dd8bb33bb478bdaf0bb725a05','createTable tableName=test_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-100','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:10',98,'EXECUTED','8:5311325d6a46d0feb522ff60d8a5cf80','createTable tableName=user_property','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-101','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:10',99,'EXECUTED','8:5a15316575ed6969069e2c906af3b12b','createTable tableName=user_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-102','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:11',100,'EXECUTED','8:8097a95686fc72d4eee52b904b8517f1','createTable tableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-103','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:12',101,'EXECUTED','8:4c2f1c04b745bbf720c94d08f824439d','createTable tableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-104','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:13',102,'EXECUTED','8:94fc7056b587c4d5291ae12880439d10','createTable tableName=visit_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-105','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:14',103,'EXECUTED','8:e3fff16d34de807a446d0d5a331ef929','createTable tableName=visit_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-106','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:16',104,'EXECUTED','8:fe8c5f6c57c52f28ac22bcf213575434','createTable tableName=visit_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-107','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:17',105,'EXECUTED','8:e6e767dc77131b1867f0eca3cf137607','addUniqueConstraint constraintName=Unique_StopWord_Key, tableName=concept_stop_word','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-108','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:17',106,'EXECUTED','8:89adbb595c96cd430a0b511ae01ff6a0','addUniqueConstraint constraintName=unique_form_and_name, tableName=form_resource','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-109','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:18',107,'EXECUTED','8:3164a86460597775566f339b7988025b','addUniqueConstraint constraintName=unique_workflow_concept_in_conversion, tableName=concept_state_conversion','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-110','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:19',108,'EXECUTED','8:b333d65cbce8404063a1a9c49de4448f','createIndex indexName=address_for_person, tableName=person_address','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-111','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:20',109,'EXECUTED','8:66771b59765b7d074573fc820d0cd3fe','createIndex indexName=alert_creator, tableName=notification_alert','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-112','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:21',110,'EXECUTED','8:8147fa6e97c11507e1f592303259720e','createIndex indexName=alert_date_to_expire_idx, tableName=notification_alert','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-113','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:21',111,'EXECUTED','8:3191e265a3b57b0521ac0f34acec54a3','createIndex indexName=alert_read_by_user, tableName=notification_alert_recipient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-114','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:23',112,'EXECUTED','8:f5fae48654f180b62cf26898cd7f9459','createIndex indexName=allergy_changed_by_fk, tableName=allergy','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-115','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:23',113,'EXECUTED','8:21221492eb4e97daa9035b20a84f906a','createIndex indexName=allergy_coded_allergen_fk, tableName=allergy','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-116','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:24',114,'EXECUTED','8:b1d6b67f44e93f9b02919352b5aacaad','createIndex indexName=allergy_creator_fk, tableName=allergy','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-117','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:25',115,'EXECUTED','8:3802de1996f1d6d8960ff81b4e7a8490','createIndex indexName=allergy_patient_id_fk, tableName=allergy','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-118','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:25',116,'EXECUTED','8:73c8f4df0e4b017640c1dbd16aa29dc7','createIndex indexName=allergy_reaction_allergy_id_fk, tableName=allergy_reaction','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-119','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:27',117,'EXECUTED','8:0c7772d6190cbac7f586dddedfddc53a','createIndex indexName=allergy_reaction_reaction_concept_id_fk, tableName=allergy_reaction','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-120','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:27',118,'EXECUTED','8:1c9aac1012a9f0aa9ffd18108fb78c7b','createIndex indexName=allergy_severity_concept_id_fk, tableName=allergy','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-121','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:28',119,'EXECUTED','8:26d5e7fcd5345ba55707d1e45d68f384','createIndex indexName=allergy_voided_by_fk, tableName=allergy','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-122','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:29',120,'EXECUTED','8:6085d7b477502bb8c100914454572165','createIndex indexName=answer, tableName=concept_answer','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-123','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:30',121,'EXECUTED','8:6b328688423a699018d015f3de50e7d9','createIndex indexName=answer_answer_drug_fk, tableName=concept_answer','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-124','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:35',122,'EXECUTED','8:e149c8cd912ab791878266048cdc5f66','createIndex indexName=answer_concept, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-125','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:41',123,'EXECUTED','8:4cff1dfa775ab85432147fc7a9bc45bb','createIndex indexName=answer_concept_drug, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-126','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:44',124,'EXECUTED','8:cb0f8b09f946ae6f4de454a9b3c73d14','createIndex indexName=answer_creator, tableName=concept_answer','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-127','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:45',125,'EXECUTED','8:aafb0f0bbcc38efaea28ef6a0d0279b9','createIndex indexName=answers_for_concept, tableName=concept_answer','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-128','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:47',126,'EXECUTED','8:b932dbce6343d0824d78fb1ab6bafe63','createIndex indexName=attribute_changer, tableName=person_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-129','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:47',127,'EXECUTED','8:5efc1f8e26031e3b01c73abefbd04d97','createIndex indexName=attribute_creator, tableName=person_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-130','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:48',128,'EXECUTED','8:9685bc73a05b10f134eb4094de4454fd','createIndex indexName=attribute_is_searchable, tableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-131','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:49',129,'EXECUTED','8:8ee4bc666d3f825b7fd1b219483b31c9','createIndex indexName=attribute_type_changer, tableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-132','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:50',130,'EXECUTED','8:2d33f303d66728b36c2613fbdbf1aaee','createIndex indexName=attribute_type_creator, tableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-133','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:51',131,'EXECUTED','8:cdc02e232fe6637a419142acd22d6931','createIndex indexName=attribute_voider, tableName=person_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-134','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:52',132,'EXECUTED','8:58d7b7938a86384a410898cb2af13e8c','createIndex indexName=care_setting_changed_by, tableName=care_setting','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-135','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:53',133,'EXECUTED','8:bbe2e850c9553c682b0b81a09d28bea2','createIndex indexName=care_setting_creator, tableName=care_setting','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-136','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:54',134,'EXECUTED','8:5cf3a54d398cc896218fbf6e3b298995','createIndex indexName=care_setting_retired_by, tableName=care_setting','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-137','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:55',135,'EXECUTED','8:6e0c003dc134e780289f4bbed82aa8ac','createIndex indexName=category_order_set_fk, tableName=order_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-138','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:55',136,'EXECUTED','8:f09e2fb2224ce21fcef36d29b130aa92','createIndex indexName=cohort_creator, tableName=cohort','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-139','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:56',137,'EXECUTED','8:4029038a2a09d5f0815d7e34592c64be','createIndex indexName=cohort_member_creator, tableName=cohort_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-140','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:57',138,'EXECUTED','8:606356b2cb0496204c4d88883957bd25','createIndex indexName=concept_attribute_attribute_type_id_fk, tableName=concept_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-141','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:58',139,'EXECUTED','8:1e05001c3a7a9e8a9eb97183fc608c2b','createIndex indexName=concept_attribute_changed_by_fk, tableName=concept_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-142','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:20:59',140,'EXECUTED','8:5f96f8798e5b7b9da72c45b3dc81ac9d','createIndex indexName=concept_attribute_concept_fk, tableName=concept_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-143','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:00',141,'EXECUTED','8:c89c712442a89f2d07ea21f6b60ffc1a','createIndex indexName=concept_attribute_creator_fk, tableName=concept_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-144','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:01',142,'EXECUTED','8:c10f39874bf68963958a72412fe6bcac','createIndex indexName=concept_attribute_type_changed_by_fk, tableName=concept_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-145','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:03',143,'EXECUTED','8:28845acfb2c6fa84d47ce725c57f8794','createIndex indexName=concept_attribute_type_creator_fk, tableName=concept_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-146','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:05',144,'EXECUTED','8:edf32967a9d82155a0ea8dd8eb2ab6e1','createIndex indexName=concept_attribute_type_retired_by_fk, tableName=concept_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-147','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:05',145,'EXECUTED','8:723ad3f4df5d4e3dfd3a85d5ab9b541e','createIndex indexName=concept_attribute_voided_by_fk, tableName=concept_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-148','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:06',146,'EXECUTED','8:4074c61d6b4dae4ab5df098dc9546d7b','createIndex indexName=concept_class_changed_by, tableName=concept_class','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-149','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:07',147,'EXECUTED','8:d2fe72bcd363d8819fae99cfa833b6bb','createIndex indexName=concept_class_creator, tableName=concept_class','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-150','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:09',148,'EXECUTED','8:6e676415380fef7f1ac0d9f9033aca69','createIndex indexName=concept_class_name_index, tableName=concept_class','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-151','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:10',149,'EXECUTED','8:38e8f613e1b7a518ba6ed47e80e6f8ca','createIndex indexName=concept_class_retired_status, tableName=concept_class','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-152','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:11',150,'EXECUTED','8:b74346ab17f12599f02e5bea00781e31','createIndex indexName=concept_classes, tableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-153','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:12',151,'EXECUTED','8:f302942598e5281d4edaa8eab7b4ade4','createIndex indexName=concept_creator, tableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-154','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:13',152,'EXECUTED','8:8af66bd30f40514f5663229d3f558a52','createIndex indexName=concept_datatype_creator, tableName=concept_datatype','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-155','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:14',153,'EXECUTED','8:0eb97161e6a7cea441a2ed63e804feaa','createIndex indexName=concept_datatype_name_index, tableName=concept_datatype','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-156','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:14',154,'EXECUTED','8:988e10b41ee14ab190aabac3111ecc84','createIndex indexName=concept_datatype_retired_status, tableName=concept_datatype','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-157','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:15',155,'EXECUTED','8:e9d6fb1e47328e7d59c1ddbf308dea70','createIndex indexName=concept_datatypes, tableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-158','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:17',156,'EXECUTED','8:b245869dccd4b5adbc79240f66334db4','createIndex indexName=concept_for_field, tableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-159','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:18',157,'EXECUTED','8:b47fb81e5fd807f6999454f313e4fb88','createIndex indexName=concept_for_proposal, tableName=concept_proposal','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-160','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:18',158,'EXECUTED','8:9d6067722574739babcf829fd7005083','createIndex indexName=concept_map_type_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-161','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:19',159,'EXECUTED','8:446797c99cbd566e631792db3f446eb0','createIndex indexName=concept_name_changed_by, tableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-162','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:20',160,'EXECUTED','8:fe80f22f46e05ec71478e7ce7c665681','createIndex indexName=concept_name_tag_changed_by, tableName=concept_name_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-163','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:20',161,'EXECUTED','8:97a9fac7c24c6ceb695c173082b6de53','createIndex indexName=concept_reference_source_changed_by, tableName=concept_reference_source','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-164','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:22',162,'EXECUTED','8:983653514a7c9e3c9e7cb3f06f845759','createIndex indexName=concept_reference_term_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-165','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:23',163,'EXECUTED','8:11669081562535928754bc5bcc11a180','createIndex indexName=concept_source_creator, tableName=concept_reference_source','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-166','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:24',164,'EXECUTED','8:87a8f1b58cf4f932acdd05c7e1590ff4','createIndex indexName=concept_triggers_conversion, tableName=concept_state_conversion','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-167','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:24',165,'EXECUTED','8:7369c064030a14e98be1c1b9dd0680bb','createIndex indexName=condition_changed_by_fk, tableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-168','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:25',166,'EXECUTED','8:b3b1a267e2f70b822a9ea1dfe6755b1e','createIndex indexName=condition_condition_coded_fk, tableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-169','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:26',167,'EXECUTED','8:babb1074f32abb1122b552ca0eda2abd','createIndex indexName=condition_condition_coded_name_fk, tableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-170','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:27',168,'EXECUTED','8:e2bda57c42c5a9bf7c854a67b55bf3c7','createIndex indexName=condition_creator_fk, tableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-171','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:28',169,'EXECUTED','8:ee4160d92a93933a9b2d17ff9f6b60c5','createIndex indexName=condition_patient_fk, tableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-172','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:29',170,'EXECUTED','8:1aa6149355334eb5629ba66c9f4e8488','createIndex indexName=condition_previous_version_fk, tableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-173','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:30',171,'EXECUTED','8:a0f5c5a8139591a6dfaa0ebdcb1abf91','createIndex indexName=condition_voided_by_fk, tableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-174','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:32',172,'EXECUTED','8:9036796f0a8298a97e6ebbbb44f60269','createIndex indexName=conversion_to_state, tableName=concept_state_conversion','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-175','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:33',173,'EXECUTED','8:ca5f8b4206708c7a0b265ec52b2036f1','createIndex indexName=defines_attribute_type, tableName=person_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-176','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:33',174,'EXECUTED','8:0e8c8a71f1d7106ab0ee2b7a4e9c1a8e','createIndex indexName=defines_identifier_type, tableName=patient_identifier','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-177','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:36',175,'EXECUTED','8:21f248120c7e245a62a62a73f0bca3ac','createIndex indexName=description_for_concept, tableName=concept_description','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-178','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:41',176,'EXECUTED','8:3947bfa70f2dd628ef3693ef16865e27','createIndex indexName=discontinued_because, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-179','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:45',177,'EXECUTED','8:16bae96e0a9575b80f7436b65b3c901f','createIndex indexName=dosage_form_concept, tableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-180','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:48',178,'EXECUTED','8:aa2f3c125c218015850faf6902216f15','createIndex indexName=drug_changed_by, tableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-181','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:49',179,'EXECUTED','8:7923f05b615200e9a0074c5891d30bf9','createIndex indexName=drug_creator, tableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-182','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:50',180,'EXECUTED','8:12c2cab925c834a4e3cfd42d35177396','createIndex indexName=drug_dose_limit_units_fk, tableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-183','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:51',181,'EXECUTED','8:5504067b12cf6ae817487a6ca5d52d1d','createIndex indexName=drug_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-184','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:52',182,'EXECUTED','8:b3ff030e8d493d861782b7f31a050e0f','createIndex indexName=drug_ingredient_ingredient_id_fk, tableName=drug_ingredient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-185','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:53',183,'EXECUTED','8:bb3a92181d3b62e7473b880f3d1091c8','createIndex indexName=drug_ingredient_units_fk, tableName=drug_ingredient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-186','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:54',184,'EXECUTED','8:2247879088e4582d25b5375883a3831b','createIndex indexName=drug_order_dose_units, tableName=drug_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-187','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:55',185,'EXECUTED','8:a120dbdf3e345dca7ed6ad9f16ee5ee2','createIndex indexName=drug_order_duration_units_fk, tableName=drug_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-188','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:55',186,'EXECUTED','8:3b8d08a476c29d5fd436f49598aeff80','createIndex indexName=drug_order_frequency_fk, tableName=drug_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-189','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:57',187,'EXECUTED','8:6abde870ce9c60dbf78776b3ab7b0747','createIndex indexName=drug_order_quantity_units, tableName=drug_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-190','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:57',188,'EXECUTED','8:5962c1ccc35a4201ad511c5972e4d773','createIndex indexName=drug_order_route_fk, tableName=drug_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-191','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:58',189,'EXECUTED','8:194d1348aad83d4663ff157b6980811b','createIndex indexName=drug_reference_map_creator, tableName=drug_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-192','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:21:59',190,'EXECUTED','8:7197cb961f010b43e23b0f22fcc8f111','createIndex indexName=drug_retired_by, tableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-193','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:00',191,'EXECUTED','8:31c423c71c17e8760f26658c86d6f6e3','createIndex indexName=encounter_changed_by, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-194','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:01',192,'EXECUTED','8:4afd4079efd3ff663172a71a656cb0af','createIndex indexName=encounter_datetime_idx, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-195','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:02',193,'EXECUTED','8:dede34974de7f23b44244760df684f5a','createIndex indexName=encounter_diagnosis_changed_by_fk, tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-196','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:03',194,'EXECUTED','8:ce1e96338f2fd38358218a1b00930ecf','createIndex indexName=encounter_diagnosis_coded_fk, tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-197','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:04',195,'EXECUTED','8:4cf956666910b129c0ba36fc14010d11','createIndex indexName=encounter_diagnosis_coded_name_fk, tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-198','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:07',196,'EXECUTED','8:18e31313b0721289a6b9f980c3483ecc','createIndex indexName=encounter_diagnosis_condition_id_fk, tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-199','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:07',197,'EXECUTED','8:558a51844de3da4468a37e556f88550c','createIndex indexName=encounter_diagnosis_creator_fk, tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-200','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:08',198,'EXECUTED','8:ba1b9af8999b961c8bd24b959adda690','createIndex indexName=encounter_diagnosis_encounter_id_fk, tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-201','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:09',199,'EXECUTED','8:4751d44aad47533f7134557462f454d1','createIndex indexName=encounter_diagnosis_patient_fk, tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-202','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:10',200,'EXECUTED','8:517763278ae916a8f65aeb738b9071cb','createIndex indexName=encounter_diagnosis_voided_by_fk, tableName=encounter_diagnosis','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-203','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:11',201,'EXECUTED','8:82914cb547a4e291a05eff545a62e372','createIndex indexName=encounter_for_proposal, tableName=concept_proposal','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-204','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:12',202,'EXECUTED','8:dfea9f5ed02652ffc5e82180f2b5992e','createIndex indexName=encounter_form, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-205','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:13',203,'EXECUTED','8:6a5edd213c96575bd6da0b995778673c','createIndex indexName=encounter_ibfk_1, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-206','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:13',204,'EXECUTED','8:dda7f3b1c8972a907b426fd36ba0602e','createIndex indexName=encounter_id_fk, tableName=encounter_provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-207','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:14',205,'EXECUTED','8:1b085e5a93b7f65318144bdce78c779a','createIndex indexName=encounter_location, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-208','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:15',206,'EXECUTED','8:3c53772159fdf4203993da96963deb97','createIndex indexName=encounter_note, tableName=note','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-209','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:16',207,'EXECUTED','8:4336db4180aeb8bb560bc2d8c97f6a73','createIndex indexName=encounter_observations, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-210','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:17',208,'EXECUTED','8:c12352d4cf4efd3d17dd66f10d27d583','createIndex indexName=encounter_patient, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-211','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:18',209,'EXECUTED','8:672cc0e9cd6fea831298ed3ffaf45b10','createIndex indexName=encounter_provider_changed_by, tableName=encounter_provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-212','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:19',210,'EXECUTED','8:d77e3dc635af12b46d4053e839f9e56a','createIndex indexName=encounter_provider_creator, tableName=encounter_provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-213','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:21',211,'EXECUTED','8:eda86bd1660dca81f84a0dd9779884f4','createIndex indexName=encounter_provider_voided_by, tableName=encounter_provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-214','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:22',212,'EXECUTED','8:a0c736f940893bf5c0a56c15d99d7e21','createIndex indexName=encounter_role_changed_by_fk, tableName=encounter_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-215','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:23',213,'EXECUTED','8:3b49284874dfe876e87273e8f2688bed','createIndex indexName=encounter_role_creator_fk, tableName=encounter_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-216','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:24',214,'EXECUTED','8:a4a01769a58e5cd2dbd901d9b72c6dac','createIndex indexName=encounter_role_id_fk, tableName=encounter_provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-217','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:25',215,'EXECUTED','8:4d72025c8c4bac3cd6be806e49d67b7c','createIndex indexName=encounter_role_retired_by_fk, tableName=encounter_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-218','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:27',216,'EXECUTED','8:9d45a4c24d04a5d65220c7f89899c24a','createIndex indexName=encounter_type_changed_by, tableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-219','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:28',217,'EXECUTED','8:c5a4bab1f539bd4ced495c005c1a6f7f','createIndex indexName=encounter_type_id, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-220','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:29',218,'EXECUTED','8:06769795c33557f4889394fc30179450','createIndex indexName=encounter_type_retired_status, tableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-221','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:29',219,'EXECUTED','8:1a50f14ad002e48115436ef3665f4c43','createIndex indexName=encounter_visit_id_fk, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-222','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:31',220,'EXECUTED','8:d37207a166aaca60d194ee966bc7e120','createIndex indexName=family_name2, tableName=person_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-223','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:35',221,'EXECUTED','8:d4aa398734c837519572e6fcb143f355','createIndex indexName=field_answer_concept, tableName=field_answer','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-224','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:36',222,'EXECUTED','8:5dd4c8d34f9c8e04b99ccb7c2d12598f','createIndex indexName=field_retired_status, tableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-225','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:37',223,'EXECUTED','8:3b5c94c711a49af9fb71d08971423bb8','createIndex indexName=field_within_form, tableName=form_field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-226','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:38',224,'EXECUTED','8:38c45e1e9f4030e9e93022f6dc4ed350','createIndex indexName=first_name, tableName=person_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-227','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:39',225,'EXECUTED','8:5fcbc0fefca2b7bb36b0d15a0eb99e8f','createIndex indexName=fk_orderer_provider, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-228','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:40',226,'EXECUTED','8:92329d4c3a194f8543b93d67fccecd19','createIndex indexName=form_containing_field, tableName=form_field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-229','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:40',227,'EXECUTED','8:a8c8db5b52aa3122f0d65888b7700398','createIndex indexName=form_encounter_type, tableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-230','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:41',228,'EXECUTED','8:5fd7daba08733913b3e5dcf044c4a82a','createIndex indexName=form_field_hierarchy, tableName=form_field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-231','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:43',229,'EXECUTED','8:c8a1b0aeda085a3c343812e6e2daa18d','createIndex indexName=form_published_and_retired_index, tableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-232','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:44',230,'EXECUTED','8:024161f440c8e3fbbf85b098b439ae3f','createIndex indexName=form_published_index, tableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-233','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:44',231,'EXECUTED','8:4c6571095e0adeb94f37286e43b5b9d2','createIndex indexName=form_resource_changed_by, tableName=form_resource','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-234','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:46',232,'EXECUTED','8:023c3e2259f8bb56b2a1cb4a8c35a867','createIndex indexName=form_retired_index, tableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-235','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:46',233,'EXECUTED','8:077ed81c7d1f405c4ac4eac7e218fa43','createIndex indexName=global_property_changed_by, tableName=global_property','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-236','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:47',234,'EXECUTED','8:43a5867d586a7bb3465aa89d95198815','createIndex indexName=has_a, tableName=concept_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-237','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:48',235,'EXECUTED','8:117418151837815057613901205a080b','createIndex indexName=hl7_in_archive_message_state_idx, tableName=hl7_in_archive','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-238','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:48',236,'EXECUTED','8:6d3741d2da44192d82d16931f1ac6ac3','createIndex indexName=hl7_source_with_queue, tableName=hl7_in_queue','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-239','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:50',237,'EXECUTED','8:d95090902ac2b5d451f06d171c4cbf17','createIndex indexName=identifier_creator, tableName=patient_identifier','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-240','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:50',238,'EXECUTED','8:5f75e8eaf134aa378d6abed32e7ffef2','createIndex indexName=identifier_name, tableName=patient_identifier','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-241','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:52',239,'EXECUTED','8:27c4e5b6e65968bc70a736d1c002ee4f','createIndex indexName=identifier_voider, tableName=patient_identifier','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-242','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:53',240,'EXECUTED','8:85e6b78d6cd2d2b38288c093ed45a50c','createIndex indexName=identifies_person, tableName=person_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-243','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:55',241,'EXECUTED','8:d2ad7f39efadf4ae6e8cc21e028d3ae2','createIndex indexName=idx_code_concept_reference_term, tableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-244','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:55',242,'EXECUTED','8:604f6d74b4b564008d52f4e4724025e0','createIndex indexName=idx_concept_set_concept, tableName=concept_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-245','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:56',243,'EXECUTED','8:073d2de556dcb0d7069d64fc1ac853ac','createIndex indexName=idx_patient_identifier_patient, tableName=patient_identifier','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-246','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:22:58',244,'EXECUTED','8:a7118f2301f4b24a6342ef5b45ff9310','createIndex indexName=inherited_role, tableName=role_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-247','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:03',245,'EXECUTED','8:adebe6e37634bbab5e47e52c6f001b6e','createIndex indexName=inventory_item, tableName=drug_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-248','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:04',246,'EXECUTED','8:9ab129f6cd9a2eb318aa9b6188e10a05','createIndex indexName=last_name, tableName=person_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-249','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:05',247,'EXECUTED','8:7116fd0aa0d86192591b5b05562321f7','createIndex indexName=location_attribute_attribute_type_id_fk, tableName=location_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-250','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:05',248,'EXECUTED','8:55a0e386a302774eb39a51199113f194','createIndex indexName=location_attribute_changed_by_fk, tableName=location_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-251','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:06',249,'EXECUTED','8:73ff410750d5bd6be3065cf8872da7ad','createIndex indexName=location_attribute_creator_fk, tableName=location_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-252','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:07',250,'EXECUTED','8:49f63762203223d15f120ef9e10e0d37','createIndex indexName=location_attribute_location_fk, tableName=location_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-253','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:08',251,'EXECUTED','8:9f081da2d2b5de2bde1c4fffa582c2ff','createIndex indexName=location_attribute_type_changed_by_fk, tableName=location_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-254','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:09',252,'EXECUTED','8:dc08777f447f2daa7b3882f86c1bc70e','createIndex indexName=location_attribute_type_creator_fk, tableName=location_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-255','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:10',253,'EXECUTED','8:08cd9b26671410fa217fcbda4a00df29','createIndex indexName=location_attribute_type_retired_by_fk, tableName=location_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-256','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:11',254,'EXECUTED','8:a8104ab3f954e872c1e57069d16b49ba','createIndex indexName=location_attribute_voided_by_fk, tableName=location_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-257','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:12',255,'EXECUTED','8:f7bfde79464fa0eef95da29ea2ce350e','createIndex indexName=location_changed_by, tableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-258','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:13',256,'EXECUTED','8:da61c541398842b05fb3fdc5a2d44825','createIndex indexName=location_retired_status, tableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-259','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:13',257,'EXECUTED','8:a76d70c3f03f3db902cc9fb070564974','createIndex indexName=location_tag_changed_by, tableName=location_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-260','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:14',258,'EXECUTED','8:c1e4a003467d3a7586507788c79d6632','createIndex indexName=location_tag_creator, tableName=location_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-261','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:15',259,'EXECUTED','8:40cceeab104549fd7756a182c7b31fce','createIndex indexName=location_tag_map_tag, tableName=location_tag_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-262','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:16',260,'EXECUTED','8:af9d4ce6100a5afe145c856afc419037','createIndex indexName=location_tag_retired_by, tableName=location_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-263','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:17',261,'EXECUTED','8:b88c90f1f923cde2f9e5b575bc897d24','createIndex indexName=map_creator, tableName=concept_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-264','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:18',262,'EXECUTED','8:aaec6329d2d4888261e450178f7169e0','createIndex indexName=map_for_concept, tableName=concept_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-265','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:19',263,'EXECUTED','8:30d99738aea457ba6229a7b6f5e20cbd','createIndex indexName=mapped_concept_map_type, tableName=concept_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-266','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:20',264,'EXECUTED','8:10e3e6f6299728e62066649948857d9a','createIndex indexName=mapped_concept_map_type_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-267','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:21',265,'EXECUTED','8:51f56c62985729cfea11d79bef2c188b','createIndex indexName=mapped_concept_name, tableName=concept_name_tag_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-268','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:22',266,'EXECUTED','8:d83c81bd65c2723b6e2db5d44a0c99b1','createIndex indexName=mapped_concept_name_tag, tableName=concept_name_tag_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-269','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:24',267,'EXECUTED','8:b0c3a30b6d83eba35cc271b97bf2b88f','createIndex indexName=mapped_concept_proposal, tableName=concept_proposal_tag_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-270','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:27',268,'EXECUTED','8:a3c3c7616093618de7f90a3bac2d27bc','createIndex indexName=mapped_concept_proposal_tag, tableName=concept_proposal_tag_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-271','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:28',269,'EXECUTED','8:17a6d1ea0726018afcd68f60d77159f4','createIndex indexName=mapped_concept_reference_term, tableName=concept_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-272','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:30',270,'EXECUTED','8:9a0d34b3c6b7086cbc977a8be7baaff0','createIndex indexName=mapped_concept_source, tableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-273','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:30',271,'EXECUTED','8:b550cb7b0906479412351e273260ad7f','createIndex indexName=mapped_term_a, tableName=concept_reference_term_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-274','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:31',272,'EXECUTED','8:6e11a8dd0c3441dadbe67e7c9c68bf42','createIndex indexName=mapped_term_b, tableName=concept_reference_term_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-275','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:32',273,'EXECUTED','8:76d42b1c3a55e113b21aa47ccf41907e','createIndex indexName=mapped_user_changed, tableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-276','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:33',274,'EXECUTED','8:19b3d065a2f192cbe7698cdfdfec4eb0','createIndex indexName=mapped_user_changed_concept_map_type, tableName=concept_map_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-277','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:34',275,'EXECUTED','8:46f0c2de79abb084376f3d0dd760bbd5','createIndex indexName=mapped_user_changed_ref_term, tableName=concept_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-278','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:35',276,'EXECUTED','8:a2cf7b4567d193532eaefe2ce29aff62','createIndex indexName=mapped_user_changed_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-279','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:36',277,'EXECUTED','8:64ea4ebae8ea496a009d1f525367370a','createIndex indexName=mapped_user_creator, tableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-280','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:37',278,'EXECUTED','8:b3435d6dd1b7880e93aa5edcc74846c7','createIndex indexName=mapped_user_creator_concept_map_type, tableName=concept_map_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-281','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:38',279,'EXECUTED','8:3dc54f80ef612321c91462eccd3a55ec','createIndex indexName=mapped_user_creator_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-282','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:39',280,'EXECUTED','8:0a3503af05a7bd7897d95be10c3b3688','createIndex indexName=mapped_user_retired, tableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-283','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:39',281,'EXECUTED','8:31d72025fbec4406f9f1cb7c1f033cdb','createIndex indexName=mapped_user_retired_concept_map_type, tableName=concept_map_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-284','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:41',282,'EXECUTED','8:aad8af5f9b037c94eac525a386375b06','createIndex indexName=member_patient, tableName=cohort_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-285','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:41',283,'EXECUTED','8:bc24e713e119554b17147a3f6a2dfb93','createIndex indexName=middle_name, tableName=person_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-286','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:43',284,'EXECUTED','8:4ee87d8b126bd60cc9275e7f68c8015d','createIndex indexName=name_for_concept, tableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-287','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:43',285,'EXECUTED','8:b9d77080d671f9befc731734d1082d2c','createIndex indexName=name_for_person, tableName=person_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-288','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:43',286,'EXECUTED','8:e1cf3551a6093982be076e202c877bea','createIndex indexName=name_of_attribute, tableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-289','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:45',287,'EXECUTED','8:f20bfdf41671ea836878754bf85cefaf','createIndex indexName=name_of_concept, tableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-290','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:45',288,'EXECUTED','8:6ab3606ad0d1274f0f855eb01769c936','createIndex indexName=name_of_location, tableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-291','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:45',289,'EXECUTED','8:04a2e1643f8c67411cae4177290f22b5','createIndex indexName=note_hierarchy, tableName=note','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-292','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:46',290,'EXECUTED','8:502b5e5c51859e2eec91b875bc9abcb0','createIndex indexName=obs_concept, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-293','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:47',291,'EXECUTED','8:722b0dba4b61dcab30b52c887cf9e0b8','createIndex indexName=obs_datetime_idx, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-294','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:48',292,'EXECUTED','8:dce7042a64be9d3a55a5cbcf432e7bf5','createIndex indexName=obs_enterer, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-295','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:49',293,'EXECUTED','8:2c33da9c17d2eaeaee93fc90591b033d','createIndex indexName=obs_grouping_id, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-296','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:49',294,'EXECUTED','8:d84954ea35e785f43984207b617ed02f','createIndex indexName=obs_location, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-297','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:50',295,'EXECUTED','8:b5a33a8491f791f267384902aa798522','createIndex indexName=obs_name_of_coded_value, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-298','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:51',296,'EXECUTED','8:83f5de226100f7e8c6ee067396be02a7','createIndex indexName=obs_note, tableName=note','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-299','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:52',297,'EXECUTED','8:a192ac50b1fd406192f9924692d4b796','createIndex indexName=obs_order, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-300','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:54',298,'EXECUTED','8:0c18f787da491494b46284585cd17820','createIndex indexName=order_creator, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-301','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:55',299,'EXECUTED','8:1667c90052e388e32df606174648c13a','createIndex indexName=order_for_patient, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-302','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:55',300,'EXECUTED','8:c7b2f400292b0f1b2b3371c9c64e46f1','createIndex indexName=order_frequency_changed_by_fk, tableName=order_frequency','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-303','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:56',301,'EXECUTED','8:9dce146c0bdb56e141c57d01f0a3d7a6','createIndex indexName=order_frequency_creator_fk, tableName=order_frequency','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-304','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:57',302,'EXECUTED','8:87f2104877646004907ff88af1d0f110','createIndex indexName=order_frequency_retired_by_fk, tableName=order_frequency','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-305','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:58',303,'EXECUTED','8:a6d743bf0f9e2a56558455fa5a1d87fa','createIndex indexName=order_group_changed_by_fk, tableName=order_group','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-306','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:58',304,'EXECUTED','8:a1aafa6be68646d6461ea2ffbf1a8eaa','createIndex indexName=order_group_creator_fk, tableName=order_group','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-307','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:23:59',305,'EXECUTED','8:1fd62bd470c97ec9131e196ac9cb2653','createIndex indexName=order_group_encounter_id_fk, tableName=order_group','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-308','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:02',306,'EXECUTED','8:b5d584dae229bb43b3d5dfac96ff4baa','createIndex indexName=order_group_patient_id_fk, tableName=order_group','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-309','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:03',307,'EXECUTED','8:3f6b7823a7e57010dc4b96a25697e015','createIndex indexName=order_group_set_id_fk, tableName=order_group','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-310','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:03',308,'EXECUTED','8:a2b48e2bbe4c1757ae3a99938d81eac5','createIndex indexName=order_group_voided_by_fk, tableName=order_group','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-311','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:05',309,'EXECUTED','8:a5912184a23044851e8ef42a1b48a7e4','createIndex indexName=order_set_changed_by_fk, tableName=order_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-312','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:05',310,'EXECUTED','8:fb89530b109069ba8be1c3bb717c2121','createIndex indexName=order_set_creator_fk, tableName=order_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-313','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:09',311,'EXECUTED','8:a9f9b14070164cc2407c05f8d78b0aa2','createIndex indexName=order_set_member_changed_by_fk, tableName=order_set_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-314','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:13',312,'EXECUTED','8:9e380798192199cc558dcf76b86ee383','createIndex indexName=order_set_member_concept_id_fk, tableName=order_set_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-315','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:18',313,'EXECUTED','8:ab47cf75996ecd79d4f3e7d51add4f85','createIndex indexName=order_set_member_creator_fk, tableName=order_set_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-316','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:18',314,'EXECUTED','8:a4486ddcf3e2bfe7c2af98f689f999f0','createIndex indexName=order_set_member_order_set_id_fk, tableName=order_set_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-317','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:19',315,'EXECUTED','8:c33913fec57162ef1d536665aefaa1c4','createIndex indexName=order_set_member_order_type_fk, tableName=order_set_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-318','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:20',316,'EXECUTED','8:2038b70c44473ef106edbf302edd26a4','createIndex indexName=order_set_member_retired_by_fk, tableName=order_set_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-319','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:20',317,'EXECUTED','8:e6296cd5b7a15e29ffbcde45a4cd0268','createIndex indexName=order_set_retired_by_fk, tableName=order_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-320','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:22',318,'EXECUTED','8:8cd746d20e2d3f0cfb478b8fbb3b7976','createIndex indexName=order_type_changed_by, tableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-321','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:22',319,'EXECUTED','8:f2dc37c519d6795fd871c18435980f70','createIndex indexName=order_type_parent_order_type, tableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-322','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:24',320,'EXECUTED','8:644ef92f3d47d365532eff9953db9793','createIndex indexName=order_type_retired_status, tableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-323','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:26',321,'EXECUTED','8:ecd6c3abe3ba7670d05bb4f66036e2d0','createIndex indexName=orders_care_setting, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-324','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:28',322,'EXECUTED','8:d43c7046b4cc96fb2bab5c015230ea82','createIndex indexName=orders_in_encounter, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-325','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:30',323,'EXECUTED','8:411231af101070ffc908d7c86640b5de','createIndex indexName=orders_order_group_id_fk, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-326','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:31',324,'EXECUTED','8:b015ed6aaed23eda9c8e04dad894a859','createIndex indexName=parent_cohort, tableName=cohort_member','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-327','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:32',325,'EXECUTED','8:7bd03f793dfec28e378b4c7b5f193b83','createIndex indexName=parent_location, tableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-328','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:32',326,'EXECUTED','8:e9b88deaeac31b0432fbd4d4d483691e','createIndex indexName=patient_address_creator, tableName=person_address','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-329','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:37',327,'EXECUTED','8:4afe3b113bc16965b318ebd554a09bc8','createIndex indexName=patient_address_void, tableName=person_address','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-330','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:38',328,'EXECUTED','8:ace943334658479bf77701411c6be732','createIndex indexName=patient_identifier_changed_by, tableName=patient_identifier','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-331','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:38',329,'EXECUTED','8:6d42130aab478c32de45a24a4bac2a24','createIndex indexName=patient_identifier_ibfk_2, tableName=patient_identifier','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-332','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:39',330,'EXECUTED','8:95435cb6c7ff578eb26059b6a7321f72','createIndex indexName=patient_identifier_type_changed_by, tableName=patient_identifier_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-333','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:40',331,'EXECUTED','8:38fdd8b1bdea75698ea31430790b340e','createIndex indexName=patient_identifier_type_retired_status, tableName=patient_identifier_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-334','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:43',332,'EXECUTED','8:dcfc5706248f1defc7ea124dbef8ec14','createIndex indexName=patient_in_program, tableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-335','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:43',333,'EXECUTED','8:0ef5c8042260eb5634b1665a3f970dc8','createIndex indexName=patient_note, tableName=note','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-336','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:44',334,'EXECUTED','8:f6981472e24eb69ed6a696561588fd0e','createIndex indexName=patient_program_attribute_attributetype_fk, tableName=patient_program_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-337','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:45',335,'EXECUTED','8:f449c5e93c69745dc202a964eb95b43f','createIndex indexName=patient_program_attribute_changed_by_fk, tableName=patient_program_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-338','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:47',336,'EXECUTED','8:2beba5b0be222efca6a121d118a4ab09','createIndex indexName=patient_program_attribute_creator_fk, tableName=patient_program_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-339','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:49',337,'EXECUTED','8:958d8644d04dcbe96aad90bb7ca4eed6','createIndex indexName=patient_program_attribute_programid_fk, tableName=patient_program_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-340','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:49',338,'EXECUTED','8:4b4e07cc31c923fa37f0caaa8bf323df','createIndex indexName=patient_program_attribute_voided_by_fk, tableName=patient_program_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-341','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:51',339,'EXECUTED','8:ef920ed5a34363bd9ece75f6eb9071d7','createIndex indexName=patient_program_creator, tableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-342','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:51',340,'EXECUTED','8:2ce117f1b4c309dd58b48915890bba97','createIndex indexName=patient_program_for_state, tableName=patient_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-343','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:53',341,'EXECUTED','8:5e6d0c02499f229cf931498b8c6ae898','createIndex indexName=patient_program_location_id, tableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-344','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:53',342,'EXECUTED','8:e28c5452f1d034a0ad4f3cf5a0f1df95','createIndex indexName=patient_program_outcome_concept_id_fk, tableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-345','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:54',343,'EXECUTED','8:e1cab1a84a4e9594b95d9eb6e9643932','createIndex indexName=patient_state_changer, tableName=patient_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-346','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:55',344,'EXECUTED','8:59094c6a8698fa471c9b14945960111a','createIndex indexName=patient_state_creator, tableName=patient_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-347','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:56',345,'EXECUTED','8:f61e718deb4467f134397c85a65cd48c','createIndex indexName=patient_state_voider, tableName=patient_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-348','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:58',346,'EXECUTED','8:c4934fbf7bce4899a852b7e2ac7a0c62','createIndex indexName=person_a_is_person, tableName=relationship','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-349','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:24:58',347,'EXECUTED','8:b66c5278a9277f8055bf6e303d4276e8','createIndex indexName=person_address_changed_by, tableName=person_address','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-350','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:03',348,'EXECUTED','8:f3ec96539a9c6fa4a8e93f2387d65b25','createIndex indexName=person_attribute_type_retired_status, tableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-351','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:04',349,'EXECUTED','8:32c296ff73a60f3b9f44519f4e05ada3','createIndex indexName=person_b_is_person, tableName=relationship','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-352','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:05',350,'EXECUTED','8:0ffc099ac596e6a1e0623448a12d32b7','createIndex indexName=person_birthdate, tableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-353','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:05',351,'EXECUTED','8:5d335cd48c9c3622ecdbc9398fba5a49','createIndex indexName=person_death_date, tableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-354','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:10',352,'EXECUTED','8:fa9376ea58b6f400fd7b37c634f8439e','createIndex indexName=person_died_because, tableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-355','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:13',353,'EXECUTED','8:af83ca3362c3219a38a424b25e6cb9a0','createIndex indexName=person_id_for_user, tableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-356','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:14',354,'EXECUTED','8:10e7a7009c8a68479c8b5d3a3bd723e1','createIndex indexName=person_merge_log_changed_by_fk, tableName=person_merge_log','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-357','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:14',355,'EXECUTED','8:aeba6374ce79692cc6c4afdbcbdae230','createIndex indexName=person_merge_log_creator, tableName=person_merge_log','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-358','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:16',356,'EXECUTED','8:44d3661ba03f1283fd7ad325dac42206','createIndex indexName=person_merge_log_loser, tableName=person_merge_log','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-359','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:17',357,'EXECUTED','8:c85e6c020114981ada1c3e475de966c4','createIndex indexName=person_merge_log_voided_by_fk, tableName=person_merge_log','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-360','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:18',358,'EXECUTED','8:03ad1a480aa9c0448d3fd383e831beff','createIndex indexName=person_merge_log_winner, tableName=person_merge_log','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-361','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:19',359,'EXECUTED','8:f7b462971b2248a9a77bd476ce5591dc','createIndex indexName=person_obs, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-362','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:21',360,'EXECUTED','8:87b5dc4984cd482af28b829d4a3411e5','createIndex indexName=previous_order_id_order_id, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-363','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:21',361,'EXECUTED','8:481f14ae80e10723e8cdd4d957a32b18','createIndex indexName=previous_version, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-364','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:22',362,'EXECUTED','8:8b988fc20cd05cce87dfca918a67a853','createIndex indexName=primary_drug_concept, tableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-365','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:23',363,'EXECUTED','8:8035e065236d99f2120a0e0ae7e00e19','createIndex indexName=privilege_definitions, tableName=role_privilege','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-366','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:24',364,'EXECUTED','8:569e556b5127fb85bbd2f762b8abcb0d','createIndex indexName=privilege_which_can_edit, tableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-367','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:26',365,'EXECUTED','8:b2d66237cf16273ca43a279787abd289','createIndex indexName=privilege_which_can_edit_encounter_type, tableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-368','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:26',366,'EXECUTED','8:0bad7afd4996f4532aabecc55c05c6f9','createIndex indexName=privilege_which_can_view_encounter_type, tableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-369','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:27',367,'EXECUTED','8:1b95d72f022d870a00e7a1306eaed6af','createIndex indexName=program_attribute_type_changed_by_fk, tableName=program_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-370','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:28',368,'EXECUTED','8:0666dfeda180082f4a8ce20d4672aabb','createIndex indexName=program_attribute_type_creator_fk, tableName=program_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-371','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:28',369,'EXECUTED','8:cb4803b0dcbc70a13a2bf54dd7b04c93','createIndex indexName=program_attribute_type_retired_by_fk, tableName=program_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-372','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:29',370,'EXECUTED','8:4fceeddc65527f6aff2db27629515acc','createIndex indexName=program_concept, tableName=program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-373','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:30',371,'EXECUTED','8:c860ac227d0114f62112a04072c5d8b3','createIndex indexName=program_creator, tableName=program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-374','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:31',372,'EXECUTED','8:fc67efa5176469047ee0366b3cf61606','createIndex indexName=program_for_patient, tableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-375','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:32',373,'EXECUTED','8:802d71f2abb2ed1c9596adaefa80f25a','createIndex indexName=program_for_workflow, tableName=program_workflow','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-376','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:32',374,'EXECUTED','8:6de848917d554d43146c6d60ce7c1654','createIndex indexName=program_outcomes_concept_id_fk, tableName=program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-377','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:34',375,'EXECUTED','8:a40909e40fd6c37a4c77d0db07af0c35','createIndex indexName=proposal_obs_concept_id, tableName=concept_proposal','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-378','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:35',376,'EXECUTED','8:97f396dababa47ad282f35d66387010f','createIndex indexName=proposal_obs_id, tableName=concept_proposal','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-379','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:35',377,'EXECUTED','8:7878b52a263400367ae2f19ee2ffea2c','createIndex indexName=provider_attribute_attribute_type_id_fk, tableName=provider_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-380','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:36',378,'EXECUTED','8:b1e716f65494df103352dce39165d467','createIndex indexName=provider_attribute_changed_by_fk, tableName=provider_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-381','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:37',379,'EXECUTED','8:1a3991173a1a6c1cbedcfd8f38b23d46','createIndex indexName=provider_attribute_creator_fk, tableName=provider_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-382','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:37',380,'EXECUTED','8:2f926bc27f17c6b5761c743e12bc4704','createIndex indexName=provider_attribute_provider_fk, tableName=provider_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-383','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:41',381,'EXECUTED','8:c82699b775351d2324ca4f3797bd2aa0','createIndex indexName=provider_attribute_type_changed_by_fk, tableName=provider_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-384','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:45',382,'EXECUTED','8:c8769a761efe89c1327d1f45c3e6804b','createIndex indexName=provider_attribute_type_creator_fk, tableName=provider_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-385','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:45',383,'EXECUTED','8:5a015c038de4e1bfb150845cc8dcd1fd','createIndex indexName=provider_attribute_type_retired_by_fk, tableName=provider_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-386','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:47',384,'EXECUTED','8:071b3b36b034dde1fb3eac03d76dc3c2','createIndex indexName=provider_attribute_voided_by_fk, tableName=provider_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-387','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:47',385,'EXECUTED','8:28391123e016ecedc9e92aaa7002a9a5','createIndex indexName=provider_changed_by_fk, tableName=provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-388','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:47',386,'EXECUTED','8:6150efa0ff3b5fd0ac858125c1a470ce','createIndex indexName=provider_creator_fk, tableName=provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-389','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:48',387,'EXECUTED','8:14b0b358db728ed4432e8de5dc0909e4','createIndex indexName=provider_id_fk, tableName=encounter_provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-390','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:49',388,'EXECUTED','8:60671017da9f7c68ceeb70574da92295','createIndex indexName=provider_person_id_fk, tableName=provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-391','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:49',389,'EXECUTED','8:d1b4399b5599817e9b1159107eefe938','createIndex indexName=provider_retired_by_fk, tableName=provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-392','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:50',390,'EXECUTED','8:0faeedc4e3cb554ffcfb7d184a9b8ca5','createIndex indexName=provider_role_id_fk, tableName=provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-393','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:51',391,'EXECUTED','8:3b20f44b1dbc5ad8f3bd825b45e89984','createIndex indexName=provider_speciality_id_fk, tableName=provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-394','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:51',392,'EXECUTED','8:c1d0126a6bf573cae8fcb664270333c7','createIndex indexName=relation_creator, tableName=relationship','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-395','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:52',393,'EXECUTED','8:727751987bccbb0bd271dcb57a46e2f3','createIndex indexName=relation_voider, tableName=relationship','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-396','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:53',394,'EXECUTED','8:02c1b06ef9c6be308a00d4df8da55eb6','createIndex indexName=relationship_changed_by, tableName=relationship','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-397','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:54',395,'EXECUTED','8:975371d15b7b0a5e52af044c7d3f6a28','createIndex indexName=relationship_type_changed_by, tableName=relationship_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-398','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:55',396,'EXECUTED','8:2f66bc5bb41570ae45a5ab255469fcd4','createIndex indexName=relationship_type_id, tableName=relationship','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-399','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:55',397,'EXECUTED','8:60c176b60dcff5580d0f22a012633b25','createIndex indexName=report_object_creator, tableName=report_object','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-400','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:56',398,'EXECUTED','8:7c638e546bd699a279d62b0d36489c57','createIndex indexName=role_definitions, tableName=user_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-401','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:57',399,'EXECUTED','8:c89862f1966d03c0884d245fdaf4a88f','createIndex indexName=role_privilege_to_role, tableName=role_privilege','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-402','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:57',400,'EXECUTED','8:58a56ac393d2f6c48126a8adba8a9a66','createIndex indexName=route_concept, tableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-403','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:58',401,'EXECUTED','8:345907215bab087d0035d000afa9a514','createIndex indexName=scheduler_changer, tableName=scheduler_task_config','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-404','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:25:59',402,'EXECUTED','8:8ba6f3cf03f4489d612f25773dcad889','createIndex indexName=scheduler_creator, tableName=scheduler_task_config','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-405','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:00',403,'EXECUTED','8:99d9e2f3721be928d0c43ca256e12728','createIndex indexName=serialized_object_changed_by, tableName=serialized_object','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-406','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:02',404,'EXECUTED','8:dc694719e402b67c9639afee8af3b75c','createIndex indexName=serialized_object_creator, tableName=serialized_object','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-407','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:06',405,'EXECUTED','8:7437d93c8757fb55aa919bf21b456a0f','createIndex indexName=serialized_object_retired_by, tableName=serialized_object','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-408','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:07',406,'EXECUTED','8:e8e2d575a45d7de72c502acc8d6c006c','createIndex indexName=state_changed_by, tableName=program_workflow_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-409','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:07',407,'EXECUTED','8:3f7b636456460832ee260a18eb162a6c','createIndex indexName=state_concept, tableName=program_workflow_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-410','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:07',408,'EXECUTED','8:81fc984d8bff19515079254bdfce4802','createIndex indexName=state_creator, tableName=program_workflow_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-411','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:07',409,'EXECUTED','8:f2c40d95494570530e077694d500fbba','createIndex indexName=state_for_patient, tableName=patient_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-412','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:08',410,'EXECUTED','8:11c673d5fe793dde11022be10f69d93f','createIndex indexName=task_config_for_property, tableName=scheduler_task_config_property','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-413','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:08',411,'EXECUTED','8:0b3d1d47a36a661b8367b2d90e21e362','createIndex indexName=test_order_frequency_fk, tableName=test_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-414','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:09',412,'EXECUTED','8:cee34c547f13180783fb9f02e79a28e0','createIndex indexName=test_order_specimen_source_fk, tableName=test_order','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-415','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:10',413,'EXECUTED','8:30777b65a5778c2830ab812ea875d684','createIndex indexName=type_created_by, tableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-416','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:10',414,'EXECUTED','8:4f750963d8d22945764a40f9349c9bb9','createIndex indexName=type_creator, tableName=patient_identifier_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-417','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:14',415,'EXECUTED','8:72c791b5132cf0715a6f75e6339c2780','createIndex indexName=type_of_field, tableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-418','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:19',416,'EXECUTED','8:2635f2461e75c0f71a74049ee425d379','createIndex indexName=type_of_order, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-419','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:22',417,'EXECUTED','8:98a1414be57317ab27d544e18c5ff1a8','createIndex indexName=user_creator, tableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-420','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:24',418,'EXECUTED','8:6a79b0e1a0cf53e5fe69cd7e9fdb1a23','createIndex indexName=user_role_to_users, tableName=user_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-421','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:25',419,'EXECUTED','8:4916c9528fc492d433ad57cef358518d','createIndex indexName=user_who_changed, tableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-422','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:26',420,'EXECUTED','8:2dcbd1f067b5fe3c83c2613efd2d1ce3','createIndex indexName=user_who_changed_alert, tableName=notification_alert','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-423','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:26',421,'EXECUTED','8:c22cb21d67fe46c765e31421cbdbba78','createIndex indexName=user_who_changed_cohort, tableName=cohort','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-424','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:27',422,'EXECUTED','8:12e40bf834814c64bd67441cc66450b8','createIndex indexName=user_who_changed_concept, tableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-425','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:28',423,'EXECUTED','8:97f4d48da9b98a9797f11bd2e121e3bb','createIndex indexName=user_who_changed_description, tableName=concept_description','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-426','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:29',424,'EXECUTED','8:31934f744d48a9d20bbd99af206f3666','createIndex indexName=user_who_changed_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-427','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:29',425,'EXECUTED','8:1b013a4f078f3b18bba0c97bd807be90','createIndex indexName=user_who_changed_field, tableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-428','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:30',426,'EXECUTED','8:84e66526131ba5b2f75ef7b0a475cb97','createIndex indexName=user_who_changed_note, tableName=note','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-429','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:31',427,'EXECUTED','8:3b0867d2fa7c5bbfa2e0151ff998c0a9','createIndex indexName=user_who_changed_pat, tableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-430','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:32',428,'EXECUTED','8:0122464ab2e25489a251a835254933b2','createIndex indexName=user_who_changed_person, tableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-431','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:34',429,'EXECUTED','8:295451a8413d60bf3a126b7c0a377dec','createIndex indexName=user_who_changed_program, tableName=program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-432','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:35',430,'EXECUTED','8:2a9363c78f4846cf41045c6f203573b8','createIndex indexName=user_who_changed_proposal, tableName=concept_proposal','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-433','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:35',431,'EXECUTED','8:80eaf4b1de0dda76c24bf41ada886534','createIndex indexName=user_who_changed_report_object, tableName=report_object','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-434','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:37',432,'EXECUTED','8:d08c61d242968617b703fc25d88d2c97','createIndex indexName=user_who_changed_user, tableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-435','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:37',433,'EXECUTED','8:e9b1959ae3773a7b5381225a307b25a7','createIndex indexName=user_who_created, tableName=concept_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-436','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:38',434,'EXECUTED','8:dec84946e9ef350fee9bf9e564565ae7','createIndex indexName=user_who_created_description, tableName=concept_description','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-437','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:38',435,'EXECUTED','8:2267a0e2ef7c5c12e1136d8fc58ee817','createIndex indexName=user_who_created_field, tableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-438','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:38',436,'EXECUTED','8:cc980da2d5334af135b31baab720a8b7','createIndex indexName=user_who_created_field_answer, tableName=field_answer','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-439','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:38',437,'EXECUTED','8:b4e1b4ef31eed23b036e69759ed6d362','createIndex indexName=user_who_created_field_type, tableName=field_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-440','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:40',438,'EXECUTED','8:4c9ab7f6f116fb6d180165aa4314c4f9','createIndex indexName=user_who_created_form, tableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-441','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:41',439,'EXECUTED','8:d1435b63968d4ac2ff7656d2f26c596d','createIndex indexName=user_who_created_form_field, tableName=form_field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-442','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:46',440,'EXECUTED','8:d60b12848c9dbbf1c87a640ba1f1464e','createIndex indexName=user_who_created_hl7_source, tableName=hl7_source','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-443','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:49',441,'EXECUTED','8:77e3f63aae12ba9d898a35ab6fe95592','createIndex indexName=user_who_created_location, tableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-444','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:50',442,'EXECUTED','8:e5b1e2c2a208fc667cab964139db2a5b','createIndex indexName=user_who_created_name, tableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-445','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:51',443,'EXECUTED','8:482b94f4c8a17498c0ea738a069e3b64','createIndex indexName=user_who_created_name_tag, tableName=concept_name_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-446','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:52',444,'EXECUTED','8:b7ac3e14096bec7ec7488c25b0f3a459','createIndex indexName=user_who_created_note, tableName=note','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-447','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:53',445,'EXECUTED','8:831f45000783dbdccbd088d9f1fe2b94','createIndex indexName=user_who_created_patient, tableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-448','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:54',446,'EXECUTED','8:cf226ccbf7971a8a9ca0d248d495ba02','createIndex indexName=user_who_created_person, tableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-449','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:55',447,'EXECUTED','8:35887a2b53f4cdfc1d6bfbdf1f08c935','createIndex indexName=user_who_created_proposal, tableName=concept_proposal','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-450','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:56',448,'EXECUTED','8:4f2fdf3f432374182921e1e7549ec23c','createIndex indexName=user_who_created_rel, tableName=relationship_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-451','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:57',449,'EXECUTED','8:2e9acebbfe25234f77fb27d8073d54a3','createIndex indexName=user_who_created_type, tableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-452','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:26:59',450,'EXECUTED','8:efc6dd67eaa7c5c4d10a3ec3a31b6ffb','createIndex indexName=user_who_last_changed_form, tableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-453','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:00',451,'EXECUTED','8:3626af26aefa67355dbdc1443c425dc9','createIndex indexName=user_who_last_changed_form_field, tableName=form_field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-454','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:01',452,'EXECUTED','8:dba003f29a0c1a018bb4d6b19bb8ea82','createIndex indexName=user_who_made_name, tableName=person_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-455','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:02',453,'EXECUTED','8:596d63992b7500d2857ff9b591a5867a','createIndex indexName=user_who_retired_concept, tableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-456','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:03',454,'EXECUTED','8:22c383f0c05fdab71781e7a590e548e6','createIndex indexName=user_who_retired_concept_class, tableName=concept_class','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-457','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:03',455,'EXECUTED','8:38342c5f7d175b5085fe7779daed6a25','createIndex indexName=user_who_retired_concept_datatype, tableName=concept_datatype','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-458','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:08',456,'EXECUTED','8:6b4329d504bbeef8d05f63c829474fa5','createIndex indexName=user_who_retired_concept_source, tableName=concept_reference_source','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-459','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:09',457,'EXECUTED','8:be03b0886a60a4801fd01afe63879796','createIndex indexName=user_who_retired_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-460','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:11',458,'EXECUTED','8:e16cbf2b5aaefb822e1077ad4752fcd7','createIndex indexName=user_who_retired_encounter_type, tableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-461','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:11',459,'EXECUTED','8:cc548a866306eedbab3ba3ccd03d87fa','createIndex indexName=user_who_retired_field, tableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-462','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:12',460,'EXECUTED','8:81ce0f64dd3f0a7e91dcdbdeefd2eabf','createIndex indexName=user_who_retired_form, tableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-463','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:12',461,'EXECUTED','8:b71173f28e535bf7348e6a3c7557dd7b','createIndex indexName=user_who_retired_location, tableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-464','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:13',462,'EXECUTED','8:6372653c2c49f52453fbf46af792d8a8','createIndex indexName=user_who_retired_order_type, tableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-465','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:13',463,'EXECUTED','8:d3e96ecd89da6c8fe015b2574708eca0','createIndex indexName=user_who_retired_patient_identifier_type, tableName=patient_identifier_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-466','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:14',464,'EXECUTED','8:d833b27872a872339fc8028162d0cdc8','createIndex indexName=user_who_retired_person_attribute_type, tableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-467','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:17',465,'EXECUTED','8:7fd5577476509af77746aecc8b078ab6','createIndex indexName=user_who_retired_relationship_type, tableName=relationship_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-468','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:19',466,'EXECUTED','8:1d661628f98b448fce38d7aa3e0bede7','createIndex indexName=user_who_retired_this_user, tableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-469','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:19',467,'EXECUTED','8:5852f80d0e0ef4359873f542c2747a63','createIndex indexName=user_who_voided_cohort, tableName=cohort','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-470','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:20',468,'EXECUTED','8:ab96b9937398cd4e1449dec3506e528e','createIndex indexName=user_who_voided_encounter, tableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-471','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:22',469,'EXECUTED','8:2bf627a24b3a4101ad2cf42aebc6f170','createIndex indexName=user_who_voided_name, tableName=person_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-472','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:22',470,'EXECUTED','8:988da7b1d6f2c4056885ecfcf0f9a57d','createIndex indexName=user_who_voided_name_tag, tableName=concept_name_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-473','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:24',471,'EXECUTED','8:2219bbfb05637be221bef4bc9a853477','createIndex indexName=user_who_voided_obs, tableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-474','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:24',472,'EXECUTED','8:9e19e62c8650a5aefb0e6c2602764586','createIndex indexName=user_who_voided_order, tableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-475','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:26',473,'EXECUTED','8:6e61ed99aa6f483b97bd3d01301171f9','createIndex indexName=user_who_voided_patient, tableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-476','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:26',474,'EXECUTED','8:35bb5780c5059d400cac524f0301abd0','createIndex indexName=user_who_voided_patient_program, tableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-477','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:27',475,'EXECUTED','8:714686779f3d31877568eccb91700375','createIndex indexName=user_who_voided_person, tableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-478','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:28',476,'EXECUTED','8:9eeded0707368de50c3ee0add3c2e8b2','createIndex indexName=user_who_voided_report_object, tableName=report_object','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-479','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:29',477,'EXECUTED','8:3f9860528ccc3a3ae04d7e8aca6f44e1','createIndex indexName=user_who_voided_this_name, tableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-480','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:29',478,'EXECUTED','8:b9a65b7ab309bdd46ba4f2c449115ff7','createIndex indexName=visit_attribute_attribute_type_id_fk, tableName=visit_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-481','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:31',479,'EXECUTED','8:abb19811e24e0f8e496c1fa04d44c32e','createIndex indexName=visit_attribute_changed_by_fk, tableName=visit_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-482','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:31',480,'EXECUTED','8:a2626b27d70186539932878526685946','createIndex indexName=visit_attribute_creator_fk, tableName=visit_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-483','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:33',481,'EXECUTED','8:303466c6d7bf9f3da0b0d284d6ceb254','createIndex indexName=visit_attribute_type_changed_by_fk, tableName=visit_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-484','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:33',482,'EXECUTED','8:9e79bc736ad1da58baa5e7e6a7865b63','createIndex indexName=visit_attribute_type_creator_fk, tableName=visit_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-485','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:34',483,'EXECUTED','8:d7b6dd39ec5c3dbd6ede2a3c125c2109','createIndex indexName=visit_attribute_type_retired_by_fk, tableName=visit_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-486','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:35',484,'EXECUTED','8:7abf34988c450d665e0cdeb647f80119','createIndex indexName=visit_attribute_visit_fk, tableName=visit_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-487','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:36',485,'EXECUTED','8:a988a83b44131d10905757c01b41d39e','createIndex indexName=visit_attribute_voided_by_fk, tableName=visit_attribute','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-488','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:36',486,'EXECUTED','8:ed5026748c07dc69aa88ee02efc0d531','createIndex indexName=visit_changed_by_fk, tableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-489','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:37',487,'EXECUTED','8:821728f2ac5511a778103702e2758d66','createIndex indexName=visit_creator_fk, tableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-490','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:38',488,'EXECUTED','8:3c6b43e507d00b5bfb092c11eb16b0ec','createIndex indexName=visit_indication_concept_fk, tableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-491','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:38',489,'EXECUTED','8:026070962492dcdc88e33096b8f34690','createIndex indexName=visit_location_fk, tableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-492','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:39',490,'EXECUTED','8:fe8454bcd5df128318c029e22ad9e9ea','createIndex indexName=visit_patient_index, tableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-493','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:40',491,'EXECUTED','8:422143f23d4dd075db333a41c242fe94','createIndex indexName=visit_type_changed_by, tableName=visit_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-494','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:43',492,'EXECUTED','8:d334a839fdff81402550989673440de6','createIndex indexName=visit_type_creator, tableName=visit_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-495','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:46',493,'EXECUTED','8:42aae037b40bfe2fae6e57dba78e4381','createIndex indexName=visit_type_fk, tableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-496','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:50',494,'EXECUTED','8:f947d1867f95025430145d95911af633','createIndex indexName=visit_type_retired_by, tableName=visit_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-497','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:51',495,'EXECUTED','8:c4045e420af7ca5b14cf317fd211cda1','createIndex indexName=visit_voided_by_fk, tableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-498','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:53',496,'EXECUTED','8:3d95ff0d3142092fa058978762d39599','createIndex indexName=workflow_changed_by, tableName=program_workflow','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-499','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:53',497,'EXECUTED','8:3000c224f29f0dae2ab9005d36b178a0','createIndex indexName=workflow_concept, tableName=program_workflow','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-500','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:54',498,'EXECUTED','8:6bcb3a192f7a5cf3c1ace2f3bd41cd77','createIndex indexName=workflow_creator, tableName=program_workflow','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-501','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:27:55',499,'EXECUTED','8:eb75a8f45e6abce58d20c2215b7e4f14','createIndex indexName=workflow_for_state, tableName=program_workflow_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-502','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:00',500,'EXECUTED','8:b6e1c8e8fc47af4830e99c9013b80fb2','addForeignKeyConstraint baseTableName=person_address, constraintName=address_for_person, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-503','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:02',501,'EXECUTED','8:1ec946ec8939be01efbbb88cf8fa56f9','addForeignKeyConstraint baseTableName=notification_alert, constraintName=alert_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-504','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:04',502,'EXECUTED','8:39db8f28c8000a553adb6ba15530c4b6','addForeignKeyConstraint baseTableName=notification_alert_recipient, constraintName=alert_read_by_user, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-505','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:07',503,'EXECUTED','8:973d36344c1dfc1c9b50e8e088c0652a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-506','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:12',504,'EXECUTED','8:a8a2bfcfcd93cbed9981ac64456f5854','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_coded_allergen_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-507','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:17',505,'EXECUTED','8:25b1d85ad004674ca5a2eb96e5c42fb2','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-508','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:18',506,'EXECUTED','8:b8da87293e10f64fcfe4746997cf1194','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_patient_id_fk, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-509','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:19',507,'EXECUTED','8:da9b1b2931d5cb6d8467df67e4170771','addForeignKeyConstraint baseTableName=allergy_reaction, constraintName=allergy_reaction_allergy_id_fk, referencedTableName=allergy','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-510','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:28',508,'EXECUTED','8:23d4467b422513efd10b68ef30607187','addForeignKeyConstraint baseTableName=allergy_reaction, constraintName=allergy_reaction_reaction_concept_id_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-511','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:30',509,'EXECUTED','8:0b98d57fb66075dffdc6f0327b0ed51a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_severity_concept_id_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-512','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:36',510,'EXECUTED','8:76c04d554dccd13fe1668f569b17e62a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_voided_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-513','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:40',511,'EXECUTED','8:bacea2a759845361696795b01b15a774','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-514','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:42',512,'EXECUTED','8:5425a5305a81c382842f827738b2eba7','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer_answer_drug_fk, referencedTableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-515','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:50',513,'EXECUTED','8:d08eeab2acb74694acb823d3bd33683c','addForeignKeyConstraint baseTableName=obs, constraintName=answer_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-516','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:28:59',514,'EXECUTED','8:993ba5f29b8b033d85f2d67278b91aeb','addForeignKeyConstraint baseTableName=obs, constraintName=answer_concept_drug, referencedTableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-517','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:02',515,'EXECUTED','8:ff36e32f75908f129f488a847418993a','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-518','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:05',516,'EXECUTED','8:99814a0e717b6e85599784487fa515ed','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answers_for_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-519','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:09',517,'EXECUTED','8:f654d22286db16b023d7c8efc12b6dbd','addForeignKeyConstraint baseTableName=field_answer, constraintName=answers_for_field, referencedTableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-520','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:12',518,'EXECUTED','8:8604b3b4fb3677cd5d849d27de8f6747','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_changer, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-521','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:22',519,'EXECUTED','8:1f3af68eb9a72c0828976c0c988bc2ef','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-522','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:25',520,'EXECUTED','8:35eada7bb99cf639a17421fc86975d2a','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=attribute_type_changer, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-523','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:35',521,'EXECUTED','8:5564f9398f0cb98de98d54685d56f91d','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=attribute_type_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-524','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:39',522,'EXECUTED','8:fd53f94868cf335848f17cc5af41ebe6','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_voider, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-525','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:41',523,'EXECUTED','8:6ff79c01470986df7e6fd8389a055b34','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-526','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:44',524,'EXECUTED','8:d5d65fa61eacf27e22c3b73bf4964280','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-527','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:49',525,'EXECUTED','8:1262c08379f097648c81983b83c828ab','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_retired_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-528','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:55',526,'EXECUTED','8:14f51cb7024cf4b9d0cf5de40b1bd656','addForeignKeyConstraint baseTableName=order_set, constraintName=category_order_set_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-529','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:56',527,'EXECUTED','8:28f0560443db9c0778378585f3aba7c0','addForeignKeyConstraint baseTableName=cohort, constraintName=cohort_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-530','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:29:58',528,'EXECUTED','8:3b4adf2a5b7f7ceb9a15070e9a5a9dea','addForeignKeyConstraint baseTableName=cohort_member, constraintName=cohort_member_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-531','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:01',529,'EXECUTED','8:676a6c5d4e74361903a325056751786c','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_attribute_type_id_fk, referencedTableName=concept_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-532','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:06',530,'EXECUTED','8:12553549877cfe05e628cc81edc92430','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-533','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:12',531,'EXECUTED','8:8f623fcdb9898edc0c01116c3e0246b7','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_concept_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-534','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:15',532,'EXECUTED','8:d78557d92aea1aab6f039afdd95277f6','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-535','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:17',533,'EXECUTED','8:d5726b2f1d411facb9f9cc2b4c1c8d74','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-536','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:22',534,'EXECUTED','8:d8810b69d852f158a0a6a8d090746c1d','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-537','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:26',535,'EXECUTED','8:4732421cdb4b33ae6a472a42ab7e5ac7','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-538','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:29',536,'EXECUTED','8:2818e68c416aa6371d7f7f2e0d5bf4a8','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-539','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:34',537,'EXECUTED','8:2a31268e8389ead337d01f761437ef02','addForeignKeyConstraint baseTableName=concept_complex, constraintName=concept_attributes, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-540','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:39',538,'EXECUTED','8:649f717179083bfdd1724cef6b4bae49','addForeignKeyConstraint baseTableName=concept_class, constraintName=concept_class_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-541','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:42',539,'EXECUTED','8:16116d24f478ae4256a3f4cd89ddf1b8','addForeignKeyConstraint baseTableName=concept_class, constraintName=concept_class_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-542','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:45',540,'EXECUTED','8:aa266368ce23dab47453fe16faf532fc','addForeignKeyConstraint baseTableName=concept, constraintName=concept_classes, referencedTableName=concept_class','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-543','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:49',541,'EXECUTED','8:ae87e3825b9e50d9e517b0730d8283a9','addForeignKeyConstraint baseTableName=concept, constraintName=concept_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-544','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:51',542,'EXECUTED','8:d103964c3dc48330db9e9a25c14291bf','addForeignKeyConstraint baseTableName=concept_datatype, constraintName=concept_datatype_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-545','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:53',543,'EXECUTED','8:f373e4b204964bdfe5f5bd88655f08ca','addForeignKeyConstraint baseTableName=concept, constraintName=concept_datatypes, referencedTableName=concept_datatype','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-546','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:30:56',544,'EXECUTED','8:da92ad33e8b6e0303f010ea16f828c4f','addForeignKeyConstraint baseTableName=field, constraintName=concept_for_field, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-547','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:31:02',545,'EXECUTED','8:c903a4ac7b7d7c3af47dff734b968c05','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=concept_for_proposal, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-548','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:31:08',546,'EXECUTED','8:1754fb36a03905b0820d15547552be80','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=concept_map_type_for_drug_reference_map, referencedTableName=concept_map_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-549','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:31:21',547,'EXECUTED','8:f8cc69b9aaf639c2a557ed449dafb707','addForeignKeyConstraint baseTableName=concept_name, constraintName=concept_name_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-550','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:31:43',548,'EXECUTED','8:a0b92c973cbe7a7186c5b1b3247c8324','addForeignKeyConstraint baseTableName=concept_name_tag, constraintName=concept_name_tag_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-551','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:31:55',549,'EXECUTED','8:7f55c49f252271863a74efec5dca6963','addForeignKeyConstraint baseTableName=concept_reference_source, constraintName=concept_reference_source_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-552','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:32:08',550,'EXECUTED','8:8200585e5fc54aad32f7e13429a7b028','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=concept_reference_term_for_drug_reference_map, referencedTableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-553','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:32:25',551,'EXECUTED','8:45d8c4a52f4c4ae3d8a2bff4c1781651','addForeignKeyConstraint baseTableName=concept_reference_source, constraintName=concept_source_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-554','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:32:38',552,'EXECUTED','8:00339eef1ba1912570d3ea905417c5b1','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=concept_triggers_conversion, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-555','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:32:47',553,'EXECUTED','8:e85ae80b67cfd4db417e33e318701d3c','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-556','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:32:58',554,'EXECUTED','8:ab139110539c388d66a8f2f0013d1b0b','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_condition_coded_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-557','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:33:06',555,'EXECUTED','8:58d73cee6c614043fb3733e0dbe6d479','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_condition_coded_name_fk, referencedTableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-558','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:33:12',556,'EXECUTED','8:bc12d124077f87e9da7cdb1e8ef07f1e','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-559','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:33:25',557,'EXECUTED','8:aa7b42a352b4fc7b59f2d8229b1c5bb6','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_patient_fk, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-560','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:33:32',558,'EXECUTED','8:2090aa26bbe56d51c4b25f009036d3cd','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_previous_version_fk, referencedTableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-561','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:33:52',559,'EXECUTED','8:a6662d3138a91c5451f019920120b309','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_voided_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-562','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:33:54',560,'EXECUTED','8:c45d4124278063454e28412966c3d075','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=conversion_involves_workflow, referencedTableName=program_workflow','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-563','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:33:55',561,'EXECUTED','8:f783ec8d57cab054d9d241495c7cdcab','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=conversion_to_state, referencedTableName=program_workflow_state','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-564','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:33:57',562,'EXECUTED','8:af744a99c04da67bf99e80174bebe15f','addForeignKeyConstraint baseTableName=person_attribute, constraintName=defines_attribute_type, referencedTableName=person_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-565','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:34:06',563,'EXECUTED','8:faed525320f2f83c920d665a965001e5','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=defines_identifier_type, referencedTableName=patient_identifier_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-566','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:34:14',564,'EXECUTED','8:09c26ff9f5c725b7cb40b0c494295c95','addForeignKeyConstraint baseTableName=concept_description, constraintName=description_for_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-567','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:34:22',565,'EXECUTED','8:105fb4739f59d253dc1a015f98cd10d4','addForeignKeyConstraint baseTableName=orders, constraintName=discontinued_because, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-568','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:34:29',566,'EXECUTED','8:3830fd8cdd434be82eaac016e4edab36','addForeignKeyConstraint baseTableName=drug, constraintName=dosage_form_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-569','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:34:36',567,'EXECUTED','8:d03afbcbe53ba5021acef4dd28552fb7','addForeignKeyConstraint baseTableName=drug, constraintName=drug_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-570','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:34:47',568,'EXECUTED','8:5231d12b016b67bfb9e12b2d17abbfe6','addForeignKeyConstraint baseTableName=drug, constraintName=drug_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-571','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:34:55',569,'EXECUTED','8:f4810867e925ce07cf7d723360968d1a','addForeignKeyConstraint baseTableName=drug, constraintName=drug_dose_limit_units_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-572','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:34:57',570,'EXECUTED','8:a6c3f0bd9a47a1717f792d0578b70e2f','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=drug_for_drug_reference_map, referencedTableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-573','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:02',571,'EXECUTED','8:d662c80d9c600f694ddaea7c0192f451','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_drug_id_fk, referencedTableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-574','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:06',572,'EXECUTED','8:36e2d9e76e86ddcbea122d2e144cdbd9','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_ingredient_id_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-575','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:08',573,'EXECUTED','8:34084dad7a3a236ceebdb83b3a9e0c1f','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_units_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-576','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:11',574,'EXECUTED','8:c44f51f79df5d4e0468b64f40b5e4f97','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_dose_units, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-577','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:22',575,'EXECUTED','8:b33243e95f8262831338df6e20a6d881','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_duration_units_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-578','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:31',576,'EXECUTED','8:53cd923fbefd9a4dd6733945a28a9b62','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_frequency_fk, referencedTableName=order_frequency','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-579','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:36',577,'EXECUTED','8:0b31914637b8b4e844a556d5c1ea031a','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_quantity_units, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-580','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:39',578,'EXECUTED','8:c7f6ed748327e9baac7ed7953d18ec1c','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_route_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-581','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:46',579,'EXECUTED','8:0253b90367453adf19c09c3013fb8dc3','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=drug_reference_map_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-582','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:54',580,'EXECUTED','8:4dc230f5d02486b8d9c58ae8a01628fc','addForeignKeyConstraint baseTableName=drug, constraintName=drug_retired_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-583','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:35:55',581,'EXECUTED','8:f143d21018358409bb9581c3e29fc160','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-584','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:36:08',582,'EXECUTED','8:e25f3380836582dc8052bc1c445f8b60','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-585','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:36:23',583,'EXECUTED','8:e8554f1f03f07ee3cd1f6b7fe3bf493e','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_coded_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-586','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:36:35',584,'EXECUTED','8:da2a7be9e55bd45cd780a8df20af60d4','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_coded_name_fk, referencedTableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-587','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:36:42',585,'EXECUTED','8:c5afe7b601dafc0c40a3cad845fe64fc','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_condition_id_fk, referencedTableName=conditions','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-588','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:36:47',586,'EXECUTED','8:36b1ccb71ae92fd5223d074da16d632b','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-589','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:36:49',587,'EXECUTED','8:801acff9a2798f43e2a3641139ad113b','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-590','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:36:50',588,'EXECUTED','8:8aa55bb7c0d793aa392b59f9f93e99ee','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_patient_fk, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-591','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:36:57',589,'EXECUTED','8:02bd0156780b3e6d53cc1e4bb4dce8cc','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_voided_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-592','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:03',590,'EXECUTED','8:3970a663eed3b6c3f188662c64edc543','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=encounter_for_proposal, referencedTableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-593','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:06',591,'EXECUTED','8:210039b231ee3c0e460e0218988e91cc','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_form, referencedTableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-594','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:17',592,'EXECUTED','8:e22246ade5c0e680a0e498c71dd213b7','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_ibfk_1, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-595','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:19',593,'EXECUTED','8:a67709326ffdec1fb396b1945a70027b','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-596','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:26',594,'EXECUTED','8:e97e2d0264ee91758e2c6fba9d8c4588','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_location, referencedTableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-597','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:31',595,'EXECUTED','8:012e16d01037b4d01bfb7116d59a8291','addForeignKeyConstraint baseTableName=note, constraintName=encounter_note, referencedTableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-598','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:37',596,'EXECUTED','8:2d63bc1fade593ead70c0eea87128c8c','addForeignKeyConstraint baseTableName=obs, constraintName=encounter_observations, referencedTableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-599','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:38',597,'EXECUTED','8:c7012fabbc2393f393eda9ce1520fd2b','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_patient, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-600','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:50',598,'EXECUTED','8:541ce5d1093fdecc87ecc8a765cc324f','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-601','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:54',599,'EXECUTED','8:76deded3b3e88e71af862e958685591a','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-602','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:37:58',600,'EXECUTED','8:d5db7b8e7b82e7ac83321c0f7db7fdaa','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_voided_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-603','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:38:09',601,'EXECUTED','8:316c689f0dd949635c6b461d6da844cb','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-604','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:38:20',602,'EXECUTED','8:aad73f4eac8d37b4ff91cfae56647778','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-605','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:38:23',603,'EXECUTED','8:6b5d33f7502fa361cccb208ba3ca9612','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_role_id_fk, referencedTableName=encounter_role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-606','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:38:29',604,'EXECUTED','8:63c33f11d1048f4a376ee1988bedcb22','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_retired_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-607','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:38:31',605,'EXECUTED','8:e85bacc187b63072f286b97de56ed71d','addForeignKeyConstraint baseTableName=encounter_type, constraintName=encounter_type_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-608','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:38:40',606,'EXECUTED','8:4ecf31c173230b5b38207132ccc18bfd','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_type_id, referencedTableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-609','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:38:42',607,'EXECUTED','8:01343cf01ebe1e2d3fb1fe460d1b52fc','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_visit_id_fk, referencedTableName=visit','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-610','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:38:54',608,'EXECUTED','8:fde37b9094cc447bbef2e81aea9d5f9a','addForeignKeyConstraint baseTableName=drug_order, constraintName=extends_order, referencedTableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-611','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:39:00',609,'EXECUTED','8:15986d2715766d22ca5aee2fc0fb9760','addForeignKeyConstraint baseTableName=field_answer, constraintName=field_answer_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-612','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:39:06',610,'EXECUTED','8:40aac8b7fd4955579e5a4335c1ad496e','addForeignKeyConstraint baseTableName=form_field, constraintName=field_within_form, referencedTableName=field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-613','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:39:10',611,'EXECUTED','8:0fc24b5eb57987ea58550b45692a876d','addForeignKeyConstraint baseTableName=order_type_class_map, constraintName=fk_order_type_class_map_concept_class_concept_class_id, referencedTableName=concept_class','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-614','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:39:15',612,'EXECUTED','8:f8ff2cf7060d71390dd68da84014956c','addForeignKeyConstraint baseTableName=order_type_class_map, constraintName=fk_order_type_order_type_id, referencedTableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-615','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:39:25',613,'EXECUTED','8:d6a297a45ab7034c4550d06b241d10a9','addForeignKeyConstraint baseTableName=orders, constraintName=fk_orderer_provider, referencedTableName=provider','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-616','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:39:34',614,'EXECUTED','8:d4002ab7f9a0f0a7d4276f208e5496c7','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=fk_patient_id_patient_identifier, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-617','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:39:41',615,'EXECUTED','8:058ade5e67a5e4c9f6774fe26e41cb70','addForeignKeyConstraint baseTableName=form_field, constraintName=form_containing_field, referencedTableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-618','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:39:46',616,'EXECUTED','8:02b36c3723f68bc2b4bdd77b801e3b70','addForeignKeyConstraint baseTableName=form, constraintName=form_encounter_type, referencedTableName=encounter_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-619','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:40:00',617,'EXECUTED','8:6e714deb4047c385619bb35497f4dc4e','addForeignKeyConstraint baseTableName=form_field, constraintName=form_field_hierarchy, referencedTableName=form_field','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-620','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:40:03',618,'EXECUTED','8:ff86dcb00584315dbb04c6e51c410bb5','addForeignKeyConstraint baseTableName=form_resource, constraintName=form_resource_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-621','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:40:12',619,'EXECUTED','8:ae518a8608ae65f4606e10547d866504','addForeignKeyConstraint baseTableName=form_resource, constraintName=form_resource_form_fk, referencedTableName=form','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-622','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:40:16',620,'EXECUTED','8:66a6f7b82373f3c0c08a68a662f0b4af','addForeignKeyConstraint baseTableName=global_property, constraintName=global_property_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-623','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:40:20',621,'EXECUTED','8:0a584ebf18cd8dbc521ecb2689f0a1ac','addForeignKeyConstraint baseTableName=concept_set, constraintName=has_a, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-624','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:40:31',622,'EXECUTED','8:fc455ba76ca852afe49f6e7ce37b1c9d','addForeignKeyConstraint baseTableName=hl7_in_queue, constraintName=hl7_source_with_queue, referencedTableName=hl7_source','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-625','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:40:38',623,'EXECUTED','8:de4d1a28261c165a0f1b8f0cd3e2c00b','addForeignKeyConstraint baseTableName=notification_alert_recipient, constraintName=id_of_alert, referencedTableName=notification_alert','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-626','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:40:51',624,'EXECUTED','8:b89d5041997285d87092384134d988e2','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=identifier_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-627','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:41:05',625,'EXECUTED','8:45b1f2e72faae44c6aabb846eb7a7990','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=identifier_voider, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-628','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:41:15',626,'EXECUTED','8:1ec314a54566d8a1749a7ed7297cbda4','addForeignKeyConstraint baseTableName=person_attribute, constraintName=identifies_person, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-629','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:41:23',627,'EXECUTED','8:db807c956e45a33f21cc15672920101a','addForeignKeyConstraint baseTableName=role_role, constraintName=inherited_role, referencedTableName=role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-630','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:41:27',628,'EXECUTED','8:da5615ab343e9ed9a7d0604ff50bb049','addForeignKeyConstraint baseTableName=drug_order, constraintName=inventory_item, referencedTableName=drug','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-631','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:41:41',629,'EXECUTED','8:559103057592c513461e34872ab98c82','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_attribute_type_id_fk, referencedTableName=location_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-632','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:41:49',630,'EXECUTED','8:f0ed1db50d2aaef52d7787e729067765','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-633','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:41:54',631,'EXECUTED','8:9053697625cec4b7181154ede82af8e1','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-634','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:42:05',632,'EXECUTED','8:25fa762d4a54cb768494393188a40f13','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_location_fk, referencedTableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-635','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:42:11',633,'EXECUTED','8:55bfc1c498d66b56056252e5e1bf38e3','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-636','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:42:20',634,'EXECUTED','8:caaf7c26f7283691746ca5cf776e17e1','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-637','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:42:31',635,'EXECUTED','8:b28edd14d548454ee5e31d5129932600','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-638','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:42:42',636,'EXECUTED','8:c9858f861bc729085245ab56d1db294c','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-639','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:42:50',637,'EXECUTED','8:9c5f3393d4a9a88d9b4bd434ea9e1033','addForeignKeyConstraint baseTableName=location, constraintName=location_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-640','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:42:57',638,'EXECUTED','8:0bd00341f91fb696b1bedccccd73f6c2','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-641','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:43:13',639,'EXECUTED','8:91fc0e963eae16130bcfdd515a5ae281','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-642','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:43:17',640,'EXECUTED','8:61c3eccfbd38970237b9757fb3002fb8','addForeignKeyConstraint baseTableName=location_tag_map, constraintName=location_tag_map_location, referencedTableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-643','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:43:24',641,'EXECUTED','8:49c4b5a03214ea9e7195d1a5fcc2b353','addForeignKeyConstraint baseTableName=location_tag_map, constraintName=location_tag_map_tag, referencedTableName=location_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-644','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:43:35',642,'EXECUTED','8:4f3813eecf2d7b5e04f9863404258d84','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_retired_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-645','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:43:47',643,'EXECUTED','8:c5fdb5309db2ec8e9ed2f0510c9c2138','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=map_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-646','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:43:52',644,'EXECUTED','8:4a43c5a94c750536bee6b283c505f829','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=map_for_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-647','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:43:55',645,'EXECUTED','8:54becb16ae94c3222c044550d5d6f056','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_concept_map_type, referencedTableName=concept_map_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-648','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:44:08',646,'EXECUTED','8:2467bca4029d86bceb6827936123016a','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_concept_map_type_ref_term_map, referencedTableName=concept_map_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-649','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:44:17',647,'EXECUTED','8:2c8ee6ec62f93dcc0f2c5b8049c2302e','addForeignKeyConstraint baseTableName=concept_name_tag_map, constraintName=mapped_concept_name, referencedTableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-650','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:44:21',648,'EXECUTED','8:123dae6f3c1bdbba9f0e038a75cadd18','addForeignKeyConstraint baseTableName=concept_name_tag_map, constraintName=mapped_concept_name_tag, referencedTableName=concept_name_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-651','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:44:34',649,'EXECUTED','8:6113bb795c41cd648452833ad0042a6f','addForeignKeyConstraint baseTableName=concept_proposal_tag_map, constraintName=mapped_concept_proposal, referencedTableName=concept_proposal','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-652','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:44:40',650,'EXECUTED','8:bb379d0d109c494e25d0aad46c4b708a','addForeignKeyConstraint baseTableName=concept_proposal_tag_map, constraintName=mapped_concept_proposal_tag, referencedTableName=concept_name_tag','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-653','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:44:53',651,'EXECUTED','8:d43ec007e993bc1ba8a32131d99c4934','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_concept_reference_term, referencedTableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-654','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:45:04',652,'EXECUTED','8:082f379958b4b6b0b60f8dacf700120d','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_concept_source, referencedTableName=concept_reference_source','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-655','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:45:19',653,'EXECUTED','8:fbaa69db4de6c1eeb907ffe63b8c0c10','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_term_a, referencedTableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-656','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:45:31',654,'EXECUTED','8:24f9c07d372054537e2a2ea87bd9631c','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_term_b, referencedTableName=concept_reference_term','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-657','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:45:37',655,'EXECUTED','8:30b7404b3900c6211bca9aed71900491','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_changed, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-658','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:45:41',656,'EXECUTED','8:57c58bfdec0f073948d2e817b630dcab','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_changed_concept_map_type, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-659','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:45:56',657,'EXECUTED','8:c821ce1c018a6faf63dd71082055395e','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_user_changed_ref_term, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-660','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:46:01',658,'EXECUTED','8:5b7076881c0ac0cf99d8c95b7d444aee','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_user_changed_ref_term_map, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-661','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:46:10',659,'EXECUTED','8:a1638b45c453e9eb9a3b134bde3f7511','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-662','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:46:16',660,'EXECUTED','8:7de2f45294f47a0e11920b3b35c80afc','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_creator_concept_map_type, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-663','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:46:30',661,'EXECUTED','8:8e584e915ed85cf967e02bba69ac0dc8','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_user_creator_ref_term_map, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-664','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:46:34',662,'EXECUTED','8:9134c8a4af26c7c2ea22247618bdfb40','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_retired, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-665','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:46:38',663,'EXECUTED','8:9cc8c64a1e7940f2bb38355dd376c886','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_retired_concept_map_type, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-666','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:46:50',664,'EXECUTED','8:3d4258ef0daff9793f9a952fdffb0c41','addForeignKeyConstraint baseTableName=cohort_member, constraintName=member_patient, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-667','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:05',665,'EXECUTED','8:666bc2a7c0279cbfd0305d8ff49ba8ee','addForeignKeyConstraint baseTableName=concept_name, constraintName=name_for_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-668','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:13',666,'EXECUTED','8:701e3bc4a6970fabf97dc342030a4c06','addForeignKeyConstraint baseTableName=person_name, constraintName=name_for_person, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-669','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:15',667,'EXECUTED','8:d1866f483f3bb96a94eac81896ac1953','addForeignKeyConstraint baseTableName=note, constraintName=note_hierarchy, referencedTableName=note','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-670','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:16',668,'EXECUTED','8:cb4d919e70133e597f64007fbf2948b3','addForeignKeyConstraint baseTableName=concept_numeric, constraintName=numeric_attributes, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-671','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:19',669,'EXECUTED','8:ce723ec131e65372d698e8f4f17c31ca','addForeignKeyConstraint baseTableName=obs, constraintName=obs_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-672','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:28',670,'EXECUTED','8:8f9bbcbadb0451fa6b7ce24203ce8657','addForeignKeyConstraint baseTableName=obs, constraintName=obs_enterer, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-673','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:39',671,'EXECUTED','8:19db7630095b44733983eb4220261063','addForeignKeyConstraint baseTableName=obs, constraintName=obs_grouping_id, referencedTableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-674','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:47',672,'EXECUTED','8:f3778f9e0c00c315c3800bc7b782a671','addForeignKeyConstraint baseTableName=obs, constraintName=obs_location, referencedTableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-675','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:53',673,'EXECUTED','8:b25c922870449bd0907794c59d83e383','addForeignKeyConstraint baseTableName=obs, constraintName=obs_name_of_coded_value, referencedTableName=concept_name','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-676','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:47:56',674,'EXECUTED','8:04161767dc1175e6bcde6531da741346','addForeignKeyConstraint baseTableName=note, constraintName=obs_note, referencedTableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-677','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:09',675,'EXECUTED','8:e470661ffd302542439b7eb3609111cd','addForeignKeyConstraint baseTableName=obs, constraintName=obs_order, referencedTableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-678','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:13',676,'EXECUTED','8:2cb7f76a9d99495e812c39ec388a6bef','addForeignKeyConstraint baseTableName=orders, constraintName=order_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-679','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:19',677,'EXECUTED','8:d9ed04c8d5baddb3d68fb12d393837cc','addForeignKeyConstraint baseTableName=orders, constraintName=order_for_patient, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-680','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:24',678,'EXECUTED','8:82c1c50be676174f52ee01c3f08a6c97','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-681','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:26',679,'EXECUTED','8:1a5d93f4f0b06bd21bb8601483b68297','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_concept_id_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-682','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:30',680,'EXECUTED','8:4e10969a38735815960341380ee10035','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-683','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:32',681,'EXECUTED','8:f1ccac259e4279e39ffaf281cb75e5ef','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_retired_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-684','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:43',682,'EXECUTED','8:b06b7ad924250754d8e4ae05f8375ca6','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-685','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:49',683,'EXECUTED','8:db59f16b55000d806437669be4338965','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-686','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:54',684,'EXECUTED','8:801a71a6636913fac4ab3edba7b5ea43','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-687','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:48:59',685,'EXECUTED','8:b51974fd7cb54147c5708857c63b5f4b','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_patient_id_fk, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-688','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:02',686,'EXECUTED','8:054d2e2db4143462eeea6ad1e06e5356','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_set_id_fk, referencedTableName=order_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-689','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:11',687,'EXECUTED','8:1745fc0d80bb9bcbdb08abda3b6f7565','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_voided_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-690','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:16',688,'EXECUTED','8:07198ea1b745a2d72fcaa28d994e72b9','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-691','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:19',689,'EXECUTED','8:83e6ccf66b8ed79ba263a796dd149baf','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-692','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:25',690,'EXECUTED','8:94e75871390bb64fcccb47aa1725903c','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-693','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:28',691,'EXECUTED','8:c8c694b06dd35f1da3426ac3181d9a74','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_concept_id_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-694','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:36',692,'EXECUTED','8:384c4abbf62461cd49ef2dc527d12722','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-695','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:47',693,'EXECUTED','8:c6f489f4278cf19fa33e39a0cd31a101','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_order_set_id_fk, referencedTableName=order_set','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-696','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:49',694,'EXECUTED','8:2633d85c3af4c94cbf2301fd3146086c','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_order_type_fk, referencedTableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-697','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:49:52',695,'EXECUTED','8:fef4d230928bf3ea7e4ece1161013076','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_retired_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-698','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:02',696,'EXECUTED','8:8cacc6031f21735211f4abcd31ddd88f','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_retired_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-699','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:06',697,'EXECUTED','8:b68e6a401034b93cf919550ae7c01236','addForeignKeyConstraint baseTableName=order_type, constraintName=order_type_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-700','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:10',698,'EXECUTED','8:8f9a1f9b5c29d91a7cfca6410ff23f99','addForeignKeyConstraint baseTableName=order_type, constraintName=order_type_parent_order_type, referencedTableName=order_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-701','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:18',699,'EXECUTED','8:8a5e47f2adbd789c9b8ddbdefd413a27','addForeignKeyConstraint baseTableName=orders, constraintName=orders_care_setting, referencedTableName=care_setting','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-702','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:20',700,'EXECUTED','8:b34eac879f2fb2d08e968218747ad8ab','addForeignKeyConstraint baseTableName=orders, constraintName=orders_in_encounter, referencedTableName=encounter','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-703','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:23',701,'EXECUTED','8:9bddd80656976d26e20202f8e5f0ffc8','addForeignKeyConstraint baseTableName=orders, constraintName=orders_order_group_id_fk, referencedTableName=order_group','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-704','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:26',702,'EXECUTED','8:8669298d0fbb0b0136fdd9233857d4ad','addForeignKeyConstraint baseTableName=cohort_member, constraintName=parent_cohort, referencedTableName=cohort','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-705','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:33',703,'EXECUTED','8:1438af742d5acc5940365ede8f3ceceb','addForeignKeyConstraint baseTableName=location, constraintName=parent_location, referencedTableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-706','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:39',704,'EXECUTED','8:9fcbe6d2601cac51aa3f458d6a035c60','addForeignKeyConstraint baseTableName=role_role, constraintName=parent_role, referencedTableName=role','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-707','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:41',705,'EXECUTED','8:1bd029cf8717e512c685cad38cf4d12b','addForeignKeyConstraint baseTableName=person_address, constraintName=patient_address_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-708','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:51',706,'EXECUTED','8:06fa710137b97c922bfaab061ad9293c','addForeignKeyConstraint baseTableName=person_address, constraintName=patient_address_void, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-709','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:50:57',707,'EXECUTED','8:aab960ea913b6ddd3127c14baf73c823','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=patient_identifier_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-710','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:06',708,'EXECUTED','8:17cb9af404062b01a5ab912efd281339','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=patient_identifier_ibfk_2, referencedTableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-711','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:10',709,'EXECUTED','8:c0b1f393954a90918f009d1cbc32cb63','addForeignKeyConstraint baseTableName=patient_identifier_type, constraintName=patient_identifier_type_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-712','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:24',710,'EXECUTED','8:34dec67047f0a39b208918ec21db5893','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_in_program, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-713','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:30',711,'EXECUTED','8:9ee961926d38a101798bb447b92a6c2d','addForeignKeyConstraint baseTableName=note, constraintName=patient_note, referencedTableName=patient','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-714','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:39',712,'EXECUTED','8:52a51ec6cd1c0737ad6a5f719c910969','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_attributetype_fk, referencedTableName=program_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-715','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:44',713,'EXECUTED','8:e161fefafcfee7977591996d6a1c53d6','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-716','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:46',714,'EXECUTED','8:0bd38a9b69329f52f5468385a98d774f','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-717','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:55',715,'EXECUTED','8:60e5ba2f6405a0116d60c2a952a25190','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_programid_fk, referencedTableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-718','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:57',716,'EXECUTED','8:8f15d936795e44307bec87846cd65b00','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-719','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:51:58',717,'EXECUTED','8:391cfe0ab46ac6cea973cea3a3545e33','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-720','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:07',718,'EXECUTED','8:7bd5776b0be8fac9dc94dfb88f00da7f','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_program_for_state, referencedTableName=patient_program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-721','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:13',719,'EXECUTED','8:9190ba5bf9823cd885efa25a83a578d9','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_location_id, referencedTableName=location','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-722','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:19',720,'EXECUTED','8:04b0bde679cb2101a63bd18d29aeee77','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_outcome_concept_id_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-723','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:22',721,'EXECUTED','8:09c964b19c46ae35f0861344281d0d91','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_changer, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-724','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:31',722,'EXECUTED','8:8b7ac0848be5c70d19764d59ca40aff4','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-725','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:36',723,'EXECUTED','8:b06ac13374b66e1d56e008b9dca28a88','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_voider, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-726','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:41',724,'EXECUTED','8:4166e03396d5cdbee3c4ea94ba58bfa2','addForeignKeyConstraint baseTableName=relationship, constraintName=person_a_is_person, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-727','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:47',725,'EXECUTED','8:996e5f32a4912adeed25e0bd685f1269','addForeignKeyConstraint baseTableName=person_address, constraintName=person_address_changed_by, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-728','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:50',726,'EXECUTED','8:d4d0032894d6ebee123d06ce5349464e','addForeignKeyConstraint baseTableName=relationship, constraintName=person_b_is_person, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-729','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:53',727,'EXECUTED','8:22477dea7d8ed4bbc85cc65f207ee05d','addForeignKeyConstraint baseTableName=person, constraintName=person_died_because, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-730','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:52:56',728,'EXECUTED','8:7d03edea9ef8a1f11bf2f6116a9f47fe','addForeignKeyConstraint baseTableName=patient, constraintName=person_id_for_patient, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-731','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:06',729,'EXECUTED','8:6138e932a8f7dc672b976c44a3c5619c','addForeignKeyConstraint baseTableName=users, constraintName=person_id_for_user, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-732','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:08',730,'EXECUTED','8:567fe452a2e7ae893a17afcc6103dd6f','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-733','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:10',731,'EXECUTED','8:2ad1f60029f2ce1b182f59e5d4220425','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-734','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:12',732,'EXECUTED','8:0350eec9ec5bfdd57c8ad13fbf5bbb2d','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_loser, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-735','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:15',733,'EXECUTED','8:1c08d6a13ef8d9666cb6c1b83a73861f','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_voided_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-736','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:23',734,'EXECUTED','8:f87ea09206b90f73bd071fb61cf567f4','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_winner, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-737','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:32',735,'EXECUTED','8:f0b2534406dbc50e53da76f45facc93e','addForeignKeyConstraint baseTableName=obs, constraintName=person_obs, referencedTableName=person','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-738','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:38',736,'EXECUTED','8:70c3d0c0adaa5e68504b6f778c5dbc8c','addForeignKeyConstraint baseTableName=orders, constraintName=previous_order_id_order_id, referencedTableName=orders','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-739','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:47',737,'EXECUTED','8:8bfedf09577dff4983a279b26382c718','addForeignKeyConstraint baseTableName=obs, constraintName=previous_version, referencedTableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-740','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:49',738,'EXECUTED','8:0e582969c42698d575c944782d71ec2c','addForeignKeyConstraint baseTableName=drug, constraintName=primary_drug_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-741','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:52',739,'EXECUTED','8:3504918956d1525b97cc077a5f91c544','addForeignKeyConstraint baseTableName=role_privilege, constraintName=privilege_definitions, referencedTableName=privilege','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-742','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:53:57',740,'EXECUTED','8:d1bda4909128e34a7312587b02425cb6','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=privilege_which_can_edit, referencedTableName=privilege','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-743','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:01',741,'EXECUTED','8:456e9cc829e92a93994e9029368d90f9','addForeignKeyConstraint baseTableName=encounter_type, constraintName=privilege_which_can_edit_encounter_type, referencedTableName=privilege','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-744','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:03',742,'EXECUTED','8:8ce1f2486f15760dc9c942bb41cafadb','addForeignKeyConstraint baseTableName=encounter_type, constraintName=privilege_which_can_view_encounter_type, referencedTableName=privilege','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-745','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:09',743,'EXECUTED','8:cf0afb19ccd46f8be51d48a105be071c','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-746','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:16',744,'EXECUTED','8:d72f0c2b1ada2b3b917ebe3937480494','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-747','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:22',745,'EXECUTED','8:3b575ae1da7da6e2bef9733217b30260','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-748','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:26',746,'EXECUTED','8:e1259106d9e68fbc9f745ff166d0f607','addForeignKeyConstraint baseTableName=program, constraintName=program_concept, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-749','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:29',747,'EXECUTED','8:83c1da42e28b3ee703b4ba9f7a135b52','addForeignKeyConstraint baseTableName=program, constraintName=program_creator, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-750','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:40',748,'EXECUTED','8:04b4751737c937eff17ef2586b6c329c','addForeignKeyConstraint baseTableName=patient_program, constraintName=program_for_patient, referencedTableName=program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-751','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:46',749,'EXECUTED','8:7b2cc29cbc7bcfee9385f6c53f6c6d6c','addForeignKeyConstraint baseTableName=program_workflow, constraintName=program_for_workflow, referencedTableName=program','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-752','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:49',750,'EXECUTED','8:3debc27e4493cc2fc2e55763a55fd7c6','addForeignKeyConstraint baseTableName=program, constraintName=program_outcomes_concept_id_fk, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-753','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:54:56',751,'EXECUTED','8:0fb2cdfa9a72f2d9dccfc130f52f2d48','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=proposal_obs_concept_id, referencedTableName=concept','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-754','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:55:00',752,'EXECUTED','8:da7e5963f137ab11e91395eb1741fbd8','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=proposal_obs_id, referencedTableName=obs','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-755','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:55:02',753,'EXECUTED','8:92a0046d7220d0babd6f79e0e9865916','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_attribute_type_id_fk, referencedTableName=provider_attribute_type','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-756','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:55:15',754,'EXECUTED','8:20003c0fdad7306a5e412886292a7c77','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL),('1582473628795-757','wolf (generated)','liquibase-schema-only.xml','2021-02-05 19:55:17',755,'EXECUTED','8:feb5a286ea545d2728cdf5c68111912e','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.3',NULL,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangeloglock`
--

DROP TABLE IF EXISTS `liquibasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangeloglock`
--

LOCK TABLES `liquibasechangeloglock` WRITE;
/*!40000 ALTER TABLE `liquibasechangeloglock` DISABLE KEYS */;
INSERT INTO `liquibasechangeloglock` VALUES (1,0,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `parent_location` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `address7` varchar(255) DEFAULT NULL,
  `address8` varchar(255) DEFAULT NULL,
  `address9` varchar(255) DEFAULT NULL,
  `address10` varchar(255) DEFAULT NULL,
  `address11` varchar(255) DEFAULT NULL,
  `address12` varchar(255) DEFAULT NULL,
  `address13` varchar(255) DEFAULT NULL,
  `address14` varchar(255) DEFAULT NULL,
  `address15` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_changed_by` (`changed_by`),
  KEY `location_retired_status` (`retired`),
  KEY `name_of_location` (`name`),
  KEY `parent_location` (`parent_location`),
  KEY `user_who_created_location` (`creator`),
  KEY `user_who_retired_location` (`retired_by`),
  CONSTRAINT `location_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_location` FOREIGN KEY (`parent_location`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_attribute`
--

DROP TABLE IF EXISTS `location_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_attribute` (
  `location_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `location_attribute_changed_by_fk` (`changed_by`),
  KEY `location_attribute_creator_fk` (`creator`),
  KEY `location_attribute_location_fk` (`location_id`),
  KEY `location_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `location_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `location_attribute_type` (`location_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_attribute`
--

LOCK TABLES `location_attribute` WRITE;
/*!40000 ALTER TABLE `location_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_attribute_type`
--

DROP TABLE IF EXISTS `location_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_attribute_type` (
  `location_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`location_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_type_changed_by_fk` (`changed_by`),
  KEY `location_attribute_type_creator_fk` (`creator`),
  KEY `location_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `location_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_attribute_type`
--

LOCK TABLES `location_attribute_type` WRITE;
/*!40000 ALTER TABLE `location_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag`
--

DROP TABLE IF EXISTS `location_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag` (
  `location_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`location_tag_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_tag_changed_by` (`changed_by`),
  KEY `location_tag_creator` (`creator`),
  KEY `location_tag_retired_by` (`retired_by`),
  CONSTRAINT `location_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag`
--

LOCK TABLES `location_tag` WRITE;
/*!40000 ALTER TABLE `location_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag_map`
--

DROP TABLE IF EXISTS `location_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag_map` (
  `location_id` int(11) NOT NULL,
  `location_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`location_tag_id`),
  KEY `location_tag_map_tag` (`location_tag_id`),
  CONSTRAINT `location_tag_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_map_tag` FOREIGN KEY (`location_tag_id`) REFERENCES `location_tag` (`location_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag_map`
--

LOCK TABLES `location_tag_map` WRITE;
/*!40000 ALTER TABLE `location_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `note_id` int(11) NOT NULL DEFAULT '0',
  `note_type` varchar(50) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `text` text NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_note` (`encounter_id`),
  KEY `note_hierarchy` (`parent`),
  KEY `obs_note` (`obs_id`),
  KEY `patient_note` (`patient_id`),
  KEY `user_who_changed_note` (`changed_by`),
  KEY `user_who_created_note` (`creator`),
  CONSTRAINT `encounter_note` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `note_hierarchy` FOREIGN KEY (`parent`) REFERENCES `note` (`note_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_note` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_note` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert`
--

DROP TABLE IF EXISTS `notification_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(512) NOT NULL,
  `satisfied_by_any` tinyint(1) NOT NULL DEFAULT '0',
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_to_expire` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `alert_creator` (`creator`),
  KEY `alert_date_to_expire_idx` (`date_to_expire`),
  KEY `user_who_changed_alert` (`changed_by`),
  CONSTRAINT `alert_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert`
--

LOCK TABLES `notification_alert` WRITE;
/*!40000 ALTER TABLE `notification_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert_recipient`
--

DROP TABLE IF EXISTS `notification_alert_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert_recipient` (
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`,`user_id`),
  KEY `alert_read_by_user` (`user_id`),
  CONSTRAINT `alert_read_by_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_of_alert` FOREIGN KEY (`alert_id`) REFERENCES `notification_alert` (`alert_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert_recipient`
--

LOCK TABLES `notification_alert_recipient` WRITE;
/*!40000 ALTER TABLE `notification_alert_recipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_alert_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_template`
--

DROP TABLE IF EXISTS `notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `template` text,
  `subject` varchar(100) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `recipients` varchar(512) DEFAULT NULL,
  `ordinal` int(11) DEFAULT '0',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_template`
--

LOCK TABLES `notification_template` WRITE;
/*!40000 ALTER TABLE `notification_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obs`
--

DROP TABLE IF EXISTS `obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs` (
  `obs_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `encounter_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `obs_datetime` datetime NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `obs_group_id` int(11) DEFAULT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `value_group_id` int(11) DEFAULT NULL,
  `value_coded` int(11) DEFAULT NULL,
  `value_coded_name_id` int(11) DEFAULT NULL,
  `value_drug` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_modifier` varchar(2) DEFAULT NULL,
  `value_text` text,
  `value_complex` varchar(1000) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `form_namespace_and_path` varchar(255) DEFAULT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'FINAL',
  `interpretation` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `answer_concept` (`value_coded`),
  KEY `answer_concept_drug` (`value_drug`),
  KEY `encounter_observations` (`encounter_id`),
  KEY `obs_concept` (`concept_id`),
  KEY `obs_datetime_idx` (`obs_datetime`),
  KEY `obs_enterer` (`creator`),
  KEY `obs_grouping_id` (`obs_group_id`),
  KEY `obs_location` (`location_id`),
  KEY `obs_name_of_coded_value` (`value_coded_name_id`),
  KEY `obs_order` (`order_id`),
  KEY `person_obs` (`person_id`),
  KEY `previous_version` (`previous_version`),
  KEY `user_who_voided_obs` (`voided_by`),
  CONSTRAINT `answer_concept` FOREIGN KEY (`value_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_concept_drug` FOREIGN KEY (`value_drug`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_observations` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_enterer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_grouping_id` FOREIGN KEY (`obs_group_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_name_of_coded_value` FOREIGN KEY (`value_coded_name_id`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_obs` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `previous_version` FOREIGN KEY (`previous_version`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obs`
--

LOCK TABLES `obs` WRITE;
/*!40000 ALTER TABLE `obs` DISABLE KEYS */;
/*!40000 ALTER TABLE `obs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_frequency`
--

DROP TABLE IF EXISTS `order_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_frequency` (
  `order_frequency_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `frequency_per_day` double DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_frequency_id`),
  UNIQUE KEY `concept_id` (`concept_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_frequency_changed_by_fk` (`changed_by`),
  KEY `order_frequency_creator_fk` (`creator`),
  KEY `order_frequency_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_frequency_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_frequency`
--

LOCK TABLES `order_frequency` WRITE;
/*!40000 ALTER TABLE `order_frequency` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_group`
--

DROP TABLE IF EXISTS `order_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_group` (
  `order_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_set_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_group_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_changed_by_fk` (`changed_by`),
  KEY `order_group_creator_fk` (`creator`),
  KEY `order_group_encounter_id_fk` (`encounter_id`),
  KEY `order_group_patient_id_fk` (`patient_id`),
  KEY `order_group_set_id_fk` (`order_set_id`),
  KEY `order_group_voided_by_fk` (`voided_by`),
  CONSTRAINT `order_group_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_group`
--

LOCK TABLES `order_group` WRITE;
/*!40000 ALTER TABLE `order_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set`
--

DROP TABLE IF EXISTS `order_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set` (
  `order_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `category_order_set_fk` (`category`),
  KEY `order_set_changed_by_fk` (`changed_by`),
  KEY `order_set_creator_fk` (`creator`),
  KEY `order_set_retired_by_fk` (`retired_by`),
  CONSTRAINT `category_order_set_fk` FOREIGN KEY (`category`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set`
--

LOCK TABLES `order_set` WRITE;
/*!40000 ALTER TABLE `order_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set_member`
--

DROP TABLE IF EXISTS `order_set_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set_member` (
  `order_set_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type` int(11) NOT NULL,
  `order_template` text,
  `order_template_type` varchar(1024) DEFAULT NULL,
  `order_set_id` int(11) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_set_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_member_changed_by_fk` (`changed_by`),
  KEY `order_set_member_concept_id_fk` (`concept_id`),
  KEY `order_set_member_creator_fk` (`creator`),
  KEY `order_set_member_order_set_id_fk` (`order_set_id`),
  KEY `order_set_member_order_type_fk` (`order_type`),
  KEY `order_set_member_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_set_member_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_order_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_order_type_fk` FOREIGN KEY (`order_type`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set_member`
--

LOCK TABLES `order_set_member` WRITE;
/*!40000 ALTER TABLE `order_set_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type`
--

DROP TABLE IF EXISTS `order_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type` (
  `order_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `java_class_name` varchar(255) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`order_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_type_changed_by` (`changed_by`),
  KEY `order_type_parent_order_type` (`parent`),
  KEY `order_type_retired_status` (`retired`),
  KEY `type_created_by` (`creator`),
  KEY `user_who_retired_order_type` (`retired_by`),
  CONSTRAINT `order_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_type_parent_order_type` FOREIGN KEY (`parent`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type`
--

LOCK TABLES `order_type` WRITE;
/*!40000 ALTER TABLE `order_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type_class_map`
--

DROP TABLE IF EXISTS `order_type_class_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type_class_map` (
  `order_type_id` int(11) NOT NULL,
  `concept_class_id` int(11) NOT NULL,
  PRIMARY KEY (`order_type_id`,`concept_class_id`),
  UNIQUE KEY `concept_class_id` (`concept_class_id`),
  CONSTRAINT `fk_order_type_class_map_concept_class_concept_class_id` FOREIGN KEY (`concept_class_id`) REFERENCES `concept_class` (`concept_class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_type_order_type_id` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type_class_map`
--

LOCK TABLES `order_type_class_map` WRITE;
/*!40000 ALTER TABLE `order_type_class_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_type_class_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `orderer` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `instructions` text,
  `date_activated` datetime DEFAULT NULL,
  `auto_expire_date` datetime DEFAULT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `order_reason` int(11) DEFAULT NULL,
  `order_reason_non_coded` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `urgency` varchar(50) NOT NULL DEFAULT 'ROUTINE',
  `order_number` varchar(50) NOT NULL,
  `previous_order_id` int(11) DEFAULT NULL,
  `order_action` varchar(50) NOT NULL,
  `comment_to_fulfiller` varchar(1024) DEFAULT NULL,
  `care_setting` int(11) NOT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `order_group_id` int(11) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `fulfiller_comment` varchar(1024) DEFAULT NULL,
  `fulfiller_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `discontinued_because` (`order_reason`),
  KEY `fk_orderer_provider` (`orderer`),
  KEY `order_creator` (`creator`),
  KEY `order_for_patient` (`patient_id`),
  KEY `orders_care_setting` (`care_setting`),
  KEY `orders_in_encounter` (`encounter_id`),
  KEY `orders_order_group_id_fk` (`order_group_id`),
  KEY `previous_order_id_order_id` (`previous_order_id`),
  KEY `type_of_order` (`order_type_id`),
  KEY `user_who_voided_order` (`voided_by`),
  CONSTRAINT `discontinued_because` FOREIGN KEY (`order_reason`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderer_provider` FOREIGN KEY (`orderer`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `orders_care_setting` FOREIGN KEY (`care_setting`) REFERENCES `care_setting` (`care_setting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orders_in_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orders_order_group_id_fk` FOREIGN KEY (`order_group_id`) REFERENCES `order_group` (`order_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `previous_order_id_order_id` FOREIGN KEY (`previous_order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `allergy_status` varchar(50) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`patient_id`),
  KEY `user_who_changed_pat` (`changed_by`),
  KEY `user_who_created_patient` (`creator`),
  KEY `user_who_voided_patient` (`voided_by`),
  CONSTRAINT `person_id_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier`
--

DROP TABLE IF EXISTS `patient_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier` (
  `patient_identifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_identifier_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `defines_identifier_type` (`identifier_type`),
  KEY `identifier_creator` (`creator`),
  KEY `identifier_name` (`identifier`),
  KEY `identifier_voider` (`voided_by`),
  KEY `idx_patient_identifier_patient` (`patient_id`),
  KEY `patient_identifier_changed_by` (`changed_by`),
  KEY `patient_identifier_ibfk_2` (`location_id`),
  CONSTRAINT `defines_identifier_type` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_id_patient_identifier` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifier_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifier_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_identifier_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_identifier_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier`
--

LOCK TABLES `patient_identifier` WRITE;
/*!40000 ALTER TABLE `patient_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier_type`
--

DROP TABLE IF EXISTS `patient_identifier_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier_type` (
  `patient_identifier_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text,
  `format` varchar(255) DEFAULT NULL,
  `check_digit` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `format_description` varchar(255) DEFAULT NULL,
  `validator` varchar(200) DEFAULT NULL,
  `location_behavior` varchar(50) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `uniqueness_behavior` varchar(50) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient_identifier_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_identifier_type_changed_by` (`changed_by`),
  KEY `patient_identifier_type_retired_status` (`retired`),
  KEY `type_creator` (`creator`),
  KEY `user_who_retired_patient_identifier_type` (`retired_by`),
  CONSTRAINT `patient_identifier_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier_type`
--

LOCK TABLES `patient_identifier_type` WRITE;
/*!40000 ALTER TABLE `patient_identifier_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_identifier_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program`
--

DROP TABLE IF EXISTS `patient_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program` (
  `patient_program_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `program_id` int(11) NOT NULL DEFAULT '0',
  `date_enrolled` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `outcome_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_program_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_in_program` (`patient_id`),
  KEY `patient_program_creator` (`creator`),
  KEY `patient_program_location_id` (`location_id`),
  KEY `patient_program_outcome_concept_id_fk` (`outcome_concept_id`),
  KEY `program_for_patient` (`program_id`),
  KEY `user_who_changed` (`changed_by`),
  KEY `user_who_voided_patient_program` (`voided_by`),
  CONSTRAINT `patient_in_program` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `patient_program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_outcome_concept_id_fk` FOREIGN KEY (`outcome_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_for_patient` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program`
--

LOCK TABLES `patient_program` WRITE;
/*!40000 ALTER TABLE `patient_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program_attribute`
--

DROP TABLE IF EXISTS `patient_program_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program_attribute` (
  `patient_program_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patient_program_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_program_attribute_attributetype_fk` (`attribute_type_id`),
  KEY `patient_program_attribute_changed_by_fk` (`changed_by`),
  KEY `patient_program_attribute_creator_fk` (`creator`),
  KEY `patient_program_attribute_programid_fk` (`patient_program_id`),
  KEY `patient_program_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `patient_program_attribute_attributetype_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `program_attribute_type` (`program_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_programid_fk` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program_attribute`
--

LOCK TABLES `patient_program_attribute` WRITE;
/*!40000 ALTER TABLE `patient_program_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_state`
--

DROP TABLE IF EXISTS `patient_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_state` (
  `patient_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_state_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_program_for_state` (`patient_program_id`),
  KEY `patient_state_changer` (`changed_by`),
  KEY `patient_state_creator` (`creator`),
  KEY `patient_state_voider` (`voided_by`),
  KEY `state_for_patient` (`state`),
  CONSTRAINT `patient_program_for_state` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_state`
--

LOCK TABLES `patient_state` WRITE;
/*!40000 ALTER TABLE `patient_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) DEFAULT '',
  `birthdate` date DEFAULT NULL,
  `birthdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `dead` tinyint(1) NOT NULL DEFAULT '0',
  `death_date` datetime DEFAULT NULL,
  `cause_of_death` int(11) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `deathdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `birthtime` time DEFAULT NULL,
  `cause_of_death_non_coded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_birthdate` (`birthdate`),
  KEY `person_death_date` (`death_date`),
  KEY `person_died_because` (`cause_of_death`),
  KEY `user_who_changed_person` (`changed_by`),
  KEY `user_who_created_person` (`creator`),
  KEY `user_who_voided_person` (`voided_by`),
  CONSTRAINT `person_died_because` FOREIGN KEY (`cause_of_death`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_address` (
  `person_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `address7` varchar(255) DEFAULT NULL,
  `address8` varchar(255) DEFAULT NULL,
  `address9` varchar(255) DEFAULT NULL,
  `address10` varchar(255) DEFAULT NULL,
  `address11` varchar(255) DEFAULT NULL,
  `address12` varchar(255) DEFAULT NULL,
  `address13` varchar(255) DEFAULT NULL,
  `address14` varchar(255) DEFAULT NULL,
  `address15` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_address_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `address_for_person` (`person_id`),
  KEY `patient_address_creator` (`creator`),
  KEY `patient_address_void` (`voided_by`),
  KEY `person_address_changed_by` (`changed_by`),
  CONSTRAINT `address_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `patient_address_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_address_void` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_address_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_address`
--

LOCK TABLES `person_address` WRITE;
/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute`
--

DROP TABLE IF EXISTS `person_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute` (
  `person_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(50) NOT NULL DEFAULT '',
  `person_attribute_type_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `attribute_changer` (`changed_by`),
  KEY `attribute_creator` (`creator`),
  KEY `attribute_voider` (`voided_by`),
  KEY `defines_attribute_type` (`person_attribute_type_id`),
  KEY `identifies_person` (`person_id`),
  CONSTRAINT `attribute_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `defines_attribute_type` FOREIGN KEY (`person_attribute_type_id`) REFERENCES `person_attribute_type` (`person_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifies_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute`
--

LOCK TABLES `person_attribute` WRITE;
/*!40000 ALTER TABLE `person_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute_type`
--

DROP TABLE IF EXISTS `person_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute_type` (
  `person_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text,
  `format` varchar(50) DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `attribute_is_searchable` (`searchable`),
  KEY `attribute_type_changer` (`changed_by`),
  KEY `attribute_type_creator` (`creator`),
  KEY `name_of_attribute` (`name`),
  KEY `person_attribute_type_retired_status` (`retired`),
  KEY `privilege_which_can_edit` (`edit_privilege`),
  KEY `user_who_retired_person_attribute_type` (`retired_by`),
  CONSTRAINT `attribute_type_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_edit` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute_type`
--

LOCK TABLES `person_attribute_type` WRITE;
/*!40000 ALTER TABLE `person_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_merge_log`
--

DROP TABLE IF EXISTS `person_merge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_merge_log` (
  `person_merge_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `winner_person_id` int(11) NOT NULL,
  `loser_person_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `merged_data` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_merge_log_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_merge_log_changed_by_fk` (`changed_by`),
  KEY `person_merge_log_creator` (`creator`),
  KEY `person_merge_log_loser` (`loser_person_id`),
  KEY `person_merge_log_voided_by_fk` (`voided_by`),
  KEY `person_merge_log_winner` (`winner_person_id`),
  CONSTRAINT `person_merge_log_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_loser` FOREIGN KEY (`loser_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_winner` FOREIGN KEY (`winner_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_merge_log`
--

LOCK TABLES `person_merge_log` WRITE;
/*!40000 ALTER TABLE `person_merge_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_merge_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_name`
--

DROP TABLE IF EXISTS `person_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `person_id` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `given_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `family_name_prefix` varchar(50) DEFAULT NULL,
  `family_name` varchar(50) DEFAULT NULL,
  `family_name2` varchar(50) DEFAULT NULL,
  `family_name_suffix` varchar(50) DEFAULT NULL,
  `degree` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_name_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `family_name2` (`family_name2`),
  KEY `first_name` (`given_name`),
  KEY `last_name` (`family_name`),
  KEY `middle_name` (`middle_name`),
  KEY `name_for_person` (`person_id`),
  KEY `user_who_made_name` (`creator`),
  KEY `user_who_voided_name` (`voided_by`),
  CONSTRAINT `name_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_name`
--

LOCK TABLES `person_name` WRITE;
/*!40000 ALTER TABLE `person_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privilege` (
  `privilege` varchar(255) NOT NULL,
  `description` text,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`privilege`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege`
--

LOCK TABLES `privilege` WRITE;
/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `outcomes_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `description` text,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_concept` (`concept_id`),
  KEY `program_creator` (`creator`),
  KEY `program_outcomes_concept_id_fk` (`outcomes_concept_id`),
  KEY `user_who_changed_program` (`changed_by`),
  CONSTRAINT `program_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_outcomes_concept_id_fk` FOREIGN KEY (`outcomes_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_attribute_type`
--

DROP TABLE IF EXISTS `program_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_attribute_type` (
  `program_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_attribute_type_changed_by_fk` (`changed_by`),
  KEY `program_attribute_type_creator_fk` (`creator`),
  KEY `program_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `program_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_attribute_type`
--

LOCK TABLES `program_attribute_type` WRITE;
/*!40000 ALTER TABLE `program_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow`
--

DROP TABLE IF EXISTS `program_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow` (
  `program_workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_workflow_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_for_workflow` (`program_id`),
  KEY `workflow_changed_by` (`changed_by`),
  KEY `workflow_concept` (`concept_id`),
  KEY `workflow_creator` (`creator`),
  CONSTRAINT `program_for_workflow` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow`
--

LOCK TABLES `program_workflow` WRITE;
/*!40000 ALTER TABLE `program_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow_state`
--

DROP TABLE IF EXISTS `program_workflow_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow_state` (
  `program_workflow_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_workflow_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `initial` tinyint(1) NOT NULL DEFAULT '0',
  `terminal` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_workflow_state_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `state_changed_by` (`changed_by`),
  KEY `state_concept` (`concept_id`),
  KEY `state_creator` (`creator`),
  KEY `workflow_for_state` (`program_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow_state`
--

LOCK TABLES `program_workflow_state` WRITE;
/*!40000 ALTER TABLE `program_workflow_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `speciality_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_changed_by_fk` (`changed_by`),
  KEY `provider_creator_fk` (`creator`),
  KEY `provider_person_id_fk` (`person_id`),
  KEY `provider_retired_by_fk` (`retired_by`),
  KEY `provider_role_id_fk` (`role_id`),
  KEY `provider_speciality_id_fk` (`speciality_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_attribute`
--

DROP TABLE IF EXISTS `provider_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_attribute` (
  `provider_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`provider_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `provider_attribute_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_creator_fk` (`creator`),
  KEY `provider_attribute_provider_fk` (`provider_id`),
  KEY `provider_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `provider_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `provider_attribute_type` (`provider_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_provider_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_attribute`
--

LOCK TABLES `provider_attribute` WRITE;
/*!40000 ALTER TABLE `provider_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_attribute_type`
--

DROP TABLE IF EXISTS `provider_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_attribute_type` (
  `provider_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`provider_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_type_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_type_creator_fk` (`creator`),
  KEY `provider_attribute_type_retired_by_fk` (`retired_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_attribute_type`
--

LOCK TABLES `provider_attribute_type` WRITE;
/*!40000 ALTER TABLE `provider_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_a` int(11) NOT NULL,
  `relationship` int(11) NOT NULL DEFAULT '0',
  `person_b` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`relationship_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_a_is_person` (`person_a`),
  KEY `person_b_is_person` (`person_b`),
  KEY `relation_creator` (`creator`),
  KEY `relation_voider` (`voided_by`),
  KEY `relationship_changed_by` (`changed_by`),
  KEY `relationship_type_id` (`relationship`),
  CONSTRAINT `person_a_is_person` FOREIGN KEY (`person_a`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_b_is_person` FOREIGN KEY (`person_b`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship`
--

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship_type` (
  `relationship_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_is_to_b` varchar(50) NOT NULL,
  `b_is_to_a` varchar(50) NOT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `weight` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`relationship_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `relationship_type_changed_by` (`changed_by`),
  KEY `user_who_created_rel` (`creator`),
  KEY `user_who_retired_relationship_type` (`retired_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship_type`
--

LOCK TABLES `relationship_type` WRITE;
/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_object`
--

DROP TABLE IF EXISTS `report_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_object` (
  `report_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_object_type` varchar(255) NOT NULL,
  `report_object_sub_type` varchar(255) NOT NULL,
  `xml_data` text,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`report_object_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `report_object_creator` (`creator`),
  KEY `user_who_changed_report_object` (`changed_by`),
  KEY `user_who_voided_report_object` (`voided_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_object`
--

LOCK TABLES `report_object` WRITE;
/*!40000 ALTER TABLE `report_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_schema_xml`
--

DROP TABLE IF EXISTS `report_schema_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_schema_xml` (
  `report_schema_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `xml_data` text NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`report_schema_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_schema_xml`
--

LOCK TABLES `report_schema_xml` WRITE;
/*!40000 ALTER TABLE `report_schema_xml` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_schema_xml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`role`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_privilege` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `privilege` varchar(255) NOT NULL,
  PRIMARY KEY (`role`,`privilege`),
  KEY `privilege_definitions` (`privilege`),
  KEY `role_privilege_to_role` (`role`),
  CONSTRAINT `privilege_definitions` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_privilege`
--

LOCK TABLES `role_privilege` WRITE;
/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_role`
--

DROP TABLE IF EXISTS `role_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_role` (
  `parent_role` varchar(50) NOT NULL DEFAULT '',
  `child_role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`parent_role`,`child_role`),
  KEY `inherited_role` (`child_role`),
  CONSTRAINT `inherited_role` FOREIGN KEY (`child_role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_role` FOREIGN KEY (`parent_role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_role`
--

LOCK TABLES `role_role` WRITE;
/*!40000 ALTER TABLE `role_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config`
--

DROP TABLE IF EXISTS `scheduler_task_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config` (
  `task_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `schedulable_class` text,
  `start_time` datetime DEFAULT NULL,
  `start_time_pattern` varchar(50) DEFAULT NULL,
  `repeat_interval` int(11) NOT NULL DEFAULT '0',
  `start_on_startup` tinyint(1) NOT NULL DEFAULT '0',
  `started` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(11) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `last_execution_time` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`task_config_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `scheduler_changer` (`changed_by`),
  KEY `scheduler_creator` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config`
--

LOCK TABLES `scheduler_task_config` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config_property`
--

DROP TABLE IF EXISTS `scheduler_task_config_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config_property` (
  `task_config_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text,
  `task_config_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_config_property_id`),
  KEY `task_config_for_property` (`task_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config_property`
--

LOCK TABLES `scheduler_task_config_property` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_config_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serialized_object`
--

DROP TABLE IF EXISTS `serialized_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serialized_object` (
  `serialized_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `subtype` varchar(255) NOT NULL,
  `serialization_class` varchar(255) NOT NULL,
  `serialized_data` mediumtext NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(1000) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`serialized_object_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `serialized_object_changed_by` (`changed_by`),
  KEY `serialized_object_creator` (`creator`),
  KEY `serialized_object_retired_by` (`retired_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serialized_object`
--

LOCK TABLES `serialized_object` WRITE;
/*!40000 ALTER TABLE `serialized_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialized_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_order`
--

DROP TABLE IF EXISTS `test_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `specimen_source` int(11) DEFAULT NULL,
  `laterality` varchar(20) DEFAULT NULL,
  `clinical_history` text,
  `frequency` int(11) DEFAULT NULL,
  `number_of_repeats` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `test_order_frequency_fk` (`frequency`),
  KEY `test_order_specimen_source_fk` (`specimen_source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_order`
--

LOCK TABLES `test_order` WRITE;
/*!40000 ALTER TABLE `test_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_property`
--

DROP TABLE IF EXISTS `user_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_property` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `property` varchar(100) NOT NULL DEFAULT '',
  `property_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`property`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_property`
--

LOCK TABLES `user_property` WRITE;
/*!40000 ALTER TABLE `user_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`role`),
  KEY `role_definitions` (`role`),
  KEY `user_role_to_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_id` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `salt` varchar(128) DEFAULT NULL,
  `secret_question` varchar(255) DEFAULT NULL,
  `secret_answer` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `activation_key` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `person_id_for_user` (`person_id`),
  KEY `user_creator` (`creator`),
  KEY `user_who_changed_user` (`changed_by`),
  KEY `user_who_retired_this_user` (`retired_by`),
  CONSTRAINT `person_id_for_user` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit` (
  `visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `visit_type_id` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `indication_concept_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_changed_by_fk` (`changed_by`),
  KEY `visit_creator_fk` (`creator`),
  KEY `visit_indication_concept_fk` (`indication_concept_id`),
  KEY `visit_location_fk` (`location_id`),
  KEY `visit_patient_index` (`patient_id`),
  KEY `visit_type_fk` (`visit_type_id`),
  KEY `visit_voided_by_fk` (`voided_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_attribute`
--

DROP TABLE IF EXISTS `visit_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_attribute` (
  `visit_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`visit_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `visit_attribute_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_creator_fk` (`creator`),
  KEY `visit_attribute_visit_fk` (`visit_id`),
  KEY `visit_attribute_voided_by_fk` (`voided_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_attribute`
--

LOCK TABLES `visit_attribute` WRITE;
/*!40000 ALTER TABLE `visit_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_attribute_type`
--

DROP TABLE IF EXISTS `visit_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_attribute_type` (
  `visit_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_type_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_type_creator_fk` (`creator`),
  KEY `visit_attribute_type_retired_by_fk` (`retired_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_attribute_type`
--

LOCK TABLES `visit_attribute_type` WRITE;
/*!40000 ALTER TABLE `visit_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_type`
--

DROP TABLE IF EXISTS `visit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_type` (
  `visit_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_type_changed_by` (`changed_by`),
  KEY `visit_type_creator` (`creator`),
  KEY `visit_type_retired_by` (`retired_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_type`
--

LOCK TABLES `visit_type` WRITE;
/*!40000 ALTER TABLE `visit_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-13 23:57:25

DELETE FROM `openmrs`.global_property WHERE property = 'search.indexVersion'