<?php
/**
 * MySQL Database Configuration for Hostinger
 * LIVVRA E-Commerce Platform
 * Developed by Digitaldots (digitaldots.in)
 * 
 * Ye file Hostinger par upload karne ke baad
 * includes/database.php naam se save karein
 */

class Database {
    private static $instance = null;
    private $pdo;
    
    // MySQL Configuration for Hostinger
    private $host = 'localhost';
    private $dbname = 'u848520183_Livvra';
    private $username = 'u848520183_Livvra';
    private $password = 'Livvra@97296';
    private $charset = 'utf8mb4';

    private function __construct() {
        try {
            $dsn = "mysql:host={$this->host};dbname={$this->dbname};charset={$this->charset}";
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
