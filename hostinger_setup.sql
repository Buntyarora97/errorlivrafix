-- =====================================================
-- LIVVRA E-Commerce Database Setup for Hostinger
-- Developed by Digitaldots (digitaldots.in)
-- =====================================================
-- 
-- INSTRUCTIONS:
-- 1. Hostinger hPanel mein login karein
-- 2. Databases > phpMyAdmin par click karein
-- 3. Left side mein apna database select karein (u848520183_Livvra)
-- 4. SQL tab par click karein
-- 5. Is puri file ka content paste karein
-- 6. Go button par click karein
--
-- =====================================================

-- Drop existing tables (agar already exist karti hain)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS contact_inquiries;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS settings;
DROP TABLE IF EXISTS admins;

-- =====================================================
-- TABLE: admins
-- =====================================================
CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    role VARCHAR(20) DEFAULT 'admin',
    is_active TINYINT(1) DEFAULT 1,
    last_login_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: categories
-- =====================================================
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    icon_class VARCHAR(50) DEFAULT 'fa-leaf',
    is_active TINYINT(1) DEFAULT 1,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: products
-- =====================================================
CREATE TABLE products (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: customers
-- =====================================================
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20) NOT NULL,
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: orders
-- =====================================================
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100),
    customer_phone VARCHAR(20) NOT NULL,
    shipping_address TEXT NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'pending',
    order_status VARCHAR(20) DEFAULT 'pending',
    subtotal DECIMAL(10,2) NOT NULL,
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    razorpay_order_id VARCHAR(100),
    razorpay_payment_id VARCHAR(100),
    razorpay_signature VARCHAR(255),
    notes TEXT,
    placed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    delivered_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: order_items
-- =====================================================
CREATE TABLE order_items (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: contact_inquiries
-- =====================================================
CREATE TABLE contact_inquiries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    subject VARCHAR(200),
    message TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'new',
    handled_by INT,
    handled_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (handled_by) REFERENCES admins(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLE: settings
-- =====================================================
CREATE TABLE settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- INSERT DEFAULT DATA
-- =====================================================

-- Admin User (Password: OfficialLivvra@97296)
INSERT INTO admins (username, password_hash, email, role) VALUES 
('OfficialLivvra', '$2y$10$8tGvVzJxgVhKpYqR5qFYy.QlZmRD9QGVQ3VmZJQl6ZIcM.VB8iRHy', 'livvraindia@gmail.com', 'super_admin');

-- Categories
INSERT INTO categories (name, slug, description, icon_class, sort_order) VALUES 
('Skin Care', 'skin-care', 'Natural skincare products', 'fa-spa', 1),
('Gym Foods', 'gym-foods', 'Nutrition for fitness', 'fa-dumbbell', 2),
('Men''s Health', 'mens-health', 'Vitality and energy', 'fa-mars', 3),
('Weight Management', 'weight-management', 'Healthy weight loss', 'fa-weight-scale', 4),
('Heart Care', 'heart-care', 'Cardiovascular health', 'fa-heart-pulse', 5),
('Daily Wellness', 'daily-wellness', 'Everyday health', 'fa-leaf', 6),
('Ayurvedic Juices', 'ayurvedic-juices', 'Pure herbal juices', 'fa-glass-water', 7),
('Blood Sugar & Chronic Care', 'blood-sugar', 'Diabetes management', 'fa-droplet', 8);

-- Products
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

-- Settings
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

-- =====================================================
-- SETUP COMPLETE!
-- =====================================================
-- Admin Login:
-- Username: OfficialLivvra
-- Password: OfficialLivvra@97296
-- =====================================================
