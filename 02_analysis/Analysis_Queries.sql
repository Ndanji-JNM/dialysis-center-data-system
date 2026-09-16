-- Dialysis Session Tracking System
-- Analytical SQL Queries
 
-- Purpose:
-- Explore patient demographics, dialysis activity, clinical monitoring, complications, and operations.
------------------------------------------------------

-- Database: dialysis_tracker
-- Data: Synthetic
-- ==========================================================

USE dialysis_tracker;

 
-- 1. PATIENT ANALYSIS
 

-- Total number of patients
SELECT
COUNT(*) AS total_patients
FROM patients;

-- Patients by gender
SELECT
gender,
COUNT(*) AS patient_count
FROM patients
GROUP BY gender
ORDER BY patient_count DESC;

-- Patients by blood group
SELECT
blood_group,
COUNT(*) AS patient_count
FROM patients
GROUP BY blood_group
ORDER BY patient_count DESC;

-- Patients by infection status
SELECT
infection_status,
COUNT(*) AS patient_count
FROM patients
GROUP BY infection_status
ORDER BY patient_count DESC;

-- Patients by diagnosis
SELECT
diagnosis,
COUNT(*) AS patient_count
FROM patients
GROUP BY diagnosis
ORDER BY patient_count DESC;

-- Active vs inactive patients
SELECT
status,
COUNT(*) AS patient_count
FROM patients
GROUP BY status
ORDER BY patient_count DESC;

 
-- 2. SESSION ANALYSIS

-- Total dialysis sessions
SELECT
COUNT(*) AS total_sessions
FROM sessions;

-- Sessions by status
SELECT
session_status,
COUNT(*) AS session_count
FROM sessions
GROUP BY session_status
ORDER BY session_count DESC;

-- Session status as a percentage
SELECT
session_status,
COUNT(*) AS session_count,
ROUND(
COUNT(*) * 100.0 / (SELECT COUNT(*) FROM sessions),
2
) AS percentage
FROM sessions
GROUP BY session_status
ORDER BY session_count DESC;

-- Sessions by year
SELECT
YEAR(session_date) AS session_year,
COUNT(*) AS session_count
FROM sessions
GROUP BY YEAR(session_date)
ORDER BY session_year;

-- Sessions by month
SELECT
YEAR(session_date) AS session_year,
MONTH(session_date) AS session_month,
COUNT(*) AS session_count
FROM sessions
GROUP BY
YEAR(session_date),
MONTH(session_date)
ORDER BY
session_year,
session_month;

-- Sessions by patient
SELECT
patient_id,
COUNT(*) AS session_count
FROM sessions
GROUP BY patient_id
ORDER BY session_count DESC;

-- Average prescribed dialysis duration
SELECT
ROUND(AVG(prescribed_duration_hours), 2)
AS avg_prescribed_duration_hours
FROM sessions;

-- Average actual dialysis duration
SELECT
ROUND(AVG(actual_duration_hours), 2)
AS avg_actual_duration_hours
FROM sessions;

-- Average ultrafiltration goal
SELECT
ROUND(AVG(uf_goal_ml), 0) AS avg_uf_goal_ml
FROM sessions;

-- Average fluid removed
SELECT
ROUND(AVG(fluid_removed_ml), 0)
AS avg_fluid_removed_ml
FROM sessions;

 
-- 3. SESSION PERFORMANCE

-- Completion rate
SELECT
ROUND(
SUM(
CASE
WHEN session_status = 'Completed'
THEN 1
ELSE 0
END
) * 100.0 / COUNT(*),
2
) AS completion_rate
FROM sessions;

-- Interrupted session rate
SELECT
ROUND(
SUM(
CASE
WHEN session_status = 'Interrupted'
THEN 1
ELSE 0
END
) * 100.0 / COUNT(*),
2
) AS interruption_rate
FROM sessions;

-- Missed session rate
SELECT
ROUND(
SUM(
CASE
WHEN session_status = 'Missed'
THEN 1
ELSE 0
END
) * 100.0 / COUNT(*),
2
) AS missed_session_rate
FROM sessions;
 
-- 4. CLINICAL MONITORING

-- Average pre- and post-dialysis blood pressure
SELECT
ROUND(AVG(pre_systolic_bp), 1)
AS avg_pre_systolic,
ROUND(AVG(post_systolic_bp), 1)
AS avg_post_systolic,
ROUND(AVG(pre_diastolic_bp), 1)
AS avg_pre_diastolic,
ROUND(AVG(post_diastolic_bp), 1)
AS avg_post_diastolic
FROM vital_logs;

-- Average pre- and post-dialysis pulse
SELECT
ROUND(AVG(pre_pulse), 1)
AS avg_pre_pulse,
ROUND(AVG(post_pulse), 1)
AS avg_post_pulse
FROM vital_logs;

-- Average pre- and post-dialysis weight
SELECT
ROUND(AVG(pre_weight), 1)
AS avg_pre_weight,
ROUND(AVG(post_weight), 1)
AS avg_post_weight
FROM vital_logs;

-- Average weight reduction
SELECT
ROUND(
AVG(pre_weight - post_weight),
2
) AS avg_weight_reduction_kg
FROM vital_logs;

-- 5. COMPLICATION ANALYSIS

-- Total complications
SELECT
COUNT(*) AS total_complications
FROM session_complications;

-- Complications by type
SELECT
complication_type,
COUNT(*) AS complication_count
FROM session_complications
GROUP BY complication_type
ORDER BY complication_count DESC;

-- Complications by severity
SELECT
severity,
COUNT(*) AS complication_count
FROM session_complications
GROUP BY severity
ORDER BY complication_count DESC;

-- Complication percentage by severity
SELECT
severity,
COUNT(*) AS complication_count,
ROUND(
COUNT(*) * 100.0 /
(SELECT COUNT(*) FROM session_complications),
2
) AS percentage
FROM session_complications
GROUP BY severity
ORDER BY complication_count DESC;

-- Complications by intervention
SELECT
intervention,
COUNT(*) AS occurrence_count
FROM session_complications
GROUP BY intervention
ORDER BY occurrence_count DESC;

-- 6. MACHINE / OPERATIONS ANALYSIS

-- Total operational machines
SELECT
COUNT(*) AS operational_machines
FROM dialysis_machines
WHERE status = 'Operational';

-- Sessions by machine
SELECT
machine_id,
COUNT(*) AS session_count
FROM sessions
GROUP BY machine_id
ORDER BY session_count DESC;

-- Sessions by machine and status
SELECT
machine_id,
session_status,
COUNT(*) AS session_count
FROM sessions
GROUP BY
machine_id,
session_status
ORDER BY
machine_id,
session_count DESC;

-- Machine utilization based on session count
SELECT
m.machine_id,
m.loop_number,
COUNT(s.session_id) AS session_count
FROM dialysis_machines m
LEFT JOIN sessions s
ON m.machine_id = s.machine_id
GROUP BY
m.machine_id,
m.loop_number
ORDER BY session_count DESC;
 
-- 7. INFECTION CONTROL LOOP ANALYSIS

-- Machines by infection-control loop
SELECT
loop_number,
COUNT(*) AS machine_count
FROM dialysis_machines
GROUP BY loop_number
ORDER BY loop_number;

-- Sessions by machine loop
SELECT
m.loop_number,
COUNT(s.session_id) AS session_count
FROM dialysis_machines m
LEFT JOIN sessions s
ON m.machine_id = s.machine_id
GROUP BY m.loop_number
ORDER BY m.loop_number;
 
-- 8. STAFF ANALYSIS

-- Total active dialysis nurses
SELECT
COUNT(*) AS active_dialysis_nurses
FROM staff s
JOIN staff_roles r
ON s.role_id = r.role_id
WHERE r.role_name = 'Dialysis Nurse'
AND s.status = 'Active';

-- Sessions handled by staff
SELECT
s.staff_id,
CONCAT(
s.first_name,
' ',
s.last_name
) AS staff_name,
COUNT(se.session_id) AS session_count
FROM staff s
JOIN sessions se
ON s.staff_id = se.staff_id
GROUP BY
s.staff_id,
staff_name
ORDER BY session_count DESC;

-- Session outcomes by staff
SELECT
s.staff_id,
CONCAT(
s.first_name,
' ',
s.last_name
) AS staff_name,
se.session_status,
COUNT(*) AS session_count
FROM staff s
JOIN sessions se
ON s.staff_id = se.staff_id
GROUP BY
s.staff_id,
staff_name,
se.session_status
ORDER BY
staff_name,
session_count DESC;
 
-- 9. PATIENT + SESSION ANALYSIS

-- Sessions by patient with patient information
SELECT
p.patient_id,
CONCAT(
p.first_name,
' ',
p.last_name
) AS patient_name,
p.gender,
p.diagnosis,
p.infection_status,
COUNT(s.session_id) AS session_count
FROM patients p
LEFT JOIN sessions s
ON p.patient_id = s.patient_id
GROUP BY
p.patient_id,
patient_name,
p.gender,
p.diagnosis,
p.infection_status
ORDER BY session_count DESC;
 
-- 10. SESSION + COMPLICATION ANALYSIS

-- Sessions with complications
SELECT
COUNT(DISTINCT session_id)
AS sessions_with_complications
FROM session_complications;

-- Complication rate among all sessions
SELECT
ROUND(
COUNT(DISTINCT sc.session_id) * 100.0
/ COUNT(DISTINCT s.session_id),
2
) AS complication_rate
FROM sessions s
LEFT JOIN session_complications sc
ON s.session_id = sc.session_id;

-- Complications by session status
SELECT
s.session_status,
COUNT(sc.session_id) AS complication_count
FROM sessions s
JOIN session_complications sc
ON s.session_id = sc.session_id
GROUP BY s.session_status
ORDER BY complication_count DESC;
 
-- 11. DATA QUALITY CHECKS

-- Sessions without a patient
SELECT
COUNT(*) AS sessions_without_patient
FROM sessions s
LEFT JOIN patients p
ON s.patient_id = p.patient_id
WHERE p.patient_id IS NULL;

-- Sessions without a machine
SELECT
COUNT(*) AS sessions_without_machine
FROM sessions s
LEFT JOIN dialysis_machines m
ON s.machine_id = m.machine_id
WHERE m.machine_id IS NULL;

-- Sessions without assigned staff
SELECT
COUNT(*) AS sessions_without_staff
FROM sessions s
LEFT JOIN staff st
ON s.staff_id = st.staff_id
WHERE st.staff_id IS NULL;

-- Vital logs without a corresponding session
SELECT
COUNT(*) AS orphaned_vital_logs
FROM vital_logs v
LEFT JOIN sessions s
ON v.session_id = s.session_id
WHERE s.session_id IS NULL;

-- Complications without a corresponding session
SELECT
COUNT(*) AS orphaned_complications
FROM session_complications sc
LEFT JOIN sessions s
ON sc.session_id = s.session_id
WHERE s.session_id IS NULL;

-- END OF ANALYSIS QUERIES
 
