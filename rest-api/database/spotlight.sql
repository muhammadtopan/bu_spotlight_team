-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2022 at 02:08 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spotlight`
--

-- --------------------------------------------------------

--
-- Table structure for table `balances`
--

CREATE TABLE `balances` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('pending','success') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `balances`
--

INSERT INTO `balances` (`id`, `user_id`, `bank_id`, `amount`, `title`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 2022082701001, 2, 0, 'init bank BRI', 'menambah akun bank user agen x', 'success', '2022-09-11 09:07:18', '2022-10-23 05:14:34'),
(2, 2022082701001, 2, 50000000, 'Debit', 'tambah saldo Rp 50.000.000 dari admin', 'success', '2022-09-11 09:07:18', '2022-10-23 05:14:40'),
(4, 2022082701001, 2, -8400000, 'Kredit', 'Pembayaran stok produk', 'success', '2022-09-11 03:12:18', '2022-10-23 05:14:41'),
(7, 2022082701004, 2, 450000, 'Debit', 'Pembatalan stok produk', 'success', '2022-09-14 10:49:27', '2022-10-23 05:14:42'),
(8, 2022082701001, 5, 0, 'init bank Mandiri', 'menambah akun bank user agen x', 'success', '2022-09-11 09:07:18', '2022-09-11 09:20:25'),
(9, 2022082701001, 5, 20000000, 'Debit', 'tambah saldo Rp 20.000.000 dari admin', 'success', '2022-09-11 09:07:18', '2022-09-11 09:20:25'),
(10, 2022082701001, 1, 0, 'init bank Mandiri', 'menambah akun bank user agen x', 'success', '2022-09-11 09:07:18', '2022-09-11 09:20:25'),
(11, 2022082701001, 1, 10000000, 'Debit', 'tambah saldo Rp 10.000.000 dari admin', 'success', '2022-09-11 09:07:18', '2022-09-11 09:20:25'),
(13, 2022082701001, 2, 100000, 'Debit', 'tambah saldo Rp 100.000 dari admin', 'pending', '2022-10-23 00:00:00', '2022-10-22 23:48:40'),
(14, 2022082701001, 1, 100000, 'Debit', 'Tambah saldo Rp 100.000 dari admin', 'pending', '2022-11-07 00:00:00', '2022-11-07 14:11:03'),
(15, 2022082701001, 1, 100000, 'Debit', 'Tambah saldo Rp 100.000 dari admin', 'pending', '2022-11-07 00:00:00', '2022-11-07 14:11:06'),
(16, 2022082701001, 1, 20000, 'Debit', 'Tambah saldo Rp 20.000 dari admin', 'pending', '2022-11-07 00:00:00', '2022-11-07 14:12:27'),
(17, 2022082701001, 1, 20000, 'Debit', 'Tambah saldo Rp 20.000 dari admin', 'pending', '2022-11-07 00:00:00', '2022-11-07 14:12:29');

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` int(11) NOT NULL,
  `bank` varchar(50) NOT NULL,
  `logo` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `bank`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'Cash', '', '2022-09-11 09:05:16', '2022-10-23 05:14:12'),
(2, 'BRI', '/img/logos/bri.png', '2022-09-11 09:05:16', '2022-10-23 05:14:12'),
(3, 'BNI', '/img/logos/bni.png', '2022-09-11 09:05:16', '2022-10-23 05:10:24'),
(4, 'BCA', '/img/logos/bca.png', '2022-09-11 09:05:16', '2022-10-23 05:10:23'),
(5, 'Mandiri', '/img/logos/mandiri.png', '2022-09-11 09:05:16', '2022-10-23 05:10:21');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `item` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `nominal` bigint(20) NOT NULL,
  `type_trans` enum('transfer','cash') NOT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `user_id`, `item`, `category`, `nominal`, `type_trans`, `bank`, `created_at`, `updated_at`) VALUES
(2, 2022082701001, 'tes', 'Reward', 12000, 'transfer', 'BNI', '2022-10-23 22:29:00', '2022-10-23 15:30:10'),
(4, 2022082701008, 'galon 2', 'Konsumsi', 5000, 'cash', NULL, '2022-11-27 07:11:00', '2022-11-28 19:10:03');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(2, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(3, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(4, '2016_06_01_000004_create_oauth_clients_table', 1),
(5, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(6, '2022_03_15_090428_create_users_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('07b0e3c86498865224be51042d799f2620e83af6a41bac10be660e668696f9a0a5169b21ed8cbaff', 2022082701, 2, NULL, '[]', 0, '2022-12-04 16:27:47', '2022-12-04 16:27:47', '2023-12-04 16:27:47'),
('249395e25acf21fe513f8c15c658503a757bdddb987de1d851390b13d692a47904ec5e11a2072de2', 2022082701002, 2, NULL, '[]', 0, '2022-08-27 16:51:58', '2022-08-27 16:51:58', '2023-08-27 16:51:58'),
('be08c9023ee7676e74be183f1669f56744a226345aeae61f042230a8b94c0cf64146559785288afe', 2, 2, NULL, '[]', 0, '2022-08-27 14:50:37', '2022-08-27 14:50:37', '2023-08-27 14:50:37');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Lumen Personal Access Client', 'sZT0qbkYVC3Zvtl9IRQNnoAoLllSWV8LccCmbytG', NULL, 'http://localhost', 1, 0, 0, '2022-08-03 23:47:45', '2022-08-03 23:47:45'),
(2, NULL, 'Lumen Password Grant Client', 'vqkV6BLXrN20wgEdQtMuRX5N2sCBnRpx7BjsOOI5', 'users', 'http://localhost', 0, 1, 0, '2022-08-03 23:47:45', '2022-08-03 23:47:45');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2022-08-03 23:47:45', '2022-08-03 23:47:45');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
('0415c4a4a54b5d9ec91b6363467e8560e5773a0429ba527f066bb379f72c88a236ded8e1591f92ac', '739d91b995ba67055fb3dfe866fe2a7ce7e719bdf70585ade4bf0834c51561bd03629edd40de78bf', 0, '2023-11-10 12:29:30'),
('04bf0fefbfdbea93b88eeffffe6bfdd563219fee84a6d0379c2576936886d873197ef5634b850c07', 'e090405bc7b91e49f9598fda87b1f2208ecceaeaa6f14c968684f4121e8ce9623beffd006c2920a1', 0, '2023-08-26 03:15:44'),
('071eff5c54b02eaadedf8a67674d9d57aa25b09d136b06d77ec26a966b3bd330752b065384152a5e', '410ebacbeddd1ce9687c815df78b48380da25e91e7f1a5fd88640afb11a05ad6526667678e3e3e27', 0, '2023-08-27 16:49:01'),
('09401def7c2d9251268843115deaef1f41f6f22ec93cbcc67a11fc013957434484b03dec38bb45e8', '168e3336aebe83e687aa375e524417ee29e2a89650e68e9151759874fd62f7f5b620c8e28d994f27', 0, '2023-12-04 16:27:11'),
('09c3a7d70c8ee55b436ada7a22e0b42986f73be2599830993a16d9a6a698d8b2e9172f20a0c47656', 'e7b070e9c10ebc450de129db008f7cdd82bd5705128f9fa278768322fd5bd8eff6b5b78cdf37bdfb', 0, '2023-08-27 15:29:32'),
('0b6ad66431020bc14599d9216be51078cf0eae93e46da9adae978666a1c914ef1e9eaa136004a462', '50e2b802cb970bf2a6b41c24e59c119acad3945bd870e4b75229b14b751ecb97e29158e12e648605', 0, '2023-08-28 11:25:37'),
('0dfee84fac4b3db64a013bf8e51b4966179cf819c96d754f8a311a762a9d5b1102515dfc3f1b8d41', 'ef97016349fa4864b0ca5fefa9047bcb7ca2f8581f2e299eede9d0dc4e5ba7c37d19010267355dc3', 0, '2023-08-31 12:09:27'),
('0e1b8148d657415e6132c477d3f10be80c99a07ee62f5f0dd1e262dab083d359897c961227eb8243', '206f1162d2d53983e95010e1cd6a3d702bdc990fcb0922d67425371e71266257ba740ff7f85aaa4d', 0, '2023-08-08 18:53:41'),
('107eebfc7031d96f86c3db24058bc44440794a98955926f80805d42ee0a5f83b48a58fdda244abc4', '94660079493f9f2938b889fe93abaef9c3e7cdd4d6fc30215e8ad65ab0149be30d1b0ab025981c92', 0, '2023-08-19 19:49:45'),
('14ab5f42e9bd38c5204fcf5bf33dabfa22dcc32e583daf00484ffa9e76c3e64470130dc73a3616b3', '70124282ef0f177d297773faa383650e6e8357f40bf41ac72ebe7d330da99d7f7bfad1d0218444fa', 0, '2023-12-04 16:05:31'),
('1a7319ca7bf0f9193b90fe247214edcde22e6e2a723cd5c836c5287b0f15b1484abfa3819a0f50a6', 'ac9ae4f90c252eb4a8ff9563b183290acab05e2e2170c157faf3d8604e6eff8e73f83192032e09c0', 0, '2023-08-08 19:11:50'),
('218c5b0ba08f15a7266533ee6aadda2adb17fd36c2338108d46370a6b14d48910b3dd35224225a63', '1bd10fbfbb57be1b0b176ed9b167beb0f015e18160938b2f08a11161b42a823ab9ade286fb92a69f', 0, '2023-08-29 08:00:51'),
('226ee178055a73ad7c698c3e361fb6764bc8f2335c554767d15d67ecdd872b46ad41a3cbabf24ed5', 'b26a01302e600dc180a3e0d0d6cd88518e7d51cdc104222ece29fff07137a61facb516664717ed83', 0, '2023-09-08 09:51:18'),
('2e834d295446efd3616a3949e04e79a1221a6bb2fdaacbba9a931b349a74e0b9052ab43679e722c3', 'd5847cb39ed01417982bbf866d0c0c6581438a9bbaca1179bcc156d3ac53a9eed7a9bb4f2ddac27f', 0, '2023-11-28 21:58:27'),
('3108ee183983e9420d48add09f4fac7ad16f3f0486f74e5b3e7acc54cbf60e99a079e20af81a2c9e', 'f03733fb3f88fe6d45821f6b14a72cd9a114fc2828a0158b5e9a6cd851e350b6512a85dad966e555', 0, '2023-10-22 21:18:08'),
('315ec144bfe831714cb175580ff7b1b9ff97f7bf72a54b1bf7065ad63430509b24534c9f0c2e17fb', '2f59471d3b70c979f3e5388c8b9d699e0fef06ebab1b81200dca05f1259d7dbd1915fe54c0a7d6ff', 0, '2023-11-23 22:53:17'),
('34ff3871c4b07c7ffe5268b1212e5ef8757d1ef742211cf36f8b9ce195b3693552badb21baa36cb4', '9ae856943cd4489c2514ae40fe8732f1f47aa8b676c1f4407e56faeed38eb3fdbaa78b7a81c262fd', 0, '2023-10-23 19:51:48'),
('35b1bb98c6950c1019fcf2fe4ad22ce629c49602d42cc9c2ea4e719f555aa31f0df62bfb5e5fa872', '1cf9aa3e9e52a4fe689bba1453ad2cf065bdd8e0b1a910ed286a399fcb809ce83764594f8a7e9b85', 0, '2023-12-04 16:13:18'),
('3b6afad162e82ea88acf2b60111f39bdc45055b8b05ec13500d629597316eb05fe538a49098f54dd', '58bcf1b898d0b062a7726662b6cbad0b17b43f64dd23442e53eaac50fec76b31db08366879b7b832', 0, '2023-12-04 15:34:03'),
('3b6d8ff0ee82d70937bccda9d20c2d24609b45d3539b7975a23d6d6a93b218f4bf8e67c6c6e0f35a', 'c0597982710fdf4d70d8ffd2b95af31b754a87aa1ad3469a2efc27b419953eaf1006dd8526661f96', 0, '2023-11-07 13:40:20'),
('3d7236323ca08cf1052bbff78eaa461b04323fb70c6fddb6cb16653e8eec8b609af9ae9924ce9b81', '5f4899fedac36ec48353a297ed026e045f3ab1afa9108d78d02f812b9d724ef1a95023e813d12cb9', 0, '2023-10-23 19:55:07'),
('3db007658c92abf6b49a664b8906a1684dc8cfa8324e6ab42f6b633e2a214d62aef0c2c527541a0b', 'da6a505f8861ee2854d6b8bd172545abd294e4fd3c6fcdbe7e6b0a95ef0a27a5b55de6822024eb07', 0, '2023-08-08 19:06:54'),
('457755731b02120e26667bcf15c4b4383fa1a002e472798086f063e828d9e6b5e2298737544775b7', 'a3862aee595047c85cdb148a43e5f96f24504fa7e594d74320a94b26d993681a1a05de92c21afe32', 0, '2023-08-19 19:55:34'),
('4952cd676f744ddff3f3154c8292f2f5d27869d601639ccfd2b76e185fe65d590ed68e959fbe11c8', 'f017039ff4a1540a21a7a991cd308c0d894dd393b326aff64f5065f88bce9b50cfee764fc328bb65', 0, '2023-08-08 19:29:12'),
('495c092663450a67ef5a78b7aa9a583c1252865eac27530967a0102948e4accba15821f41486d7f4', '5e17a18bacc5cd70cc88a8e5d33f5e31b31b280d78995e945bbc72c9140ce5d55a43cd14fea58e07', 0, '2023-10-23 19:48:14'),
('4a74e2262a8af49c276cf74edc59632544f6b1c9e8d17f073215804485421c8f9db99c68bf69fced', '79ea86e9b9669a18475766d84a0f91eeb0b4dab47d2876b86b99831a5072134f95d4887466a5d874', 0, '2023-11-26 22:09:45'),
('4baa5410dd1e8b92b804884d35452dddddc637982160d2e437ea6942b8535c3ea5f65c597d8732c6', '314d9fa68418ef3d81c7d737b49ed20fb720b02dbd6bf14496c63fd0bf2c0a8773f14c8938dbd058', 0, '2023-08-31 17:15:06'),
('4d6b17edf6e34d1fe24cfce88108db1396bb1902281a571dcce76eaa44cf1d6c7aba21d45eca8f9a', '20702090a1f6ed29443f91928a049d218ae8bf04b24c56fd68c24e800d22d6cb4f864c287513dcc1', 0, '2023-09-11 12:22:41'),
('4f6e07dca6d93345177cb561e2b7c4c97879cc3b4762c7764c88a59421467df381190fb76aea6cc2', 'fcb32f548a630f39735e7dac29dd54346d179087e48f957e12ac4a8d09636b5c98db1dd04c9cc514', 0, '2023-11-28 21:58:38'),
('500247cd8939c16d5e52d9b58d787c6da1210353dd233f186077ab7590ef301f054633a5f8d51c32', '74284cd5c8b35f91e90128b97ba540672e406a295b284fd62beca1a956b027abcdd2ca07ff354a65', 0, '2023-11-07 13:38:17'),
('5608cd1e0ca90d09135a5c46aeb45b13f07555aeda93409b131cb08b02d46e18b74771fc441d059c', '406e3e8ddcf77c0c1f5cbe44630f0b08c6d77e1a6006ae31f38a4060c8687b7fe3b72eabe33e9e12', 0, '2023-08-27 14:14:12'),
('5657ce8a8854cba383cda4b7de7a1cb81747eaf77d477d3de78d30f000cfff5a66f0e1f3f8461458', '49a0e4fff3b6c0f65edae390bd69241301757149649c01466ed3344a676e9dc4f43ceb6929b8f699', 0, '2023-10-23 21:13:40'),
('576fc1cccd0fde6d5e7015f11b6262cf71c5a2ebdd97e6a21a1eda3164f3d76df53a188e29e49d6f', '6e97acbf3381a5f8e94759110885b1aa778b99e3a1690f7cc1bdf28c5aab05e424953420f0f5c0c0', 0, '2023-11-07 13:37:13'),
('593abef26a2dbce63e7a289b21c2f810d24ac9ab2df30bdee2e288f2c9b83d3852d308d9c22cc9a9', '73d7d0fbade5410099d1899e1a3cf7d7e07b07dbc1496484f04d16ab4827ee8912ec61e460c5a6e0', 0, '2023-08-31 12:10:07'),
('599aa8c2223687495ce12dbf020d00a0bf4e25a9fc799294d04b1155ba420301fc4c7dfe82d2b7a5', '5a4bc75e417dc89fccda9d016210beb2496c6727b05a5d2b9bdf79c78ab19bf42df6741c4e614188', 0, '2023-10-23 21:14:21'),
('5c36e56589d96af3f8d0dfd0bc97a3e82fecc1a0b2c21a9a29eac2b309ce577fdaf90cf35faef8b9', 'f89ded2b64aef5416f8499f783b9d33b8bfb47baa0c563acf6de61d0d0c456c40284d7a0f9274305', 0, '2023-10-08 09:28:04'),
('5c81fd030cdfb3fb5fc71366e8e310262d5979305d15ab16da8043b96348be49cd3e2f620739194f', 'c07329aaeafefc8a6b0521102eebda43fc788e90b140a14ea8837f3fb2550b5d0edd4fcb115b0f71', 0, '2023-10-23 21:16:02'),
('607cc7db0178d447a03a7c31b404c555eaa09ed9ebba92e1573163f48189375e0f38f9438cca5a8f', 'ce7510ac21dd774f382113f4cc217aea74b2cbd3983c8f8b1461823cc579cc275b289dcf2493d160', 0, '2023-09-09 06:46:01'),
('61bb06b691af8a607c2bd06fd6b8a5e4904e497c3c81f56e4cb4bf8030e1fb3975457d340951bd5b', '815a577ea8d016d20c36f66f81554b7bec0d25c0836bab3ea7d4f80cb6f198ba538f3f5a3cc37754', 0, '2023-11-28 21:49:51'),
('643aa9d869b717beee8f25a69be87f6222ab9d8aa6b76e57488a7e1313a42d09656ffef0e0c06652', 'a9bfeddedddbc90732dfdbf6880142412aa00eb9367d37b0c108956d6c7b711625d26f9741a40d62', 0, '2023-09-17 05:31:33'),
('659f26137f17266ee9b9a60cfac7d127e38a69258e6dbe3560aa5aa2ea2d2fdad5914eab5cf2841e', '9ebc80f8c84bb032a71966cff5763b37ef159d9a7813bf6012ee8e85ff433d3d8ac7384293d0d48c', 0, '2023-08-27 14:17:19'),
('691f1778e54c7f35d699fd4e3f62c526a463c364169fa7ae2d417400af14f39d98fca0f85a808408', 'b8182c71441e1ad46748b14a22b5849083be4418db8b456070fc9c779edefb0cb7111fb3947c0f48', 0, '2023-08-31 16:48:46'),
('6b8fccd5c08bc1b6c41a3154dc28a023badbcd3786525fcbc2ead98a9454a3eac08875e74e10ac17', 'dfebab71e2e7dcfe169dbcd8ea6263e6bc33d8fc452cc99b13ad9649cf721969beb7615ecbe6babd', 0, '2023-11-25 19:39:28'),
('6e3bd61f1c1f62d849c02ab162249cff2f0c9b103cc2d2a595af66b058727ffc7bc24ffc4876dc09', 'c00ce49ae5b9d044321d994b1efd89ab5fae078adfa3c98637f7ee8f9c5f809ba0108d0cfe714fbe', 0, '2023-11-07 13:37:39'),
('73e7c317a6c863cdcb7745f70718dff42ba29c3ebe94eed76df000d3247dfefcdad8037370edc164', 'e26a92c9f6356b1535afeb0a6adf18635c767e75fde7ca404a9c30104250fb298ece0b9b046c3fcf', 0, '2023-11-26 21:09:06'),
('783a7957387a99ae53acc2c01195b12fe580b102de06d6204a5dcd6df3344348bb613ce6bacb467f', '51ee8a396736cd03f607ea9a5df9bf062c9d2811cad0ee7d8a6973f7c194847025d66a81b3568cd0', 0, '2023-09-07 20:51:51'),
('79df109d1716c9fb4b4a7b077ef3ca7d0f9bd81d4e484a9757c114d2951ac5fd6f51b23bdfed6951', 'e45b1ac362e861f89133ffdedb2a21e739c5224edbf7b26a53fba0191f522a2adf8092d93385a928', 0, '2023-12-04 15:50:53'),
('7c5dbc9968d496eef36c2c4efd2b9a4e95f86facf9eca7e95fcbf2d0fb87ac132733b116e03b5dd8', '23b7d716756ab0c439b1a29599e3d1b6cf52da3ec4608037951d1914f6cab9acf35237ef9672064d', 0, '2023-09-07 20:49:35'),
('83b15e1806c6a3853642a45b3bd41799177310c6159997f792082fb705da711244eb8eba74f647de', '613a5a17afdcfbf8f080cbf5a06f05f12b471c95d4f91a87a6203671c7ec321f23bcb89685008523', 0, '2023-09-09 06:45:50'),
('84bd090c904512f8080f12e47a8ff0dfe333a32a869f5992906c6e606b0fcddf3566188acc287280', '3a7c1bd407933999b4ed2dbbefcf8d7874f7dadaf82215067220cf4f9c4b7f9f1ffd6de2bed44fc5', 0, '2023-10-25 18:16:18'),
('86b9b42bddc81eb0cba1b5863b2a185fdf726789b04939a553de72d3c85b990ff3791a86b6fd457d', 'a1acc5b982f642b7515f8c9b3b3d1de5be7310dfcc4aa30aef51ff5423a8679a21516a0a4412d2e1', 0, '2023-09-14 07:36:49'),
('8a0c9bd53797417daa75f644928281c146e9c7234e32013848a7546d8e68a332233a8ef7b6dd12cb', '0f1cd9c1af778e3c0cba144e5474198b024ec64cdbb6c3f937c40d4bda4005d24518cab3129aab48', 0, '2023-08-08 19:08:37'),
('8aa98ba44d72c5ed9f8bacafa78475743d8f03e7cf8d3ad5a3d58d9878b908cefc28a4992cd2cf52', '998b9eec02e01169ae613c596636e3cf76fc31f1a462034cbd921249dc7f845d27f07c045bdf2126', 0, '2023-08-27 14:30:12'),
('8f27ec7ec3e87a7fd16bab191286c7a5956d4d8d916eeb096ff380bde1e9ff287b0aa2fa8137d9bf', 'ea94fa427bbe387d67feca17f8e83d8070e41865d4db3fb648e1fe0293b311e2b697dea7125433e3', 0, '2023-08-08 19:45:59'),
('8fa567062d6cf3f10c92f596db85d569c7e5197fc868b786e704406d02e251b2e657eaf5bba0d8c6', 'b4c77d9d6a665f0c591aba2342af1974d9f8e016ad490ef69943703a1c052cb649607ca4c42ac224', 0, '2023-11-23 22:50:01'),
('968e2fbba41fe8a08633f8c585e8ad232414dc3750c2d594d65b8b866cc6d8b714712af7598fc4fd', '9f6aaee43c6657e6263f5bdddecede0d717c2e3c5781f573398d3ffde59cd1b74d85d26fa9ed08f1', 0, '2023-08-27 14:36:56'),
('9b00dd442c34f61152abeb25635ec6e37f377d49f6bcbe4999de6286c9462b7dff7faffa1a37c040', '4b4a783e3d6b86416a675e8562f92053ad306036a1540c8822e94a93d9c9509370e2578abb8ea327', 0, '2023-08-19 19:47:34'),
('9c438a9877a5b1398ab50e61cecb11e825cc06f57a5d0f3fd9d8de23ba6e1704fe5886f76e9b463c', 'a8dbd7f3d14c91e02391c9bc478ff7bf9eb0ad55bccb5d246ade08d8ba1b2ad57a0e575de4793d5b', 0, '2023-11-23 22:44:31'),
('9d74adc6171664d08fa64e958719355130f13ddefb2c7cf27e4827ebecfb6171cdacd2cddf5e9e75', '816cb9ba58052c61662c48e1a7917f23416c9974b1d06267b9ed85457c21ea02de41873c61845538', 0, '2023-09-12 09:43:29'),
('9ecaebb86620bbae74fa787679994dcf5e31ef887cbde254d6e3a987c8ea7fc36f437b2d537ae781', '249395e25acf21fe513f8c15c658503a757bdddb987de1d851390b13d692a47904ec5e11a2072de2', 0, '2023-08-27 16:51:58'),
('a07e4e5120a1e5bce686bb8affe40b1243e31190385877db9484463b1e076b8c4aa6f023310ca43c', '07b0e3c86498865224be51042d799f2620e83af6a41bac10be660e668696f9a0a5169b21ed8cbaff', 0, '2023-12-04 16:27:47'),
('a146586009175be8ea6712757bbaccdd708a89d3c89bb4dfe6a6e7115c0b4d338acfa52bd71173e4', 'd654d086947892e9b08ed4d9dc66b089fab4c365ad6d1e6fb5c85133b7539d247843bb41defa3b15', 0, '2023-11-12 16:20:18'),
('a79dfc90e247eba2ec1f32fbbb282aefe56cd7a6a2ada8a97056f44722258de3d9300164c7b21a78', '460a3a3439acc4c863ab868f5c11e56c80f21313fa99a5a2badd03bc9ed0ced37530477853ea29af', 0, '2023-10-23 19:36:49'),
('a9bd1d98562d2aa79e04812db4fde7b6d8745370496dfb4078087ef8bc858f18053b997b73717372', 'f4872251bda3adf2d407b0e9b17de89c05f8e8b67be86cd99f50a4f54109a89ec27f8bb3bd006513', 0, '2023-10-23 15:10:13'),
('aa8f0d689580d1fea9957c02ccba051a8c9ad69788f26fe78e950f82dfc4933cfde18f43f058e684', '576671c61b2479811a2af83317b9ea220d0603090cf2d6879a24e62f95df51f0298dc87a15ef9b87', 0, '2023-08-27 14:18:56'),
('ad35a6ef5cba8374e87666d2580b3217bb03ae373e56f74807a7921c55e4e010050bf6fdbbedc680', '8d58c26b48a5ef31f3d9cb3b3c1dc07736f05e2acf84f607f54e26671bf37411a3ae5c5eeb393968', 0, '2023-10-07 10:21:30'),
('add358622ed94f74e340878862001d39ba2746cb1dce09de2737e10b7d1b19fc88e60b205e1b7cba', 'be08c9023ee7676e74be183f1669f56744a226345aeae61f042230a8b94c0cf64146559785288afe', 0, '2023-08-27 14:50:37'),
('b2a3785b8dba90b67c6a25260b619a52822469a5e41b248388dd5999de16a38b554f44654687a16b', 'df7684647f3d546a4d3cd525bbaf2a4884337f61ff2b70a8b929ba1a618e190e04199c6d59aa7d88', 0, '2023-11-07 14:08:25'),
('b34e795d6aa3ae3a9d6832c2ffde433504cc32d88965d872c29aeda614d8a1653551750150e42994', 'e0211a7c018f524bcc7ccf9d91c3d54a8d92db9ef0055e7e5ea1e22e7f2aefad2ae6e77df1717353', 0, '2023-11-26 21:36:59'),
('b44966a91bb4f918cf3f04424a7f5754d050184a422c39faff1ef68216705044e44a7fb28a1068af', '5f885cb83437c7fe2e728f20c693fc9c691bada3996e4c7144f931b009b330265492e0b74c1dd6a2', 0, '2023-09-11 12:21:39'),
('ba77572531eed8d5784890b6290bec7e77b93449024b5561434bedd591d3a17babe701be7d784f82', '4a749239c7e9f87cf3d3671770bb6a0a5230ed29f47883a34d1db12d6396ab9a3f5b5294eb7393f3', 0, '2023-08-31 17:00:56'),
('bc04b5d1c67879db247003002d27aab53bdbf13da28456af1570468759521800969f47c1bfc4e185', '34218b1f74ebda6fc300549a5ccc6395482efb2fa3e128b8aecd1f7ff6372ad91a40cef2902af30e', 0, '2023-09-11 01:31:59'),
('c01d95ca1fbeac0f9791b4d8595eb6930e92c6e2020d7519708d7360d66f814b62cd2b1e902c97a3', 'c02c4783e02f8e40c1079b360b8798ca05a7e5334c0992d223ea6e565806637aa5e2100a84e0b85b', 0, '2023-08-08 19:13:03'),
('c2cfca7680374fcdcf307c7837c7380167d32e4bc780d811b045faf9c0803e3c71b912eb58ed1720', '2e6c48f54c8f3f9a72b03ded9751fa4e288b5e22de04aceda3c3277545177dcebb1579dcdea1e664', 0, '2023-09-09 06:50:28'),
('c433f951e6bd3ec5410a12fee884fcb617285b9e2d42a10ac8f957edabf564e2a8573dfd0c41f336', 'd2353641f36a9751d62f8fdb116f57cb924f0b80acdfabc09811179aaebba01ac58b054ebf19e167', 0, '2023-08-19 19:55:15'),
('c5951e36c25337be7f6127eb1a1ed5535db926561213dd02164b11dafd1ffd4103e04755e083f5b0', '1098a515b981b16333613d949337c53f7ad59274a242a5744998d8b9186b5a1210abb5274a678b00', 0, '2023-11-01 04:13:45'),
('c59615675f5af8ae89eabd7f011148d4de004afcbba7109872c7e5b3d30075aaa82db62f472b3599', 'b3621a0ec89a38ae5999415b54d7bde1dd9af83af02a26a82cd7c1f0c05828c7e0d8ac5e7625c1ae', 0, '2023-09-11 01:20:03'),
('c8e8cca3d5b081a3ee3e2e2b3e1729017e52fd3eb8397155b53d96586ab0057e35fb10341cb0b380', '0651b492dba798745ff8ecc1861eda9cb2ee21ac5f63349bdd3ab02a6b678c4e725d26a4ad66f16c', 0, '2023-08-31 17:01:19'),
('c8f72d83d54a41b8c4800cbe173197802165574f897af63bf27abe9586f89c5e27cad9aec62df42b', '8da287fce780e1cb50d3923def54d715942cd7f193c4011e2c6da2b21559be8efba2d2233fbdb575', 0, '2023-11-12 07:30:00'),
('c990fa779c1727436e8f9152b65c7cf44ca799748039948179f2ad26ebf1fdf569c6784b7d031442', '30a7eedc880fca0566fe95c0e5fc39c5606037941fb0641ddefd3eaa850913305646ab9202fdc69f', 0, '2023-10-06 13:59:17'),
('ccfeb5db41c0e35acdf4211a64a0aa6025f106c179a3bd482d5c151697402011e4afaff744e2e1e2', '1c0f146c3d0cc63cc77767a76908c2d1b609078c96becaf708e777342826d044f402bc0ddc7885f2', 0, '2023-11-28 23:24:35'),
('ce9c98d717ae4514a2edaa49a067373c5438879a8a99d06947723330d86d1e3a4f5c4f9425446069', '1851a6850f0e28327391fec890736d0958a102cbe6e80cbcf6369e000463430caee18ebd41c6e314', 0, '2023-09-12 10:24:26'),
('d7427d2718d93650236628f89a098d8dd655c7168de9402da5a452b345cd7d2a989e451fbe65f286', '63a292b06ca280559173b5cc0ceb61e05becfa4c320807aaa46214473a5e383ed247c6a871df29ec', 0, '2023-08-31 16:45:24'),
('d7d2bc20e5c0049be8c951b85feb7b6f8a14dc76dc97be015a0ab0f24163d4539f3e3227f932c02e', '2a7a4f9bde3bcdc5e5c232129d1e312e2773c2568525fc730a1e68cfbca9c418511f1b56c36ef24a', 0, '2023-10-23 19:46:51'),
('de6dccc54c3709f3115c334461fbdaaddf2d1fe9ddeb192c7a8886c06eb214fc5ae3a47ef9a3adfb', 'a882263a3e9112c8d99ad0bc965b31deb71c0c7a5443ece3802d3e9173ed175424d5a103aa5bf831', 0, '2023-11-01 04:12:27'),
('ded27652f58c3b40027c45b9cc73bb999495734e164ad622acb3495ebe338c367970fe5111842003', '21ce931a656d212a15362da0533d398f54aaddfd9dff32774b94e417c6d9dbb996a9295dbff61e81', 0, '2023-11-25 18:53:26'),
('e0330de30c1c8ff6cba1e23cbae80e392b52cfd42480fc3df8e5efb4ee11b88cd6b7fcebf5ea2c73', '96cb7c7267bb6c3707760b73808eeebe9f2cdbd58baefe2daf23f1dc584d66178da4edc72f384c24', 0, '2023-11-07 14:10:27'),
('e14131cddb8109f5eb9e73c5426bb3d980647500dd41f663c08365d7bf8743068649fac5131bb953', '0ad63c44d31fc70b1982446db5ab3f3aa08c6464f55e4f19fd5e42464b817780263487b0ca5f5480', 0, '2023-08-27 14:40:03'),
('e1689e07575cdcac6b655a25c09544e48abaa1380852c9ca194f4a3aa6e56966e323a74b5601b149', '1da500ba703165f061b93c32f059bd59170ae98e96348231cf65736606df1434b27d705cfc2c444b', 0, '2023-09-09 08:33:58'),
('ebd2d6e17fb1024ebe491361e095f9ea6ef6f03a12d4acd0179b7ac317da044a21b4e7a2f8e039a7', 'c507c485ad49d0f16e23724560626ee69108724b521bcd137b460faa72662ea516375766d806f508', 0, '2023-11-28 19:09:49'),
('edfba9a14d1d91218c8e8365443cc25bd6fe1aa1d7dc6b4aa9f4aaf3b998443bdbdf431a78d60c3c', '4570d1f9ff6b6fffe5e2633c11072d8dcc2b4f72282556ada93e6328d5d3b5ecb8213d3ab80fb411', 0, '2023-08-27 14:20:22'),
('ee3a32e99c91919104e65e156e226ca2bae0726992a248c780c3e23f79ed16f5d66abe0deb7ac716', '8ef3ec7f0de123d9bd396e98ca778d66849791708cbe4919ef6b10d90336f41f70fea66829b4601d', 0, '2023-08-08 19:41:56'),
('f3315e65517ff7e8b0c822e6c98ec1045982ca60ec3888906d361bb690d8623a4072a4223e92137a', 'bdc13db456665546105298d1c2b4aea7b8a26fee64a64ef2acd547cf6e970e79967ac19209b2cd6d', 0, '2023-08-08 19:07:50'),
('f4fad2e93c3768a8a61e2ac02d900f1967ca062f29939d1d505fb185f65d53003e63407248399011', 'ded0af55afbc366c00ae412deab2938461f970bf225f07cdea4b2199d6d3e0dff246e93ed1cb1ae3', 0, '2023-12-04 15:52:00'),
('f61774063d626df284787bb57f011fc5ff3fa4e1187f46ea9957d30cdcfd66452c367688011c2ac5', '11e45e4992d9cd104e9ac9197eb435e468131a8f58bd4bee131158157ee5f4595afb41ce6bf74ec6', 0, '2023-09-15 12:15:36'),
('f92f349ec38bf962ad52c7f7603d7265813bcd51506005840b4ffceee7627e5b304754142845941b', '58289b26b901956d64dac8fc1308b30578ade1d08289157e2791c840801edd3e5c3e780480fb97cf', 0, '2023-11-07 13:17:36'),
('f9cb2e6ae23c7da7d310060e72ec1327186a97ade2f70f02101ae9533e86ba9deb27e2b535e71793', 'abd4913605204e3f8029938bbd4610e9e7798c4278f497ccef454d8259aec4641090e4a2c65dde35', 0, '2023-08-27 15:53:39'),
('ff2a2df4fcae25f8e7725accee8dad5ae45a78bd29a0a2ae2befc718cf566efc2b65c78984d952c2', 'bc09e31420ba181e92046fd5d7eec0a1760cefe696ead7d14ec4dcb5bd70417a484020e563161a5e', 0, '2023-08-19 19:51:25'),
('ffd3513425039fd3f1d490952f0b639a64772dfffb6848ca2c29155d15a55e03ec6be219ab588c19', 'd4cc08cd22d9c3bb3c7602a97af302bc158bdedbd1b68039b4416eaa717bab42d6a281c80dff5448', 0, '2023-09-11 12:21:29');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `price` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `unit`, `price`, `created_at`, `updated_at`) VALUES
(1, 'p1', 'pcs', 12500, '2022-08-08 19:43:17', '2022-09-08 03:48:26'),
(2, 'p2', 'botol', 15000, '2022-08-08 19:44:28', '2022-09-08 03:48:31'),
(3, 'p3', 'pcs', 15000, '2022-08-08 19:44:59', '2022-09-08 03:48:36');

-- --------------------------------------------------------

--
-- Table structure for table `product_users`
--

CREATE TABLE `product_users` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `price` bigint(20) NOT NULL,
  `stock` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_users`
--

INSERT INTO `product_users` (`id`, `product_id`, `user_id`, `price`, `stock`, `created_at`, `updated_at`) VALUES
(1, 1, 2022082701, 10000, 270, '2022-08-27 23:33:32', '2022-11-26 22:09:31'),
(2, 2, 2022082701, 20000, 345, '2022-08-27 23:33:44', '2022-11-26 22:09:31'),
(3, 3, 2022082701, 40000, 595, '2022-08-27 23:33:56', '2022-11-26 22:09:31'),
(4, 1, 2022082701004, 25000, 10, '2022-08-27 23:33:32', '2022-08-28 14:35:40'),
(5, 2, 2022082701004, 31000, 10, '2022-08-27 23:33:44', '2022-08-28 14:35:40'),
(6, 3, 2022082701004, 41000, 10, '2022-08-27 23:33:56', '2022-08-28 14:35:40'),
(8, 3, 2022082701001, 40000, 300, '2022-09-11 08:12:29', '2022-09-11 08:12:29'),
(9, 1, 2022082701003, 10000, 5, '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(10, 2, 2022082701003, 20000, 5, '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(11, 3, 2022082701003, 40000, 5, '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(12, 1, 2022082701008, 10000, 25, '2022-11-26 22:09:31', '2022-11-26 22:09:31'),
(13, 2, 2022082701008, 20000, 50, '2022-11-26 22:09:31', '2022-11-26 22:09:31'),
(14, 3, 2022082701008, 40000, 100, '2022-11-26 22:09:31', '2022-11-26 22:09:31');

-- --------------------------------------------------------

--
-- Table structure for table `product_user_histories`
--

CREATE TABLE `product_user_histories` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `price` bigint(20) NOT NULL,
  `stock` int(11) NOT NULL,
  `type` enum('first','last') NOT NULL,
  `ontime` enum('yes','no') NOT NULL DEFAULT 'yes',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_user_histories`
--

INSERT INTO `product_user_histories` (`id`, `product_id`, `user_id`, `price`, `stock`, `type`, `ontime`, `created_at`, `updated_at`) VALUES
(13, 1, 2022082701004, 25000, 10, 'last', 'yes', '2022-08-31 17:38:38', '2022-08-31 17:38:38'),
(14, 1, 2022082701004, 25000, 10, 'first', 'yes', '2022-08-31 17:38:38', '2022-08-31 17:38:38'),
(15, 2, 2022082701004, 31000, 10, 'last', 'yes', '2022-08-31 17:38:38', '2022-08-31 17:38:38'),
(16, 2, 2022082701004, 31000, 10, 'first', 'yes', '2022-08-31 17:38:38', '2022-08-31 17:38:38'),
(17, 3, 2022082701004, 41000, 10, 'last', 'yes', '2022-08-31 17:38:38', '2022-08-31 17:38:38'),
(18, 3, 2022082701004, 41000, 10, 'first', 'yes', '2022-08-31 17:38:38', '2022-08-31 17:38:38'),
(19, 1, 2022082701008, 10000, 25, 'last', 'yes', '2022-11-26 22:10:21', '2022-11-26 22:10:21'),
(20, 1, 2022082701008, 10000, 25, 'first', 'yes', '2022-11-26 22:10:21', '2022-11-26 22:10:21'),
(21, 2, 2022082701008, 20000, 50, 'last', 'yes', '2022-11-26 22:10:21', '2022-11-26 22:10:21'),
(22, 2, 2022082701008, 20000, 50, 'first', 'yes', '2022-11-26 22:10:21', '2022-11-26 22:10:21'),
(23, 3, 2022082701008, 40000, 100, 'last', 'yes', '2022-11-26 22:10:21', '2022-11-26 22:10:21'),
(24, 3, 2022082701008, 40000, 100, 'first', 'yes', '2022-11-26 22:10:21', '2022-11-26 22:10:21');

-- --------------------------------------------------------

--
-- Table structure for table `product_user_in_outs`
--

CREATE TABLE `product_user_in_outs` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `stock` int(11) NOT NULL,
  `status` enum('pending','success') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_user_in_outs`
--

INSERT INTO `product_user_in_outs` (`id`, `product_id`, `user_id`, `stock`, `status`, `created_at`, `updated_at`) VALUES
(16, 3, 2022082701, -300, 'success', '2022-09-11 08:12:29', '2022-09-11 08:12:29'),
(17, 3, 2022082701001, 300, 'success', '2022-09-11 08:12:29', '2022-09-11 08:12:29'),
(18, 1, 2022082701, -5, 'success', '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(19, 2, 2022082701, -5, 'success', '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(20, 3, 2022082701, -5, 'success', '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(21, 1, 2022082701003, 5, 'success', '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(22, 2, 2022082701003, 5, 'success', '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(23, 3, 2022082701003, 5, 'success', '2022-09-11 08:15:54', '2022-09-11 08:15:54'),
(24, 1, 2022082701, -25, 'success', '2022-11-26 22:09:31', '2022-11-26 22:09:31'),
(25, 2, 2022082701, -50, 'success', '2022-11-26 22:09:31', '2022-11-26 22:09:31'),
(26, 3, 2022082701, -100, 'success', '2022-11-26 22:09:31', '2022-11-26 22:09:31'),
(27, 1, 2022082701008, 25, 'success', '2022-11-26 22:09:31', '2022-11-26 22:09:31'),
(28, 2, 2022082701008, 50, 'success', '2022-11-26 22:09:31', '2022-11-26 22:09:31'),
(29, 3, 2022082701008, 100, 'success', '2022-11-26 22:09:31', '2022-11-26 22:09:31');

-- --------------------------------------------------------

--
-- Table structure for table `role_discounts`
--

CREATE TABLE `role_discounts` (
  `id` int(11) NOT NULL,
  `discount_up` float NOT NULL,
  `price_discount_up` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role_discounts`
--

INSERT INTO `role_discounts` (`id`, `discount_up`, `price_discount_up`) VALUES
(2, 0.5, 20000000),
(3, 0.4, 15000000),
(4, 0.3, 5000000),
(5, 0.2, 500000),
(6, 0.15, -1);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) NOT NULL,
  `seller_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `subtotal` bigint(20) NOT NULL,
  `discount` float NOT NULL,
  `total` bigint(20) NOT NULL,
  `type` enum('transfer','cash') DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `status` enum('cancel','pending','process','success') NOT NULL DEFAULT 'pending',
  `is_online` enum('yes','no') NOT NULL DEFAULT 'yes',
  `transaction_note_id` bigint(20) DEFAULT NULL,
  `ordered_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `seller_id`, `user_id`, `subtotal`, `discount`, `total`, `type`, `bank_id`, `status`, `is_online`, `transaction_note_id`, `ordered_at`, `created_at`, `updated_at`) VALUES
(4, 2022082701, 2022082701004, 900000, 0, 900000, 'transfer', 2, 'success', 'yes', NULL, '2022-08-30 00:00:00', '2022-08-30 00:00:00', '2022-09-16 00:09:19'),
(6, 2022082701, 2022082701003, 450000, 0, 450000, 'transfer', 2, 'success', 'yes', NULL, '2022-08-30 07:52:22', '2022-08-29 07:52:22', '2022-11-29 07:49:51'),
(7, 2022082701, 2022082701004, 450000, 0, 450000, 'transfer', 2, 'success', 'yes', NULL, '2022-08-31 07:52:22', '2022-08-31 07:52:22', '2022-11-29 07:49:12'),
(9, 2022082701, 2022082701001, 12000000, 0.3, 8400000, 'transfer', 2, 'success', 'yes', NULL, '2022-09-09 08:31:31', '2022-09-09 08:31:31', '2022-09-16 00:09:30'),
(15, 2022082701, NULL, 170000, 0, 170000, NULL, NULL, 'success', 'no', 7, '2022-09-15 16:35:01', '2022-09-15 16:35:01', '2022-09-15 23:42:38'),
(16, 2022082701001, NULL, 400000, 0, 400000, NULL, NULL, 'success', 'no', 8, '2022-10-07 10:35:53', '2022-10-07 10:35:53', '2022-10-07 10:35:53'),
(17, 2022082701001, NULL, 400000, 0, 400000, NULL, NULL, 'success', 'no', 9, '2022-10-07 10:39:16', '2022-10-07 10:39:16', '2022-10-07 10:39:16'),
(18, 2022082701001, NULL, 200000, 0, 200000, NULL, NULL, 'success', 'no', 10, '2022-10-07 10:41:06', '2022-10-07 10:41:06', '2022-10-07 10:41:06'),
(19, 2022082701001, NULL, 120000, 0, 120000, NULL, NULL, 'success', 'no', 11, '2022-10-07 10:44:39', '2022-10-07 10:44:39', '2022-10-07 10:44:39'),
(20, 2022082701, 2022082701008, 5250000, 0.3, 3675000, 'transfer', 1, 'success', 'yes', NULL, '2022-11-26 21:35:57', '2022-11-26 21:35:57', '2022-11-26 22:09:31'),
(21, 2022082701008, NULL, 10000, 0, 10000, NULL, NULL, 'success', 'no', 12, '2022-11-26 23:49:11', '2022-11-26 23:49:11', '2022-11-26 23:49:11');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` bigint(20) NOT NULL,
  `transaction_id` bigint(20) NOT NULL,
  `product_user_id` bigint(20) NOT NULL,
  `ro` int(11) NOT NULL,
  `subtotal` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `transaction_id`, `product_user_id`, `ro`, `subtotal`) VALUES
(4, 4, 1, 10, 200000),
(5, 4, 2, 10, 300000),
(6, 4, 3, 10, 400000),
(7, 7, 1, 5, 100000),
(8, 7, 2, 5, 150000),
(9, 7, 3, 5, 200000),
(10, 6, 1, 5, 100000),
(11, 6, 2, 5, 150000),
(12, 6, 3, 5, 200000),
(13, 9, 3, 300, 10000000),
(14, 9, 2, 100, 2000000),
(27, 15, 1, 1, 10000),
(28, 15, 2, 2, 40000),
(29, 15, 3, 3, 120000),
(30, 16, 8, 10, 400000),
(31, 17, 8, 10, 400000),
(32, 18, 8, 5, 200000),
(33, 19, 8, 3, 120000),
(34, 20, 1, 25, 250000),
(35, 20, 2, 50, 1000000),
(36, 20, 3, 100, 4000000),
(37, 21, 12, 1, 10000);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_notes`
--

CREATE TABLE `transaction_notes` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `position` varchar(20) NOT NULL,
  `address` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `bank` varchar(20) DEFAULT NULL,
  `behalf_of` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction_notes`
--

INSERT INTO `transaction_notes` (`id`, `name`, `position`, `address`, `type`, `bank`, `behalf_of`) VALUES
(7, 'asd', 'agen', 'asd', 'transfer', 'BRI', 'al'),
(8, 'alfikri', 'customer', 'tes', 'transfer', 'BNI', 'Alfikri'),
(9, 'alfikri', 'customer', 'tes', 'cash', NULL, NULL),
(10, 'alfikri', 'customer', 'tes', 'cash', NULL, NULL),
(11, 'alfikri', 'customer', 'tes', 'cash', NULL, NULL),
(12, 'tes1', 'agen', 'tes', 'transfer', 'BNI', 'tes');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive','request') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `role` enum('admin','distributor','agen','sub agen','reseller','marketer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` bigint(20) NOT NULL,
  `relation_id` bigint(20) NOT NULL DEFAULT 1,
  `night_mode` tinyint(1) NOT NULL DEFAULT 1,
  `view_admin` tinyint(4) NOT NULL DEFAULT 0,
  `verify_at` datetime DEFAULT NULL,
  `activated_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `status`, `role`, `level`, `relation_id`, `night_mode`, `view_admin`, `verify_at`, `activated_at`, `created_at`, `updated_at`) VALUES
(99, 'admin', 'admin@gmail.com', '$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'active', 'admin', 0, 0, 1, 0, NULL, NULL, '2022-07-20 16:10:20', '2022-07-19 17:00:00'),
(2022082701, 'Tiger Nixon', 'd1@gmail.com', '$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'active', 'distributor', 0, 99, 1, 1, '2022-11-01 05:46:12', '2022-08-27 03:27:18', '2022-08-27 03:26:47', '2022-08-27 14:01:41'),
(2022082702, 'D2 x', 'd2@gmail.com', '$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'active', 'distributor', 0, 99, 1, 0, '2022-11-01 05:46:12', '2022-08-27 22:17:15', '2022-08-27 14:41:56', '2022-08-27 14:41:56'),
(2022083101, 'D3', NULL, '$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'inactive', 'distributor', 0, 1, 1, 0, '2022-11-01 05:46:12', NULL, '2022-08-31 16:52:35', '2022-08-31 16:52:44'),
(2022083102, 'D4', NULL, '$2y$10$TgLC8MUGA7OpcCmojaAKAOWRvGMHpudAqEWLKDMHvf3dqVkCSoAMa$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'active', 'distributor', 0, 1, 1, 0, '2022-11-01 05:46:12', '2022-08-31 16:52:58', '2022-08-31 16:52:53', '2022-08-31 16:52:58'),
(2022082701001, 'agen x', 'agen@gmail.com', '$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'active', 'agen', 1, 2022082701, 1, 0, '2022-11-01 05:46:12', '2022-08-08 19:42:18', '2022-07-20 16:10:20', '2022-08-08 19:42:19'),
(2022082701002, 'sub agen x', 'subagen@gmail.com', '$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'active', 'sub agen', 2, 2022082701001, 1, 0, '2022-11-01 05:46:12', '2022-08-08 19:42:15', '2022-07-20 16:10:20', '2022-08-08 19:42:15'),
(2022082701003, 'reseller x', 'reseller@gmail.com', '$2y$10$BQ.sN3mLQTWKslK8DE3Kd.NVs.pDE0lAIZ1xLdDI5H1xoiiyVgGs6', 'active', 'reseller', 3, 2022082701002, 1, 1, '2022-11-01 05:46:12', '2022-08-31 17:05:50', '2022-07-20 16:10:20', '2022-08-31 17:05:50'),
(2022082701004, 'marketer x', 'marketer@gmail.com', '$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'active', 'marketer', 4, 2022082701003, 1, 1, '2022-11-01 00:00:00', '1900-01-01 00:00:00', '2022-07-20 16:10:20', '2022-08-27 03:37:35'),
(2022082701008, 'Alfikri Alfikri', 'belintex8@gmail.com', '$2y$10$blx0vQRQ78uXuHlCI/eRHeJFkluVnMacCgUCfIqKZvhhS.Q8mIoUO', 'active', 'reseller', 2, 2022082701001, 1, 1, '2022-12-04 16:12:46', '2022-12-01 23:27:25', '2022-10-23 19:16:02', '2022-12-04 16:12:46');

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `user_id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `domicile` varchar(200) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `profession` varchar(50) DEFAULT NULL,
  `born` date DEFAULT NULL,
  `join_at` date DEFAULT NULL,
  `nearest_distributor` varchar(50) DEFAULT NULL,
  `google_business` varchar(200) DEFAULT NULL,
  `fb` varchar(200) DEFAULT NULL,
  `ig` varchar(200) DEFAULT NULL,
  `shoopee` varchar(200) DEFAULT NULL,
  `tokopedia` varchar(200) DEFAULT NULL,
  `lazada` varchar(200) DEFAULT NULL,
  `tiktok` varchar(200) DEFAULT NULL,
  `ktp` varchar(100) DEFAULT NULL,
  `motto` text DEFAULT NULL,
  `img_profile` varchar(100) DEFAULT NULL,
  `tf_unix` int(11) DEFAULT NULL,
  `photo_tf` varchar(100) DEFAULT NULL,
  `tf_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`user_id`, `name`, `phone`, `domicile`, `address`, `city`, `province`, `profession`, `born`, `join_at`, `nearest_distributor`, `google_business`, `fb`, `ig`, `shoopee`, `tokopedia`, `lazada`, `tiktok`, `ktp`, `motto`, `img_profile`, `tf_unix`, `photo_tf`, `tf_date`) VALUES
(99, 'admin', '08', 'payakumbuh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022082701, 'Tiger Nixon', '6281234567890', 'Payakumbuh', 'Tj. Pauh, Payakumbuh, Sumatera Barat', 'Payakumbuh', 'Sumatera Barat', 'Programmer', '2000-12-01', NULL, NULL, 'google business', 'tigerNx.fb', 'tigerNx.ig', 'tigerNx.sp', 'tigerNx.tp', 'tigerNx.lz', 'tigerNx.tt', '/ktp/ktp.jpg', 'Gagal berasal dari rasa takut yang tidak dilawan', '/images/user/profile.png', NULL, NULL, NULL),
(2022082702, 'D2', '6282', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022083101, 'D3', '6282391352791', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022083102, 'D4', '6282391352791', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022082701001, 'agen', '08', 'payakumbuh', 'Tj. Pauh, Payakumbuh, Sumatera Barat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022082701002, 'sub agen', '08', 'payakumbuh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022082701003, 'reseller', '08', 'payakumbuh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022082701004, 'marketer', '08', 'payakumbuh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2022082701008, 'Alfikri Alfikri', '6282391352791', 'payakumbuh', 'tes', 'tes', 'tes', 'tes', '2022-05-11', '2022-10-24', 'tes', 'tes', 'tes', 'tes', NULL, 'tes', 'tes', 'tes', '/images/ktp/1670170366.jpg', 'tes', '/images/user/profile2.png', 123, '/images/bukti-transfer/1670170366.jpg', '2022-12-04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `balances`
--
ALTER TABLE `balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `bank_id` (`bank_id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_users`
--
ALTER TABLE `product_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `product_user_histories`
--
ALTER TABLE `product_user_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `product_user_in_outs`
--
ALTER TABLE `product_user_in_outs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `role_discounts`
--
ALTER TABLE `role_discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `distributor_id` (`seller_id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `transaction_note_id` (`transaction_note_id`),
  ADD KEY `bank_id` (`bank_id`);

--
-- Indexes for table `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `product_user_id` (`product_user_id`);

--
-- Indexes for table `transaction_notes`
--
ALTER TABLE `transaction_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD UNIQUE KEY `user_id_2` (`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `balances`
--
ALTER TABLE `balances`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_users`
--
ALTER TABLE `product_users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `product_user_histories`
--
ALTER TABLE `product_user_histories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `product_user_in_outs`
--
ALTER TABLE `product_user_in_outs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `role_discounts`
--
ALTER TABLE `role_discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `transaction_notes`
--
ALTER TABLE `transaction_notes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2022082701014;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `balances`
--
ALTER TABLE `balances`
  ADD CONSTRAINT `balances_ibfk_1` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `balances_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_users`
--
ALTER TABLE `product_users`
  ADD CONSTRAINT `product_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_users_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_user_histories`
--
ALTER TABLE `product_user_histories`
  ADD CONSTRAINT `product_user_histories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_user_histories_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_user_in_outs`
--
ALTER TABLE `product_user_in_outs`
  ADD CONSTRAINT `product_user_in_outs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_user_in_outs_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_4` FOREIGN KEY (`transaction_note_id`) REFERENCES `transaction_notes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_5` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD CONSTRAINT `transaction_details_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_details_ibfk_2` FOREIGN KEY (`product_user_id`) REFERENCES `product_users` (`id`);

--
-- Constraints for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
