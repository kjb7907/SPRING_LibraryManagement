-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        5.5.32 - MySQL Community Server (GPL)
-- 서버 OS:                        Win32
-- HeidiSQL 버전:                  8.0.0.4396
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- library 의 데이터베이스 구조 덤핑
DROP DATABASE IF EXISTS `library`;
CREATE DATABASE IF NOT EXISTS `library` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `library`;


-- 테이블 library의 구조를 덤프합니다. admin
DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `ADMINID` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'ID',
  `ADMINPW` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'PW',
  PRIMARY KEY (`ADMINID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='관리자';

-- Dumping data for table library.admin: ~0 rows (대략적)
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;


-- 테이블 library의 구조를 덤프합니다. books
DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `BOOKCODE` int(11) NOT NULL AUTO_INCREMENT COMMENT '도서관리코드',
  `LIBCODE` int(11) NOT NULL COMMENT '도서관코드',
  `BOOKNAME` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '도서명',
  `WRITER` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '저자이름',
  `PUBLISHER` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '출판사',
  `CATEGORY` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '분류명',
  `GENRE` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '장르',
  `BOOKLOCATION` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '도서위치',
  `CURRENTSTATUS` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '현재대여여부',
  `FIRSTRENTALDAY` date DEFAULT NULL COMMENT '최초대여일',
  `RENTALCOUNT` int(11) DEFAULT NULL COMMENT '대여횟수',
  `RENTALDAYS` int(11) DEFAULT NULL COMMENT '대여일수',
  PRIMARY KEY (`BOOKCODE`),
  KEY `FK_lib_TO_books` (`LIBCODE`),
  CONSTRAINT `FK_lib_TO_books` FOREIGN KEY (`LIBCODE`) REFERENCES `lib` (`LIBCODE`)
) ENGINE=InnoDB AUTO_INCREMENT=800002 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='도서관리';

-- Dumping data for table library.books: ~2 rows (대략적)
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` (`BOOKCODE`, `LIBCODE`, `BOOKNAME`, `WRITER`, `PUBLISHER`, `CATEGORY`, `GENRE`, `BOOKLOCATION`, `CURRENTSTATUS`, `FIRSTRENTALDAY`, `RENTALCOUNT`, `RENTALDAYS`) VALUES
	(800000, 100, '너의이름은', '신카이 마코토', '대원씨아이', '소설', '로맨스소설', '일본소설/A/3열', '대여불가능', NULL, 1, 1),
	(800001, 101, '자바스크립트 닌자 비급', '존레식', '인사이트', '컴퓨터/IT', '웹프로그래밍', '컴퓨터/A/3', '대여가능', NULL, NULL, NULL);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;


-- 테이블 library의 구조를 덤프합니다. cost
DROP TABLE IF EXISTS `cost`;
CREATE TABLE IF NOT EXISTS `cost` (
  `MEMBERRENTALCOST` int(11) NOT NULL COMMENT '회원대여료',
  `NONMEMBERRENTALCOST` int(11) NOT NULL COMMENT '비회원대여료'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='단가';

-- Dumping data for table library.cost: ~1 rows (대략적)
/*!40000 ALTER TABLE `cost` DISABLE KEYS */;
INSERT INTO `cost` (`MEMBERRENTALCOST`, `NONMEMBERRENTALCOST`) VALUES
	(100, 200);
/*!40000 ALTER TABLE `cost` ENABLE KEYS */;


-- 테이블 library의 구조를 덤프합니다. discardbooks
DROP TABLE IF EXISTS `discardbooks`;
CREATE TABLE IF NOT EXISTS `discardbooks` (
  `BOOKCODE` int(11) NOT NULL AUTO_INCREMENT COMMENT '도서관리코드',
  `DISCARDREASON` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '폐기사유',
  PRIMARY KEY (`BOOKCODE`),
  CONSTRAINT `FK_books_TO_discardbooks` FOREIGN KEY (`BOOKCODE`) REFERENCES `books` (`BOOKCODE`)
) ENGINE=InnoDB AUTO_INCREMENT=800001 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='폐기도서';

-- Dumping data for table library.discardbooks: ~1 rows (대략적)
/*!40000 ALTER TABLE `discardbooks` DISABLE KEYS */;
INSERT INTO `discardbooks` (`BOOKCODE`, `DISCARDREASON`) VALUES
	(800000, '고객파손');
/*!40000 ALTER TABLE `discardbooks` ENABLE KEYS */;


-- 테이블 library의 구조를 덤프합니다. lib
DROP TABLE IF EXISTS `lib`;
CREATE TABLE IF NOT EXISTS `lib` (
  `LIBCODE` int(11) NOT NULL AUTO_INCREMENT COMMENT '도서관코드',
  `LIBNAME` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '도서관명',
  `LIBLOCATION` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '도서관위치',
  PRIMARY KEY (`LIBCODE`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='도서관';

-- Dumping data for table library.lib: ~2 rows (대략적)
/*!40000 ALTER TABLE `lib` DISABLE KEYS */;
INSERT INTO `lib` (`LIBCODE`, `LIBNAME`, `LIBLOCATION`) VALUES
	(100, '전주금암점', '전주'),
	(101, '전주송천점', '전주');
/*!40000 ALTER TABLE `lib` ENABLE KEYS */;


-- 테이블 library의 구조를 덤프합니다. member
DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `MEMBERID` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'ID',
  `MEMBERPW` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'PW',
  `MEMBERNAME` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '이름',
  `MEMBERBIRTHDAY` int(11) NOT NULL COMMENT '생년월일',
  `MEMBERPHONE` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '전화번호',
  `MEMBERADDR` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '주소',
  `JOINDAY` date NOT NULL COMMENT '가입일',
  `LIBCODE` int(11) NOT NULL COMMENT '도서관코드',
  `RENTALCOUNT` int(11) DEFAULT NULL COMMENT '대여횟수',
  `MEMBERPAYMENTSTATUS` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '회원비입금여부',
  PRIMARY KEY (`MEMBERID`),
  KEY `FK_lib_TO_member` (`LIBCODE`),
  CONSTRAINT `FK_lib_TO_member` FOREIGN KEY (`LIBCODE`) REFERENCES `lib` (`LIBCODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='회원';

-- Dumping data for table library.member: ~2 rows (대략적)
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`MEMBERID`, `MEMBERPW`, `MEMBERNAME`, `MEMBERBIRTHDAY`, `MEMBERPHONE`, `MEMBERADDR`, `JOINDAY`, `LIBCODE`, `RENTALCOUNT`, `MEMBERPAYMENTSTATUS`) VALUES
	('kjb7907', '1234', '김정빈', 930410, '01073667907', '전주시 덕진구 금암동', '2017-01-26', 100, NULL, '미입금'),
	('mid001', 'mpw001', '홍길동', 930410, '01088888888', '전라북도 전주시 덕진구 금암동', '2017-01-24', 100, 1, '입금회원');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;


-- 테이블 library의 구조를 덤프합니다. payment
DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `PAYMENTCODE` int(11) NOT NULL AUTO_INCREMENT COMMENT '결제코드',
  `RENTALCODE` int(11) NOT NULL COMMENT '대여코드',
  `MEMBERID` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'ID',
  `PAYMENTDAY` date NOT NULL COMMENT '결제일',
  `PAYMENTPRICE` int(11) NOT NULL COMMENT '결제금액',
  PRIMARY KEY (`PAYMENTCODE`),
  KEY `FK_rental_TO_payment` (`RENTALCODE`),
  KEY `FK_member_TO_payment` (`MEMBERID`),
  CONSTRAINT `FK_member_TO_payment` FOREIGN KEY (`MEMBERID`) REFERENCES `member` (`MEMBERID`),
  CONSTRAINT `FK_rental_TO_payment` FOREIGN KEY (`RENTALCODE`) REFERENCES `rental` (`RENTALCODE`)
) ENGINE=InnoDB AUTO_INCREMENT=2000001 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='결제';

-- Dumping data for table library.payment: ~1 rows (대략적)
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` (`PAYMENTCODE`, `RENTALCODE`, `MEMBERID`, `PAYMENTDAY`, `PAYMENTPRICE`) VALUES
	(2000000, 1000000, 'mid001', '2017-01-24', 1000);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;


-- 테이블 library의 구조를 덤프합니다. rental
DROP TABLE IF EXISTS `rental`;
CREATE TABLE IF NOT EXISTS `rental` (
  `RENTALCODE` int(11) NOT NULL AUTO_INCREMENT COMMENT '대여코드',
  `BOOKCODE` int(11) NOT NULL COMMENT '도서관리코드',
  `MEMBERID` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'ID',
  `RENTALSTARTDAY` date NOT NULL COMMENT '대여일',
  `RETURNEXPECTDAY` date NOT NULL COMMENT '반납예정일',
  `RETURNDAY` date DEFAULT NULL COMMENT '반납일',
  `RETURNSTATUS` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '반납여부',
  PRIMARY KEY (`RENTALCODE`),
  KEY `FK_books_TO_rental` (`BOOKCODE`),
  KEY `FK_member_TO_rental` (`MEMBERID`),
  CONSTRAINT `FK_books_TO_rental` FOREIGN KEY (`BOOKCODE`) REFERENCES `books` (`BOOKCODE`),
  CONSTRAINT `FK_member_TO_rental` FOREIGN KEY (`MEMBERID`) REFERENCES `member` (`MEMBERID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000006 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='대여';

-- Dumping data for table library.rental: ~2 rows (대략적)
/*!40000 ALTER TABLE `rental` DISABLE KEYS */;
INSERT INTO `rental` (`RENTALCODE`, `BOOKCODE`, `MEMBERID`, `RENTALSTARTDAY`, `RETURNEXPECTDAY`, `RETURNDAY`, `RETURNSTATUS`) VALUES
	(1000000, 800000, 'mid001', '2017-01-24', '2017-01-31', '2017-01-24', '반납'),
	(1000005, 800000, 'mid001', '2017-01-25', '2017-01-31', NULL, NULL);
/*!40000 ALTER TABLE `rental` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
