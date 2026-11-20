CREATE DATABASE IF NOT EXISTS lab4_inventory
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE lab4_inventory;

CREATE TABLE users (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(80) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE products (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(255) NOT NULL UNIQUE,
    description TEXT NULL,
    category VARCHAR(255) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 10,
    unit_price DECIMAL(10, 2) NOT NULL,
    supplier VARCHAR(255) NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO users (id, username, password)
VALUES (1, 'admin', '$2y$12$bQbgeHtbuYtdtp9PsQOMpesrfDSWwdabux..5UIW.uNmQjD1Jjfbq');

INSERT INTO products
    (id, sku, name, category, quantity, unit_price, reorder_level, supplier)
VALUES
    (1, 'SKU-1001', 'Adjustable Dumbbell Set', 'Equipment', 12, 89.99, 5, 'IronForge Supply'),
    (2, 'SKU-1002', 'Olympic Barbell', 'Equipment', 4, 149.99, 5, 'IronForge Supply'),
    (3, 'SKU-1003', 'Resistance Bands Set', 'Equipment', 0, 19.99, 15, 'IronForge Supply'),
    (4, 'SKU-2001', 'Whey Protein Powder (Chocolate)', 'Supplements', 60, 34.99, 20, 'PeakNutrition'),
    (5, 'SKU-2002', 'Pre-Workout Formula', 'Supplements', 10, 29.99, 15, 'PeakNutrition'),
    (6, 'SKU-2003', 'BCAA Capsules', 'Supplements', 0, 18.50, 20, 'PeakNutrition'),
    (7, 'SKU-3001', 'Gym Tank Top', 'Apparel', 85, 15.00, 25, 'ActiveWear Co.'),
    (8, 'SKU-3002', 'Compression Leggings', 'Apparel', 18, 32.00, 20, 'ActiveWear Co.'),
    (9, 'SKU-3003', 'Gym Shorts', 'Apparel', 6, 20.00, 15, 'ActiveWear Co.'),
    (10, 'SKU-4001', 'Yoga Mat', 'Accessories', 40, 22.00, 10, 'FlexFit Gear'),
    (11, 'SKU-4002', 'Shaker Bottle', 'Accessories', 5, 8.99, 10, 'FlexFit Gear'),
    (12, 'SKU-4003', 'Weightlifting Gloves', 'Accessories', 30, 14.50, 10, 'FlexFit Gear'),
    (13, 'SKU-5001', 'Foam Roller', 'Recovery', 20, 25.00, 8, 'RecoverPlus'),
    (14, 'SKU-5002', 'Massage Gun', 'Recovery', 2, 99.99, 5, 'RecoverPlus'),
    (15, 'SKU-5003', 'Ice Pack Wrap', 'Recovery', 15, 12.99, 8, 'RecoverPlus');
