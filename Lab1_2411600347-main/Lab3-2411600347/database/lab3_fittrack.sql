CREATE DATABASE IF NOT EXISTS lab3_fittrack
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE lab3_fittrack;

CREATE TABLE users (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(80) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE fitness_stats (
    user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    steps_today INT UNSIGNED NOT NULL DEFAULT 0,
    calories_burned INT UNSIGNED NOT NULL DEFAULT 0,
    workouts_this_week INT UNSIGNED NOT NULL DEFAULT 0,
    avg_heart_rate INT UNSIGNED NOT NULL DEFAULT 0,
    CONSTRAINT fitness_stats_user_id_foreign
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE workout_activities (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    workout_date DATE NOT NULL,
    workout VARCHAR(255) NOT NULL,
    duration_minutes INT UNSIGNED NOT NULL,
    calories INT UNSIGNED NOT NULL,
    status VARCHAR(30) NOT NULL,
    INDEX workout_activities_user_date_index (user_id, workout_date),
    CONSTRAINT workout_activities_user_id_foreign
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO users (id, username, password)
VALUES (1, 'admin', '$2y$12$bQbgeHtbuYtdtp9PsQOMpesrfDSWwdabux..5UIW.uNmQjD1Jjfbq');

INSERT INTO fitness_stats (user_id, steps_today, calories_burned, workouts_this_week, avg_heart_rate)
VALUES (1, 8542, 2150, 4, 118);

INSERT INTO workout_activities (user_id, workout_date, workout, duration_minutes, calories, status)
VALUES
    (1, '2026-08-28', 'Morning Run', 32, 410, 'Completed'),
    (1, '2026-08-27', 'Upper Body Strength', 45, 380, 'Completed'),
    (1, '2026-08-26', 'Yoga and Stretching', 20, 110, 'Completed'),
    (1, '2026-08-25', 'HIIT Cardio', 25, 320, 'Missed');
