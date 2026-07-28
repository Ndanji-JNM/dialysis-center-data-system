 
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