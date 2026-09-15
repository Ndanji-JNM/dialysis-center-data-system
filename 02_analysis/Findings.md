# Analysis Findings

## Dialysis Session Tracking System

This document summarizes observations from the analysis of the synthetic dialysis dataset.

> **Note:** This project uses synthetic data for portfolio and learning purposes. Findings describe patterns within the generated dataset and should not be interpreted as real-world clinical conclusions.

---

## 1. Patient Population

The dataset contains **30 active patients** with varied demographic, diagnostic, and infection-status attributes.

Infection statuses include:

- None
- HIV
- Hepatitis C
- Hepatitis B

These attributes were also used to demonstrate infection-control machine allocation.

---

## 2. Dialysis Session Activity

The dataset contains **1,200 dialysis sessions**:

| Status | Sessions | Percentage |
|---|---:|---:|
| Completed | 1,087 | 90.6% |
| Interrupted | 81 | 6.8% |
| Missed | 32 | 2.7% |

The session analysis provides a view of treatment activity and session outcomes.

> These percentages apply only to the synthetic dataset.

---

## 3. Treatment Parameters

Session records include:

- Prescribed and actual duration
- Blood flow
- Dialysate flow
- UF goal
- Fluid removed

Completed sessions generally contain longer actual treatment durations, while interrupted sessions contain shorter durations. Missed sessions do not contain treatment measurements.

Fluid removal also varies across sessions according to the generated treatment parameters.

---

## 4. Clinical Monitoring

Pre- and post-dialysis measurements were analyzed for:

- Systolic blood pressure
- Diastolic blood pressure
- Pulse
- Weight

The dataset shows changes between pre- and post-treatment measurements, including reductions in weight following fluid removal.

These measurements allow clinical variables to be monitored across individual sessions and patient treatment histories.

> Clinical values are synthetic and should not be interpreted as actual patient outcomes.

---

## 5. Complications

Recorded complications include:

- Muscle Cramps
- Hypotension
- Nausea
- Access Clotting
- Chest Pain
- Blood Leak Alarm

Complications were analyzed by type, severity, intervention, and session status.

Some differences in complication frequency appear between session statuses. However, the synthetic data-generation logic intentionally varies complication probabilities, so these patterns should **not** be interpreted as real clinical associations.

---

## 6. Machine and Staff Operations

The analysis examined:

- Machine operational status
- Sessions per machine
- Infection-control loops
- Staff session assignments
- Session outcomes by staff

This demonstrates how the same dataset can support both clinical and operational analysis.

---

## 7. Data Quality

SQL checks were used to identify:

- Sessions without patients
- Sessions without machines
- Sessions without assigned staff
- Orphaned vital-log records
- Orphaned complication records

Primary and foreign-key relationships were also reviewed to support the integrity of the analytical dataset.

---

## 8. Dashboard Application

The analysis formed the foundation for the Power BI dashboard.

The dashboard presents:

- Overall dialysis activity
- Patient information
- Session performance
- Clinical monitoring
- Machine and operational activity
- Individual patient history through drill-through

The project demonstrates an end-to-end workflow:

**MySQL → SQL Analysis → Data Validation → Power BI → DAX → Interactive Reporting**

---

## Limitations

The dataset is entirely synthetic. Patient information, clinical measurements, complications, staff assignments, and operational records were generated for demonstration purposes.

The project is intended to demonstrate practical **SQL, data modelling, data analysis, DAX, and Power BI skills**, not to function as a production clinical system.