CREATE DATABASE IF NOT EXISTS lab5_inventory
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE lab5_inventory;

CREATE TABLE migrations (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    migration VARCHAR(255) NOT NULL,
    batch INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE users (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    email_verified_at TIMESTAMP NULL,
    password VARCHAR(255) NOT NULL,
    remember_token VARCHAR(100) NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
) ENGINE=InnoDB;

CREATE TABLE password_reset_tokens (
    email VARCHAR(255) NOT NULL PRIMARY KEY,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL
) ENGINE=InnoDB;

CREATE TABLE sessions (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    payload LONGTEXT NOT NULL,
    last_activity INT NOT NULL,
    INDEX sessions_user_id_index (user_id),
    INDEX sessions_last_activity_index (last_activity)
) ENGINE=InnoDB;

CREATE TABLE cache (
    `key` VARCHAR(255) NOT NULL PRIMARY KEY,
    value MEDIUMTEXT NOT NULL,
    expiration INT NOT NULL,
    INDEX cache_expiration_index (expiration)
) ENGINE=InnoDB;

CREATE TABLE cache_locks (
    `key` VARCHAR(255) NOT NULL PRIMARY KEY,
    owner VARCHAR(255) NOT NULL,
    expiration INT NOT NULL,
    INDEX cache_locks_expiration_index (expiration)
) ENGINE=InnoDB;

CREATE TABLE jobs (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    queue VARCHAR(255) NOT NULL,
    payload LONGTEXT NOT NULL,
    attempts TINYINT UNSIGNED NOT NULL,
    reserved_at INT UNSIGNED NULL,
    available_at INT UNSIGNED NOT NULL,
    created_at INT UNSIGNED NOT NULL,
    INDEX jobs_queue_index (queue)
) ENGINE=InnoDB;

CREATE TABLE job_batches (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    total_jobs INT NOT NULL,
    pending_jobs INT NOT NULL,
    failed_jobs INT NOT NULL,
    failed_job_ids LONGTEXT NOT NULL,
    options MEDIUMTEXT NULL,
    cancelled_at INT NULL,
    created_at INT NOT NULL,
    finished_at INT NULL
) ENGINE=InnoDB;

CREATE TABLE failed_jobs (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(255) NOT NULL UNIQUE,
    connection TEXT NOT NULL,
    queue TEXT NOT NULL,
    payload LONGTEXT NOT NULL,
    exception LONGTEXT NOT NULL,
    failed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
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
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
) ENGINE=InnoDB;

INSERT INTO migrations (id, migration, batch) VALUES
    (1, '0001_01_01_000000_create_users_table', 1),
    (2, '0001_01_01_000001_create_cache_table', 1),
    (3, '0001_01_01_000002_create_jobs_table', 1),
    (4, '2026_09_22_000810_create_products_table', 1);

INSERT INTO products
    (id, name, sku, description, category, quantity, reorder_level, unit_price, supplier, created_at, updated_at)
VALUES
    (1, 'Plywood Sheet 4x8ft', 'LUM-001', NULL, 'Lumber', 45, 15, 28.99, 'National Lumber Co.', NOW(), NOW()),
    (2, 'Treated 2x4 Lumber', 'LUM-002', NULL, 'Lumber', 8, 20, 6.50, 'National Lumber Co.', NOW(), NOW()),
    (3, 'Plywood Sheet 1/2in', 'LUM-003', NULL, 'Lumber', 0, 10, 22.00, 'National Lumber Co.', NOW(), NOW()),
    (4, 'Galvanized Nails 5kg', 'HW-001', NULL, 'Hardware', 60, 20, 12.50, 'FastenPro', NOW(), NOW()),
    (5, 'Hex Bolts Assorted Set', 'HW-002', NULL, 'Hardware', 5, 10, 15.75, 'FastenPro', NOW(), NOW()),
    (6, 'Door Hinges (Pair)', 'HW-003', NULL, 'Hardware', 32, 10, 8.99, 'FastenPro', NOW(), NOW()),
    (7, 'Cordless Drill 18V', 'TL-001', NULL, 'Tools', 10, 5, 89.99, 'ProTools Inc.', NOW(), NOW()),
    (8, 'Claw Hammer 16oz', 'TL-002', NULL, 'Tools', 3, 8, 14.99, 'ProTools Inc.', NOW(), NOW()),
    (9, 'Tape Measure 25ft', 'TL-003', NULL, 'Tools', 25, 10, 9.50, 'ProTools Inc.', NOW(), NOW()),
    (10, 'Electrical Wire 12AWG (100ft)', 'EL-001', NULL, 'Electrical', 18, 10, 45.00, 'CircuitSupply', NOW(), NOW()),
    (11, 'Outlet Switch Plate', 'EL-002', NULL, 'Electrical', 0, 15, 3.25, 'CircuitSupply', NOW(), NOW()),
    (12, 'Circuit Breaker 20A', 'EL-003', NULL, 'Electrical', 14, 8, 12.99, 'CircuitSupply', NOW(), NOW()),
    (13, 'PVC Pipe 1in (10ft)', 'PLB-001', NULL, 'Plumbing', 40, 15, 7.99, 'AquaFlow Supply', NOW(), NOW()),
    (14, 'Pipe Fittings Set', 'PLB-002', NULL, 'Plumbing', 6, 10, 18.50, 'AquaFlow Supply', NOW(), NOW()),
    (15, 'Interior Latex Paint (1 Gallon)', 'PT-001', NULL, 'Paint', 22, 10, 32.99, 'ColorMax Paints', NOW(), NOW());
