<?php

function getDatabaseConnection(): PDO
{
    $host = getenv('LAB3_DB_HOST') ?: '127.0.0.1';
    $port = getenv('LAB3_DB_PORT') ?: '3307';
    $database = getenv('LAB3_DB_NAME') ?: 'lab3_fittrack';
    $username = getenv('LAB3_DB_USER') ?: 'root';
    $password = getenv('LAB3_DB_PASSWORD') ?: '';

    return new PDO(
        "mysql:host={$host};port={$port};dbname={$database};charset=utf8mb4",
        $username,
        $password,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
}
