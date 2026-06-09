-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: dbpenjualan
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

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
-- Table structure for table `tblbarang`
--

DROP TABLE IF EXISTS `tblbarang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblbarang` (
  `idbarang` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(250) NOT NULL,
  `jml` int(100) NOT NULL,
  `harga_beli` decimal(12,2) NOT NULL,
  `harga_jual` decimal(12,2) NOT NULL,
  PRIMARY KEY (`idbarang`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbljual`
--

DROP TABLE IF EXISTS `tbljual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbljual` (
  `idstruk` int(11) NOT NULL AUTO_INCREMENT,
  `tgl_jual` date NOT NULL,
  `id_petugas` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  PRIMARY KEY (`idstruk`) USING BTREE,
  KEY `FK_tbljual_tblpetugas` (`id_petugas`),
  KEY `FK_tbljual_tblpelanggan` (`id_pelanggan`),
  CONSTRAINT `FK_tbljual_tblpelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `tblpelanggan` (`idpelanggan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tbljual_tblpetugas` FOREIGN KEY (`id_petugas`) REFERENCES `tblpetugas` (`idpetugas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbljual_detil`
--

DROP TABLE IF EXISTS `tbljual_detil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbljual_detil` (
  `idstrukturdetail` int(11) NOT NULL AUTO_INCREMENT,
  `id_jual` int(11) DEFAULT NULL,
  `idbarang` int(11) NOT NULL,
  `jml` int(1) NOT NULL,
  `harga_jual` decimal(12,2) NOT NULL,
  PRIMARY KEY (`idstrukturdetail`) USING BTREE,
  KEY `FK_tblorder_detail_tbljual` (`id_jual`) USING BTREE,
  KEY `FK_tblorder_detail_tblbarang` (`idbarang`) USING BTREE,
  CONSTRAINT `tbljual_detil_ibfk_1` FOREIGN KEY (`idbarang`) REFERENCES `tblbarang` (`idbarang`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tbljual_detil_ibfk_2` FOREIGN KEY (`id_jual`) REFERENCES `tbljual` (`idstruk`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tbljual_detail_before_insert` BEFORE INSERT ON `tbljual_detil` FOR EACH ROW BEGIN
DECLARE abc int;  
SELECT b.harga_jual INTO abc FROM tblbarang b WHERE b.idbarang= new.idbarang;
SET NEW.harga_jual=abc;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tblorder_detail`
--

DROP TABLE IF EXISTS `tblorder_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblorder_detail` (
  `idstrukturdetail` int(11) NOT NULL AUTO_INCREMENT,
  `id_jual` int(11) DEFAULT NULL,
  `idbarang` int(11) NOT NULL,
  `jml` int(100) NOT NULL,
  `harga_jual` decimal(12,2) NOT NULL,
  PRIMARY KEY (`idstrukturdetail`),
  KEY `FK_tblorder_detail_tbljual` (`id_jual`),
  KEY `FK_tblorder_detail_tblbarang` (`idbarang`),
  CONSTRAINT `FK_tblorder_detail_tblbarang` FOREIGN KEY (`idbarang`) REFERENCES `tblbarang` (`idbarang`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tblorder_detail_tbljual` FOREIGN KEY (`id_jual`) REFERENCES `tbljual` (`idstruk`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblpelanggan`
--

DROP TABLE IF EXISTS `tblpelanggan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpelanggan` (
  `idpelanggan` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `alamat` varchar(250) NOT NULL,
  PRIMARY KEY (`idpelanggan`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblpetugas`
--

DROP TABLE IF EXISTS `tblpetugas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpetugas` (
  `idpetugas` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(250) NOT NULL,
  `alamat` varchar(250) NOT NULL,
  PRIMARY KEY (`idpetugas`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblstruk`
--

DROP TABLE IF EXISTS `tblstruk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblstruk` (
  `idstruk` int(11) NOT NULL AUTO_INCREMENT,
  `tgl_jual` date NOT NULL,
  `id_petugas` int(11) NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  PRIMARY KEY (`idstruk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-09 11:58:50
