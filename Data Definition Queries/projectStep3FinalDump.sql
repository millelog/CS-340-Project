-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Feb 10, 2019 at 08:15 PM
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
(1, 'John Allen', '1038859123', 'AllenJ@oregonstate.edu', '1523 Mcleod Ave', '97330'),
(2, 'Richard Richardson', '5037678823', 'RR@gmail.com', '11542 NW Johnson St’', '92232'),
(3, 'Tom Allen', '5037748812', 'AllenT@oregonstate.edu', '1523 Mcleod Ave', '97330'),
(4, 'Taylor Brooks', '1203391842', 'brooksy@yahoo.com', '4273 Linkford Pk', '44723');

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
(3, 'Mary Flatt', 2, '1142325542', '1185 Pickford St', '92333');

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `Order_ID` int(11) NOT NULL,
  `Cust_ID` int(11) NOT NULL,
  `Emp_ID` int(11) NOT NULL,
  `Order_Date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`Order_ID`, `Cust_ID`, `Emp_ID`, `Order_Date`) VALUES
(1, 1, 1, '2018-04-23 12:04:24'),
(2, 2, 1, '2018-07-11 08:09:48'),
(3, 3, 3, '2018-12-27 15:10:28'),
(4, 4, 2, '2019-01-27 13:56:43');

-- --------------------------------------------------------

--
-- Table structure for table `Orders_Products`
--

CREATE TABLE `Orders_Products` (
  `Order_ID` int(11) NOT NULL,
  `IMEI` int(11) NOT NULL,
  `Plan_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Orders_Products`
--

INSERT INTO `Orders_Products` (`Order_ID`, `IMEI`, `Plan_ID`) VALUES
(1, 486723455, 4),
(2, 112999908, 1),
(3, 227823009, 1),
(4, 368899013, 4);

-- --------------------------------------------------------

--
-- Table structure for table `Phones`
--

CREATE TABLE `Phones` (
  `IMEI` int(15) NOT NULL,
  `SKU` varchar(15) NOT NULL,
  `Order_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Phones`
--

INSERT INTO `Phones` (`IMEI`, `SKU`, `Order_ID`) VALUES
(112999908, '6282526', 3),
(227823009, '6282526', 4),
(368899013, '6303049', 1),
(486723455, '6009657', 2);

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
('6009657', 'Apple', 'MT5C2LL/A', 'iPhone XS Max 64GB - Gold ', 1100),
('6282526', 'Samsung', 'SM-N960U', 'Galaxy Note9 128GB - Ocean Blue', 1000),
('6303049', 'Google', 'GA00468-US', 'Pixel 3 128GB Not Pink', 929);

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
(4, 60, 'Unlimited Data', 'Unlimited call, text, and data');

-- --------------------------------------------------------

--
-- Table structure for table `Stores`
--

CREATE TABLE `Stores` (
  `Store_ID` int(11) NOT NULL,
  `Store_Phone_Number` int(11) NOT NULL,
  `Store_Address_Street` varchar(255) NOT NULL,
  `Store_Address_Zip` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Stores`
--

INSERT INTO `Stores` (`Store_ID`, `Store_Phone_Number`, `Store_Address_Street`, `Store_Address_Zip`) VALUES
(1, 1036782932, '566 Newburg Dr', '97330'),
(2, 1036788402, '1100 Stent Ln', '97330'),
(3, 1009582911, '521 Lovelace St', '92333');

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
  ADD KEY `Orders_fk1` (`Emp_ID`);

--
-- Indexes for table `Orders_Products`
--
ALTER TABLE `Orders_Products`
  ADD KEY `Orders_Products_fk0` (`Order_ID`),
  ADD KEY `Orders_Products_fk1` (`IMEI`),
  ADD KEY `Orders_Products_fk2` (`Plan_ID`);

--
-- Indexes for table `Phones`
--
ALTER TABLE `Phones`
  ADD PRIMARY KEY (`IMEI`),
  ADD UNIQUE KEY `IMEI` (`IMEI`),
  ADD KEY `Phones_fk0` (`SKU`),
  ADD KEY `Phones_fk1` (`Order_ID`);

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
  ADD PRIMARY KEY (`Store_ID`),
  ADD UNIQUE KEY `Store_Phone_Number` (`Store_Phone_Number`);

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
-- AUTO_INCREMENT for table `Customers`
--
ALTER TABLE `Customers`
  MODIFY `Cust_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Employees`
--
ALTER TABLE `Employees`
  MODIFY `Emp_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Phones`
--
ALTER TABLE `Phones`
  MODIFY `IMEI` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=486723456;

--
-- AUTO_INCREMENT for table `ServicePlans`
--
ALTER TABLE `ServicePlans`
  MODIFY `Plan_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Stores`
--
ALTER TABLE `Stores`
  MODIFY `Store_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

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
  ADD CONSTRAINT `Orders_fk1` FOREIGN KEY (`Emp_ID`) REFERENCES `Employees` (`Emp_ID`);

--
-- Constraints for table `Orders_Products`
--
ALTER TABLE `Orders_Products`
  ADD CONSTRAINT `Orders_Products_fk0` FOREIGN KEY (`Order_ID`) REFERENCES `Orders` (`Order_ID`),
  ADD CONSTRAINT `Orders_Products_fk1` FOREIGN KEY (`IMEI`) REFERENCES `Phones` (`IMEI`),
  ADD CONSTRAINT `Orders_Products_fk2` FOREIGN KEY (`Plan_ID`) REFERENCES `ServicePlans` (`Plan_ID`);

--
-- Constraints for table `Phones`
--
ALTER TABLE `Phones`
  ADD CONSTRAINT `Phones_fk0` FOREIGN KEY (`SKU`) REFERENCES `Phones_Infos` (`SKU`),
  ADD CONSTRAINT `Phones_fk1` FOREIGN KEY (`Order_ID`) REFERENCES `Orders` (`Order_ID`);

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
