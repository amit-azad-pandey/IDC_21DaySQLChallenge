-- Practice Questions:
-- 1. Count the number of patients by each service.
select service, count(name) as total_patients from patients group by service

-- 2. Calculate the average age of patients grouped by service.
select service, AVG(age) as avg_age from patients group by service order by avg_age

-- 3. Find the total number of staff members per role.
select role, COUNT(staff_id) as total from staff group by role order by total desc

--Daily Challenge:
-- Question: For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate (percentage of requests that were admitted). Order by admission rate descending.

SELECT service, SUM(patients_admitted) AS total_admitted, SUM(patients_refused) AS total_refused, CAST(SUM(patients_admitted) * 100.0 / SUM(patients_request) AS DECIMAL(5,2)) AS admission_rate_percent
FROM services_weekly
GROUP BY service
ORDER BY admission_rate_percent DESC;
