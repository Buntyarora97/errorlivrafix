# LIVVRA - Hostinger Deployment Complete Guide

## Aapki Database Details:
- **Database Name:** u872449974_livvra
- **Username:** u872449974_livvra  
- **Password:** Livvra@97296

---

## STEP 1: phpMyAdmin mein Database Setup

### 1.1 phpMyAdmin Open karein
1. Hostinger hPanel mein login karein
2. **Databases** section mein jaayein
3. **phpMyAdmin** button click karein
4. Left side mein `u872449974_livvra` database select karein

### 1.2 SQL Import karein
1. Top menu mein **"SQL"** tab click karein
2. Neeche diye gaye SQL code ko copy karein aur paste karein
3. **"Go"** button click karein

```sql
-- LIVVRA Database Schema for Hostinger MySQL

-- Admin Users Table
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    role ENUM('super_admin', 'admin', 'manager') DEFAULT 'admin',
    is_active TINYINT(1) DEFAULT 1,
    last_login_at DATETIME NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    icon_class VARCHAR(50) DEFAULT 'fa-leaf',
    is_active TINYINT(1) DEFAULT 1,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) UNIQUE NOT NULL,
    sku VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    mrp DECIMAL(10,2),
    short_description TEXT,
    long_description TEXT,
    benefits TEXT,
    image VARCHAR(255),
    stock_qty INT DEFAULT 100,
    is_featured TINYINT(1) DEFAULT 0,
    is_active TINYINT(1) DEFAULT 1,
    rating DECIMAL(2,1) DEFAULT 0,
    reviews_count INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Customers Table
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20) NOT NULL,
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(10),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100),
    customer_phone VARCHAR(20) NOT NULL,
    shipping_address TEXT NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(10),
    payment_method ENUM('cod', 'razorpay') NOT NULL,
    payment_status ENUM('pending', 'paid', 'failed', 'refunded') DEFAULT 'pending',
    order_status ENUM('pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    subtotal DECIMAL(10,2) NOT NULL,
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    razorpay_order_id VARCHAR(100),
    razorpay_payment_id VARCHAR(100),
    razorpay_signature VARCHAR(255),
    notes TEXT,
    placed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    delivered_at DATETIME NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL
);

-- Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT,
    product_name VARCHAR(200) NOT NULL,
    product_image VARCHAR(255),
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    line_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);

-- Contact Inquiries Table
CREATE TABLE IF NOT EXISTS contact_inquiries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    subject VARCHAR(200),
    message TEXT NOT NULL,
    status ENUM('new', 'in_progress', 'resolved', 'closed') DEFAULT 'new',
    handled_by INT NULL,
    handled_at DATETIME NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (handled_by) REFERENCES admins(id) ON DELETE SET NULL
);

-- Site Settings Table
CREATE TABLE IF NOT EXISTS settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default admin user (Password: OfficialLivvra@97296)
INSERT INTO admins (username, password_hash, email, role) VALUES 
('OfficialLivvra', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'livvraindia@gmail.com', 'super_admin');

-- Insert categories
INSERT INTO categories (name, slug, description, icon_class, sort_order) VALUES
('Skin Care', 'skin-care', 'Natural skincare products', 'fa-spa', 1),
('Gym Foods', 'gym-foods', 'Nutrition for fitness', 'fa-dumbbell', 2),
('Men''s Health', 'mens-health', 'Vitality and energy', 'fa-mars', 3),
('Weight Management', 'weight-management', 'Healthy weight loss', 'fa-weight-scale', 4),
('Heart Care', 'heart-care', 'Cardiovascular health', 'fa-heart-pulse', 5),
('Daily Wellness', 'daily-wellness', 'Everyday health', 'fa-leaf', 6),
('Ayurvedic Juices', 'ayurvedic-juices', 'Pure herbal juices', 'fa-glass-water', 7),
('Blood Sugar & Chronic Care', 'blood-sugar', 'Diabetes management', 'fa-droplet', 8);

-- Insert products
INSERT INTO products (category_id, name, slug, sku, price, mrp, short_description, benefits, image, rating, reviews_count, is_featured) VALUES
(3, 'Pure Shilajit Gold', 'pure-shilajit-gold', 'SG001', 1499, 1999, 'Premium Himalayan Shilajit enriched with gold for enhanced energy and vitality. 100% natural and lab tested.', 'Boosts Energy, Enhances Stamina, Improves Immunity, Natural Aphrodisiac', 'shilajit-gold.jpg', 4.8, 256, 1),
(6, 'Ashwagandha Capsules', 'ashwagandha-capsules', 'AC001', 599, 799, 'Organic Ashwagandha root extract capsules for stress relief and improved sleep quality.', 'Reduces Stress, Better Sleep, Muscle Recovery, Mental Clarity', 'ashwagandha.jpg', 4.7, 189, 1),
(1, 'Aloe Vera Gel', 'aloe-vera-gel', 'AV001', 349, 499, 'Pure Aloe Vera gel for skin hydration, acne control, and natural glow.', 'Deep Hydration, Acne Control, Anti-Aging, Sun Protection', 'aloe-vera.jpg', 4.6, 342, 1),
(2, 'Protein Powder Plus', 'protein-powder-plus', 'PP001', 1899, 2499, 'Plant-based protein powder with added vitamins and minerals for muscle building.', 'Muscle Building, Fast Recovery, High Protein, No Artificial Flavors', 'protein-powder.jpg', 4.9, 167, 1),
(4, 'Weight Loss Formula', 'weight-loss-formula', 'WL001', 899, 1299, 'Natural weight management supplement with Garcinia Cambogia and Green Tea extract.', 'Burns Fat, Appetite Control, Boosts Metabolism, Natural Ingredients', 'weight-loss.jpg', 4.5, 298, 1),
(5, 'Heart Care Capsules', 'heart-care-capsules', 'HC001', 799, 1099, 'Ayurvedic formulation for heart health with Arjuna and Omega-3 fatty acids.', 'Healthy Heart, Blood Pressure, Cholesterol Control, Circulation', 'heart-care.jpg', 4.7, 156, 1),
(7, 'Amla Juice', 'amla-juice', 'AJ001', 299, 399, 'Pure Amla juice rich in Vitamin C for immunity and digestive health.', 'Immunity Boost, Digestive Health, Hair Growth, Skin Glow', 'amla-juice.jpg', 4.8, 423, 1),
(8, 'Diabetic Care Plus', 'diabetic-care-plus', 'DC001', 699, 999, 'Herbal supplement for blood sugar management with Karela and Jamun extracts.', 'Blood Sugar Control, Pancreas Health, Natural Formula, Safe Long-term Use', 'diabetic-care.jpg', 4.6, 278, 1),
(6, 'Immunity Booster', 'immunity-booster', 'IB001', 449, 599, 'Powerful immunity booster with Giloy, Tulsi, and Turmeric extracts.', 'Strong Immunity, Fights Infections, Antioxidant Rich, Daily Protection', 'immunity-booster.jpg', 4.9, 512, 1),
(1, 'Hair Growth Oil', 'hair-growth-oil', 'HG001', 399, 549, 'Ayurvedic hair oil with Bhringraj, Amla, and Coconut for healthy hair growth.', 'Hair Growth, Prevents Hairfall, Nourishes Scalp, Reduces Dandruff', 'hair-oil.jpg', 4.7, 367, 1),
(2, 'Energy Drink Mix', 'energy-drink-mix', 'ED001', 549, 749, 'Natural energy drink powder with electrolytes and B-vitamins for workout performance.', 'Instant Energy, Electrolyte Balance, Pre-Workout, No Crash', 'energy-drink.jpg', 4.6, 198, 1),
(6, 'Joint Pain Relief', 'joint-pain-relief', 'JP001', 649, 899, 'Herbal formulation with Boswellia and Turmeric for joint pain and inflammation.', 'Pain Relief, Reduces Inflammation, Joint Mobility, Cartilage Support', 'joint-pain.jpg', 4.8, 234, 1);

-- Insert site settings
INSERT INTO settings (setting_key, setting_value) VALUES
('site_name', 'LIVVRA'),
('site_tagline', 'Live Better Live Strong'),
('site_email', 'livvraindia@gmail.com'),
('site_phone', '+91 9876543210'),
('site_address', 'Dr Tridosha Herbotech Pvt Ltd, Sco no 27, Second Floor, Phase 3, Model Town, Bathinda 151001'),
('currency_symbol', '₹'),
('razorpay_key_id', ''),
('razorpay_key_secret', ''),
('shipping_fee', '0'),
('free_shipping_above', '499');
```

---

## STEP 2: Files Download karein

### Option A: Replit se Download
1. Replit mein is project ko open karein
2. Left side mein **three dots (...)** click karein
3. **"Download as ZIP"** select karein

### Option B: GitHub se Download
1. GitHub repository par jaayein
2. **"Code"** button click karein
3. **"Download ZIP"** select karein

---

## STEP 3: Files Upload karein Hostinger par

### 3.1 File Manager Open karein
1. Hostinger hPanel login karein
2. **Files** > **File Manager** jaayein
3. `public_html` folder kholein

### 3.2 Purani files delete karein (agar ho)
1. `public_html` mein jo bhi files hain, unhe select karein
2. Delete karein (important files ka backup le lein)

### 3.3 ZIP Upload karein
1. **Upload** button click karein
2. Downloaded ZIP file select karein
3. Upload complete hone ka wait karein

### 3.4 ZIP Extract karein
1. Uploaded ZIP file par **right-click** karein
2. **"Extract"** select karein
3. `public_html` folder mein extract karein

### 3.5 File Structure Fix karein

**IMPORTANT:** Ye file structure hona chahiye:

```
public_html/
├── admin/
│   ├── assets/
│   ├── views/
│   ├── dashboard.php
│   ├── index.php
│   └── ...
├── includes/
│   ├── models/
│   ├── config.php
│   ├── database.php    <-- Ye file update karni hai!
│   ├── header.php
│   └── footer.php
├── assets/
│   ├── css/
│   ├── js/
│   └── images/
├── ajax/
├── index.php
├── products.php
├── about.php
├── contact.php
├── cart.php
├── checkout.php
└── ...
```

**Dhyan dein:**
- `public/` folder ki saari files `public_html/` ki root mein move karein
- `includes/`, `admin/` folders ko `public_html/` mein rakhein

---

## STEP 4: Database Configuration Update karein

### 4.1 File Manager mein jaayein
1. `public_html/includes/database.php` file kholein
2. **Edit** button click karein

### 4.2 Poori file replace karein is code se:

```php
<?php
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
```

3. **Save** button click karein

---

## STEP 5: .htaccess File Create karein

### 5.1 New File Create karein
1. `public_html` mein **New File** create karein
2. File name: `.htaccess`

### 5.2 Ye code paste karein:

```apache
# Enable URL Rewriting
RewriteEngine On

# Force HTTPS
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Remove .php extension
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME}\.php -f
RewriteRule ^([^\.]+)$ $1.php [NC,L]

# Protect sensitive files
<FilesMatch "\.(db|sql|ini|log)$">
    Order Allow,Deny
    Deny from all
</FilesMatch>

# Security Headers
<IfModule mod_headers.c>
    Header set X-Content-Type-Options "nosniff"
    Header set X-Frame-Options "SAMEORIGIN"
    Header set X-XSS-Protection "1; mode=block"
</IfModule>

# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/css application/javascript
</IfModule>
```

3. Save karein

---

## STEP 6: PHP Version Check karein

1. hPanel mein **Advanced** > **PHP Configuration** jaayein
2. PHP Version **8.0** ya higher select karein
3. Extensions mein ye enable karein:
   - pdo_mysql
   - json
   - mbstring

---

## STEP 7: SSL Certificate Enable karein

1. hPanel mein **Security** > **SSL** jaayein
2. **Free SSL** enable karein
3. 10-15 minutes wait karein

---

## STEP 8: Test karein

1. Browser mein apna domain kholein: `https://yourdomain.com`
2. Homepage check karein
3. Products page check karein
4. Admin panel test karein: `https://yourdomain.com/admin`

---

## Admin Login Details

- **URL:** https://yourdomain.com/admin
- **Username:** OfficialLivvra
- **Password:** OfficialLivvra@97296

**IMPORTANT:** Pehli baar login karke password change kar lein!

---

## Troubleshooting

### 500 Error
- PHP version 8.0+ check karein
- .htaccess syntax check karein
- File permissions check karein

### Database Error
- phpMyAdmin mein tables check karein
- database.php mein credentials verify karein
- pdo_mysql extension enabled hai check karein

### CSS/Images Not Loading
- File paths correct check karein
- Browser cache clear karein

---

## Kuch Bhi Problem Ho To:

1. Error message ka screenshot lein
2. Browser console check karein (F12 key dabayein)
3. Contact: livvraindia@gmail.com

---

**Congratulations!** Aapki LIVVRA website ab Hostinger par live hai!

*Dr Tridosha Herbotech Pvt Ltd*
