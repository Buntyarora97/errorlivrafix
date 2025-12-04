
<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$host = 'localhost';
$dbname = 'u848520183_Livvra';
$username = 'u848520183_Livvra';
$password = 'Livvra@97296';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    echo "✅ Database connection successful!<br>";
    
    $stmt = $pdo->query("SHOW TABLES");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    echo "Tables found: " . count($tables) . "<br>";
    foreach($tables as $table) {
        echo "- " . $table . "<br>";
    }
} catch(PDOException $e) {
    echo "❌ Connection failed: " . $e->getMessage();
}
?>
