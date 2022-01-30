--Queries for R statistic
---------------------------------------------------------------------------------------------------------------
--***********************************************eICU********************************************************--
---------------------------------------------------------------------------------------------------------------
--Numerical variables: Age, BMI, APACHE IV, ICU LOS, Hospital LOS
--Age, BMI, APACHE IV, ICU LOS, Hospital LOS
CREATE OR REPLACE TABLE `learned-vortex-290901.readmissons.readmission_num_var_eICU` as
SELECT cohort.patientunitstayid,
age, 
case when (admissionweight>20 and admissionweight<260 and admissionheight>100 and admissionheight<240) then 
round(admissionweight/power((admissionheight/100),2),2) else null end BMI,
apachescore_APACHE_IVa,
actualiculos as los_icu, 
actualhospitallos as los_hosp,
label_30days
FROM `learned-vortex-290901.readmissons.readmission_cohort_checked_features` cohort
left join `physionet-data.eicu_crd.apachepatientresult` apache
on cohort.patientunitstayid=apache.patientunitstayid
where (apacheversion = 'IVa' or apacheversion is null)
order by cohort.patientunitstayid

--Categorical variables
CREATE OR REPLACE TABLE `learned-vortex-290901.readmissons.readmission_bool_var_eICU` as
SELECT 
cohort.patientunitstayid,
--gender
case when cohort.gender='Female' then 1 when cohort.gender = 'Male'  then 0 else null end gender_female,
case when cohort.gender='Male' then 1 when cohort.gender = 'Female'  then 0 else null end gender_male,
--apache diagnosis
cardiovascular_adm_diag, 
neurologic_adm_diag, 
gastrointestinal_adm_diag,
trauma_adm_diag, 
respiratory_adm_diag, 
other_adm_diag, 
--unit type
case when cohort.unittype='Med-Surg ICU' then 1 when cohort.unittype is not null then 0 else null end as utype_Med_Surg_ICU,  
case when cohort.unittype='Cardiac ICU' then 1 when cohort.unittype is not null then 0 else null end as utype_Cardiac_ICU, 
case when cohort.unittype='CCU-CTICU' then 1 when cohort.unittype is not null then 0 else null end as utype_CCU_CTICU, 	
case when cohort.unittype='SICU' then 1 when cohort.unittype is not null then 0 else null end as utype_SICU,
case when cohort.unittype='Neuro ICU' then 1 when cohort.unittype is not null then 0 else null end as utype_Neuro_ICU,
case when cohort.unittype='MICU' then 1 when cohort.unittype is not null then 0 else null end as utype_MICU,
case when cohort.unittype='CSICU' then 1 when cohort.unittype is not null then 0 else null end as utype_CSICU,
case when cohort.unittype='CTICU' then 1 when cohort.unittype is not null then 0 else null end as utype_CTICU,
--hospital capacity
case when cohort.numbedscategory='100 - 249' then 1 when cohort.numbedscategory is not null then 0 else null end as numbed_100_249,
case when cohort.numbedscategory='<100' then 1 when cohort.numbedscategory is not null then 0 else null end as numbed_less_100,
case when cohort.numbedscategory='250 - 499' then 1 when cohort.numbedscategory is not null then 0 else null end as numbed_250_499,
case when cohort.numbedscategory='Unknown' then 1 when cohort.numbedscategory is not null then 0 else null end as numbed_unknown,
case when cohort.numbedscategory='>= 500' then 1 when cohort.numbedscategory is not null then 0 else null end as numbed_500_or_more,
--teaching/not-teaching
case when teachingstatus is TRUE then 1 when teachingstatus is FALSE then 0 else null end teachingstatus,
--origin
case when cohort.hospitaladmitsource in ('ICU', 'Other ICU') then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_ICU,
case when cohort.hospitaladmitsource = 'Operating Room' then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_Ope_Room,
case when cohort.hospitaladmitsource = 'Emergency Department' then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_ED,
case when cohort.hospitaladmitsource = 'Recovery Room' then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_RR,
case when cohort.hospitaladmitsource = 'Direct Admit' then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_DirectAdmit,
case when (cohort.hospitaladmitsource not in ('ICU', 'Operating Room', 'Emergency Department','Recovery Room','Direct Admit', 'Other ICU') and cohort.hospitaladmitsource is not null) then 1
     when cohort.hospitaladmitsource in ('ICU', 'Operating Room', 'Emergency Department','Recovery Room','Direct Admit', 'Other ICU') then 0 else null end admsource_other,
case when cohort.hospitaladmitsource is null then 1 else 0 end as admsource_unknown,
mech_vent_first_24,
vasopressors_first_24,
dialysis_first_24,
--mortality
case when patient.hospitaldischargelocation ='Death' then 1 when patient.hospitaldischargelocation is not null then 0 else null end as mortality,
--dischrge location
case when patient.hospitaldischargelocation='Home' then 1 when patient.hospitaldischargelocation is not null then 0 else null end as discharge_home,
case when patient.hospitaldischargelocation='Skilled Nursing Facility' then 1 when patient.hospitaldischargelocation is not null then 0 else null end as discharge_SNF,
case when patient.hospitaldischargelocation='Other Hospital' then 1 when patient.hospitaldischargelocation is not null then 0 else null end as discharge_other_hosp,
case when patient.hospitaldischargelocation='Rehabilitation' then 1 when patient.hospitaldischargelocation is not null then 0 else null end as discharge_rehab,
case when patient.hospitaldischargelocation='Nursing Home' then 1 when patient.hospitaldischargelocation is not null then 0 else null end as discharge_nurs_home,
case when patient.hospitaldischargelocation='Other External' then 1 when patient.hospitaldischargelocation is not null then 0 else null end as discharge_other_extern,
label_30days
FROM `learned-vortex-290901.readmissons.readmission_cohort_checked_features` cohort
left join `physionet-data.eicu_crd.hospital` hospital
on cohort.hospitalid=hospital.hospitalid 
left join `physionet-data.eicu_crd.patient` patient
on cohort.patientunitstayid=patient.patientunitstayid


---------------------------------------------------------------------------------------------------------------
--*********************************************MIMIC-IV******************************************************--
---------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE `learned-vortex-290901.readmissons.readmission_num_var_MIMIC_IV` as
SELECT patientunitstayid,
age, 
case when (admissionweight>20 and admissionweight<260 and admissionheight>100 and admissionheight<240) then 
round(admissionweight/power((admissionheight/100),2),2) else null end BMI,
sofa_table.SOFA,
sofa_table.respiration, 
sofa_table.coagulation, 
sofa_table.liver, 
sofa_table.cardiovascular, 
sofa_table.cns, 
sofa_table.renal,
round(icustays.los,2) los_icu,  
DATETIME_DIFF(admissions.dischtime,admissions.admittime,DAY) los_hosp,
label_30d as label_30days
FROM `learned-vortex-290901.readmissons.readmission_cohort_MIMIC_IV_2406` cohort
inner join `physionet-data.mimic_icu.icustays`  icustays
on cohort.patientunitstayid = icustays.stay_id
inner join `physionet-data.mimic_core.admissions` admissions
on admissions.hadm_id=icustays.hadm_id
left join `physionet-data.mimic_derived.first_day_sofa`  sofa_table
on cohort.patientunitstayid = sofa_table.stay_id


CREATE OR REPLACE TABLE `learned-vortex-290901.readmissons.readmission_bool_var_MIMIC_IV` as
SELECT 
patientunitstayid,
--gender
case when cohort.gender='F' then 1 when cohort.gender = 'M'  then 0 else null end gender_female,
case when cohort.gender='M' then 1 when cohort.gender = 'F'  then 0 else null end gender_male,
--unit type
case when cohort.unittype='MICU' then 1 when cohort.unittype is not null then 0 else null end as utype_MICU,
case when cohort.unittype='Med-Surg ICU' then 1 when cohort.unittype is not null then 0 else null end as utype_Med_Surg_ICU,  
case when cohort.unittype='CCU' then 1 when cohort.unittype is not null then 0 else null end as utype_CCU, 
case when cohort.unittype='CVICU' then 1 when cohort.unittype is not null then 0 else null end as utype_CVICU, 
case when cohort.unittype='SICU' then 1 when cohort.unittype is not null then 0 else null end as utype_SICU,
case when cohort.unittype='TSICU' then 1 when cohort.unittype is not null then 0 else null end as utype_TSICU,
case when cohort.unittype='Neuro ICU' then 1 when cohort.unittype is not null then 0 else null end as utype_Neuro_ICU,
--origin
case when cohort.hospitaladmitsource = 'TRANSFER FROM SKILLED NURSING FACILITY' then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_transf_SNF,
case when cohort.hospitaladmitsource = 'Operating Room' then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_Ope_Room,
case when cohort.hospitaladmitsource = 'ICU' then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_ICU,
case when cohort.hospitaladmitsource = 'Other' then 1 when cohort.hospitaladmitsource is not null then 0 else null end as admsource_Other,
mech_vent_first_24,
vasopressors_first_24,
dialysis_first_24,
--mortality
case when admissions.discharge_location ='DIED' then 1 when admissions.discharge_location is not null then 0 else null end as mortality,
--dischrge location
case when admissions.discharge_location='HOME' then 1 when admissions.discharge_location is not null then 0 else null end as discharge_home,
case when admissions.discharge_location='REHAB' then 1 when admissions.discharge_location is not null then 0 else null end as discharge_rehab,
case when admissions.discharge_location='HOME HEALTH CARE' then 1 when admissions.discharge_location is not null then 0 else null end as discharge_home_hc,
case when admissions.discharge_location='SKILLED NURSING FACILITY' then 1 when admissions.discharge_location is not null then 0 else null end as discharge_SNF,
case when admissions.discharge_location='CHRONIC/LONG TERM ACUTE CARE' then 1 when admissions.discharge_location is not null then 0 else null end as discharge_CLTAC,
case when admissions.discharge_location='HOSPICE' then 1 when admissions.discharge_location is not null then 0 else null end as discharge_hospice,
label_30d as label_30days
FROM `learned-vortex-290901.readmissons.readmission_cohort_MIMIC_IV_2406` cohort
inner join `physionet-data.mimic_icu.icustays`  icustays
on cohort.patientunitstayid = icustays.stay_id
inner join `physionet-data.mimic_core.admissions` admissions
on admissions.hadm_id=icustays.hadm_id

	
	
	
	

	

	



