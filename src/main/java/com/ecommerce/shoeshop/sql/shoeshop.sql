/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MariaDB
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : shoe

 Target Server Type    : MariaDB
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 05/03/2026 16:47:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id_address` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ward` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_default` tinyint(1) NULL DEFAULT 1,
  `id_user` int(11) NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_address`) USING BTREE,
  INDEX `id_user`(`id_user`) USING BTREE,
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 'Nguyen Van A', '0987654321', '123 Le Loi', 'Ward 1', 'District 1', 'HCM', 0, 2, '2025-09-18 15:32:04', '2025-09-18 15:32:04');
INSERT INTO `address` VALUES (2, 'Tran Thanh Binh', '0987654321', '123 Le Loi', 'Ward 2', 'District 2', 'HN', 0, 2, '2025-09-19 07:36:12', '2025-09-28 16:03:33');
INSERT INTO `address` VALUES (3, 'Tran Thanh Binh', '0987654321', '123 Le Loi', 'Ward 1', 'District 1', 'HCM', 0, 2, '2025-09-19 07:53:04', '2025-09-28 16:03:34');
INSERT INTO `address` VALUES (4, 'Nguyen Van A', '0987654321', '123 Le Loi', 'Ward 1', 'District 1', 'HCM', 0, 2, '2025-09-22 07:22:59', '2025-09-22 07:22:59');
INSERT INTO `address` VALUES (5, 'Tran Thanh Binh', '0987654321', '123 Le Loi', 'Ward 1', 'District 1', 'HCM', 0, 2, '2025-09-22 08:08:34', '2025-09-28 16:03:35');
INSERT INTO `address` VALUES (6, 'Tran Thanh Binh', '0987654321', '123 Le Loi', 'Ward 1', 'District 2', 'Bình Dương', 0, 2, '2025-09-28 08:28:44', '2025-09-28 16:03:37');
INSERT INTO `address` VALUES (7, 'Tran Thanh Binh', '0987654321', '234 le loi', 'Ward 2', 'District 2', 'Bình Dương', 0, 2, '2025-09-28 08:36:37', '2025-09-28 16:03:22');
INSERT INTO `address` VALUES (8, 'Trần Thanh Bình', '0987654321', '123/B', 'Ward 1', 'District 1', 'Bình Dương', 0, 2, '2025-09-28 09:55:08', '2025-09-28 09:55:08');

-- ----------------------------
-- Table structure for brands
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands`  (
  `id_brand` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_brand`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (2, 'adidas');
INSERT INTO `brands` VALUES (5, 'asics');
INSERT INTO `brands` VALUES (8, 'jodan');
INSERT INTO `brands` VALUES (7, 'kamito');
INSERT INTO `brands` VALUES (4, 'mizuno');
INSERT INTO `brands` VALUES (1, 'nike');
INSERT INTO `brands` VALUES (6, 'nms');
INSERT INTO `brands` VALUES (3, 'puma');
INSERT INTO `brands` VALUES (9, 'under amour');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id_cart` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `id_shipping_method` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cart`) USING BTREE,
  UNIQUE INDEX `id_user`(`id_user`) USING BTREE,
  INDEX `fk_cart_shipping_method`(`id_shipping_method`) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_shipping_method` FOREIGN KEY (`id_shipping_method`) REFERENCES `shipping_methods` (`id_shipping_method`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (1, NULL, '2025-09-09 13:44:22', '2025-09-09 13:44:22', NULL);
INSERT INTO `cart` VALUES (2, 1, '2025-09-09 14:00:32', '2025-09-09 14:00:32', NULL);
INSERT INTO `cart` VALUES (9, 2, '2025-09-28 16:55:46', '2025-09-28 16:55:46', NULL);
INSERT INTO `cart` VALUES (10, 8, '2025-10-10 21:43:19', '2025-10-10 21:43:19', NULL);

-- ----------------------------
-- Table structure for cart_item
-- ----------------------------
DROP TABLE IF EXISTS `cart_item`;
CREATE TABLE `cart_item`  (
  `id_cart_item` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `id_cart` int(11) NULL DEFAULT NULL,
  `id_variant` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cart_item`) USING BTREE,
  INDEX `id_cart`(`id_cart`) USING BTREE,
  INDEX `fk_cart_item_variant`(`id_variant`) USING BTREE,
  CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`id_cart`) REFERENCES `cart` (`id_cart`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_item_variant` FOREIGN KEY (`id_variant`) REFERENCES `product_variants` (`id_variant`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart_item
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id_category` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parent_id_category` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_category`) USING BTREE,
  INDEX `parent_id_category`(`parent_id_category`) USING BTREE,
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent_id_category`) REFERENCES `category` (`id_category`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Giày thể thao', 'Các loại giày sử dụng cho thể thao', NULL);
INSERT INTO `category` VALUES (2, 'Giày bóng đá', 'Các loại giày thể thao sử dụng cho bóng đá', 1);
INSERT INTO `category` VALUES (3, 'Giày bóng rổ', 'Các loại giày thể thao sử dụng cho bóng rổ', 1);
INSERT INTO `category` VALUES (4, 'Giày chạy bộ', 'Các loại giày thể thao sử dụng cho chạy bộ', 1);
INSERT INTO `category` VALUES (5, 'Giày bóng chuyền', 'Các loại giày thể thao sử dụng cho bóng chuyền', 1);
INSERT INTO `category` VALUES (6, 'Giày thời trang', 'Các loại giày thể thao sử dụng cho đi chơi', NULL);
INSERT INTO `category` VALUES (7, 'Giày thời trang nam', 'Các loại giày thời trang dành cho nam', 6);
INSERT INTO `category` VALUES (8, 'Giày thời trang nữ', 'Các loại giày thời trang dành cho nữ', 6);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id_order_item` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `id_order` int(11) NULL DEFAULT NULL,
  `id_variant` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_order_item`) USING BTREE,
  INDEX `id_order`(`id_order`) USING BTREE,
  INDEX `fk_orderitem_variant`(`id_variant`) USING BTREE,
  CONSTRAINT `fk_orderitem_variant` FOREIGN KEY (`id_variant`) REFERENCES `product_variants` (`id_variant`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (1, 2, 1903300.00, 1, 15);
INSERT INTO `order_item` VALUES (2, 2, 1903300.00, 2, 15);
INSERT INTO `order_item` VALUES (3, 1, 2022300.00, 2, 16);
INSERT INTO `order_item` VALUES (4, 1, 1359500.00, 3, 361);
INSERT INTO `order_item` VALUES (5, 1, 1359500.00, 3, 381);
INSERT INTO `order_item` VALUES (6, 2, 1903300.00, 4, 15);
INSERT INTO `order_item` VALUES (7, 1, 2022300.00, 5, 71);
INSERT INTO `order_item` VALUES (8, 1, 1903300.00, 6, 56);
INSERT INTO `order_item` VALUES (9, 1, 2022300.00, 7, 26);
INSERT INTO `order_item` VALUES (10, 1, 2022300.00, 8, 16);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id_order` int(11) NOT NULL AUTO_INCREMENT,
  `total_amount` decimal(10, 2) NULL DEFAULT NULL,
  `status` enum('PENDING','CONFIRMED','SHIPPED','DELIVERED','CANCELLED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PENDING',
  `id_user` int(11) NULL DEFAULT NULL,
  `id_address` int(11) NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `id_payment` int(11) NULL DEFAULT NULL,
  `id_shipping_method` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_order`) USING BTREE,
  INDEX `id_user`(`id_user`) USING BTREE,
  INDEX `id_address`(`id_address`) USING BTREE,
  INDEX `id_payment`(`id_payment`) USING BTREE,
  INDEX `fk_orders_shipping_method`(`id_shipping_method`) USING BTREE,
  CONSTRAINT `fk_orders_shipping_method` FOREIGN KEY (`id_shipping_method`) REFERENCES `shipping_methods` (`id_shipping_method`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`id_address`) REFERENCES `address` (`id_address`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`id_payment`) REFERENCES `payment` (`id_payment`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 4006600.00, 'PENDING', 2, 1, '2025-09-18 15:32:04', '2025-09-18 15:32:04', 1, NULL);
INSERT INTO `orders` VALUES (2, 6028900.00, 'PENDING', 2, 2, '2025-09-19 07:36:12', '2025-09-19 07:36:12', 2, NULL);
INSERT INTO `orders` VALUES (3, 2919000.00, 'PENDING', 2, 3, '2025-09-19 07:53:04', '2025-09-19 07:53:04', 3, NULL);
INSERT INTO `orders` VALUES (4, 4006600.00, 'PENDING', 2, 4, '2025-09-22 07:23:00', '2025-09-22 07:23:00', 4, NULL);
INSERT INTO `orders` VALUES (5, 2022300.00, 'PENDING', 2, 5, '2025-09-22 08:08:34', '2025-09-22 08:08:34', 5, NULL);
INSERT INTO `orders` VALUES (6, 2003300.00, 'CANCELLED', 2, 6, '2025-09-28 08:28:44', '2025-09-28 16:58:48', 6, NULL);
INSERT INTO `orders` VALUES (7, 2122300.00, 'DELIVERED', 2, 7, '2025-09-28 08:36:37', '2025-09-28 16:58:37', 7, 1);
INSERT INTO `orders` VALUES (8, 2122300.00, 'PENDING', 2, 8, '2025-09-28 09:55:08', '2025-09-28 09:55:08', 8, 1);

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `expiry` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token`(`token`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------
INSERT INTO `password_reset_tokens` VALUES (3, 3, '730cf717-17af-4383-b111-2dbce9bb370c', '2025-09-06 17:22:37', '2025-09-06 17:07:37');

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `id_payment` int(11) NOT NULL AUTO_INCREMENT,
  `method` enum('COD','BANK_TRANSFER','MOMO','ZALOPAY','VNPAY') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('PENDING','SUCCESS','FAILED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PENDING',
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(10, 2) NULL DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_order` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_payment`) USING BTREE,
  INDEX `id_order`(`id_order`) USING BTREE,
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment
-- ----------------------------
INSERT INTO `payment` VALUES (1, 'COD', 'PENDING', NULL, 4006600.00, '2025-09-18 15:32:03', NULL);
INSERT INTO `payment` VALUES (2, 'COD', 'PENDING', NULL, 6028900.00, '2025-09-19 07:36:12', NULL);
INSERT INTO `payment` VALUES (3, 'COD', 'PENDING', NULL, 2919000.00, '2025-09-19 07:53:04', NULL);
INSERT INTO `payment` VALUES (4, 'COD', 'PENDING', NULL, 4006600.00, '2025-09-22 07:22:59', NULL);
INSERT INTO `payment` VALUES (5, 'VNPAY', 'PENDING', NULL, 2022300.00, '2025-09-22 08:08:34', NULL);
INSERT INTO `payment` VALUES (6, 'COD', 'PENDING', NULL, 2003300.00, '2025-09-28 08:28:43', 6);
INSERT INTO `payment` VALUES (7, 'COD', 'PENDING', NULL, 2122300.00, '2025-09-28 08:36:37', 7);
INSERT INTO `payment` VALUES (8, 'COD', 'PENDING', NULL, 2122300.00, '2025-09-28 09:55:08', 8);

-- ----------------------------
-- Table structure for product_images
-- ----------------------------
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images`  (
  `id_image` int(11) NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_product` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_image`) USING BTREE,
  INDEX `id_product`(`id_product`) USING BTREE,
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 263 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_images
-- ----------------------------
INSERT INTO `product_images` VALUES (1, 'https://supersports.com.vn/cdn/shop/files/FQ8449-400-2.jpg?v=1732699414&width=1000', 1);
INSERT INTO `product_images` VALUES (2, 'https://supersports.com.vn/cdn/shop/files/FQ8449-800-2.jpg?v=1737453570&width=1000', 1);
INSERT INTO `product_images` VALUES (3, 'https://supersports.com.vn/cdn/shop/files/FQ8449-301-2.jpg?v=1745909006&width=1000', 1);
INSERT INTO `product_images` VALUES (4, 'https://supersports.com.vn/cdn/shop/files/HV4069-400-2.jpg?v=1742530689&width=1000', 2);
INSERT INTO `product_images` VALUES (5, 'https://supersports.com.vn/cdn/shop/files/FQ8374-800-2.jpg?v=1737453543&width=1000', 3);
INSERT INTO `product_images` VALUES (6, 'https://supersports.com.vn/cdn/shop/files/FQ8384-800-2_120x@2x.jpg?v=1731317989', 4);
INSERT INTO `product_images` VALUES (7, 'https://supersports.com.vn/cdn/shop/files/FQ8384-800-4.jpg?v=1731317989&width=1000', 4);
INSERT INTO `product_images` VALUES (8, 'https://supersports.com.vn/cdn/shop/files/FQ8384-800-5.jpg?v=1731317989&width=1000', 4);
INSERT INTO `product_images` VALUES (9, 'https://supersports.com.vn/cdn/shop/files/DV4337-002-2.jpg?v=1728985613&width=1000', 5);
INSERT INTO `product_images` VALUES (10, 'https://supersports.com.vn/cdn/shop/files/DV4337-400-2.jpg?v=1728985616&width=1000', 5);
INSERT INTO `product_images` VALUES (11, 'https://supersports.com.vn/cdn/shop/files/DV4337-800-2.jpg?v=1737452814&width=1000', 5);
INSERT INTO `product_images` VALUES (12, 'https://supersports.com.vn/cdn/shop/files/IF8818-2.jpg?v=1725005968&width=1000', 6);
INSERT INTO `product_images` VALUES (13, 'https://supersports.com.vn/cdn/shop/files/JH7615-2.jpg?v=1752053821&width=1000', 6);
INSERT INTO `product_images` VALUES (14, 'https://supersports.com.vn/cdn/shop/files/JH7725-1.jpg?v=1752053873&width=1000', 7);
INSERT INTO `product_images` VALUES (15, 'https://supersports.com.vn/cdn/shop/files/IE1231-1.jpg?v=1734691213&width=1000', 7);
INSERT INTO `product_images` VALUES (16, 'https://supersports.com.vn/cdn/shop/files/JH7724-1.jpg?v=1751364866&width=1000', 7);
INSERT INTO `product_images` VALUES (17, 'https://supersports.com.vn/cdn/shop/files/JI1133-1.jpg?v=1752054004&width=1000', 8);
INSERT INTO `product_images` VALUES (18, 'https://supersports.com.vn/cdn/shop/files/ID3769-1.jpg?v=1735887589&width=1000', 8);
INSERT INTO `product_images` VALUES (19, 'https://supersports.com.vn/cdn/shop/files/JR2852-1.jpg?v=1751365503&width=1000', 9);
INSERT INTO `product_images` VALUES (20, 'https://supersports.com.vn/cdn/shop/files/ID9044-1.jpg?v=1734691118&width=1000', 9);
INSERT INTO `product_images` VALUES (21, 'https://supersports.com.vn/cdn/shop/files/IF8867-1.jpg?v=1717755773&width=1000', 10);
INSERT INTO `product_images` VALUES (22, 'https://supersports.com.vn/cdn/shop/files/IF5441-1.jpg?v=1752743122&width=1000', 10);
INSERT INTO `product_images` VALUES (23, 'https://supersports.com.vn/cdn/shop/files/10852201-1.jpg?v=1752054159&width=1000', 11);
INSERT INTO `product_images` VALUES (24, 'https://supersports.com.vn/cdn/shop/files/10852201-3.jpg?v=1752054159&width=1000', 11);
INSERT INTO `product_images` VALUES (25, 'https://supersports.com.vn/cdn/shop/files/10852201-5.jpg?v=1752054160&width=1000', 11);
INSERT INTO `product_images` VALUES (26, 'https://supersports.com.vn/cdn/shop/files/10860501-1.jpg?v=1752054216&width=1000', 12);
INSERT INTO `product_images` VALUES (27, 'https://supersports.com.vn/cdn/shop/files/10860501-3.jpg?v=1752054216&width=1000', 12);
INSERT INTO `product_images` VALUES (28, 'https://supersports.com.vn/cdn/shop/files/10860501-5.jpg?v=1752054216&width=1000', 12);
INSERT INTO `product_images` VALUES (29, 'https://supersports.com.vn/cdn/shop/files/10883501-1.jpg?v=1752054247&width=1000', 13);
INSERT INTO `product_images` VALUES (30, 'https://supersports.com.vn/cdn/shop/files/10883501-3.jpg?v=1752054247&width=1000', 13);
INSERT INTO `product_images` VALUES (31, 'https://supersports.com.vn/cdn/shop/files/10883501-5.jpg?v=1752054247&width=1000', 13);
INSERT INTO `product_images` VALUES (32, 'https://supersports.com.vn/cdn/shop/files/FQ1456-800-1.jpg?v=1737453396&width=1000', 14);
INSERT INTO `product_images` VALUES (33, 'https://supersports.com.vn/cdn/shop/files/FQ1456-800-2.jpg?v=1737453396&width=1000', 14);
INSERT INTO `product_images` VALUES (34, 'https://supersports.com.vn/cdn/shop/files/FQ1456-800-5.jpg?v=1737453396&width=1000', 14);
INSERT INTO `product_images` VALUES (35, 'https://supersports.com.vn/cdn/shop/files/FJ2577-300-1.jpg?v=1737453189&width=1000', 15);
INSERT INTO `product_images` VALUES (36, 'https://supersports.com.vn/cdn/shop/files/FJ2577-300-2.jpg?v=1737453189&width=1000', 15);
INSERT INTO `product_images` VALUES (37, 'https://supersports.com.vn/cdn/shop/files/FJ2577-300-5.jpg?v=1737453190&width=1000', 15);
INSERT INTO `product_images` VALUES (38, 'https://product.hstatic.net/1000061481/product/anh_sp_add_web_3-02-02-01-01-01-01-01-01-01-0104-03_2a3b4bbb7c144191ae4e07635880cea9_1024x1024.jpg', 16);
INSERT INTO `product_images` VALUES (39, 'https://product.hstatic.net/1000061481/product/dsc00984_c4733c62890f4d33a8081f9853592414_1024x1024.jpg', 16);
INSERT INTO `product_images` VALUES (40, 'https://product.hstatic.net/1000061481/product/dsc00990_e3e90afe7ac945f88f29dcb079cb2dab_1024x1024.jpg', 16);
INSERT INTO `product_images` VALUES (41, 'https://product.hstatic.net/1000061481/product/anh_sp_add_web_3-02-02-01-01-01-01-01-01-01-0101-04-03_3482d62c836345f58461a737fdff7b63_1024x1024.jpg', 17);
INSERT INTO `product_images` VALUES (42, 'https://product.hstatic.net/1000061481/product/dsc00993_e648af27fb8044e9a480cfff7df828b5_1024x1024.jpg', 17);
INSERT INTO `product_images` VALUES (43, 'https://product.hstatic.net/1000061481/product/dsc00999_4b61eb8dff184760a502a5faae4dff92_1024x1024.jpg', 17);
INSERT INTO `product_images` VALUES (44, 'https://product.hstatic.net/1000061481/product/anh_sp_add_web_4-02-02-078971-01-2-02-02-02-01-01-02-01_386cf5b2d6ac4e80b5c18bbee1b4e629_1024x1024.jpg', 18);
INSERT INTO `product_images` VALUES (45, 'https://product.hstatic.net/1000061481/product/nms03652_66787edc57004a70be6ec1bb88880407_1024x1024.jpg', 18);
INSERT INTO `product_images` VALUES (46, 'https://product.hstatic.net/1000061481/product/nms03657_092b10c151194bd5bf3922039acbd87f_1024x1024.jpg', 18);
INSERT INTO `product_images` VALUES (47, 'https://product.hstatic.net/1000061481/product/anh_sp_add_web_4-02-02-002-02-02-001-029-01-2-2_d0c4dc6c563e40978e2c0f6316d7ef3c_1024x1024.jpg', 19);
INSERT INTO `product_images` VALUES (48, 'https://product.hstatic.net/1000061481/product/anh_sp_add77-01777883901-573-2_e9e65b8724a34533a902354eb461e851_1024x1024.jpg', 20);
INSERT INTO `product_images` VALUES (49, 'https://product.hstatic.net/1000061481/product/nms00186_4b806f2b1495466286cadf2ef540cb98_1024x1024.jpg', 20);
INSERT INTO `product_images` VALUES (50, 'https://product.hstatic.net/1000061481/product/nms00191_a871acf1353b468090aa42c3352492d7_1024x1024.jpg', 20);
INSERT INTO `product_images` VALUES (51, 'https://supersports.com.vn/cdn/shop/files/FD2336-160-1.jpg?v=1728295225&width=1000', 21);
INSERT INTO `product_images` VALUES (52, 'https://supersports.com.vn/cdn/shop/files/FD2336-160-4.jpg?v=1728295225&width=1000', 21);
INSERT INTO `product_images` VALUES (53, 'https://supersports.com.vn/cdn/shop/files/FD2336-160-6.jpg?v=1728295227&width=1000', 21);
INSERT INTO `product_images` VALUES (54, 'https://supersports.com.vn/cdn/shop/files/DR8786-402-1.jpg?v=1717495944&width=1000', 22);
INSERT INTO `product_images` VALUES (55, 'https://supersports.com.vn/cdn/shop/files/DR8786-402-4.jpg?v=1717495944&width=1000', 22);
INSERT INTO `product_images` VALUES (56, 'https://supersports.com.vn/cdn/shop/files/DR8786-402-6.jpg?v=1717495944&width=1000', 22);
INSERT INTO `product_images` VALUES (57, 'https://supersports.com.vn/cdn/shop/files/FQ3681-501-1.jpg?v=1740566699&width=1000', 23);
INSERT INTO `product_images` VALUES (58, 'https://supersports.com.vn/cdn/shop/files/FQ3681-501-4.jpg?v=1740566699&width=1000', 23);
INSERT INTO `product_images` VALUES (59, 'https://supersports.com.vn/cdn/shop/files/FQ3681-501-6.jpg?v=1740566699&width=1000', 23);
INSERT INTO `product_images` VALUES (60, 'https://supersports.com.vn/cdn/shop/files/FB2237-004-1.jpg?v=1725531193&width=1000', 24);
INSERT INTO `product_images` VALUES (61, 'https://supersports.com.vn/cdn/shop/files/FB2237-004-4.jpg?v=1725531193&width=1000', 24);
INSERT INTO `product_images` VALUES (62, 'https://supersports.com.vn/cdn/shop/files/FB2237-004-6.jpg?v=1725531193&width=1000', 24);
INSERT INTO `product_images` VALUES (63, 'https://supersports.com.vn/cdn/shop/files/FQ3681-700-1.jpg?v=1740566732&width=1000', 25);
INSERT INTO `product_images` VALUES (64, 'https://supersports.com.vn/cdn/shop/files/FQ3681-700-4.jpg?v=1740566732&width=1000', 25);
INSERT INTO `product_images` VALUES (65, 'https://supersports.com.vn/cdn/shop/files/FQ3681-700-6.jpg?v=1740566732&width=1000', 25);
INSERT INTO `product_images` VALUES (66, 'https://supersports.com.vn/cdn/shop/files/FQ1285-003-1.jpg?v=1737453319&width=1000', 26);
INSERT INTO `product_images` VALUES (67, 'https://supersports.com.vn/cdn/shop/files/FQ1285-003-4.jpg?v=1737453319&width=1000', 26);
INSERT INTO `product_images` VALUES (68, 'https://supersports.com.vn/cdn/shop/files/FQ1285-003-6.jpg?v=1737453319&width=1000', 26);
INSERT INTO `product_images` VALUES (69, 'https://supersports.com.vn/cdn/shop/files/FB2598-600-1.jpg?v=1737453023&width=1000', 27);
INSERT INTO `product_images` VALUES (70, 'https://supersports.com.vn/cdn/shop/files/FB2598-600-4.jpg?v=1737453023&width=1000', 27);
INSERT INTO `product_images` VALUES (71, 'https://supersports.com.vn/cdn/shop/files/FB2598-600-6.jpg?v=1737453023&width=1000', 27);
INSERT INTO `product_images` VALUES (72, 'https://supersports.com.vn/cdn/shop/files/FD2336-007-1.jpg?v=1728985664&width=1000', 28);
INSERT INTO `product_images` VALUES (73, 'https://supersports.com.vn/cdn/shop/files/FD2336-007-4.jpg?v=1728985664&width=1000', 28);
INSERT INTO `product_images` VALUES (74, 'https://supersports.com.vn/cdn/shop/files/FD2336-007-6.jpg?v=1728985664&width=1000', 28);
INSERT INTO `product_images` VALUES (75, 'https://supersports.com.vn/cdn/shop/files/FB2237-402-1.jpg?v=1728985664&width=1000', 29);
INSERT INTO `product_images` VALUES (76, 'https://supersports.com.vn/cdn/shop/files/FB2237-402-4.jpg?v=1728985665&width=1000', 29);
INSERT INTO `product_images` VALUES (77, 'https://supersports.com.vn/cdn/shop/files/FB2237-402-6.jpg?v=1728985665&width=1000', 29);
INSERT INTO `product_images` VALUES (78, 'https://supersports.com.vn/cdn/shop/files/DX9012-800-1.jpg?v=1721988894&width=1000', 30);
INSERT INTO `product_images` VALUES (79, 'https://supersports.com.vn/cdn/shop/files/DX9012-800-4.jpg?v=1721988894&width=1000', 30);
INSERT INTO `product_images` VALUES (80, 'https://supersports.com.vn/cdn/shop/files/DX9012-800-6.jpg?v=1721988894&width=1000', 30);
INSERT INTO `product_images` VALUES (81, 'https://supersports.com.vn/cdn/shop/files/1298306-111-1.jpg?v=1715140950&width=1000', 31);
INSERT INTO `product_images` VALUES (82, 'https://supersports.com.vn/cdn/shop/files/1298306-111-4.jpg?v=1715140951&width=1000', 31);
INSERT INTO `product_images` VALUES (83, 'https://supersports.com.vn/cdn/shop/files/1298306-111-5.jpg?v=1715140951&width=1000', 31);
INSERT INTO `product_images` VALUES (84, 'https://supersports.com.vn/cdn/shop/files/1298306-301-1.jpg?v=1708506560&width=1000', 32);
INSERT INTO `product_images` VALUES (85, 'https://supersports.com.vn/cdn/shop/files/1298306-301-4.jpg?v=1708506560&width=1000', 32);
INSERT INTO `product_images` VALUES (86, 'https://supersports.com.vn/cdn/shop/files/1298306-301-5.jpg?v=1708506560&width=1000', 32);
INSERT INTO `product_images` VALUES (87, 'https://supersports.com.vn/cdn/shop/files/3026617-300-1.jpg?v=1708507439&width=1000', 33);
INSERT INTO `product_images` VALUES (88, 'https://supersports.com.vn/cdn/shop/files/3026617-300-4.jpg?v=1708507439&width=1000', 33);
INSERT INTO `product_images` VALUES (89, 'https://supersports.com.vn/cdn/shop/files/3026617-300-5.jpg?v=1708507439&width=1000', 33);
INSERT INTO `product_images` VALUES (90, 'https://supersports.com.vn/cdn/shop/files/3028497-600-1.jpg?v=1740970387&width=1000', 34);
INSERT INTO `product_images` VALUES (91, 'https://supersports.com.vn/cdn/shop/files/3028497-600-3.jpg?v=1740970387&width=1000', 34);
INSERT INTO `product_images` VALUES (92, 'https://supersports.com.vn/cdn/shop/files/3028497-600-4.jpg?v=1740970387&width=1000', 34);
INSERT INTO `product_images` VALUES (93, 'https://supersports.com.vn/cdn/shop/files/3028512-001-1.jpg?v=1753343127&width=1000', 35);
INSERT INTO `product_images` VALUES (94, 'https://supersports.com.vn/cdn/shop/files/3028512-001-3.jpg?v=1753343127&width=1000', 35);
INSERT INTO `product_images` VALUES (95, 'https://supersports.com.vn/cdn/shop/files/3028512-001-4.jpg?v=1753343131&width=1000', 35);
INSERT INTO `product_images` VALUES (96, 'https://supersports.com.vn/cdn/shop/files/3028498-280-1.jpg?v=1743585430&width=1000', 36);
INSERT INTO `product_images` VALUES (97, 'https://supersports.com.vn/cdn/shop/files/3028498-280-3.jpg?v=1743585430&width=1000', 36);
INSERT INTO `product_images` VALUES (98, 'https://supersports.com.vn/cdn/shop/files/3028498-280-4.jpg?v=1743585431&width=1000', 36);
INSERT INTO `product_images` VALUES (99, 'https://supersports.com.vn/cdn/shop/files/3027646-102-1.jpg?v=1753343069&width=1000', 37);
INSERT INTO `product_images` VALUES (100, 'https://supersports.com.vn/cdn/shop/files/3027646-102-3.jpg?v=1753343072&width=1000', 37);
INSERT INTO `product_images` VALUES (101, 'https://supersports.com.vn/cdn/shop/files/3027646-102-4.jpg?v=1753343072&width=1000', 37);
INSERT INTO `product_images` VALUES (102, 'https://supersports.com.vn/cdn/shop/files/3027646-003-1.jpg?v=1753343070&width=1000', 38);
INSERT INTO `product_images` VALUES (103, 'https://supersports.com.vn/cdn/shop/files/3027646-003-3.jpg?v=1753343072&width=1000', 38);
INSERT INTO `product_images` VALUES (104, 'https://supersports.com.vn/cdn/shop/files/3027646-003-4.jpg?v=1753343075&width=1000', 38);
INSERT INTO `product_images` VALUES (105, 'https://supersports.com.vn/cdn/shop/files/3027769-300-1.jpg?v=1711967655&width=1000', 39);
INSERT INTO `product_images` VALUES (106, 'https://supersports.com.vn/cdn/shop/files/3027769-300-3.jpg?v=1711967656&width=1000', 39);
INSERT INTO `product_images` VALUES (107, 'https://supersports.com.vn/cdn/shop/files/3027769-300-4.jpg?v=1711967656&width=1000', 39);
INSERT INTO `product_images` VALUES (108, 'https://supersports.com.vn/cdn/shop/files/3026630-003-1.jpg?v=1721205538&width=1000', 40);
INSERT INTO `product_images` VALUES (109, 'https://supersports.com.vn/cdn/shop/files/3026630-003-3.jpg?v=1721205539&width=1000', 40);
INSERT INTO `product_images` VALUES (110, 'https://supersports.com.vn/cdn/shop/files/3026630-003-4.jpg?v=1721205538&width=1000', 40);
INSERT INTO `product_images` VALUES (111, 'https://supersports.com.vn/cdn/shop/files/JI3010-1.jpg?v=1754991069&width=1000', 41);
INSERT INTO `product_images` VALUES (112, 'https://supersports.com.vn/cdn/shop/files/JI3010-2.jpg?v=1754991069&width=1000', 41);
INSERT INTO `product_images` VALUES (113, 'https://supersports.com.vn/cdn/shop/files/JI3010-3.jpg?v=1754991069&width=1000', 41);
INSERT INTO `product_images` VALUES (114, 'https://supersports.com.vn/cdn/shop/files/JQ7709-1.jpg?v=1754991259&width=1000', 42);
INSERT INTO `product_images` VALUES (115, 'https://supersports.com.vn/cdn/shop/files/JQ7709-2.jpg?v=1754991259&width=1000', 42);
INSERT INTO `product_images` VALUES (116, 'https://supersports.com.vn/cdn/shop/files/JQ7709-3.jpg?v=1754991259&width=1000', 42);
INSERT INTO `product_images` VALUES (117, 'https://supersports.com.vn/cdn/shop/files/JS4487-1.jpg?v=1754991330&width=1000', 43);
INSERT INTO `product_images` VALUES (118, 'https://supersports.com.vn/cdn/shop/files/JS4487-2.jpg?v=1754991330&width=1000', 43);
INSERT INTO `product_images` VALUES (119, 'https://supersports.com.vn/cdn/shop/files/JS4487-3.jpg?v=1754991330&width=1000', 43);
INSERT INTO `product_images` VALUES (120, 'https://supersports.com.vn/cdn/shop/files/JS4938-1.jpg?v=1754991362&width=1000', 44);
INSERT INTO `product_images` VALUES (121, 'https://supersports.com.vn/cdn/shop/files/JS4938-2.jpg?v=1754991362&width=1000', 44);
INSERT INTO `product_images` VALUES (122, 'https://supersports.com.vn/cdn/shop/files/JS4938-3.jpg?v=1754991362&width=1000', 44);
INSERT INTO `product_images` VALUES (123, 'https://supersports.com.vn/cdn/shop/files/JS4395-1.jpg?v=1750046024&width=1000', 45);
INSERT INTO `product_images` VALUES (124, 'https://supersports.com.vn/cdn/shop/files/JS4395-2.jpg?v=1750046024&width=1000', 45);
INSERT INTO `product_images` VALUES (125, 'https://supersports.com.vn/cdn/shop/files/JS4395-4.jpg?v=1750046024&width=1000', 45);
INSERT INTO `product_images` VALUES (126, 'https://supersports.com.vn/cdn/shop/files/1011C084.600-1.jpg?v=1752207303&width=1000', 46);
INSERT INTO `product_images` VALUES (127, 'https://supersports.com.vn/cdn/shop/files/1011C084.600-2.jpg?v=1752207303&width=1000', 46);
INSERT INTO `product_images` VALUES (128, 'https://supersports.com.vn/cdn/shop/files/1011C084.600-3.jpg?v=1752207303&width=1000', 46);
INSERT INTO `product_images` VALUES (129, 'https://supersports.com.vn/cdn/shop/files/1011C080.100-1.jpg?v=1753087499&width=1000', 47);
INSERT INTO `product_images` VALUES (130, 'https://supersports.com.vn/cdn/shop/files/1011C080.100-2.jpg?v=1753087498&width=1000', 47);
INSERT INTO `product_images` VALUES (131, 'https://supersports.com.vn/cdn/shop/files/1011C080.100-3.jpg?v=1753087498&width=1000', 47);
INSERT INTO `product_images` VALUES (132, 'https://supersports.com.vn/cdn/shop/files/1011B960.401-1.jpg?v=1744612992&width=1000', 48);
INSERT INTO `product_images` VALUES (133, 'https://supersports.com.vn/cdn/shop/files/1011B960.401-2.jpg?v=1744612992&width=1000', 48);
INSERT INTO `product_images` VALUES (134, 'https://supersports.com.vn/cdn/shop/files/1011B960.401-3.jpg?v=1744612992&width=1000', 48);
INSERT INTO `product_images` VALUES (135, 'https://supersports.com.vn/cdn/shop/files/1011B872.800-1.jpg?v=1747372416&width=1000', 49);
INSERT INTO `product_images` VALUES (136, 'https://supersports.com.vn/cdn/shop/files/1011B872.800-2.jpg?v=1747372416&width=1000', 49);
INSERT INTO `product_images` VALUES (137, 'https://supersports.com.vn/cdn/shop/files/1011B872.800-3.jpg?v=1747372415&width=1000', 49);
INSERT INTO `product_images` VALUES (138, 'https://supersports.com.vn/cdn/shop/files/1011C135.100-1.jpg?v=1753087562&width=1000', 50);
INSERT INTO `product_images` VALUES (139, 'https://supersports.com.vn/cdn/shop/files/1011C135.100-2.jpg?v=1753087562&width=1000', 50);
INSERT INTO `product_images` VALUES (140, 'https://supersports.com.vn/cdn/shop/files/1011C135.100-3.jpg?v=1753087561&width=1000', 50);
INSERT INTO `product_images` VALUES (141, 'https://supersports.com.vn/cdn/shop/files/DZ2617-001-1.jpg?v=1709806089&width=1000', 51);
INSERT INTO `product_images` VALUES (142, 'https://supersports.com.vn/cdn/shop/files/DZ2617-001-2.jpg?v=1709806088&width=1000', 51);
INSERT INTO `product_images` VALUES (143, 'https://supersports.com.vn/cdn/shop/files/DZ2617-001-4.jpg?v=1709806089&width=1000', 51);
INSERT INTO `product_images` VALUES (144, 'https://supersports.com.vn/cdn/shop/files/DV1237-001-1.jpg?v=1725530687&width=1000', 52);
INSERT INTO `product_images` VALUES (145, 'https://supersports.com.vn/cdn/shop/files/DV1237-001-2.jpg?v=1725530687&width=1000', 52);
INSERT INTO `product_images` VALUES (146, 'https://supersports.com.vn/cdn/shop/files/DV1237-001-4.jpg?v=1736230857&width=1000', 52);
INSERT INTO `product_images` VALUES (147, 'https://supersports.com.vn/cdn/shop/files/621716-020-1.jpg?v=1726562753&width=1000', 53);
INSERT INTO `product_images` VALUES (148, 'https://supersports.com.vn/cdn/shop/files/621716-020-2.jpg?v=1726562752&width=1000', 53);
INSERT INTO `product_images` VALUES (149, 'https://supersports.com.vn/cdn/shop/files/621716-020-4.jpg?v=1726562752&width=1000', 53);
INSERT INTO `product_images` VALUES (150, 'https://supersports.com.vn/cdn/shop/files/FQ1833-001-1.jpg?v=1726563708&width=1000', 54);
INSERT INTO `product_images` VALUES (151, 'https://supersports.com.vn/cdn/shop/files/FQ1833-001-2.jpg?v=1726563708&width=1000', 54);
INSERT INTO `product_images` VALUES (152, 'https://supersports.com.vn/cdn/shop/files/FQ1833-001-4.jpg?v=1726563708&width=1000', 54);
INSERT INTO `product_images` VALUES (153, 'https://supersports.com.vn/cdn/shop/files/DM1120-001-1.jpg?v=1717495856&width=1000', 55);
INSERT INTO `product_images` VALUES (154, 'https://supersports.com.vn/cdn/shop/files/DM1120-001-2.jpg?v=1717495856&width=1000', 55);
INSERT INTO `product_images` VALUES (155, 'https://supersports.com.vn/cdn/shop/files/DM1120-001-4.jpg?v=1717495856&width=1000', 55);
INSERT INTO `product_images` VALUES (156, 'https://supersports.com.vn/cdn/shop/products/3026021-001-1.jpg?v=1679654495&width=1600', 56);
INSERT INTO `product_images` VALUES (157, 'https://supersports.com.vn/cdn/shop/products/3026021-001-2.jpg?v=1679654496&width=1600', 56);
INSERT INTO `product_images` VALUES (158, 'https://supersports.com.vn/cdn/shop/products/3026021-001-4.jpg?v=1679654495&width=1600', 56);
INSERT INTO `product_images` VALUES (159, 'https://supersports.com.vn/cdn/shop/files/3027177-002-1.jpg?v=1709269210&width=1000', 57);
INSERT INTO `product_images` VALUES (160, 'https://supersports.com.vn/cdn/shop/files/3027177-002-2.jpg?v=1709269210&width=1000', 57);
INSERT INTO `product_images` VALUES (161, 'https://supersports.com.vn/cdn/shop/files/3027177-002-3.jpg?v=1709269210&width=1000', 57);
INSERT INTO `product_images` VALUES (162, 'https://supersports.com.vn/cdn/shop/files/3026534-100-1.jpg?v=1705907447&width=1000', 58);
INSERT INTO `product_images` VALUES (163, 'https://supersports.com.vn/cdn/shop/files/3026534-100-2.jpg?v=1705907448&width=1000', 58);
INSERT INTO `product_images` VALUES (164, 'https://supersports.com.vn/cdn/shop/files/3026534-100-4.jpg?v=1705907447&width=1000', 58);
INSERT INTO `product_images` VALUES (165, 'https://supersports.com.vn/cdn/shop/files/3027341-002-1.jpg?v=1708585479&width=1000', 59);
INSERT INTO `product_images` VALUES (166, 'https://supersports.com.vn/cdn/shop/files/3027341-002-2.jpg?v=1708585478&width=1000', 59);
INSERT INTO `product_images` VALUES (167, 'https://supersports.com.vn/cdn/shop/files/3027341-002-3.jpg?v=1708585478&width=1000', 59);
INSERT INTO `product_images` VALUES (168, 'https://supersports.com.vn/cdn/shop/files/3027344-100-1.jpg?v=1705897521&width=1000', 60);
INSERT INTO `product_images` VALUES (169, 'https://supersports.com.vn/cdn/shop/files/3027344-100-2.jpg?v=1705897521&width=1000', 60);
INSERT INTO `product_images` VALUES (170, 'https://supersports.com.vn/cdn/shop/files/3027344-100-4.jpg?v=1705897521&width=1000', 60);
INSERT INTO `product_images` VALUES (171, 'https://supersports.com.vn/cdn/shop/files/JS0913-1.jpg?v=1750668563&width=1000', 61);
INSERT INTO `product_images` VALUES (172, 'https://supersports.com.vn/cdn/shop/files/JS0913-2.jpg?v=1750668563&width=1000', 61);
INSERT INTO `product_images` VALUES (173, 'https://supersports.com.vn/cdn/shop/files/JS0913-3.jpg?v=1750668563&width=1000', 61);
INSERT INTO `product_images` VALUES (174, 'https://supersports.com.vn/cdn/shop/files/ID6285-1.jpg?v=1712309750&width=1000', 62);
INSERT INTO `product_images` VALUES (175, 'https://supersports.com.vn/cdn/shop/files/ID6285-2.jpg?v=1712309750&width=1000', 62);
INSERT INTO `product_images` VALUES (176, 'https://supersports.com.vn/cdn/shop/files/ID6285-3.jpg?v=1712309750&width=1000', 62);
INSERT INTO `product_images` VALUES (177, 'https://supersports.com.vn/cdn/shop/files/ID6286-1.jpg?v=1714041359&width=1000', 63);
INSERT INTO `product_images` VALUES (178, 'https://supersports.com.vn/cdn/shop/files/ID6286-2.jpg?v=1714041359&width=1000', 63);
INSERT INTO `product_images` VALUES (179, 'https://supersports.com.vn/cdn/shop/files/ID6286-3.jpg?v=1714041359&width=1000', 63);
INSERT INTO `product_images` VALUES (180, 'https://supersports.com.vn/cdn/shop/files/IH0457-1.jpg?v=1731386759&width=1000', 64);
INSERT INTO `product_images` VALUES (181, 'https://supersports.com.vn/cdn/shop/files/IH0457-2.jpg?v=1731386759&width=1000', 64);
INSERT INTO `product_images` VALUES (182, 'https://supersports.com.vn/cdn/shop/files/IH0457-3.jpg?v=1731386759&width=1000', 64);
INSERT INTO `product_images` VALUES (183, 'https://supersports.com.vn/cdn/shop/files/JR3521-1.jpg?v=1750668483&width=1000', 65);
INSERT INTO `product_images` VALUES (184, 'https://supersports.com.vn/cdn/shop/files/JR3521-2.jpg?v=1750668483&width=1000', 65);
INSERT INTO `product_images` VALUES (185, 'https://supersports.com.vn/cdn/shop/files/JR3521-3.jpg?v=1750668483&width=1000', 65);
INSERT INTO `product_images` VALUES (186, 'https://supersports.com.vn/cdn/shop/files/IF4458-1.jpg?v=1723020563&width=1000', 66);
INSERT INTO `product_images` VALUES (187, 'https://supersports.com.vn/cdn/shop/files/IF4458-2.jpg?v=1723020565&width=1000', 66);
INSERT INTO `product_images` VALUES (188, 'https://supersports.com.vn/cdn/shop/files/IF4458-3.jpg?v=1723020564&width=1000', 66);
INSERT INTO `product_images` VALUES (189, 'https://supersports.com.vn/cdn/shop/files/IH2421-1.jpg?v=1727859670&width=1000', 67);
INSERT INTO `product_images` VALUES (190, 'https://supersports.com.vn/cdn/shop/files/IH2421-2.jpg?v=1727859671&width=1000', 67);
INSERT INTO `product_images` VALUES (191, 'https://supersports.com.vn/cdn/shop/files/IH2421-3.jpg?v=1727859671&width=1000', 67);
INSERT INTO `product_images` VALUES (192, 'https://supersports.com.vn/cdn/shop/files/JH6944-1.jpg?v=1733817472&width=1000', 68);
INSERT INTO `product_images` VALUES (193, 'https://supersports.com.vn/cdn/shop/files/JH6944-2.jpg?v=1733817473&width=1000', 68);
INSERT INTO `product_images` VALUES (194, 'https://supersports.com.vn/cdn/shop/files/JH6944-3.jpg?v=1733817473&width=1000', 68);
INSERT INTO `product_images` VALUES (195, 'https://supersports.com.vn/cdn/shop/files/JI2318-1.jpg?v=1733817949&width=1000', 69);
INSERT INTO `product_images` VALUES (196, 'https://supersports.com.vn/cdn/shop/files/JI2318-2.jpg?v=1733817949&width=1000', 69);
INSERT INTO `product_images` VALUES (197, 'https://supersports.com.vn/cdn/shop/files/JI2318-3.jpg?v=1733817949&width=1000', 69);
INSERT INTO `product_images` VALUES (198, 'https://supersports.com.vn/cdn/shop/files/JI4919-1.jpg?v=1733818183&width=1000', 70);
INSERT INTO `product_images` VALUES (199, 'https://supersports.com.vn/cdn/shop/files/JI4919-2.jpg?v=1733818183&width=1000', 70);
INSERT INTO `product_images` VALUES (200, 'https://supersports.com.vn/cdn/shop/files/JI4919-3.jpg?v=1733818183&width=1000', 70);
INSERT INTO `product_images` VALUES (201, 'https://supersports.com.vn/cdn/shop/files/1203A614.301-1.jpg?v=1752207664&width=1000', 71);
INSERT INTO `product_images` VALUES (202, 'https://supersports.com.vn/cdn/shop/files/1203A614.301-2.jpg?v=1752207665&width=1000', 71);
INSERT INTO `product_images` VALUES (203, 'https://supersports.com.vn/cdn/shop/files/1203A614.301-3.jpg?v=1752207664&width=1000', 71);
INSERT INTO `product_images` VALUES (204, 'https://supersports.com.vn/cdn/shop/files/1203A614.100-1.jpg?v=1752207567&width=1000', 72);
INSERT INTO `product_images` VALUES (205, 'https://supersports.com.vn/cdn/shop/files/1203A614.100-2.jpg?v=1752207567&width=1000', 72);
INSERT INTO `product_images` VALUES (206, 'https://supersports.com.vn/cdn/shop/files/1203A614.100-3.jpg?v=1752207567&width=1000', 72);
INSERT INTO `product_images` VALUES (207, 'https://supersports.com.vn/cdn/shop/files/1201A256.118-1.jpg?v=1753087795&width=1000', 73);
INSERT INTO `product_images` VALUES (208, 'https://supersports.com.vn/cdn/shop/files/1201A256.118-2.jpg?v=1753087795&width=1000', 73);
INSERT INTO `product_images` VALUES (209, 'https://supersports.com.vn/cdn/shop/files/1201A256.118-3.jpg?v=1753087795&width=1000', 73);
INSERT INTO `product_images` VALUES (210, 'https://supersports.com.vn/cdn/shop/files/1203A609.105-1.jpg?v=1747372164&width=1000', 74);
INSERT INTO `product_images` VALUES (211, 'https://supersports.com.vn/cdn/shop/files/1203A609.105-2.jpg?v=1747372164&width=1000', 74);
INSERT INTO `product_images` VALUES (212, 'https://supersports.com.vn/cdn/shop/files/1203A609.105-3.jpg?v=1747372164&width=1000', 74);
INSERT INTO `product_images` VALUES (213, 'https://supersports.com.vn/cdn/shop/files/162050C-1.jpg?v=1703496901&width=1600', 75);
INSERT INTO `product_images` VALUES (214, 'https://supersports.com.vn/cdn/shop/files/162050C-2.jpg?v=1703496901&width=1600', 75);
INSERT INTO `product_images` VALUES (215, 'https://supersports.com.vn/cdn/shop/files/162050C-5.jpg?v=1703496900&width=1600', 75);
INSERT INTO `product_images` VALUES (216, 'https://supersports.com.vn/cdn/shop/files/JQ9688-1.jpg?v=1751365416&width=1000', 76);
INSERT INTO `product_images` VALUES (217, 'https://supersports.com.vn/cdn/shop/files/JQ9688-2.jpg?v=1751365416&width=1000', 76);
INSERT INTO `product_images` VALUES (218, 'https://supersports.com.vn/cdn/shop/files/JQ9688-3.jpg?v=1751365416&width=1000', 76);
INSERT INTO `product_images` VALUES (219, 'https://supersports.com.vn/cdn/shop/files/JQ9684-1.jpg?v=1751365385&width=1000', 77);
INSERT INTO `product_images` VALUES (220, 'https://supersports.com.vn/cdn/shop/files/JQ9684-2.jpg?v=1751365385&width=1000', 77);
INSERT INTO `product_images` VALUES (221, 'https://supersports.com.vn/cdn/shop/files/JQ9684-3.jpg?v=1751365385&width=1000', 77);
INSERT INTO `product_images` VALUES (222, 'https://supersports.com.vn/cdn/shop/files/JS4256-1.jpg?v=1750668596&width=1000', 78);
INSERT INTO `product_images` VALUES (223, 'https://supersports.com.vn/cdn/shop/files/JS4256-2.jpg?v=1750668596&width=1000', 78);
INSERT INTO `product_images` VALUES (224, 'https://supersports.com.vn/cdn/shop/files/JS4256-3.jpg?v=1750668596&width=1000', 78);
INSERT INTO `product_images` VALUES (225, 'https://supersports.com.vn/cdn/shop/files/JR3544-1.jpg?v=1750668507&width=1000', 79);
INSERT INTO `product_images` VALUES (226, 'https://supersports.com.vn/cdn/shop/files/JR3544-2.jpg?v=1750668507&width=1000', 79);
INSERT INTO `product_images` VALUES (227, 'https://supersports.com.vn/cdn/shop/files/JR3544-3.jpg?v=1750668507&width=1000', 79);
INSERT INTO `product_images` VALUES (228, 'https://supersports.com.vn/cdn/shop/files/GW9213-1.jpg?v=1702022974&width=1000', 80);
INSERT INTO `product_images` VALUES (229, 'https://supersports.com.vn/cdn/shop/files/GW9213-2.jpg?v=1702022972&width=1000', 80);
INSERT INTO `product_images` VALUES (230, 'https://supersports.com.vn/cdn/shop/files/GW9213-3.jpg?v=1702022973&width=1000', 80);
INSERT INTO `product_images` VALUES (231, 'https://supersports.com.vn/cdn/shop/files/ID8796-1.jpg?v=1720490104&width=1000', 81);
INSERT INTO `product_images` VALUES (232, 'https://supersports.com.vn/cdn/shop/files/ID8796-2.jpg?v=1720490104&width=1000', 81);
INSERT INTO `product_images` VALUES (233, 'https://supersports.com.vn/cdn/shop/files/ID8796-3.jpg?v=1720490105&width=1000', 81);
INSERT INTO `product_images` VALUES (234, 'https://supersports.com.vn/cdn/shop/files/IG4416-1.jpg?v=1731386728&width=1000', 82);
INSERT INTO `product_images` VALUES (235, 'https://supersports.com.vn/cdn/shop/files/IG4416-2.jpg?v=1731386728&width=1000', 82);
INSERT INTO `product_images` VALUES (236, 'https://supersports.com.vn/cdn/shop/files/IG4416-3.jpg?v=1731386728&width=1000', 82);
INSERT INTO `product_images` VALUES (237, 'https://supersports.com.vn/cdn/shop/files/IG4344-1.jpg?v=1753095053&width=1000', 83);
INSERT INTO `product_images` VALUES (238, 'https://supersports.com.vn/cdn/shop/files/IG4344-2.jpg?v=1753095055&width=1000', 83);
INSERT INTO `product_images` VALUES (239, 'https://supersports.com.vn/cdn/shop/files/IG4344-3.jpg?v=1753095057&width=1000', 83);
INSERT INTO `product_images` VALUES (240, 'https://supersports.com.vn/cdn/shop/files/IG4346-1.jpg?v=1731386620&width=1000', 84);
INSERT INTO `product_images` VALUES (241, 'https://supersports.com.vn/cdn/shop/files/IG4346-2.jpg?v=1731386621&width=1000', 84);
INSERT INTO `product_images` VALUES (242, 'https://supersports.com.vn/cdn/shop/files/IG4346-3.jpg?v=1731386620&width=1000', 84);
INSERT INTO `product_images` VALUES (243, 'https://supersports.com.vn/cdn/shop/files/JI1784-1.jpg?v=1733817784&width=1000', 85);
INSERT INTO `product_images` VALUES (244, 'https://supersports.com.vn/cdn/shop/files/JI1784-2.jpg?v=1733817784&width=1000', 85);
INSERT INTO `product_images` VALUES (245, 'https://supersports.com.vn/cdn/shop/files/JI1784-3.jpg?v=1733817784&width=1000', 85);
INSERT INTO `product_images` VALUES (246, 'https://supersports.com.vn/cdn/shop/files/JH6962-1.jpg?v=1733817585&width=1000', 86);
INSERT INTO `product_images` VALUES (247, 'https://supersports.com.vn/cdn/shop/files/JH6962-2.jpg?v=1733817585&width=1000', 86);
INSERT INTO `product_images` VALUES (248, 'https://supersports.com.vn/cdn/shop/files/JH6962-3.jpg?v=1733817586&width=1000', 86);
INSERT INTO `product_images` VALUES (249, 'https://supersports.com.vn/cdn/shop/files/JR3103-1.jpg?v=1733818962&width=1000', 87);
INSERT INTO `product_images` VALUES (250, 'https://supersports.com.vn/cdn/shop/files/JR3103-2.jpg?v=1733818961&width=1000', 87);
INSERT INTO `product_images` VALUES (251, 'https://supersports.com.vn/cdn/shop/files/JR3103-3.jpg?v=1733818961&width=1000', 87);
INSERT INTO `product_images` VALUES (252, 'https://supersports.com.vn/cdn/shop/files/ID8797-1.jpg?v=1712309775&width=1000', 88);
INSERT INTO `product_images` VALUES (253, 'https://supersports.com.vn/cdn/shop/files/ID8797-2.jpg?v=1712309775&width=1000', 88);
INSERT INTO `product_images` VALUES (254, 'https://supersports.com.vn/cdn/shop/files/ID8797-3.jpg?v=1712309775&width=1000', 88);
INSERT INTO `product_images` VALUES (255, 'https://supersports.com.vn/cdn/shop/files/GW9214-1.jpg?v=1702022989&width=1000', 89);
INSERT INTO `product_images` VALUES (256, 'https://supersports.com.vn/cdn/shop/files/GW9214-2.jpg?v=1702022989&width=1000', 89);
INSERT INTO `product_images` VALUES (257, 'https://supersports.com.vn/cdn/shop/files/GW9214-3.jpg?v=1702022990&width=1000', 89);
INSERT INTO `product_images` VALUES (258, 'https://supersports.com.vn/cdn/shop/files/HQ4207-1.jpg?v=1717755544&width=1000', 90);
INSERT INTO `product_images` VALUES (259, 'https://supersports.com.vn/cdn/shop/files/HQ4207-2.jpg?v=1717755544&width=1000', 90);
INSERT INTO `product_images` VALUES (260, 'https://supersports.com.vn/cdn/shop/files/HQ4207-3.jpg?v=1717755544&width=1000', 90);
INSERT INTO `product_images` VALUES (261, 'https://images.pexels.com/photos/19090/pexels-photo.jpg', 91);

-- ----------------------------
-- Table structure for product_variants
-- ----------------------------
DROP TABLE IF EXISTS `product_variants`;
CREATE TABLE `product_variants`  (
  `id_variant` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `size` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stock_quantity` int(11) NULL DEFAULT NULL,
  `id_product` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_variant`) USING BTREE,
  INDEX `id_product`(`id_product`) USING BTREE,
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 513 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_variants
-- ----------------------------
INSERT INTO `product_variants` VALUES (1, 'Xanh Dương', 'US 8', 20, 1);
INSERT INTO `product_variants` VALUES (2, 'Xanh Dương', 'US 8.5', 20, 1);
INSERT INTO `product_variants` VALUES (3, 'Xanh Dương', 'US 9', 20, 1);
INSERT INTO `product_variants` VALUES (4, 'Xanh Dương', 'US 9.5', 20, 1);
INSERT INTO `product_variants` VALUES (5, 'Xanh Dương', 'US 10', 20, 1);
INSERT INTO `product_variants` VALUES (6, 'Đỏ', 'US 8', 20, 1);
INSERT INTO `product_variants` VALUES (7, 'Đỏ', 'US 8.5', 20, 1);
INSERT INTO `product_variants` VALUES (8, 'Đỏ', 'US 9', 20, 1);
INSERT INTO `product_variants` VALUES (9, 'Đỏ', 'US 9.5', 20, 1);
INSERT INTO `product_variants` VALUES (10, 'Đỏ', 'US 10', 20, 1);
INSERT INTO `product_variants` VALUES (11, 'Xanh Lá', 'US 8', 20, 1);
INSERT INTO `product_variants` VALUES (12, 'Xanh Lá', 'US 8.5', 20, 1);
INSERT INTO `product_variants` VALUES (13, 'Xanh Lá', 'US 9', 20, 1);
INSERT INTO `product_variants` VALUES (14, 'Xanh Lá', 'US 9.5', 20, 1);
INSERT INTO `product_variants` VALUES (15, 'Xanh Lá', 'US 10', 14, 1);
INSERT INTO `product_variants` VALUES (16, 'Xanh Navy', 'US 8', 18, 2);
INSERT INTO `product_variants` VALUES (17, 'Xanh Navy', 'US 8.5', 20, 2);
INSERT INTO `product_variants` VALUES (18, 'Xanh Navy', 'US 9', 20, 2);
INSERT INTO `product_variants` VALUES (19, 'Xanh Navy', 'US 9.5', 20, 2);
INSERT INTO `product_variants` VALUES (20, 'Xanh Navy', 'US 10', 20, 2);
INSERT INTO `product_variants` VALUES (21, 'Đỏ', 'US 8', 20, 3);
INSERT INTO `product_variants` VALUES (22, 'Đỏ', 'US 8.5', 20, 3);
INSERT INTO `product_variants` VALUES (23, 'Đỏ', 'US 9', 20, 3);
INSERT INTO `product_variants` VALUES (24, 'Đỏ', 'US 9.5', 20, 3);
INSERT INTO `product_variants` VALUES (25, 'Đỏ', 'US 10', 20, 3);
INSERT INTO `product_variants` VALUES (26, 'Vàng', 'US 8', 19, 4);
INSERT INTO `product_variants` VALUES (27, 'Vàng', 'US 8.5', 20, 4);
INSERT INTO `product_variants` VALUES (28, 'Vàng', 'US 9', 20, 4);
INSERT INTO `product_variants` VALUES (29, 'Vàng', 'US 9.5', 20, 4);
INSERT INTO `product_variants` VALUES (30, 'Vàng', 'US 10', 20, 4);
INSERT INTO `product_variants` VALUES (31, 'Đen', 'US 8', 20, 5);
INSERT INTO `product_variants` VALUES (32, 'Đen', 'US 8.5', 20, 5);
INSERT INTO `product_variants` VALUES (33, 'Đen', 'US 9', 20, 5);
INSERT INTO `product_variants` VALUES (34, 'Đen', 'US 9.5', 20, 5);
INSERT INTO `product_variants` VALUES (35, 'Đen', 'US 10', 20, 5);
INSERT INTO `product_variants` VALUES (36, 'Xanh Dương', 'US 8', 20, 5);
INSERT INTO `product_variants` VALUES (37, 'Xanh Dương', 'US 8.5', 20, 5);
INSERT INTO `product_variants` VALUES (38, 'Xanh Dương', 'US 9', 20, 5);
INSERT INTO `product_variants` VALUES (39, 'Xanh Dương', 'US 9.5', 20, 5);
INSERT INTO `product_variants` VALUES (40, 'Xanh Dương', 'US 10', 20, 5);
INSERT INTO `product_variants` VALUES (41, 'Cam', 'US 8', 20, 5);
INSERT INTO `product_variants` VALUES (42, 'Cam', 'US 8.5', 20, 5);
INSERT INTO `product_variants` VALUES (43, 'Cam', 'US 9', 20, 5);
INSERT INTO `product_variants` VALUES (44, 'Cam', 'US 9.5', 20, 5);
INSERT INTO `product_variants` VALUES (45, 'Cam', 'US 10', 20, 5);
INSERT INTO `product_variants` VALUES (46, 'Xanh Dương', 'US 8', 20, 6);
INSERT INTO `product_variants` VALUES (47, 'Xanh Dương', 'US 8.5', 20, 6);
INSERT INTO `product_variants` VALUES (48, 'Xanh Dương', 'US 9', 20, 6);
INSERT INTO `product_variants` VALUES (49, 'Xanh Dương', 'US 9.5', 20, 6);
INSERT INTO `product_variants` VALUES (50, 'Xanh Dương', 'US 10', 20, 6);
INSERT INTO `product_variants` VALUES (51, 'Tím', 'US 8', 20, 6);
INSERT INTO `product_variants` VALUES (52, 'Tím', 'US 8.5', 20, 6);
INSERT INTO `product_variants` VALUES (53, 'Tím', 'US 9', 20, 6);
INSERT INTO `product_variants` VALUES (54, 'Tím', 'US 9.5', 20, 6);
INSERT INTO `product_variants` VALUES (55, 'Tím', 'US 10', 20, 6);
INSERT INTO `product_variants` VALUES (56, 'Đen', 'US 8', 19, 7);
INSERT INTO `product_variants` VALUES (57, 'Đen', 'US 8.5', 20, 7);
INSERT INTO `product_variants` VALUES (58, 'Đen', 'US 9', 20, 7);
INSERT INTO `product_variants` VALUES (59, 'Đen', 'US 9.5', 20, 7);
INSERT INTO `product_variants` VALUES (60, 'Đen', 'US 10', 20, 7);
INSERT INTO `product_variants` VALUES (61, 'Trắng', 'US 8', 20, 7);
INSERT INTO `product_variants` VALUES (62, 'Trắng', 'US 8.5', 20, 7);
INSERT INTO `product_variants` VALUES (63, 'Trắng', 'US 9', 20, 7);
INSERT INTO `product_variants` VALUES (64, 'Trắng', 'US 9.5', 20, 7);
INSERT INTO `product_variants` VALUES (65, 'Trắng', 'US 10', 20, 7);
INSERT INTO `product_variants` VALUES (66, 'Tím', 'US 8', 20, 7);
INSERT INTO `product_variants` VALUES (67, 'Tím', 'US 8.5', 20, 7);
INSERT INTO `product_variants` VALUES (68, 'Tím', 'US 9', 20, 7);
INSERT INTO `product_variants` VALUES (69, 'Tím', 'US 9.5', 20, 7);
INSERT INTO `product_variants` VALUES (70, 'Tím', 'US 10', 20, 7);
INSERT INTO `product_variants` VALUES (71, 'Đen', 'US 8', 19, 8);
INSERT INTO `product_variants` VALUES (72, 'Đen', 'US 8.5', 20, 8);
INSERT INTO `product_variants` VALUES (73, 'Đen', 'US 9', 20, 8);
INSERT INTO `product_variants` VALUES (74, 'Đen', 'US 9.5', 20, 8);
INSERT INTO `product_variants` VALUES (75, 'Đen', 'US 10', 20, 8);
INSERT INTO `product_variants` VALUES (76, 'Đỏ', 'US 8', 20, 8);
INSERT INTO `product_variants` VALUES (77, 'Đỏ', 'US 8.5', 20, 8);
INSERT INTO `product_variants` VALUES (78, 'Đỏ', 'US 9', 20, 8);
INSERT INTO `product_variants` VALUES (79, 'Đỏ', 'US 9', 20, 8);
INSERT INTO `product_variants` VALUES (80, 'Đỏ', 'US 10', 20, 8);
INSERT INTO `product_variants` VALUES (81, 'Đen', 'US 8', 20, 9);
INSERT INTO `product_variants` VALUES (82, 'Đen', 'US 8.5', 20, 9);
INSERT INTO `product_variants` VALUES (83, 'Đen', 'US 9', 20, 9);
INSERT INTO `product_variants` VALUES (84, 'Đen', 'US 9.5', 20, 9);
INSERT INTO `product_variants` VALUES (85, 'Đen', 'US 10', 20, 9);
INSERT INTO `product_variants` VALUES (86, 'Trắng', 'US 8', 20, 9);
INSERT INTO `product_variants` VALUES (87, 'Trắng', 'US 8.5', 20, 9);
INSERT INTO `product_variants` VALUES (88, 'Trắng', 'US 9', 20, 9);
INSERT INTO `product_variants` VALUES (89, 'Trắng', 'US 9.5', 20, 9);
INSERT INTO `product_variants` VALUES (90, 'Trắng', 'US 10', 20, 9);
INSERT INTO `product_variants` VALUES (91, 'Xanh Dương', 'US 8', 20, 10);
INSERT INTO `product_variants` VALUES (92, 'Xanh Dương', 'US 8.5', 20, 10);
INSERT INTO `product_variants` VALUES (93, 'Xanh Dương', 'US 9', 20, 10);
INSERT INTO `product_variants` VALUES (94, 'Xanh Dương', 'US 9.5', 20, 10);
INSERT INTO `product_variants` VALUES (95, 'Xanh Dương', 'US 10', 20, 10);
INSERT INTO `product_variants` VALUES (96, 'Vàng', 'US 8', 20, 10);
INSERT INTO `product_variants` VALUES (97, 'Vàng', 'US 8.5', 20, 10);
INSERT INTO `product_variants` VALUES (98, 'Vàng', 'US 9', 20, 10);
INSERT INTO `product_variants` VALUES (99, 'Vàng', 'US 9.5', 20, 10);
INSERT INTO `product_variants` VALUES (100, 'Vàng', 'US 10', 20, 10);
INSERT INTO `product_variants` VALUES (101, 'Xanh Dương', 'US 8', 20, 11);
INSERT INTO `product_variants` VALUES (102, 'Xanh Dương', 'US 8.5', 20, 11);
INSERT INTO `product_variants` VALUES (103, 'Xanh Dương', 'US 9', 20, 11);
INSERT INTO `product_variants` VALUES (104, 'Xanh Dương', 'US 9.5', 20, 11);
INSERT INTO `product_variants` VALUES (105, 'Xanh Dương', 'US 10', 20, 11);
INSERT INTO `product_variants` VALUES (106, 'Trắng', 'US 8', 20, 12);
INSERT INTO `product_variants` VALUES (107, 'Trắng', 'US 8.5', 20, 12);
INSERT INTO `product_variants` VALUES (108, 'Trắng', 'US 9', 20, 12);
INSERT INTO `product_variants` VALUES (109, 'Trắng', 'US 9.5', 20, 12);
INSERT INTO `product_variants` VALUES (110, 'Trắng', 'US 10', 20, 12);
INSERT INTO `product_variants` VALUES (111, 'Trắng', 'US 8', 20, 13);
INSERT INTO `product_variants` VALUES (112, 'Trắng', 'US 8.5', 20, 13);
INSERT INTO `product_variants` VALUES (113, 'Trắng', 'US 9', 20, 13);
INSERT INTO `product_variants` VALUES (114, 'Trắng', 'US 9.5', 20, 13);
INSERT INTO `product_variants` VALUES (115, 'Trắng', 'US 10', 20, 13);
INSERT INTO `product_variants` VALUES (116, 'Đỏ', 'US 8', 20, 14);
INSERT INTO `product_variants` VALUES (117, 'Đỏ', 'US 8.5', 20, 14);
INSERT INTO `product_variants` VALUES (118, 'Đỏ', 'US 9', 20, 14);
INSERT INTO `product_variants` VALUES (119, 'Đỏ', 'US 9.5', 20, 14);
INSERT INTO `product_variants` VALUES (120, 'Đỏ', 'US 10', 20, 14);
INSERT INTO `product_variants` VALUES (121, 'Xanh Dương', 'US 8', 20, 15);
INSERT INTO `product_variants` VALUES (122, 'Xanh Dương', 'US 8.5', 20, 15);
INSERT INTO `product_variants` VALUES (123, 'Xanh Dương', 'US 9', 20, 15);
INSERT INTO `product_variants` VALUES (124, 'Xanh Dương', 'US 9.5', 20, 15);
INSERT INTO `product_variants` VALUES (125, 'Xanh Dương', 'US 10', 20, 15);
INSERT INTO `product_variants` VALUES (126, 'Tím', 'US 8', 20, 16);
INSERT INTO `product_variants` VALUES (127, 'Tím', 'US 8.5', 20, 16);
INSERT INTO `product_variants` VALUES (128, 'Tím', 'US 9', 20, 16);
INSERT INTO `product_variants` VALUES (129, 'Tím', 'US 9.5', 20, 16);
INSERT INTO `product_variants` VALUES (130, 'Tím', 'US 10', 20, 16);
INSERT INTO `product_variants` VALUES (131, 'Trắng', 'US 8', 20, 17);
INSERT INTO `product_variants` VALUES (132, 'Trắng', 'US 8.5', 20, 17);
INSERT INTO `product_variants` VALUES (133, 'Trắng', 'US 9', 20, 17);
INSERT INTO `product_variants` VALUES (134, 'Trắng', 'US 9.5', 20, 17);
INSERT INTO `product_variants` VALUES (135, 'Trắng', 'US 10', 20, 17);
INSERT INTO `product_variants` VALUES (136, 'Đỏ', 'US 8', 20, 18);
INSERT INTO `product_variants` VALUES (137, 'Đỏ', 'US 8.5', 20, 18);
INSERT INTO `product_variants` VALUES (138, 'Đỏ', 'US 9', 20, 18);
INSERT INTO `product_variants` VALUES (139, 'Đỏ', 'US 9.5', 20, 18);
INSERT INTO `product_variants` VALUES (140, 'Đỏ', 'US 10', 20, 18);
INSERT INTO `product_variants` VALUES (141, 'Trắng', 'US 8', 20, 19);
INSERT INTO `product_variants` VALUES (142, 'Trắng', 'US 8.5', 20, 19);
INSERT INTO `product_variants` VALUES (143, 'Trắng', 'US 9', 20, 19);
INSERT INTO `product_variants` VALUES (144, 'Trắng', 'US 9.5', 20, 19);
INSERT INTO `product_variants` VALUES (145, 'Trắng', 'US 10', 20, 19);
INSERT INTO `product_variants` VALUES (146, 'Trắng', 'US 8', 20, 20);
INSERT INTO `product_variants` VALUES (147, 'Trắng', 'US 8.5', 20, 20);
INSERT INTO `product_variants` VALUES (148, 'Trắng', 'US 9', 20, 20);
INSERT INTO `product_variants` VALUES (149, 'Trắng', 'US 9.5', 20, 20);
INSERT INTO `product_variants` VALUES (150, 'Trắng', 'US 10', 20, 20);
INSERT INTO `product_variants` VALUES (151, 'Trắng', 'US 8', 20, 21);
INSERT INTO `product_variants` VALUES (152, 'Trắng', 'US 8.5', 20, 21);
INSERT INTO `product_variants` VALUES (153, 'Trắng', 'US 9', 20, 21);
INSERT INTO `product_variants` VALUES (154, 'Trắng', 'US 9.5', 20, 21);
INSERT INTO `product_variants` VALUES (155, 'Trắng', 'US 10', 20, 21);
INSERT INTO `product_variants` VALUES (156, 'Đen', 'US 8', 20, 21);
INSERT INTO `product_variants` VALUES (157, 'Đen', 'US 8.5', 20, 21);
INSERT INTO `product_variants` VALUES (158, 'Đen', 'US 9', 20, 21);
INSERT INTO `product_variants` VALUES (159, 'Đen', 'US 9.5', 20, 21);
INSERT INTO `product_variants` VALUES (160, 'Đen', 'US 10', 20, 21);
INSERT INTO `product_variants` VALUES (161, 'Xanh Dương', 'US 8', 20, 22);
INSERT INTO `product_variants` VALUES (162, 'Xanh Dương', 'US 8.5', 20, 22);
INSERT INTO `product_variants` VALUES (163, 'Xanh Dương', 'US 9', 20, 22);
INSERT INTO `product_variants` VALUES (164, 'Xanh Dương', 'US 9.5', 20, 22);
INSERT INTO `product_variants` VALUES (165, 'Xanh Dương', 'US 10', 20, 22);
INSERT INTO `product_variants` VALUES (166, 'Tím', 'US 8', 20, 22);
INSERT INTO `product_variants` VALUES (167, 'Tím', 'US 8.5', 20, 22);
INSERT INTO `product_variants` VALUES (168, 'Tím', 'US 9', 20, 22);
INSERT INTO `product_variants` VALUES (169, 'Tím', 'US 9.5', 20, 22);
INSERT INTO `product_variants` VALUES (170, 'Tím', 'US 10', 20, 22);
INSERT INTO `product_variants` VALUES (171, 'Tím', 'US 8', 20, 23);
INSERT INTO `product_variants` VALUES (172, 'Tím', 'US 8.5', 20, 23);
INSERT INTO `product_variants` VALUES (173, 'Tím', 'US 9', 20, 23);
INSERT INTO `product_variants` VALUES (174, 'Tím', 'US 9.5', 20, 23);
INSERT INTO `product_variants` VALUES (175, 'Tím', 'US 10', 20, 23);
INSERT INTO `product_variants` VALUES (176, 'Đen', 'US 8', 20, 24);
INSERT INTO `product_variants` VALUES (177, 'Đen', 'US 8.5', 20, 24);
INSERT INTO `product_variants` VALUES (178, 'Đen', 'US 9', 20, 24);
INSERT INTO `product_variants` VALUES (179, 'Đen', 'US 9.5', 20, 24);
INSERT INTO `product_variants` VALUES (180, 'Đen', 'US 10', 20, 24);
INSERT INTO `product_variants` VALUES (181, 'Vàng', 'US 8', 20, 25);
INSERT INTO `product_variants` VALUES (182, 'Vàng', 'US 8.5', 20, 25);
INSERT INTO `product_variants` VALUES (183, 'Vàng', 'US 9', 20, 25);
INSERT INTO `product_variants` VALUES (184, 'Vàng', 'US 9.5', 20, 25);
INSERT INTO `product_variants` VALUES (185, 'Vàng', 'US 10', 20, 25);
INSERT INTO `product_variants` VALUES (186, 'Đen', 'US 8', 20, 26);
INSERT INTO `product_variants` VALUES (187, 'Đen', 'US 8.5', 20, 26);
INSERT INTO `product_variants` VALUES (188, 'Đen', 'US 9', 20, 26);
INSERT INTO `product_variants` VALUES (189, 'Đen', 'US 9.5', 20, 26);
INSERT INTO `product_variants` VALUES (190, 'Đen', 'US 10', 20, 26);
INSERT INTO `product_variants` VALUES (191, 'Đỏ', 'US 8', 20, 27);
INSERT INTO `product_variants` VALUES (192, 'Đỏ', 'US 8.5', 20, 27);
INSERT INTO `product_variants` VALUES (193, 'Đỏ', 'US 9', 20, 27);
INSERT INTO `product_variants` VALUES (194, 'Đỏ', 'US 9.5', 20, 27);
INSERT INTO `product_variants` VALUES (195, 'Đỏ', 'US 10', 20, 27);
INSERT INTO `product_variants` VALUES (196, 'Đen', 'US 8', 20, 28);
INSERT INTO `product_variants` VALUES (197, 'Đen', 'US 8.5', 20, 28);
INSERT INTO `product_variants` VALUES (198, 'Đen', 'US 9', 20, 28);
INSERT INTO `product_variants` VALUES (199, 'Đen', 'US 9.5', 20, 28);
INSERT INTO `product_variants` VALUES (200, 'Đen', 'US 10', 20, 28);
INSERT INTO `product_variants` VALUES (201, 'Xanh Dương', 'US 8', 20, 29);
INSERT INTO `product_variants` VALUES (202, 'Xanh Dương', 'US 8.5', 20, 29);
INSERT INTO `product_variants` VALUES (203, 'Xanh Dương', 'US 9', 20, 29);
INSERT INTO `product_variants` VALUES (204, 'Xanh Dương', 'US 9.5', 20, 29);
INSERT INTO `product_variants` VALUES (205, 'Xanh Dương', 'US 10', 20, 29);
INSERT INTO `product_variants` VALUES (206, 'Đỏ', 'US 8', 20, 30);
INSERT INTO `product_variants` VALUES (207, 'Đỏ', 'US 8.5', 20, 30);
INSERT INTO `product_variants` VALUES (208, 'Đỏ', 'US 9', 20, 30);
INSERT INTO `product_variants` VALUES (209, 'Đỏ', 'US 9.5', 20, 30);
INSERT INTO `product_variants` VALUES (210, 'Đỏ', 'US 10', 20, 30);
INSERT INTO `product_variants` VALUES (211, 'Trắng', 'US 8', 20, 31);
INSERT INTO `product_variants` VALUES (212, 'Trắng', 'US 8.5', 20, 31);
INSERT INTO `product_variants` VALUES (213, 'Trắng', 'US 9', 20, 31);
INSERT INTO `product_variants` VALUES (214, 'Trắng', 'US 9.5', 20, 31);
INSERT INTO `product_variants` VALUES (215, 'Trắng', 'US 10', 20, 31);
INSERT INTO `product_variants` VALUES (216, 'Vàng', 'US 8', 20, 32);
INSERT INTO `product_variants` VALUES (217, 'Vàng', 'US 8.5', 20, 32);
INSERT INTO `product_variants` VALUES (218, 'Vàng', 'US 9', 20, 32);
INSERT INTO `product_variants` VALUES (219, 'Vàng', 'US 9.5', 20, 32);
INSERT INTO `product_variants` VALUES (220, 'Vàng', 'US 10', 20, 32);
INSERT INTO `product_variants` VALUES (221, 'Vàng', 'US 8', 20, 33);
INSERT INTO `product_variants` VALUES (222, 'Vàng', 'US 8.5', 20, 33);
INSERT INTO `product_variants` VALUES (223, 'Vàng', 'US 9', 20, 33);
INSERT INTO `product_variants` VALUES (224, 'Vàng', 'US 9.5', 20, 33);
INSERT INTO `product_variants` VALUES (225, 'Vàng', 'US 10', 20, 33);
INSERT INTO `product_variants` VALUES (226, 'Đỏ', 'US 8', 20, 34);
INSERT INTO `product_variants` VALUES (227, 'Đỏ', 'US 8.5', 20, 34);
INSERT INTO `product_variants` VALUES (228, 'Đỏ', 'US 9', 20, 34);
INSERT INTO `product_variants` VALUES (229, 'Đỏ', 'US 9.5', 20, 34);
INSERT INTO `product_variants` VALUES (230, 'Đỏ', 'US 10', 20, 34);
INSERT INTO `product_variants` VALUES (231, 'Đen', 'US 8', 20, 35);
INSERT INTO `product_variants` VALUES (232, 'Đen', 'US 8.5', 20, 35);
INSERT INTO `product_variants` VALUES (233, 'Đen', 'US 9', 20, 35);
INSERT INTO `product_variants` VALUES (234, 'Đen', 'US 9.5', 20, 35);
INSERT INTO `product_variants` VALUES (235, 'Đen', 'US 10', 20, 35);
INSERT INTO `product_variants` VALUES (236, 'Trắng', 'US 8', 20, 36);
INSERT INTO `product_variants` VALUES (237, 'Trắng', 'US 8.5', 20, 36);
INSERT INTO `product_variants` VALUES (238, 'Trắng', 'US 9', 20, 36);
INSERT INTO `product_variants` VALUES (239, 'Trắng', 'US 9.5', 20, 36);
INSERT INTO `product_variants` VALUES (240, 'Trắng', 'US 10', 20, 36);
INSERT INTO `product_variants` VALUES (241, 'Trắng', 'US 8', 20, 37);
INSERT INTO `product_variants` VALUES (242, 'Trắng', 'US 8.5', 20, 37);
INSERT INTO `product_variants` VALUES (243, 'Trắng', 'US 9', 20, 37);
INSERT INTO `product_variants` VALUES (244, 'Trắng', 'US 9.5', 20, 37);
INSERT INTO `product_variants` VALUES (245, 'Trắng', 'US 10', 20, 37);
INSERT INTO `product_variants` VALUES (246, 'Đen', 'US 8', 20, 38);
INSERT INTO `product_variants` VALUES (247, 'Đen', 'US 8.5', 20, 38);
INSERT INTO `product_variants` VALUES (248, 'Đen', 'US 9', 20, 38);
INSERT INTO `product_variants` VALUES (249, 'Đen', 'US 9.5', 20, 38);
INSERT INTO `product_variants` VALUES (250, 'Đen', 'US 10', 20, 38);
INSERT INTO `product_variants` VALUES (251, 'Xanh Dương', 'US 8', 20, 39);
INSERT INTO `product_variants` VALUES (252, 'Xanh Dương', 'US 8.5', 20, 39);
INSERT INTO `product_variants` VALUES (253, 'Xanh Dương', 'US 9', 20, 39);
INSERT INTO `product_variants` VALUES (254, 'Xanh Dương', 'US 9.5', 20, 39);
INSERT INTO `product_variants` VALUES (255, 'Xanh Dương', 'US 10', 20, 39);
INSERT INTO `product_variants` VALUES (256, 'Vàng', 'US 8', 20, 40);
INSERT INTO `product_variants` VALUES (257, 'Vàng', 'US 8.5', 20, 40);
INSERT INTO `product_variants` VALUES (258, 'Vàng', 'US 9', 20, 40);
INSERT INTO `product_variants` VALUES (259, 'Vàng', 'US 9.5', 20, 40);
INSERT INTO `product_variants` VALUES (260, 'Vàng', 'US 10', 20, 40);
INSERT INTO `product_variants` VALUES (261, 'Xám', 'US 8', 20, 41);
INSERT INTO `product_variants` VALUES (262, 'Xám', 'US 8.5', 20, 41);
INSERT INTO `product_variants` VALUES (263, 'Xám', 'US 9', 20, 41);
INSERT INTO `product_variants` VALUES (264, 'Xám', 'US 9.5', 20, 41);
INSERT INTO `product_variants` VALUES (265, 'Xám', 'US 10', 20, 41);
INSERT INTO `product_variants` VALUES (266, 'Trắng', 'US 8', 20, 42);
INSERT INTO `product_variants` VALUES (267, 'Trắng', 'US 8.5', 20, 42);
INSERT INTO `product_variants` VALUES (268, 'Trắng', 'US 9', 20, 42);
INSERT INTO `product_variants` VALUES (269, 'Trắng', 'US 9.5', 20, 42);
INSERT INTO `product_variants` VALUES (270, 'Trắng', 'US 10', 20, 42);
INSERT INTO `product_variants` VALUES (271, 'Trắng', 'US 8', 20, 43);
INSERT INTO `product_variants` VALUES (272, 'Trắng', 'US 8.5', 20, 43);
INSERT INTO `product_variants` VALUES (273, 'Trắng', 'US 9', 20, 43);
INSERT INTO `product_variants` VALUES (274, 'Trắng', 'US 9.5', 20, 43);
INSERT INTO `product_variants` VALUES (275, 'Trắng', 'US 10', 20, 43);
INSERT INTO `product_variants` VALUES (276, 'Đen', 'US 8', 20, 44);
INSERT INTO `product_variants` VALUES (277, 'Đen', 'US 8.5', 20, 44);
INSERT INTO `product_variants` VALUES (278, 'Đen', 'US 9', 20, 44);
INSERT INTO `product_variants` VALUES (279, 'Đen', 'US 9.5', 20, 44);
INSERT INTO `product_variants` VALUES (280, 'Đen', 'US 10', 20, 44);
INSERT INTO `product_variants` VALUES (281, 'Trắng', 'US 8', 20, 45);
INSERT INTO `product_variants` VALUES (282, 'Trắng', 'US 8.5', 20, 45);
INSERT INTO `product_variants` VALUES (283, 'Trắng', 'US 9', 20, 45);
INSERT INTO `product_variants` VALUES (284, 'Trắng', 'US 9.5', 20, 45);
INSERT INTO `product_variants` VALUES (285, 'Trắng', 'US 10', 20, 45);
INSERT INTO `product_variants` VALUES (286, 'Đỏ', 'US 8', 20, 46);
INSERT INTO `product_variants` VALUES (287, 'Đỏ', 'US 8.5', 20, 46);
INSERT INTO `product_variants` VALUES (288, 'Đỏ', 'US 9', 20, 46);
INSERT INTO `product_variants` VALUES (289, 'Đỏ', 'US 9.5', 20, 46);
INSERT INTO `product_variants` VALUES (290, 'Đỏ', 'US 10', 20, 46);
INSERT INTO `product_variants` VALUES (291, 'Trắng', 'US 8', 20, 47);
INSERT INTO `product_variants` VALUES (292, 'Trắng', 'US 8.5', 20, 47);
INSERT INTO `product_variants` VALUES (293, 'Trắng', 'US 9', 20, 47);
INSERT INTO `product_variants` VALUES (294, 'Trắng', 'US 9.5', 20, 47);
INSERT INTO `product_variants` VALUES (295, 'Trắng', 'US 10', 20, 47);
INSERT INTO `product_variants` VALUES (296, 'Xanh Dương', 'US 8', 20, 48);
INSERT INTO `product_variants` VALUES (297, 'Xanh Dương', 'US 8.5', 20, 48);
INSERT INTO `product_variants` VALUES (298, 'Xanh Dương', 'US 9', 20, 48);
INSERT INTO `product_variants` VALUES (299, 'Xanh Dương', 'US 9.5', 20, 48);
INSERT INTO `product_variants` VALUES (300, 'Xanh Dương', 'US 10', 20, 48);
INSERT INTO `product_variants` VALUES (301, 'Đỏ', 'US 8', 20, 49);
INSERT INTO `product_variants` VALUES (302, 'Đỏ', 'US 8.5', 20, 49);
INSERT INTO `product_variants` VALUES (303, 'Đỏ', 'US 9', 20, 49);
INSERT INTO `product_variants` VALUES (304, 'Đỏ', 'US 9.5', 20, 49);
INSERT INTO `product_variants` VALUES (305, 'Đỏ', 'US 10', 20, 49);
INSERT INTO `product_variants` VALUES (306, 'Trắng', 'US 8', 20, 50);
INSERT INTO `product_variants` VALUES (307, 'Trắng', 'US 8.5', 20, 50);
INSERT INTO `product_variants` VALUES (308, 'Trắng', 'US 9', 20, 50);
INSERT INTO `product_variants` VALUES (309, 'Trắng', 'US 9.5', 20, 50);
INSERT INTO `product_variants` VALUES (310, 'Trắng', 'US 10', 20, 50);
INSERT INTO `product_variants` VALUES (311, 'Đen', 'US 8', 20, 51);
INSERT INTO `product_variants` VALUES (312, 'Đen', 'US 8.5', 20, 51);
INSERT INTO `product_variants` VALUES (313, 'Đen', 'US 9', 20, 51);
INSERT INTO `product_variants` VALUES (314, 'Đen', 'US 9.5', 20, 51);
INSERT INTO `product_variants` VALUES (315, 'Đen', 'US 10', 20, 51);
INSERT INTO `product_variants` VALUES (316, 'Đen', 'US 8', 20, 52);
INSERT INTO `product_variants` VALUES (317, 'Đen', 'US 8.5', 20, 52);
INSERT INTO `product_variants` VALUES (318, 'Đen', 'US 9', 20, 52);
INSERT INTO `product_variants` VALUES (319, 'Đen', 'US 9.5', 20, 52);
INSERT INTO `product_variants` VALUES (320, 'Đen', 'US 10', 20, 52);
INSERT INTO `product_variants` VALUES (321, 'Đen', 'US 8', 20, 53);
INSERT INTO `product_variants` VALUES (322, 'Đen', 'US 8.5', 20, 53);
INSERT INTO `product_variants` VALUES (323, 'Đen', 'US 9', 20, 53);
INSERT INTO `product_variants` VALUES (324, 'Đen', 'US 9.5', 20, 53);
INSERT INTO `product_variants` VALUES (325, 'Đen', 'US 10', 20, 53);
INSERT INTO `product_variants` VALUES (326, 'Đen', 'US 8', 20, 54);
INSERT INTO `product_variants` VALUES (327, 'Đen', 'US 8.5', 20, 54);
INSERT INTO `product_variants` VALUES (328, 'Đen', 'US 9', 20, 54);
INSERT INTO `product_variants` VALUES (329, 'Đen', 'US 9.5', 20, 54);
INSERT INTO `product_variants` VALUES (330, 'Đen', 'US 10', 20, 54);
INSERT INTO `product_variants` VALUES (331, 'Đen', 'US 8', 20, 55);
INSERT INTO `product_variants` VALUES (332, 'Đen', 'US 8.5', 20, 55);
INSERT INTO `product_variants` VALUES (333, 'Đen', 'US 9', 20, 55);
INSERT INTO `product_variants` VALUES (334, 'Đen', 'US 9.5', 20, 55);
INSERT INTO `product_variants` VALUES (335, 'Đen', 'US 10', 20, 55);
INSERT INTO `product_variants` VALUES (336, 'Đen', 'US 8', 20, 56);
INSERT INTO `product_variants` VALUES (337, 'Đen', 'US 8.5', 20, 56);
INSERT INTO `product_variants` VALUES (338, 'Đen', 'US 9', 20, 56);
INSERT INTO `product_variants` VALUES (339, 'Đen', 'US 9.5', 20, 56);
INSERT INTO `product_variants` VALUES (340, 'Đen', 'US 10', 20, 56);
INSERT INTO `product_variants` VALUES (341, 'Đen', 'US 8', 20, 57);
INSERT INTO `product_variants` VALUES (342, 'Đen', 'US 8.5', 20, 57);
INSERT INTO `product_variants` VALUES (343, 'Đen', 'US 9', 20, 57);
INSERT INTO `product_variants` VALUES (344, 'Đen', 'US 9.5', 20, 57);
INSERT INTO `product_variants` VALUES (345, 'Đen', 'US 10', 20, 57);
INSERT INTO `product_variants` VALUES (346, 'Trắng', 'US 8.', 20, 58);
INSERT INTO `product_variants` VALUES (347, 'Trắng', 'US 8.5', 20, 58);
INSERT INTO `product_variants` VALUES (348, 'Trắng', 'US 9', 20, 58);
INSERT INTO `product_variants` VALUES (349, 'Trắng', 'US 9.5', 20, 58);
INSERT INTO `product_variants` VALUES (350, 'Trắng', 'US 10', 20, 58);
INSERT INTO `product_variants` VALUES (351, 'Đen', 'US 8', 20, 59);
INSERT INTO `product_variants` VALUES (352, 'Đen', 'US 8.5', 20, 59);
INSERT INTO `product_variants` VALUES (353, 'Đen', 'US 9', 20, 59);
INSERT INTO `product_variants` VALUES (354, 'Đen', 'US 9.5', 20, 59);
INSERT INTO `product_variants` VALUES (355, 'Đen', 'US 10', 20, 59);
INSERT INTO `product_variants` VALUES (356, 'Trắng', 'US 8', 20, 60);
INSERT INTO `product_variants` VALUES (357, 'Trắng', 'US 8.5', 20, 60);
INSERT INTO `product_variants` VALUES (358, 'Trắng', 'US 9', 20, 60);
INSERT INTO `product_variants` VALUES (359, 'Trắng', 'US 9.5', 20, 60);
INSERT INTO `product_variants` VALUES (360, 'Trắng', 'US 10', 20, 60);
INSERT INTO `product_variants` VALUES (361, 'Xám', 'US 8', 19, 61);
INSERT INTO `product_variants` VALUES (362, 'Xám', 'US 8.5', 20, 61);
INSERT INTO `product_variants` VALUES (363, 'Xám', 'US 9', 20, 61);
INSERT INTO `product_variants` VALUES (364, 'Xám', 'US 9.5', 20, 61);
INSERT INTO `product_variants` VALUES (365, 'Xám', 'US 10', 20, 61);
INSERT INTO `product_variants` VALUES (366, 'Trắng', 'US 8', 20, 62);
INSERT INTO `product_variants` VALUES (367, 'Trắng', 'US 8.5', 20, 62);
INSERT INTO `product_variants` VALUES (368, 'Trắng', 'US 9', 20, 62);
INSERT INTO `product_variants` VALUES (369, 'Trắng', 'US 9.5', 20, 62);
INSERT INTO `product_variants` VALUES (370, 'Trắng', 'US 10', 20, 62);
INSERT INTO `product_variants` VALUES (371, 'Đen', 'US 8', 20, 63);
INSERT INTO `product_variants` VALUES (372, 'Đen', 'US 8.5', 20, 63);
INSERT INTO `product_variants` VALUES (373, 'Đen', 'US 9', 20, 63);
INSERT INTO `product_variants` VALUES (374, 'Đen', 'US 9.5', 20, 63);
INSERT INTO `product_variants` VALUES (375, 'Đen', 'US 10', 20, 63);
INSERT INTO `product_variants` VALUES (376, 'Trắng', 'US 8', 20, 64);
INSERT INTO `product_variants` VALUES (377, 'Trắng', 'US 8.5', 20, 64);
INSERT INTO `product_variants` VALUES (378, 'Trắng', 'US 9', 20, 64);
INSERT INTO `product_variants` VALUES (379, 'Trắng', 'US 9.5', 20, 64);
INSERT INTO `product_variants` VALUES (380, 'Trắng', 'US 10', 20, 64);
INSERT INTO `product_variants` VALUES (381, 'Xanh Dương', 'US 8', 19, 65);
INSERT INTO `product_variants` VALUES (382, 'Xanh Dương', 'US 8.5', 20, 65);
INSERT INTO `product_variants` VALUES (383, 'Xanh Dương', 'US 9', 20, 65);
INSERT INTO `product_variants` VALUES (384, 'Xanh Dương', 'US 9.5', 20, 65);
INSERT INTO `product_variants` VALUES (385, 'Xanh Dương', 'US 10', 20, 65);
INSERT INTO `product_variants` VALUES (386, 'Xanh Dương', 'US 8', 20, 66);
INSERT INTO `product_variants` VALUES (387, 'Xanh Dương', 'US 8.5', 20, 66);
INSERT INTO `product_variants` VALUES (388, 'Xanh Dương', 'US 9', 20, 66);
INSERT INTO `product_variants` VALUES (389, 'Xanh Dương', 'US 9.5', 20, 66);
INSERT INTO `product_variants` VALUES (390, 'Xanh Dương', 'US 10', 20, 66);
INSERT INTO `product_variants` VALUES (391, 'Vàng', 'US 8', 20, 67);
INSERT INTO `product_variants` VALUES (392, 'Vàng', 'US 8.5', 20, 67);
INSERT INTO `product_variants` VALUES (393, 'Vàng', 'US 9', 20, 67);
INSERT INTO `product_variants` VALUES (394, 'Vàng', 'US 9.5', 20, 67);
INSERT INTO `product_variants` VALUES (395, 'Vàng', 'US 10', 20, 67);
INSERT INTO `product_variants` VALUES (396, 'Trắng', 'US 8', 20, 68);
INSERT INTO `product_variants` VALUES (397, 'Trắng', 'US 8.5', 20, 68);
INSERT INTO `product_variants` VALUES (398, 'Trắng', 'US 9', 20, 68);
INSERT INTO `product_variants` VALUES (399, 'Trắng', 'US 9.5', 20, 68);
INSERT INTO `product_variants` VALUES (400, 'Trắng', 'US 10', 20, 68);
INSERT INTO `product_variants` VALUES (401, 'Xanh Lá', 'US 8', 20, 69);
INSERT INTO `product_variants` VALUES (402, 'Xanh Lá', 'US 8.5', 20, 69);
INSERT INTO `product_variants` VALUES (403, 'Xanh Lá', 'US 9', 20, 69);
INSERT INTO `product_variants` VALUES (404, 'Xanh Lá', 'US 9.5', 20, 69);
INSERT INTO `product_variants` VALUES (405, 'Xanh Lá', 'US 10', 20, 69);
INSERT INTO `product_variants` VALUES (406, 'Xanh Lá', 'US 8', 20, 70);
INSERT INTO `product_variants` VALUES (407, 'Xanh Lá', 'US 8.5', 20, 70);
INSERT INTO `product_variants` VALUES (408, 'Xanh Lá', 'US 9', 20, 70);
INSERT INTO `product_variants` VALUES (409, 'Xanh Lá', 'US 9.5', 20, 70);
INSERT INTO `product_variants` VALUES (410, 'Xanh Lá', 'US 10', 20, 70);
INSERT INTO `product_variants` VALUES (411, 'Xanh Lá', 'US 8', 20, 71);
INSERT INTO `product_variants` VALUES (412, 'Xanh Lá', 'US 8.5', 20, 71);
INSERT INTO `product_variants` VALUES (413, 'Xanh Lá', 'US 9', 20, 71);
INSERT INTO `product_variants` VALUES (414, 'Xanh Lá', 'US 9.5', 20, 71);
INSERT INTO `product_variants` VALUES (415, 'Xanh Lá', 'US 10', 20, 71);
INSERT INTO `product_variants` VALUES (416, 'Trắng', 'US 8', 20, 72);
INSERT INTO `product_variants` VALUES (417, 'Trắng', 'US 8.5', 20, 72);
INSERT INTO `product_variants` VALUES (418, 'Trắng', 'US 9', 20, 72);
INSERT INTO `product_variants` VALUES (419, 'Trắng', 'US 9.5', 20, 72);
INSERT INTO `product_variants` VALUES (420, 'Trắng', 'US 10', 20, 72);
INSERT INTO `product_variants` VALUES (421, 'Trắng', 'US 8', 20, 73);
INSERT INTO `product_variants` VALUES (422, 'Trắng', 'US 8.5', 20, 73);
INSERT INTO `product_variants` VALUES (423, 'Trắng', 'US 9', 20, 73);
INSERT INTO `product_variants` VALUES (424, 'Trắng', 'US 9.5', 20, 73);
INSERT INTO `product_variants` VALUES (425, 'Trắng', 'US 10', 20, 73);
INSERT INTO `product_variants` VALUES (426, 'Trắng', 'US 8', 20, 74);
INSERT INTO `product_variants` VALUES (427, 'Trắng', 'US 8.5', 20, 74);
INSERT INTO `product_variants` VALUES (428, 'Trắng', 'US 9', 20, 74);
INSERT INTO `product_variants` VALUES (429, 'Trắng', 'US 9.5', 20, 74);
INSERT INTO `product_variants` VALUES (430, 'Trắng', 'US 10', 20, 74);
INSERT INTO `product_variants` VALUES (431, 'Đen', 'US 8', 20, 75);
INSERT INTO `product_variants` VALUES (432, 'Đen', 'US 8.5', 20, 75);
INSERT INTO `product_variants` VALUES (433, 'Đen', 'US 9', 20, 75);
INSERT INTO `product_variants` VALUES (434, 'Đen', 'US 9.5', 20, 75);
INSERT INTO `product_variants` VALUES (435, 'Đen', 'US 10', 20, 75);
INSERT INTO `product_variants` VALUES (436, 'Trắng', 'US 8', 20, 76);
INSERT INTO `product_variants` VALUES (437, 'Trắng', 'US 8.5', 20, 76);
INSERT INTO `product_variants` VALUES (438, 'Trắng', 'US 9', 20, 76);
INSERT INTO `product_variants` VALUES (439, 'Trắng', 'US 9.5', 20, 76);
INSERT INTO `product_variants` VALUES (440, 'Trắng', 'US 10', 20, 76);
INSERT INTO `product_variants` VALUES (441, 'Đen', 'US 8', 20, 77);
INSERT INTO `product_variants` VALUES (442, 'Đen', 'US 8.5', 20, 77);
INSERT INTO `product_variants` VALUES (443, 'Đen', 'US 9', 20, 77);
INSERT INTO `product_variants` VALUES (444, 'Đen', 'US 9.5', 20, 77);
INSERT INTO `product_variants` VALUES (445, 'Đen', 'US 10', 20, 77);
INSERT INTO `product_variants` VALUES (446, 'Xám', 'US 8', 20, 78);
INSERT INTO `product_variants` VALUES (447, 'Xám', 'US 8.5', 20, 78);
INSERT INTO `product_variants` VALUES (448, 'Xám', 'US 9', 20, 78);
INSERT INTO `product_variants` VALUES (449, 'Xám', 'US 9.5', 20, 78);
INSERT INTO `product_variants` VALUES (450, 'Xám', 'US 10', 20, 78);
INSERT INTO `product_variants` VALUES (451, 'Tím', 'US 8', 20, 79);
INSERT INTO `product_variants` VALUES (452, 'Tím', 'US 8.5', 20, 79);
INSERT INTO `product_variants` VALUES (453, 'Tím', 'US 9', 20, 79);
INSERT INTO `product_variants` VALUES (454, 'Tím', 'US 9.5', 20, 79);
INSERT INTO `product_variants` VALUES (455, 'Tím', 'US 10', 20, 79);
INSERT INTO `product_variants` VALUES (456, 'Trắng', 'US 8', 20, 80);
INSERT INTO `product_variants` VALUES (457, 'Trắng', 'US 8.5', 20, 80);
INSERT INTO `product_variants` VALUES (458, 'Trắng', 'US 9', 20, 80);
INSERT INTO `product_variants` VALUES (459, 'Trắng', 'US 9.5', 20, 80);
INSERT INTO `product_variants` VALUES (460, 'Trắng', 'US 10', 20, 80);
INSERT INTO `product_variants` VALUES (461, 'Đen', 'US 8', 20, 81);
INSERT INTO `product_variants` VALUES (462, 'Đen', 'US 8.5', 20, 81);
INSERT INTO `product_variants` VALUES (463, 'Đen', 'US 9', 20, 81);
INSERT INTO `product_variants` VALUES (464, 'Đen', 'US 9.5', 20, 81);
INSERT INTO `product_variants` VALUES (465, 'Đen', 'US 10', 20, 81);
INSERT INTO `product_variants` VALUES (466, 'Xám', 'US 8', 20, 82);
INSERT INTO `product_variants` VALUES (467, 'Xám', 'US 8.5', 20, 82);
INSERT INTO `product_variants` VALUES (468, 'Xám', 'US 9', 20, 82);
INSERT INTO `product_variants` VALUES (469, 'Xám', 'US 9.5', 20, 82);
INSERT INTO `product_variants` VALUES (470, 'Xám', 'US 10', 20, 82);
INSERT INTO `product_variants` VALUES (471, 'Xám', 'US 8', 20, 83);
INSERT INTO `product_variants` VALUES (472, 'Xám', 'US 8.5', 20, 83);
INSERT INTO `product_variants` VALUES (473, 'Xám', 'US 9', 20, 83);
INSERT INTO `product_variants` VALUES (474, 'Xám', 'US 9.5', 20, 83);
INSERT INTO `product_variants` VALUES (475, 'Xám', 'US 10', 20, 83);
INSERT INTO `product_variants` VALUES (476, 'Xám', 'US 8', 20, 84);
INSERT INTO `product_variants` VALUES (477, 'Xám', 'US 8.5', 20, 84);
INSERT INTO `product_variants` VALUES (478, 'Xám', 'US 9', 20, 84);
INSERT INTO `product_variants` VALUES (479, 'Xám', 'US 9.5', 20, 84);
INSERT INTO `product_variants` VALUES (480, 'Xám', 'US 10', 20, 84);
INSERT INTO `product_variants` VALUES (481, 'Vàng', 'US 8', 20, 85);
INSERT INTO `product_variants` VALUES (482, 'Vàng', 'US 8.5', 20, 85);
INSERT INTO `product_variants` VALUES (483, 'Vàng', 'US 9', 20, 85);
INSERT INTO `product_variants` VALUES (484, 'Vàng', 'US 9.5', 20, 85);
INSERT INTO `product_variants` VALUES (485, 'Vàng', 'US 10', 20, 85);
INSERT INTO `product_variants` VALUES (486, 'Trắng', 'US 8', 20, 86);
INSERT INTO `product_variants` VALUES (487, 'Trắng', 'US 8.5', 20, 86);
INSERT INTO `product_variants` VALUES (488, 'Trắng', 'US 9', 20, 86);
INSERT INTO `product_variants` VALUES (489, 'Trắng', 'US 9.5', 20, 86);
INSERT INTO `product_variants` VALUES (490, 'Trắng', 'US 10', 20, 86);
INSERT INTO `product_variants` VALUES (491, 'Xanh Dương', 'US 8', 20, 87);
INSERT INTO `product_variants` VALUES (492, 'Xanh Dương', 'US 8.5', 20, 87);
INSERT INTO `product_variants` VALUES (493, 'Xanh Dương', 'US 9', 20, 87);
INSERT INTO `product_variants` VALUES (494, 'Xanh Dương', 'US 9.5', 20, 87);
INSERT INTO `product_variants` VALUES (495, 'Xanh Dương', 'US 10', 20, 87);
INSERT INTO `product_variants` VALUES (496, 'Trắng', 'US 8', 20, 88);
INSERT INTO `product_variants` VALUES (497, 'Trắng', 'US 8.5', 20, 88);
INSERT INTO `product_variants` VALUES (498, 'Trắng', 'US 9', 20, 88);
INSERT INTO `product_variants` VALUES (499, 'Trắng', 'US 9.5', 20, 88);
INSERT INTO `product_variants` VALUES (500, 'Trắng', 'US 10', 20, 88);
INSERT INTO `product_variants` VALUES (501, 'Trắng', 'US 8', 20, 89);
INSERT INTO `product_variants` VALUES (502, 'Trắng', 'US 8.5', 20, 89);
INSERT INTO `product_variants` VALUES (503, 'Trắng', 'US 9', 20, 89);
INSERT INTO `product_variants` VALUES (504, 'Trắng', 'US 9.5', 20, 89);
INSERT INTO `product_variants` VALUES (505, 'Trắng', 'US 10', 20, 89);
INSERT INTO `product_variants` VALUES (506, 'Trắng', 'US 8', 20, 90);
INSERT INTO `product_variants` VALUES (507, 'Trắng', 'US 8.5', 20, 90);
INSERT INTO `product_variants` VALUES (508, 'Trắng', 'US 9', 20, 90);
INSERT INTO `product_variants` VALUES (509, 'Trắng', 'US 9.5', 20, 90);
INSERT INTO `product_variants` VALUES (510, 'Trắng', 'US 10', 20, 90);
INSERT INTO `product_variants` VALUES (511, 'Trắng', 'US10', 20, 91);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id_product` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_brand` int(11) NULL DEFAULT NULL,
  `id_category` int(11) NULL DEFAULT NULL,
  `discount_percent` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id_product`) USING BTREE,
  INDEX `id_brand`(`id_brand`) USING BTREE,
  INDEX `id_category`(`id_category`) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id_brand`) REFERENCES `brands` (`id_brand`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Giày Bóng Đá Dành Cho Sân Cỏ Nhân Tạo Nam Nike Zoom Vapor 16 Academy', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 2, 30);
INSERT INTO `products` VALUES (2, 'Giàu Đá Bóng Dành Cho Sân Cỏ Nhân Tạo Nam Nike Phantom Gx Ii Academy Erling Haaland', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 2, 30);
INSERT INTO `products` VALUES (3, 'Giày Đá Bóng Dành Cho Mọi Loại Sân Nam Nike Zoom Vapor 16 Academy Fg/Mg', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 2, 30);
INSERT INTO `products` VALUES (4, 'Giày Đá Bóng Sân Cỏ Nhân Tạo Nam Nike Air Zoom Mercurial Vapor 16 Academy Tf Mbappé Personal Edition', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 2, 30);
INSERT INTO `products` VALUES (5, 'Giày Đá Bóng Dành Cho Sân Cỏ Tự Nhiên Nam Nike Legend 10 Academy', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 2, 30);
INSERT INTO `products` VALUES (6, 'Giày Đá Bóng Nam Adidas F50 Elite Firm Ground (Dành Cho Sân Cỏ Tự Nhiên)', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 2, 30);
INSERT INTO `products` VALUES (7, 'Giày Đá Bóng Dành Cho Sân Cỏ Nhân Tạo Nam Adidas F50 League', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 2, 30);
INSERT INTO `products` VALUES (8, 'Giày Đá Bóng Dành Cho Sân Cỏ Nhân Tạo Nam Adidas Predator League', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 2, 30);
INSERT INTO `products` VALUES (9, 'Giày Đá Bóng Sân Cỏ Nhân Tạo Nam Adidas Copa Pure Iii League', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 2, 30);
INSERT INTO `products` VALUES (10, 'Giày Đá Bóng Nam Adidas Predator Elite Firm Ground (Dành Cho Sân Cỏ Tự Nhiên)', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 2, 30);
INSERT INTO `products` VALUES (11, 'Giày Đá Bóng Dành Cho Sân Cỏ Nhân Tạo Nam Puma Ultra 6 Match Tt', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 3, 2, 30);
INSERT INTO `products` VALUES (12, 'Giày Đá Bóng Dành Cho Sân Cỏ Nhân Tạo Nam Puma Future 8 Play Tt', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 3, 2, 30);
INSERT INTO `products` VALUES (13, 'Giày Đá Bóng Dành Cho Sân Cỏ Nhân Tạo Nam Puma King Match Tt', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 3, 2, 30);
INSERT INTO `products` VALUES (14, 'Giày Đá Bóng Dành Cho Mọi Loại Sân Nam Nike Zm Superfly 10 Acad Fg/Mg', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 2, 30);
INSERT INTO `products` VALUES (15, 'Giày Bóng Đá Dành Cho Sân Cỏ Nhân Tạo Nam Nike Phantom Gx Ii Academy Tf', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 2, 30);
INSERT INTO `products` VALUES (16, 'Giày đá bóng Mizuno Morelia II Pro AG', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 4, 2, 30);
INSERT INTO `products` VALUES (17, 'Giày đá bóng Mizuno Morelia II Pro AG', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 4, 2, 20);
INSERT INTO `products` VALUES (18, 'Giày đá bóng Mizuno Alpha II Pro FG Red Ruby Pack', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 4, 2, 20);
INSERT INTO `products` VALUES (19, 'Giày đá bóng Mizuno Morelia Neo Sala Beta Made in Japan TF Platinum Silver', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 4, 2, 20);
INSERT INTO `products` VALUES (20, 'Giày đá bóng Mizuno Morelia Sala Elite AS TF Frontier Pack', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 4, 2, 20);
INSERT INTO `products` VALUES (21, 'Giày Bóng Rổ Nam Nike Jordan One Take 5 Pf', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 20);
INSERT INTO `products` VALUES (22, 'Giày Bóng Rổ Nam Nike Ja 1 Ep', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 20);
INSERT INTO `products` VALUES (23, 'Giày Bóng Rổ Nam Nike Giannis Immortality 4 Ep', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 20);
INSERT INTO `products` VALUES (24, 'Giày Bóng Rổ Nam Nike Lebron Witness Viii Ep', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 20);
INSERT INTO `products` VALUES (25, 'Giày Bóng Rổ Nam Nike Giannis Immortality 4 Ep', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 30);
INSERT INTO `products` VALUES (26, 'Giày Bóng Rổ Nam Nike Jordan Luka 3 Pf', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 10);
INSERT INTO `products` VALUES (27, 'Giày Bóng Rổ Nam Nike Air Zoom G.T. Cut Academy Ep', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 10);
INSERT INTO `products` VALUES (28, 'Giày Bóng Rổ Nam Nike Jordan One Take 5 Pf', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 10);
INSERT INTO `products` VALUES (29, 'Giày Bóng Rổ Nam Nike Lebron Witness Viii Ep', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 10);
INSERT INTO `products` VALUES (30, 'Giày Bóng Rổ Nam Nike Jordan Luka 2 Pf', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 3, 10);
INSERT INTO `products` VALUES (31, 'Giày Bóng Rổ Nam Under Armour Curry 4 Retro', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (32, 'Giày Bóng Rổ Nam Under Armour Curry 4 Retro', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (33, 'Giày Bóng Rổ Unisex Under Armour Curry 11 Champion Mindset', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (34, 'Giày Bóng Rổ Unisex Under Armour Curry 12 Sn', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (35, 'Giày Bóng Rổ Unisex Under Armour Lockdown 7 Mid Top', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (36, 'Giày Bóng Rổ Unisex Under Armour Curry 12 Strn', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (37, 'Giày Bóng Rổ Unisex Under Armour Lockdown 7 Low Top', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (38, 'Giày Bóng Rổ Unisex Under Armour Lockdown 7 Low Top', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (39, 'Giày Bóng Rổ Unisex Under Armour Curry 12 Pisces', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (40, 'Giày Bóng Rổ Unisex Under Armour Curry Fox 1 Bnd', 2889000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 3, 10);
INSERT INTO `products` VALUES (41, 'Giày Chạy Bộ Nam Adidas Duramo Sl2 - Xám', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 4, 10);
INSERT INTO `products` VALUES (42, 'Giày Chạy Bộ Nam Adidas Supernova Rise 2', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 4, 30);
INSERT INTO `products` VALUES (43, 'Giày Chạy Bộ Nam Adidas Adizero Evo Sl - Xám', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 4, 30);
INSERT INTO `products` VALUES (44, 'Giày Chạy Bộ Nam Adidas Adizero Boston 13', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 4, 30);
INSERT INTO `products` VALUES (45, 'Giày Chạy Bộ Nam Adidas Duramo Sl2', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 4, 30);
INSERT INTO `products` VALUES (46, 'Giày Chạy Bộ Nam Asics Hyper Speed 5', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 4, 30);
INSERT INTO `products` VALUES (47, 'Giày Chạy Bộ Nam Asics Gel-Excite 11', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 4, 30);
INSERT INTO `products` VALUES (48, 'Giày Chạy Bộ Nam Asics Gel-Cumulus 27', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 4, 30);
INSERT INTO `products` VALUES (49, 'Giày Chạy Bộ Nam Asics Noosa Tri 16', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 4, 30);
INSERT INTO `products` VALUES (50, 'Giày Chạy Bộ Nam Asics Gel-Cumulus 27 Atc', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 4, 30);
INSERT INTO `products` VALUES (51, 'Giày Thể Thao Nam Nike Metcon 9', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 5, 30);
INSERT INTO `products` VALUES (52, 'Giày Tập Luyện Nam Nike Motiva', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 5, 30);
INSERT INTO `products` VALUES (53, 'Giày Luyện Tập Nam Nike Reax 8', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 5, 30);
INSERT INTO `products` VALUES (54, 'Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 5, 30);
INSERT INTO `products` VALUES (55, 'Giày Luyện Tập Nam Nike Legend Essential 3 Next Nature', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 1, 5, 30);
INSERT INTO `products` VALUES (56, 'Giày Luyện Tập Nam Under Armour Tribase Reign 5', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 5, 30);
INSERT INTO `products` VALUES (57, 'Giày Tập Luyện Nam Under Armour Flow Dynamic Intelliknit \'Black Hydro Teal\'', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 5, 30);
INSERT INTO `products` VALUES (58, 'Giày Luyện Tập Nam Under Armour Project Rock 6', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 5, 30);
INSERT INTO `products` VALUES (59, 'Giày Tập Luyện Nam Under Armour Tribase Reign 6', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 5, 50);
INSERT INTO `products` VALUES (60, 'Giày Luyện Tập Nam Under Armour Project Rock Bsr 4', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 9, 5, 50);
INSERT INTO `products` VALUES (61, 'Giày Sneakers Nam Adidas Lightblaze', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (62, 'Giày Sneaker Nam Adidas Vl Court 3.0', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (63, 'Giày Sneaker Nam Adidas Vl Court 3.0', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (64, 'Giày Sneaker Nam Adidas Crazychaos 2000', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (65, 'Giày Sneaker Nam Adidas Bara Decode', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (66, 'Giày Sneaker Nam Adidas Vl Court 3.0', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (67, 'Giày Sneaker Nam Adidas Grand Court 2.0', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (68, 'Giày Sneaker Nam Adidas Lightblaze', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (69, 'Giày Sneaker Nam Adidas Barreda Decode', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (70, 'Giày Sneaker Nam Adidas Run 70S 2.0', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 7, 50);
INSERT INTO `products` VALUES (71, 'Giày Sneaker Nam Asics Japan S', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 7, 50);
INSERT INTO `products` VALUES (72, 'Giày Sneaker Nam Asics Japan S', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 7, 30);
INSERT INTO `products` VALUES (73, 'Giày Sneaker Nam Asics Gel-1130', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 7, 30);
INSERT INTO `products` VALUES (74, 'Giày Sneaker Nam Asics Gel-1130', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 7, 30);
INSERT INTO `products` VALUES (75, 'Giày Thời Trang Unisex Converse Chuck 70 Vintage Canvas', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 5, 7, 30);
INSERT INTO `products` VALUES (76, 'Giày Sneakers Nữ Adidas Grand Court Lo', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 30);
INSERT INTO `products` VALUES (77, 'Giày Sneakers Nữ Adidas Grand Court Lo', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (78, 'Giày Sneakers Nữ Adidas Lightblaze', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (79, 'Giày Sneaker Nữ Adidas Bara Decode', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (80, 'Giày Sneaker Nữ Adidas Grand Court Cloudfoam Lifestyle Court Comfort', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (81, 'Giày Sneaker Nữ Adidas Vl Court 3.0', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (82, 'Giày Sneaker Nữ Adidas Crazychaos 2000', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (83, 'Giày Sneaker Nữ Adidas Crazychaos 2000', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (84, 'Giày Sneaker Nữ Adidas Crazychaos 2000', 2579000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (85, 'Giày Sneaker Nữ Adidas Vl Court Bold', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (86, 'Giày Sneaker Nữ Adidas Lightblaze', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (87, 'Giày Sneaker Nữ Adidas Barreda Decode', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (88, 'Giày Sneaker Nữ Adidas Vl Court 3.0', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (89, 'Giày Sneaker Nữ Adidas Grand Court Cloudfoam Lifestyle Court Comfort', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (90, 'Giày Thể Thao Nữ Adidas Ultraboost 1.0', 2719000.00, 'Bạn đã sẵn sàng nâng tầm cuộc chơi? Với [Tên Giày], mỗi bước chạy, mỗi pha chạm bóng của bạn sẽ trở nên sắc bén và hiệu quả hơn bao giờ hết. Được thiết kế cho những cầu thủ không ngừng tìm kiếm sự hoàn hảo, đây không chỉ là một đôi giày, mà là lời khẳng định đẳng cấp trên sân cỏ.', 2, 8, 0);
INSERT INTO `products` VALUES (91, 'Giày Sneaker Cổ Thấp Năng Động', 850000.00, 'Thiết kế tối giản và hiện đại, phù hợp cho mọi hoạt động hàng ngày. Chất liệu vải canvas bền bỉ và thoáng mát.', 1, 2, 0);

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id_review` int(11) NOT NULL AUTO_INCREMENT,
  `rating` tinyint(4) NULL DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_product` int(11) NULL DEFAULT NULL,
  `id_user` int(11) NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_review`) USING BTREE,
  INDEX `id_product`(`id_product`) USING BTREE,
  INDEX `id_user`(`id_user`) USING BTREE,
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_role`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'ADMIN');
INSERT INTO `roles` VALUES (2, 'USER');

-- ----------------------------
-- Table structure for shipping
-- ----------------------------
DROP TABLE IF EXISTS `shipping`;
CREATE TABLE `shipping`  (
  `id_shipping` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tracking_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shipping_cost` decimal(10, 2) NULL DEFAULT NULL,
  `status` enum('PENDING','SHIPPING','DELIVERED','FAILED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `estimated_delivery` date NULL DEFAULT NULL,
  `delivered_date` date NULL DEFAULT NULL,
  `id_order` int(11) NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_shipping`) USING BTREE,
  UNIQUE INDEX `id_order`(`id_order`) USING BTREE,
  CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipping
-- ----------------------------

-- ----------------------------
-- Table structure for shipping_methods
-- ----------------------------
DROP TABLE IF EXISTS `shipping_methods`;
CREATE TABLE `shipping_methods`  (
  `id_shipping_method` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cost` decimal(10, 2) NOT NULL,
  `min_order_amount` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_shipping_method`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipping_methods
-- ----------------------------
INSERT INTO `shipping_methods` VALUES (1, 'Giao hàng tiêu chuẩn', 100000.00, 3000000.00);
INSERT INTO `shipping_methods` VALUES (2, 'Giao hàng nhanh', 200000.00, NULL);
INSERT INTO `shipping_methods` VALUES (3, 'Miễn phí vận chuyển', 0.00, 1000000.00);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1,
  `id_role` int(11) NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  INDEX `id_role`(`id_role`) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Nguyễn Văn Test', 'test@gmail.com', '0123456789', '$2a$10$UNvLb7Ygvs8CyZKPDvoDZuryX.UdgAVf0x1mIgHPa8Pv0/tTIzj6S', 1, 2, '2025-09-03 15:26:36', '2025-09-03 15:42:41');
INSERT INTO `users` VALUES (2, 'Nguyen Van A', 'test@example.com', '0987654333', '$2a$10$t6pCvZJru7xikHhMgEnxEuEALgRw/CcGQ8VhU4aYBX7Xg9OiF0h9i', 1, 2, '2025-09-05 00:49:31', '2025-09-30 11:59:23');
INSERT INTO `users` VALUES (3, 'Ho Thi B', 'test123@gmail.com', NULL, '$2a$10$AxzTaYhj5CxWFeJr.EbygOE7Q5QyEUfDIvGDr5fdKkJaJ79MdCQn.', 1, 2, '2025-09-05 01:09:54', '2025-09-08 13:36:13');
INSERT INTO `users` VALUES (4, 'Trần Thanh Bình', 'tranbinh040224@gmail.com', NULL, '$2a$10$oOyHBg0aps/s3nmyf3eKLO.lq98dDPCC6zI6nhbVtLPVCRJXgLzKi', 1, 2, '2025-09-05 20:33:59', '2025-09-05 20:33:59');
INSERT INTO `users` VALUES (7, 'Bình Trần Thanh', '22130027@st.hcmuaf.edu.vn', NULL, NULL, 1, 2, '2025-09-08 15:13:42', '2025-09-08 15:13:42');
INSERT INTO `users` VALUES (8, 'Admin', 'admin@gmail.com', '0987654321', '$2a$10$./nizMPeoTlJKfZ4TxXpQe0bqSYC2ZJIVlVRiMwOEI6zSPavgf3.y', 1, 1, '2025-10-10 21:36:22', '2025-10-10 21:38:06');

SET FOREIGN_KEY_CHECKS = 1;
