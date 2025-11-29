-- Investigation Steps
-- Identify where and when the crime happened
SELECT 
	room AS crime_location, 
	entry_time AS crime_time
FROM keycard_logs
WHERE room = 'CEO Office'
ORDER BY entry_time desc;

-- Analyze who accessed critical areas at the time
SELECT 
	e.employee_id, e.name,k.room, k.entry_time, k.exit_time
FROM employees AS e JOIN keycard_logs AS k ON e.employee_id = k.employee_id
WHERE room = 'CEO Office' AND entry_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00';

-- Cross-check alibis with actual logs
SELECT 
	e.employee_id, 
	e.name, 
	a.claimed_location, 
	k.room AS actual_room, 
	a.claim_time, 
	k.entry_time, 
	k.exit_time, 
	CASE 
		WHEN k.room IS NULL THEN 'no log available for claim_time' 
		WHEN k.room = a.claimed_location THEN 'Match'
		ELSE 'Mismatch'
	END AS status
FROM employees e
JOIN alibis a ON e.employee_id = a.employee_id
LEFT JOIN keycard_logs k ON e.employee_id = k.employee_id
AND a.claim_time BETWEEN k.entry_time AND k.exit_time 
ORDER BY employee_id; 

-- Investigate suspicious calls made around the time
SELECT
    c.call_id,
    e1.name AS caller_name,
    e2.name AS receiver_name,
    c.call_time,
    c.duration_sec
FROM
    calls AS c
JOIN
    employees AS e1
    ON c.caller_id = e1.employee_id
JOIN
    employees AS e2
    ON c.receiver_id = e2.employee_id
WHERE
    call_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00';


-- Match evidence with movements and claims


SELECT
    ev.evidence_id,
    ev.room AS evidence_room,
    ev.description,
    CAST(ev.found_time AS TIME) AS found_time,
    e.name,
    k.room AS actual_location,
    CAST(k.entry_time AS TIME) AS entry_time,
    a.claimed_location,
    CAST(a.claim_time AS TIME) AS claim_time,
    CASE
        WHEN a.claimed_location IS NULL THEN 'alibi not available'
        WHEN a.claimed_location = k.room THEN 'Alibi match'
        ELSE 'Alibi Mismatch'
    END AS Alibi_Status
FROM
    evidence ev
JOIN
    keycard_logs k ON ev.room = k.room
JOIN
    employees e ON k.employee_id = e.employee_id
LEFT JOIN
    alibis a ON e.employee_id = a.employee_id;


--Combine all findings to identify the killer
SELECT
    emp.name AS suspect,
    k.room AS actual_location,
    CAST(k.entry_time AS TIME) AS entry_time,
    CAST(k.exit_time AS TIME) AS exit_time,
    a.claimed_location,
    CAST(a.claim_time AS TIME) AS claim_time,
    evi.room AS evidence_room,
    evi.description AS evidence_found,
    CAST(evi.found_time AS TIME) AS found_time,
    CASE
        WHEN a.claimed_location IS NULL THEN 'No alibi'
        WHEN a.claimed_location = k.room THEN 'Alibi matches'
        ELSE 'Alibi mismatch'
    END AS alibi_status
FROM employees emp
JOIN keycard_logs k
    ON emp.employee_id = k.employee_id
JOIN evidence evi
    ON evi.room = k.room
    AND CAST(evi.found_time AS DATE) = CAST(k.entry_time AS DATE)
LEFT JOIN alibis a
    ON a.employee_id = emp.employee_id
    AND CAST(a.claim_time AS DATE) = CAST(k.entry_time AS DATE)
WHERE evi.room = 'CEO Office'
ORDER BY evi.found_time, emp.name;




