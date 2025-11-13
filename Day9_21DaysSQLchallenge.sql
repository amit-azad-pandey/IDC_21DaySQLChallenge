-- Practice questions
-- 1. Extract the year from all patient arrival dates.
SELECT patient_id, YEAR(arrival_date) AS arrival_year
FROM patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT patient_id, name, DATEDIFF(day, arrival_date, departure_date) AS stay
FROM patients;

-- 3. Find all patients who arrived in a specific month.
SELECT MONTH(arrival_date) AS arrived_month, COUNT(*) AS total_patients
FROM patients
GROUP BY MONTH(arrival_date)
ORDER BY arrived_month;

-- Daily Challenge:
-- Question: Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.
SELECT 
    service, 
	count(name) as count_of_patients,
    AVG(DATEDIFF(day, arrival_date, departure_date)) AS avg_interval_of_stay
FROM patients
GROUP BY service
HAVING AVG(DATEDIFF(day, arrival_date, departure_date)) > 7;
