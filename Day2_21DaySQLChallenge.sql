-- Practice questions
-- 1. Find all patients who are older than 60 years.
select * from patients where age > 60

-- 2. Retrieve all staff members who work in the 'Emergency' service.
select * from staff where service = 'emergency'

-- 3. List all weeks where more than 100 patients requested admission in any service.
SELECT week, service, patients_request
FROM services_weekly
WHERE patients_request > 100
ORDER BY week, service;

-- Daily challenge
-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.
select patient_id, name, age, satisfaction from patients 
where service = 'surgery' 
AND satisfaction < 70 
Order by satisfaction asc 
