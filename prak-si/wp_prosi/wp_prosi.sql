-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.1.0-MariaDB-log - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table wp_prosi.contoh
CREATE TABLE IF NOT EXISTS `contoh` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table wp_prosi.contoh: ~0 rows (approximately)

-- Dumping structure for table wp_prosi.konversi_nilai
CREATE TABLE IF NOT EXISTS `konversi_nilai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alternatif` int(11) NOT NULL,
  `subkriteria` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_konversi_nilai_mahasiswa` (`alternatif`),
  KEY `FK_konversi_nilai_subkriteria` (`subkriteria`),
  CONSTRAINT `FK_konversi_nilai_mahasiswa` FOREIGN KEY (`alternatif`) REFERENCES `mahasiswa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_konversi_nilai_subkriteria` FOREIGN KEY (`subkriteria`) REFERENCES `subkriteria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table wp_prosi.konversi_nilai: ~60 rows (approximately)
INSERT INTO `konversi_nilai` (`id`, `alternatif`, `subkriteria`) VALUES
	(165, 1, 5),
	(166, 1, 10),
	(167, 1, 11),
	(168, 1, 32),
	(169, 1, 16),
	(170, 1, 23),
	(171, 1, 22),
	(172, 1, 34),
	(173, 1, 37),
	(174, 1, 39),
	(180, 2, 5),
	(181, 2, 10),
	(182, 2, 14),
	(183, 2, 16),
	(184, 2, 19),
	(185, 2, 24),
	(186, 2, 32),
	(187, 2, 38),
	(188, 2, 39),
	(189, 3, 5),
	(190, 3, 10),
	(191, 3, 12),
	(192, 3, 16),
	(193, 3, 21),
	(194, 3, 24),
	(195, 3, 28),
	(196, 3, 33),
	(197, 3, 37),
	(198, 3, 39),
	(199, 4, 4),
	(200, 4, 10),
	(201, 4, 14),
	(202, 4, 16),
	(203, 4, 21),
	(204, 4, 24),
	(205, 4, 32),
	(206, 4, 37),
	(207, 4, 39),
	(208, 6, 5),
	(209, 6, 10),
	(210, 6, 12),
	(211, 6, 16),
	(212, 6, 18),
	(213, 6, 23),
	(214, 6, 32),
	(215, 6, 34),
	(216, 6, 38),
	(217, 6, 39),
	(222, 2, 35),
	(223, 4, 35);

-- Dumping structure for table wp_prosi.kriteria
CREATE TABLE IF NOT EXISTS `kriteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT NULL,
  `kriteria` varchar(50) DEFAULT NULL,
  `bobot` int(11) NOT NULL,
  `keterangan` enum('Benefit','Cost') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_kriteria_tingkat_bobot_kriteria` (`bobot`),
  CONSTRAINT `FK_kriteria_tingkat_bobot_kriteria` FOREIGN KEY (`bobot`) REFERENCES `tingkat_bobot_kriteria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table wp_prosi.kriteria: ~10 rows (approximately)
INSERT INTO `kriteria` (`id`, `timestamp`, `kriteria`, `bobot`, `keterangan`) VALUES
	(1, '2023-11-25 07:51:41', 'Penghasilan Ayah', 5, 'Cost'),
	(2, '2023-11-25 08:51:47', 'Penghasilan Ibu', 5, 'Cost'),
	(3, '2023-11-25 09:51:48', 'Jumlah Tanggungan', 4, 'Benefit'),
	(4, '2023-11-25 10:51:49', 'Kepemilikan Rumah', 3, 'Benefit'),
	(5, '2023-11-25 11:51:50', 'Luas Tanah', 3, 'Cost'),
	(6, '2023-11-25 12:51:51', 'Luas Bangunan', 3, 'Cost'),
	(7, '2023-11-25 13:52:25', 'Jarak Pusat Kota', 3, 'Benefit'),
	(8, '2023-11-25 14:52:28', 'Mandi Cuci Kakus', 2, 'Benefit'),
	(9, '2023-11-25 15:52:31', 'Sumber Air', 1, 'Benefit'),
	(10, '2023-11-25 16:52:34', 'Sumber Listrik', 1, 'Benefit');

-- Dumping structure for table wp_prosi.mahasiswa
CREATE TABLE IF NOT EXISTS `mahasiswa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_alternatif` varchar(50) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table wp_prosi.mahasiswa: ~5 rows (approximately)
INSERT INTO `mahasiswa` (`id`, `kode_alternatif`, `nama`) VALUES
	(1, 'A1', 'Willi'),
	(2, 'A2', 'Candra'),
	(3, 'A3', 'Wahyu'),
	(4, 'A4', 'Imam'),
	(6, 'A5', 'Santi');

-- Dumping structure for table wp_prosi.subkriteria
CREATE TABLE IF NOT EXISTS `subkriteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kriteria` int(11) NOT NULL,
  `subkriteria` varchar(50) DEFAULT NULL,
  `skor` int(11) NOT NULL,
  `keterangan` enum('Cost','Benefit') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_subkriteria_kriteria` (`kriteria`),
  KEY `FK_subkriteria_tingkat_bobot_kriteria` (`skor`),
  CONSTRAINT `FK_subkriteria_kriteria` FOREIGN KEY (`kriteria`) REFERENCES `kriteria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_subkriteria_tingkat_bobot_kriteria` FOREIGN KEY (`skor`) REFERENCES `tingkat_bobot_kriteria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table wp_prosi.subkriteria: ~41 rows (approximately)
INSERT INTO `subkriteria` (`id`, `kriteria`, `subkriteria`, `skor`, `keterangan`) VALUES
	(1, 1, '>Rp 2.000.000', 1, 'Cost'),
	(2, 1, '>Rp 1.500.000 - 2.000.000', 2, 'Cost'),
	(3, 1, '>Rp 1.000.000 - 1.500.000', 3, 'Cost'),
	(4, 1, '>Rp 500.000 - 1.000.000', 4, 'Cost'),
	(5, 1, '<= Rp 500.000', 5, 'Cost'),
	(6, 2, '>Rp 2.000.000', 1, 'Cost'),
	(7, 2, '>Rp 1.500.000 - 2.000.000', 2, 'Cost'),
	(8, 2, '>Rp 1.000.000-  1.500.000', 3, 'Cost'),
	(9, 2, '>Rp 500.000 - 1.000.000', 4, 'Cost'),
	(10, 2, '<= Rp 500.000', 5, 'Cost'),
	(11, 3, '1-2 orang', 1, 'Benefit'),
	(12, 3, '3 orang', 2, 'Benefit'),
	(13, 3, '4 orang', 3, 'Benefit'),
	(14, 3, '5 orang', 4, 'Benefit'),
	(15, 3, 'Lebih dari 5 orang', 5, 'Benefit'),
	(16, 4, 'Sendiri', 1, 'Benefit'),
	(17, 4, 'Menumpang', 5, 'Benefit'),
	(18, 5, '> 200 m2', 1, 'Cost'),
	(19, 5, '100-200 m2', 2, 'Cost'),
	(20, 5, '> 50-99 m2', 3, 'Cost'),
	(21, 5, '> 25-50 m2', 4, 'Cost'),
	(22, 5, '< 25 m2', 5, 'Cost'),
	(23, 6, '> 200 m2', 1, 'Cost'),
	(24, 6, '100 - 200 m2', 2, 'Cost'),
	(25, 6, '> 50 - 90 m2', 3, 'Cost'),
	(26, 6, '> 25 - 50 m2', 4, 'Cost'),
	(27, 6, '< 25 m2', 5, 'Cost'),
	(28, 7, '<= 5 km', 1, 'Benefit'),
	(29, 7, '> 5 - 10 km', 2, 'Benefit'),
	(30, 7, '>10 -15 km', 3, 'Benefit'),
	(31, 7, '> 15 -20 km', 4, 'Benefit'),
	(32, 7, '> 20 km', 5, 'Benefit'),
	(33, 8, 'Ada di dalam rumah', 1, 'Benefit'),
	(34, 8, 'Ada di luar', 3, 'Benefit'),
	(35, 8, 'Umum/Berbagi Pakai', 5, 'Benefit'),
	(36, 9, 'PDAM', 1, 'Benefit'),
	(37, 9, 'Sumur', 3, 'Benefit'),
	(38, 9, 'Sungai/Mata air', 5, 'Benefit'),
	(39, 10, 'PLN', 1, 'Benefit'),
	(40, 10, 'Genset/Mandiri', 3, 'Benefit'),
	(41, 10, 'Tidak Ada', 5, 'Benefit');

-- Dumping structure for table wp_prosi.tingkat_bobot_kriteria
CREATE TABLE IF NOT EXISTS `tingkat_bobot_kriteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kriteria_penilaian` varchar(50) DEFAULT NULL,
  `nilai` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table wp_prosi.tingkat_bobot_kriteria: ~5 rows (approximately)
INSERT INTO `tingkat_bobot_kriteria` (`id`, `kriteria_penilaian`, `nilai`) VALUES
	(1, 'Sangat Rendah', '1'),
	(2, 'Rendah', '2'),
	(3, 'Sedang', '3'),
	(4, 'Tinggi', '4'),
	(5, 'Sangat Tinggi', '5');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
