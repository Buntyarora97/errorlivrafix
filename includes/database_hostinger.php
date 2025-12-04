<?php
/**
 * Hostinger MySQL Database Configuration
 * Developed by Digitaldots (digitaldots.in)
 * 
 * INSTRUCTIONS:
 * 1. Hostinger par deploy karne ke liye, is file ko 
 *    includes/database.php ke naam se save karein (purani file replace karein)
 * 2. Database credentials neeche set hain
 */

class Database {
    private static $instance = null;
    private $pdo;
    
    // MySQL Configuration for Hostinger
    private $host = 'localhost';
    private $dbname = 'u872449974_livvra';
    private $username = 'u872449974_livvra';
    private $password = 'Livvra@97296';

    private function __construct() {
        try {
            $dsn = "mysql:host={$this->host};dbname={$this->dbname};charset=utf8mb4";
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ];
            
            $this->pdo = new PDO($dsn, $this->username, $this->password, $options);
            
        } catch (PDOException $e) {
            die("Database connection failed: " . $e->getMessage());
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
