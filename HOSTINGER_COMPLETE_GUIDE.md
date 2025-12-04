# LIVVRA - Hostinger Deployment Complete Guide
## Developed by Digitaldots (digitaldots.in)

---

## STEP 1: Database Setup

### 1.1 Database Already Created
Aapka database:
- **Database Name:** u848520183_Livvra
- **Username:** u848520183_Livvra
- **Password:** Livvra@97296

### 1.2 phpMyAdmin mein SQL Run karein

1. Hostinger hPanel mein login karein
2. **Databases** > **phpMyAdmin** par click karein
3. Left side mein **u848520183_Livvra** database select karein
4. **SQL** tab par click karein
5. `hostinger_setup.sql` file ka content paste karein
6. **Go** button par click karein

---

## STEP 2: Files Upload Structure

### IMPORTANT: File Structure

Hostinger ke **public_html** folder mein ye structure hona chahiye:

```
public_html/
├── .htaccess           (from public/.htaccess)
├── index.php           (from public/index.php)
├── products.php        (from public/products.php)
├── product-detail.php  (from public/product-detail.php)
├── cart.php            (from public/cart.php)
├── checkout.php        (from public/checkout.php)
├── contact.php         (from public/contact.php)
├── about.php           (from public/about.php)
├── payment.php         (from public/payment.php)
├── verify-payment.php  (from public/verify-payment.php)
├── order-success.php   (from public/order-success.php)
│
├── admin/              (pura admin folder)
│   ├── index.php
│   ├── dashboard.php
│   ├── products.php
│   ├── orders.php
│   └── ...
│
├── includes/           (pura includes folder)
│   ├── config.php
│   ├── database.php    ← YE FILE REPLACE KARNI HAI!
│   ├── header.php
│   ├── footer.php
│   └── models/
│
├── assets/             (from public/assets)
│   ├── css/
│   ├── js/
│   └── images/
│
├── ajax/               (from public/ajax)
│   ├── add-to-cart.php
│   ├── update-cart.php
│   └── remove-from-cart.php
│
└── database/           (empty folder banayein)
```

---

## STEP 3: Upload Files

### Option A: File Manager se Upload

1. Hostinger hPanel > **File Manager** open karein
2. **public_html** folder mein jayein
3. Sabhi existing files delete karein (backup le lein)
4. **Upload** button se files upload karein:
   - `public/` folder ki saari files (index.php, products.php, etc.)
   - `admin/` pura folder
   - `includes/` pura folder  
   - `public/assets/` folder ko `assets/` naam se
   - `public/ajax/` folder ko `ajax/` naam se
   - `public/.htaccess` file

### Option B: FTP se Upload

FileZilla ya koi bhi FTP client use karein:
- Host: ftp.livvra.in
- Username: Aapka Hostinger FTP username
- Password: Aapka Hostinger FTP password
- Port: 21

---

## STEP 4: Database.php Replace karein (CRITICAL!)

### Ye Sabse Important Step hai!

1. File Manager mein `public_html/includes/database.php` file kholen
2. **Edit** par click karein
3. **PURANA CODE DELETE KAREIN**
4. Ye naya code paste karein:

```php
<?php
/**
 * MySQL Database Configuration for Hostinger
 * LIVVRA E-Commerce Platform
 * Developed by Digitaldots (digitaldots.in)
 */

class Database {
    private static $instance = null;
    private $pdo;
    
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
```

5. **Save** karein

---

## STEP 5: Permissions Set karein

File Manager mein:
1. `includes/` folder par right-click > **Permissions** > **755**
2. `database/` folder par right-click > **Permissions** > **755**

---

## STEP 6: Test karein

1. Browser mein **https://livvra.in** open karein
2. Admin Panel: **https://livvra.in/admin/**

### Admin Login:
- **Username:** OfficialLivvra
- **Password:** OfficialLivvra@97296

---

## Troubleshooting

### Error 500?
- Check karein database credentials sahi hain
- phpMyAdmin mein check karein tables ban gayi hain

### 403 Forbidden?
- .htaccess file check karein
- File permissions 644 honi chahiye

### Blank Page?
- PHP error check karein:
  1. hPanel > **Advanced** > **PHP Configuration**
  2. display_errors = On karein temporarily

---

## Contact

**Developed by Digitaldots**
Website: https://digitaldots.in

