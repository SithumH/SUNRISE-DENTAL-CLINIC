-- ============================================
-- Sunrise Dental Clinic - Database Setup
-- ============================================

CREATE DATABASE IF NOT EXISTS sunrise_dental;
USE sunrise_dental;

-- Users (staff login)
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(30) NOT NULL
);

-- Patients
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    contact_number VARCHAR(20) NOT NULL
);

-- Dentists
CREATE TABLE dentists (
    dentist_id INT PRIMARY KEY AUTO_INCREMENT,
    dentist_name VARCHAR(100) NOT NULL
);

-- Treatments
CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    treatment_name VARCHAR(100) NOT NULL,
    treatment_fee DECIMAL(10,2) NOT NULL
);

-- Appointments
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_number VARCHAR(30) NOT NULL UNIQUE,
    patient_id INT NOT NULL,
    dentist_id INT NOT NULL,
    treatment_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (dentist_id) REFERENCES dentists(dentist_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);

-- Bills
CREATE TABLE bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL UNIQUE,
    treatment_fee DECIMAL(10,2) NOT NULL,
    consultation_fee DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- ============================================
-- Sample Data
-- ============================================

INSERT INTO users (username, password, role) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'ADMIN'),
('receptionist', '$2a$10$c9urZiyMgNkEXFQMBqSIVOBsHoFR9HFqCpX3JdFMFhHqJkFpFpFpO', 'RECEPTIONIST');
-- Passwords: admin=admin123 | receptionist=recep123
-- To regenerate: UserDAO.hashPassword("yourpassword")

INSERT INTO dentists (dentist_name) VALUES
('Dr. Perera'),
('Dr. Silva'),
('Dr. Fernando');

INSERT INTO treatments (treatment_name, treatment_fee) VALUES
('Dental Filling', 5000.00),
('Tooth Extraction', 3500.00),
('Root Canal', 15000.00),
('Teeth Cleaning', 2500.00),
('Dental Crown', 20000.00),
('Teeth Whitening', 8000.00);

INSERT INTO patients (patient_name, address, contact_number) VALUES
('John Silva', 'Colombo 03', '0712345678');

INSERT INTO appointments (appointment_number, patient_id, dentist_id, treatment_id, appointment_date, appointment_time) VALUES
('APT001', 1, 1, 1, '2026-09-10', '10:30:00');

INSERT INTO bills (appointment_id, treatment_fee, consultation_fee, total_amount) VALUES
(1, 5000.00, 2000.00, 7000.00);
