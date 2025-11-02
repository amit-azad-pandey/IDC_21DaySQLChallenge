-- Practice questions
-- Retrieve all columns from the patients table.

Select * from patients

--Select only the patient_id, name, and age columns from the patients table.

select patient_id, name, age from patients

--Display the first 10 records from the services_weekly table.

select top 10 * from services_weekly

-- Daily challenge
-- List all unique hospital services available in the hospital.

select distinct(service) from services_weekly