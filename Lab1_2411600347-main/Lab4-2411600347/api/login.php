<?php

header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/db.php';

$credentials = json_decode(file_get_contents('php://input'), true);
$username = is_array($credentials) ? trim($credentials['username'] ?? '') : '';
$password = is_array($credentials) ? ($credentials['password'] ?? '') : '';

if ($username === '' || $password === '') {
    http_response_code(422);
    echo json_encode(['error' => 'Enter both username and password.']);
    exit;
}

try {
    $statement = getDatabaseConnection()->prepare(
        'SELECT username, password FROM users WHERE username = :username'
    );
    $statement->execute(['username' => $username]);
    $user = $statement->fetch();
} catch (PDOException $exception) {
    error_log($exception->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Unable to connect to the inventory database.']);
    exit;
}

if (!$user || !password_verify($password, $user['password'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Invalid username or password.']);
    exit;
}

echo json_encode(['username' => $user['username']]);
