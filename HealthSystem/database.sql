CREATE DATABASE IF NOT EXISTS healthsystem;
USE healthsystem;

CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    password VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    role VARCHAR(50),
    password VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS treatments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DOUBLE NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT DEFAULT NULL,
    patient_name VARCHAR(100),
    doctor_name VARCHAR(100),
    treatment_id INT DEFAULT NULL,
    treatment_name VARCHAR(100),
    treatment_fee DOUBLE DEFAULT 0,
    date DATE,
    time TIME,
    status VARCHAR(20) DEFAULT 'Pending',
    bill_amount DOUBLE DEFAULT 0,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE SET NULL
);

INSERT IGNORE INTO treatments (name, description, price) VALUES
('Dental Consultation', 'Initial dental examination and consultation', 1500),
('Teeth Cleaning', 'Professional scaling and polishing', 2500),
('Tooth Filling', 'Composite filling for a damaged tooth', 3500),
('Tooth Extraction', 'Simple tooth extraction procedure', 5000),
('Root Canal Treatment', 'Root canal treatment and restoration', 18000);

-- =============================================
-- SAMPLE DATA - Run this after creating tables
-- =============================================

-- Sample Staff (password: staff123)
INSERT IGNORE INTO staff (name, email, phone, role, password) VALUES
('Saman Kumara', 'saman@health.com', '0711111111', 'Receptionist', 'staff123'),
('Dilani Perera', 'dilani@health.com', '0712222222', 'Nurse', 'staff123');

-- Sample Patient (password: patient123)
INSERT IGNORE INTO patients (name, email, phone, password) VALUES
('Amal Bandara', 'amal@gmail.com', '0751111111', 'patient123');
