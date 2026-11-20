<?php

header('Content-Type: application/json');

require_once __DIR__ . '/db.php';

try {
    $products = getDatabaseConnection()->query(
        'SELECT id, sku, name, category, quantity, unit_price, reorder_level, supplier
         FROM products ORDER BY id'
    )->fetchAll();

    foreach ($products as &$product) {
        $product['id'] = (int) $product['id'];
        $product['quantity'] = (int) $product['quantity'];
        $product['unit_price'] = (float) $product['unit_price'];
        $product['reorder_level'] = (int) $product['reorder_level'];
    }
    unset($product);

    echo json_encode($products);
} catch (PDOException $exception) {
    error_log($exception->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Unable to load products from the inventory database.']);
}
?>