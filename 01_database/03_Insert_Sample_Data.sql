 
-- Dialysis Session Tracking System
-- File: 03_Insert_Sample_Data.sql
--
-- Description:
-- Inserts synthetic dialysis data generated for
-- Dialysis Renal Care and Diagnostics Centre (DRCDC),
-- a fictional Zambian renal care facility.
--
-- The dataset represents realistic dialysis operations
-- using fictional patient and staff information.
--
-- No real patient information is used.
 

USE dialysis_tracker;


 
-- STAFF ROLES
-- =====================================================

INSERT INTO staff_roles (role_name)
VALUES
('Dialysis Technician'),
('Dialysis Nurse'),
('Nephrologist'),
('General Medical Doctor'),
('Administrator');


 
-- STAFF INFORMATION
-- =====================================================

INSERT INTO staff
(first_name, last_name, gender, phone, email, role_id, hire_date, status)
VALUES

('Michael','Banda','Male',
'0977000001',
'michael.banda@drcdc.example',
1,
'2022-03-10',
'Active'),

('Peter','Mwansa','Male',
'0977000002',
'peter.mwansa@drcdc.example',
1,
'2023-01-15',
'Active'),

('Ruth','Phiri','Female',
'0977000003',
'ruth.phiri@drcdc.example',
1,
'2021-06-20',
'Active'),


('Mary','Zulu','Female',
'0977000004',
'mary.zulu@drcdc.example',
2,
'2020-02-11',
'Active'),

('Grace','Chanda','Female',
'0977000005',
'grace.chanda@drcdc.example',
2,
'2021-09-18',
'Active'),

('Brian','Tembo','Male',
'0977000006',
'brian.tembo@drcdc.example',
2,
'2023-04-05',
'Active'),


('John','Mumba','Male',
'0977000007',
'dr.john.mumba@drcdc.example',
3,
'2019-05-12',
'Active'),


('Sarah','Kunda','Female',
'0977000008',
'dr.sarah.kunda@drcdc.example',
4,
'2022-07-01',
'Active'),


('Angela','Mulenga','Female',
'0977000009',
'angela.mulenga@drcdc.example',
5,
'2018-01-20',
'Active');
 

-- DIALYSIS MACHINES
-- =====================================================

INSERT INTO dialysis_machines
(machine_code, manufacturer, model, serial_number, loop_number, installation_date, status)
VALUES

('HD001','Fresenius','4008S','FR4008S001',1,'2022-01-15','Operational'),

('HD002','Fresenius','4008S','FR4008S002',1,'2022-01-15','Operational'),

('HD003','B. Braun','Dialog+','BBD001',2,'2023-03-10','Operational'),

('HD004','Gambro','AK 96','GM001',3,'2021-11-05','Maintenance'),

('HD005','Fresenius','5008S','FR5008S001',1,'2024-02-18','Operational'),

('HD006','B. Braun','Dialog+','BBD002',4,'2023-08-12','Operational'),

('HD007','Fresenius','4008S','FR4008S003',3,'2024-06-15','Operational');

-- =====================================================
-- PATIENTS
-- =====================================================

INSERT INTO patients
(
first_name,
last_name,
gender,
date_of_birth,
blood_group,
diagnosis,
infection_status,
phone,
emergency_contact,
address,
registration_date,
status
)
VALUES

('Joseph','Mwamba','Male','1972-04-18','O+','Hypertensive Nephropathy','None','0977111001','0977666001','Lusaka','2024-01-15','Active'),

('Mary','Tembo','Female','1981-09-03','A+','Diabetic Nephropathy','None','0977111002','0977666002','Kitwe','2024-02-10','Active'),

('Patrick','Banda','Male','1965-12-22','B+','Chronic Glomerulonephritis','None','0977111003','0977666003','Ndola','2024-01-28','Active'),

('Ruth','Phiri','Female','1978-07-11','O+','Hypertensive Nephropathy','None','0977111004','0977666004','Kabwe','2024-03-05','Active'),

('Charles','Mulenga','Male','1959-05-16','AB+','Diabetic Nephropathy','None','0977111005','0977666005','Livingstone','2024-02-18','Active'),

('Grace','Zulu','Female','1986-10-02','A-','Lupus Nephritis','None','0977111006','0977666006','Lusaka','2024-01-20','Active'),

('Brian','Chanda','Male','1974-03-09','O-','HIV Associated Kidney Disease','HIV','0977111007','0977666007','Chipata','2024-02-01','Active'),

('Esther','Mumba','Female','1969-11-13','B+','Hypertensive Nephropathy','None','0977111008','0977666008','Kasama','2024-01-25','Active'),

('Andrew','Sakala','Male','1984-08-27','A+','Diabetic Nephropathy','None','0977111009','0977666009','Mongu','2024-03-02','Active'),

('Agnes','Mwila','Female','1976-02-15','O+','Polycystic Kidney Disease','None','0977111010','0977666010','Solwezi','2024-02-12','Active'),

('Kelvin','Lungu','Male','1988-01-21','B-','Hypertensive Nephropathy','None','0977111011','0977666011','Lusaka','2024-03-11','Active'),

('Beatrice','Simukoko','Female','1971-06-30','A+','Diabetic Nephropathy','None','0977111012','0977666012','Mazabuka','2024-01-30','Active'),

('David','Mwape','Male','1967-09-12','O+','Chronic Kidney Disease','Hepatitis C','0977111013','0977666013','Chingola','2024-02-06','Active'),

('Linda','Kunda','Female','1983-05-24','AB+','Hypertensive Nephropathy','None','0977111014','0977666014','Lusaka','2024-03-08','Active'),

('Samuel','Chisanga','Male','1970-12-18','B+','Diabetic Nephropathy','None','0977111015','0977666015','Mansa','2024-01-18','Active'),

('Mildred','Mbewe','Female','1977-04-11','O+','Chronic Glomerulonephritis','None','0977111016','0977666016','Kapiri Mposhi','2024-02-15','Active'),

('Jacob','Musonda','Male','1982-07-26','A+','Hypertensive Nephropathy','None','0977111017','0977666017','Lusaka','2024-03-01','Active'),

('Naomi','Mutale','Female','1968-03-17','O-','Diabetic Nephropathy','HIV','0977111018','0977666018','Mpika','2024-02-20','Active'),

('Emmanuel','Phiri','Male','1975-08-09','B+','Obstructive Nephropathy','None','0977111019','0977666019','Kafue','2024-01-22','Active'),

('Catherine','Mwanza','Female','1980-10-29','A+','Hypertensive Nephropathy','None','0977111020','0977666020','Lusaka','2024-02-25','Active'),

('Isaac','Chomba','Male','1973-01-06','O+','Diabetic Nephropathy','None','0977111021','0977666021','Serenje','2024-03-04','Active'),

('Patricia','Sichone','Female','1987-05-08','B+','Lupus Nephritis','Hepatitis B','0977111022','0977666022','Kabwe','2024-02-28','Active'),

('Martin','Hamusonde','Male','1966-11-19','A+','Hypertensive Nephropathy','None','0977111023','0977666023','Monze','2024-01-12','Active'),

('Susan','Bwalya','Female','1974-09-14','O+','Diabetic Nephropathy','None','0977111024','0977666024','Lusaka','2024-03-12','Active'),

('Henry','Zimba','Male','1979-02-23','AB-','Chronic Kidney Disease','None','0977111025','0977666025','Ndola','2024-02-14','Active'),

('Mercy','Kalaba','Female','1985-12-05','A+','Hypertensive Nephropathy','None','0977111026','0977666026','Kasama','2024-01-29','Active'),

('Paul','Kabwe','Male','1972-06-16','B+','Diabetic Nephropathy','HIV','0977111027','0977666027','Lusaka','2024-02-16','Active'),

('Joyce','Mwansa','Female','1981-03-01','O+','HIV Associated Kidney Disease','HIV','0977111028','0977666028','Chipata','2024-03-06','Active'),

('Edward','Soko','Male','1964-10-25','A+','Hypertensive Nephropathy','Hepatitis C','0977111029','0977666029','Kitwe','2024-01-10','Active'),

('Faith','Banda','Female','1978-08-18','B+','Diabetic Nephropathy','None','0977111030','0977666030','Lusaka','2024-02-08','Active');