-- Practice Questions
-- 1. Display the first 5 patients from the patients table.
SELECT TOP 5 * FROM patients

-- 2. Show patients 11-20 using OFFSET.
SELECT *
FROM Patients
ORDER BY patient_id
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

-- 3. Get the 10 most recent patient admissions based on arrival_date.
SELECT TOP 10 * FROM patients ORDER BY arrival_date DESC

-- Daily Challenge:
-- Question: Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, name, service, and satisfaction. Display only these 5 records.

SELECT patient_id, name, service, satisfaction
FROM Patients
ORDER BY satisfaction DESC
OFFSET 2 ROWS
FETCH NEXT 5 ROWS ONLY;
