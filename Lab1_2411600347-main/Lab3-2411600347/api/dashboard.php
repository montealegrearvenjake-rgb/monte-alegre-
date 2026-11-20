<?php

header('Content-Type: application/json; charset=utf-8');
session_start();

if (empty($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Please log in to view the dashboard.']);
    exit;
}

require_once __DIR__ . '/db.php';

try {
    $database = getDatabaseConnection();

    $statsStatement = $database->prepare(
        'SELECT steps_today, calories_burned, workouts_this_week, avg_heart_rate
         FROM fitness_stats WHERE user_id = :user_id'
    );
    $statsStatement->execute(['user_id' => $_SESSION['user_id']]);
    $stats = $statsStatement->fetch();

    $activityStatement = $database->prepare(
        'SELECT workout_date, workout, duration_minutes, calories, status
         FROM workout_activities
         WHERE user_id = :user_id
         ORDER BY workout_date DESC, id DESC'
    );
    $activityStatement->execute(['user_id' => $_SESSION['user_id']]);

    if (!$stats) {
        http_response_code(404);
        echo json_encode(['error' => 'Dashboard data was not found.']);
        exit;
    }

    echo json_encode([
        'username' => $_SESSION['username'],
        'stats' => $stats,
        'activities' => $activityStatement->fetchAll(),
    ]);
} catch (PDOException $exception) {
    error_log($exception->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Unable to load FitTrack data from the database.']);
}
