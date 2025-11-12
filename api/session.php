<?php
// Robust session configuration: honor HTTPS, work on HTTP during local/dev hosting
$isHttps = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off')
    || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https');

session_start([
    'cookie_secure' => $isHttps,
    'cookie_httponly' => true,
    'use_strict_mode' => true,
    'cookie_samesite' => 'Lax',
    'cookie_path' => '/',
]);

if (!isset($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

header('Content-Type: application/json');
echo json_encode(['csrf_token' => $_SESSION['csrf_token']]);
?>
