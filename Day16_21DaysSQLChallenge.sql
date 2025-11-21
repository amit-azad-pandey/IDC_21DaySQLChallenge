-- Practice Questions:
-- 1. Find patients who are in services with above-average staff count.
SELECT p.patient_id, p.name AS patient_name, p.service FROM patients p
WHERE p.service IN (
    SELECT service FROM (
        SELECT service, COUNT(staff_id) AS staff_count
        FROM staff
        GROUP BY service
    ) s WHERE staff_count > (
        SELECT AVG(staff_per_service) FROM (
            SELECT COUNT(staff_id) AS staff_per_service FROM staff GROUP BY service
        ) a
    )
)

-- 2. List staff who work in services that had any week with patient satisfaction below 70.
SELECT s.staff_id, s.staff_name, s.service FROM staff s WHERE s.service IN (
    SELECT DISTINCT service FROM services_weekly WHERE patient_satisfaction < 70
);

-- 3. Show patients from services where total admitted patients exceed 1000.
SELECT p.patient_id, p.name AS patient_name, p.service FROM patients p WHERE p.service IN (
    SELECT service FROM services_weekly GROUP BY service HAVING SUM(patients_admitted) > 1000
);


-- Daily Challenge:
-- Question: Find all patients who were admitted to services that had at least one week where patients were refused AND the average patient satisfaction for that service was below the overall hospital average satisfaction. Show patient_id, name, service, and their personal satisfaction score.
SELECT p.patient_id, p.name AS patient_name, p.service, p.satisfaction FROM patients p
WHERE p.service IN (
    SELECT service
    FROM services_weekly
    WHERE patients_refused > 0
)
AND p.service IN (
    SELECT service FROM services_weekly GROUP BY service
    HAVING AVG(patient_satisfaction) <
           (SELECT AVG(patient_satisfaction) FROM services_weekly)
);