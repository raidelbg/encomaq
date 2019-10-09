-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: db_encomaq_v2
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.19.04.1

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
-- Table structure for table `biz_carrier`
--

DROP TABLE IF EXISTS `biz_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_carrier` (
  `idcarrier` int(11) NOT NULL AUTO_INCREMENT,
  `ididentifytype` int(11) NOT NULL,
  `identify` varchar(13) NOT NULL,
  `carriername` varchar(200) NOT NULL,
  `licenseplate` varchar(15) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idcarrier`) USING BTREE,
  KEY `carrier_identifytype_ididentifytype_fk` (`ididentifytype`) USING BTREE,
  CONSTRAINT `carrier_identifytype_ididentifytype_fk` FOREIGN KEY (`ididentifytype`) REFERENCES `nom_identifytype` (`ididentifytype`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_carrier`
--

LOCK TABLES `biz_carrier` WRITE;
/*!40000 ALTER TABLE `biz_carrier` DISABLE KEYS */;
INSERT INTO `biz_carrier` VALUES (1,2,'1709213720','JUAN ALOMOTO','PBA 7766',1,'2018-09-13 21:21:42','2018-09-14 17:53:40'),(2,2,'1721063350','JUAN CARLOS TERMAL','PSI 603',1,'2018-09-13 21:22:21','2018-09-13 21:22:21'),(3,2,'3234496733','LUIS ORELLANA','PBA766',1,'2018-09-14 17:52:51','2018-09-14 17:52:51');
/*!40000 ALTER TABLE `biz_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_client`
--

DROP TABLE IF EXISTS `biz_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_client` (
  `idclient` int(11) NOT NULL AUTO_INCREMENT,
  `ididentifytype` int(11) NOT NULL,
  `businessname` varchar(200) NOT NULL COMMENT 'NOMBRE/RAZON SOCIAL',
  `identify` varchar(13) NOT NULL,
  `phone` text,
  `phone_2` text,
  `address` text,
  `email` text,
  `email_2` text,
  `email_3` text,
  `observation` text,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idclient`) USING BTREE,
  KEY `client_identifytype_ididentifytype_fk` (`ididentifytype`) USING BTREE,
  CONSTRAINT `client_identifytype_ididentifytype_fk` FOREIGN KEY (`ididentifytype`) REFERENCES `nom_identifytype` (`ididentifytype`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_client`
--

LOCK TABLES `biz_client` WRITE;
/*!40000 ALTER TABLE `biz_client` DISABLE KEYS */;
INSERT INTO `biz_client` VALUES (1,1,'ANDINO Y ASOCIADOS','1791314824011','6021240',NULL,'MUROS N27-75 Y 12 DE OCTUBRE','facturas@andinoyasociados.com','obralashigueras@gmail.com','obrasierraserena@gmail.com',NULL,0,'2018-09-13 21:24:07','2019-02-20 07:53:18'),(2,1,'LUIS ORELLANA','595','3234496733','3234496733','2418 SICHEL ST','luisgorellana@hotmail.com','luisgorellana@hotmail.com','luisgorellana@hotmail.com','DGEGFGE',1,'2018-09-14 17:54:40','2018-09-14 17:56:50'),(5,1,'ENCOMAQUINARIA CIA LTDA','1792713439001','999086617',NULL,'EL NACIONAL N 39 89 Y EL TELEGRAFO','admin@example.com',NULL,NULL,NULL,1,'2018-09-14 18:32:41','2018-10-12 03:50:22'),(8,1,'OBRACIV','1791290410001','2904040',NULL,'AV NACIONES UNIDAS','facturacion@obraciv.com.ec',NULL,NULL,NULL,1,'2018-10-23 18:44:33','2018-10-25 13:55:56'),(9,1,'VINICIO CAMACHO','1711411502001','2926122',NULL,'PILLARO','brexosdesarrollos@gmail.com','karinavallejo150@hotmail.com',NULL,NULL,1,'2018-10-25 13:58:45','2018-10-25 13:58:45');
/*!40000 ALTER TABLE `biz_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_company`
--

DROP TABLE IF EXISTS `biz_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_company` (
  `idcompany` int(11) NOT NULL AUTO_INCREMENT,
  `businessname` varchar(200) NOT NULL COMMENT 'RAZON SOCIAL',
  `tradename` varchar(200) NOT NULL COMMENT 'NOMBRE COMERCIAL',
  `identify` varchar(13) NOT NULL COMMENT 'RUC',
  `phone` varchar(100) DEFAULT NULL,
  `address` text,
  `email` varchar(150) NOT NULL,
  `image` text COMMENT 'LOGO',
  `urlweb` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idcompany`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_company`
--

LOCK TABLES `biz_company` WRITE;
/*!40000 ALTER TABLE `biz_company` DISABLE KEYS */;
INSERT INTO `biz_company` VALUES (2,'Encofrado y Maquinaria Cia ltda','ENCOMAQ','1792477875001','2621858','AV. MARISCAL SUCRE S24-100 Y TABIAZO','ventas@encomaq.com.ec','uploads/image/7698_LogoEncomaq-color2.png','http://www.encomaq.com.ec/','2018-05-07 15:31:18','2019-07-22 01:37:49');
/*!40000 ALTER TABLE `biz_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_contract`
--

DROP TABLE IF EXISTS `biz_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_contract` (
  `idcontract` int(11) NOT NULL AUTO_INCREMENT,
  `idclient` int(11) NOT NULL,
  `idperiod` int(11) NOT NULL,
  `idcategoryitem` int(11) DEFAULT NULL,
  `nocontract` varchar(9) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `area` varchar(50) DEFAULT NULL,
  `period` int(11) NOT NULL,
  `guarantee` decimal(10,2) DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL,
  `observation` text,
  `type` varchar(20) DEFAULT NULL,
  `receipt` text,
  `invoice` text,
  `contractstate` varchar(20) DEFAULT NULL,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idcontract`) USING BTREE,
  KEY `contract_client_idclient_fk` (`idclient`) USING BTREE,
  KEY `biz_contract_nom_categoryitem_idcategoryitem_fk` (`idcategoryitem`),
  CONSTRAINT `biz_contract_nom_categoryitem_idcategoryitem_fk` FOREIGN KEY (`idcategoryitem`) REFERENCES `nom_categoryitem` (`idcategoryitem`),
  CONSTRAINT `contract_client_idclient_fk` FOREIGN KEY (`idclient`) REFERENCES `biz_client` (`idclient`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_contract`
--

LOCK TABLES `biz_contract` WRITE;
/*!40000 ALTER TABLE `biz_contract` DISABLE KEYS */;
INSERT INTO `biz_contract` VALUES (8,8,2,1,'000000001','2019-05-01','2019-10-31','25',5,NULL,36.35,'hgi',NULL,'56','45',NULL,1,'2019-09-03 05:29:48','2019-09-03 05:29:48');
/*!40000 ALTER TABLE `biz_contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_contract_paymentform`
--

DROP TABLE IF EXISTS `biz_contract_paymentform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_contract_paymentform` (
  `idcontract_paymentform` int(11) NOT NULL AUTO_INCREMENT,
  `idcontract` int(11) NOT NULL,
  `idpaymentform` int(11) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idcontract_paymentform`) USING BTREE,
  KEY `idcontract` (`idcontract`) USING BTREE,
  KEY `idpaymentform` (`idpaymentform`) USING BTREE,
  CONSTRAINT `biz_contract_paymentform_ibfk_1` FOREIGN KEY (`idcontract`) REFERENCES `biz_contract` (`idcontract`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `biz_contract_paymentform_ibfk_2` FOREIGN KEY (`idpaymentform`) REFERENCES `biz_paymentform` (`idpaymentform`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_contract_paymentform`
--

LOCK TABLES `biz_contract_paymentform` WRITE;
/*!40000 ALTER TABLE `biz_contract_paymentform` DISABLE KEYS */;
INSERT INTO `biz_contract_paymentform` VALUES (34,8,1,10.00,'2019-09-03 05:29:48','2019-09-03 05:29:48'),(35,8,2,15.00,'2019-09-03 05:29:48','2019-09-03 05:29:48'),(36,8,3,12.36,'2019-09-03 05:29:48','2019-09-03 05:29:48');
/*!40000 ALTER TABLE `biz_contract_paymentform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_contractitem`
--

DROP TABLE IF EXISTS `biz_contractitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_contractitem` (
  `idcontractitem` int(11) NOT NULL AUTO_INCREMENT,
  `idcontract` int(11) NOT NULL,
  `iditem` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `observation` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idcontractitem`) USING BTREE,
  KEY `contractitem_item_iditem_fk` (`iditem`) USING BTREE,
  KEY `contractitem_contract_idcontract_fk` (`idcontract`) USING BTREE,
  CONSTRAINT `contractitem_contract_idcontract_fk` FOREIGN KEY (`idcontract`) REFERENCES `biz_contract` (`idcontract`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contractitem_item_iditem_fk` FOREIGN KEY (`iditem`) REFERENCES `biz_item` (`iditem`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_contractitem`
--

LOCK TABLES `biz_contractitem` WRITE;
/*!40000 ALTER TABLE `biz_contractitem` DISABLE KEYS */;
INSERT INTO `biz_contractitem` VALUES (30,8,1,10,NULL,'2019-09-03 05:29:48','2019-09-03 05:29:48'),(31,8,19,10,NULL,'2019-09-03 05:29:48','2019-09-03 05:29:48'),(32,8,22,5,NULL,'2019-09-03 05:29:48','2019-09-03 05:29:48');
/*!40000 ALTER TABLE `biz_contractitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_item`
--

DROP TABLE IF EXISTS `biz_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_item` (
  `iditem` int(11) NOT NULL AUTO_INCREMENT,
  `idcategoryitem` int(11) NOT NULL,
  `idunittype` int(11) NOT NULL,
  `itemname` varchar(200) NOT NULL,
  `image` text,
  `description` text,
  `state` tinyint(1) NOT NULL,
  `price` decimal(11,2) DEFAULT '0.00',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`iditem`) USING BTREE,
  KEY `biz_item_nom_unittype_idunittype_fk` (`idunittype`) USING BTREE,
  KEY `biz_item_nom_categoryitem_idcategoryitem_fk` (`idcategoryitem`) USING BTREE,
  CONSTRAINT `biz_item_nom_categoryitem_idcategoryitem_fk` FOREIGN KEY (`idcategoryitem`) REFERENCES `nom_categoryitem` (`idcategoryitem`),
  CONSTRAINT `biz_item_nom_unittype_idunittype_fk` FOREIGN KEY (`idunittype`) REFERENCES `nom_unittype` (`idunittype`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_item`
--

LOCK TABLES `biz_item` WRITE;
/*!40000 ALTER TABLE `biz_item` DISABLE KEYS */;
INSERT INTO `biz_item` VALUES (1,1,2,'A1',NULL,'TABLEROS DE MADERA',1,0.00,'2018-05-07 15:33:21','2018-05-15 17:53:16'),(4,1,1,'A2',NULL,'TABLEROS METALICOS 1.20x0.60m',1,1.20,'2018-05-09 15:39:05','2018-08-15 21:20:52'),(5,1,4,'A4',NULL,'PUNTALES METALICOS 3m',1,1.20,'2018-05-09 15:40:40','2018-09-26 15:43:58'),(6,1,1,'A6',NULL,'VIGUETAS METALICAS 3m',1,1.20,'2018-05-09 15:41:24','2018-08-15 21:21:30'),(7,1,1,'A10',NULL,'TABLEROS RECTOS DE BORDILLO 2.40m',1,0.00,'2018-05-09 15:42:32','2018-05-09 15:42:32'),(8,1,1,'A11',NULL,'TABLEROS CURVOS DE BORDILLO 2.40m',1,0.00,'2018-05-09 15:42:55','2018-05-09 15:42:55'),(9,1,1,'A13',NULL,'TABLEROS DE COLUMNA 1.20m',1,0.00,'2018-05-09 15:43:26','2018-05-17 14:35:55'),(10,3,1,'C6',NULL,'MARTILLO 10kg',1,0.00,'2018-05-09 15:44:17','2018-10-23 19:44:54'),(11,1,1,'A3',NULL,'TABLERO METALICO 1.20x0.30m',1,0.00,'2018-05-09 16:06:34','2018-05-09 16:08:29'),(12,1,1,'A7',NULL,'DISTANCIADORES',1,30.00,'2018-05-09 16:06:57','2018-09-14 18:46:31'),(13,1,1,'A5',NULL,'PUNTAL METALICOS 5m',1,0.00,'2018-05-09 16:09:36','2018-05-17 14:37:20'),(14,1,1,'A8',NULL,'CRUCETA METÁLICA CORTA',1,0.00,'2018-05-09 16:10:01','2018-05-09 16:10:01'),(15,1,1,'A9',NULL,'CRUCETA METÁLICA LARGA',1,0.00,'2018-05-09 16:14:43','2018-05-09 16:14:43'),(16,1,1,'A12',NULL,'SEGUROS DE BORDILLO',1,0.00,'2018-05-09 16:15:04','2018-05-09 16:15:04'),(17,1,1,'A15',NULL,'SEGUROS DE COLUMNA',1,0.00,'2018-05-09 16:15:18','2018-05-09 16:15:18'),(18,2,1,'B1',NULL,'MARCOS DE ANDAMIO',1,0.00,'2018-05-09 16:15:34','2018-05-09 16:15:34'),(19,2,1,'B2',NULL,'CRUCETAS DE ANDAMIO',1,0.00,'2018-05-09 16:15:48','2018-05-09 16:15:48'),(20,2,4,'B4',NULL,'CANASTILLAS',1,10.00,'2018-05-09 16:16:05','2019-05-10 04:02:47'),(21,2,1,'B5',NULL,'RUEDAS',1,0.00,'2018-05-09 16:16:16','2018-05-09 16:16:16'),(22,2,1,'B6',NULL,'ESCALERAS',1,0.00,'2018-05-09 16:16:33','2018-05-17 14:28:19'),(23,2,1,'B7',NULL,'PASAMANOS',1,0.00,'2018-05-09 16:16:46','2018-05-09 16:16:46'),(24,2,1,'B3',NULL,'TABLONES',1,0.00,'2018-05-09 16:17:17','2018-05-09 16:17:17'),(25,3,4,'C1',NULL,'CONCRETERA (4 PARIHUELAS)',1,20.00,'2018-05-09 16:17:34','2018-09-26 14:28:25'),(26,3,1,'A14',NULL,'TABLEROS DE COLUMNA 2.40m',1,0.00,'2018-05-09 16:17:46','2018-05-17 14:42:17'),(27,3,1,'C2',NULL,'VIBRADOR CON MANGUERA',1,0.00,'2018-05-09 16:18:05','2018-05-17 14:41:19'),(28,3,1,'C3',NULL,'ELEVADOR CAPACIDAD 150 KG',1,0.00,'2018-05-09 16:18:18','2018-05-17 14:44:11'),(29,3,1,'C4',NULL,'VIBROAPISONADOR (SAPITO)',1,45.00,'2018-05-09 16:18:40','2018-08-15 21:21:41'),(30,3,1,'C5',NULL,'PLANCHA COMPACTADORA',1,0.00,'2018-05-09 16:18:57','2018-05-17 14:31:06'),(31,3,1,'C7',NULL,'MARTILLO 16kg',1,0.00,'2018-05-09 16:19:25','2018-05-18 16:04:33'),(32,3,1,'C8',NULL,'MARTILLO 30Kg',1,0.00,'2018-05-09 16:19:54','2018-05-17 14:29:58');
/*!40000 ALTER TABLE `biz_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_itemprice`
--

DROP TABLE IF EXISTS `biz_itemprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_itemprice` (
  `iditemprice` int(11) NOT NULL AUTO_INCREMENT,
  `iditem` int(11) NOT NULL,
  `price` decimal(11,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`iditemprice`),
  KEY `biz_itemprice_biz_item_iditem_fk` (`iditem`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_itemprice`
--

LOCK TABLES `biz_itemprice` WRITE;
/*!40000 ALTER TABLE `biz_itemprice` DISABLE KEYS */;
INSERT INTO `biz_itemprice` VALUES (17,10,35.00,'2018-10-23 19:44:54','2018-10-23 19:44:54'),(18,10,30.00,'2018-10-23 19:44:54','2018-10-23 19:44:54'),(19,5,0.03,'2018-10-23 19:45:25','2018-10-23 19:45:25'),(20,5,0.50,'2018-10-23 19:45:25','2018-10-23 19:45:25'),(21,5,1.00,'2018-10-23 19:45:25','2018-10-23 19:45:25'),(40,4,1.20,'2018-10-24 15:02:43','2018-10-24 15:02:43'),(41,4,1.50,'2018-10-24 15:02:43','2018-10-24 15:02:43'),(42,4,1.10,'2018-10-24 15:02:43','2018-10-24 15:02:43'),(43,4,1.05,'2018-10-24 15:02:43','2018-10-24 15:02:43'),(44,4,1.00,'2018-10-24 15:02:43','2018-10-24 15:02:43'),(45,4,0.05,'2018-10-24 15:02:43','2018-10-24 15:02:43'),(46,4,0.00,'2018-10-24 15:02:43','2018-10-24 15:02:43'),(47,4,0.00,'2018-10-24 15:02:43','2018-10-24 15:02:43'),(51,9,7.00,'2018-10-25 20:31:18','2018-10-25 20:31:18'),(52,9,5.00,'2018-10-25 20:31:18','2018-10-25 20:31:18'),(53,20,10.00,'2018-11-28 01:43:50','2018-11-28 01:43:50'),(54,20,15.00,'2018-11-28 01:43:50','2019-01-19 01:15:37');
/*!40000 ALTER TABLE `biz_itemprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_liquidation`
--

DROP TABLE IF EXISTS `biz_liquidation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_liquidation` (
  `idliquidation` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `billnumber` varchar(17) CHARACTER SET latin1 DEFAULT NULL,
  `dateinit` date DEFAULT NULL,
  `dateend` date DEFAULT NULL,
  `observation` text CHARACTER SET latin1,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `iva` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idliquidation`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_liquidation`
--

LOCK TABLES `biz_liquidation` WRITE;
/*!40000 ALTER TABLE `biz_liquidation` DISABLE KEYS */;
INSERT INTO `biz_liquidation` VALUES (4,'000000001',NULL,'2019-08-01','2019-08-31',NULL,22825.86,2739.10,25564.96,1,'2019-09-03 08:34:54','2019-09-03 08:34:54');
/*!40000 ALTER TABLE `biz_liquidation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_liquidation_project`
--

DROP TABLE IF EXISTS `biz_liquidation_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_liquidation_project` (
  `idliquidation` int(11) DEFAULT NULL,
  `idproject` int(11) DEFAULT NULL,
  KEY `idliquidation` (`idliquidation`) USING BTREE,
  KEY `idproject` (`idproject`) USING BTREE,
  CONSTRAINT `biz_liquidation_project_ibfk_1` FOREIGN KEY (`idliquidation`) REFERENCES `biz_liquidation` (`idliquidation`),
  CONSTRAINT `biz_liquidation_project_ibfk_2` FOREIGN KEY (`idproject`) REFERENCES `biz_project` (`idproject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_liquidation_project`
--

LOCK TABLES `biz_liquidation_project` WRITE;
/*!40000 ALTER TABLE `biz_liquidation_project` DISABLE KEYS */;
INSERT INTO `biz_liquidation_project` VALUES (4,7);
/*!40000 ALTER TABLE `biz_liquidation_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_liquidationitemsurplus`
--

DROP TABLE IF EXISTS `biz_liquidationitemsurplus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_liquidationitemsurplus` (
  `idliquidationitemsurplus` int(11) NOT NULL AUTO_INCREMENT,
  `idliquidation` int(11) NOT NULL,
  `iditem` int(11) NOT NULL,
  `iditemprice` int(11) NOT NULL,
  `idproject` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantify` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idliquidationitemsurplus`),
  KEY `biz_liquidationitemsurplus_biz_liquidation_idliquidation_fk` (`idliquidation`),
  KEY `biz_liquidationitemsurplus_biz_item_iditem_fk` (`iditem`),
  KEY `biz_liquidationitemsurplus_biz_itemprice_iditemprice_fk` (`iditemprice`),
  KEY `biz_liquidationitemsurplus_biz_project_idproject_fk` (`idproject`),
  CONSTRAINT `biz_liquidationitemsurplus_biz_item_iditem_fk` FOREIGN KEY (`iditem`) REFERENCES `biz_item` (`iditem`),
  CONSTRAINT `biz_liquidationitemsurplus_biz_itemprice_iditemprice_fk` FOREIGN KEY (`iditemprice`) REFERENCES `biz_itemprice` (`iditemprice`),
  CONSTRAINT `biz_liquidationitemsurplus_biz_liquidation_idliquidation_fk` FOREIGN KEY (`idliquidation`) REFERENCES `biz_liquidation` (`idliquidation`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `biz_liquidationitemsurplus_biz_project_idproject_fk` FOREIGN KEY (`idproject`) REFERENCES `biz_project` (`idproject`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_liquidationitemsurplus`
--

LOCK TABLES `biz_liquidationitemsurplus` WRITE;
/*!40000 ALTER TABLE `biz_liquidationitemsurplus` DISABLE KEYS */;
INSERT INTO `biz_liquidationitemsurplus` VALUES (13,4,9,51,7,7.00,8,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(14,4,5,19,7,0.03,14,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(15,4,20,53,7,10.00,4,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(16,4,10,17,7,35.00,5,'2019-09-03 08:34:54','2019-09-03 08:34:54');
/*!40000 ALTER TABLE `biz_liquidationitemsurplus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_liquidationprojectitem`
--

DROP TABLE IF EXISTS `biz_liquidationprojectitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_liquidationprojectitem` (
  `idliquidationprojectitem` int(11) NOT NULL AUTO_INCREMENT,
  `idliquidation` int(11) NOT NULL,
  `idproject` int(11) NOT NULL,
  `iditem` int(11) NOT NULL,
  `quantify` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idliquidationprojectitem`),
  KEY `biz_liquidationprojectitem_biz_liquidation_idliquidation_fk` (`idliquidation`),
  KEY `biz_liquidationprojectitem_biz_project_idproject_fk` (`idproject`),
  KEY `biz_liquidationprojectitem_biz_item_iditem_fk` (`iditem`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_liquidationprojectitem`
--

LOCK TABLES `biz_liquidationprojectitem` WRITE;
/*!40000 ALTER TABLE `biz_liquidationprojectitem` DISABLE KEYS */;
INSERT INTO `biz_liquidationprojectitem` VALUES (1,9,5,20,10,'2019-05-04 10:15:27','2019-05-04 10:15:27'),(2,9,5,10,2,'2019-05-04 10:15:27','2019-05-04 10:15:27'),(3,9,5,5,1,'2019-05-04 10:15:27','2019-05-04 10:15:27'),(4,9,5,20,5,'2019-05-04 10:15:27','2019-05-04 10:15:27'),(5,10,5,20,10,'2019-05-12 14:23:59','2019-05-12 14:23:59'),(6,10,5,10,2,'2019-05-12 14:24:00','2019-05-12 14:24:00'),(7,10,5,5,1,'2019-05-12 14:24:00','2019-05-12 14:24:00'),(8,10,5,20,5,'2019-05-12 14:24:00','2019-05-12 14:24:00'),(9,1,5,20,10,'2019-05-17 06:16:40','2019-05-17 06:16:40'),(10,1,5,10,2,'2019-05-17 06:16:41','2019-05-17 06:16:41'),(11,1,5,5,1,'2019-05-17 06:16:41','2019-05-17 06:16:41'),(12,1,5,20,5,'2019-05-17 06:16:41','2019-05-17 06:16:41'),(13,1,7,9,10,'2019-09-03 05:59:45','2019-09-03 05:59:45'),(14,1,7,5,15,'2019-09-03 05:59:45','2019-09-03 05:59:45'),(15,1,7,20,2,'2019-09-03 05:59:45','2019-09-03 05:59:45'),(16,1,7,10,5,'2019-09-03 05:59:45','2019-09-03 05:59:45'),(17,1,7,9,2,'2019-09-03 05:59:45','2019-09-03 05:59:45'),(18,1,7,5,1,'2019-09-03 05:59:45','2019-09-03 05:59:45'),(19,1,7,4,3,'2019-09-03 05:59:45','2019-09-03 05:59:45'),(20,2,7,9,10,'2019-09-03 08:11:13','2019-09-03 08:11:13'),(21,2,7,5,15,'2019-09-03 08:11:13','2019-09-03 08:11:13'),(22,2,7,20,2,'2019-09-03 08:11:13','2019-09-03 08:11:13'),(23,2,7,10,5,'2019-09-03 08:11:13','2019-09-03 08:11:13'),(24,2,7,9,2,'2019-09-03 08:11:13','2019-09-03 08:11:13'),(25,2,7,5,1,'2019-09-03 08:11:13','2019-09-03 08:11:13'),(26,2,7,4,3,'2019-09-03 08:11:13','2019-09-03 08:11:13'),(27,2,7,20,2,'2019-09-03 08:11:13','2019-09-03 08:11:13'),(28,3,7,9,10,'2019-09-03 08:16:17','2019-09-03 08:16:17'),(29,3,7,5,15,'2019-09-03 08:16:17','2019-09-03 08:16:17'),(30,3,7,20,2,'2019-09-03 08:16:17','2019-09-03 08:16:17'),(31,3,7,10,5,'2019-09-03 08:16:17','2019-09-03 08:16:17'),(32,3,7,9,2,'2019-09-03 08:16:17','2019-09-03 08:16:17'),(33,3,7,5,1,'2019-09-03 08:16:17','2019-09-03 08:16:17'),(34,3,7,4,3,'2019-09-03 08:16:17','2019-09-03 08:16:17'),(35,3,7,20,2,'2019-09-03 08:16:17','2019-09-03 08:16:17'),(36,4,7,9,10,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(37,4,7,5,15,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(38,4,7,20,2,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(39,4,7,10,5,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(40,4,7,9,2,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(41,4,7,5,1,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(42,4,7,4,3,'2019-09-03 08:34:54','2019-09-03 08:34:54'),(43,4,7,20,2,'2019-09-03 08:34:54','2019-09-03 08:34:54');
/*!40000 ALTER TABLE `biz_liquidationprojectitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_paymentform`
--

DROP TABLE IF EXISTS `biz_paymentform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_paymentform` (
  `idpaymentform` int(11) NOT NULL AUTO_INCREMENT,
  `paymentformname` varchar(150) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idpaymentform`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_paymentform`
--

LOCK TABLES `biz_paymentform` WRITE;
/*!40000 ALTER TABLE `biz_paymentform` DISABLE KEYS */;
INSERT INTO `biz_paymentform` VALUES (1,'LETRA DE CAMBIO',1,'2018-08-09 12:01:19','2018-08-09 12:01:26'),(2,'EFECTIVO',1,'2018-08-09 12:01:42','2018-08-09 12:01:44'),(3,'CHEQUE',1,'2018-08-09 12:01:59','2018-08-09 12:02:01');
/*!40000 ALTER TABLE `biz_paymentform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_period`
--

DROP TABLE IF EXISTS `biz_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_period` (
  `idperiod` int(11) NOT NULL AUTO_INCREMENT,
  `periodname` varchar(50) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idperiod`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_period`
--

LOCK TABLES `biz_period` WRITE;
/*!40000 ALTER TABLE `biz_period` DISABLE KEYS */;
INSERT INTO `biz_period` VALUES (1,'DIA',1,'2018-08-09 12:02:51','2018-08-09 12:02:54'),(2,'MES',1,'2018-08-09 12:03:06','2018-08-09 12:03:09'),(3,'AÑO',1,'2018-08-09 12:03:46','2018-08-09 12:03:49');
/*!40000 ALTER TABLE `biz_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_place`
--

DROP TABLE IF EXISTS `biz_place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_place` (
  `idplace` int(11) NOT NULL AUTO_INCREMENT,
  `placename` text NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idplace`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_place`
--

LOCK TABLES `biz_place` WRITE;
/*!40000 ALTER TABLE `biz_place` DISABLE KEYS */;
/*!40000 ALTER TABLE `biz_place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_project`
--

DROP TABLE IF EXISTS `biz_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_project` (
  `idproject` int(11) NOT NULL AUTO_INCREMENT,
  `idclient` int(11) NOT NULL,
  `projectname` varchar(150) NOT NULL,
  `place` text,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idproject`) USING BTREE,
  KEY `project_client_idclient_fk` (`idclient`) USING BTREE,
  CONSTRAINT `project_client_idclient_fk` FOREIGN KEY (`idclient`) REFERENCES `biz_client` (`idclient`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_project`
--

LOCK TABLES `biz_project` WRITE;
/*!40000 ALTER TABLE `biz_project` DISABLE KEYS */;
INSERT INTO `biz_project` VALUES (1,1,'LAS HIGUERAS','LAS HIGUERAS',1,'2018-09-13 21:25:01','2018-09-13 21:25:01'),(2,1,'SIERRA SERENA','GUAMANI',1,'2018-09-13 21:25:17','2018-09-13 21:25:17'),(3,2,'COLISEO DE COTACACHI','COTACACHI',1,'2018-09-14 18:02:27','2018-09-14 18:02:27'),(4,2,'AMBATO','AMBATO',1,'2018-09-14 18:13:59','2018-10-25 17:28:57'),(5,5,'BODEGA NORTE','MARIANITAS',1,'2018-09-14 18:32:57','2018-10-25 17:28:28'),(6,5,'BODEGA SUR','SANTA BARBARA',1,'2018-09-14 18:33:08','2018-10-25 17:28:41'),(7,8,'AMAGUAÑA','AMAGUAÑA',1,'2018-10-23 18:59:02','2018-10-23 18:59:02'),(8,8,'PARQUE NUEVA AURORA','NUEVA AURORA',1,'2018-10-23 18:59:21','2018-10-23 18:59:21'),(9,9,'PILLARO','AMBATO',1,'2018-10-25 17:27:32','2018-10-25 17:27:32'),(10,9,'LA ECUATORIANA','SUR DE QUITO',1,'2018-10-25 17:27:52','2018-10-25 17:27:52');
/*!40000 ALTER TABLE `biz_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_referralguide`
--

DROP TABLE IF EXISTS `biz_referralguide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_referralguide` (
  `idreferralguide` int(11) NOT NULL AUTO_INCREMENT,
  `idcontract` int(11) NOT NULL,
  `idtransferreason` int(11) NOT NULL,
  `idcarrier` int(11) NOT NULL,
  `idproject` int(11) DEFAULT NULL,
  `idwarehouse` int(11) NOT NULL,
  `guidenumber` varchar(17) DEFAULT NULL,
  `datetimereferral` date NOT NULL,
  `sequential` varchar(17) NOT NULL,
  `logisticservicecost` decimal(11,2) DEFAULT '0.00',
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idreferralguide`) USING BTREE,
  KEY `referralguide_contract_idcontract_fk` (`idcontract`) USING BTREE,
  KEY `referralguide_transferreason_idtransferreason_fk` (`idtransferreason`) USING BTREE,
  KEY `referralguide_carrier_idcarrier_fk` (`idcarrier`) USING BTREE,
  KEY `biz_referralguide_biz_project_idproject_fk` (`idproject`) USING BTREE,
  KEY `biz_referralguide_biz_warehouse_idwarehouse_fk` (`idwarehouse`),
  CONSTRAINT `biz_referralguide_biz_project_idproject_fk` FOREIGN KEY (`idproject`) REFERENCES `biz_project` (`idproject`),
  CONSTRAINT `biz_referralguide_biz_warehouse_idwarehouse_fk` FOREIGN KEY (`idwarehouse`) REFERENCES `biz_warehouse` (`idwarehouse`),
  CONSTRAINT `referralguide_carrier_idcarrier_fk` FOREIGN KEY (`idcarrier`) REFERENCES `biz_carrier` (`idcarrier`),
  CONSTRAINT `referralguide_contract_idcontract_fk` FOREIGN KEY (`idcontract`) REFERENCES `biz_contract` (`idcontract`),
  CONSTRAINT `referralguide_transferreason_idtransferreason_fk` FOREIGN KEY (`idtransferreason`) REFERENCES `nom_transferreason` (`idtransferreason`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_referralguide`
--

LOCK TABLES `biz_referralguide` WRITE;
/*!40000 ALTER TABLE `biz_referralguide` DISABLE KEYS */;
INSERT INTO `biz_referralguide` VALUES (18,8,2,3,7,1,'001-001-000000001','2019-06-01','12:12',147.12,1,'2019-09-03 05:34:42','2019-09-03 05:34:42'),(19,8,4,3,7,1,'001-001-000000002','2019-07-01','10:10',20.00,1,'2019-09-03 05:55:12','2019-09-03 05:55:12'),(20,8,2,3,7,1,'001-001-000000003','2019-09-01','13:13',0.00,1,'2019-09-03 06:03:34','2019-09-03 06:03:34');
/*!40000 ALTER TABLE `biz_referralguide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_referralguide_liquidation`
--

DROP TABLE IF EXISTS `biz_referralguide_liquidation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_referralguide_liquidation` (
  `idreferralguide` int(11) DEFAULT NULL,
  `idliquidation` int(11) DEFAULT NULL,
  KEY `biz_referralguide_liquidation_ibfk_1` (`idreferralguide`) USING BTREE,
  KEY `biz_referralguide_liquidation_ibfk_2` (`idliquidation`) USING BTREE,
  CONSTRAINT `biz_referralguide_liquidation_ibfk_1` FOREIGN KEY (`idreferralguide`) REFERENCES `biz_referralguide` (`idreferralguide`) ON DELETE CASCADE,
  CONSTRAINT `biz_referralguide_liquidation_ibfk_2` FOREIGN KEY (`idliquidation`) REFERENCES `biz_liquidation` (`idliquidation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_referralguide_liquidation`
--

LOCK TABLES `biz_referralguide_liquidation` WRITE;
/*!40000 ALTER TABLE `biz_referralguide_liquidation` DISABLE KEYS */;
INSERT INTO `biz_referralguide_liquidation` VALUES (18,4),(19,4),(20,4);
/*!40000 ALTER TABLE `biz_referralguide_liquidation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_referralguide_null`
--

DROP TABLE IF EXISTS `biz_referralguide_null`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_referralguide_null` (
  `idreferralguide_null` int(11) NOT NULL AUTO_INCREMENT,
  `guidenumber` varchar(17) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idreferralguide_null`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_referralguide_null`
--

LOCK TABLES `biz_referralguide_null` WRITE;
/*!40000 ALTER TABLE `biz_referralguide_null` DISABLE KEYS */;
/*!40000 ALTER TABLE `biz_referralguide_null` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_referralguide_place`
--

DROP TABLE IF EXISTS `biz_referralguide_place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_referralguide_place` (
  `idreferralguide` int(11) NOT NULL,
  `idplace_start` int(11) NOT NULL,
  `idplace_end` int(11) NOT NULL,
  KEY `idreferralguide` (`idreferralguide`) USING BTREE,
  KEY `idplace_start` (`idplace_start`) USING BTREE,
  KEY `idplace_end` (`idplace_end`) USING BTREE,
  CONSTRAINT `biz_referralguide_place_ibfk_1` FOREIGN KEY (`idreferralguide`) REFERENCES `biz_referralguide` (`idreferralguide`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `biz_referralguide_place_ibfk_2` FOREIGN KEY (`idplace_start`) REFERENCES `biz_place` (`idplace`),
  CONSTRAINT `biz_referralguide_place_ibfk_3` FOREIGN KEY (`idplace_end`) REFERENCES `biz_place` (`idplace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_referralguide_place`
--

LOCK TABLES `biz_referralguide_place` WRITE;
/*!40000 ALTER TABLE `biz_referralguide_place` DISABLE KEYS */;
/*!40000 ALTER TABLE `biz_referralguide_place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_referralguideitem`
--

DROP TABLE IF EXISTS `biz_referralguideitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_referralguideitem` (
  `idreferralguideitem` int(11) NOT NULL AUTO_INCREMENT,
  `idreferralguide` int(11) NOT NULL,
  `iditem` int(11) NOT NULL,
  `iditemprice` int(11) NOT NULL,
  `quantify` int(11) NOT NULL,
  `price` decimal(11,2) DEFAULT '0.00',
  `observation` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idreferralguideitem`) USING BTREE,
  KEY `referralguideitem_referralguide_idreferralguide_fk` (`idreferralguide`) USING BTREE,
  KEY `referralguideitem_item_iditem_fk` (`iditem`) USING BTREE,
  KEY `biz_referralguideitem_biz_itemprice_iditemprice_fk` (`iditemprice`),
  CONSTRAINT `biz_referralguideitem_biz_itemprice_iditemprice_fk` FOREIGN KEY (`iditemprice`) REFERENCES `biz_itemprice` (`iditemprice`),
  CONSTRAINT `referralguideitem_item_iditem_fk` FOREIGN KEY (`iditem`) REFERENCES `biz_item` (`iditem`),
  CONSTRAINT `referralguideitem_referralguide_idreferralguide_fk` FOREIGN KEY (`idreferralguide`) REFERENCES `biz_referralguide` (`idreferralguide`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_referralguideitem`
--

LOCK TABLES `biz_referralguideitem` WRITE;
/*!40000 ALTER TABLE `biz_referralguideitem` DISABLE KEYS */;
INSERT INTO `biz_referralguideitem` VALUES (27,18,9,51,10,7.00,NULL,'2019-09-03 05:34:42','2019-09-03 05:34:42'),(28,18,5,19,15,0.03,NULL,'2019-09-03 05:34:42','2019-09-03 05:34:42'),(29,18,20,53,2,10.00,NULL,'2019-09-03 05:34:42','2019-09-03 05:34:42'),(30,18,10,17,5,35.00,NULL,'2019-09-03 05:34:42','2019-09-03 05:34:42'),(31,19,9,51,2,7.00,NULL,'2019-09-03 05:55:12','2019-09-03 05:55:12'),(32,19,5,19,1,0.03,NULL,'2019-09-03 05:55:12','2019-09-03 05:55:12'),(33,19,4,40,3,1.20,NULL,'2019-09-03 05:55:12','2019-09-03 05:55:12'),(34,20,20,53,2,10.00,NULL,'2019-09-03 06:03:34','2019-09-03 06:03:34');
/*!40000 ALTER TABLE `biz_referralguideitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz_warehouse`
--

DROP TABLE IF EXISTS `biz_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz_warehouse` (
  `idwarehouse` int(11) NOT NULL AUTO_INCREMENT,
  `idcompany` int(11) NOT NULL,
  `warehousename` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idwarehouse`) USING BTREE,
  KEY `biz_warehouse_biz_company_idcompany_fk` (`idcompany`) USING BTREE,
  CONSTRAINT `biz_warehouse_biz_company_idcompany_fk` FOREIGN KEY (`idcompany`) REFERENCES `biz_company` (`idcompany`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_warehouse`
--

LOCK TABLES `biz_warehouse` WRITE;
/*!40000 ALTER TABLE `biz_warehouse` DISABLE KEYS */;
INSERT INTO `biz_warehouse` VALUES (1,2,'Bodega sur','Sur de Quito','022621858','contabilidad@encomaq.com.ec',1,'2018-05-07 15:32:49','2018-10-24 14:29:39'),(2,2,'Bodega norte','AV. MARISCAL SUCRE S24-100','999086617','luisgorellana@hotmail.com',1,'2018-05-08 01:56:13','2018-10-24 14:29:58'),(4,2,'Bodega Ambato','direccion Bodega','098197127','contabilidad@imnegocios.com',1,'2018-06-22 19:19:12','2019-10-07 23:01:29');
/*!40000 ALTER TABLE `biz_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_06_01_000001_create_oauth_auth_codes_table',1),(4,'2016_06_01_000002_create_oauth_access_tokens_table',1),(5,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(6,'2016_06_01_000004_create_oauth_clients_table',1),(7,'2016_06_01_000005_create_oauth_personal_access_clients_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nom_categoryitem`
--

DROP TABLE IF EXISTS `nom_categoryitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nom_categoryitem` (
  `idcategoryitem` int(11) NOT NULL AUTO_INCREMENT,
  `categoryitemname` varchar(100) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idcategoryitem`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nom_categoryitem`
--

LOCK TABLES `nom_categoryitem` WRITE;
/*!40000 ALTER TABLE `nom_categoryitem` DISABLE KEYS */;
INSERT INTO `nom_categoryitem` VALUES (1,'ENCOFRADO',1,'2018-04-22 12:51:12','2019-10-07 18:32:18'),(2,'ANDAMIO Y CANASTILLA',1,'2018-04-22 12:52:01','2019-10-07 18:33:52'),(3,'MAQUINARIA DE CONSTRUCCION',1,'2018-04-22 12:52:30','2019-10-07 18:32:40');
/*!40000 ALTER TABLE `nom_categoryitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nom_identifytype`
--

DROP TABLE IF EXISTS `nom_identifytype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nom_identifytype` (
  `ididentifytype` int(11) NOT NULL AUTO_INCREMENT,
  `identifytypename` varchar(100) NOT NULL,
  `identifylength` varchar(50) DEFAULT NULL,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`ididentifytype`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nom_identifytype`
--

LOCK TABLES `nom_identifytype` WRITE;
/*!40000 ALTER TABLE `nom_identifytype` DISABLE KEYS */;
INSERT INTO `nom_identifytype` VALUES (1,'RUC','13',1,'2018-04-22 12:43:43','2018-09-09 13:59:46'),(2,'CÉDULA','10',1,'2018-04-22 12:44:14','2018-09-09 13:59:57'),(3,'PASAPORTE',NULL,1,'2018-04-22 12:44:40','2018-04-22 12:44:45'),(4,'VENTA A CONSUMIDOR FINAL',NULL,1,'2018-04-22 12:45:27','2018-04-22 12:45:32'),(5,'IDENTIFICACIÓN DEL EXTERIOR',NULL,1,'2018-04-22 12:46:05','2018-05-08 01:58:42');
/*!40000 ALTER TABLE `nom_identifytype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nom_transferreason`
--

DROP TABLE IF EXISTS `nom_transferreason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nom_transferreason` (
  `idtransferreason` int(11) NOT NULL AUTO_INCREMENT,
  `idtypetransferreason` int(11) NOT NULL DEFAULT '1',
  `transferreasonname` varchar(150) NOT NULL,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idtransferreason`) USING BTREE,
  KEY `nom_typetransferreason_idtypetransferreason_fk` (`idtypetransferreason`) USING BTREE,
  CONSTRAINT `nom_typetransferreason_idtypetransferreason_fk` FOREIGN KEY (`idtypetransferreason`) REFERENCES `nom_typetransferreason` (`idtypetransferreason`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nom_transferreason`
--

LOCK TABLES `nom_transferreason` WRITE;
/*!40000 ALTER TABLE `nom_transferreason` DISABLE KEYS */;
INSERT INTO `nom_transferreason` VALUES (1,3,'VENTA',1,'2018-05-07 15:34:04','2018-10-01 21:39:23'),(2,1,'ENTREGA EN OBRA',1,'2018-05-08 02:00:07','2018-05-16 20:02:35'),(3,2,'RECEPCION EN BODEGA ENCOMAQ',1,'2018-05-08 02:00:18','2018-05-16 20:03:01'),(4,2,'DEVOLUCION',1,'2018-05-16 20:03:13','2018-05-16 20:03:13'),(5,1,'TRASLADO ENTRE ESTABLECIMIENTOS',1,'2018-05-16 20:03:38','2018-10-01 21:39:09'),(6,1,'OTROS',1,'2018-05-16 20:03:46','2018-05-16 20:03:46'),(9,1,'ALQUILER PRUEBA',1,'2018-06-25 16:32:33','2018-06-25 16:32:33');
/*!40000 ALTER TABLE `nom_transferreason` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nom_typetransferreason`
--

DROP TABLE IF EXISTS `nom_typetransferreason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nom_typetransferreason` (
  `idtypetransferreason` int(11) NOT NULL AUTO_INCREMENT,
  `nametypetransferreason` varchar(100) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idtypetransferreason`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nom_typetransferreason`
--

LOCK TABLES `nom_typetransferreason` WRITE;
/*!40000 ALTER TABLE `nom_typetransferreason` DISABLE KEYS */;
INSERT INTO `nom_typetransferreason` VALUES (1,'ENTREGA',1,'2018-08-31 04:31:37','2018-08-31 04:31:46'),(2,'RETIRO',1,'2018-08-31 04:32:01','2018-08-31 04:32:04'),(3,'VENTA',1,'2018-08-31 04:32:19','2018-08-31 04:32:28');
/*!40000 ALTER TABLE `nom_typetransferreason` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nom_unittype`
--

DROP TABLE IF EXISTS `nom_unittype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nom_unittype` (
  `idunittype` int(11) NOT NULL AUTO_INCREMENT,
  `unittypename` varchar(100) NOT NULL,
  `state` int(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idunittype`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nom_unittype`
--

LOCK TABLES `nom_unittype` WRITE;
/*!40000 ALTER TABLE `nom_unittype` DISABLE KEYS */;
INSERT INTO `nom_unittype` VALUES (1,'UNIDAD',1,'2018-04-22 12:53:28','2018-05-07 06:15:22'),(2,'UNIDAD 3',1,'2018-05-07 15:34:25','2019-10-07 18:55:14'),(4,'u / 30 días',1,'2018-09-26 14:27:57','2018-09-26 14:27:57');
/*!40000 ALTER TABLE `nom_unittype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('01cae129be2eeede194c7d64a9880af3dc8d99cf641a55d03a253d09051fe79ab83cf1bde3659c41',1,3,'MyAppFacturaDigital','[]',0,'2019-10-05 03:24:59','2019-10-05 03:24:59','2019-10-05 22:24:59'),('5ad29d1a301a7490dfff9f32335ea511c5d2b95aa0152657c2b84136b63faffa17783dc9971e0ef3',1,3,'MyAppFacturaDigital','[]',0,'2019-10-05 03:21:19','2019-10-05 03:21:19','2019-10-05 22:21:17'),('7fa5d544afa5584d7b52ef96e155d0bc7af4f1c655f95877563b8ee553c6a995be3147abda6a7f6b',1,3,'MyAppFacturaDigital','[]',0,'2019-10-07 22:59:16','2019-10-07 22:59:16','2019-10-08 17:59:15');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Laravel Personal Access Client','ckrGo5Bv5xTeaTY15KUUtlahhSbmIohTMONKUnvN','http://localhost',1,0,0,'2019-10-04 21:44:36','2019-10-04 21:44:36'),(2,NULL,'Laravel Password Grant Client','Ex2lR5hMUNS4QDd2VI5yAx6xaySRdTfKpeJDRoCD','http://localhost',0,1,0,'2019-10-04 21:44:36','2019-10-04 21:44:36'),(3,NULL,'Laravel Personal Access Client','hJ2gVsfLjPIttfAMUeIvaxtu3mFPCyEH8INEiD96','http://localhost',1,0,0,'2019-10-04 21:44:52','2019-10-04 21:44:52'),(4,NULL,'Laravel Password Grant Client','SMCG1QUSbDuleSQkJ1qu9kJMLNa41pQ6t7UsZTbz','http://localhost',0,1,0,'2019-10-04 21:44:52','2019-10-04 21:44:52');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2019-10-04 21:44:36','2019-10-04 21:44:36'),(2,3,'2019-10-04 21:44:52','2019-10-04 21:44:52');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_configemail`
--

DROP TABLE IF EXISTS `sys_configemail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_configemail` (
  `idconfigemail` int(11) NOT NULL AUTO_INCREMENT,
  `driver` varchar(10) CHARACTER SET latin1 NOT NULL,
  `server` varchar(200) CHARACTER SET latin1 NOT NULL,
  `port` int(11) NOT NULL,
  `encryptation` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `useremail` varchar(100) CHARACTER SET latin1 NOT NULL,
  `passwordemail` text CHARACTER SET latin1 NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idconfigemail`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_configemail`
--

LOCK TABLES `sys_configemail` WRITE;
/*!40000 ALTER TABLE `sys_configemail` DISABLE KEYS */;
INSERT INTO `sys_configemail` VALUES (1,'SMTP','smtp.gmail.com',587,'tls','info@imnegocios.com','Vabell2046_1256','2018-05-14 20:32:57','2018-06-22 19:02:08');
/*!40000 ALTER TABLE `sys_configemail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_permission`
--

DROP TABLE IF EXISTS `sys_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_permission` (
  `idpermission` int(11) NOT NULL AUTO_INCREMENT,
  `permissionname` varchar(150) NOT NULL,
  `node` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idpermission`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_permission`
--

LOCK TABLES `sys_permission` WRITE;
/*!40000 ALTER TABLE `sys_permission` DISABLE KEYS */;
INSERT INTO `sys_permission` VALUES (1,'Roles','','2018-05-01 01:20:45','2018-05-01 01:21:02'),(2,'Usuarios','','2018-05-01 01:21:34','2018-05-01 01:21:37'),(3,'Email','','2018-05-01 01:22:04','2018-05-01 01:22:07'),(4,'Tipo Identificación','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Categoría Item','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'Motivo Traslado (Guía Remisión)','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'Unidad','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'Transportista','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'Cliente','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'Producto','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'Bodega','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'Información de Empresa','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'Proyecto','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'Guía Remisión','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,'Contrato','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,'Liquidación','','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `sys_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `idrole` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`idrole`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'ADMINISTRADOR','2018-04-30 17:14:56','2018-04-30 17:14:56'),(3,'CONTADOR','2018-05-08 02:50:11','2018-07-27 16:20:36'),(4,'GERENTE','2018-05-08 02:50:20','2018-05-08 02:50:20'),(5,'SECRETARIA','2018-05-09 20:54:14','2018-09-09 14:01:36'),(8,'REPRESENTANTE LEGAL','2018-06-22 18:15:54','2018-09-09 14:01:24');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_permission`
--

DROP TABLE IF EXISTS `sys_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_permission` (
  `idrole` int(11) NOT NULL,
  `idpermission` int(11) NOT NULL,
  KEY `sys_role_permission_sys_role_idrole_fk` (`idrole`) USING BTREE,
  KEY `sys_role_permission_sys_permission_idpermission_fk` (`idpermission`) USING BTREE,
  CONSTRAINT `sys_role_permission_sys_permission_idpermission_fk` FOREIGN KEY (`idpermission`) REFERENCES `sys_permission` (`idpermission`),
  CONSTRAINT `sys_role_permission_sys_role_idrole_fk` FOREIGN KEY (`idrole`) REFERENCES `sys_role` (`idrole`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_permission`
--

LOCK TABLES `sys_role_permission` WRITE;
/*!40000 ALTER TABLE `sys_role_permission` DISABLE KEYS */;
INSERT INTO `sys_role_permission` VALUES (4,15);
/*!40000 ALTER TABLE `sys_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `idrole` int(11) NOT NULL,
  `personname` varchar(100) NOT NULL,
  `lastnameperson` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` text NOT NULL,
  `token` text,
  `state` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`iduser`) USING BTREE,
  KEY `user_role_idrole_fk` (`idrole`) USING BTREE,
  CONSTRAINT `user_role_idrole_fk` FOREIGN KEY (`idrole`) REFERENCES `sys_role` (`idrole`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,1,'Administrador','General','admin@example.com','$2y$10$Zg4/ViB7sD1KrUqmlUKsI.kZDbBmNBLgnWosplc3t6jZjPHVyYCum',NULL,1,'2018-04-30 23:04:56','2018-06-22 18:22:26'),(2,3,'Jose','Peréz','jose.perez@prueba.com','$2y$10$yLpw/8IgNOs08lHaIb9c3u3TyX76tF7.kHjWSv941ohStLZSfhpKm',NULL,1,'2018-05-08 03:10:26','2018-05-08 03:10:26'),(3,4,'Pepe','Pruebas','pepe@pruebas.com','$2y$10$w0htHcaOpFrPJKZ4jURstebXROCLQAuFJiyeMfozcfSPjFemf06Le',NULL,0,'2018-05-08 03:11:06','2018-05-08 03:11:14'),(4,3,'Jose','Lopez','er@.com','$2y$10$k5RRPcbmNyfOVKkAAGQnp.K7Sjlcn1f4GCvvW6Nw.QKNAsKI7MYrq',NULL,0,'2018-05-09 21:07:00','2018-05-09 21:07:10'),(5,1,'Luis Antonio','Vinueza','gerencia@imnegocios.com','$2y$10$KmO75Ep62kUpl.GNIMBf9.upQ7PDZ6bEc5KLFdkj9Tr8tcMNSEgpa','118f9a891131dfaa17e77e5d9c4337f7',1,'2018-05-15 18:30:25','2018-05-21 19:14:53'),(6,1,'Luis','Orellana','luisgorellana@gmail.com','$2y$10$DIPs70xS5UxBPP3a1jFOqOj7eaRdEGll5rCPMHEsOPBy8iBVaw4D6',NULL,1,'2018-05-15 21:02:53','2018-05-15 21:02:53'),(7,1,'Manuel','Mideros','info@imnegocios.com','$2y$10$A7.NIWMXLNNOIS6Z8kSZ5eorxJMMACVK4Q/CFmDOYr2tijrnrQg4W',NULL,1,'2018-06-22 16:51:46','2018-06-22 16:51:46'),(11,4,'test','test','darwinpeacehope@gmail.com','$2y$10$6kLISFeHJH6RDJhV5QotruNboWWs4GliPWgcUjmfK.59CKOhk7Qqa',NULL,1,'2018-09-06 04:12:59','2018-06-25 04:35:57'),(12,3,'CONTABILIDAD','PRUEBA','contabilidad@imnegocios.com','$2y$10$NQ/j820QcORWTxUd8VE/M.xydsBnILxsDsJIOrF0w.5GOhsOrrGoO',NULL,1,'2018-06-25 16:25:16','2018-06-25 16:25:16');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-09  7:58:31
