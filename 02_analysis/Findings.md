 # Analysis Findings

## Dialysis Session Tracking System

This document summarizes the main findings identified from the synthetic dialysis dataset.

The analysis focuses on patient characteristics, dialysis activity, clinical monitoring, complications, and operational performance.

> **Note:** The dataset is synthetic and the findings should not be interpreted as clinical findings from a real dialysis population.

---

## 1. Patient Population

The dataset contains **30 active patients** used for the dialysis-session analysis.

The patient population was examined across:

- Gender
- Blood group
- Diagnosis
- Infection status
- Patient status

### Key observations

- The dataset contains patients across multiple diagnostic categories.
- Infection status is used as part of the machine-allocation logic.
- Patient characteristics can be filtered and explored through the Power BI dashboard.

---

## 2. Dialysis Session Activity

A total of **1,200 dialysis sessions** were generated.

Sessions were distributed across three possible outcomes:

- Completed = 1087
- Interrupted = 81
- Missed = 32

### Key observations

- Completed sessions represent the largest share of treatment activity.
- Interrupted sessions represent a smaller proportion of treatments.
- Missed sessions represent the smallest category.
- Session activity can be examined over time using the session date.

---

## 3. Treatment Parameters

The dataset includes treatment parameters such as:

- Prescribed treatment duration
- Actual treatment duration
- Blood flow rate
- Dialysate flow rate
- Ultrafiltration goal
- Fluid removed

The generated treatment durations range from approximately **3.5 to 4.5 hours** for prescribed sessions.

### Key observations

- Completed sessions generally retain the prescribed treatment duration.
- Interrupted sessions have shorter actual treatment durations.
- Missed sessions have no treatment duration.
- Fluid removal is generally lower for interrupted sessions than completed sessions.


## 4. Clinical Monitoring

Vital signs were generated for sessions that were not missed.

The analysis includes:

- Pre-dialysis systolic blood pressure
- Post-dialysis systolic blood pressure
- Pre-dialysis diastolic blood pressure
- Post-dialysis diastolic blood pressure
- Pre-dialysis pulse
- Post-dialysis pulse
- Pre-dialysis weight
- Post-dialysis weight

### Key observations

- The dataset generally shows lower post-dialysis blood pressure compared with pre-dialysis measurements.
- Post-dialysis weight is lower than pre-dialysis weight because fluid removal is incorporated into the generated records.
- Pulse values show relatively small changes between pre- and post-dialysis measurements.

These patterns are characteristics of the synthetic data-generation logic and should not be interpreted as clinical conclusions.

---

## 5. Complications

Complications were generated for a subset of dialysis sessions.

The dataset includes:

- Muscle Cramps
- Hypotension
- Nausea
- Access Clotting
- Chest Pain
- Blood Leak Alarm

Complications were assigned different severity levels:

- Mild
- Moderate
- Severe

### Key observations

- Complications occur more frequently in interrupted sessions because the synthetic generation logic assigns a higher probability of complications to interrupted treatments.
- Completed sessions have a lower probability of receiving a complication.
- Missed sessions do not receive complications.

The distribution of complication types and severity can be explored in the Complications page of the Power BI dashboard.

---

## 6. Machine Operations

Dialysis machines were organized according to infection-control loops.

The dataset contains operational machines across four loop categories.
 
Sessions were assigned to machines according to the patient's infection status and the corresponding machine loop.

### Key observations

- Machine workload varies according to the number of sessions assigned to each machine.
- Machines can therefore be compared based on session volume.
- Infection-control loop distribution provides an operational view of available dialysis capacity.
- Machine-level session counts can be used as a simple indicator of workload.

---

## 7. Staff Activity

Dialysis sessions were assigned to active dialysis nurses.

Staff activity can be examined through:

- Total sessions handled
- Session status
- Staff workload

### Key observations

- Session volume differs between staff members because assignments were generated randomly.
- Staff workload can be compared using total assigned sessions.
- Session outcomes can also be examined at staff level.

These values represent synthetic assignments rather than actual staff performance.

---

## 8. Data Quality

Several validation checks were performed during the project.

These included:

- Checking the number of generated records.
- Verifying primary and foreign-key relationships.
- Checking session relationships with patients, machines, and staff.
- Checking vital-log relationships with sessions.
- Checking complication relationships with sessions.
- Validating the relationship between fluid removed and weight change.
- Reviewing generated SQL records before loading them into MySQL.
- Verifying the Power BI model and relationships.

The generated dataset was successfully loaded into MySQL and connected to Power BI.

---

## 9. Dashboard Findings

The Power BI dashboard provides interactive views of the dataset across six areas:

1. Overview
2. Patients
3. Sessions
4. Clinical Monitoring
5. Complications
6. Operations

The dashboard allows users to filter and compare the data rather than relying only on static summary values.

This makes it possible to examine the same dataset from different perspectives while keeping patient, treatment, clinical, complication, and operational analysis separate.

---

## 10. Limitations

The dataset is synthetic and was created for analytical and portfolio purposes.

The main limitations are:

- Patient information is not real.
- Clinical measurements are generated rather than observed.
- Complications are generated according to predefined probabilities.
- Staff assignments are synthetic.
- Machine allocation is based on simplified infection-control rules.
- The system does not represent a production clinical information system.

Therefore, the findings demonstrate the analytical workflow rather than real-world clinical performance.

---

## 11. Conclusion

This project demonstrates an end-to-end workflow for transforming structured dialysis-unit data into an analytical reporting system.

The project combines:

**MySQL → Python → Data Validation → Power BI → DAX → Interactive Reporting**
 