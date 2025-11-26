--Practice Questions:
--1. Calculate running total of patients admitted by week for each service.
SELECT * 
FROM ( SELECT 
		service, week, patient_satisfaction, patients_admitted,
		RANK() OVER(partition by service ORDER BY patient_satisfaction DESC) as patient_satisfaction_rank
	   FROM services_weekly
	) AS weekly_rank
WHERE patient_satisfaction_rank <= 3;

--2. Find the moving average of patient satisfaction over 4-week periods.
select 
    week,
	service,
	patient_satisfaction,
	round(avg(patient_satisfaction)
	over (partition by service order by week rows between 3  preceding and current row ),2)as moving_average
from services_weekly
group by week,service, patient_satisfaction ;

--3. Show cumulative patient refusals by week across all services.
select
    week,
	service,
	patients_refused, 
    sum(patients_refused) over (partition by service order by week)as cumulative
from services_weekly
group by week,service, patients_refused ;


--Daily Challenge:
--Question: Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted (cumulative), 3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions and the service average. Filter for weeks 10-20 only.
with Service_analysis as(
    select 
      week, service, patients_admitted, 
      sum(patients_admitted) over (partition by service order by week) as cumulative_admissions, 
      round(avg(patient_satisfaction) over (partition by service order by week rows between 2 preceding and current row ),2) as moving_avg_satisfaction, 
      round(avg(patients_admitted) over (partition by service),2) as service_avg_admissions
from services_weekly
where week >= 10 and week <= 20
)
select 
      week, 
      service, 
      patients_admitted, 
      cumulative_admissions, 
      moving_avg_satisfaction, 
      patients_admitted - service_avg_admissions as diff_from_avg
from Service_analysis;