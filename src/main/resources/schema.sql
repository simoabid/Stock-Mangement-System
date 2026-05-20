-- =============================================
-- Pharmacy Stock Management System - Schema
-- =============================================

DROP TABLE IF EXISTS stock_exits;
DROP TABLE IF EXISTS stock_entries;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS users;

-- Users (Staff)
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  fullname VARCHAR(150),
  email VARCHAR(100) UNIQUE,
  role VARCHAR(20) NOT NULL DEFAULT 'TECHNICIAN',
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories
CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  description VARCHAR(255)
);

-- Suppliers
CREATE TABLE suppliers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  contact_person VARCHAR(150),
  phone VARCHAR(30),
  email VARCHAR(100),
  address TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  generic_name VARCHAR(255),
  category_id INT,
  form VARCHAR(50),
  dosage VARCHAR(50),
  barcode VARCHAR(50) UNIQUE,
  unit VARCHAR(30) NOT NULL DEFAULT 'Box',
  shelf_location VARCHAR(100),
  requires_prescription BOOLEAN DEFAULT FALSE,
  description TEXT,
  image_path VARCHAR(255),
  min_stock_level INT DEFAULT 10,
  current_stock INT DEFAULT 0 CHECK (current_stock >= 0),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Stock Entries (incoming shipments)
CREATE TABLE stock_entries (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  supplier_id INT,
  quantity INT NOT NULL,
  purchase_price DECIMAL(10,2),
  selling_price DECIMAL(10,2),
  batch_number VARCHAR(100),
  expiry_date DATE,
  entry_date DATE NOT NULL,
  user_id INT NOT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE SET NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Stock Exits (sales, disposals, etc.)
CREATE TABLE stock_exits (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  exit_type VARCHAR(30) NOT NULL DEFAULT 'SALE',
  exit_date DATE NOT NULL,
  user_id INT NOT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- =============================================
-- Seed Data
-- =============================================

-- Users (password = 'password' for all)
INSERT INTO users (username, password_hash, fullname, email, role) VALUES
('admin', '$2a$10$.xizo65mX9wAU88BsXemsuuyrZ/DERfHDfyytz/5FvSbHK57Ne3M2', 'System Administrator', 'admin@pharmacy.com', 'ADMIN'),
('pharmacist', '$2a$10$.xizo65mX9wAU88BsXemsuuyrZ/DERfHDfyytz/5FvSbHK57Ne3M2', 'Ahmed Pharmacist', 'pharmacist@pharmacy.com', 'PHARMACIST'),
('technician', '$2a$10$.xizo65mX9wAU88BsXemsuuyrZ/DERfHDfyytz/5FvSbHK57Ne3M2', 'Sara Technician', 'tech@pharmacy.com', 'TECHNICIAN');

-- Categories
INSERT INTO categories (name, description) VALUES
('Medicine', 'Pharmaceutical drugs and medications'),
('Medical Device', 'Equipment for diagnosis and monitoring'),
('Medical Supply', 'Consumable medical supplies'),
('Cosmetic', 'Parapharmacy, skincare, and beauty products'),
('Other', 'Miscellaneous items');

-- Suppliers
INSERT INTO suppliers (name, contact_person, phone, email, address) VALUES
('PharmaDist SA', 'Karim Benali', '+212 522 123456', 'contact@pharmadist.ma', '123 Avenue Hassan II, Casablanca'),
('MedSupply International', 'Sophie Martin', '+33 1 4567 8901', 'orders@medsupply.eu', '45 Rue de la Sante, Paris'),
('HealthCare Logistics', 'Omar Tazi', '+212 537 654321', 'info@hclogistics.ma', '78 Boulevard Mohammed V, Rabat');

-- Products
INSERT INTO products (name, generic_name, category_id, form, dosage, barcode, unit, shelf_location, requires_prescription, description, min_stock_level, current_stock) VALUES
('Doliprane 1000mg', 'Paracetamol', 1, 'Tablet', '1000mg', '3400935183804', 'Box', 'A1-S1', FALSE, 'Pain reliever and fever reducer', 20, 150),
('Amoxicilline 500mg', 'Amoxicillin', 1, 'Capsule', '500mg', '3400935183811', 'Box', 'A1-S2', TRUE, 'Antibiotic for bacterial infections', 15, 80),
('Ventoline 100mcg', 'Salbutamol', 1, 'Inhaler', '100mcg', '3400935183828', 'Piece', 'A2-S1', TRUE, 'Bronchodilator for asthma', 10, 45),
('Voltarene Gel 1%', 'Diclofenac', 1, 'Gel', '1%', '3400935183835', 'Tube', 'A2-S2', FALSE, 'Anti-inflammatory topical gel', 12, 60),
('Insuline Lantus', 'Insulin Glargine', 1, 'Injection', '100U/ml', '3400935183842', 'Box', 'B1-S1 (Fridge)', TRUE, 'Long-acting insulin. Keep refrigerated.', 5, 20),
('Omeprazole 20mg', 'Omeprazole', 1, 'Capsule', '20mg', '3400935183859', 'Box', 'A1-S3', FALSE, 'Proton pump inhibitor for acid reflux', 15, 95),
('Augmentin 1g', 'Amox/Clavulanic Acid', 1, 'Tablet', '1g', '3400935183866', 'Box', 'A1-S2', TRUE, 'Broad-spectrum antibiotic', 10, 55),
('Levothyrox 50mcg', 'Levothyroxine', 1, 'Tablet', '50mcg', '3400935183873', 'Box', 'A3-S1', TRUE, 'Thyroid hormone replacement', 10, 40),
('Blood Pressure Monitor', NULL, 2, NULL, NULL, '4015672104567', 'Piece', 'C1-S1', FALSE, 'Digital automatic blood pressure monitor', 3, 12),
('Digital Thermometer', NULL, 2, NULL, NULL, '4015672104574', 'Piece', 'C1-S2', FALSE, 'Fast-read digital thermometer', 5, 25),
('Surgical Mask (Box 50)', NULL, 3, NULL, NULL, '6111234567001', 'Box', 'D1-S1', FALSE, 'Disposable 3-ply surgical masks, box of 50', 20, 200),
('Latex Gloves (Box 100)', NULL, 3, NULL, NULL, '6111234567018', 'Box', 'D1-S2', FALSE, 'Powder-free latex examination gloves', 15, 120),
('Sterile Bandage 10cm', NULL, 3, NULL, NULL, '6111234567025', 'Piece', 'D2-S1', FALSE, 'Sterile gauze bandage roll 10cm x 4m', 30, 180),
('Syringes 5ml (Box 100)', NULL, 3, NULL, NULL, '6111234567032', 'Box', 'D2-S2', FALSE, 'Disposable syringes 5ml with needle', 10, 50),
('Sunscreen SPF50', NULL, 4, 'Cream', 'SPF50', '3600523354108', 'Tube', 'E1-S1', FALSE, 'High protection sunscreen', 8, 35),
('Vitamin D3 1000IU', NULL, 4, 'Capsule', '1000IU', '3600523354115', 'Box', 'E1-S2', FALSE, 'Vitamin D3 dietary supplement', 10, 70),
('Baby Shampoo 250ml', NULL, 4, 'Liquid', '250ml', '3600523354122', 'Bottle', 'E2-S1', FALSE, 'Gentle baby shampoo', 8, 40),
('Hand Sanitizer 500ml', NULL, 5, 'Gel', '500ml', '6111234567049', 'Bottle', 'D3-S1', FALSE, 'Antibacterial hand sanitizer gel', 15, 90),
('Saline Solution 0.9%', NULL, 3, 'Solution', '0.9%', '6111234567056', 'Box', 'D3-S2', FALSE, 'Sterile normal saline for wound cleaning', 10, 65),
('Ibuprofen 400mg', 'Ibuprofen', 1, 'Tablet', '400mg', '3400935183880', 'Box', 'A1-S4', FALSE, 'Anti-inflammatory and pain reliever', 20, 110);

-- Stock Entries (sample receiving history)
INSERT INTO stock_entries (product_id, supplier_id, quantity, purchase_price, selling_price, batch_number, expiry_date, entry_date, user_id, notes) VALUES
(1, 1, 100, 2.50, 4.50, 'BT-2025-001', '2027-06-15', '2025-12-01', 1, 'Regular monthly order'),
(1, 1, 50, 2.50, 4.50, 'BT-2025-002', '2027-09-20', '2026-03-15', 1, NULL),
(2, 1, 80, 5.00, 8.50, 'BT-2025-010', '2027-03-10', '2025-11-20', 2, NULL),
(3, 2, 45, 15.00, 22.00, 'BT-2025-020', '2027-12-01', '2026-01-10', 2, 'New supplier shipment'),
(5, 2, 20, 45.00, 65.00, 'BT-2025-030', '2026-08-15', '2025-10-05', 1, 'Refrigerated storage required'),
(9, 3, 12, 35.00, 55.00, 'BT-2025-040', '2028-01-01', '2026-02-15', 1, NULL),
(11, 3, 200, 1.20, 2.50, 'BT-2025-050', '2027-06-01', '2026-04-01', 2, 'Bulk order'),
(14, 3, 50, 3.50, 6.00, 'BT-2025-060', '2027-11-30', '2026-04-10', 2, NULL);

-- Stock Exits (sample dispensing history)
INSERT INTO stock_exits (product_id, quantity, exit_type, exit_date, user_id, notes) VALUES
(1, 5, 'SALE', '2026-05-01', 2, 'Walk-in customer'),
(1, 3, 'SALE', '2026-05-05', 2, NULL),
(2, 2, 'SALE', '2026-05-03', 2, 'Prescription #RX-2026-0501'),
(5, 1, 'SALE', '2026-05-04', 1, 'Prescription #RX-2026-0502'),
(11, 10, 'INTERNAL_USE', '2026-05-02', 1, 'For pharmacy staff use'),
(3, 1, 'EXPIRED_DISPOSAL', '2026-05-06', 1, 'Expired batch BT-2024-015'),
(14, 2, 'SALE', '2026-05-07', 2, NULL);
