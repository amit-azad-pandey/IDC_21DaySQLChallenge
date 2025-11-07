-- Practice Questions:
-- 1. Count the total number of patients in the hospital.
SELECT count(patient_id) as count FROM patients 

-- 2. Calculate the average satisfaction score of all patients.
SELECT AVG(satisfaction) AS AVG_SATISFACTION_SCORE FROM patients 

-- 3. Find the minimum and maximum age of patients.
SELECT MIN(age) AS MIN_AGE, MAX(age) AS MAX_AGE FROM patients

-- Daily Challenge:
-- Question: Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.

SELECT SUM(patients_admitted) AS total_patients_admitted, SUM(patients_refused) AS total_patients_refused, AVG(patient_satisfaction) AS avg_patient_satisfaction FROM services_weekly;
