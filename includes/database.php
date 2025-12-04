
<?php
/**
 * SQLite Database Configuration for Replit
 * LIVVRA E-Commerce Platform
 * Developed by Digitaldots (digitaldots.in)
 */

class Database {
    private static $instance = null;
    private $pdo;
    
    private function __construct() {
        try {
            $dbPath = __DIR__ . '/../database/livvra.db';
            
            // Create database directory if it doesn't exist
            $dbDir = dirname($dbPath);
            if (!is_dir($dbDir)) {
                mkdir($dbDir, 0755, true);
            }
            
            $dsn = "sqlite:" . $dbPath;
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ];
            
            $this->pdo = new PDO($dsn, null, null, $options);
            
            // Enable foreign keys for SQLite
            $this->pdo->exec('PRAGMA foreign_keys = ON;');
            
        } catch (PDOException $e) {
            error_log("Database connection failed: " . $e->getMessage());
            die("Website temporarily unavailable. Please try again later.");
        }
    }

    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function getConnection() {
        return $this->pdo;
    }
}

function db() {
    return Database::getInstance()->getConnection();
}
