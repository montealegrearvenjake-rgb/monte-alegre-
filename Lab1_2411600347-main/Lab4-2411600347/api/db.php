<?php

function getDatabaseConnection(): PDO
{
    $host = getenv('LAB4_DB_HOST') ?: '127.0.0.1';
    $port = getenv('LAB4_DB_PORT') ?: '3307';
    $database = getenv('LAB4_DB_NAME') ?: 'lab4_inventory';
    $username = getenv('LAB4_DB_USER') ?: 'root';
    $password = getenv('LAB4_DB_PASSWORD') ?: '';

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
