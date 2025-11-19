--Practice Questions:
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
select p.patient_id,p.name,p.service,st.staff_id,st.staff_name
from patients as p
left join staff as st
on p.service = st.service
left join staff_schedule as ss
on st.staff_id = ss.staff_id;

-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
select sw.* ,st.staff_id,st.staff_name
from services_weekly as sw
left join staff as st
on sw.service = st.service
left join staff_schedule as ss
on st.staff_id = ss.staff_id;

-- 3. Create a multi-table report showing patient admissions with staff information.
select sw.patients_admitted,st.*
from services_weekly as sw
left join staff as st
on sw.service = st.service;

-- Daily Challenge:
-- Question: Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.
select 
	sw.service,
	sum(sw.patients_admitted) as total_patients,
    sum(sw.patients_refused) as patients_refused,
    avg(sw.patient_satisfaction) as pattient_satisfaction,
    count(ss.staff_id) as staff_assigned_to_service,
    count(distinct case when ss.present=1 then ss.staff_id end) as staff_persent_that_week
from services_weekly as sw
left join staff_schedule as ss
on sw.service = ss.service 
where sw.week=20
group by sw.service
order by total_patients desc;

