 
-- Dialysis Session Tracking System
-- File: 02_Create_Tables.sql
-- Author: Joseph Ndanji Muleba
-- Description:
-- Creates all database tables for the Dialysis Session
-- Tracking System.
 

USE dialysis_tracker;
CREATE TABLE staff_roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female') NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    role_id INT NOT NULL,
    hire_date DATE,
    status ENUM('Active','Inactive') DEFAULT 'Active'
);

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female') NOT NULL,
    date_of_birth DATE,
    blood_group VARCHAR(5),
    diagnosis VARCHAR(100),
    infection_status ENUM('None','HIV','Hepatitis B','Hepatitis C') DEFAULT 'None',
    phone VARCHAR(20),
    emergency_contact VARCHAR(20),
    address VARCHAR(150),
    registration_date DATE,
    status ENUM('Active','Inactive','Transferred','Deceased') DEFAULT 'Active'
);

CREATE TABLE dialysis_machines (
    machine_id INT AUTO_INCREMENT PRIMARY KEY,
    machine_code VARCHAR(20) NOT NULL UNIQUE,
    manufacturer VARCHAR(50),
    model VARCHAR(50),
    serial_number VARCHAR(50) UNIQUE,
    loop_number INT,
    installation_date DATE,
    status ENUM('Operational','Maintenance','Out of Service')
        DEFAULT 'Operational'
);

CREATE TABLE sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    machine_id INT NOT NULL,
    staff_id INT NOT NULL,
    session_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    prescribed_duration_hours DECIMAL(3,1),
    actual_duration_hours DECIMAL(3,1),
    blood_flow_rate INT,
    dialysate_flow_rate INT,
    uf_goal_ml INT,
    fluid_removed_ml INT,
    session_status ENUM(
        'Completed',
        'Interrupted',
        'Missed'
    ) DEFAULT 'Completed',

    notes TEXT
);

CREATE TABLE vital_logs (
    vital_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    pre_systolic_bp INT,
    pre_diastolic_bp INT,
    pre_pulse INT,
    pre_weight DECIMAL(5,2),
    post_systolic_bp INT,
    post_diastolic_bp INT,
    post_pulse INT,
    post_weight DECIMAL(5,2)
);

CREATE TABLE session_complications (
    complication_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL,
    complication_type VARCHAR(100),
    severity ENUM(
        'Mild',
        'Moderate',
        'Severe'
    ),
    intervention TEXT,
    resolved BOOLEAN DEFAULT TRUE
);