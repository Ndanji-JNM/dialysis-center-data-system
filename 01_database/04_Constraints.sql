
-- Dialysis Session Tracking System
-- File: 04_Constraints.sql


USE dialysis_tracker;

ALTER TABLE staff
ADD CONSTRAINT fk_staff_role
FOREIGN KEY (role_id)
REFERENCES staff_roles(role_id);

ALTER TABLE sessions
ADD CONSTRAINT fk_sessions_patient
FOREIGN KEY (patient_id)
REFERENCES patients(patient_id);

ALTER TABLE sessions
ADD CONSTRAINT fk_sessions_machine
FOREIGN KEY (machine_id)
REFERENCES dialysis_machines(machine_id);

ALTER TABLE sessions
ADD CONSTRAINT fk_sessions_staff
FOREIGN KEY (staff_id)
REFERENCES staff(staff_id);

ALTER TABLE vital_logs
ADD CONSTRAINT fk_vitals_session
FOREIGN KEY (session_id)
REFERENCES sessions(session_id);

ALTER TABLE session_complications
ADD CONSTRAINT fk_complications_session
FOREIGN KEY (session_id)
REFERENCES sessions(session_id);