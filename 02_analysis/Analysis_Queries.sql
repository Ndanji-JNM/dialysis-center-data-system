-- Dialysis Center Analytics
-- Analytical SQL Queries
-- Synthetic dataset

USE dialysis_tracker;


-- 1. PATIENT ANALYSIS

-- Patient population by key characteristics
SELECT
    gender,
    infection_status,
    COUNT(*) AS patient_count
FROM patients
GROUP BY
    gender,
    infection_status
ORDER BY patient_count DESC;


-- Patients by diagnosis
SELECT
    diagnosis,
    COUNT(*) AS patient_count
FROM patients
GROUP BY diagnosis
ORDER BY patient_count DESC;


-- 2. SESSION ANALYSIS

-- Session activity and outcomes
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


-- Sessions by year and month
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


-- 3. SESSION PERFORMANCE

-- Treatment duration and fluid removal
SELECT
    ROUND(AVG(prescribed_duration_hours), 2) AS avg_prescribed_duration_hours,
    ROUND(AVG(actual_duration_hours), 2) AS avg_actual_duration_hours,
    ROUND(AVG(uf_goal_ml), 0) AS avg_uf_goal_ml,
    ROUND(AVG(fluid_removed_ml), 0) AS avg_fluid_removed_ml
FROM sessions;


-- Session completion, interruption and missed rates
SELECT
    ROUND(
        SUM(session_status = 'Completed') * 100.0 / COUNT(*),
        2
    ) AS completion_rate,
    ROUND(
        SUM(session_status = 'Interrupted') * 100.0 / COUNT(*),
        2
    ) AS interruption_rate,
    ROUND(
        SUM(session_status = 'Missed') * 100.0 / COUNT(*),
        2
    ) AS missed_session_rate
FROM sessions;


-- 4. CLINICAL MONITORING

-- Pre- and post-dialysis vital signs
SELECT
    ROUND(AVG(pre_systolic_bp), 1) AS avg_pre_systolic,
    ROUND(AVG(post_systolic_bp), 1) AS avg_post_systolic,
    ROUND(AVG(pre_diastolic_bp), 1) AS avg_pre_diastolic,
    ROUND(AVG(post_diastolic_bp), 1) AS avg_post_diastolic,
    ROUND(AVG(pre_pulse), 1) AS avg_pre_pulse,
    ROUND(AVG(post_pulse), 1) AS avg_post_pulse
FROM vital_logs;


-- Weight change during dialysis
SELECT
    ROUND(AVG(pre_weight), 2) AS avg_pre_weight_kg,
    ROUND(AVG(post_weight), 2) AS avg_post_weight_kg,
    ROUND(AVG(pre_weight - post_weight), 2) AS avg_weight_reduction_kg
FROM vital_logs;


-- 5. COMPLICATION ANALYSIS

-- Complications by type and severity
SELECT
    complication_type,
    severity,
    COUNT(*) AS complication_count
FROM session_complications
GROUP BY
    complication_type,
    severity
ORDER BY complication_count DESC;


-- Sessions affected by complications
SELECT
    COUNT(DISTINCT sc.session_id) AS sessions_with_complications,
    ROUND(
        COUNT(DISTINCT sc.session_id) * 100.0
        / COUNT(DISTINCT s.session_id),
        2
    ) AS complication_rate
FROM sessions s
LEFT JOIN session_complications sc
    ON s.session_id = sc.session_id;


-- 6. MACHINE & OPERATIONS ANALYSIS

-- Machine activity
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


-- Sessions by infection-control loop
SELECT
    m.loop_number,
    COUNT(s.session_id) AS session_count
FROM dialysis_machines m
LEFT JOIN sessions s
    ON m.machine_id = s.machine_id
GROUP BY m.loop_number
ORDER BY m.loop_number;


-- 7. STAFF ANALYSIS

-- Sessions handled by staff
SELECT
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
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
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
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


-- 8. PATIENT + SESSION ANALYSIS

-- Patient dialysis activity
SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
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


-- 9. DATA QUALITY CHECKS

-- Check for orphaned records
SELECT
    'Sessions without patient' AS check_name,
    COUNT(*) AS issue_count
FROM sessions s
LEFT JOIN patients p
    ON s.patient_id = p.patient_id
WHERE p.patient_id IS NULL

UNION ALL

SELECT
    'Sessions without machine',
    COUNT(*)
FROM sessions s
LEFT JOIN dialysis_machines m
    ON s.machine_id = m.machine_id
WHERE m.machine_id IS NULL

UNION ALL

SELECT
    'Sessions without staff',
    COUNT(*)
FROM sessions s
LEFT JOIN staff st
    ON s.staff_id = st.staff_id
WHERE st.staff_id IS NULL

UNION ALL

SELECT
    'Orphaned vital logs',
    COUNT(*)
FROM vital_logs v
LEFT JOIN sessions s
    ON v.session_id = s.session_id
WHERE s.session_id IS NULL

UNION ALL

SELECT
    'Orphaned complications',
    COUNT(*)
FROM session_complications sc
LEFT JOIN sessions s
    ON sc.session_id = s.session_id
WHERE s.session_id IS NULL;


-- END OF ANALYSIS QUERIES
