-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Mar 18, 2019 at 11:35 PM
-- Server version: 10.1.22-MariaDB
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_kuangx`
--

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `Cust_ID` int(11) NOT NULL,
  `Cust_Name` varchar(255) NOT NULL,
  `Cust_Phone_Number` varchar(10) NOT NULL,
  `Cust_Email` varchar(254) NOT NULL,
  `Cust_Address_Street` varchar(255) DEFAULT NULL,
  `Cust_Address_Zip` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`Cust_ID`, `Cust_Name`, `Cust_Phone_Number`, `Cust_Email`, `Cust_Address_Street`, `Cust_Address_Zip`) VALUES
(1, 'John Allen12', '1038859123', '12AllenJ@oregonstate.edu', '1523 Mcleod Ave12', '4421'),
(2, 'Richard Richardson', '5037678823', 'RR@gmail.com', '11542 NW Johnson St’', '92232'),
(3, 'Tom Allen', '5037748812', 'AllenT@oregonstate.edu', '1523 Mcleod Ave', '97330'),
(4, 'Taylor Brooks', '1203391842', 'brooksy@yahoo.com', '4273 Linkford Pk', '44723'),
(5, 'Chet Ubetcha', '5555599098', 'chett@1234.com', '456 This St', '11234'),
(6, 'CJ P', '5557789965', 'cj@p.com', '321 Chump Ln', '42012'),
(7, 'qwerty', '324232', 'dsdsf@sdd.com', '243wersfd', '32432'),
(8, 'Bryce Harper', '215-555-55', 'bharper@phillies.com', '1200 S Broad Street', '19103'),
(9, 'test', '1234567890', 'test@asdf', '123 m', '123'),
(10, 'test', '6666666666', 'test@testcom', '126 testy st', '111111'),
(11, 'John Allentest', '1234567891', 'testAllenJ@oregonstate.edu', 'test', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `Employees`
--

CREATE TABLE `Employees` (
  `Emp_ID` int(11) NOT NULL,
  `Emp_Name` varchar(255) NOT NULL,
  `Store_ID` int(11) NOT NULL,
  `Emp_Phone_Number` varchar(10) NOT NULL,
  `Emp_Address_Street` varchar(255) NOT NULL,
  `Emp_Address_Zip` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Employees`
--

INSERT INTO `Employees` (`Emp_ID`, `Emp_Name`, `Store_ID`, `Emp_Phone_Number`, `Emp_Address_Street`, `Emp_Address_Zip`) VALUES
(1, 'Chuck Smith', 1, '1413777283', '1112 Street St', '97330'),
(2, 'Larry Gurgitch', 2, '1541883912', '1455 Park Ave', '97330'),
(3, 'Mary Flatt', 2, '1142325542', '1185 Pickford St', '92333'),
(4, 'Super Dave', 3, '1413877200', '1738 Chill Rd', '44567'),
(5, 'Thomas Johnson', 1, '1023259258', '2906  Brownton Road', '97330'),
(6, 'Catherine Wooly', 3, '1376749035', '2500 Harter St', '44565'),
(9, 'Mark Tester', 19, '1112223333', '52 Mark\'l Rd', '54321'),
(10, 'Chetty Boii', 15, '+511122233', '123 notmain st', '88981'),
(11, 'Noworky12', 20, '987987987', 'not a street', '112233'),
(12, '123test', 1, 'tew', 'twet', '123');

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `Order_ID` int(11) NOT NULL,
  `Cust_ID` int(11) NOT NULL,
  `Emp_ID` int(11) NOT NULL,
  `Order_Date` datetime NOT NULL,
  `IMEI` int(15) NOT NULL,
  `Plan_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`Order_ID`, `Cust_ID`, `Emp_ID`, `Order_Date`, `IMEI`, `Plan_ID`) VALUES
(11, 1, 1, '2019-03-01 00:00:00', 0, 5),
(12, 1, 5, '2019-03-01 00:00:00', 0, 5),
(13, 6, 4, '2019-03-01 00:00:00', 2147483647, 3),
(14, 6, 9, '2019-03-03 00:00:00', 99999999, 1),
(15, 6, 2, '2019-01-01 00:00:00', 88878998, 6),
(16, 6, 10, '2019-01-09 00:00:00', 888789, 5),
(17, 6, 3, '2019-01-20 00:00:00', 8885576, 5),
(18, 10, 1, '2019-03-01 00:00:00', 11111010, 1),
(19, 7, 9, '2117-07-01 00:00:00', 9999630, 5);

-- --------------------------------------------------------

--
-- Table structure for table `Phones`
--

CREATE TABLE `Phones` (
  `IMEI` int(15) NOT NULL,
  `SKU` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Phones`
--

INSERT INTO `Phones` (`IMEI`, `SKU`) VALUES
(11111010, '1234'),
(486723455, '6009657'),
(2147483647, '6009657'),
(9999630, '6244701'),
(789456, '6259980'),
(8885576, '6261401'),
(112999908, '6282526'),
(227823009, '6282526'),
(888789, '6303049'),
(368899013, '6303049'),
(88878998, '6316066'),
(99999999, '6316066');

-- --------------------------------------------------------

--
-- Table structure for table `Phones_Infos`
--

CREATE TABLE `Phones_Infos` (
  `SKU` varchar(15) NOT NULL,
  `Manufacturer` varchar(255) NOT NULL,
  `Model` varchar(255) NOT NULL,
  `Phone_Name` varchar(255) DEFAULT NULL,
  `Phone_Price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Phones_Infos`
--

INSERT INTO `Phones_Infos` (`SKU`, `Manufacturer`, `Model`, `Phone_Name`, `Phone_Price`) VALUES
('1234', 'mc Test', 'Big Mac', 'II', 8),
('5870401', 'LG', 'G6', 'G6 4G LTE 32G - Platinum', 350),
('6009657', 'Apple', 'MT5C2LL/A', 'iPhone XS Max 64GB - Gold ', 1100),
('6244701', 'Asus', 'ZC600KL-5Q', 'ZenFone 5Q 64GB - Midnight Black', 249),
('6259980', 'Sony', 'H8166', 'XPERIA XZ2 Premium 64GB - Chrome Black', 850),
('6261401', 'LG', 'G7', 'G7 ThinQ 64GB - Aurora Black', 450),
('6282526', 'Samsung', 'SM-N960U', 'Galaxy Note9 128GB - Ocean Blue', 1000),
('6291898', 'Nokia', 'TA-1085 BLUE', 'Nokia 7.1 64GB - Blue', 300),
('6296105', 'Razer', 'RZ35-0259UR10-R3U1', 'Razer Phone2 64GB - Black', 450),
('6303049', 'Google', 'GA00468-US', 'Pixel 3 128GB - Not Pink', 929),
('6305718', 'LG', 'V40', 'V40 ThinQ 64GB - Aurora Black', 999),
('6316066', 'Apple', 'MQCL2LL/A', 'iPhone X 64GB - Silver', 800),
('6323529', 'Samsung', 'SM-G973UZBAXAA', 'Galaxy S10 128GB - Prism Blue', 850),
('6325704', 'Nokia', 'TA-1082 BLUE', 'Nokia 9 PureView 128GB - Midnight Blue', 550),
('8675309', 'PS Phonestores', 'MK30001', 'Test Phone MKIII2', 501);

-- --------------------------------------------------------

--
-- Table structure for table `ServicePlans`
--

CREATE TABLE `ServicePlans` (
  `Plan_ID` int(11) NOT NULL,
  `Plan_Cost` int(11) NOT NULL,
  `Plan_Name` varchar(255) NOT NULL,
  `Plan_Desc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ServicePlans`
--

INSERT INTO `ServicePlans` (`Plan_ID`, `Plan_Cost`, `Plan_Name`, `Plan_Desc`) VALUES
(1, 0, 'No Plan', 'No Plan'),
(2, 20, 'No Data', 'Unlimited call and texting but no data service'),
(3, 20, 'Limited Data', 'Unlimited call and text with 2GB of data'),
(4, 60, 'Unlimited Data', 'Unlimited call, text, and data'),
(5, 70, 'Unlimited Data + Hotspot', 'Unlimited call, text, data, and hotspot'),
(6, 10012, 'test plan12', 'test desc12'),
(7, 42, 'test plan new', 'Test plan description');

-- --------------------------------------------------------

--
-- Table structure for table `Stores`
--

CREATE TABLE `Stores` (
  `Store_ID` int(11) NOT NULL,
  `Store_Phone_Number` varchar(10) NOT NULL,
  `Store_Address_Street` varchar(255) NOT NULL,
  `Store_Address_Zip` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Stores`
--

INSERT INTO `Stores` (`Store_ID`, `Store_Phone_Number`, `Store_Address_Street`, `Store_Address_Zip`) VALUES
(1, '1036782932', '566 Newburg Dr', '97330'),
(2, '1036788402', '1100 Stent Ln', '97330'),
(3, '1009582911', '521 Lovelace St', '92333'),
(4, '1439011187', '10 4th Place', '01002'),
(15, '15599876', '444 65th LN', '88596'),
(19, '5557789965', '321 Chump Ln', '42012'),
(20, '80085', 'test st 443', '0123'),
(21, '999666961', 'Test Lane1', '02');

-- --------------------------------------------------------

--
-- Table structure for table `Stores_Customers`
--

CREATE TABLE `Stores_Customers` (
  `Store_ID` int(11) NOT NULL,
  `Cust_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Stores_Customers`
--

INSERT INTO `Stores_Customers` (`Store_ID`, `Cust_ID`) VALUES
(1, 1),
(3, 2),
(2, 3),
(1, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bsg_cert`
--
ALTER TABLE `bsg_cert`
  ADD PRIMARY KEY (`certification_id`);

--
-- Indexes for table `bsg_cert_people`
--
ALTER TABLE `bsg_cert_people`
  ADD PRIMARY KEY (`cid`,`pid`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `bsg_people`
--
ALTER TABLE `bsg_people`
  ADD PRIMARY KEY (`character_id`),
  ADD KEY `homeworld` (`homeworld`);

--
-- Indexes for table `bsg_planets`
--
ALTER TABLE `bsg_planets`
  ADD PRIMARY KEY (`planet_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `bsg_spaceship`
--
ALTER TABLE `bsg_spaceship`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cs290_db`
--
ALTER TABLE `cs290_db`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`Cust_ID`),
  ADD UNIQUE KEY `Cust_ID` (`Cust_ID`);

--
-- Indexes for table `Employees`
--
ALTER TABLE `Employees`
  ADD PRIMARY KEY (`Emp_ID`),
  ADD UNIQUE KEY `Emp_ID` (`Emp_ID`),
  ADD KEY `Employees_fk0` (`Store_ID`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`Order_ID`),
  ADD UNIQUE KEY `Order_ID` (`Order_ID`),
  ADD KEY `Orders_fk0` (`Cust_ID`),
  ADD KEY `Orders_fk1` (`Emp_ID`),
  ADD KEY `Orders_fk2` (`IMEI`),
  ADD KEY `Orders_fk3` (`Plan_ID`);

--
-- Indexes for table `Phones`
--
ALTER TABLE `Phones`
  ADD PRIMARY KEY (`IMEI`),
  ADD UNIQUE KEY `IMEI` (`IMEI`),
  ADD KEY `Phones_fk0` (`SKU`);

--
-- Indexes for table `Phones_Infos`
--
ALTER TABLE `Phones_Infos`
  ADD PRIMARY KEY (`SKU`);

--
-- Indexes for table `ServicePlans`
--
ALTER TABLE `ServicePlans`
  ADD PRIMARY KEY (`Plan_ID`);

--
-- Indexes for table `Stores`
--
ALTER TABLE `Stores`
  ADD PRIMARY KEY (`Store_ID`);

--
-- Indexes for table `Stores_Customers`
--
ALTER TABLE `Stores_Customers`
  ADD KEY `Stores_Customers_fk0` (`Store_ID`),
  ADD KEY `Stores_Customers_fk1` (`Cust_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bsg_cert`
--
ALTER TABLE `bsg_cert`
  MODIFY `certification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `bsg_people`
--
ALTER TABLE `bsg_people`
  MODIFY `character_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- AUTO_INCREMENT for table `bsg_planets`
--
ALTER TABLE `bsg_planets`
  MODIFY `planet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `bsg_spaceship`
--
ALTER TABLE `bsg_spaceship`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cs290_db`
--
ALTER TABLE `cs290_db`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Customers`
--
ALTER TABLE `Customers`
  MODIFY `Cust_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `Employees`
--
ALTER TABLE `Employees`
  MODIFY `Emp_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `Phones`
--
ALTER TABLE `Phones`
  MODIFY `IMEI` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2147483648;

--
-- AUTO_INCREMENT for table `ServicePlans`
--
ALTER TABLE `ServicePlans`
  MODIFY `Plan_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Stores`
--
ALTER TABLE `Stores`
  MODIFY `Store_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bsg_cert_people`
--
ALTER TABLE `bsg_cert_people`
  ADD CONSTRAINT `bsg_cert_people_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `bsg_cert` (`certification_id`),
  ADD CONSTRAINT `bsg_cert_people_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `bsg_people` (`character_id`);

--
-- Constraints for table `bsg_people`
--
ALTER TABLE `bsg_people`
  ADD CONSTRAINT `bsg_people_ibfk_1` FOREIGN KEY (`homeworld`) REFERENCES `bsg_planets` (`planet_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Employees`
--
ALTER TABLE `Employees`
  ADD CONSTRAINT `Employees_fk0` FOREIGN KEY (`Store_ID`) REFERENCES `Stores` (`Store_ID`);

--
-- Constraints for table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `Orders_fk0` FOREIGN KEY (`Cust_ID`) REFERENCES `Customers` (`Cust_ID`),
  ADD CONSTRAINT `Orders_fk1` FOREIGN KEY (`Emp_ID`) REFERENCES `Employees` (`Emp_ID`),
  ADD CONSTRAINT `Orders_fk3` FOREIGN KEY (`Plan_ID`) REFERENCES `ServicePlans` (`Plan_ID`);

--
-- Constraints for table `Phones`
--
ALTER TABLE `Phones`
  ADD CONSTRAINT `Phones_fk0` FOREIGN KEY (`SKU`) REFERENCES `Phones_Infos` (`SKU`);

--
-- Constraints for table `Stores_Customers`
--
ALTER TABLE `Stores_Customers`
  ADD CONSTRAINT `Stores_Customers_fk0` FOREIGN KEY (`Store_ID`) REFERENCES `Stores` (`Store_ID`),
  ADD CONSTRAINT `Stores_Customers_fk1` FOREIGN KEY (`Cust_ID`) REFERENCES `Customers` (`Cust_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
