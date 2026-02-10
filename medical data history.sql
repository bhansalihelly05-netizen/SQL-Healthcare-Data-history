use project_medical_data_history;
select * from admissions;
select * from doctors;
select * from patients;
select * from province_names;
-- 1. Show first name, last name, and gender of patients who's gender is 'M'
select first_name, last_name, gender from patients where gender="M";

-- 2. Show first name and last name of patients who does not have allergies
select first_name, last_name, allergies from patients where allergies is NULL;

-- 3. Show first name of patients that start with the letter 'C'
select first_name from patients where first_name like "C%";

-- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name, last_name, weight from patients where weight between 100 and 120 order by weight asc;

-- 5.  Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
select * from patients;
update patients set allergies= "NKA" where allergies is NULL;
select first_name, last_name, ifnull(allergies, "NKA") as allergies from patients;

-- 6. Show first name and last name concatenated into one column to show their full name.
select concat(first_name," ", last_name) as full_name from patients; 

-- 7. Show first name, last name, and the full province name of each patient.
select * from patients;
select * from province_names;
select p.first_name, p.last_name, n.province_name from patients p join province_names n on p.province_id= n.province_id;

-- 8. Show how many patients have a birth_date with 2010 as the birth year.
select* from patients;	
select count(*) as total_patients from patients where year(birth_date) = 2010;


-- 9. Show the first_name, last_name, and height of the patient with the greatest height.
select * from patients;
select first_name, last_name, height from patients order by	height desc limit 1;
select first_name, last_name, height from patients where height = (select max(height) from patients);


-- 10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * from patients;
select patient_id, first_name, last_name, gender, birth_date, city, province_id, allergies, height, weight from patients where patient_id in (1, 45, 534, 879, 1000);
select * from patients where patient_id in (1, 45, 534, 879, 1000);

-- 11. Show the total number of admissions
select * from admissions;
select count(*) as total_no_of_patients from admissions;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select* from admissions;
select patient_id, admission_date as Same_Day_Discharge from admissions where admission_date= discharge_date;

-- 13.  Show the total number of admissions for patient_id 579.
select * from admissions;
select count(*)  from admissions where patient_id= "579";

-- 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select* from patients;
select distinct(city), province_id from patients where province_id= "NS";

-- 15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
select * from patients;
select first_name, last_name, birth_date, height, weight from patients where height>160 and weight>70;

-- 16. Show unique birth years from patients and order them by ascending.
select * from patients;
select distinct year(birth_date) as unique_years from patients order by unique_years asc;

-- 17. Show unique first names from the patients table which only occurs once in the list.
select * from patients;
select first_name from patients group by first_name having count(*)= 1;

-- 18. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long
select patient_id, first_name from patients where first_name like "S%S" and length(first_name)>= 6;

-- 19. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.   Primary diagnosis is stored in the admissions table.
select * from patients;
select * from admissions;
select p.patient_id, p.first_name, p.last_name, a.diagnosis from patients p left join admissions a on p.patient_id= a.patient_id where diagnosis= "Dementia";

-- 20. Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
select first_name from patients order by length(first_name) asc, first_name asc;

-- 21. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select * from patients;
select count(if(gender = 'M',1,Null)) as Total_Male , count(if(gender = 'F',1,Null)) as Total_Female from patients;

-- 22. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select count(if(gender="M",1, NULL)) as total_male, count(if(gender="F",1,NULL)) as total_female from patients;

-- 23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select * from admissions;
select * from patients;
select patient_id, diagnosis , count(*) as admission_counts from admissions group by patient_id, diagnosis having count(*)>1;

-- 24. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
select * from patients;
select city, count(*) as total_patients from patients group by city order by total_patients desc;
select city, count(*) as total_patients from patients group by city order by city asc;

-- 25. Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
select * from patients;
select * from doctors;
select first_name, last_name , "patients" as Role from patients union select first_name, last_name, "doctors" as Role from doctors;

-- 26. Show all allergies ordered by popularity. Remove NULL values from query.
select * from patients;
select allergies, count(*) as popularity from patients where allergies is not NULL group by allergies order by popularity desc;

-- 27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select * from patients;
select first_name, last_name, birth_date as birthday from patients where year(birth_date)>=1970 and year(birth_date)<=1979 order by birthday asc;

-- 28. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order    EX: SMITH,jane
select * from patients;
select concat(upper(last_name),',' ,lower(first_name)) as full_name from patients order by first_name desc;

-- 29. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select * from patients;
select province_id, sum(height) as total_height from patients group by province_id having sum(height) >=7000 ;

-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select * from patients;
select last_name, max(weight)-min(weight) as diff_weight from patients where last_name= "Maroni";

-- 31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select * from admissions;
select day(admission_date) as days_of_month, count(*) as total_admission from admissions group by day(admission_date) order by total_admission desc;


-- 32. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select * from patients;
select max(weight) from patients;
select count(if(weight between 0 and 9, 1, NULL)) as 0_weight_group ,
count(if(weight between 10 and 19, 1, NULL)) as 10_weight_group,
 count(if(weight between 20 and 29, 1, NULL)) as 20_weight_group,
 count(if(weight between 30 and 39,1, NULL)) as 30_weight_group,
 count(if(weight between 40 and 49,1, NULL)) as 40_weight_group,
 count(if(weight between 50 and 59,1, NULL)) as 50_weight_group, 
 count(if(weight between 60 and 69,1, NULL)) as 60_weight_group, 
 count(if(weight between 70 and 79,1, NULL)) as 70_weight_group, 
 count(if(weight between 80 and 89,1, NULL)) as 80_weight_group,
 count(if(weight between 90 and 99,1, NULL)) as 90_weight_group,
 count(if(weight between 100 and 109,1, NULL)) as 100_weight_group,
 count(if(weight between 110 and 119,1, NULL)) as 110_weight_group,
 count(if(weight between 120 and 129,1, NULL)) as 120_weight_group,
 count(if(weight between 130 and 139,1, NULL)) as 130_weight_group, 
 count(if(weight between 140 and 149,1, NULL)) as 140_weight_group
 from patients;
 select case when weight between 0 and 9 then '0_weight_group' when weight between 10 and 19 then '10_weight_group' when weight between 20 and 29 then '20_weight_group' when weight between 30 and 39 then '30_weight_group' when weight between 40 and 49 then '40_weight_group' when weight between 50 and 59 then '50_weight_group' when weight between 60 and 69 then '60_weight_group' when weight between 70 and 79 then '70_weight_group' when weight between 80 and 89 then '80_weight_group' when weight between 90 and 99 then '90_weight_group' when weight between 100 and 109 then '100_weight_group' when weight between 110 and 119 then '110_weight_group' when weight between 120 and 129 then '120_weight_group' when weight between 130 and 139 then '130_weight_group' else '140_weight_group' end as weight_group, count(*) as total_patients from patients group by weight_group order by total_patients desc; 
 
 
 
 -- 33. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.
 select patient_id, weight, height, case when weight / power(height/100.0,2) >= 30 then 1 else 0 end as isObese from patients;
 
 -- 34. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.
select * from patients; 
select* from doctors;
select * from admissions;
select p.patient_id, p.first_name as patient_first_name, p.last_name as patient_last_name, a.diagnosis, d.first_name, d.specialty 
from patients p 
right join admissions a 
on p.patient_id= a.patient_id
left join doctors d 
on a.attending_doctor_id= d.doctor_id
where a.diagnosis= "Epilepsy" and d.first_name= "Lisa";


