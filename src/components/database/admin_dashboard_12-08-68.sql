-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 12, 2025 at 03:54 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `admin_dashboard`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `account` varchar(100) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `activity` text DEFAULT NULL,
  `page` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `account`, `ip_address`, `activity`, `page`, `timestamp`) VALUES
(1, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-23 10:00:35'),
(2, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-23 10:01:02'),
(3, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-23 10:01:08'),
(4, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 10:01:40'),
(5, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-23 10:03:03'),
(6, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-23 10:03:04'),
(7, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 10:03:11'),
(8, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 10:08:01'),
(9, 'crm020', '49.49.216.81', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 15:17:42'),
(10, 'Crm020', '49.49.216.81', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 23:51:23'),
(11, 'Crm020', '49.49.216.81', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 23:51:32'),
(12, 'crm020', '49.49.216.81', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 23:58:59'),
(13, 'crm020', '49.49.216.81', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 23:59:25'),
(14, 'crm020', '49.49.216.81', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-23 23:59:26'),
(15, 'crm020', '49.49.216.81', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 00:00:36'),
(16, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 01:16:49'),
(17, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 01:16:50'),
(18, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:18:07'),
(19, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:19:21'),
(20, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:20:59'),
(21, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:21:08'),
(22, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:21:36'),
(23, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:23:08'),
(24, 'Crm020', '49.237.45.249', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 01:23:56'),
(25, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:27:15'),
(26, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:32:47'),
(27, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:32:52'),
(28, 'Crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:33:15'),
(29, 'Crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:34:19'),
(30, 'Crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:34:50'),
(31, 'Crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 01:34:54'),
(32, 'crm020', '203.154.60.148', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 02:13:18'),
(33, 'crm020', '203.154.60.148', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 02:13:20'),
(34, 'crm020', '203.154.60.148', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 02:13:26'),
(35, 'crm020', '203.154.60.148', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 02:13:28'),
(36, 'crm020', '203.154.60.148', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 02:13:30'),
(37, 'Crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 03:18:32'),
(38, 'Crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 03:18:33'),
(39, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 03:19:22'),
(40, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 03:19:23'),
(41, 'Crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:20:16'),
(42, 'Crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 03:20:29'),
(43, 'Crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 03:20:30'),
(44, 'Crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:20:34'),
(45, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:21:53'),
(46, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:25:15'),
(47, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 03:26:58'),
(48, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 03:26:59'),
(49, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:28:01'),
(50, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:29:22'),
(51, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:32:22'),
(52, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:33:37'),
(53, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:36:20'),
(54, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:36:31'),
(55, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:36:34'),
(56, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 03:41:54'),
(57, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 03:41:55'),
(58, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:41:58'),
(59, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:45:02'),
(60, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:46:18'),
(61, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:46:23'),
(62, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:49:52'),
(63, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:50:07'),
(64, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:53:46'),
(65, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 03:57:44'),
(66, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:05:01'),
(67, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:05:14'),
(68, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 04:06:24'),
(69, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:06:44'),
(70, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 04:08:16'),
(71, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 04:08:17'),
(72, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:08:20'),
(73, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:08:22'),
(74, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:09:51'),
(75, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 04:10:01'),
(76, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:10:30'),
(77, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:10:35'),
(78, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:14:06'),
(79, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:15:07'),
(80, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:15:47'),
(81, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:16:29'),
(82, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:16:26'),
(83, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:17:29'),
(84, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:20:03'),
(85, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:20:47'),
(86, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:22:01'),
(87, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:23:11'),
(88, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:28:02'),
(89, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 04:28:23'),
(90, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 04:28:24'),
(91, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:28:23'),
(92, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:32:03'),
(93, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 04:36:43'),
(94, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 06:03:41'),
(95, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 06:03:42'),
(96, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 06:03:44'),
(97, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 06:11:03'),
(98, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:40:43'),
(99, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:41:00'),
(100, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:42:30'),
(101, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:42:35'),
(102, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:45:45'),
(103, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:46:50'),
(104, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:47:45'),
(105, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:49:00'),
(106, 'crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-24 09:51:35'),
(107, 'crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-24 09:51:36'),
(108, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:51:40'),
(109, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:53:50'),
(110, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-24 09:54:48'),
(111, 'crm020', '49.49.251.111', ' user ได้เข้าหน้า SaleOrderList', 'SaleOrderList.vue', '2025-07-25 04:23:09'),
(112, 'Crm020', '49.49.251.111', 'fa_account Login สำเร็จ', 'SinginForm.vue', '2025-07-25 09:20:01'),
(113, 'Crm020', '49.49.251.111', 'user ได้เข้าหน้า CustomerView', 'CustomerView.vue', '2025-07-25 09:20:02');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `cus_ids` varchar(50) NOT NULL,
  `cus_full_name` varchar(255) NOT NULL,
  `cus_image_path` varchar(512) NOT NULL,
  `cus_email` varchar(64) NOT NULL,
  `cus_password` varchar(512) DEFAULT '0',
  `cus_telephone` varchar(10) DEFAULT NULL,
  `cus_address` varchar(50) NOT NULL,
  `cus_status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `cus_ids`, `cus_full_name`, `cus_image_path`, `cus_email`, `cus_password`, `cus_telephone`, `cus_address`, `cus_status`, `created_at`) VALUES
(1, '452135', 'puttachai bodkhuntod', 'http://localhost/assets/image/profile/first.png', 'puttachai.2546@gmail.com', '123', '0952517869', '454/279 ลาดพร้าว87แยก 22', '์normal', '2025-06-18 04:20:22');

-- --------------------------------------------------------

--
-- Table structure for table `documentrunning`
--

CREATE TABLE `documentrunning` (
  `id` int(11) NOT NULL,
  `warehouse_code` varchar(10) DEFAULT NULL,
  `doc_type` varchar(10) DEFAULT NULL,
  `prefix` varchar(30) DEFAULT NULL,
  `run_number` varchar(10) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documentrunning`
--

INSERT INTO `documentrunning` (`id`, `warehouse_code`, `doc_type`, `prefix`, `run_number`, `created_at`, `updated_at`) VALUES
(17, 'H1', 'SO', 'H1-SO25680711', '43', '2025-07-11 13:42:58', '2025-07-12 01:45:36'),
(18, 'H1', 'SO', 'H1-SO25680712', '22', '2025-07-12 08:22:51', '2025-07-12 18:36:52'),
(19, 'H1', 'SO', 'H1-SO25680714', '5', '2025-07-14 09:23:10', '2025-07-14 09:27:24'),
(20, 'H1', 'SO', 'H1-SO25680715', '11', '2025-07-15 13:12:34', '2025-07-15 13:32:29'),
(21, 'H1', 'SO', 'H1-SO25680718', '12', '2025-07-18 09:10:06', '2025-07-18 10:42:06'),
(22, 'H1', 'SO', 'H1-SO25680722', '1', '2025-07-22 15:30:41', '2025-07-22 15:30:41'),
(23, 'H1', 'SO', 'H1-SO25680723', '2', '2025-07-23 08:25:16', '2025-07-23 13:25:52'),
(24, 'H1', 'SO', 'H1-SO25680724', '14', '2025-07-24 13:10:42', '2025-07-25 02:21:24'),
(25, 'H1', 'SO', 'H1-SO25680725', '41', '2025-07-25 08:08:45', '2025-07-25 21:00:03'),
(26, 'H1', 'SO', 'H1-SO25680726', '34', '2025-07-26 06:58:11', '2025-07-27 15:20:31'),
(27, 'H1', 'SO', 'H1-SO25680727', '58', '2025-07-27 17:24:30', '2025-07-30 11:37:02'),
(28, 'H1', 'SO', 'H1-SO25680729', '2', '2025-07-29 09:26:13', '2025-07-29 09:31:44'),
(29, 'H1', 'SO', 'H1-SO25680730', '13', '2025-07-30 14:22:38', '2025-07-30 16:55:03'),
(30, 'H1', 'SO', 'H1-SO25680731', '1', '2025-07-31 15:18:54', '2025-07-31 15:18:54'),
(31, 'H1', 'SO', 'H1-SO25680801', '4', '2025-08-01 10:24:46', '2025-08-01 10:35:23'),
(32, 'H1', 'SO', 'H1-SO25680802', '8', '2025-08-02 14:45:12', '2025-08-02 16:30:07'),
(33, 'H1', 'SO', 'H1-SO25680803', '19', '2025-08-03 17:06:42', '2025-08-04 00:29:30'),
(34, 'H1', 'SO', 'H1-SO25680804', '35', '2025-08-04 13:41:18', '2025-08-04 21:39:02'),
(35, 'H1', 'SO', 'H1-SO25680808', '13', '2025-08-08 13:25:08', '2025-08-08 14:30:30'),
(36, 'H1', 'SO', 'H1-SO25680809', '17', '2025-08-09 08:20:40', '2025-08-09 16:49:30'),
(37, 'H1', 'SO', 'H1-SO25680811', '4', '2025-08-11 10:56:28', '2025-08-11 11:29:11');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL COMMENT 'id',
  `emp_ids` int(6) NOT NULL COMMENT 'รหัสพนักงาน',
  `customer_no` varchar(255) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL COMMENT 'ที่อยู่รูปภาพ',
  `full_name` varchar(255) NOT NULL COMMENT 'ชื่อเต็ม',
  `email` varchar(255) NOT NULL COMMENT 'อีเมล',
  `password` varchar(255) NOT NULL COMMENT 'รหัสผ่าน',
  `telephone` varchar(10) NOT NULL COMMENT 'โทรศัพท์',
  `address` varchar(255) NOT NULL COMMENT 'ที่อยู่',
  `department` varchar(128) NOT NULL COMMENT 'แผนกงาน',
  `salary` double(16,2) NOT NULL COMMENT 'เงินเดือน',
  `status` enum('Normal','Active','Inactive','Abnormal') NOT NULL COMMENT 'สถานะ',
  `start_work` datetime DEFAULT NULL ON UPDATE current_timestamp() COMMENT 'วันเริ่มงาน',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `emp_ids`, `customer_no`, `image_path`, `full_name`, `email`, `password`, `telephone`, `address`, `department`, `salary`, `status`, `start_work`, `created_at`) VALUES
(11, 996716, '', 'http://localhost/api_admin_dashboard/backend/img/profile/684d50367d9b1_puttachai.png', 'Testter Test', 'testters@gmail.com', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '0952546369', '107 rbac Facility of Engineering', 'Tester', 20999.00, 'Active', '2025-07-29 22:38:38', '2025-06-14 11:34:53'),
(14, 581850, '', 'http://localhost/api_admin_dashboard/backend/img/profile/688980a688bd3_doctor.png', 'Profile Admin', 'test@gmail.com', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', '015614659', 'Profile Admin', 'Admin', 18000.00, 'Active', '2025-07-31 00:00:00', '2025-07-30 09:17:10');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `pro_code` varchar(50) NOT NULL,
  `pro_name` varchar(255) NOT NULL,
  `pro_images` varchar(512) NOT NULL,
  `pro_quantity` decimal(10,2) NOT NULL,
  `pro_unit_price` decimal(10,2) NOT NULL,
  `pro_discount_per_unit` decimal(10,2) DEFAULT 0.00,
  `pro_unit` varchar(50) DEFAULT NULL,
  `pro_total_price` decimal(10,2) NOT NULL,
  `pro_status` varchar(50) DEFAULT 'available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `pro_code`, `pro_name`, `pro_images`, `pro_quantity`, `pro_unit_price`, `pro_discount_per_unit`, `pro_unit`, `pro_total_price`, `pro_status`, `created_at`) VALUES
(1, 'P0001-2', 'MacBook Air รุ่น 13 นิ้ว', 'http://localhost/api_admin_dashboard/backend/img/products/Apple MacBook Air 13.webp', 460.00, 45500.00, 999.00, 'ชิ้น', 20930000.00, 'available', '2025-06-20 07:08:02'),
(2, 'P0001-3', 'MacBook Air รุ่น 15 นิ้ว', 'http://localhost/api_admin_dashboard/backend/img/products/Apple MacBook Air 15.webp', 150.00, 56900.00, 890.00, 'ชิ้น', 20930000.00, 'available', '2025-06-20 07:07:39');

-- --------------------------------------------------------

--
-- Table structure for table `sale_item`
--

CREATE TABLE `sale_item` (
  `item_id` int(11) NOT NULL COMMENT 'รหัสไอเท็ม',
  `item_code` varchar(50) NOT NULL COMMENT 'รหัสสินค้า',
  `item_name` varchar(255) NOT NULL COMMENT 'ชื่อสินค้า',
  `unit_price` decimal(10,2) NOT NULL COMMENT 'ราคาต่อหน่วย',
  `discount_per_unit` decimal(10,2) DEFAULT 0.00 COMMENT '	ส่วนลดต่อหน่วย',
  `unit` varchar(50) DEFAULT NULL COMMENT 'หน่วยนับ',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่และเวลาที่เพิ่มข้อมูล'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_item`
--

INSERT INTO `sale_item` (`item_id`, `item_code`, `item_name`, `unit_price`, `discount_per_unit`, `unit`, `created_at`) VALUES
(1, 'P0001-2', 'ข้อมูลตัวอย่าง 7(M)', 600.00, 20.00, 'ตัว', '2025-06-18 04:31:00'),
(2, 'P0002-1', 'เสื้อยืดคอกลม Size L', 350.00, 0.00, 'ตัว', '2025-06-18 04:31:00'),
(3, 'P0003-5', 'กางเกงยีนส์ชาย', 900.00, 50.00, 'ตัว', '2025-06-18 04:31:00');

-- --------------------------------------------------------

--
-- Table structure for table `sale_list`
--

CREATE TABLE `sale_list` (
  `sale_id` int(11) NOT NULL COMMENT 'รหัสรายการขาย',
  `item_id` int(11) NOT NULL COMMENT 'รหัสสินค้า',
  `quantity` int(11) NOT NULL COMMENT 'จำนวนที่ขาย',
  `total_price` decimal(10,2) NOT NULL COMMENT 'ราคารวมหลังหักส่วนลดแล้ว',
  `delivery_method` varchar(100) DEFAULT NULL COMMENT 'วิธีการจัดส่ง',
  `payment_method` varchar(100) DEFAULT NULL COMMENT 'วิธีชำระเงิน',
  `remark` text DEFAULT NULL COMMENT 'หมายเหตุเพิ่มเติม',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '	วันที่และเวลาที่ทำรายการขาย'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_list`
--

INSERT INTO `sale_list` (`sale_id`, `item_id`, `quantity`, `total_price`, `delivery_method`, `payment_method`, `remark`, `created_at`) VALUES
(1, 1, 1, 580.00, 'เก็บเงินปลายทาง', 'เงินสด', 'ไม่มีหมายเหตุ', '2025-06-18 04:31:13'),
(2, 2, 2, 700.00, 'เก็บเงินปลายทาง', 'โอนผ่านธนาคาร', 'ลดราคาพิเศษ', '2025-06-18 04:31:13'),
(3, 3, 1, 850.00, 'ส่งฟรี', 'เครดิตการ์ด', 'ลูกค้าประจำ', '2025-06-18 04:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `sale_order`
--

CREATE TABLE `sale_order` (
  `id` int(11) NOT NULL,
  `list_code` varchar(100) DEFAULT NULL,
  `sell_date` date DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `channel` varchar(100) DEFAULT NULL,
  `tax_type` varchar(100) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `customer_code` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(20) DEFAULT NULL,
  `receiver_email` varchar(255) DEFAULT NULL,
  `receiver_address` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `work_detail` text DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `tracking_no` varchar(255) DEFAULT NULL,
  `delivery_type` varchar(100) DEFAULT NULL,
  `total_discount` varchar(100) DEFAULT NULL,
  `delivery_fee` varchar(100) DEFAULT NULL,
  `product_qty` varchar(100) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `discount_qty` varchar(100) DEFAULT NULL,
  `final_total_price` decimal(16,2) NOT NULL,
  `document_no` varchar(255) DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT 0,
  `vat_visible` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'แสดงภาษี (1=แสดง, 0=ไม่แสดง)',
  `status` enum('ยังไม่ได้ตรวจสอบ','ตรวจสอบเรียบร้อย','การตรวจสอบล้มเหลว') DEFAULT 'ยังไม่ได้ตรวจสอบ',
  `created_at` datetime DEFAULT current_timestamp(),
  `price_before_tax` decimal(16,2) DEFAULT 0.00,
  `tax_value` decimal(16,2) DEFAULT 0.00,
  `price_with_tax` decimal(16,2) DEFAULT 0.00,
  `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'สถานะอ่านข้อความ (0=ยังไม่อ่านข้อความ, 1=อ่านข้อความแล้ว)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_order`
--

INSERT INTO `sale_order` (`id`, `list_code`, `sell_date`, `reference`, `channel`, `tax_type`, `full_name`, `customer_code`, `phone`, `email`, `address`, `receiver_name`, `receiver_phone`, `receiver_email`, `receiver_address`, `note`, `work_detail`, `delivery_date`, `tracking_no`, `delivery_type`, `total_discount`, `delivery_fee`, `product_qty`, `product_name`, `discount_qty`, `final_total_price`, `document_no`, `is_locked`, `vat_visible`, `status`, `created_at`, `price_before_tax`, `tax_value`, `price_with_tax`, `is_read`) VALUES
(87, 'H1-SO25680711', '2025-07-11', 'H1-SO25680711', 'Mobile D-power', 'H1-SO25680711', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'test@gmail.com', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', 'test@gmail.com', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'insert products', NULL, '2025-07-12', 'TH15653132', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 19880.60, 'H1-SO25680711-000003', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-07-11 13:07:11', 0.00, 0.00, 0.00, 0),
(88, 'H1-SO25680711', '2025-07-11', 'H1-SO25680711', 'Mobile D-power', 'H1-SO25680711', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'test@gmail.com', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', 'test@gmail.com', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'insert products', NULL, '2025-07-12', 'TH156453148468', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 1498.00, 'H1-SO25680711-000009', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-07-11 13:11:15', 0.00, 0.00, 0.00, 0),
(89, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'asfa', 'asdas', 'dasfds', '0638606865', 'sdfdsf', 'ffsfsd, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'afaadasd', NULL, '2025-07-12', 'TH1532561653', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 722.25, 'H1-SO25680711-000010', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 12:29:01', 0.00, 0.00, 0.00, 0),
(90, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'asdasd', 'asdad', 'asdasd', 'asdasd', 'asdas', 'adsada', 'asasda', NULL, '2025-07-14', 'TH156156316', 'แมสเซนเจอร์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000011', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 10:30:20', 0.00, 0.00, 0.00, 0),
(91, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'asdad', 'asdas', 'adas', '0348645', 'asdasd', 'adasd', '', NULL, '2025-07-12', 'TH153516513', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000012', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 15:15:21', 0.00, 0.00, 0.00, 0),
(92, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'sfdsfds', 'sdfsf', 'adasda', 'adad', 'asdasd', 'asdasd', '', NULL, '2025-07-12', 'TH412134', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000013', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 15:18:35', 0.00, 0.00, 0.00, 0),
(93, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'adad', 'asdasds', 'asdas', 'adad', 'sda', 'dsasd', 'asdasd', NULL, '2025-07-14', 'asdad', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 722.25, 'H1-SO25680711-000014', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 09:34:59', 0.00, 0.00, 0.00, 0),
(94, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'asda', 'dasda', 'asdasd', 'asdasd', 'adasd', 'asdasd', '', NULL, '2025-07-14', 'adada', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000015', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-11 08:17:31', 0.00, 0.00, 0.00, 0),
(95, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'adas', 'asdas', 'dasd', 'adad', 'asdas', 'asdasd', '', NULL, '2025-07-15', 'asdasd', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 315.65, 'H1-SO25680711-000016', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-11 11:18:10', 0.00, 0.00, 0.00, 0),
(96, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'asdasd', 'asdasd', 'adasda', 'dasd', 'adasd', 'adas', 'adasd', NULL, '2025-07-14', 'dsadas', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 722.25, 'H1-SO25680711-000017', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-11 08:07:34', 0.00, 0.00, 0.00, 0),
(97, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'adasd', 'asdasd', 'ada', 'adad', 'ads', 'ada', '', NULL, '2025-07-17', 'th153135', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000018', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-07-11 16:40:16', 0.00, 0.00, 0.00, 0),
(98, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'zxcx', 'zxczxc', 'zxczxcz', 'xzdczc', 'adasd', 'sadxsad', '', NULL, '2025-07-17', 'zxczx', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000019', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 15:37:01', 0.00, 0.00, 0.00, 0),
(99, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'asdasd', 'asdas', 'asdas', 'ada', 'asdas', 'asdas', 'ada', NULL, '2025-07-12', 'asdas', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000020', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-07-11 14:41:01', 0.00, 0.00, 0.00, 0),
(100, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'adas', 'adas', 'adsa', 'adas', 'daa', 'adasa', 'asda', NULL, '2025-07-17', 'adad', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000021', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-11 18:26:10', 0.00, 0.00, 0.00, 0),
(101, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'das', 'asdasd', 'adad', 'adad', 'asdasa', 'daa', '', NULL, '2025-07-15', 'das', 'ขนส่งเอกชน', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000022', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 14:08:16', 0.00, 0.00, 0.00, 0),
(102, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'asdasda', 'das', 'adasdd', 'adasd', 'asdsd', 'adsad', '', NULL, '2025-07-17', 'asdasd', 'แมสเซนเจอร์', '', '', NULL, NULL, NULL, 636.65, 'H1-SO25680711-000023', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 18:41:29', 0.00, 0.00, 0.00, 0),
(103, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'adasa', 'dsada', 'ada', 'adada', 'asdasd', 'adas', 'ada', NULL, '2025-07-11', 'asdasd', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 315.65, 'H1-SO25680711-000024', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 11:53:59', 0.00, 0.00, 0.00, 0),
(104, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'asdasd', 'adasd', 'asdasd', 'asdas', 'asdasd', 'ada', '', NULL, '2025-07-12', 'adasd', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 321.00, 'H1-SO25680711-000025', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-11 09:52:26', 0.00, 0.00, 0.00, 0),
(105, 'H1-SO25680711', '2025-07-11', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'adsada', 'adadas', 'adasda', 'sdasd', 'adas', 'adad', '', NULL, '2025-07-11', 'adad', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 315.65, 'H1-SO25680711-000026', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-11 08:30:29', 0.00, 0.00, 0.00, 0),
(106, 'H1-SO25680711', '2025-07-11', 'H1-SO25680711', 'Mobile D-power', 'H1-SO25680711', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'test@gmail.com', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', 'test@gmail.com', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'insert products', NULL, '2025-07-15', 'TH445682515', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 1203.75, 'H1-SO25680711-000027', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-11 12:47:27', 0.00, 0.00, 0.00, 0),
(107, 'H1-SO25680711', '2025-07-11', 'H1-SO25680711', 'Mobile D-power', 'H1-SO25680711', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'test@gmail.com', 'ถนนปากน้ำ, แขวง ปากน้ำ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', 'test@gmail.com', 'ถนนปากน้ำ, แขวง ปากน้ำ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', 'insert products', NULL, '2025-07-12', 'TH14321584869', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 722.25, 'H1-SO25680711-000043', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-11 10:27:12', 0.00, 0.00, 0.00, 1),
(108, 'H1-SO25680712', '2025-07-12', 'H1-SO25680711', 'Mobile D-power', 'H1-SO25680711', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'test@gmail.com', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', 'test@gmail.com', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'insert products', NULL, '2025-07-14', 'TH4586312846', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 1294.70, 'H1-SO25680712-000001', 1, 0, 'ตรวจสอบเรียบร้อย', '2025-07-12 11:29:53', 0.00, 0.00, 0.00, 0),
(109, 'H1-SO25680712', '2025-07-12', 'H1-SO25680712', 'Mobile D-power', 'H1-SO25680712', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'test@gmail.com', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', 'test@gmail.com', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'insert products', NULL, '2025-07-14', 'TH531326816', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 25958.20, 'H1-SO25680712-000013', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-12 16:22:59', 0.00, 0.00, 0.00, 0),
(110, 'H1-SO25680712', '2025-07-12', 'sdfdsf', 'fdsfds', 'sdfdsfsd', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'dfds', 'sdfds', 'adsasd', '0638606865', 'asda', 'asdasd, แขวง วชิรพยาบาล เขตดุสิต, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'sdfds', NULL, '2025-07-19', 'asdasd', 'แมสเซนเจอร์', '', '', NULL, NULL, NULL, 40750.95, 'H1-SO25680712-000015', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-07-12 15:47:53', 0.00, 0.00, 0.00, 0),
(111, 'H1-SO25680712', '2025-07-12', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', 'aS', 'sda', 'ASDAS', '0638606865', 'ASDAS', 'SADASD, แขวง ลาดกระบัง เขตลาดกระบัง, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '', NULL, '2025-07-12', 'ADSA', 'แมสเซนเจอร์', '', '', NULL, NULL, NULL, 856.00, 'H1-SO25680712-000016', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-12 08:43:06', 0.00, 0.00, 0.00, 0),
(112, 'H1-SO25680712', '2025-07-12', '', '', 'ไม่รวมภาษี', 'คุณ โสภา ประจวบสุข (S02)', 'C03290', '0851195429', '-', '1010222522', 'nn', '0851195429', '-', '1010/1010, แขวง  เขตสะพานสูง, กรุงเทพมหานคร, เบอร์โทร: 0851195429', '', NULL, '2025-07-12', '1010', 'ขนส่งเอกชน', '0', '0', NULL, NULL, NULL, 21850.00, 'H1-SO25680712-000019', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-12 11:28:04', 0.00, 0.00, 0.00, 0),
(113, 'H1-SO25680712', '2025-07-12', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '', '', 'adasd', '0638606865', 'asdad', 'sadas, แขวง เทพารักษ์ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', '', NULL, '2025-07-12', 'dasdasd', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 14980.00, 'H1-SO25680712-000020', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-12 19:25:24', 0.00, 0.00, 0.00, 0),
(114, 'H1-SO25680712', '2025-07-12', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '', '', 'sdd', '0638606865', 'asda', 'dasdasd, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0638606865', '', NULL, '2025-07-12', 'dasdasd', 'แมสเซนเจอร์', '', '', NULL, NULL, NULL, 10967.50, 'H1-SO25680712-000021', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-07-12 13:49:57', 0.00, 0.00, 0.00, 0),
(115, 'H1-SO25680712', '2025-07-12', '', '', '', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '', '', 'asdas', '0638606865', 'adsad', 'adadsda, แขวง ดุสิต เขตดุสิต, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '', NULL, '2025-07-12', 'dsad', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 4387.00, 'H1-SO25680712-000022', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-07-12 16:00:35', 0.00, 0.00, 0.00, 0),
(116, 'H1-SO25680714', '2025-07-14', 'H1-SO25680721', '-', 'H1-SO25680721', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'insert products', NULL, '2025-07-15', 'TH215326555', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 80678.00, 'H1-SO25680714-000001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-14 11:41:41', 0.00, 0.00, 0.00, 0),
(117, 'H1-SO25680714', '2025-07-14', '', '', '', 'คุณ โสภา ประจวบสุข (S02)', 'C03290', '0851195429', '', '99, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0851195429', 'คุณ โสภา ประจวบสุข (S02)', '0851195429', '', '99, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0851195429', '', NULL, '2025-07-14', '99', 'แมสเซนเจอร์', '', '', NULL, NULL, NULL, 5894.63, 'H1-SO25680714-000002', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-14 18:06:40', 0.00, 0.00, 0.00, 0),
(118, 'H1-SO25680714', '2025-07-14', '', '', 'ไม่รวมภาษี', 'คุณ โสภา ประจวบสุข (S02)', 'C03290', '0851195429', '', '99, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0851195429', 'คุณ โสภา ประจวบสุข (S02)', '0851195499', '', '99, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0851195429', '', NULL, '2025-07-14', '99', 'แมสเซนเจอร์', '', '', NULL, NULL, NULL, 5509.00, 'H1-SO25680714-000005', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-14 10:51:38', 0.00, 0.00, 0.00, 0),
(119, 'H1-SO25680715', '2025-07-15', 'H1-SO25680715', 'Mobile D-power', 'H1-SO25680715', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'insert products', NULL, '2025-07-16', 'TH181351651531', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 13867.20, 'H1-SO25680715-00010', 0, 0, 'การตรวจสอบล้มเหลว', '2025-07-15 19:21:01', 0.00, 0.00, 0.00, 0),
(120, 'H1-SO25680718', '2025-07-18', '-', '-', 'ไม่รวมภาษี', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-19', 'TH181345684165', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 2624.00, 'H1-SO25680718-00001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-18 09:20:14', 0.00, 0.00, 0.00, 0),
(121, 'H1-SO25680718', '2025-07-18', '-', '-', 'ไม่รวมภาษี', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-18', 'TH153', 'ไปรษณีย์', '0', '0', NULL, NULL, NULL, 27109.52, 'H1-SO25680718-00012', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-18 09:22:21', 25336.00, 1773.52, 27109.52, 0),
(122, 'H1-SO25680722', '2025-07-22', '-', '-', '-', 'คุณอาทิตย์ ศรีนิล', 'C04277', '0926484269', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0926484269', 'คุณอาทิตย์ ศรีนิล', '0926484269', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0926484269', '-', NULL, '2025-07-23', 'TH1532156153', 'ไปรษณีย์', '120', '200', NULL, NULL, NULL, 4740.10, 'H1-SO25680722-00001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-22 15:30:42', 4430.00, 310.10, 4740.10, 0),
(123, 'H1-SO25680723', '2025-07-23', '-', '-', '-', 'คุณ ณัฐพร รัตนอมตกุล', 'C04366', '0884449959', '-', 'ถนนสีลม, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0884449959', 'คุณ ณัฐพร รัตนอมตกุล', '0884449959', '-', 'ถนนสีลม, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0884449959', '-', NULL, '2025-07-24', 'TH183123186984', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 5926.73, 'H1-SO25680723-00001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-23 08:25:16', 5539.00, 387.73, 5926.73, 0),
(124, 'H1-SO25680723', '2025-07-23', '-', '-', '-', 'คุณนรินทร์ โชยชัยสุนทร', 'C03519', '0866471575', '-', 'ถนนสีลม, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0866471575', 'คุณนรินทร์ โชยชัยสุนทร', '0866471575', '-', 'ถนนสีลม, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0866471575', '-', NULL, '2025-07-24', 'TH4846543846', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 17638.95, 'H1-SO25680723-00002', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-23 13:25:52', 16485.00, 1153.95, 17638.95, 0),
(125, 'H1-SO25680724', '2025-07-24', '-', '-', '-', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', 'AP00025202', '0629352962', '-', 'TEST, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0629352962', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', '0629352962', '-', 'TEST, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0629352962', '-', NULL, '2025-07-25', 'TH5655845378', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 1861.80, 'H1-SO25680724-00001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-24 13:10:42', 1740.00, 121.80, 1861.80, 0),
(126, 'H1-SO25680724', '2025-07-24', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'Th1465414165', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 43458.05, 'H1-SO25680724-00002', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-24 23:07:26', 40615.00, 2843.05, 43458.05, 0),
(127, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'TH158515365', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 10250.60, 'H1-SO25680724-00003', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 01:13:39', 9580.00, 670.60, 10250.60, 0),
(128, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'TH158515365', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 10250.60, 'H1-SO25680724-00004', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 01:13:54', 9580.00, 670.60, 10250.60, 0),
(129, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง อนุสาวรีย์ เขตบางเขน, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง อนุสาวรีย์ เขตบางเขน, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'TH25465165', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 25856.55, 'H1-SO25680724-00005', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 01:17:39', 24165.00, 1691.55, 25856.55, 0),
(130, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง อนุสาวรีย์ เขตบางเขน, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง อนุสาวรีย์ เขตบางเขน, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'TH25465165', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 4761.50, 'H1-SO25680724-00006', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 01:19:48', 4450.00, 311.50, 4761.50, 0),
(131, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-24', 'TH1565165', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 4205.10, 'H1-SO25680724-00007', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 01:28:45', 3930.00, 275.10, 4205.10, 0),
(132, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'Th14132156132', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 29772.75, 'H1-SO25680724-00009', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 01:38:34', 27825.00, 1947.75, 29772.75, 0),
(133, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'TH5434156135', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 33325.15, 'H1-SO25680724-00011', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 01:50:44', 31145.00, 2180.15, 33325.15, 0),
(134, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'Th156165', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 3049.50, 'H1-SO25680724-00012', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 01:57:39', 2850.00, 199.50, 3049.50, 0),
(135, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'Th151651', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 3049.50, 'H1-SO25680724-00013', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 02:19:15', 2850.00, 199.50, 3049.50, 0),
(136, 'H1-SO25680724', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'TH151665', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 3049.50, 'H1-SO25680724-00014', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 02:21:24', 2850.00, 199.50, 3049.50, 0),
(137, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'TH4542156486468', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 23705.85, 'H1-SO25680725-00001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 08:08:45', 22155.00, 1550.85, 23705.85, 0),
(138, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', 'TH17465465', 'ไปรษณีย์', '', '', NULL, NULL, NULL, 13877.90, 'H1-SO25680725-00002', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 08:11:26', 12970.00, 907.90, 13877.90, 0),
(139, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'คุณ โสภา ประจวบสุข (S02)', 'C03290', '0851195429', '-', '99, แขวง เทพารักษ์ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0851195429', 'คุณ โสภา ประจวบสุข (S02)', '0851195429', '-', '99, แขวง เทพารักษ์ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0851195429', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 6848.00, 'H1-SO25680725-00003', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 09:46:52', 6400.00, 448.00, 6848.00, 0),
(140, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'คุณ โสภา ประจวบสุข (S02)', 'C03290', '0851195429', '-', '22, แขวง เทพารักษ์ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0851195429', 'คุณ โสภา ประจวบสุข (S02)', '0851195429', '-', '22, แขวง เทพารักษ์ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0851195429', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 19848.50, 'H1-SO25680725-00004', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 09:50:46', 18550.00, 1298.50, 19848.50, 0),
(141, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง บางพลีใหญ่ บางพลี, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง บางพลีใหญ่ บางพลี, สมุทรปราการ, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '0', '0', NULL, NULL, NULL, 8142.70, 'H1-SO25680725-00007', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 09:55:45', 7610.00, 532.70, 8142.70, 0),
(142, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'สีลม, แขวง มหาพฤฒาราม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'สีลม, แขวง มหาพฤฒาราม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 11909.10, 'H1-SO25680725-00008', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 10:31:24', 11130.00, 779.10, 11909.10, 0),
(143, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'สีลม, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'สีลม, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 3156.50, 'H1-SO25680725-00009', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 10:39:32', 2950.00, 206.50, 3156.50, 0),
(144, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง หนองจอก เขตหนองจอก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง หนองจอก เขตหนองจอก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 5184.15, 'H1-SO25680725-00010', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 10:47:08', 4845.00, 339.15, 5184.15, 0),
(145, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', 'AP00025202', '0629352962', '-', '55, แขวง เสือโฮก เมืองชัยนาท, ชัยนาท, เบอร์โทร: 0629352962', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', '0629352962', '-', '55, แขวง เสือโฮก เมืองชัยนาท, ชัยนาท, เบอร์โทร: 0629352962', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 4766.85, 'H1-SO25680725-00011', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 10:54:09', 4455.00, 311.85, 4766.85, 0),
(146, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', 'AP00025202', '0629352962', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0629352962', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', '0629352962', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0629352962', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 1551.50, 'H1-SO25680725-00012', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 11:40:05', 1450.00, 101.50, 1551.50, 0),
(147, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สุริยวงศ์ เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สุริยวงศ์ เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 802.50, 'H1-SO25680725-00013', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 11:42:10', 750.00, 52.50, 802.50, 0),
(148, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 642.00, 'H1-SO25680725-00014', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 11:45:22', 600.00, 42.00, 642.00, 0),
(149, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 1123.50, 'H1-SO25680725-00015', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 11:48:13', 1050.00, 73.50, 1123.50, 0),
(150, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 1123.50, 'H1-SO25680725-00016', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 11:54:06', 1050.00, 73.50, 1123.50, 0),
(151, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00017', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 13:18:54', 186.92, 13.08, 200.00, 0),
(152, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00018', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 13:22:34', 186.92, 13.08, 200.00, 0),
(153, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00019', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 14:09:35', 186.92, 13.08, 200.00, 0),
(154, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00020', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 14:16:53', 186.92, 13.08, 200.00, 0),
(155, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00021', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 14:45:13', 186.92, 13.08, 200.00, 1),
(156, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง สีลม เขตบางรัก, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00022', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:04:35', 186.92, 13.08, 200.00, 0),
(157, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '0, แขวง ท้ายบ้านใหม่ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '0, แขวง ท้ายบ้านใหม่ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00023', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:08:15', 186.92, 13.08, 200.00, 0),
(158, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00024', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:25:42', 186.92, 13.08, 200.00, 0),
(159, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'pro_discount, แขวง ท้ายบ้านใหม่ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'pro_discount, แขวง ท้ายบ้านใหม่ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00028', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:31:31', 186.92, 13.08, 200.00, 0),
(160, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'pro_discount, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'pro_discount, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00029', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:33:53', 186.92, 13.08, 200.00, 0),
(161, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00031', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:37:44', 186.92, 13.08, 200.00, 0),
(162, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'totalDiscount, แขวง ดุสิต เขตดุสิต, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'totalDiscount, แขวง ดุสิต เขตดุสิต, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, NULL, 200.00, 'H1-SO25680725-00032', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:41:31', 186.92, 13.08, 200.00, 0),
(163, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'discount, แขวง เทพารักษ์ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'discount, แขวง เทพารักษ์ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, '200', 0.00, 'H1-SO25680725-00033', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:46:08', 186.92, 13.08, 200.00, 0),
(164, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'discount_qty,, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'discount_qty,, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '', '', NULL, NULL, '0', 200.00, 'H1-SO25680725-00034', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 15:48:49', 186.92, 13.08, 200.00, 0),
(165, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง บางขุนพรหม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '0', '', NULL, NULL, '0', 200.00, 'H1-SO25680725-00036', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 16:01:01', 186.92, 13.08, 200.00, 0),
(166, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง บ้านพานถม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง บ้านพานถม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680725-00037', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 16:11:21', 981.31, 68.69, 1050.00, 0),
(167, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'สตึก, แขวง สตึก สตึก, บุรีรัมย์, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'สตึก, แขวง สตึก สตึก, บุรีรัมย์, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680725-00038', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 16:20:00', 981.31, 68.69, 1050.00, 0),
(168, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680725-00039', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 16:39:26', 981.31, 68.69, 1050.00, 0),
(169, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง ศาลเจ้าพ่อเสือ เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง ศาลเจ้าพ่อเสือ เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680725-00040', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 20:47:55', 981.31, 68.69, 1050.00, 0),
(170, 'H1-SO25680725', '2025-07-25', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง ปากน้ำ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง ปากน้ำ เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', '-', NULL, '2025-07-25', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680725-00041', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-25 21:00:03', 981.31, 68.69, 1050.00, 0),
(171, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง วังบูรพาภิรมย์ เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง วังบูรพาภิรมย์ เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 06:58:11', 981.31, 68.69, 1050.00, 0),
(172, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'pro_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'pro_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00002', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 06:59:30', 981.31, 68.69, 1050.00, 0),
(173, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'pro_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'pro_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00003', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 06:59:55', 981.31, 68.69, 1050.00, 0),
(174, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'pro_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'pro_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00004', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 07:00:54', 981.31, 68.69, 1050.00, 0),
(175, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'pro_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'pro_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00005', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 07:01:06', 981.31, 68.69, 1050.00, 0),
(176, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'asdadas, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'asdadas, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00006', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 07:01:42', 981.31, 68.69, 1050.00, 0),
(177, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'asdadas, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'asdadas, แขวง บ้านระกาศ บางบ่อ, สมุทรปราการ, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00007', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 07:11:07', 981.31, 68.69, 1050.00, 0),
(178, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00008', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 08:15:59', 981.31, 68.69, 1050.00, 0),
(179, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'pro_sku_price_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'pro_sku_price_id, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '', NULL, NULL, '0', 1050.00, 'H1-SO25680726-00009', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 08:17:52', 981.31, 68.69, 1050.00, 0),
(180, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', 'ไปรษณีย์', '0', '0', NULL, NULL, '0', 13500.00, 'H1-SO25680726-00034', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 09:17:29', 12616.82, 883.18, 13500.00, 0),
(181, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง พระบรมมหาราชวัง เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '0', NULL, NULL, '0', 4200.00, 'H1-SO25680726-00021', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 09:38:07', 3925.23, 274.77, 4200.00, 0),
(182, 'H1-SO25680726', '2025-07-26', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง วังบูรพาภิรมย์ เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง วังบูรพาภิรมย์ เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-26', '-', '', '0', '0', NULL, NULL, '0', 4200.00, 'H1-SO25680726-00019', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-26 09:41:00', 3925.23, 274.77, 4200.00, 0),
(183, 'H1-SO25680727', '2025-07-27', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง วัดสามพระยา เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง วัดสามพระยา เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-27', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680727-00001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-27 17:24:30', 3925.23, 274.77, 4200.00, 0),
(184, 'H1-SO25680727', '2025-07-27', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง วัดสามพระยา เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง วัดสามพระยา เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-27', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680727-00002', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-27 17:28:34', 3925.23, 274.77, 4200.00, 0),
(185, 'H1-SO25680727', '2025-07-27', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง วังบูรพาภิรมย์ เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง วังบูรพาภิรมย์ เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-27', '-', '', '0', '', NULL, NULL, '0', 3450.00, 'H1-SO25680727-00003', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-27 17:43:11', 3224.30, 225.70, 3450.00, 0),
(186, 'H1-SO25680727', '2025-07-27', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง บางโปรง เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง บางโปรง เมืองสมุทรปราการ, สมุทรปราการ, เบอร์โทร: 0638606865', '-', NULL, '2025-07-27', '-', '', '0', '0', NULL, NULL, '0', 4200.00, 'H1-SO25680727-00005', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-27 17:52:00', 3925.23, 274.77, 4200.00, 0),
(187, 'H1-SO25680727', '2025-07-27', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'test, แขวง ชนะสงคราม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'test, แขวง ชนะสงคราม เขตพระนคร, กรุงเทพมหานคร, เบอร์โทร: 0638606865', '-', NULL, '2025-07-27', '-', 'ไปรษณีย์', '0', '0', NULL, NULL, '0', 4050.00, 'H1-SO25680727-00058', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-27 19:55:05', 3785.05, 264.95, 4050.00, 0),
(188, 'H1-SO25680729', '2025-07-29', '-', '-', '-', 'คุณ โสภา ประจวบสุข (S02)', 'C03290', '0851195429', '-', '99, แขวง จักรวรรดิ เขตสัมพันธวงศ์, กรุงเทพมหานคร, เบอร์โทร: 0851195429', 'คุณ โสภา ประจวบสุข (S02)', '0851195429', '-', '99, แขวง จักรวรรดิ เขตสัมพันธวงศ์, กรุงเทพมหานคร, เบอร์โทร: 0851195429', '-', NULL, '2025-07-29', '-', '', '100', '0', NULL, NULL, '0', 6300.00, 'H1-SO25680729-00002', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-07-29 09:26:13', 5887.85, 412.15, 6300.00, 0),
(189, 'H1-SO25680730', '2025-07-30', '-', '-', '-', 'คุณ ณัฐพร รัตนอมตกุล', 'C04366', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170,  เบอร์โทร: 0884449959', 'คุณ ณัฐพร รัตนอมตกุล', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170,  เบอร์โทร: 0884449959', '-', NULL, '2025-07-30', '-', 'ไปรษณีย์', '0', '0', NULL, NULL, '0', 4200.00, 'H1-SO25680730-00012', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-07-30 14:36:50', 3925.23, 274.77, 4200.00, 0),
(192, 'H1-SO25680801', '2025-08-01', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-01', '-', '', '0', '', NULL, NULL, '0', 1395.00, 'H1-SO25680801-00001', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-01 10:24:46', 1303.74, 91.26, 1395.00, 0),
(193, 'H1-SO25680801', '2025-08-01', '-', '-', '-', 'คุณ ณัฐพร รัตนอมตกุล', 'C04366', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170 สมอทอง อำเภอท่าชนะ สุราษฎร์ธานี,  เบอร์โทร: 0884449959', 'คุณ ณัฐพร รัตนอมตกุล', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170 สมอทอง อำเภอท่าชนะ สุราษฎร์ธานี,  เบอร์โทร: 0884449959', '-', NULL, '2025-08-01', '-', 'ไปรษณีย์', '0', '3', NULL, NULL, '0', 1398.00, 'H1-SO25680801-00002', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-01 10:30:07', 1306.54, 91.46, 1398.00, 0),
(194, 'H1-SO25680801', '2025-08-01', '-', '-', '-', 'คุณ ณัฐพร รัตนอมตกุล', 'C04366', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170 สมอทอง อำเภอท่าชนะ สุราษฎร์ธานี,  เบอร์โทร: 0884449959', 'คุณ ณัฐพร รัตนอมตกุล', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170 สมอทอง อำเภอท่าชนะ สุราษฎร์ธานี,  เบอร์โทร: 0884449959', '-', NULL, '2025-08-01', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680801-00003', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-01 10:32:57', 3925.23, 274.77, 4200.00, 0),
(195, 'H1-SO25680801', '2025-08-01', '-', '-', '-', 'คุณ ณัฐพร รัตนอมตกุล', 'C04366', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170 สมอทอง อำเภอท่าชนะ สุราษฎร์ธานี,  เบอร์โทร: 0884449959', 'คุณ ณัฐพร รัตนอมตกุล', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170 สมอทอง อำเภอท่าชนะ สุราษฎร์ธานี,  เบอร์โทร: 0884449959', '-', NULL, '2025-08-01', '-', '', '0', '', NULL, NULL, '0', 1395.00, 'H1-SO25680801-00004', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-01 10:35:23', 1303.74, 91.26, 1395.00, 0);
INSERT INTO `sale_order` (`id`, `list_code`, `sell_date`, `reference`, `channel`, `tax_type`, `full_name`, `customer_code`, `phone`, `email`, `address`, `receiver_name`, `receiver_phone`, `receiver_email`, `receiver_address`, `note`, `work_detail`, `delivery_date`, `tracking_no`, `delivery_type`, `total_discount`, `delivery_fee`, `product_qty`, `product_name`, `discount_qty`, `final_total_price`, `document_no`, `is_locked`, `vat_visible`, `status`, `created_at`, `price_before_tax`, `tax_value`, `price_with_tax`, `is_read`) VALUES
(196, 'H1-SO25680802', '2025-08-02', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-02', '-', '', '0', '', NULL, NULL, '0', 3540.00, 'H1-SO25680802-00001', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-02 14:45:12', 3308.41, 231.59, 3540.00, 0),
(197, 'H1-SO25680802', '2025-08-02', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-02', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680802-00002', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-02 15:22:52', 3925.23, 274.77, 4200.00, 0),
(198, 'H1-SO25680802', '2025-08-02', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-02', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680802-00003', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-02 15:30:08', 3925.23, 274.77, 4200.00, 0),
(199, 'H1-SO25680802', '2025-08-02', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-02', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680802-00004', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-02 15:35:24', 3925.23, 274.77, 4200.00, 0),
(200, 'H1-SO25680802', '2025-08-02', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-02', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680802-00005', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-02 15:44:50', 3925.23, 274.77, 4200.00, 0),
(201, 'H1-SO25680802', '2025-08-02', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-02', '-', '', '0', '', NULL, NULL, '0', 8400.00, 'H1-SO25680802-00006', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-02 16:01:17', 7850.47, 549.53, 8400.00, 0),
(202, 'H1-SO25680802', '2025-08-02', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-02', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680802-00007', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-02 16:29:25', 3925.23, 274.77, 4200.00, 0),
(203, 'H1-SO25680802', '2025-08-02', '-', '-', '-', 'คุณ ณัฐพร รัตนอมตกุล', 'C04366', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170 สมอทอง อำเภอท่าชนะ สุราษฎร์ธานี,  เบอร์โทร: 0884449959', 'คุณ ณัฐพร รัตนอมตกุล', '0884449959', '-', '31/1 ม.10 ต.สมอทอง อ.ท่าชนะ จ.สุราษฎร์ธานี 84170 สมอทอง อำเภอท่าชนะ สุราษฎร์ธานี,  เบอร์โทร: 0884449959', '-', NULL, '2025-08-02', '-', '', '0', '', NULL, NULL, '0', 4200.00, 'H1-SO25680802-00008', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-02 16:30:07', 3925.23, 274.77, 4200.00, 0),
(204, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00003', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 17:17:15', 6775.70, 474.30, 7250.00, 0),
(205, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00004', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 17:31:12', 6775.70, 474.30, 7250.00, 0),
(206, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00005', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:20:44', 6775.70, 474.30, 7250.00, 0),
(207, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00006', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:22:45', 6775.70, 474.30, 7250.00, 0),
(208, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00007', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:32:08', 6775.70, 474.30, 7250.00, 0),
(209, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00008', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:32:17', 6775.70, 474.30, 7250.00, 0),
(210, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00009', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:33:09', 6775.70, 474.30, 7250.00, 0),
(211, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00010', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:33:34', 6775.70, 474.30, 7250.00, 0),
(212, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '12, แขวง ลำตะเคียน ผักไห่, พระนครศรีอยุธยา, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '12, แขวง ลำตะเคียน ผักไห่, พระนครศรีอยุธยา, เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00011', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:33:48', 6775.70, 474.30, 7250.00, 0),
(213, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '12, แขวง ลำตะเคียน ผักไห่, พระนครศรีอยุธยา, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '12, แขวง ลำตะเคียน ผักไห่, พระนครศรีอยุธยา, เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00012', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:41:09', 6775.70, 474.30, 7250.00, 0),
(214, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '12, แขวง ลำตะเคียน ผักไห่, พระนครศรีอยุธยา, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '12, แขวง ลำตะเคียน ผักไห่, พระนครศรีอยุธยา, เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00013', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:43:00', 6775.70, 474.30, 7250.00, 0),
(215, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '12, แขวง ลำตะเคียน ผักไห่, พระนครศรีอยุธยา, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '12, แขวง ลำตะเคียน ผักไห่, พระนครศรีอยุธยา, เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00014', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:46:30', 6775.70, 474.30, 7250.00, 0),
(216, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00015', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:46:59', 6775.70, 474.30, 7250.00, 0),
(217, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00016', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:48:42', 6775.70, 474.30, 7250.00, 0),
(218, 'H1-SO25680803', '2025-08-03', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-03', '-', '', '0', '0', NULL, NULL, '0', 7250.00, 'H1-SO25680803-00019', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-03 19:52:14', 6775.70, 474.30, 7250.00, 0),
(219, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '0', NULL, NULL, '0', 4200.00, 'H1-SO25680804-00003', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 13:41:18', 3925.23, 274.77, 4200.00, 0),
(220, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '0', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00012', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 15:20:06', 2990.65, 209.35, 3200.00, 0),
(221, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00013', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:11:44', 2990.65, 209.35, 3200.00, 0),
(222, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00014', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:11:54', 2990.65, 209.35, 3200.00, 0),
(223, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00015', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:18:44', 2990.65, 209.35, 3200.00, 0),
(224, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00016', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:18:47', 2990.65, 209.35, 3200.00, 0),
(225, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00017', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:23:34', 2990.65, 209.35, 3200.00, 1),
(226, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00018', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:23:52', 2990.65, 209.35, 3200.00, 1),
(227, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00019', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:25:36', 2990.65, 209.35, 3200.00, 0),
(228, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', 'ดกดฟ, แขวง ต้นตาล เสาไห้, สระบุรี, เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', 'ดกดฟ, แขวง ต้นตาล เสาไห้, สระบุรี, เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00020', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:25:55', 2990.65, 209.35, 3200.00, 0),
(229, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3520.00, 'H1-SO25680804-00021', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:29:31', 3289.72, 230.28, 3520.00, 0),
(230, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3520.00, 'H1-SO25680804-00022', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:33:47', 3289.72, 230.28, 3520.00, 1),
(231, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00023', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:34:13', 2990.65, 209.35, 3200.00, 1),
(232, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00024', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:42:33', 2990.65, 209.35, 3200.00, 1),
(233, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00025', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:47:51', 2990.65, 209.35, 3200.00, 1),
(234, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00026', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:50:48', 2990.65, 209.35, 3200.00, 1),
(235, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00027', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:50:54', 2990.65, 209.35, 3200.00, 1),
(236, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '', NULL, NULL, '0', 3200.00, 'H1-SO25680804-00028', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-04 16:52:33', 2990.65, 209.35, 3200.00, 1),
(237, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '0', NULL, NULL, '0', 44894.00, 'H1-SO25680804-00035', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-04 16:53:43', 41957.01, 2936.99, 44894.00, 1),
(238, 'H1-SO25680804', '2025-08-04', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', '-', NULL, '2025-08-04', '-', '', '0', '0', NULL, NULL, '0', 8040.00, 'H1-SO25680804-00034', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-04 16:58:49', 7514.02, 525.98, 8040.00, 1),
(239, 'H1-SO25680808', '2025-08-08', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240', '-', '-', '2025-08-08', '-', 'ไปรษณีย์', '1500', '0', NULL, NULL, '0', 34500.00, 'H1-SO25680808-00012', 0, 1, 'ตรวจสอบเรียบร้อย', '2025-08-08 13:39:25', 32242.99, 2257.01, 34500.00, 1),
(240, 'H1-SO25680808', '2025-08-08', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0638606865', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240', '-', '-', '2025-08-08', '-', 'ไปรษณีย์', '500', '0', NULL, NULL, '0', 13000.00, 'H1-SO25680808-00013', 0, 1, 'ตรวจสอบเรียบร้อย', '2025-08-08 13:45:18', 12149.53, 850.47, 13000.00, 1),
(241, 'H1-SO25680809', '2025-08-09', '-', '-', '-', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', 'AP00025202', '0629352962', '-', '11 ซอยราษฎร์พัฒนา 16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0629352962', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', '0629352962', '-', '11 ซอยราษฎร์พัฒนา 16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240,  เบอร์โทร: 0629352962', '-', '-', '2025-08-09', '-', 'ไปรษณีย์', '0', '', NULL, NULL, '0', 2250.00, 'H1-SO25680809-00001', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-09 08:20:40', 2102.80, 147.20, 2250.00, 1),
(242, 'H1-SO25680809', '2025-08-09', '-', '-', '-', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', 'AP00025202', '0629352962', '-', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5,  เบอร์โทร: 0629352962', 'คุณ วรยุทธ์ พังแก้ว (แผนกขาย)', '0629352962', '-', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5,  เบอร์โทร: 0629352962', '-', '-', '2025-08-09', '-', 'ไปรษณีย์', '1000', '', NULL, NULL, '0', 15800.00, 'H1-SO25680809-00002', 0, 0, 'ตรวจสอบเรียบร้อย', '2025-08-09 08:28:23', 14766.36, 1033.64, 15800.00, 1),
(243, 'H1-SO25680809', '2025-08-09', '-', '-', '-', 'คุณ วันเพ็ญ (จัดซื้อ) / ฝากขาย', 'C05935', '0802954156', '--', 'อาคาร ทรู ทาวเวอร์ เลขที่ 18 ถ.รัชดาภิเษก', 'คุณ วันเพ็ญ (จัดซื้อ) / ฝากขาย', '0802954156', '-', 'อาคาร ทรู ทาวเวอร์ เลขที่ 18 ถ.รัชดาภิเษก', '-', '-', '2025-08-09', '-', 'ไปรษณีย์', '0', '0', NULL, NULL, '0', 885.00, 'H1-SO25680809-00017', 0, 0, 'ยังไม่ได้ตรวจสอบ', '2025-08-09 16:48:36', 827.10, 57.90, 885.00, 1),
(244, 'H1-SO25680811', '2025-08-11', '-', '-', '-', 'คุณสุริยพงษ์ ศรีละพันธ์', 'C03917', '0979319477', '-', '143 ม.10 ต.เมืองจันทร์ อ.เมืองจันทร์ จ.ศรีสะเกษ 33120,  เบอร์โทร: 0979319477', 'คุณสุริยพงษ์ ศรีละพันธ์', '0979319477', '-', '143 ม.10 ต.เมืองจันทร์ อ.เมืองจันทร์ จ.ศรีสะเกษ 33120,  เบอร์โทร: 0979319477', '-', '-', '2025-08-11', '-', 'ไปรษณีย์', '0', '0', NULL, NULL, '0', 5400.00, 'H1-SO25680811-00003', 0, 1, 'ยังไม่ได้ตรวจสอบ', '2025-08-11 10:56:28', 5046.73, 353.27, 5400.00, 1),
(245, 'H1-SO25680811', '2025-08-11', '-', '-', '-', 'อภิวัฒน์ ปัญจรัตน์ (IT)', 'AP00111913', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240', 'อภิวัฒน์ ปัญจรัตน์ (IT)', '0638606865', '-', '11 ซอยราษฏร์พัฒนา16 แขวงราษฎร์พัฒนา เขตสะพานสูง กรุงเทพฯ 10240', '-', '-', '2025-08-11', '-', 'ไปรษณีย์', '500', '', NULL, NULL, '0', 6580.00, 'H1-SO25680811-00004', 0, 1, 'ยังไม่ได้ตรวจสอบ', '2025-08-11 11:29:11', 6149.53, 430.47, 6580.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sale_order_gifts`
--

CREATE TABLE `sale_order_gifts` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `pro_sn` varchar(50) NOT NULL,
  `pro_goods_sku_text` varchar(255) DEFAULT NULL COMMENT 'color // สี',
  `title` varchar(255) NOT NULL,
  `pro_goods_num` int(11) NOT NULL,
  `stock` int(255) NOT NULL,
  `pro_image` text DEFAULT NULL,
  `ML_Note` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `pro_activity_id` int(11) DEFAULT NULL,
  `activity_id` int(255) NOT NULL,
  `pro_goods_id` int(11) DEFAULT NULL,
  `st` tinyint(1) NOT NULL,
  `pro_sku_price_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_order_gifts`
--

INSERT INTO `sale_order_gifts` (`id`, `order_id`, `pro_sn`, `pro_goods_sku_text`, `title`, `pro_goods_num`, `stock`, `pro_image`, `ML_Note`, `note`, `pro_activity_id`, `activity_id`, `pro_goods_id`, `st`, `pro_sku_price_id`, `user_id`, `item_id`) VALUES
(70, 87, '', '', 'อะแดปเตอร์ AU-51 (12W)', 40, 0, '/uploads/20240525/45fbaef9d8021f506de91f9b14ab5d23.webp', 'zengsopng_day', 'ของแถม', 1490, 0, 10936, 0, 46249, 11913, NULL),
(71, 88, '', '', 'อะแดปเตอร์ AU-51 (12W)', 3, 0, '/uploads/20240525/45fbaef9d8021f506de91f9b14ab5d23.webp', 'zengsopng_day', 'ของแถม', 1491, 0, 10936, 0, 46249, 11913, NULL),
(72, 112, '', '', 'อะแดปเตอร์เซ็ต QMAX AU-50 2A', 6, 0, '/uploads/20250628/d28fb2522ea4fe0b5363b024c4952162.jpg', 'zengsopng_day', 'ของแถม', 1494, 0, 12821, 0, 49235, 40, NULL),
(73, 116, '', '', 'ชุดกาพ่นสี AJ SG-001', 4, 0, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 0, 13308, 0, 50318, 11913, NULL),
(74, 117, '', '', 'ลำโพงบลูทูธ M-22', 2, 0, '/uploads/20250614/6fb51ca48959e8bfcc71a946d89fdc28.jpg', 'zengsopng_day', 'ของแถม', 1505, 0, 303, 0, 1201, 40, NULL),
(75, 118, '', '', 'ลำโพงบลูทูธ M-22', 2, 0, '/uploads/20250614/6fb51ca48959e8bfcc71a946d89fdc28.jpg', 'zengsopng_day', 'ของแถม', 1505, 0, 303, 0, 1201, 40, NULL),
(76, 119, '', '', 'เตารีดแห้ง AJ IR013', 4, 0, '/uploads/20240912/ad8a35e8fc4ce95a9c5999d3cbc826bd.webp', 'zengsopng_month', 'ของแถม', 1498, 0, 13810, 0, 50915, 11913, NULL),
(77, 119, '', '', 'อะแดปเตอร์ AU-51 (12W)', 16, 0, '/uploads/20240525/45fbaef9d8021f506de91f9b14ab5d23.webp', 'zengsopng_day', 'ของแถม', 1501, 0, 11169, 0, 46581, 11913, NULL),
(78, 122, '', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 3, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 775, NULL),
(79, 123, '', '', 'USB UB-11  [2.4A]', 5, 0, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1496, 0, 482, 0, 1948, 1008, NULL),
(80, 124, '', '', 'หม้อหุงข้าว AJ A102T', 1, 0, '/uploads/20240608/a95fbe53952ab3be9ce791b7652e8dc1.webp', 'zengsopng_month', 'ของแถม', 1371, 0, 13687, 0, 50716, 1687, NULL),
(81, 125, '', '', 'หม้อหุงข้าว AJ A102T', 1, 0, '/uploads/20240608/a95fbe53952ab3be9ce791b7652e8dc1.webp', 'zengsopng_month', 'ของแถม', 1371, 0, 13687, 0, 50716, 23, NULL),
(82, 132, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 0, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1496, 0, 482, 0, 1948, 11913, NULL),
(83, 133, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 0, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1496, 0, 482, 0, 1948, 11913, NULL),
(84, 134, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(85, 135, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(86, 136, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(87, 137, '2030101AJ0003', '', 'หม้อหุงข้าว AJ A102T', 1, 0, '/uploads/20240608/a95fbe53952ab3be9ce791b7652e8dc1.webp', 'zengsopng_month', 'ของแถม', 1371, 0, 13687, 0, 50716, 11913, NULL),
(88, 138, '2020103DP0014', '', 'ทีวีดิจิตอล 24นิ้ว PRISMA DLE-2401DT', 1, 0, '/uploads/20240316/da98245e8146e6d4fd59b93ea3cbc3b6.webp', 'zengsopng_day', 'ของแถม', 1508, 0, 1562, 0, 3641, 11913, NULL),
(89, 139, '2010307DP0097', '', 'พาวเวอร์แบงค์ GC106 (2A)', 3, 0, '/uploads/20240924/61e0c48595ce6a40018cba42634af57e.webp', 'zengsopng_month', 'ของแถม', 1497, 0, 13833, 0, 50940, 40, NULL),
(90, 140, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 0, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1496, 0, 482, 0, 1948, 40, NULL),
(91, 140, '2020103DP0014', '', 'ทีวีดิจิตอล 24นิ้ว PRISMA DLE-2401DT', 1, 0, '/uploads/20240316/da98245e8146e6d4fd59b93ea3cbc3b6.webp', 'zengsopng_day', 'ของแถม', 1508, 0, 1562, 0, 3641, 40, NULL),
(92, 141, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 0, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1496, 0, 482, 0, 1948, 11913, NULL),
(93, 141, '2020103DP0014', '', 'ทีวีดิจิตอล 24นิ้ว PRISMA DLE-2401DT', 1, 0, '/uploads/20240316/da98245e8146e6d4fd59b93ea3cbc3b6.webp', 'zengsopng_day', 'ของแถม', 1508, 0, 1562, 0, 3641, 11913, NULL),
(94, 142, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(95, 143, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(96, 144, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 0, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1496, 0, 482, 0, 1948, 11913, NULL),
(97, 148, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(98, 149, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(99, 150, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(100, 166, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(101, 167, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(102, 168, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(103, 169, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(104, 170, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(105, 177, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(106, 178, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(107, 179, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(109, 181, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(110, 182, '2010101DP0085', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 1, 0, '/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'zengsopng_day', 'ของแถม', 1509, 0, 13799, 0, 50896, 11913, NULL),
(113, 180, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 0, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 0, 13308, 0, 50318, 11913, NULL),
(114, 184, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 0, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 0, 13308, 0, 50318, 11913, NULL),
(115, 186, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 0, 13308, 1, 50318, 11913, NULL),
(127, 187, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(128, 188, '2010307DP0097', '', 'พาวเวอร์แบงค์ GC106 (2A)', 3, 9133, '/uploads/20240924/61e0c48595ce6a40018cba42634af57e.webp', 'zengsopng_month', 'ของแถม', 1497, 1497, 13833, 0, 50940, 40, NULL),
(129, 189, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 1008, NULL),
(130, 194, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 1008, NULL),
(131, 196, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17944, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 1513, 482, 0, 1948, 11913, NULL),
(132, 197, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(133, 198, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(134, 199, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(135, 200, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17894, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 1513, 482, 0, 1948, 11913, NULL),
(136, 202, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(137, 203, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 1008, NULL),
(138, 204, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17890, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 1513, 482, 0, 1948, 11913, NULL),
(139, 204, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(140, 205, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17890, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 1513, 482, 0, 1948, 11913, NULL),
(141, 205, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(142, 206, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17890, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 1513, 482, 0, 1948, 11913, NULL),
(143, 206, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(144, 218, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17890, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1948, 11913, NULL),
(145, 218, '2010202DP0004', '', 'USB UB-11  [2.4A]', 5, 304, '/uploads/20230717/0713fbaad30b2b1391867ae389eac833.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1949, 11913, NULL),
(146, 218, '2010203DP0005', '', 'USB UB-11  [2.4A]', 5, 6183, '/uploads/20230717/26c4a2bb7929c9442e8594542448bc09.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1950, 11913, NULL),
(147, 218, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 0, 13308, 1, 50318, 11913, NULL),
(148, 219, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 0, 13308, 1, 50318, 11913, NULL),
(152, 220, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17826, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1948, 11913, NULL),
(153, 220, '2010202DP0004', '', 'USB UB-11  [2.4A]', 5, 264, '/uploads/20230717/0713fbaad30b2b1391867ae389eac833.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1949, 11913, NULL),
(154, 220, '2010203DP0005', '', 'USB UB-11  [2.4A]', 5, 6134, '/uploads/20230717/26c4a2bb7929c9442e8594542448bc09.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1950, 11913, NULL),
(155, 232, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17826, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1948, 11913, NULL),
(156, 232, '2010202DP0004', '', 'USB UB-11  [2.4A]', 5, 264, '/uploads/20230717/0713fbaad30b2b1391867ae389eac833.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1949, 11913, NULL),
(157, 232, '2010203DP0005', '', 'USB UB-11  [2.4A]', 5, 6134, '/uploads/20230717/26c4a2bb7929c9442e8594542448bc09.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1950, 11913, NULL),
(158, 234, '2010201DP0002', NULL, 'USB UB-11  [2.4A]', 5, 17826, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1948, 11913, NULL),
(159, 234, '2010202DP0004', NULL, 'USB UB-11  [2.4A]', 5, 264, '/uploads/20230717/0713fbaad30b2b1391867ae389eac833.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1949, 11913, NULL),
(160, 234, '2010203DP0005', NULL, 'USB UB-11  [2.4A]', 5, 6134, '/uploads/20230717/26c4a2bb7929c9442e8594542448bc09.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1950, 11913, NULL),
(161, 235, '2010201DP0002', NULL, 'USB UB-11  [2.4A]', 5, 17826, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1948, 11913, NULL),
(162, 235, '2010202DP0004', NULL, 'USB UB-11  [2.4A]', 5, 264, '/uploads/20230717/0713fbaad30b2b1391867ae389eac833.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1949, 11913, NULL),
(163, 235, '2010203DP0005', NULL, 'USB UB-11  [2.4A]', 5, 6134, '/uploads/20230717/26c4a2bb7929c9442e8594542448bc09.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1950, 11913, NULL),
(164, 236, '2010201DP0002', '', 'USB UB-11  [2.4A]', 5, 17826, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1948, 11913, NULL),
(165, 236, '2010202DP0004', '', 'USB UB-11  [2.4A]', 5, 264, '/uploads/20230717/0713fbaad30b2b1391867ae389eac833.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1949, 11913, NULL),
(166, 236, '2010203DP0005', '', 'USB UB-11  [2.4A]', 5, 6134, '/uploads/20230717/26c4a2bb7929c9442e8594542448bc09.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1950, 11913, NULL),
(170, 238, '2010201DP0002', 'Micro', 'USB UB-11  [2.4A]', 5, 17826, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1948, 11913, NULL),
(171, 238, '2010202DP0004', 'Lightning', 'USB UB-11  [2.4A]', 5, 264, '/uploads/20230717/0713fbaad30b2b1391867ae389eac833.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1949, 11913, NULL),
(172, 238, '2010203DP0005', 'Type-C', 'USB UB-11  [2.4A]', 5, 6134, '/uploads/20230717/26c4a2bb7929c9442e8594542448bc09.webp', 'zengsopng_month', 'ของแถม', 1513, 0, 482, 0, 1950, 11913, NULL),
(173, 238, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(174, 237, '2010307DP0097', 'WHITE', 'พาวเวอร์แบงค์ GC106 (2A)', 12, 9038, '/uploads/20240924/61e0c48595ce6a40018cba42634af57e.webp', 'zengsopng_month', 'ของแถม', 1514, 1514, 13833, 0, 50940, 11913, NULL),
(175, 237, '2030903AJ0001', '', 'ชุดกาพ่นสี AJ SG-001', 1, 412, '/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'zengsopng_day', 'ของแถม', 1316, 1316, 13308, 1, 50318, 11913, NULL),
(176, 242, '2020101DP0069', 'BLACK', 'ลำโพงบลูทูธ Mello (20W) DP', 1, 1858, '/uploads/20241223/147e0cb81255609c2511c62e4b176eda.webp', 'zengsopng_month', 'ของแถม', 1522, 0, 13904, 0, 51060, 23, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_order_items`
--

CREATE TABLE `sale_order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `pro_id` int(11) NOT NULL,
  `sn` varchar(50) DEFAULT NULL,
  `pro_name` varchar(255) DEFAULT NULL,
  `pro_goods_sku_text` varchar(255) DEFAULT NULL COMMENT 'color // สี',
  `pro_title` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `stock` int(255) NOT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(16,2) NOT NULL,
  `pro_images` text DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `pro_activity_id` int(11) DEFAULT NULL,
  `activity_id` int(11) DEFAULT NULL,
  `st` tinyint(1) NOT NULL,
  `pro_goods_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_order_items`
--

INSERT INTO `sale_order_items` (`id`, `order_id`, `pro_id`, `sn`, `pro_name`, `pro_goods_sku_text`, `pro_title`, `qty`, `stock`, `unit_price`, `discount`, `total_price`, `pro_images`, `unit`, `item_id`, `pro_activity_id`, `activity_id`, `st`, `pro_goods_id`) VALUES
(403, 87, 46249, '2010101DP0072', 'อะแดปเตอร์ AP-21 (20W)', '', NULL, 50, 0, 145.00, 0.00, 7250.00, 'https://tgsc.qifudaren.net/uploads/20240605/29264222c63c4987c565253fd181a52d.webp', '', NULL, 1490, NULL, 0, NULL),
(405, 87, 46510, '2010903DP0001', 'BT-G01 แว่นกันแดดบลูทูธ', '', NULL, 50, 0, 225.00, 0.00, 11250.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', '', NULL, 1175, NULL, 0, NULL),
(406, 88, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(407, 88, 46249, '2010101DP0072', 'อะแดปเตอร์ AP-21 (20W)', '', NULL, 5, 0, 145.00, 0.00, 725.00, 'https://tgsc.qifudaren.net/uploads/20240605/29264222c63c4987c565253fd181a52d.webp', '', NULL, 1491, NULL, 0, NULL),
(408, 89, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(409, 89, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(410, 90, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(411, 90, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(412, 91, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(413, 91, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(414, 92, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(415, 92, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(416, 93, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(417, 93, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(418, 94, 123, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(419, 94, 123, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(420, 95, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 4567, NULL, 0, NULL),
(421, 96, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 4567, NULL, 0, NULL),
(422, 96, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 4567, NULL, 0, NULL),
(423, 97, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 4567, NULL, 0, NULL),
(424, 97, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 4567, NULL, 0, NULL),
(425, 98, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(426, 98, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(427, 99, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(428, 99, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(429, 100, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(430, 100, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(431, 101, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, NULL, NULL, 0, NULL),
(432, 101, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(433, 102, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(434, 102, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(435, 103, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(436, 104, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(437, 105, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(438, 106, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(439, 106, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 5, 0, 150.00, 0.00, 750.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(445, 107, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 295.00, 0.00, 295.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', '', NULL, 0, NULL, 0, NULL),
(447, 107, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(448, 108, 45118, '2010106DP0003', 'แท่นชาร์จไร้สาย WC-X01', '', NULL, 1, 0, 630.00, 0.00, 630.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(449, 108, 45118, '2010106DP0003', 'แท่นชาร์จไร้สาย WC-X01', '', NULL, 2, 0, 250.00, 0.00, 500.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(482, 109, 3156, '2010304DP0001', 'พาวเวอร์แบงค์ S28 ( PD20W 5200mAh )', '', NULL, 50, 0, 250.00, 0.00, 12500.00, 'https://tgsc.qifudaren.net/uploads/20230715/393b3d7b296bf5e55a101809ee591024.webp', '', NULL, 1377, NULL, 0, NULL),
(483, 109, 3153, '2010304DP0001', 'พาวเวอร์แบงค์ S28 ( PD20W 5200mAh )', '', NULL, 5, 0, 250.00, 0.00, 1250.00, 'https://tgsc.qifudaren.net/uploads/20230715/393b3d7b296bf5e55a101809ee591024.webp', '', NULL, 1378, NULL, 0, NULL),
(484, 109, 50995, '2010310QM0001', 'พาวเวอร์แบงค์ QMAX B19 (15000mAh)', '', NULL, 1, 0, 550.00, 0.00, 550.00, 'https://tgsc.qifudaren.net/uploads/20241112/4c763be7e2722e9cb9668a24ef35e461.webp', '', NULL, 1379, NULL, 0, NULL),
(485, 109, 50996, '2010310QM0001', 'พาวเวอร์แบงค์ QMAX B19 (15000mAh)', '', NULL, 4, 0, 550.00, 0.00, 2200.00, 'https://tgsc.qifudaren.net/uploads/20241112/ae53ed8ef90457ec6224b910180fd87b.webp', '', NULL, 1379, NULL, 0, NULL),
(486, 109, 46317, '2020102DP0020', 'ลำโพงบลูทูธ M79', '', NULL, 10, 0, 210.00, 0.00, 2100.00, 'https://tgsc.qifudaren.net/uploads/20250614/a43caa639273d68e526b9e54109bb307.jpg', 'PCS', NULL, 1382, NULL, 0, NULL),
(487, 109, 44801, '2020111DP0153', 'ลำโพงบลูทูธ DP-S03', '', NULL, 1, 0, 330.00, 0.00, 330.00, 'https://tgsc.qifudaren.net/uploads/20231111/8c5689c9c4841480493308a4d5a5f4cc.webp', 'PCS', NULL, 1383, NULL, 0, NULL),
(488, 109, 46469, '2010403DP0045', 'หูฟังบลูทูธแบบครอบหู HP-33', '', NULL, 1, 0, 250.00, 0.00, 250.00, 'https://tgsc.qifudaren.net/uploads/20240222/97299f4a7e76966a741381ae2031e8de.webp', 'PCS', NULL, 1385, NULL, 0, NULL),
(489, 109, 46470, '2010403DP0045', 'หูฟังบลูทูธแบบครอบหู HP-33', '', NULL, 20, 0, 250.00, 0.00, 5000.00, 'https://tgsc.qifudaren.net/uploads/20240222/81fc46b323e3e87ae2ed62791523ddd8.webp', 'PCS', NULL, 1385, NULL, 0, NULL),
(490, 110, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 50, 0, 150.00, 0.00, 7500.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(491, 110, 45120, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 50, 0, 150.00, 0.00, 7500.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(492, 110, 45118, '2010106DP0003', 'แท่นชาร์จไร้สาย WC-X01', '', NULL, 50, 0, 250.00, 0.00, 12500.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(493, 110, 45122, '2010106DP0006', 'แท่นชาร์จไร้สาย WC-X02', '', NULL, 50, 0, 160.00, 0.00, 8000.00, 'https://tgsc.qifudaren.net/uploads/20231124/b1321e5cc4ea4f1bffa5454898f910c7.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(494, 110, 1396, '2010701DP0002', 'สายแปลง 2in1 C2C', '', NULL, 47, 0, 55.00, 0.00, 2585.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 1173, NULL, 0, NULL),
(495, 111, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(496, 111, 45118, '2010106DP0003', 'แท่นชาร์จไร้สาย WC-X01', '', NULL, 2, 0, 250.00, 0.00, 500.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(497, 112, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 10, 0, 150.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', '', NULL, 1170, NULL, 0, NULL),
(498, 112, 45120, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 10, 0, 150.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', '', NULL, 1170, NULL, 0, NULL),
(499, 112, 46806, '2010402DP0047', 'หูฟังบลูทูธ BT-23', '', NULL, 10, 0, 190.00, 0.00, 1900.00, 'https://tgsc.qifudaren.net/uploads/20240316/cf780ba408bf1548ed621cf40426c932.webp', '', NULL, 1215, NULL, 0, NULL),
(500, 112, 46807, '2010402DP0047', 'หูฟังบลูทูธ BT-23', '', NULL, 10, 0, 190.00, 0.00, 1900.00, 'https://tgsc.qifudaren.net/uploads/20240316/0b298614389a0aafeaa6f288da47939c.webp', '', NULL, 1215, NULL, 0, NULL),
(501, 112, 46808, '2010402DP0047', 'หูฟังบลูทูธ BT-23', '', NULL, 10, 0, 190.00, 0.00, 1900.00, 'https://tgsc.qifudaren.net/uploads/20240316/3e4f6f26baa6ae95abbc68937ee76c0c.webp', '', NULL, 1215, NULL, 0, NULL),
(502, 112, 49235, '2010101DP0073', 'อะแดปเตอร์ APP-25 (25W)', '', NULL, 10, 0, 190.00, 0.00, 1900.00, 'https://tgsc.qifudaren.net/uploads/20240509/16c6c5b801a14a03fead28a4e8e67f57.webp', '', NULL, 1494, NULL, 0, NULL),
(503, 112, 50978, '2020103DP0025', 'ลำโพงบลูทูธ MAXWELL', '', NULL, 4, 0, 750.00, 0.00, 3000.00, 'https://tgsc.qifudaren.net/uploads/20241108/190249b7a00a9f93ff250c59206ee8d2.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(504, 112, 50979, '2020103DP0025', 'ลำโพงบลูทูธ MAXWELL', '', NULL, 3, 0, 750.00, 0.00, 2250.00, 'https://tgsc.qifudaren.net/uploads/20241108/87b2bc69028e57e9f9f8ff536fb9bdf2.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(505, 112, 50945, '2020101DP0066', 'ลำโพงบลูทูธพกพา MS-01', '', NULL, 10, 0, 200.00, 0.00, 2000.00, 'https://tgsc.qifudaren.net/uploads/20240927/b44514b1aa0408ba7434df7b91c67ffa.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(506, 112, 50946, '2020101DP0066', 'ลำโพงบลูทูธพกพา MS-01', '', NULL, 10, 0, 200.00, 0.00, 2000.00, 'https://tgsc.qifudaren.net/uploads/20240927/3067fdeec2ac8aac7e78173e5c76d378.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(507, 112, 50947, '2020101DP0066', 'ลำโพงบลูทูธพกพา MS-01', '', NULL, 10, 0, 200.00, 0.00, 2000.00, 'https://tgsc.qifudaren.net/uploads/20240927/239b970ff28ec37af03ca6d2b888491e.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(508, 113, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 40, 0, 150.00, 0.00, 6000.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(509, 113, 45122, '2010106DP0006', 'แท่นชาร์จไร้สาย WC-X02', '', NULL, 50, 0, 160.00, 0.00, 8000.00, 'https://tgsc.qifudaren.net/uploads/20231124/b1321e5cc4ea4f1bffa5454898f910c7.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(510, 114, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 50, 0, 150.00, 0.00, 7500.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(511, 114, 1396, '2010701DP0002', 'สายแปลง 2in1 C2C', '', NULL, 50, 0, 55.00, 0.00, 2750.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 1173, NULL, 0, NULL),
(512, 115, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 20, 0, 150.00, 0.00, 3000.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(513, 115, 1396, '2010701DP0002', 'สายแปลง 2in1 C2C', '', NULL, 20, 0, 55.00, 0.00, 1100.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 1173, NULL, 0, NULL),
(514, 116, 45119, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 20, 0, 150.00, 0.00, 3000.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(515, 116, 45120, '2010106DP0005', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', '', NULL, 1, 0, 150.00, 0.00, 150.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(516, 116, 50318, '2030903AJ0001', 'ชุดกาพ่นสี AJ SG-001', '', NULL, 20, 0, 750.00, 0.00, 15000.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'PCS', NULL, 1316, NULL, 0, NULL),
(517, 116, 50840, '2030801ZZ0006', 'โคมไฟสนามโซล่าเซลล์ 1000 วัตต์ รุ่น QM-F1000W', '', NULL, 20, 0, 650.00, 0.00, 13000.00, 'https://tgsc.qifudaren.net/uploads/20240717/50d867e334bdb2ecb0235289aa81b0c2.webp', 'PCS', NULL, 1317, NULL, 0, NULL),
(518, 116, 50980, '2020201AJ0001', 'ไมโครโฟนไร้สาย AJ รุ่น PM-001 (AJ)', '', NULL, 20, 0, 700.00, 0.00, 14000.00, 'https://tgsc.qifudaren.net/uploads/20241108/2532f170065217e3eae90bab69a2f7fe.webp', 'PCS', NULL, 1318, NULL, 0, NULL),
(519, 116, 3639, '2020105AJ0003', 'ลำโพงบลูทูธ AJ X65 (60W)', '', NULL, 8, 0, 1500.00, 0.00, 12000.00, 'https://tgsc.qifudaren.net/uploads/20230823/aaaa02354f7d56947a9cccf24733632d.webp', 'PCS', NULL, 1319, NULL, 0, NULL),
(520, 116, 3156, '2010304DP0001', 'พาวเวอร์แบงค์ S28 ( PD20W 5200mAh )', '', NULL, 20, 0, 250.00, 0.00, 5000.00, 'https://tgsc.qifudaren.net/uploads/20230715/393b3d7b296bf5e55a101809ee591024.webp', 'PCS', NULL, 1377, NULL, 0, NULL),
(521, 116, 3153, '2010304DP0001', 'พาวเวอร์แบงค์ S28 ( PD20W 5200mAh )', '', NULL, 9, 0, 250.00, 0.00, 2250.00, 'https://tgsc.qifudaren.net/uploads/20230715/393b3d7b296bf5e55a101809ee591024.webp', 'PCS', NULL, 1378, NULL, 0, NULL),
(522, 116, 50995, '2010310QM0001', 'พาวเวอร์แบงค์ QMAX B19 (15000mAh)', '', NULL, 20, 0, 550.00, 0.00, 11000.00, 'https://tgsc.qifudaren.net/uploads/20241112/4c763be7e2722e9cb9668a24ef35e461.webp', 'PCS', NULL, 1379, NULL, 0, NULL),
(523, 117, 1414, '2020105DP0004', 'SPEAKER BLUETOOTH K52-S MIC (CARTOON) DP', '', NULL, 1, 0, 2290.00, 0.00, 2290.00, '/uploads/20230919/14529e8058c54ecee90bfa0d512fb595.webp', '', NULL, 0, NULL, 0, NULL),
(524, 117, 2545, '2010202DP0006', 'USB DATA CABLE UB-16P FOR LIGHTNING 3A Black (DP)', '', NULL, 1, 0, 219.00, 0.00, 219.00, '/uploads/20231204/65ca202e6cc2d97384795b0a3a248936.webp', '', NULL, 0, NULL, 0, NULL),
(525, 117, 51209, '2010602DP0049', 'ฟิล์มกระจก iPhone SE2/3 แบบใส', '', NULL, 3, 0, 35.00, 0.00, 105.00, 'https://tgsc.qifudaren.net/uploads/20250607/65b1dc69122750eb1a71fceb759fd2fa.webp', 'PCS', NULL, 1391, NULL, 0, NULL),
(526, 117, 46465, '2010401DP0008', 'หูฟัง AP-03', '', NULL, 5, 0, 195.00, 0.00, 975.00, 'https://tgsc.qifudaren.net/uploads/20240201/eaf550db288e6e947c8b3e70753f6a28.webp', 'PCS', NULL, 1504, NULL, 0, NULL),
(527, 117, 1200, '2020101DP0011', 'ลำโพงบลูทูธ WOODY', '', NULL, 3, 0, 320.00, 0.00, 960.00, 'https://tgsc.qifudaren.net/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', 'PCS', NULL, 1505, NULL, 0, NULL),
(528, 117, 1201, '2020101DP0011', 'ลำโพงบลูทูธ WOODY', '', NULL, 3, 0, 320.00, 0.00, 960.00, 'https://tgsc.qifudaren.net/uploads/20230718/90acb9da1f84adcf6502bd97a2ce419b.webp', 'PCS', NULL, 1505, NULL, 0, NULL),
(541, 118, 1414, '2020105DP0004', 'SPEAKER BLUETOOTH K52-S MIC (CARTOON) DP', '', NULL, 1, 0, 2290.00, 0.00, 2290.00, '/uploads/20230919/14529e8058c54ecee90bfa0d512fb595.webp', '', NULL, 0, NULL, 0, NULL),
(542, 118, 2545, '2010202DP0006', 'USB DATA CABLE UB-16P FOR LIGHTNING 3A Black (DP)', '', NULL, 1, 0, 219.00, 0.00, 219.00, '/uploads/20231204/65ca202e6cc2d97384795b0a3a248936.webp', '', NULL, 0, NULL, 0, NULL),
(543, 118, 51209, '2010602DP0049', 'ฟิล์มกระจก iPhone SE2/3 แบบใส', '', NULL, 3, 0, 35.00, 0.00, 105.00, 'https://tgsc.qifudaren.net/uploads/20250607/65b1dc69122750eb1a71fceb759fd2fa.webp', 'PCS', NULL, 1391, NULL, 0, NULL),
(544, 118, 46465, '2010401DP0008', 'หูฟัง AP-03', '', NULL, 5, 0, 195.00, 0.00, 975.00, 'https://tgsc.qifudaren.net/uploads/20240201/eaf550db288e6e947c8b3e70753f6a28.webp', 'PCS', NULL, 1504, NULL, 0, NULL),
(545, 118, 1200, '2020101DP0011', 'ลำโพงบลูทูธ WOODY', '', NULL, 3, 0, 320.00, 0.00, 960.00, 'https://tgsc.qifudaren.net/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', 'PCS', NULL, 1505, NULL, 0, NULL),
(546, 118, 1201, '2020101DP0011', 'ลำโพงบลูทูธ WOODY', '', NULL, 3, 0, 320.00, 0.00, 960.00, 'https://tgsc.qifudaren.net/uploads/20230718/90acb9da1f84adcf6502bd97a2ce419b.webp', 'PCS', NULL, 1505, NULL, 0, NULL),
(565, 119, 46444, '2020102DP0015', 'SPEAKER BLUETOOTH SOUNDBAR M-22 BLACK (DP)', '', NULL, 39, 0, 220.00, 0.00, 8580.00, 'https://tgsc.qifudaren.net/uploads/20250614/6fb51ca48959e8bfcc71a946d89fdc28.jpg', 'PCS', NULL, 1206, NULL, 0, NULL),
(566, 119, 46581, '2010102DP0060', 'ADAPTER SET PD 20W AP-21 FOR LIGHTNING 1PORT WHITE DP', '', NULL, 20, 0, 215.00, 0.00, 4300.00, 'https://tgsc.qifudaren.net/uploads/20240313/bb9767749405ae275108f9acb7e3f20c.webp', 'PCS', NULL, 1501, NULL, 0, NULL),
(567, 120, 51197, '2010310DP0004', 'POWER BANK B19 PLUS (15000 MAH) BLACK DP', '', NULL, 1, 0, 800.00, 0.00, 800.00, 'https://tgsc.qifudaren.net/uploads/20250425/af601b5b9861038090ead989bf271ef4.webp', 'PCS', NULL, 1503, NULL, 0, NULL),
(568, 120, 51198, '2010310DP0004', 'POWER BANK B19 PLUS (15000 MAH) BLACK DP', '', NULL, 1, 0, 800.00, 0.00, 800.00, 'https://tgsc.qifudaren.net/uploads/20250425/38e8cf9a7e7f8aca9e147e0a6713f0e2.webp', 'PCS', NULL, 1503, NULL, 0, NULL),
(569, 120, 51209, '2010602DP0049', 'Tempered glass film 2.9D Clear iPhone SE2/3 (New)', '', NULL, 1, 0, 59.00, 0.00, 59.00, 'https://tgsc.qifudaren.net/uploads/20250607/65b1dc69122750eb1a71fceb759fd2fa.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(570, 120, 46465, '2010401DP0008', 'SMALL TALK EARPHONE AP-03 WHITE DP', '', NULL, 1, 0, 195.00, 0.00, 195.00, 'https://tgsc.qifudaren.net/uploads/20240201/eaf550db288e6e947c8b3e70753f6a28.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(571, 120, 50716, '2030101AJ0003', 'หม้อหุงข้าว 1 ลิตร  ไม่เคลือบ ฝาบนสแตนเลส AJ รุ่น A102T (AJ)\r\n', '', NULL, 1, 0, 320.00, 0.00, 320.00, 'https://tgsc.qifudaren.net/uploads/20240608/a95fbe53952ab3be9ce791b7652e8dc1.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(572, 120, 46566, '2030104AJ0003', 'กระติกน้ำร้อน 2.5 ลิตร กำลังไฟ 750 วัตต์ รุ่น JP5022 (AJ)', '', NULL, 1, 0, 450.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20241115/ee3e225ae6212de0bd2df76d87526234.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(578, 121, 51209, '2010602DP0049', 'Tempered glass film 2.9D Clear iPhone SE2/3 (New)', '', NULL, 10, 0, 35.00, 0.00, 350.00, 'https://tgsc.qifudaren.net/uploads/20250607/65b1dc69122750eb1a71fceb759fd2fa.webp', 'PCS', NULL, 1391, NULL, 0, NULL),
(579, 121, 51197, '2010310DP0004', 'POWER BANK B19 PLUS (15000 MAH) BLACK DP', '', NULL, 10, 0, 800.00, 0.00, 8000.00, 'https://tgsc.qifudaren.net/uploads/20250425/af601b5b9861038090ead989bf271ef4.webp', 'PCS', NULL, 1503, NULL, 0, NULL),
(580, 121, 51198, '2010310DP0004', 'POWER BANK B19 PLUS (15000 MAH) BLACK DP', '', NULL, 10, 0, 800.00, 0.00, 8000.00, 'https://tgsc.qifudaren.net/uploads/20250425/38e8cf9a7e7f8aca9e147e0a6713f0e2.webp', 'PCS', NULL, 1503, NULL, 0, NULL),
(581, 121, 46465, '2010401DP0008', 'SMALL TALK EARPHONE AP-03 WHITE DP', '', NULL, 10, 0, 195.00, 0.00, 1950.00, 'https://tgsc.qifudaren.net/uploads/20240201/eaf550db288e6e947c8b3e70753f6a28.webp', 'PCS', NULL, 1504, NULL, 0, NULL),
(582, 121, 50716, '2030101AJ0003', 'หม้อหุงข้าว 1 ลิตร  ไม่เคลือบ ฝาบนสแตนเลส AJ รุ่น A102T (AJ)\r\n', '', NULL, 10, 0, 300.00, 0.00, 3000.00, 'https://tgsc.qifudaren.net/uploads/20240608/a95fbe53952ab3be9ce791b7652e8dc1.webp', 'PCS', NULL, 1506, NULL, 0, NULL),
(583, 121, 46566, '2030104AJ0003', 'กระติกน้ำร้อน 2.5 ลิตร กำลังไฟ 750 วัตต์ รุ่น JP5022 (AJ)', '', NULL, 10, 0, 400.00, 0.00, 4000.00, 'https://tgsc.qifudaren.net/uploads/20241115/ee3e225ae6212de0bd2df76d87526234.webp', 'PCS', NULL, 1506, NULL, 0, NULL),
(584, 121, 46616, '2040301880059', 'BAI JIN ผ้านาโนไฟเบอร์อเนกประสงค์  คละสี / BJ-03\r\n', '', NULL, 4, 0, 9.00, 0.00, 36.00, 'https://tgsc.qifudaren.net/uploads/20240205/842610c0900e18e4cd66eef22da598df.webp', 'PCS', NULL, 1237, NULL, 0, NULL),
(585, 122, 49239, '2010101DP0082', 'ADAPTER APP-29 25W White DP', '', NULL, 10, 0, 235.00, 0.00, 2350.00, 'https://tgsc.qifudaren.net/uploads/20240516/9b75332224227508eaa0354fb80daabf.webp', 'PCS', NULL, 1507, NULL, 0, NULL),
(586, 122, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 10, 0, 200.00, 0.00, 2000.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(587, 123, 50978, '2020103DP0025', 'SPEAKER BLUETOOTH MAXWELL BLACK (DP)', '', NULL, 1, 0, 750.00, 0.00, 750.00, 'https://tgsc.qifudaren.net/uploads/20241108/190249b7a00a9f93ff250c59206ee8d2.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(588, 123, 50979, '2020103DP0026', 'SPEAKER BLUETOOTH MAXWELL BROWN (DP)', '', NULL, 1, 0, 750.00, 0.00, 750.00, 'https://tgsc.qifudaren.net/uploads/20241108/87b2bc69028e57e9f9f8ff536fb9bdf2.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(589, 123, 50945, '2020101DP0066', 'SPEAKER BLUETOOTH MS-01 BLACK (DP)', '', NULL, 1, 0, 230.00, 0.00, 230.00, 'https://tgsc.qifudaren.net/uploads/20240927/b44514b1aa0408ba7434df7b91c67ffa.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(590, 123, 50946, '2020101DP0067', 'SPEAKER BLUETOOTH MS-01 DARK BLUE (DP)', '', NULL, 1, 0, 230.00, 0.00, 230.00, 'https://tgsc.qifudaren.net/uploads/20240927/3067fdeec2ac8aac7e78173e5c76d378.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(591, 123, 50947, '2020101DP0068', 'SPEAKER BLUETOOTH MS-01 BEIGE (DP)', '', NULL, 1, 0, 230.00, 0.00, 230.00, 'https://tgsc.qifudaren.net/uploads/20240927/239b970ff28ec37af03ca6d2b888491e.webp', 'PCS', NULL, 1389, NULL, 0, NULL),
(592, 123, 46499, '2010203DP0070', 'USB DATA CABLE CB-X55C FOR TYPE-C BLACK DP', '', NULL, 1, 0, 55.00, 0.00, 55.00, 'https://tgsc.qifudaren.net/uploads/20240712/a1bf64eaee8c4bc5f42c0d3df9314a8c.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(593, 123, 51209, '2010602DP0049', 'Tempered glass film 2.9D Clear iPhone SE2/3 (New)', '', NULL, 1, 0, 59.00, 0.00, 59.00, 'https://tgsc.qifudaren.net/uploads/20250607/65b1dc69122750eb1a71fceb759fd2fa.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(594, 123, 49239, '2010101DP0082', 'ADAPTER APP-29 25W White DP', '', NULL, 1, 0, 235.00, 0.00, 235.00, 'https://tgsc.qifudaren.net/uploads/20240516/9b75332224227508eaa0354fb80daabf.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(595, 123, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 1, 0, 1500.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(596, 123, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 1, 0, 1500.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(597, 124, 46241, '2020102DP0019', 'SPEAKER BLUETOOTH WIRELESS SOUNDBAR M-33 IRON GRAY DP', '', NULL, 10, 0, 200.00, 0.00, 2000.00, 'https://tgsc.qifudaren.net/uploads/20250614/921504d37bea3ac4cb74bbc7e1b8d9e5.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(598, 124, 46243, '2010402DP0035', 'BLUETOOTH HEADSET BT-20 UNIVERSAL SHIBA INU PATTERN (BLACK) DP', '', NULL, 5, 0, 230.00, 0.00, 1150.00, 'https://tgsc.qifudaren.net/uploads/20240115/6a98f8fa21b9cda6991ea0e1ceab6f83.webp', 'PCS', NULL, 1211, NULL, 0, NULL),
(599, 124, 46244, '2010402DP0034', 'BLUETOOTH HEADSET BT-20 UNIVERSAL CAT PATTERN (WHITE) DP', '', NULL, 5, 0, 230.00, 0.00, 1150.00, 'https://tgsc.qifudaren.net/uploads/20240115/129d77b2d9e7dd62d407a7bfbe654b10.webp', 'PCS', NULL, 1211, NULL, 0, NULL),
(600, 124, 50915, '2030303AJ0001', 'เตารีดแห้ง 1000 วัตต์ รุ่น IR013 (AJ)', '', NULL, 11, 0, 235.00, 0.00, 2585.00, 'https://tgsc.qifudaren.net/uploads/20240912/ad8a35e8fc4ce95a9c5999d3cbc826bd.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(601, 124, 50956, '2030202DP0002', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 18 นิ้ว รุ่น JT-189 (DP)', '', NULL, 12, 0, 800.00, 0.00, 9600.00, 'https://tgsc.qifudaren.net/uploads/20241001/2137472b9eb23c26581559c2b2e9991c.webp', 'PCS', NULL, 1312, NULL, 0, NULL),
(602, 125, 45119, '2010106DP0005', 'SMART WIRELESS CARCHARGER GW-05 BLACK DP', '', NULL, 1, 0, 150.00, 0.00, 150.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(603, 125, 45120, '2010106DP0004', 'SMART WIRELESS CARCHARGER GW-05 WHITE DP', '', NULL, 1, 0, 150.00, 0.00, 150.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(604, 125, 46204, '2010103DP0040', 'CAR CHARGER RGB CD-X06 BLACK DP', '', NULL, 1, 0, 280.00, 0.00, 280.00, 'https://tgsc.qifudaren.net/uploads/20231206/4cb6625fb1f87c26f20ff6a732b7df38.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(605, 125, 45118, '2010106DP0003', 'SMART WIRELESS CHARGER 3IN1 (WC-X01) BLACK DP', '', NULL, 1, 0, 630.00, 0.00, 630.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(606, 125, 45122, '2010106DP0006', 'Wireless Charger 15W WC-X02 Black DP', '', NULL, 1, 0, 350.00, 0.00, 350.00, 'https://tgsc.qifudaren.net/uploads/20231124/b1321e5cc4ea4f1bffa5454898f910c7.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(607, 125, 1396, '2010701DP0002', 'ADAPTER CONNECTER C2C TYPE-C AUX 3.5  (SILVER) DP', '', NULL, 1, 0, 100.00, 0.00, 100.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(608, 125, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 1, 0, 80.00, 0.00, 80.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(609, 126, 46204, '2010103DP0040', 'CAR CHARGER RGB CD-X06 BLACK DP', '', NULL, 7, 0, 145.00, 0.00, 1015.00, 'https://tgsc.qifudaren.net/uploads/20231206/4cb6625fb1f87c26f20ff6a732b7df38.webp', 'PCS', NULL, 1168, NULL, 0, NULL),
(610, 126, 45119, '2010106DP0005', 'SMART WIRELESS CARCHARGER GW-05 BLACK DP', '', NULL, 10, 0, 150.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(611, 126, 45120, '2010106DP0004', 'SMART WIRELESS CARCHARGER GW-05 WHITE DP', '', NULL, 10, 0, 150.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(612, 126, 45118, '2010106DP0003', 'SMART WIRELESS CHARGER 3IN1 (WC-X01) BLACK DP', '', NULL, 8, 0, 250.00, 0.00, 2000.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(613, 126, 45122, '2010106DP0006', 'Wireless Charger 15W WC-X02 Black DP', '', NULL, 210, 0, 160.00, 0.00, 33600.00, 'https://tgsc.qifudaren.net/uploads/20231124/b1321e5cc4ea4f1bffa5454898f910c7.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(614, 126, 1396, '2010701DP0002', 'ADAPTER CONNECTER C2C TYPE-C AUX 3.5  (SILVER) DP', '', NULL, 10, 0, 55.00, 0.00, 550.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 1173, NULL, 0, NULL),
(615, 126, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 10, 0, 45.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 1174, NULL, 0, NULL),
(616, 127, 1396, '2010701DP0002', 'ADAPTER CONNECTER C2C TYPE-C AUX 3.5  (SILVER) DP', '', NULL, 10, 0, 100.00, 0.00, 1000.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 1173, NULL, 0, NULL),
(617, 127, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 10, 0, 80.00, 0.00, 800.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 1174, NULL, 0, NULL),
(618, 127, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 5, 0, 435.00, 0.00, 2175.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 1175, NULL, 0, NULL),
(619, 127, 49239, '2010101DP0082', 'ADAPTER APP-29 25W White DP', '', NULL, 13, 0, 235.00, 0.00, 3055.00, 'https://tgsc.qifudaren.net/uploads/20240516/9b75332224227508eaa0354fb80daabf.webp', 'PCS', NULL, 1507, NULL, 0, NULL),
(620, 127, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 7, 0, 200.00, 0.00, 1400.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(621, 127, 45168, '2010101DP0070', 'ADAPTER QA-18 18W WHITE DP', '', NULL, 10, 0, 115.00, 0.00, 1150.00, 'https://tgsc.qifudaren.net/uploads/20231125/bf92e68d97263280c29e4377ba445cc3.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(622, 128, 1396, '2010701DP0002', 'ADAPTER CONNECTER C2C TYPE-C AUX 3.5  (SILVER) DP', '', NULL, 10, 0, 100.00, 0.00, 1000.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 1173, NULL, 0, NULL),
(623, 128, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 10, 0, 80.00, 0.00, 800.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 1174, NULL, 0, NULL),
(624, 128, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 5, 0, 435.00, 0.00, 2175.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 1175, NULL, 0, NULL),
(625, 128, 49239, '2010101DP0082', 'ADAPTER APP-29 25W White DP', '', NULL, 13, 0, 235.00, 0.00, 3055.00, 'https://tgsc.qifudaren.net/uploads/20240516/9b75332224227508eaa0354fb80daabf.webp', 'PCS', NULL, 1507, NULL, 0, NULL),
(626, 128, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 7, 0, 200.00, 0.00, 1400.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(627, 128, 45168, '2010101DP0070', 'ADAPTER QA-18 18W WHITE DP', '', NULL, 10, 0, 115.00, 0.00, 1150.00, 'https://tgsc.qifudaren.net/uploads/20231125/bf92e68d97263280c29e4377ba445cc3.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(628, 129, 1396, '2010701DP0002', 'ADAPTER CONNECTER C2C TYPE-C AUX 3.5  (SILVER) DP', '', NULL, 7, 0, 100.00, 0.00, 700.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 1173, NULL, 0, NULL),
(629, 129, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 6, 0, 80.00, 0.00, 480.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 1174, NULL, 0, NULL),
(630, 129, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 10, 0, 435.00, 0.00, 4350.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 1175, NULL, 0, NULL),
(631, 129, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 3, 0, 1500.00, 0.00, 4500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(632, 129, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 7, 0, 1500.00, 0.00, 10500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(633, 129, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 13, 0, 200.00, 0.00, 2600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(634, 129, 45168, '2010101DP0070', 'ADAPTER QA-18 18W WHITE DP', '', NULL, 9, 0, 115.00, 0.00, 1035.00, 'https://tgsc.qifudaren.net/uploads/20231125/bf92e68d97263280c29e4377ba445cc3.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(635, 130, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 1, 0, 80.00, 0.00, 80.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(636, 130, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 1, 0, 435.00, 0.00, 435.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(637, 130, 49240, '2010703DP0005', 'SELFIE STICK TRAVE+ LIVE SF-01 BLACK DP', '', NULL, 1, 0, 300.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240517/182f80017f6d6c43dcab7168345707a7.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(638, 130, 46406, '2010703DP0007', 'SELFIE STICK TRAVE+ LIVE SF-04 BLACK DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240127/f18916664f635bb9c19ad57d2851cbcc.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(639, 130, 49239, '2010101DP0082', 'ADAPTER APP-29 25W White DP', '', NULL, 1, 0, 235.00, 0.00, 235.00, 'https://tgsc.qifudaren.net/uploads/20240516/9b75332224227508eaa0354fb80daabf.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(640, 130, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 1, 0, 1500.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(641, 130, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 1, 0, 1500.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(642, 130, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(643, 131, 1396, '2010701DP0002', 'ADAPTER CONNECTER C2C TYPE-C AUX 3.5  (SILVER) DP', '', NULL, 1, 0, 100.00, 0.00, 100.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(644, 131, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 1, 0, 80.00, 0.00, 80.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(645, 131, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 1, 0, 435.00, 0.00, 435.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(646, 131, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 1, 0, 1500.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(647, 131, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 1, 0, 1500.00, 0.00, 1500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(648, 131, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(649, 131, 45168, '2010101DP0070', 'ADAPTER QA-18 18W WHITE DP', '', NULL, 1, 0, 115.00, 0.00, 115.00, 'https://tgsc.qifudaren.net/uploads/20231125/bf92e68d97263280c29e4377ba445cc3.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(658, 132, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 6, 0, 80.00, 0.00, 480.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 1174, NULL, 0, NULL),
(659, 132, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 7, 0, 435.00, 0.00, 3045.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 1175, NULL, 0, NULL),
(660, 132, 49240, '2010703DP0005', 'SELFIE STICK TRAVE+ LIVE SF-01 BLACK DP', '', NULL, 6, 0, 300.00, 0.00, 1800.00, 'https://tgsc.qifudaren.net/uploads/20240517/182f80017f6d6c43dcab7168345707a7.webp', 'PCS', NULL, 1176, NULL, 0, NULL),
(661, 132, 46406, '2010703DP0007', 'SELFIE STICK TRAVE+ LIVE SF-04 BLACK DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240127/f18916664f635bb9c19ad57d2851cbcc.webp', 'PCS', NULL, 1176, NULL, 0, NULL),
(662, 132, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 5, 0, 1500.00, 0.00, 7500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(663, 132, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 7, 0, 1500.00, 0.00, 10500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(664, 132, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 10, 0, 200.00, 0.00, 2000.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(665, 132, 45168, '2010101DP0070', 'ADAPTER QA-18 18W WHITE DP', '', NULL, 20, 0, 115.00, 0.00, 2300.00, 'https://tgsc.qifudaren.net/uploads/20231125/bf92e68d97263280c29e4377ba445cc3.webp', 'PCS', NULL, 1510, NULL, 0, NULL),
(674, 133, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 12, 0, 80.00, 0.00, 960.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 1174, NULL, 0, NULL),
(675, 133, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 12, 0, 435.00, 0.00, 5220.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 1175, NULL, 0, NULL),
(676, 133, 49240, '2010703DP0005', 'SELFIE STICK TRAVE+ LIVE SF-01 BLACK DP', '', NULL, 1, 0, 300.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240517/182f80017f6d6c43dcab7168345707a7.webp', 'PCS', NULL, 1176, NULL, 0, NULL),
(677, 133, 46406, '2010703DP0007', 'SELFIE STICK TRAVE+ LIVE SF-04 BLACK DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240127/f18916664f635bb9c19ad57d2851cbcc.webp', 'PCS', NULL, 1176, NULL, 0, NULL),
(678, 133, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 3, 0, 1500.00, 0.00, 4500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(679, 133, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 11, 0, 1500.00, 0.00, 16500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(680, 133, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 11, 0, 200.00, 0.00, 2200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(681, 133, 45168, '2010101DP0070', 'ADAPTER QA-18 18W WHITE DP', '', NULL, 11, 0, 115.00, 0.00, 1265.00, 'https://tgsc.qifudaren.net/uploads/20231125/bf92e68d97263280c29e4377ba445cc3.webp', 'PCS', NULL, 1510, NULL, 0, NULL),
(682, 134, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 10, 0, 225.00, 0.00, 2250.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 1175, NULL, 0, NULL),
(683, 134, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(684, 135, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 10, 0, 225.00, 0.00, 2250.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 1175, NULL, 0, NULL),
(685, 135, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(686, 136, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 10, 0, 225.00, 0.00, 2250.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 1175, NULL, 0, NULL),
(687, 136, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(688, 137, 45118, '2010106DP0003', 'SMART WIRELESS CHARGER 3IN1 (WC-X01) BLACK DP', '', NULL, 1, 0, 250.00, 0.00, 250.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(689, 137, 45122, '2010106DP0006', 'Wireless Charger 15W WC-X02 Black DP', '', NULL, 1, 0, 160.00, 0.00, 160.00, 'https://tgsc.qifudaren.net/uploads/20231124/b1321e5cc4ea4f1bffa5454898f910c7.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(690, 137, 1396, '2010701DP0002', 'ADAPTER CONNECTER C2C TYPE-C AUX 3.5  (SILVER) DP', '', NULL, 1, 0, 55.00, 0.00, 55.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(691, 137, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 1, 0, 45.00, 0.00, 45.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(692, 137, 46510, '2010903DP0001', 'BLUETOOTH SUNGLASSES แว่นตากันแดด BLUETOOTH (BT-G01) DP', '', NULL, 1, 0, 225.00, 0.00, 225.00, 'https://tgsc.qifudaren.net/uploads/20240203/995ff59232956dd4e47003520f151caa.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(693, 137, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 10, 0, 1500.00, 0.00, 15000.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(694, 137, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 3, 0, 1500.00, 0.00, 4500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(695, 137, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 5, 0, 200.00, 0.00, 1000.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(696, 137, 45168, '2010101DP0070', 'ADAPTER QA-18 18W WHITE DP', '', NULL, 8, 0, 115.00, 0.00, 920.00, 'https://tgsc.qifudaren.net/uploads/20231125/bf92e68d97263280c29e4377ba445cc3.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(697, 138, 45119, '2010106DP0005', 'SMART WIRELESS CARCHARGER GW-05 BLACK DP', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(698, 138, 45120, '2010106DP0004', 'SMART WIRELESS CARCHARGER GW-05 WHITE DP', '', NULL, 2, 0, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(699, 138, 45118, '2010106DP0003', 'SMART WIRELESS CHARGER 3IN1 (WC-X01) BLACK DP', '', NULL, 2, 0, 250.00, 0.00, 500.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(700, 138, 45122, '2010106DP0006', 'Wireless Charger 15W WC-X02 Black DP', '', NULL, 2, 0, 160.00, 0.00, 320.00, 'https://tgsc.qifudaren.net/uploads/20231124/b1321e5cc4ea4f1bffa5454898f910c7.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(701, 138, 1396, '2010701DP0002', 'ADAPTER CONNECTER C2C TYPE-C AUX 3.5  (SILVER) DP', '', NULL, 2, 0, 55.00, 0.00, 110.00, 'https://tgsc.qifudaren.net/uploads/20240803/fb9c40aa03e359f3b57a9e163b6c64ac.webp', 'PCS', NULL, 1173, NULL, 0, NULL),
(702, 138, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 2, 0, 45.00, 0.00, 90.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 1174, NULL, 0, NULL),
(703, 138, 49239, '2010101DP0082', 'ADAPTER APP-29 25W White DP', '', NULL, 10, 0, 235.00, 0.00, 2350.00, 'https://tgsc.qifudaren.net/uploads/20240516/9b75332224227508eaa0354fb80daabf.webp', 'PCS', NULL, 1507, NULL, 0, NULL),
(704, 138, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 3, 0, 1500.00, 0.00, 4500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(705, 138, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 3, 0, 1500.00, 0.00, 4500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(706, 139, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', NULL, 20, 0, 320.00, 0.00, 6400.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, NULL, 0, NULL),
(707, 140, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', NULL, 10, 0, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, NULL, 0, NULL),
(708, 140, 51209, '2010602DP0049', 'Tempered glass film 2.9D Clear iPhone SE2/3 (New)', '', NULL, 10, 0, 35.00, 0.00, 350.00, 'https://tgsc.qifudaren.net/uploads/20250607/65b1dc69122750eb1a71fceb759fd2fa.webp', 'PCS', NULL, 1391, NULL, 0, NULL);
INSERT INTO `sale_order_items` (`id`, `order_id`, `pro_id`, `sn`, `pro_name`, `pro_goods_sku_text`, `pro_title`, `qty`, `stock`, `unit_price`, `discount`, `total_price`, `pro_images`, `unit`, `item_id`, `pro_activity_id`, `activity_id`, `st`, `pro_goods_id`) VALUES
(709, 140, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 5, 0, 1500.00, 0.00, 7500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(710, 140, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 5, 0, 1500.00, 0.00, 7500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(722, 141, 1227, '2010307DP0024', 'POWER BANK GC100  WHITE (10000 MAH) DP', '', NULL, 10, 0, 360.00, 0.00, 3600.00, '/uploads/20230715/176af0df66b8f519fcf81cf81ee7bf8e.webp', '', NULL, 0, NULL, 0, NULL),
(723, 141, 1201, '2020101DP0012', 'SPEAKER BLUETOOTH WOODY (BROWN) DP', '', NULL, 10, 0, 320.00, 0.00, 3200.00, '/uploads/20230718/90acb9da1f84adcf6502bd97a2ce419b.webp', '', NULL, 0, NULL, 0, NULL),
(724, 141, 2050, '2010307DP0071', 'POWER BANK GC106 PREMIUM (10000 MAH) WHITE DP มีหูแขวน', '', NULL, 1, 0, 270.00, 0.00, 270.00, '/uploads/20230715/d76aee489635eba49714aff60f298fc9.webp', '', NULL, 0, NULL, 0, NULL),
(725, 141, 2051, '2010307DP0071', 'POWER BANK GC106 PREMIUM (10000 MAH) WHITE DP มีหูแขวน', '', NULL, 2, 0, 270.00, 0.00, 540.00, '/uploads/20230715/33880a1eb8478e23ec0d9f391440bfbc.webp', '', NULL, 0, NULL, 0, NULL),
(726, 142, 45119, '2010106DP0005', 'SMART WIRELESS CARCHARGER GW-05 BLACK DP', '', NULL, 1, 0, 150.00, 0.00, 150.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(727, 142, 45120, '2010106DP0004', 'SMART WIRELESS CARCHARGER GW-05 WHITE DP', '', NULL, 1, 0, 150.00, 0.00, 150.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', 'PCS', NULL, 1170, NULL, 0, NULL),
(728, 142, 45118, '2010106DP0003', 'SMART WIRELESS CHARGER 3IN1 (WC-X01) BLACK DP', '', NULL, 3, 0, 250.00, 0.00, 750.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(729, 142, 45122, '2010106DP0006', 'Wireless Charger 15W WC-X02 Black DP', '', NULL, 3, 0, 160.00, 0.00, 480.00, 'https://tgsc.qifudaren.net/uploads/20231124/b1321e5cc4ea4f1bffa5454898f910c7.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(730, 142, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 3, 0, 1500.00, 0.00, 4500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(731, 142, 3641, '2020103DP0014', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BROWN (DP)', '', NULL, 3, 0, 1500.00, 0.00, 4500.00, 'https://tgsc.qifudaren.net/uploads/20240717/20a819feeb336f6be9a09b6767e4c6da.webp', 'PCS', NULL, 1508, NULL, 0, NULL),
(732, 142, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(733, 143, 49239, '2010101DP0082', 'ADAPTER APP-29 25W White DP', '', NULL, 10, 0, 235.00, 0.00, 2350.00, 'https://tgsc.qifudaren.net/uploads/20240516/9b75332224227508eaa0354fb80daabf.webp', 'PCS', NULL, 1507, NULL, 0, NULL),
(734, 143, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(735, 144, 3640, '2020103DP0013', 'SPEAKER BLUETOOTH MUSICAL III WRIELESS MIC*1 BLACK (DP)', '', NULL, 3, 0, 1500.00, 0.00, 4500.00, 'https://tgsc.qifudaren.net/uploads/20240717/3a84d00b874bc8a5271a96c821a36440.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(736, 144, 45168, '2010101DP0070', 'ADAPTER QA-18 18W WHITE DP', '', NULL, 3, 0, 115.00, 0.00, 345.00, 'https://tgsc.qifudaren.net/uploads/20231125/bf92e68d97263280c29e4377ba445cc3.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(737, 145, 46503, '2020203DP0011', 'AUX IP-01 (LIGHTNING TO 3.5mm) WHITE DP', '', NULL, 99, 0, 45.00, 0.00, 4455.00, 'https://tgsc.qifudaren.net/uploads/20240203/0e192217095d58b0e23d457143b89298.webp', 'PCS', NULL, 1174, NULL, 0, NULL),
(738, 146, 49240, '2010703DP0005', 'SELFIE STICK TRAVE+ LIVE SF-01 BLACK DP', '', NULL, 10, 0, 145.00, 0.00, 1450.00, 'https://tgsc.qifudaren.net/uploads/20240517/182f80017f6d6c43dcab7168345707a7.webp', 'PCS', NULL, 1176, NULL, 0, NULL),
(739, 147, 45118, '2010106DP0003', 'SMART WIRELESS CHARGER 3IN1 (WC-X01) BLACK DP', '', NULL, 3, 0, 250.00, 0.00, 750.00, 'https://tgsc.qifudaren.net/uploads/20231124/a19e756ae18fb38024c0a4683c1a79f6.webp', 'PCS', NULL, 1172, NULL, 0, NULL),
(740, 148, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(741, 149, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', NULL, 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, NULL, 0, NULL),
(742, 149, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(743, 150, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', NULL, 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, NULL, 0, NULL),
(744, 150, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(745, 151, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(746, 152, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(747, 153, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(748, 154, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(749, 155, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(750, 156, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(751, 157, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(752, 158, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(753, 159, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(754, 160, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(755, 161, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(756, 162, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(757, 163, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(758, 164, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(759, 165, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 1, 0, 200.00, 0.00, 200.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 0, NULL, 0, NULL),
(760, 166, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', NULL, 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, NULL, 0, NULL),
(761, 166, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(762, 167, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', NULL, 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, NULL, 0, NULL),
(763, 167, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(764, 168, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', NULL, 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, NULL, 0, NULL),
(765, 168, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(766, 169, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', NULL, 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, NULL, 0, NULL),
(767, 169, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(768, 170, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', NULL, 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, NULL, 0, NULL),
(769, 170, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', NULL, 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, NULL, 0, NULL),
(770, 177, 0, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 0, NULL),
(771, 177, 0, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, 1509, 0, NULL),
(772, 178, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 0, NULL),
(773, 178, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, 1509, 0, NULL),
(774, 179, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 0, NULL),
(775, 179, 50896, '2010101DP0085', 'ADAPTER APP-27 25W SUPER VOOC WHITE DP', '', 'อะแดปเตอร์ APP-27 (Super VOOC 25W)', 3, 0, 200.00, 0.00, 600.00, 'https://tgsc.qifudaren.net/uploads/20240821/50e9b6b8610eca0a2fde91a80734c013.webp', 'PCS', NULL, 1509, 1509, 0, NULL),
(790, 182, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 0, 11345),
(791, 182, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'PCS', NULL, 1316, 1316, 0, 13308),
(794, 181, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 0, 11345),
(795, 181, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'PCS', NULL, 1316, 1316, 0, 13308),
(807, 180, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 15, 0, 150.00, 0.00, 2250.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 1209, 1209, 0, 11345),
(808, 180, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 15, 0, 750.00, 0.00, 11250.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', '', NULL, 1316, 1316, 0, 13308),
(809, 183, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(810, 183, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'PCS', NULL, 1316, 1316, 1, 13308),
(811, 184, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(812, 184, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'PCS', NULL, 1316, 1316, 1, 13308),
(813, 185, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(814, 185, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 4, 0, 750.00, 0.00, 3000.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'PCS', NULL, 1316, 0, 0, 13308),
(815, 186, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 1209, 1209, 1, 11345),
(816, 186, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', '', NULL, 1316, 1316, 1, 13308),
(864, 187, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 2, 1019, 150.00, 0.00, 300.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 1209, 1209, 0, 11345),
(865, 187, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', '', NULL, 1316, 1316, 1, 13308),
(866, 188, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 20, 0, 320.00, 0.00, 6400.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(867, 189, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 1209, 1209, 1, 11345),
(868, 189, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', '', NULL, 1316, 1316, 1, 13308),
(872, 192, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 759, 315.00, 0.00, 945.00, '/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 0, 0, 0, 11345),
(873, 192, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 1209, 1209, 1, 11345),
(874, 193, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 759, 315.00, 0.00, 945.00, '/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 0, 0, 0, 11345),
(875, 193, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 1209, 1209, 1, 11345),
(876, 194, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 759, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(877, 194, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20240531/b9b88165602cf8d96ed930b9250064e6.webp', 'PCS', NULL, 1316, 1316, 1, 13308),
(878, 195, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 759, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(879, 195, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 0, 315.00, 0.00, 945.00, '/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 0, 0, 0, 11345),
(880, 196, 45119, '2010106DP0005', 'SMART WIRELESS CARCHARGER GW-05 BLACK DP', '', 'SMART WIRELESS CARCHARGER GW-05 BLACK DP', 10, 681, 295.00, 0.00, 2950.00, '/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', '', NULL, 0, 0, 0, 10226),
(881, 196, 45120, '2010106DP0004', 'SMART WIRELESS CARCHARGER GW-05 WHITE DP', '', 'SMART WIRELESS CARCHARGER GW-05 WHITE DP', 2, 1133, 295.00, 0.00, 590.00, '/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', '', NULL, 0, 0, 0, 10226),
(882, 197, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(883, 197, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(884, 198, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(885, 198, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(886, 199, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(887, 199, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(888, 200, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(889, 200, 3177, '2020106DP0002', 'SPEAKER BLUETOOTH BOM-82 (Black) DP', '', 'SPEAKER BLUETOOTH BOM-82 (Black) DP', 1, 1, 650.00, 0.00, 650.00, '/uploads/20230718/4c27cba4d38cb112f0f16b85db192c44.webp', '', NULL, 0, 0, 0, 290),
(890, 200, 1196, '2020102DP0010', 'SPEAKER BLUETOOTH WIRELESS SOUNDBAR M-200 (LED) IRON ASH DP', '', 'SPEAKER BLUETOOTH WIRELESS SOUNDBAR M-200 (LED) IRON ASH DP', 1, 1, 350.00, 0.00, 350.00, '/uploads/20250718/41e01368b463dc8cdfb73f1521c62e88.jpg', '', NULL, 0, 0, 0, 299),
(891, 201, 50990, '2030202DP0004', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 20 นิ้ว รุ่น JT-203 (DP)', '', 'พัดลมอุตสาหกรรม 20 นิ้ว รุ่น JT-203 (DP)', 2, 81, 1250.00, 0.00, 2500.00, 'https://tgsc.qifudaren.net/uploads/20250122/d83fadcaae5aed9ed01a3f260632b099.webp', 'PCS', NULL, 1519, 1519, 1, 13876),
(892, 201, 50989, '2030202DP0003', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 20 นิ้ว รุ่น JT-201 (DP)', '', 'พัดลมอุตสาหกรรม 20 นิ้ว รุ่น JT-201(DP)', 2, 195, 1250.00, 0.00, 2500.00, 'https://tgsc.qifudaren.net/uploads/20250122/0e89a762bc687c84e8eb5b2a50dcfb88.webp', 'PCS', NULL, 1519, 1519, 1, 13875),
(893, 201, 50956, '2030202DP0002', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 18 นิ้ว รุ่น JT-189 (DP)', '', 'พัดลม d-power JT-189', 2, 162, 770.00, 0.00, 1540.00, 'https://tgsc.qifudaren.net/uploads/20241001/2137472b9eb23c26581559c2b2e9991c.webp', 'PCS', NULL, 1519, 1519, 1, 13843),
(894, 201, 50933, '2030202DP0001', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 18 นิ้ว ขาสไลด์ รุ่น JT-183 (DP)', '', 'พัดลม d-power JT-183', 2, 158, 930.00, 0.00, 1860.00, 'https://tgsc.qifudaren.net/uploads/20240918/cc846133692b03192288042fa6a42c61.webp', 'PCS', NULL, 1519, 1519, 1, 13824),
(895, 202, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(896, 202, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(897, 203, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(898, 203, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 0, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(899, 204, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(900, 204, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(901, 204, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 7, 893, 320.00, 0.00, 2240.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(902, 204, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 758, 315.00, 0.00, 945.00, '/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 0, 0, 0, 11345),
(903, 205, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(904, 205, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(905, 205, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 7, 893, 320.00, 0.00, 2240.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(906, 205, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 758, 315.00, 0.00, 945.00, '/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 0, 0, 0, 11345),
(907, 206, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(908, 206, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(909, 206, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 7, 893, 320.00, 0.00, 2240.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(910, 206, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 758, 315.00, 0.00, 945.00, '/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 0, 0, 0, 11345),
(911, 207, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(912, 207, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(913, 207, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 7, 893, 320.00, 0.00, 2240.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(914, 207, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 758, 315.00, 0.00, 945.00, '/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 0, 0, 0, 11345),
(915, 208, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(916, 209, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(917, 210, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(918, 211, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(919, 212, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(920, 213, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(921, 214, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(922, 215, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(923, 216, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(924, 217, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 0, 0, 11345),
(925, 218, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 1, 758, 315.00, 0.00, 315.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 1209, 0, 0, 11345),
(926, 218, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', '', NULL, 1316, 1316, 1, 13308),
(927, 218, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 7, 893, 320.00, 0.00, 2240.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(928, 218, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', 3, 758, 315.00, 0.00, 945.00, '/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', 0, 0, 0, 0, 11345),
(929, 219, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 758, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', '', NULL, 1209, 1209, 1, 11345),
(930, 219, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', '', NULL, 1316, 1316, 1, 13308),
(934, 220, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(935, 221, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(936, 222, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(937, 223, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(938, 224, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(939, 225, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(940, 226, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(941, 227, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(942, 228, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(943, 229, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 11, 893, 320.00, 0.00, 3520.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(944, 230, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 11, 893, 320.00, 0.00, 3520.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(945, 231, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(946, 232, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(947, 233, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', '', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(948, 234, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', NULL, 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(949, 235, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', NULL, 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(950, 236, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', NULL, 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(954, 238, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 700, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(955, 238, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(956, 238, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(957, 238, 1304, '2020101DP0007', 'SPEAKER BLUETOOTH PARCO LIGHT GREEN DP', 'LIGHT GREEN', 'SPEAKER BLUETOOTH PARCO LIGHT GREEN DP', 4, 5, 160.00, 0.00, 640.00, '/uploads/20250701/5a329c624884a860499750332c85a89f.jpg', '', NULL, 0, 0, 0, 382),
(958, 237, 1200, '2020101DP0011', 'SPEAKER BLUETOOTH WOODY (BLACK) DP', 'BLACK', 'ลำโพงบลูทูธ WOODY', 10, 893, 320.00, 0.00, 3200.00, '/uploads/20230718/d6db14e8b8ea0a380a87ab0bde82da02.webp', '', NULL, 0, 0, 0, 303),
(959, 237, 1227, '2010307DP0024', 'POWER BANK GC100  WHITE (10000 MAH) DP', 'White', 'พาวเวอร์แบงค์ GC100 (10000mAh)', 11, 3084, 360.00, 0.00, 3960.00, '/uploads/20230715/176af0df66b8f519fcf81cf81ee7bf8e.webp', '', NULL, 0, 0, 0, 324),
(960, 237, 1413, '2020105DP0002', 'SPEAKER BLUETOOTH K52-S MIC (RED) DP', 'Yellow', 'ลำโพงบลูทูธ K52S MIC [แถมไมค์สาย]', 13, 236, 1250.00, 0.00, 16250.00, '/uploads/20230919/64f45e3306a0b8cff6b240a7906749c0.webp', '', NULL, 0, 0, 0, 428),
(961, 237, 1413, '2020105DP0002', 'SPEAKER BLUETOOTH K52-S MIC (RED) DP', 'Yellow', 'ลำโพงบลูทูธ K52S MIC [แถมไมค์สาย]', 13, 236, 1250.00, 0.00, 16250.00, '/uploads/20230919/1b58b7f60deaa00fb8dea9862cb2f1c5.webp', '', NULL, 0, 0, 0, 428),
(962, 237, 1950, '2010201DP0002', 'USB DATA CABLE UB-11M FOR MICRO 5PIN White (DP)', 'Type-C', 'USB UB-11  [2.4A]', 16, 17726, 22.00, 0.00, 352.00, '/uploads/20230717/b3e3e4430697cb51ed767b0c8d3b4242.webp', '', NULL, 0, 0, 0, 482),
(963, 237, 1949, '2010201DP0002', 'USB DATA CABLE UB-11M FOR MICRO 5PIN White (DP)', 'Lightning', 'USB UB-11  [2.4A]', 15, 17726, 22.00, 0.00, 330.00, '/uploads/20230717/0713fbaad30b2b1391867ae389eac833.webp', '', NULL, 0, 0, 0, 482),
(964, 237, 1950, '2010201DP0002', 'USB DATA CABLE UB-11M FOR MICRO 5PIN White (DP)', 'Type-C', 'USB UB-11  [2.4A]', 16, 17726, 22.00, 0.00, 352.00, '/uploads/20230717/26c4a2bb7929c9442e8594542448bc09.webp', '', NULL, 0, 0, 0, 482),
(965, 237, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 700, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(966, 237, 50318, '2030903AJ0001', 'AJ SETกาพ่นสี รุ่นSG-001แถมถุงมือMKT-TV-001+ชุดประแจบล็อก MKT  AJ SET-27 (AJ)', '', 'ชุดกาพ่นสี AJ SG-001', 5, 412, 750.00, 0.00, 3750.00, 'https://tgsc.qifudaren.net/uploads/20250802/fbb09c71186a5f05dbc6677dc6ee161f.jpg', 'PCS', NULL, 1316, 1316, 1, 13308),
(967, 239, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 35, 252, 150.00, 0.00, 5250.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(968, 239, 50990, '2030202DP0004', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 20 นิ้ว รุ่น JT-203 (DP)', '', 'พัดลมอุตสาหกรรม 20 นิ้ว รุ่น JT-203 (DP)', 1, 74, 1250.00, 0.00, 1250.00, 'https://tgsc.qifudaren.net/uploads/20250122/d83fadcaae5aed9ed01a3f260632b099.webp', 'PCS', NULL, 1519, 1519, 1, 13876),
(969, 239, 50989, '2030202DP0003', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 20 นิ้ว รุ่น JT-201 (DP)', '', 'พัดลมอุตสาหกรรม 20 นิ้ว รุ่น JT-201(DP)', 1, 188, 1250.00, 0.00, 1250.00, 'https://tgsc.qifudaren.net/uploads/20250122/0e89a762bc687c84e8eb5b2a50dcfb88.webp', 'PCS', NULL, 1519, 1519, 1, 13875),
(970, 239, 50956, '2030202DP0002', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 18 นิ้ว รุ่น JT-189 (DP)', '', 'พัดลม d-power JT-189', 1, 128, 770.00, 0.00, 770.00, 'https://tgsc.qifudaren.net/uploads/20241001/2137472b9eb23c26581559c2b2e9991c.webp', 'PCS', NULL, 1519, 1519, 1, 13843),
(971, 239, 50933, '2030202DP0001', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 18 นิ้ว ขาสไลด์ รุ่น JT-183 (DP)', '', 'พัดลม d-power JT-183', 1, 111, 930.00, 0.00, 930.00, 'https://tgsc.qifudaren.net/uploads/20240918/cc846133692b03192288042fa6a42c61.webp', 'PCS', NULL, 1519, 1519, 1, 13824),
(972, 239, 50928, '2030102ZZ0001', 'เตาย่าง บาบีคิว รุ่น BBQ-3101 MH 2ซุป MYHOME', '', 'เตาย่าง บาบีคิว MY HOME BBQ3101 ', 45, 23, 590.00, 0.00, 26550.00, 'https://tgsc.qifudaren.net/uploads/20240927/deac0a4f3beff4290dba27befc7046cf.webp', 'PCS', NULL, 1527, 1527, 1, 13819),
(979, 240, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 252, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(980, 240, 50990, '2030202DP0004', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 20 นิ้ว รุ่น JT-203 (DP)', '', 'พัดลมอุตสาหกรรม 20 นิ้ว รุ่น JT-203 (DP)', 1, 74, 1250.00, 0.00, 1250.00, 'https://tgsc.qifudaren.net/uploads/20250122/d83fadcaae5aed9ed01a3f260632b099.webp', 'PCS', NULL, 1519, 1519, 1, 13876),
(981, 240, 50989, '2030202DP0003', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 20 นิ้ว รุ่น JT-201 (DP)', '', 'พัดลมอุตสาหกรรม 20 นิ้ว รุ่น JT-201(DP)', 1, 188, 1250.00, 0.00, 1250.00, 'https://tgsc.qifudaren.net/uploads/20250122/0e89a762bc687c84e8eb5b2a50dcfb88.webp', 'PCS', NULL, 1519, 1519, 1, 13875),
(982, 240, 50956, '2030202DP0002', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 18 นิ้ว รุ่น JT-189 (DP)', '', 'พัดลม d-power JT-189', 1, 128, 770.00, 0.00, 770.00, 'https://tgsc.qifudaren.net/uploads/20241001/2137472b9eb23c26581559c2b2e9991c.webp', 'PCS', NULL, 1519, 1519, 1, 13843),
(983, 240, 50933, '2030202DP0001', 'พัดลมอุตสาหกรรมตั้งโต๊ะ 18 นิ้ว ขาสไลด์ รุ่น JT-183 (DP)', '', 'พัดลม d-power JT-183', 1, 111, 930.00, 0.00, 930.00, 'https://tgsc.qifudaren.net/uploads/20240918/cc846133692b03192288042fa6a42c61.webp', 'PCS', NULL, 1519, 1519, 1, 13824),
(984, 240, 50928, '2030102ZZ0001', 'เตาย่าง บาบีคิว รุ่น BBQ-3101 MH 2ซุป MYHOME', '', 'เตาย่าง บาบีคิว MY HOME BBQ3101 ', 15, 23, 590.00, 0.00, 8850.00, 'https://tgsc.qifudaren.net/uploads/20240927/deac0a4f3beff4290dba27befc7046cf.webp', 'PCS', NULL, 1527, 1527, 1, 13819),
(985, 241, 46764, '2010403DP0043', 'BLUETOOTH TWS HEADPHONE BT-G22 WHITE DP', '', 'หูฟังบลูทูธ BT-G22', 3, 0, 150.00, 0.00, 450.00, 'https://tgsc.qifudaren.net/uploads/20240228/b20cbc4bda9e57366edd3e1528160275.webp', 'PCS', NULL, 1209, 1209, 1, 11345),
(986, 241, 46229, '2030106AJ0002', 'เตาแก๊สหัวเดียว แบบหัวฟู่ ยี่ห้อ AJ รุ่น AJ-GA1H-01A (AJ)', '', 'เตาแก๊ส AJ  GA1H-01A', 3, 0, 300.00, 0.00, 900.00, 'https://tgsc.qifudaren.net/uploads/20250614/e8c9e9b3196e3a7cc54d81bf8fcd62df.webp', 'PCS', NULL, 1515, 1515, 1, 10923),
(987, 241, 50772, '2030106AJ0013', 'เตาแก๊สหัวเดี่ยว หัวเทอร์โบ ยี่ห้อ AJ รุ่น AJ- GA1H-01BS (AJ)', '', 'เตาแก๊สหัวเทอร์โบ AJ-GA1H-01BS', 3, 0, 300.00, 0.00, 900.00, 'https://tgsc.qifudaren.net/uploads/20240707/9f0166c9ed4de8541aa4ec87ae8c6597.webp', 'PCS', NULL, 1515, 1515, 1, 13741),
(988, 242, 50941, '2020103DP0032', 'SPEAKER BLUETOOTH BOM-55 BLACK (DP)', 'BLACK', 'SPEAKER BLUETOOTH BOM-55 BLACK (DP)', 10, 397, 1500.00, 0.00, 15000.00, '/uploads/20240925/e67441d24db9c064a63968dd8e8951d2.webp', '', NULL, 0, 0, 0, 13834),
(989, 242, 46229, '2030106AJ0002', 'เตาแก๊สหัวเดียว แบบหัวฟู่ ยี่ห้อ AJ รุ่น AJ-GA1H-01A (AJ)', '', 'เตาแก๊ส AJ  GA1H-01A', 3, 0, 300.00, 0.00, 900.00, 'https://tgsc.qifudaren.net/uploads/20250614/e8c9e9b3196e3a7cc54d81bf8fcd62df.webp', 'PCS', NULL, 1515, 1515, 1, 10923),
(990, 242, 50772, '2030106AJ0013', 'เตาแก๊สหัวเดี่ยว หัวเทอร์โบ ยี่ห้อ AJ รุ่น AJ- GA1H-01BS (AJ)', '', 'เตาแก๊สหัวเทอร์โบ AJ-GA1H-01BS', 3, 0, 300.00, 0.00, 900.00, 'https://tgsc.qifudaren.net/uploads/20240707/9f0166c9ed4de8541aa4ec87ae8c6597.webp', 'PCS', NULL, 1515, 1515, 1, 13741),
(991, 243, 2706, '2010103DP0029', 'CAR CHARGER C15 (2.4A 2PORT USB (BLACK) DP', 'BLACK', 'อะแดปเตอร์ชาร์จในรถยนต์ C15', 1, 0, 70.00, 0.00, 70.00, 'https://tgsc.qifudaren.net/uploads/20230714/0bdd4b75abf42b227f6f6f79004c64f7.webp', '', NULL, 1481, 1481, 0, 412),
(992, 243, 46203, '2010103DP0038', 'CAR CHARGER QC-03 PD3.0 BLACK (DP)', '', 'Car Charger QC-03 (PPS-PD 30W)', 1, 0, 135.00, 0.00, 135.00, 'https://tgsc.qifudaren.net/uploads/20231206/6e979bd88608ec1ffd1dd16f5e7a9450.webp', '', NULL, 1482, 1482, 0, 10901),
(993, 243, 45119, '2010106DP0005', 'SMART WIRELESS CARCHARGER GW-05 BLACK DP', 'Black', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', 1, 0, 220.00, 0.00, 220.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', '', NULL, 1483, 1483, 0, 10226),
(994, 243, 45120, '2010106DP0004', 'SMART WIRELESS CARCHARGER GW-05 WHITE DP', 'White', 'แท่นชาร์จไร้สาย ในรถยนต์ GW-05', 1, 0, 220.00, 0.00, 220.00, 'https://tgsc.qifudaren.net/uploads/20240802/0bcba8f0826392c9f53c5f39b3c326e0.webp', '', NULL, 1483, 1483, 0, 10226),
(995, 243, 46454, '2010103DP0039', 'CAR CHARGER CC-02 MINI 5P (2A) 3.5M DP', '', 'CC-02 สายชาร์จกล้องติดรถ หัว MINI USB', 1, 0, 110.00, 0.00, 110.00, 'https://tgsc.qifudaren.net/uploads/20240201/6d61a1218e385ca76fd9571e0e7b1b6e.webp', '', NULL, 1484, 1484, 0, 11074),
(996, 243, 46592, '2010104DP0017', 'CAR CHARGER SET C18P BLACK 2 PORT 2.4A (DP)', 'Black-Lightning', 'ชุดอะแดปเตอร์ชาร์จในรถยนต์ C18', 1, 0, 65.00, 0.00, 65.00, 'https://tgsc.qifudaren.net/uploads/20240205/28379db2fe8900349211812b184898a3.webp', '', NULL, 1485, 1485, 0, 11174),
(997, 243, 46595, '2010104DP0016', 'CAR CHARGER SET C18P WHITE 2 PORT 2.4A (DP)', 'White-Lightning', 'ชุดอะแดปเตอร์ชาร์จในรถยนต์ C18', 1, 0, 65.00, 0.00, 65.00, 'https://tgsc.qifudaren.net/uploads/20240205/28379db2fe8900349211812b184898a3.webp', '', NULL, 1485, 1485, 0, 11174),
(1002, 244, 46229, '2030106AJ0002', 'เตาแก๊สหัวเดียว แบบหัวฟู่ ยี่ห้อ AJ รุ่น AJ-GA1H-01A (AJ)', '', 'เตาแก๊ส AJ  GA1H-01A', 3, 2098, 300.00, 0.00, 900.00, 'https://tgsc.qifudaren.net/uploads/20250614/e8c9e9b3196e3a7cc54d81bf8fcd62df.webp', '', NULL, 1515, 1515, 1, 10923),
(1003, 244, 50772, '2030106AJ0013', 'เตาแก๊สหัวเดี่ยว หัวเทอร์โบ ยี่ห้อ AJ รุ่น AJ- GA1H-01BS (AJ)', '', 'เตาแก๊สหัวเทอร์โบ AJ-GA1H-01BS', 3, 1167, 300.00, 0.00, 900.00, 'https://tgsc.qifudaren.net/uploads/20240707/9f0166c9ed4de8541aa4ec87ae8c6597.webp', '', NULL, 1515, 1515, 1, 13741),
(1004, 244, 46215, '2030103AJ0004', 'เครื่องบดสับไฟฟ้า สแตนเลส 2ลิตร AJ รุ่น CP-100 (AJ)', '', 'เครื่องบดสับ AJ CP-100', 6, 70, 300.00, 0.00, 1800.00, 'https://tgsc.qifudaren.net/uploads/20231212/b556449fca5d760aeb0a2de3163d678c.webp', '', NULL, 1516, 1516, 1, 10910),
(1005, 244, 50716, '2030101AJ0003', 'หม้อหุงข้าว 1 ลิตร  ไม่เคลือบ ฝาบนสแตนเลส AJ รุ่น A102T (AJ)\r\n', '', 'หม้อหุงข้าว AJ A102T', 6, 174, 300.00, 0.00, 1800.00, 'https://tgsc.qifudaren.net/uploads/20250805/b4442f629bb73c8f822c2567f6f823d0.jpg', '', NULL, 1516, 1516, 1, 13687),
(1006, 245, 50928, '2030102ZZ0001', 'เตาย่าง บาบีคิว รุ่น BBQ-3101 MH 2ซุป MYHOME', '', 'เตาย่าง บาบีคิว MY HOME BBQ3101 ', 12, 23, 590.00, 0.00, 7080.00, 'https://tgsc.qifudaren.net/uploads/20240927/deac0a4f3beff4290dba27befc7046cf.webp', 'PCS', NULL, 1527, 1527, 1, 13819);

-- --------------------------------------------------------

--
-- Table structure for table `sale_order_promotions`
--

CREATE TABLE `sale_order_promotions` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `ML_Note` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `pro_activity_id` int(11) DEFAULT NULL,
  `activity_id` int(255) NOT NULL,
  `st` tinyint(1) NOT NULL,
  `pro_sn` varchar(50) NOT NULL,
  `pro_goods_id` int(11) DEFAULT NULL,
  `pro_goods_num` int(11) DEFAULT NULL,
  `stock` int(255) NOT NULL,
  `pro_image` text DEFAULT NULL,
  `pro_sku_price_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_order_promotions`
--

INSERT INTO `sale_order_promotions` (`id`, `order_id`, `title`, `ML_Note`, `note`, `pro_activity_id`, `activity_id`, `st`, `pro_sn`, `pro_goods_id`, `pro_goods_num`, `stock`, `pro_image`, `pro_sku_price_id`, `user_id`, `item_id`) VALUES
(132, 87, 'โปรโมชั่น ซื้อ BT-G01 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1175, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(133, 87, 'โปรโมชั่น ซื้อ AP-21 10 ชิ้น แถม AU-51 8 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1490, 0, 0, '', 0, 1, 0, '/uploads/20250630/7148d4b818bc4e3113b673d6e2e2cdce.jpg', NULL, 11913, NULL),
(134, 88, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(135, 89, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(136, 90, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(137, 91, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(138, 92, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(139, 93, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(140, 94, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(141, 96, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(142, 97, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(143, 98, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(144, 99, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(145, 100, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(146, 101, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(147, 102, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(148, 104, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(149, 106, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(150, 107, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(151, 108, 'โปรโมชั่น ซื้อ WC-X01/ WC-X02 รุ่นละ 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1172, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(167, 109, 'โปรโมชั่น ซื้อ พาวเวอร์แบงค์ S28 P จำนวน 3 ชิ้น ในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1377, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(168, 109, 'โปรโมชั่น ซื้อ พาวเวอร์แบงค์ S28 C จำนวน 3 ชิ้น ในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1378, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(169, 109, 'โปรโมชั่น ซื้อ พาวเวอร์แบงค์ B19 Qmax จำนวน 3 ชิ้น ในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1379, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(170, 109, 'โปรโมชั่น ซื้อ ลำโพงบลูทูธ M79 จำนวน 3 ชิ้น ในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1382, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(171, 109, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ HP-33 จำนวน 2 ชิ้น ในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1385, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(172, 110, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(173, 111, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(174, 112, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 40, NULL),
(175, 112, 'โปรโมชั่น ลำโพง จัดเต็มทุกปาร์ตี้ ', 'promotion_day', 'โปรโมชั่น', 1389, 0, 0, '', 0, 1, 0, '/uploads/20250606/3cf0e72c3994f1cbf09ff888cfe37f91.webp', NULL, 40, NULL),
(176, 113, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(177, 114, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(178, 115, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(179, 116, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(180, 117, 'โปรโมชั่น ซื้อ ฟิล์มกระจก I Phone SE2/3 จำนวน 2 ชิ้น ในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1391, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 40, NULL),
(181, 118, 'โปรโมชั่น ซื้อ ฟิล์มกระจก I Phone SE2/3 จำนวน 2 ชิ้น ในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1391, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 40, NULL),
(182, 118, 'โปรโมชั่น ซื้อ Woody 3 เครื่อง แถม M-22 1 เครื่อง', 'promotion_day', 'โปรโมชั่น', 1505, 0, 0, '', 0, 1, 0, '/uploads/20250709/c9c51e2a800746ef8ee8d20f0a8d07bd.jpg', NULL, 40, NULL),
(183, 119, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 8,000.-', 'promotion_month', 'โปรโมชั่น', 1498, 0, 0, '', 0, 1, 0, '/uploads/20250630/2c9805761e934f2ff34ba341c44268b5.jpg', NULL, 11913, NULL),
(184, 119, 'โปรโมชั่น ซื้อ Set AP-21 10 ชิ้น แถมฟรี AU-51, Film IP14 Plus ', 'promotion_day', 'โปรโมชั่น', 1501, 0, 0, '', 0, 1, 0, '/uploads/20250708/c67791d6a988f306e98c6164bfb369e3.jpg', NULL, 11913, NULL),
(185, 120, 'โปรโมชั่น ซื้อ B19 Plus 2 ชิ้น แถมฟรี S28 2in1 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1503, 0, 0, '', 0, 1, 0, '/uploads/20250708/60759e83d9e1f8de7d17965654e42abd.jpg', NULL, 11913, NULL),
(186, 121, 'โปรโมชั่น ซื้อ ฟิล์มกระจก I Phone SE2/3 จำนวน 2 ชิ้น ในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1391, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(187, 121, 'โปรโมชั่น ซื้อ B19 Plus 2 ชิ้น แถมฟรี S28 2in1 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1503, 0, 0, '', 0, 1, 0, '/uploads/20250708/60759e83d9e1f8de7d17965654e42abd.jpg', NULL, 11913, NULL),
(188, 121, 'โปรโมชั่น ซื้อ AP-03 10 ชิ้น แถมฟรี 3 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1504, 0, 0, '', 0, 1, 0, '/uploads/20250708/2186ea40ed549290ce0ff6e2a0dc04ed.jpg', NULL, 11913, NULL),
(189, 121, 'โปรโมชั่น ซื้อ A102T/ JP-5022 รุ่นละ 3 ชิ้น ราคาพิเศษ', 'promotion_day', 'โปรโมชั่น', 1506, 0, 0, '', 0, 1, 0, '/uploads/20250712/b2d1647805f62d3317c3d252d707f60d.jpg', NULL, 11913, NULL),
(190, 122, 'โปรโมชั่น ซื้อ APP-29 10 ชิ้น แถม AU-50 Qmax 10 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1507, 0, 0, '', 0, 1, 0, '/uploads/20250718/4ae5ac34618cfbaa3da3c5535cf80432.jpg', NULL, 775, NULL),
(191, 123, 'โปรโมชั่น ลำโพง จัดเต็มทุกปาร์ตี้ ', 'promotion_day', 'โปรโมชั่น', 1389, 0, 0, '', 0, 1, 0, '/uploads/20250606/3cf0e72c3994f1cbf09ff888cfe37f91.webp', NULL, 1008, NULL),
(192, 124, 'โปรโมชั่น ซื้อ สินค้า D-power ครบ 2,000.- รับของแถมฟรี', 'promotion_month', 'โปรโมชั่น', 1371, 0, 0, '', 0, 1, 0, '/uploads/20250606/91b2323754d224bf09486d3c2d69a25a.webp', NULL, 1687, NULL),
(193, 125, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 23, NULL),
(194, 126, 'โปรโมชั่น ซื้อ CD-X02/ CD-X06 รุ่นละ 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1168, 0, 0, '', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(196, 132, 'โปรโมชั่น ซื้อ IP-01 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1174, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(197, 132, 'โปรโมชั่น ซื้อ BT-G01 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1175, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(198, 132, 'โปรโมชั่น ซื้อ SF-01/ SF-03/ SF-04 รุ่นละ 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1176, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(199, 132, 'โปรโมชั่น ซื้อ Musical lll 6 ชิ้น แถม ทีวี 24 นิ้ว 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1508, 0, 0, 'P02-ZZ-0720', 0, 1, 0, '/uploads/20250718/e3c099fb46d6c8d477e856ffb432bd3f.jpg', NULL, 11913, NULL),
(200, 132, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', NULL, 11913, NULL),
(201, 132, 'โปรโมชั่น ซื้อ QA-18 20 ชิ้น แถมฟรี 10 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1510, 0, 0, 'P02-ZZ-0722', 0, 1, 0, '/uploads/20250718/4162024844aa4d5024e511efd94b291c.jpg', NULL, 11913, NULL),
(203, 133, 'โปรโมชั่น ซื้อ IP-01 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1174, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(204, 133, 'โปรโมชั่น ซื้อ BT-G01 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1175, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(205, 133, 'โปรโมชั่น ซื้อ สินค้า D-power ครบ 2,000.- รับของแถมฟรี', 'promotion_month', 'โปรโมชั่น', 1371, 0, 0, 'P02-ZZ-0633', 0, 1, 0, '/uploads/20250606/91b2323754d224bf09486d3c2d69a25a.webp', NULL, 11913, NULL),
(206, 133, 'โปรโมชั่น ซื้อ Musical lll 6 ชิ้น แถม ทีวี 24 นิ้ว 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1508, 0, 0, 'P02-ZZ-0720', 0, 1, 0, '/uploads/20250718/e3c099fb46d6c8d477e856ffb432bd3f.jpg', NULL, 11913, NULL),
(207, 133, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', NULL, 11913, NULL),
(208, 134, 'โปรโมชั่น ซื้อ BT-G01 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1175, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(209, 135, 'โปรโมชั่น ซื้อ BT-G01 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1175, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(210, 136, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', NULL, 11913, NULL),
(211, 137, 'โปรโมชั่น ซื้อ สินค้า D-power ครบ 2,000.- รับของแถมฟรี', 'promotion_month', 'โปรโมชั่น', 1371, 0, 0, 'P02-ZZ-0633', 0, 1, 0, '/uploads/20250606/91b2323754d224bf09486d3c2d69a25a.webp', NULL, 11913, NULL),
(212, 138, 'โปรโมชั่น ซื้อ APP-29 10 ชิ้น แถม AU-50 Qmax 10 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1507, 0, 0, 'P02-ZZ-0719', 0, 1, 0, '/uploads/20250718/4ae5ac34618cfbaa3da3c5535cf80432.jpg', NULL, 11913, NULL),
(213, 139, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 5,000.-', 'promotion_month', 'โปรโมชั่น', 1497, 0, 0, 'P02-ZZ-0702', 0, 1, 0, '/uploads/20250630/cae1e8a54d55475e2702109c506c505f.jpg', NULL, 40, NULL),
(214, 140, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1496, 0, 0, 'P02-ZZ-0701', 0, 1, 0, '/uploads/20250630/78d043e83fefa80e87f2e2ffc4546cd4.jpg', NULL, 40, NULL),
(221, 141, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 5,000.-', 'promotion_month', 'โปรโมชั่น', 1497, 0, 0, 'P02-ZZ-0702', 0, 1, 0, '/uploads/20250630/cae1e8a54d55475e2702109c506c505f.jpg', NULL, 11913, NULL),
(222, 142, 'โปรโมชั่น ซื้อ GW-05 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1170, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(223, 143, 'โปรโมชั่น ซื้อ APP-29 10 ชิ้น แถม AU-50 Qmax 10 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1507, 0, 0, 'P02-ZZ-0719', 0, 1, 0, '/uploads/20250718/4ae5ac34618cfbaa3da3c5535cf80432.jpg', NULL, 11913, NULL),
(224, 144, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1496, 0, 0, 'P02-ZZ-0701', 0, 1, 0, '/uploads/20250630/78d043e83fefa80e87f2e2ffc4546cd4.jpg', NULL, 11913, NULL),
(225, 145, 'โปรโมชั่น ซื้อ IP-01 จำนวน 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1174, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 23, NULL),
(226, 146, 'โปรโมชั่น ซื้อ SF-01/ SF-03/ SF-04 รุ่นละ 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1176, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 23, NULL),
(227, 147, 'โปรโมชั่น ซื้อ WC-X01/ WC-X02 รุ่นละ 2 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1172, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(228, 148, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', NULL, 11913, NULL),
(229, 149, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(230, 150, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(231, 166, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(232, 167, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(233, 168, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(234, 168, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', NULL, 11913, NULL),
(235, 169, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', NULL, 11913, NULL),
(236, 169, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', NULL, 11913, NULL),
(237, 170, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(238, 170, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', 0, 11913, NULL),
(239, 177, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(240, 177, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', 0, 11913, NULL),
(241, 178, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(242, 178, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', 0, 11913, NULL),
(243, 179, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(244, 179, 'โปรโมชั่น ซื้อ APP-27 3 ชิ้น แถมฟรี 1 ชิ้น', 'promotion_day', 'โปรโมชั่น', 1509, 0, 0, 'P02-ZZ-0721', 0, 1, 0, '/uploads/20250718/133d25374b050d9aeda3f4751b8b1a22.jpg', 0, 11913, NULL),
(252, 182, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(253, 182, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(255, 181, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(256, 181, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(258, 180, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(259, 180, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(260, 184, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(261, 184, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(262, 185, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(263, 186, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(264, 186, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 0, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(277, 187, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(278, 188, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 5,000.-', 'promotion_month', 'โปรโมชั่น', 1497, 1497, 0, 'P02-ZZ-0702', 0, 0, 1, '/uploads/20250630/cae1e8a54d55475e2702109c506c505f.jpg', 0, 40, NULL),
(281, 189, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 1008, NULL),
(282, 189, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 1008, NULL),
(285, 192, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(286, 193, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 1008, NULL),
(287, 194, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 1008, NULL),
(288, 194, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 1008, NULL),
(289, 195, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 1008, NULL),
(290, 196, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 1513, 0, 'P02-ZZ-0801', 0, 0, 1, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(291, 197, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(292, 197, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(293, 198, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(294, 198, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 0, 1, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(295, 199, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(296, 199, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(297, 200, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 1513, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(298, 201, 'โปรโมชั่น ซื้อ JT-183/ JT-189/ JT-201/ JT-203 รุ่นละ 1 ชิ้น ราคาพิเศษ', 'promotion_day', 'โปรโมชั่น', 1519, 1519, 1, 'P02-ZZ-0806', 0, 2, 0, '/uploads/20250731/8270c8e02271f169b7be29c7c18378da.jpg', 0, 11913, NULL),
(299, 202, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(300, 202, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(301, 203, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 1008, NULL),
(302, 203, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 1008, NULL),
(303, 204, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 1513, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(304, 204, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(305, 205, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 1513, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(306, 205, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(307, 206, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 1513, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(308, 206, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(309, 218, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(310, 218, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 0, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(312, 219, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(313, 219, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 0, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(315, 220, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(316, 221, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(317, 222, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(318, 223, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(319, 224, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(320, 225, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(321, 226, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(322, 227, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(323, 228, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(324, 229, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(325, 230, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(326, 231, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(327, 232, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(328, 233, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(329, 234, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(330, 235, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(331, 236, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(333, 238, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 3,000.-', 'promotion_month', 'โปรโมชั่น', 1513, 0, 0, 'P02-ZZ-0801', 0, 1, 0, '/uploads/20250731/4a711a28b20be48b8dea310b633038d9.jpg', 0, 11913, NULL),
(334, 238, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(335, 238, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(336, 237, 'โปรโมชั่น ซื้อสินค้า D-Power ครบ 5,000.-', 'promotion_month', 'โปรโมชั่น', 1514, 1514, 0, 'P02-ZZ-0802', 0, 1, 0, '/uploads/20250731/1e6074bdc8d115a6bd289cbfda625a53.jpg', 0, 11913, NULL),
(337, 237, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(338, 237, 'โปรโมชั่น ซื้อ กาพ่นสี AJ SG-001 จำนวน 5 เครื่อง แถมฟรี 1 เครื่อง ', 'promotion_day', 'โปรโมชั่น', 1316, 1316, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250530/0ae85b25ea54886cb008fe5823d493f9.webp', 0, 11913, NULL),
(340, 239, 'PROMOTION ซื้อ JT183/189/201/203 รุ่นละ 1ชิ้น ราคา 4200 บาท/เซ็ต 2025', 'promotion_day', 'โปรโมชั่น', 1519, 0, 1, 'P02-ZZ-0806', 0, 1, 0, '/uploads/20250731/8270c8e02271f169b7be29c7c18378da.jpg', 0, 11913, NULL),
(341, 239, 'Test ซื้อ MY HOME BBQ3101 จำนวน 12 ชิ้น รับส่วนลด 500 บาท', 'promotion_day', 'โปรโมชั่น', 1527, 0, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250806/2e75739bda43767ec2a5eb998fe25796.png', 0, 11913, NULL),
(343, 240, 'PROMOTION ซื้อ JT183/189/201/203 รุ่นละ 1ชิ้น ราคา 4200 บาท/เซ็ต 2025', 'promotion_day', 'โปรโมชั่น', 1519, 0, 1, 'P02-ZZ-0806', 0, 1, 0, '/uploads/20250731/8270c8e02271f169b7be29c7c18378da.jpg', 0, 11913, NULL),
(347, 239, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(348, 240, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 1209, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 11913, NULL),
(349, 240, 'Test ซื้อ MY HOME BBQ3101 จำนวน 12 ชิ้น รับส่วนลด 500 บาท', 'promotion_day', 'โปรโมชั่น', 1527, 1527, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250806/2e75739bda43767ec2a5eb998fe25796.png', 0, 11913, NULL),
(350, 241, 'โปรโมชั่น ซื้อ หูฟังบลูทูธ BT-G22 จำนวน 3 ชิ้น ขึ้นไปในราคาขายส่ง', 'promotion_day', 'โปรโมชั่น', 1209, 0, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250527/f5893e2a4d9212ee9ac0a818081f0e24.webp', 0, 23, NULL),
(351, 241, 'PROMOTION ซื้อ GA1H-01A/GA1H-01BS รุ่นละ 3ชิ้น ราคา 1800 บาท/เซ็ต 2025', 'promotion_day', 'โปรโมชั่น', 1515, 0, 1, 'P02-ZZ-0803', 0, 1, 0, '/uploads/20250802/2840b574fdacbf84ca3929fae2eff3b1.jpg', 0, 23, NULL),
(352, 242, 'TEST ซื้อสินค้า DP ครบ 12,000 บาท แถมฟรี Mello 1 ชิ้น รับส่วนลด 1,000 บาท', 'promotion_month', 'โปรโมชั่น', 1522, 0, 0, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250806/2e75739bda43767ec2a5eb998fe25796.png', 0, 23, NULL),
(353, 242, 'PROMOTION ซื้อ GA1H-01A/GA1H-01BS รุ่นละ 3ชิ้น ราคา 1800 บาท/เซ็ต 2025', 'promotion_day', 'โปรโมชั่น', 1515, 0, 1, 'P02-ZZ-0803', 0, 1, 0, '/uploads/20250802/2840b574fdacbf84ca3929fae2eff3b1.jpg', 0, 23, NULL),
(354, 244, 'PROMOTION ซื้อ GA1H-01A/GA1H-01BS รุ่นละ 3ชิ้น ราคา 1800 บาท/เซ็ต 2025', 'promotion_day', 'โปรโมชั่น', 1515, 0, 1, 'P02-ZZ-0803', 0, 1, 0, '/uploads/20250802/2840b574fdacbf84ca3929fae2eff3b1.jpg', 0, 350, NULL),
(355, 244, 'PROMOTION ซื้อ CP100/A102T รุ่นละ 6ชิ้น ราคา 3600 บาท/เซ็ต 2025', 'promotion_day', 'โปรโมชั่น', 1516, 0, 1, 'P02-ZZ-0804', 0, 1, 0, '/uploads/20250802/c6e89cfc7a9d9df160939fbcb85485b9.jpg', 0, 350, NULL),
(356, 245, 'Test ซื้อ MY HOME BBQ3101 จำนวน 12 ชิ้น รับส่วนลด 500 บาท', 'promotion_day', 'โปรโมชั่น', 1527, 0, 1, 'P02-ZZ-9999', 0, 1, 0, '/uploads/20250806/2e75739bda43767ec2a5eb998fe25796.png', 0, 11913, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `so_delivery_address`
--

CREATE TABLE `so_delivery_address` (
  `id` int(11) NOT NULL,
  `customer_code` varchar(50) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `address_line1` text DEFAULT NULL,
  `address_line2` text DEFAULT NULL,
  `address_line3` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `zone_code` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `so_delivery_address`
--

INSERT INTO `so_delivery_address` (`id`, `customer_code`, `order_id`, `customer_id`, `address_line1`, `address_line2`, `address_line3`, `phone`, `zone_code`, `created_at`) VALUES
(49, 'AP00111913', NULL, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 13:42:26'),
(50, 'AP00111913', NULL, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 14:23:40'),
(51, 'AP00111913', NULL, '11913', 'ffsfsd', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 16:01:44'),
(52, 'AP00111913', NULL, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 20:22:26'),
(53, 'AP00111913', NULL, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 20:33:37'),
(54, 'AP00111913', NULL, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 20:38:32'),
(55, 'AP00111913', NULL, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 20:52:59'),
(56, 'AP00111913', 106, '55', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 20:53:32'),
(57, 'AP00111913', NULL, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-11 20:59:04'),
(58, 'AP00111913', 107, '11913', 'ถนนปากน้ำ', 'แขวง ปากน้ำ เมืองสมุทรปราการ', 'สมุทรปราการ', '0638606865', '', '2025-07-11 23:30:55'),
(59, 'AP00111913', 108, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-12 08:22:51'),
(60, 'AP00111913', 109, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-12 08:27:20'),
(61, 'AP00111913', 110, '11913', 'asdasd', 'แขวง วชิรพยาบาล เขตดุสิต', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-12 13:53:20'),
(62, 'AP00111913', 111, '11913', 'SADASD', 'แขวง ลาดกระบัง เขตลาดกระบัง', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-12 14:05:27'),
(63, 'C03290', 112, '40', '1010/1010', 'แขวง  เขตสะพานสูง', 'กรุงเทพมหานคร', '0851195429', '', '2025-07-12 14:09:43'),
(64, 'AP00111913', 113, '11913', 'sadas', 'แขวง เทพารักษ์ เมืองสมุทรปราการ', 'สมุทรปราการ', '0638606865', '', '2025-07-12 18:27:38'),
(65, 'AP00111913', 114, '11913', 'dasdasd', 'แขวง บ้านระกาศ บางบ่อ', 'สมุทรปราการ', '0638606865', '', '2025-07-12 18:30:52'),
(66, 'AP00111913', 115, '11913', 'adadsda', 'แขวง ดุสิต เขตดุสิต', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-12 18:36:52'),
(67, 'AP00111913', 116, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-14 09:23:10'),
(68, 'C03290', 117, '40', '99', 'แขวง บ้านระกาศ บางบ่อ', 'สมุทรปราการ', '0851195429', '', '2025-07-14 09:26:48'),
(69, 'C03290', 118, '40', '99', 'แขวง บ้านระกาศ บางบ่อ', 'สมุทรปราการ', '0851195429', '', '2025-07-14 09:26:48'),
(70, 'AP00111913', 119, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-15 13:12:34'),
(71, 'AP00111913', 120, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-18 09:10:07'),
(72, 'AP00111913', 121, '11913', 'เลขที่ 191 อาคารสีลมคอมเพล็กซ์ ชั้น 24 ห้อง 5', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-18 09:22:21'),
(73, 'C04277', 122, '775', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0926484269', '', '2025-07-22 15:30:42'),
(74, 'C04366', 123, '1008', 'ถนนสีลม', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0884449959', '', '2025-07-23 08:25:16'),
(75, 'C03519', 124, '1687', 'ถนนสีลม', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0866471575', '', '2025-07-23 13:25:52'),
(76, 'AP00025202', 125, '23', 'TEST', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0629352962', '', '2025-07-24 13:10:42'),
(77, 'AP00111913', 126, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-24 23:07:26'),
(78, 'AP00111913', 127, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 01:13:39'),
(79, 'AP00111913', 128, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 01:13:54'),
(80, 'AP00111913', 129, '11913', 'test', 'แขวง อนุสาวรีย์ เขตบางเขน', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 01:17:39'),
(81, 'AP00111913', 130, '11913', 'test', 'แขวง อนุสาวรีย์ เขตบางเขน', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 01:19:48'),
(82, 'AP00111913', 131, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 01:28:45'),
(83, 'AP00111913', 132, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 01:38:34'),
(84, 'AP00111913', 133, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 01:50:44'),
(85, 'AP00111913', 134, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 01:57:39'),
(86, 'AP00111913', 135, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 02:19:15'),
(87, 'AP00111913', 136, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 02:21:24'),
(88, 'AP00111913', 137, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 08:08:45'),
(89, 'AP00111913', 138, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 08:11:26'),
(90, 'C03290', 139, '40', '99', 'แขวง เทพารักษ์ เมืองสมุทรปราการ', 'สมุทรปราการ', '0851195429', '', '2025-07-25 09:46:52'),
(91, 'C03290', 140, '40', '22', 'แขวง เทพารักษ์ เมืองสมุทรปราการ', 'สมุทรปราการ', '0851195429', '', '2025-07-25 09:50:46'),
(92, 'AP00111913', 141, '11913', 'test', 'แขวง บางพลีใหญ่ บางพลี', 'สมุทรปราการ', '0638606865', '', '2025-07-25 09:55:45'),
(93, 'AP00111913', 142, '11913', 'สีลม', 'แขวง มหาพฤฒาราม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 10:31:24'),
(94, 'AP00111913', 143, '11913', 'สีลม', 'แขวง บางขุนพรหม เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 10:39:32'),
(95, 'AP00111913', 144, '11913', 'test', 'แขวง หนองจอก เขตหนองจอก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 10:47:08'),
(96, 'AP00025202', 145, '23', '55', 'แขวง เสือโฮก เมืองชัยนาท', 'ชัยนาท', '0629352962', '', '2025-07-25 10:54:09'),
(97, 'AP00025202', 146, '23', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0629352962', '', '2025-07-25 11:40:05'),
(98, 'AP00111913', 147, '11913', 'test', 'แขวง สุริยวงศ์ เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 11:42:10'),
(99, 'AP00111913', 148, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 11:45:22'),
(100, 'AP00111913', 149, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 11:48:13'),
(101, 'AP00111913', 150, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 11:54:06'),
(102, 'AP00111913', 151, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 13:18:54'),
(103, 'AP00111913', 152, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 13:22:34'),
(104, 'AP00111913', 153, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 14:09:35'),
(105, 'AP00111913', 154, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 14:16:53'),
(106, 'AP00111913', 155, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 14:45:13'),
(107, 'AP00111913', 156, '11913', 'test', 'แขวง สีลม เขตบางรัก', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 15:04:35'),
(108, 'AP00111913', 157, '11913', '0', 'แขวง ท้ายบ้านใหม่ เมืองสมุทรปราการ', 'สมุทรปราการ', '0638606865', '', '2025-07-25 15:08:15'),
(109, 'AP00111913', 158, '11913', 'test', 'แขวง บางขุนพรหม เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 15:25:42'),
(110, 'AP00111913', 159, '11913', 'pro_discount', 'แขวง ท้ายบ้านใหม่ เมืองสมุทรปราการ', 'สมุทรปราการ', '0638606865', '', '2025-07-25 15:31:31'),
(111, 'AP00111913', 160, '11913', 'pro_discount', 'แขวง บางขุนพรหม เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 15:33:53'),
(112, 'AP00111913', 161, '11913', 'test', 'แขวง บางขุนพรหม เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 15:37:44'),
(113, 'AP00111913', 162, '11913', 'totalDiscount', 'แขวง ดุสิต เขตดุสิต', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 15:41:31'),
(114, 'AP00111913', 163, '11913', 'discount', 'แขวง เทพารักษ์ เมืองสมุทรปราการ', 'สมุทรปราการ', '0638606865', '', '2025-07-25 15:46:08'),
(115, 'AP00111913', 164, '11913', 'discount_qty,', 'แขวง บางขุนพรหม เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 15:48:49'),
(116, 'AP00111913', 165, '11913', 'test', 'แขวง บางขุนพรหม เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 16:01:01'),
(117, 'AP00111913', 166, '11913', 'test', 'แขวง บ้านพานถม เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 16:11:21'),
(118, 'AP00111913', 167, '11913', 'สตึก', 'แขวง สตึก สตึก', 'บุรีรัมย์', '0638606865', '', '2025-07-25 16:20:00'),
(119, 'AP00111913', 168, '11913', 'test', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 16:39:26'),
(120, 'AP00111913', 169, '11913', 'test', 'แขวง ศาลเจ้าพ่อเสือ เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-25 20:47:55'),
(121, 'AP00111913', 170, '11913', 'test', 'แขวง ปากน้ำ เมืองสมุทรปราการ', 'สมุทรปราการ', '0638606865', '', '2025-07-25 21:00:03'),
(122, 'AP00111913', 171, '11913', 'test', 'แขวง วังบูรพาภิรมย์ เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 06:58:11'),
(123, 'AP00111913', 172, '11913', 'pro_id', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 06:59:30'),
(124, 'AP00111913', 173, '11913', 'pro_id', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 06:59:55'),
(125, 'AP00111913', 174, '11913', 'pro_id', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 07:00:54'),
(126, 'AP00111913', 175, '11913', 'pro_id', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 07:01:06'),
(127, 'AP00111913', 176, '11913', 'asdadas', 'แขวง บ้านระกาศ บางบ่อ', 'สมุทรปราการ', '0638606865', '', '2025-07-26 07:01:42'),
(128, 'AP00111913', 177, '11913', 'asdadas', 'แขวง บ้านระกาศ บางบ่อ', 'สมุทรปราการ', '0638606865', '', '2025-07-26 07:11:07'),
(129, 'AP00111913', 178, '11913', 'test', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 08:15:59'),
(130, 'AP00111913', 179, '11913', 'pro_sku_price_id', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 08:17:52'),
(131, 'AP00111913', 180, '11913', 'test', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 09:17:29'),
(132, 'AP00111913', 181, '11913', 'test', 'แขวง พระบรมมหาราชวัง เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 09:38:08'),
(133, 'AP00111913', 182, '11913', 'test', 'แขวง วังบูรพาภิรมย์ เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-26 09:41:00'),
(134, 'AP00111913', 183, '11913', 'test', 'แขวง วัดสามพระยา เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-27 17:24:30'),
(135, 'AP00111913', 184, '11913', 'test', 'แขวง วัดสามพระยา เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-27 17:28:34'),
(136, 'AP00111913', 185, '11913', 'test', 'แขวง วังบูรพาภิรมย์ เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-27 17:43:11'),
(137, 'AP00111913', 186, '11913', 'test', 'แขวง บางโปรง เมืองสมุทรปราการ', 'สมุทรปราการ', '0638606865', '', '2025-07-27 17:52:00'),
(138, 'AP00111913', 187, '11913', 'test', 'แขวง ชนะสงคราม เขตพระนคร', 'กรุงเทพมหานคร', '0638606865', '', '2025-07-27 19:55:05'),
(139, 'C03290', 188, '40', '99', 'แขวง จักรวรรดิ เขตสัมพันธวงศ์', 'กรุงเทพมหานคร', '0851195429', '', '2025-07-29 09:26:13'),
(140, 'AP00111913', 212, '11913', '12', 'แขวง ลำตะเคียน ผักไห่', 'พระนครศรีอยุธยา', '0638606865', '', '2025-08-03 19:33:48'),
(141, 'AP00111913', 213, '11913', '12', 'แขวง ลำตะเคียน ผักไห่', 'พระนครศรีอยุธยา', '0638606865', '', '2025-08-03 19:41:09'),
(142, 'AP00111913', 214, '11913', '12', 'แขวง ลำตะเคียน ผักไห่', 'พระนครศรีอยุธยา', '0638606865', '', '2025-08-03 19:43:00'),
(143, 'AP00111913', 215, '11913', '12', 'แขวง ลำตะเคียน ผักไห่', 'พระนครศรีอยุธยา', '0638606865', '', '2025-08-03 19:46:30'),
(144, 'AP00111913', 216, '11913', '12', 'แขวง ลำตะเคียน ผักไห่', 'พระนครศรีอยุธยา', '0638606865', '', '2025-08-03 19:46:59'),
(145, 'AP00111913', 217, '11913', '12', 'แขวง ลำตะเคียน ผักไห่', 'พระนครศรีอยุธยา', '0638606865', '', '2025-08-03 19:48:42'),
(146, 'AP00111913', 218, '11913', '12', 'แขวง ลำตะเคียน ผักไห่', 'พระนครศรีอยุธยา', '0638606865', '', '2025-08-03 19:52:14'),
(147, 'AP00111913', 228, '11913', 'ดกดฟ', 'แขวง ต้นตาล เสาไห้', 'สระบุรี', '0638606865', '', '2025-08-04 16:25:55'),
(148, 'AP00111913', 229, '11913', 'ดกดฟ', 'แขวง ต้นตาล เสาไห้', 'สระบุรี', '0638606865', '', '2025-08-04 16:29:31'),
(149, 'AP00111913', 230, '11913', 'ดกดฟ', 'แขวง ต้นตาล เสาไห้', 'สระบุรี', '0638606865', '', '2025-08-04 16:33:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documentrunning`
--
ALTER TABLE `documentrunning`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `prefix` (`prefix`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`,`telephone`),
  ADD UNIQUE KEY `emp_ids_Relationship` (`emp_ids`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_item`
--
ALTER TABLE `sale_item`
  ADD PRIMARY KEY (`item_id`),
  ADD UNIQUE KEY `item_code` (`item_code`);

--
-- Indexes for table `sale_list`
--
ALTER TABLE `sale_list`
  ADD PRIMARY KEY (`sale_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `sale_order`
--
ALTER TABLE `sale_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_order_gifts`
--
ALTER TABLE `sale_order_gifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `fk_item_gift` (`item_id`);

--
-- Indexes for table `sale_order_items`
--
ALTER TABLE `sale_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order` (`order_id`);

--
-- Indexes for table `sale_order_promotions`
--
ALTER TABLE `sale_order_promotions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `fk_promo_item` (`item_id`);

--
-- Indexes for table `so_delivery_address`
--
ALTER TABLE `so_delivery_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_id` (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `documentrunning`
--
ALTER TABLE `documentrunning`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sale_item`
--
ALTER TABLE `sale_item`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสไอเท็ม', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sale_list`
--
ALTER TABLE `sale_list`
  MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสรายการขาย', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sale_order`
--
ALTER TABLE `sale_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- AUTO_INCREMENT for table `sale_order_gifts`
--
ALTER TABLE `sale_order_gifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- AUTO_INCREMENT for table `sale_order_items`
--
ALTER TABLE `sale_order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1007;

--
-- AUTO_INCREMENT for table `sale_order_promotions`
--
ALTER TABLE `sale_order_promotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=357;

--
-- AUTO_INCREMENT for table `so_delivery_address`
--
ALTER TABLE `so_delivery_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sale_list`
--
ALTER TABLE `sale_list`
  ADD CONSTRAINT `sale_list_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `sale_item` (`item_id`) ON UPDATE CASCADE;

--
-- Constraints for table `sale_order_gifts`
--
ALTER TABLE `sale_order_gifts`
  ADD CONSTRAINT `fk_item_gift` FOREIGN KEY (`item_id`) REFERENCES `sale_order_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_order_gifts_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `sale_order` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_order_items`
--
ALTER TABLE `sale_order_items`
  ADD CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `sale_order` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_order_promotions`
--
ALTER TABLE `sale_order_promotions`
  ADD CONSTRAINT `fk_item_promo` FOREIGN KEY (`item_id`) REFERENCES `sale_order_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_order_promotions_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `sale_order` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `so_delivery_address`
--
ALTER TABLE `so_delivery_address`
  ADD CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `sale_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
