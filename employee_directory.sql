-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 23, 2026 at 08:06 PM
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
-- Database: `employee_directory`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `department` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `joining_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `email`, `phone`, `department`, `designation`, `avatar_url`, `joining_date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Sophia Rodriguez', 'sophia.rodriguez@example.com', '+1-555-0101', 'Engineering', 'VP of Engineering', 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&auto=format&fit=crop&q=80', '2019-06-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(2, 'Liam Chen', 'liam.chen@example.com', '+1-555-0102', 'Engineering', 'Staff Backend Architect', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80', '2020-01-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(3, 'Olivia Smith', 'olivia.smith@example.com', '+1-555-0103', 'Human Resources', 'HR Director', 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=150&auto=format&fit=crop&q=80', '2018-08-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(4, 'Noah Williams', 'noah.williams@example.com', '+1-555-0104', 'DevOps & Cloud', 'Lead Infrastructure Engineer', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80', '2021-03-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(5, 'Emma Johnson', 'emma.johnson@example.com', '+1-555-0105', 'Product', 'Head of Product', 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80', '2017-09-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(6, 'Ethan Brown', 'ethan.brown@example.com', '+1-555-0106', 'Engineering', 'Senior Flutter Engineer', 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=150&auto=format&fit=crop&q=80', '2024-05-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(7, 'Ava Davis', 'ava.davis@example.com', '+1-555-0107', 'Design', 'Lead UI/UX Designer', 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&auto=format&fit=crop&q=80', '2024-12-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(8, 'Mason Miller', 'mason.miller@example.com', '+1-555-0108', 'Engineering', 'Full Stack Developer', 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=150&auto=format&fit=crop&q=80', '2022-10-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(9, 'Isabella Wilson', 'isabella.wilson@example.com', '+1-555-0109', 'Product', 'Product Manager', 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&auto=format&fit=crop&q=80', '2022-07-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(10, 'Lucas Martinez', 'lucas.martinez@example.com', '+1-555-0110', 'Quality Assurance', 'QA Automation Engineer', 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=150&auto=format&fit=crop&q=80', '2026-02-23', 1, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(11, 'Alexander Taylor', 'alexander.taylor@example.com', '+1-555-0111', 'Engineering', 'Former Principal Architect', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&auto=format&fit=crop&q=80', '2019-09-23', 0, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(12, 'Mia Anderson', 'mia.anderson@example.com', '+1-555-0112', 'Marketing', 'Former Growth Lead', 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=150&auto=format&fit=crop&q=80', '2020-06-23', 0, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(13, 'Benjamin Thomas', 'benjamin.thomas@example.com', '+1-555-0113', 'Sales', 'Former Account Executive', 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150&auto=format&fit=crop&q=80', '2025-07-23', 0, '2026-09-23 10:32:28', '2026-09-23 10:32:28'),
(14, 'Bruce Wayne', 'bruce.wayne@example.com', '+1-555-0999', 'Engineering', 'Principal Architect', NULL, '2018-01-15', 1, '2026-09-23 10:58:46', '2026-09-23 10:58:46'),
(15, 'Clark Kent', 'clark.kent@example.com', '+1-555-0888', 'Marketing', 'Content Lead', NULL, '2024-03-01', 1, '2026-09-23 10:59:51', '2026-09-23 10:59:51'),
(16, 'Bruce Wayne', 'bruce@wayne.com', '8996966468', 'Engineering', 'Chief Architect', NULL, '2017-09-23', 1, '2026-09-23 12:14:47', '2026-09-23 12:14:47'),
(17, 'test', 'test@gmail.com', NULL, 'Product', 'designer', NULL, '2018-09-23', 1, '2026-09-23 12:22:59', '2026-09-23 12:22:59'),
(18, 'Alexander', 'alexander@gmail.com', NULL, 'Human Resources', 'HR', NULL, '2017-09-23', 1, '2026-09-23 12:28:10', '2026-09-23 12:28:10');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_01_01_000001_create_employees_table', 1),
(2, '2024_01_01_000002_create_database_support_tables', 1),
(3, '2024_01_01_000002_create_sessions_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('oLoHDB1S0kEw1sq79sU4y5irzdZF2lJr8dLhDhoT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.139.0 Chrome/150.0.7871.250 Electron/43.6.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYjV5bmxQQ1M0WTMzdVpRMjhmbEtMQU11UlR1UlI1TzFKR3Rnell4SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1790179443),
('svATvDKMPk9YdQPFh3LoXTWTJoiqS6wp9TNs39xc', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2RSQ3NNY0plcmtsTFdXSEtTYWVhR2pJaWRrQThPVmowRkRhRDlIZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1790179486);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_email_unique` (`email`),
  ADD KEY `employees_is_active_index` (`is_active`),
  ADD KEY `employees_joining_date_index` (`joining_date`),
  ADD KEY `employees_department_index` (`department`),
  ADD KEY `employees_is_active_joining_date_index` (`is_active`,`joining_date`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
