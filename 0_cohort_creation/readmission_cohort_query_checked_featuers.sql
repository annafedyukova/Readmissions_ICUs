create or replace table `learned-vortex-290901.readmissons.readmission_cohort_checked_features`   
as
   with lab_first_24 as
    (
        select 
        --patienthealthsystemstayid patienthealthsystemstayid_first_24,
        patientunitstayid,
        aniongap_min aniongap_min_first_24,
        aniongap_max aniongap_max_first_24,
        albumin_min albumin_min_first_24,
        albumin_max albumin_max_first_24,
        bands_min bands_min_first_24,
        bands_max bands_max_first_24,
        bicarbonate_min bicarbonate_min_first_24,
        bicarbonate_max bicarbonate_max_first_24,
        hco3_min hco3_min_first_24,
        hco3_max hco3_max_first_24,
        bilirubin_min bilirubin_min_first_24,
        bilirubin_max bilirubin_max_first_24,
        creatinine_min creatinine_min_first_24,
        creatinine_max creatinine_max_first_24,
        chloride_min chloride_min_first_24,
        chloride_max chloride_max_first_24,
        glucose_min glucose_min_first_24,
        glucose_max glucose_max_first_24,
        hematocrit_min hematocrit_min_first_24,
        hematocrit_max hematocrit_max_first_24,
        hemoglobin_min hemoglobin_min_first_24,
        hemoglobin_max hemoglobin_max_first_24,
        lactate_min lactate_min_first_24,
        lactate_max lactate_max_first_24,
        platelet_min platelet_min_first_24,
        platelet_max platelet_max_first_24,
        potassium_min potassium_min_first_24,
        potassium_max potassium_max_first_24,
        ptt_min ptt_min_first_24,
        ptt_max ptt_max_first_24,
        inr_min inr_min_first_24,
        inr_max inr_max_first_24,
        pt_min pt_min_first_24,
        pt_max pt_max_first_24,
        sodium_min sodium_min_first_24,
        sodium_max sodium_max_first_24,
        bun_min bun_min_first_24,
        bun_max bun_max_first_24,
        wbc_min wbc_min_first_24,
        wbc_max wbc_max_first_24
        from `physionet-data.eicu_crd_derived.labsfirstday`
    )
    ,lab_last_24 as
    (
        select
        lab.patientunitstayid,
        round(min(albumin),2) albumin_min_last_24,
        round(max(albumin),2) albumin_max_last_24,
        round(min(bilirubin),2) bilirubin_min_last_24, 
        round(max(bilirubin),2) bilirubin_max_last_24, 
        round(min(BUN),2) BUN_min_last_24, 
        round(max(BUN),2) BUN_max_last_24, 
        round(min(calcium),2) calcium_min_last_24, 
        round(max(calcium),2) calcium_max_last_24, 
        round(min(creatinine),2) creatinine_min_last_24, 
        round(max(creatinine),2) creatinine_max_last_24, 
        round(min(glucose),2) glucose_min_last_24, 
        round(max(glucose),2) glucose_max_last_24, 
        round(min(bicarbonate),2) bicarbonate_min_last_24, 
        round(max(bicarbonate),2) bicarbonate_max_last_24, 
        round(min(TotalCO2),2) TotalCO2_min_last_24, 
        round(max(TotalCO2),2) TotalCO2_max_last_24, 
        round(min(hematocrit),2) hematocrit_min_last_24, 
        round(max(hematocrit),2) hematocrit_max_last_24, 
        round(min(hemoglobin),2) hemoglobin_min_last_24, 
        round(max(hemoglobin),2) hemoglobin_max_last_24, 
        round(min(INR),2) INR_min_last_24, 
        round(max(INR),2) INR_max_last_24,
        round(min(lactate),2) lactate_min_last_24, 
        round(max(lactate),2) lactate_max_last_24, 
        round(min(platelets),2) platelets_min_last_24, 
        round(max(platelets),2) platelets_max_last_24, 
        round(min(potassium),2) potassium_min_last_24, 
        round(max(potassium),2) potassium_max_last_24, 
        round(min(ptt),2) ptt_min_last_24, 
        round(max(ptt),2) ptt_max_last_24, 
        round(min(sodium),2) sodium_min_last_24, 
        round(max(sodium),2) sodium_max_last_24, 
        round(min(wbc),2) wbc_min_last_24, 
        round(max(wbc),2) wbc_max_last_24, 
        round(min(bands),2) bands_min_last_24, 
        round(max(bands),2) bands_max_last_24, 
        round(min(alt),2) alt_min_last_24,  
        round(max(alt),2) alt_max_last_24, 
        round(min(ast),2) ast_min_last_24, 
        round(max(ast),2) ast_max_last_24, 
        round(min(alp),2) alp_min_last_24,
        round(max(alp),2) alp_max_last24
        from `physionet-data.eicu_crd_derived.pivoted_lab` lab
        inner join  `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid = lab.patientunitstayid
        where lab.chartoffset >= (pat.unitdischargeoffset-1440) 
        and lab.chartoffset <= pat.unitdischargeoffset
        group by lab.patientunitstayid
    )
    ,vitals_first_24 as
    (
        select vital.patientunitstayid,
        round(min(heartrate),2) heartrate_min_first_24,
        round(max(heartrate),2) heartrate_max_first_24,
        round(avg(heartrate),2) heartrate_avg_first_24,
        round(min(respiratoryrate),2) respiratoryrate_min_first_24,
        round(max(respiratoryrate),2) respiratoryrate_max_first_24,
        round(avg(respiratoryrate),2) respiratoryrate_avg_first_24,
        round(min(spo2),2) spo2_min_first_24,
        round(max(spo2),2) spo2_max_first_24,
        round(avg(spo2),2) spo2_avg_first_24,
        round(min(nibp_systolic),2) nibp_systolic_min_first_24,
        round(max(nibp_systolic),2) nibp_systolic_max_first_24,
        round(avg(nibp_systolic),2) nibp_systolic_avg_first_24,
        round(min(nibp_diastolic),2) nibp_diastolic_min_first_24,
        round(max(nibp_diastolic),2) nibp_diastolic_max_first_24,
        round(avg(nibp_diastolic),2) nibp_diastolic_avg_first_24,
        round(min(nibp_mean),2) nibp_mean_min_first_24, --nibp Non-Invasive BP
        round(max(nibp_mean),2) nibp_mean_max_first_24,
        round(avg(nibp_mean),2) nibp_mean_avg_first_24,
        round(min(temperature),2) temperature_min_first_24,
        round(max(temperature),2) temperature_max_first_24,
        round(avg(temperature),2) temperature_avg_first_24,
        round(min(ibp_systolic),2) ibp_systolic_min_first_24,
        round(max(ibp_systolic),2) ibp_systolic_max_first_24,
        round(avg(ibp_systolic),2) ibp_systolic_avg_first_24,
        round(min(ibp_diastolic),2) ibp_diastolic_min_first_24,
        round(max(ibp_diastolic),2) ibp_diastolic_max_first_24,
        round(avg(ibp_diastolic),2) ibp_diastolic_avg_first_24,
        round(min(ibp_mean),2) ibp_mean_min_first_24,
        round(max(ibp_mean),2) ibp_mean_max_first_24,
        round(avg(ibp_mean),2) ibp_mean_avg_first_24
        from `physionet-data.eicu_crd_derived.pivoted_vital` vital
        where vital.chartoffset <= 1440 -- first 24 hours 
        group by vital.patientunitstayid
    )
    ,vitals_last_24 as
    (
        select pat.patientunitstayid,
        round(min(heartrate),2) heartrate_min_last_24 ,
        round(max(heartrate),2) heartrate_max_last_24 ,
        round(avg(heartrate),2) heartrate_avg_last_24 ,
        round(min(respiratoryrate),2) respiratoryrate_min_last_24 ,
        round(max(respiratoryrate),2) respiratoryrate_max_last_24,
        round(avg(respiratoryrate),2) respiratoryrate_avg_last_24,
        round(min(spo2),2) spo2_min_last_24,
        round(max(spo2),2) spo2_max_last_24,
        round(avg(spo2),2) spo2_avg_last_24,
        round(min(nibp_systolic),2) nibp_systolic_min_last_24,
        round(max(nibp_systolic),2) nibp_systolic_max_last_24,
        round(avg(nibp_systolic),2) nibp_systolic_avg_last_24,
        round(min(nibp_diastolic),2) nibp_diastolic_min_last_24,
        round(max(nibp_diastolic),2) nibp_diastolic_max_last_24,
        round(avg(nibp_diastolic),2) nibp_diastolic_avg_last_24,
        round(min(nibp_mean),2) nibp_mean_min_last_24,
        round(max(nibp_mean),2) nibp_mean_max_last_24,
        round(avg(nibp_mean),2) nibp_mean_avg_last_24,
        round(min(temperature),2) temperature_min_last_24,
        round(max(temperature),2) temperature_max_last_24,
        round(avg(temperature),2) temperature_avg_last_24,
        round(min(ibp_systolic),2) ibp_systolic_min_last_24,
        round(max(ibp_systolic),2) ibp_systolic_max_last_24,
        round(avg(ibp_systolic),2) ibp_systolic_avg_last_24,
        round(min(ibp_diastolic),2) ibp_diastolic_min_last_24,
        round(max(ibp_diastolic),2) ibp_diastolic_max_last_24,
        round(avg(ibp_diastolic),2) ibp_diastolic_avg_last_24,
        round(min(ibp_mean),2) ibp_mean_min_last_24,
        round(max(ibp_mean),2) ibp_mean_max_last_24,
        round(avg(ibp_mean),2) ibp_mean_avg_last_24
        from `physionet-data.eicu_crd_derived.pivoted_vital` vital
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=vital.patientunitstayid
        where  vital.chartoffset >= (pat.unitdischargeoffset-1440) 
        and  vital.chartoffset <= pat.unitdischargeoffset
        group by pat.patientunitstayid
    )
    ,cohort_vitals_other_first_24 as
    (
        select vital_other.patientunitstayid,
        round(min(pasystolic),2) pasystolic_min_first_24 ,
        round(max(pasystolic),2) pasystolic_max_first_24 ,
        round(avg(pasystolic),2) pasystolic_avg_first_24 ,
        round(min(padiastolic),2) padiastolic_min_first_24 ,
        round(max(padiastolic),2) padiastolic_max_first_24,
        round(avg(padiastolic),2) padiastolic_avg_first_24,
        round(min(pamean),2) pamean_min_first_24,
        round(max(pamean),2) pamean_max_first_24,
        round(avg(pamean),2) pamean_avg_first_24,
        round(min(sv),2) sv_min_first_24,
        round(max(sv),2) sv_max_first_24,
        round(avg(sv),2) sv_avg_first_24,
        round(min(co),2) co_min_first_24,
        round(max(co),2) co_max_first_24,
        round(avg(co),2) co_avg_first_24,
        round(min(svr),2) svr_min_first_24,
        round(max(svr),2) svr_max_first_24,
        round(avg(svr),2) svr_avg_first_24,
        round(min(icp),2) icp_min_first_24,
        round(max(icp),2) icp_max_first_24,
        round(avg(icp),2) icp_avg_first_24,
        round(min( cast(ci as FLOAT64)),2) ci_min_first_24,
        round(max( cast(ci as FLOAT64)),2) ci_max_first_24,
        round(avg( cast(ci as FLOAT64)),2) ci_avg_first_24,
        round(min(cast(svri as FLOAT64)),2) svri_min_first_24,
        round(max(cast(svri as FLOAT64)),2) svri_max_first_24,
        round(avg(cast(svri as FLOAT64)),2) svri_avg_first_24,
        round(min(cpp),2) cpp_min_first_24,
        round(max(cpp),2) cpp_max_first_24,
        round(avg(cpp),2) cpp_avg_first_24,
        round(min(cast(svo2 as FLOAT64)),2) svo2_min_first_24,
        round(max(cast(svo2 as FLOAT64)),2) svo2_max_first_24,
        round(avg(cast(svo2 as FLOAT64)),2) svo2_avg_first_24,
        round(min(paop),2) paop_min_first_24,
        round(max(paop),2) paop_max_first_24,
        round(avg(paop),2) paop_avg_first_24,
        round(min(pvr),2) pvr_min_first_24,
        round(max(pvr),2) pvr_max_first_24,
        round(avg(pvr),2) pvr_avg_first_24,
        round(min(cast(pvri as FLOAT64)),2) pvri_min_first_24,
        round(max(cast(pvri as FLOAT64)),2) pvri_max_first_24,
        round(avg(cast(pvri as FLOAT64)),2) pvri_avg_first_24,
        round(min(cast(iap as FLOAT64)),2) iap_min_first_24,
        round(max(cast(iap as FLOAT64)),2) iap_max_first_24,
        round(avg(cast(iap as FLOAT64)),2) iap_avg_first_24
        from `physionet-data.eicu_crd_derived.pivoted_vital_other` vital_other
        where  vital_other.chartoffset <= 1440 
        group by vital_other.patientunitstayid
    )
    ,cohort_vitals_other_last_24 as
    (
        select pat.patientunitstayid,
        round(min(pasystolic),2) pasystolic_min_last_24 ,
        round(max(pasystolic),2) pasystolic_max_last_24 ,
        round(avg(pasystolic),2) pasystolic_avg_last_24 ,
        round(min(padiastolic),2) padiastolic_min_last_24 ,
        round(min(padiastolic),2) padiastolic_min_last_24 ,
        round(max(padiastolic),2) padiastolic_max_last_24,
        round(avg(padiastolic),2) padiastolic_avg_last_24,
        round(min(pamean),2) pamean_min_last_24,
        round(max(pamean),2) pamean_max_last_24,
        round(avg(pamean),2) pamean_avg_last_24,
        round(min(sv),2) sv_min_last_24,
        round(max(sv),2) sv_max_last_24,
        round(avg(sv),2) sv_avg_last_24,
        round(min(co),2) co_min_last_24,
        round(max(co),2) co_max_last_24,
        round(avg(co),2) co_avg_last_24,
        round(min(svr),2) svr_min_last_24,
        round(max(svr),2) svr_max_last_24,
        round(avg(svr),2) svr_avg_last_24,
        round(min(icp),2) icp_min_last_24,
        round(max(icp),2) icp_max_last_24,
        round(avg(icp),2) icp_avg_last_24,
        round(min(cast(ci as FLOAT64)),2) ci_min_last_24,
        round(max(cast(ci as FLOAT64)),2) ci_max_last_24,
        round(avg(cast(ci as FLOAT64)),2) ci_avg_last_24,
        round(min(cast(svri as FLOAT64)),2) svri_min_last_24,
        round(max(cast(svri as FLOAT64)),2) svri_max_last_24,
        round(avg(cast(svri as FLOAT64)),2) svri_avg_last_24,
        round(min(cpp),2) cpp_min_last_24,
        round(max(cpp),2) cpp_max_last_24,
        round(avg(cpp),2) cpp_avg_last_24,
        round(min(cast(svo2 as FLOAT64)),2) svo2_min_last_24,
        round(max(cast(svo2 as FLOAT64)),2) svo2_max_last_24,
        round(avg(cast(svo2 as FLOAT64)),2) svo2_avg_last_24,
        round(min(paop),2) paop_min_last_24,
        round(max(paop),2) paop_max_last_24,
        round(avg(paop),2) paop_avg_last_24,
        round(min(pvr),2) pvr_min_last_24,
        round(max(pvr),2) pvr_max_last_24,
        round(avg(pvr),2) pvr_avg_last_24,
        round(min(cast(pvri as FLOAT64)),2) pvri_min_last_24,
        round(max(cast(pvri as FLOAT64)),2) pvri_max_last_24,
        round(avg(cast(pvri as FLOAT64)),2) pvri_avg_last_24,
        round(min(cast(iap as FLOAT64)),2) iap_min_last_24,
        round(max(cast(iap as FLOAT64)),2) iap_max_last_24,
        round(avg(cast(iap as FLOAT64)),2) iap_avg_last_24
        from `physionet-data.eicu_crd_derived.pivoted_vital_other` vital_other
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid = vital_other.patientunitstayid
        where  vital_other.chartoffset >= (pat.unitdischargeoffset-1440) 
        and  vital_other.chartoffset <= pat.unitdischargeoffset
        group by pat.patientunitstayid
    )
    ,co_morbidities as
    (
        select patientunitstayid,  
        max(case when pasthistorypath in 
            ('notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Chronic Stone Disease/chronic kidney stones',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Cancer-Primary Site/kidney',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Insufficiency/renal insufficiency - creatinine 1-2',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Insufficiency/renal insufficiency - creatinine 2-3',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Insufficiency/renal insufficiency - creatinine 3-4',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Insufficiency/renal insufficiency - creatinine 4-5',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Insufficiency/renal insufficiency - creatinine > 5',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Insufficiency/renal insufficiency - baseline creatinine unknown',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/s/p Renal Transplant/s/p renal transplant',
            --(next few could be acute failure)
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Failure/renal failure - peritoneal dialysis',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Failure/renal failure - hemodialysis',
            'notes/Progress Notes/Past History/Organ Systems/Renal  (R)/Renal Failure/renal failure- not currently dialyzed'
            ) then
            1
            else 
            0
            end) kidney_co_morbidities, 
        max(case when pasthistorypath in 
            ('notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Metastases/liver',
            'notes/Progress Notes/Past History/Organ Systems/Gastrointestinal (R)/s/p Liver Transplant/s/p liver transplant',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Cancer-Primary Site/liver',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer Therapy/Radiation Therapy within past 6 months/liver',
            'notes/Progress Notes/Past History/Organ Systems/Gastrointestinal (R)/Cirrhosis/clinical diagnosis',
            'notes/Progress Notes/Past History/Organ Systems/Gastrointestinal (R)/Cirrhosis/ascites',
            'notes/Progress Notes/Past History/Organ Systems/Gastrointestinal (R)/Cirrhosis/varices',
            'notes/Progress Notes/Past History/Organ Systems/Gastrointestinal (R)/Cirrhosis/UGI bleeding',
            'notes/Progress Notes/Past History/Organ Systems/Gastrointestinal (R)/Cirrhosis/encephalopathy',
            'notes/Progress Notes/Past History/Organ Systems/Gastrointestinal (R)/Cirrhosis/biopsy proven',
            'notes/Progress Notes/Past History/Organ Systems/Gastrointestinal (R)/Cirrhosis/coma',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Cancer-Primary Site/bile duct') then
            1
            else 
            0
            end) liver_co_morbidities,
        max(case when  pasthistorypath in 
            ('notes/Progress Notes/Past History/Organ Systems/Neurologic/Strokes/stroke - within 2 years',
            'notes/Progress Notes/Past History/Organ Systems/Neurologic/Strokes/stroke - within 5 years',
            'notes/Progress Notes/Past History/Organ Systems/Neurologic/Strokes/stroke - within 6 months',
            'notes/Progress Notes/Past History/Organ Systems/Neurologic/Strokes/stroke - remote',
            'notes/Progress Notes/Past History/Organ Systems/Neurologic/Strokes/multiple/multiple',
            'notes/Progress Notes/Past History/Organ Systems/Neurologic/Strokes/stroke - date unknown'
            ) then
            1
            else
            0
            end) stroke_co_morbidities,
        max(case when  pasthistorypath in
            (
            'notes/Progress Notes/Past History/Organ Systems/Pulmonary/COPD/COPD  - severe',
            'notes/Progress Notes/Past History/Organ Systems/Pulmonary/COPD/COPD  - moderate',
            'notes/Progress Notes/Past History/Organ Systems/Pulmonary/COPD/COPD  - no limitations'
            ) then
            1
            else
            0
            end) CRD_co_morbidities,
        max(case when  pasthistorypath in
            (
            'notes/Progress Notes/Past History/Organ Systems/Cardiovascular (R)/Congestive Heart Failure/CHF - class III',
            'notes/Progress Notes/Past History/Organ Systems/Cardiovascular (R)/Congestive Heart Failure/CHF - class II',
            'notes/Progress Notes/Past History/Organ Systems/Cardiovascular (R)/Congestive Heart Failure/CHF - class IV',
            'notes/Progress Notes/Past History/Organ Systems/Cardiovascular (R)/Congestive Heart Failure/CHF',
            'notes/Progress Notes/Past History/Organ Systems/Cardiovascular (R)/Congestive Heart Failure/CHF - severity unknown',
            'notes/Progress Notes/Past History/Organ Systems/Cardiovascular (R)/Congestive Heart Failure/CHF - class I'
            )
            then
            1
            else
            0
            end) heart_failure_co_morbidities,
        max(case when  pasthistorypath in
            (
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/AML',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/other hematologic malignancy',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/multiple myeloma',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/CLL',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/non-Hodgkins lymphoma',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/Hodgkins disease',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/CML',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/leukemia - other',
            'notes/Progress Notes/Past History/Organ Systems/Hematology/Oncology (R)/Cancer/Hematologic Malignancy/ALL'
            )
            then
            1
            else
            0
            end) hematologic_malignancy_co_morbidities,
        max(case when  pasthistorypath in
            ( 
            'notes/Progress Notes/Past History/Organ Systems/Endocrine (R)/Non-Insulin Dependent Diabetes/medication dependent',
            'notes/Progress Notes/Past History/Organ Systems/Endocrine (R)/Non-Insulin Dependent Diabetes/non-medication dependent',
            'notes/Progress Notes/Past History/Organ Systems/Endocrine (R)/Insulin Dependent Diabetes/insulin dependent diabetes'
            )
            then
            1
            else
            0
            end) diabetes_co_morbidities,
        max(case when  pasthistorypath ='notes/Progress Notes/Past History/Organ Systems/Pulmonary/Asthma/asthma' then
            1
            else 
            0
            end) asthma_co_morbidities
        from `physionet-data.eicu_crd.pasthistory` 
        group by patientunitstayid
    )
    ,gcs_first_24 as
    (
        select  gcs.patientunitstayid, 
        min(gcs.gcs) gcs_min_first_24, 
        max(gcs.gcs) gcs_max_first_24,  
        round(avg(gcs.gcs),2) gcs_avg_first_24  
        from `physionet-data.eicu_crd_derived.pivoted_gcs` gcs
        where gcs.chartoffset <= 1440 
        group by gcs.patientunitstayid
    )
    ,gcs_last_24 as
    (
        select  gcs.patientunitstayid, 
        min(gcs.gcs) gcs_min_last_24, 
        max(gcs.gcs) gcs_max_last_24,  
        round(avg(gcs.gcs),2) gcs_avg_last_24 
        from `physionet-data.eicu_crd_derived.pivoted_gcs` gcs
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=gcs.patientunitstayid
        and gcs.chartoffset >= (pat.unitdischargeoffset-1440) 
        and gcs.chartoffset <= pat.unitdischargeoffset
        group by gcs.patientunitstayid
    )
    ,creatinine_first_24 as
    (
        select crt.patientunitstayid,
        min(creatinine) creatinine_min_first_24,
        max(creatinine) creatinine_max_first_24,
        round(avg(creatinine),2) creatinine_avg_first_24
        from `physionet-data.eicu_crd_derived.pivoted_creatinine` crt
        where crt.chartoffset <= 1440 
        group by crt.patientunitstayid
    )
    ,creatinine_last_24 as
    (
        select crt.patientunitstayid,
        min(creatinine) creatinine_min_last_24,
        max(creatinine) creatinine_max_last_24,
        round(avg(creatinine),2) creatinine_avg_last_24
        from `physionet-data.eicu_crd_derived.pivoted_creatinine` crt
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=crt.patientunitstayid
        and crt.chartoffset >= (pat.unitdischargeoffset-1440) 
        and crt.chartoffset <= pat.unitdischargeoffset
        group by crt.patientunitstayid
    )
    ,urine_output_first_24 as
    (
    select 
        uo.patientunitstayid, 
        max(uo.outputtotal) outputtotal_max_first_24,
        min(uo.outputtotal) outputtotal_min_first_24, 
        round(avg(uo.outputtotal),2) outputtotal_avg_first_24,
        max(uo.urineoutput) urineoutput_max_first_24,
        min(uo.urineoutput) urineoutput_min_first_24,
        round(avg(uo.urineoutput),2) urineoutput_avg_first_24
        from `physionet-data.eicu_crd_derived.pivoted_uo` uo
        where uo.chartoffset <= 1440 
        group by uo.patientunitstayid
    )
    ,urine_output_last_24 as
    (
        select 
        uo.patientunitstayid, 
        max(uo.outputtotal) outputtotal_max_last_24,
        min(uo.outputtotal) outputtotal_min_last_24, 
        round(avg(uo.outputtotal),2) outputtotal_avg_last_24,
        max(uo.urineoutput) urineoutput_max_last_24,
        min(uo.urineoutput) urineoutput_min_last_24,
        round(avg(uo.urineoutput),2) urineoutput_avg_last_24
        from `physionet-data.eicu_crd_derived.pivoted_uo` uo
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=uo.patientunitstayid
        and uo.chartoffset >= (pat.unitdischargeoffset-1440) 
        and uo.chartoffset <= pat.unitdischargeoffset
        group by uo.patientunitstayid
    )
    ,vasopressor_first_24 as
    (
        select vs.patientunitstayid,
        max(vs.vasopressor) vasopressor_first_24
        from `physionet-data.eicu_crd_derived.pivoted_treatment_vasopressor` vs
        where vs.chartoffset <= 1440 
        group by vs.patientunitstayid
    )
    ,vasopressor_last_24 as
    (
        select vs.patientunitstayid,
        max(vs.vasopressor) vasopressor_last_24
        from `physionet-data.eicu_crd_derived.pivoted_treatment_vasopressor` vs
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=vs.patientunitstayid
        and vs.chartoffset >= (pat.unitdischargeoffset-1440) 
        and vs.chartoffset <= pat.unitdischargeoffset
        group by vs.patientunitstayid
    )
    ,blood_gas_first_24 as
    (
        select 
        bg.patientunitstayid,
        max(bg.fio2) fio2_max_first_24,
        min(bg.fio2) fio2_min_first_24,
        round(avg(bg.fio2),2) fio2_avg_first_24,
        max(bg.pao2) pao2_max_first_24,
        min(bg.pao2) pao2_min_first_24,
        round(avg(bg.pao2),2) pao2_avg_first_24,
        max(bg.paco2) paco2_max_first_24,
        min(bg.paco2) paco2_min_first_24,
        round(avg(bg.paco2),2) paco2_avg_first_24,
        max(bg.ph) ph_max_first_24,
        min(bg.ph) ph_min_first_24,
        round(avg(bg.ph),2) ph_avg_first_24,
        max(bg.aniongap) aniongap_max_first_24,
        min(bg.aniongap) aniongap_min_first_24,
        round(avg(bg.aniongap),2) aniongap_avg_first_24,
        max(bg.basedeficit) basedeficit_max_first_24,
        min(bg.basedeficit) basedeficit_min_first_24,
        round(avg(bg.basedeficit),2) basedeficit_avg_first_24,
        max(bg.baseexcess) baseexcess_max_first_24,
        min(bg.baseexcess) baseexcess_min_first_24,
        round(avg(bg.baseexcess),2) baseexcess_avg_first_24,
        max(bg.peep) peep_max_first_24,
        min(bg.peep) peep_min_first_24,
        round(avg(bg.peep),2) peep_avg_first_24
        from `physionet-data.eicu_crd_derived.pivoted_bg` bg
        where bg.chartoffset <= 1440 
        group by bg.patientunitstayid
    )
    ,blood_gas_last_24 as
    (
        select 
        bg.patientunitstayid,
        max(bg.fio2) fio2_max_last_24,
        min(bg.fio2) fio2_min_last_24,
        round(avg(bg.fio2),2) fio2_avg_last_24,
        max(bg.pao2) pao2_max_last_24,
        min(bg.pao2) pao2_min_last_24,
        round(avg(bg.pao2),2) pao2_avg_last_24,
        max(bg.paco2) paco2_max_last_24,
        min(bg.paco2) paco2_min_last_24,
        round(avg(bg.paco2),2) paco2_avg_last_24,
        max(bg.ph) ph_max_last_24,
        min(bg.ph) ph_min_last_24,
        round(avg(bg.ph),2) ph_avg_last_24,
        max(bg.aniongap) aniongap_max_last_24,
        min(bg.aniongap) aniongap_min_last_24,
        round(avg(bg.aniongap),2) aniongap_avg_last_24,
        max(bg.basedeficit) basedeficit_max_last_24,
        min(bg.basedeficit) basedeficit_min_last_24,
        round(avg(bg.basedeficit),2) basedeficit_avg_last_24,
        max(bg.baseexcess) baseexcess_max_last_24,
        min(bg.baseexcess) baseexcess_min_last_24,
        round(avg(bg.baseexcess),2) baseexcess_avg_last_24,
        max(bg.peep) peep_max_last_24,
        min(bg.peep) peep_min_last_24,
        round(avg(bg.peep),2) peep_avg_last_24
        from `physionet-data.eicu_crd_derived.pivoted_bg` bg
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=bg.patientunitstayid
        where bg.chartoffset >=(pat.unitdischargeoffset-1440) 
        and bg.chartoffset <= pat.unitdischargeoffset
        group by bg.patientunitstayid
    )
    ,nutrition_first_24 as
    (
        select  nurc.patientunitstayid,
        max(case when upper(nurc.cellattributevalue)='NPO' then
            1
            end) npo_first_24,
        max(case when upper(nurc.cellattributevalue) in ('CALORIE CONTROLLED','RENAL DIET','FULL LIQUIDS','TPN','ENTERAL AND IV','SUPPLEMENT','SNACK','PPN','LOW SODIUM DIET','REGULAR DIET','CLEAR LIQUIDS','DIABETIC DIET','ENTERAL') then
            1
            end) other_nutrition_first_24
        from `physionet-data.eicu_crd.nursecare` nurc
        where nurc.cellattributepath like '%Nutrition%'
        and nurc.nursecareoffset <= 1440 
        group by nurc.patientunitstayid
    )
    ,nutrition_last_24 as
    (
        select  nurc.patientunitstayid,
        max(case when upper(nurc.cellattributevalue)='NPO' then
            1
            end) npo_last_24,
        max(case when upper(nurc.cellattributevalue) in ('CALORIE CONTROLLED','RENAL DIET','FULL LIQUIDS','TPN','ENTERAL AND IV','SUPPLEMENT','SNACK','PPN','LOW SODIUM DIET','REGULAR DIET','CLEAR LIQUIDS','DIABETIC DIET','ENTERAL') then
            1
            end) other_nutrition_last_24
        from `physionet-data.eicu_crd.nursecare` nurc
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=nurc.patientunitstayid
        where nurc.cellattributepath like '%Nutrition%'
        and nurc.nursecareoffset >= (pat.unitdischargeoffset-1440) 
        and nurc.nursecareoffset <= pat.unitdischargeoffset
        group by nurc.patientunitstayid
    )
    ,dialysis_first_24 as
    (
        select dial.patientunitstayid, 1 as d_first_24
        from `physionet-data.eicu_crd.treatment` dial 
        where treatmentstring like '%dialysi%'
        and treatmentstring not like '%procedures/radiology%'
        and treatmentstring not like '%insertion of venous catheter for hemodialysis%'
        and treatmentstring <> 'cardiovascular|vascular surgery|dialysis access surgery'
        and dial.treatmentoffset <= 1440 
        group by dial.patientunitstayid
    ), 
    dialysis_last_24 as
    (
        select dial.patientunitstayid, 1 as d_last_24
        from `physionet-data.eicu_crd.treatment` dial 
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=dial.patientunitstayid
        where treatmentstring like '%dialysi%'
        and treatmentstring not like '%procedures/radiology%'
        and treatmentstring not like '%insertion of venous catheter for hemodialysis%'
        and treatmentstring <> 'cardiovascular|vascular surgery|dialysis access surgery'
        and dial.treatmentoffset >= (pat.unitdischargeoffset-1440) 
        and dial.treatmentoffset <= pat.unitdischargeoffset
        group by dial.patientunitstayid
    )
    ,ventilation_first_24 as
    (
        select dial.patientunitstayid, 
        max(case when treatmentstring in (
            'pulmonary|ventilation and oxygenation|lung recruitment maneuver',
            'pulmonary|ventilation and oxygenation|mechanical ventilation',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|assist controlled',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|permissive hypercapnea',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|pressure controlled',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|pressure support',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|synchronized intermittent',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|tidal volume 6-10 ml/kg',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|tidal volume < 6 ml/kg',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|tidal volume > 10 ml/kg',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|volume assured',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|volume controlled') then 1
            end ) as mech_vent_first_24,
        max(case when treatmentstring in(
            'pulmonary|ventilation and oxygenation|non-invasive ventilation',
            'pulmonary|ventilation and oxygenation|non-invasive ventilation|face mask',
            'pulmonary|ventilation and oxygenation|non-invasive ventilation|nasal mask')then 1
            end ) as NIV_first_24,
        from `physionet-data.eicu_crd.treatment` dial 
        where treatmentstring like '%ventilation%'
        and dial.treatmentoffset <= 1440 
        group by dial.patientunitstayid
    )
    ,ventilation_last_24 as
    (
        select dial.patientunitstayid, 
        max(case when treatmentstring in (
            'pulmonary|ventilation and oxygenation|lung recruitment maneuver',
            'pulmonary|ventilation and oxygenation|mechanical ventilation',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|assist controlled',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|permissive hypercapnea',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|pressure controlled',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|pressure support',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|synchronized intermittent',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|tidal volume 6-10 ml/kg',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|tidal volume < 6 ml/kg',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|tidal volume > 10 ml/kg',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|volume assured',
            'pulmonary|ventilation and oxygenation|mechanical ventilation|volume controlled') 
            then 1
            end) as mech_vent_last_24,
        max(case when treatmentstring in (
            'pulmonary|ventilation and oxygenation|non-invasive ventilation',
            'pulmonary|ventilation and oxygenation|non-invasive ventilation|face mask',
            'pulmonary|ventilation and oxygenation|non-invasive ventilation|nasal mask')then 1
            end ) as NIV_last_24,
        from `physionet-data.eicu_crd.treatment` dial 
        inner join `physionet-data.eicu_crd.patient` pat
        on pat.patientunitstayid=dial.patientunitstayid
        where treatmentstring like '%ventilation%'
        and dial.treatmentoffset >= (pat.unitdischargeoffset-1440) 
        and dial.treatmentoffset <= pat.unitdischargeoffset
        group by dial.patientunitstayid
    )
    ,apache_IVa as
    (
        select 
        patientunitstayid,    
        --physicianspeciality physicianspeciality_APACHE_IVa,
        case when physicianspeciality in ('surgery-general','surgery-cardiac','surgery-neuro','surgery-trauma','surgery-vascular','surgery-critical care','surgery-otolaryngology head & neck','surgery-pediatric','surgery-plastic','surgery-orthopedic','surgery-transplant','surgery-oral','urology','radiology','obstetrics/gynecology','ophthalmology','orthopedics','otolaryngology') then 
        'Surgical'
            when physicianspeciality in ('internal medicine','hospitalist','cardiology','pulmonary','family practice','neurology','nephrology','emergency medicine','oncology','gastroenterology','hematology/oncology','infectious disease','endocrinology','hematology','psychiatry','rheumatology','physical medicine/rehab','allergy/immunology','respiratory therapist','dermatology') then
        'Medical'
            when physicianspeciality in ('critical care medicine (CCM)','pulmonary/CCM','emergency medicine','anesthesiology/CCM','anesthesiology') then
        'Crit care'
            when physicianspeciality in  ('Specialty Not Specified','unknown','other','ethics','nurse','nurse practitioner') then
        'Other'
        end physicianspeciality_APACHE_IVa,    
        physicianinterventioncategory physicianinterventioncategory_APACHE_IVa,
        acutephysiologyscore acutephysiologyscore_APACHE_IVa,
        apachescore apachescore_APACHE_IVa,
        predictedicumortality predictedicumortality_APACHE_IVa,
        predictediculos predictediculos_APACHE_IVa,
        predictedhospitalmortality predictedhospitalmortality_APACHE_IVa,
        predictedhospitallos predictedhospitallos_APACHE_IVa,
        preopmi preopmi_APACHE_IVa,
        preopcardiaccath preopcardiaccath_APACHE_IVa,
        ptcawithin24h ptcawithin24h_APACHE_IVa,
        unabridgedunitlos unabridgedunitlos_APACHE_IVa,
        --unabridgedhosplos unabridgedhosplos_APACHE_IVa,
        predventdays predventdays_APACHE_IVa
        from `physionet-data.eicu_crd.apachepatientresult`
        where apacheversion = 'IVa'
    ), admint_diag_elective_yes as 
    ( 
        select  patientunitstayid
        from `physionet-data.eicu_crd.admissiondx` 
        where admitdxpath like ('%|Elective|Yes%')
        group by patientunitstayid
    ), admint_diag_elective_no as 
    ( 
        select  patientunitstayid
        from `physionet-data.eicu_crd.admissiondx` 
        where admitdxpath like ('%|Elective|No%')
        group by patientunitstayid
    ), non_operative_adm_diag as
    (
        select patientunitstayid
        from `physionet-data.eicu_crd.admissiondx` 
        where admitdxpath like ('%Non-operative%')
        group by patientunitstayid

    ), operative_adm_diag as  
    (
        select patientunitstayid
        from `physionet-data.eicu_crd.admissiondx` 
        where (admitdxpath like ('%Operative%')
        and admitdxpath not like ('%Non-operative%'))
        group by  patientunitstayid 
    ), group_of_adm_diag as
    (
        select admissiondx.patientunitstayid,
        max(case 
        when admitdxpath like '%Sepsis%' 
        then 1
        end) as sepsis_adm_diag,
        max(case when (admitdxpath like '%Cardiovascular%' and admitdxpath not like  '%Sepsis%') 
        then 1
        end) as cardiovascular_adm_diag,
        max(case when admitdxpath like '%Respiratory%' 
        then 1
        end) as respiratory_adm_diag,
        max(case when admitdxpath like '%Gastrointestinal%' 
        then 1 
        end) as gastrointestinal_adm_diag,
        max(case when (admitdxpath like '%Neurologic%' or admitdxpath like '%Neurology%') 
        then 1 
        end) as neurologic_adm_diag,
        max(case when (admitdxpath like '%Trauma%' or  admitdxpath like '%|Burn%') 
        then 1 
        end) as trauma_adm_diag,
        max(case when (admitdxpath like '%Metabolic%' 
        or admitdxpath like  '%Genitourinary%'
        or admitdxpath like  '%Musculoskeletal%'
        or admitdxpath like  '%Hematology%'
        or admitdxpath like  '%Transplant%')
        and admitdxpath not like '%Burn%'
         then 1
        end) as other_adm_diag

        FROM `physionet-data.eicu_crd.admissiondx` admissiondx
        where admitdxpath not in ('admission diagnosis|Elective|No','admission diagnosis|Elective|Yes',
        'admission diagnosis|Was the patient admitted from the O.R. or went to the O.R. within 4 hours of admission?|No',
        'admission diagnosis|Non-operative Organ Systems|Organ System|Cardiovascular',
        'admission diagnosis|Was the patient admitted from the O.R. or went to the O.R. within 4 hours of admission?|Yes',
        'admission diagnosis|Non-operative Organ Systems|Organ System|Neurologic',
        'admission diagnosis|Non-operative Organ Systems|Organ System|Respiratory',
        'admission diagnosis|Operative Organ Systems|Organ System|Cardiovascular',
        'admission diagnosis|Additional APACHE  Information|Thrombolytic Therapy received within 24 hours|No',
        'admission diagnosis|Non-operative Organ Systems|Organ System|Gastrointestinal',
        'admission diagnosis|Operative Organ Systems|Organ System|Gastrointestinal',
        'admission diagnosis|Non-operative Organ Systems|Organ System|Trauma',
        'admission diagnosis|Operative Organ Systems|Organ System|Neurologic',
        'admission diagnosis|Operative Organ Systems|Organ System|Respiratory',
        'admission diagnosis|Patient transferred from another hospital to the current hospital within 48 hours prior to ICU admission|Patient transferred from another hospital to the current hospital within 48 hours prior to ICU admission')
        AND admitdxpath NOT LIKE '%Additional APACHE  Information|%'
        group by patientunitstayid
    )
    --main query
    select

    coalesce((select 1 from  `physionet-data.eicu_crd.patient`  pat_readm 
        where pat_readm.patienthealthsystemstayid=pat.patienthealthsystemstayid 
        and pat_readm.unitvisitnumber=2--pat.unitvisitnumber+1
        and pat_readm.unitstaytype in ('admit', 'readmit')
        and abs((pat_readm.hospitaladmitoffset)+(pat.unitdischargeoffset+ abs(pat.hospitaladmitoffset)))<=72*60
        and abs((pat_readm.hospitaladmitoffset)+(pat.unitdischargeoffset+ abs(pat.hospitaladmitoffset)))>1
        and cast(replace(age,'> 89','89') as int64) >= 18 
        and age <> '' 
        ),null,0) as label_72,

    coalesce((select 1 from  `physionet-data.eicu_crd.patient`  pat_readm 
        where pat_readm.patienthealthsystemstayid=pat.patienthealthsystemstayid 
        and pat_readm.unitvisitnumber=2--pat.unitvisitnumber+1
        and pat_readm.unitstaytype in ('admit', 'readmit')
        and abs((pat_readm.hospitaladmitoffset)+(pat.unitdischargeoffset+ abs(pat.hospitaladmitoffset)))<=48*60
        and abs((pat_readm.hospitaladmitoffset)+(pat.unitdischargeoffset+ abs(pat.hospitaladmitoffset)))>1
        and cast(replace(age,'> 89','89') as int64) >= 18 
        and age <> '' 
        ),null,0) as label_48,

    coalesce((select 1 from  `physionet-data.eicu_crd.patient`  pat_readm 
        where pat_readm.patienthealthsystemstayid=pat.patienthealthsystemstayid 
        and pat_readm.unitvisitnumber=2--pat.unitvisitnumber+1
        and pat_readm.unitstaytype in ('admit', 'readmit')
        and abs((pat_readm.hospitaladmitoffset)+(pat.unitdischargeoffset+ abs(pat.hospitaladmitoffset)))<=168*60
        and abs((pat_readm.hospitaladmitoffset)+(pat.unitdischargeoffset+ abs(pat.hospitaladmitoffset)))>1
        and cast(replace(age,'> 89','89') as int64) >= 18 
        and age <> '' 
        ),null,0) as 
        label_7days, 
        
    coalesce((select 1 from  `physionet-data.eicu_crd.patient`  pat_readm 
        where pat_readm.patienthealthsystemstayid=pat.patienthealthsystemstayid 
        and pat_readm.unitvisitnumber=2--pat.unitvisitnumber+1
        and pat_readm.unitstaytype in ('admit', 'readmit')
        and abs((pat_readm.hospitaladmitoffset)+(pat.unitdischargeoffset+ abs(pat.hospitaladmitoffset)))<=720*60
        and abs((pat_readm.hospitaladmitoffset)+(pat.unitdischargeoffset+ abs(pat.hospitaladmitoffset)))>1
        and cast(replace(age,'> 89','89') as int64) >= 18 
        and age <> '' 
        ),null,0) as label_30days,

    pat.patientunitstayid,
    case when pat.gender='Female' then
        'Female' 
        when pat.gender='Male' then
        'Male'
        when pat.gender='Other' then
        'Other'
        else
        'Unknown'
        end gender,

    cast(case when pat.age='> 89' then
        '90'
        when pat.age='' or pat.age is null then
        '0' -- there is 95 patients with empty age who become age 0
        else 
        pat.age
        end as int64) age,

    /*case when pat.ethnicity='Caucasian' then
        'Caucasian'
        when pat.ethnicity='African American' then
        'African American'
        when (pat.ethnicity='Other/Unknown' or pat.ethnicity is null or pat.ethnicity='') then
        'Other/Unknown' 
        when pat.ethnicity='Hispanic' then
        'Hispanic'
        when pat.ethnicity='Asian' then
        'Asian'
        when pat.ethnicity='Native American' then 
        'Native American'
        end ethnicity,*/

    case when pat.admissionweight > 260 then null 
        else  pat.admissionweight 
        end as admissionweight,

    case when pat.admissionheight > 240 then null 
        else  pat.admissionheight 
        end as admissionheight,

    --contextual data
    abs(pat.hospitaladmitoffset) hospitaladmitoffset,
    
    --EXTRACT(HOUR FROM hospitaladmittime24) as hour,
    
    /*case when (hospitaladmittime24 > TIME(18, 00, 00) and hospitaladmittime24 < TIME(23, 59, 59)) or 
                (hospitaladmittime24 >= TIME(00, 00, 00) and hospitaladmittime24 < TIME(06, 00, 00)) then
        'night'
        else
        'day'
        end admission_part_of_the_day,*/

    case when pat.hospitaladmitsource='Emergency Department' then
        'Emergency Department'
        when pat.hospitaladmitsource in ('ICU', 'Other ICU', 'Step-Down Unit (SDU)', 'PACU', 'ICU to SDU') then
        'ICU'
        when pat.hospitaladmitsource in ('Recovery Room') then
        'Recovery'
        when pat.hospitaladmitsource in ('Other Hospital', 'Chest Pain Center','Direct Admit', 'Other', 'Floor', 'Acute Care/Floor', 'Observation') then
        'Other'
        when pat.hospitaladmitsource='Operating Room' then
        'Operating Room'
        when (pat.hospitaladmitsource is null or pat.hospitaladmitsource='') then 
        'Unknown'
        else
        pat.hospitaladmitsource
        end hospitaladmitsource,
    pat.unittype,

    --hospital data
    pat.hospitalid,
    case when (hosp.numbedscategory is null or hosp.numbedscategory ='') then
        'Unknown'
        else
        hosp.numbedscategory
        end as numbedscategory,

    --lab features
    lab_first_24.aniongap_min_first_24,
    lab_first_24.aniongap_max_first_24,
    lab_first_24.albumin_min_first_24,
    lab_first_24.albumin_max_first_24,
    lab_first_24.bilirubin_min_first_24,
    lab_first_24.bilirubin_max_first_24,
    --lab_first_24.bicarbonate_min_first_24,
    --lab_first_24.bicarbonate_max_first_24,
    lab_first_24.hco3_min_first_24, --This is bicarbonate but less number of null values
    lab_first_24.hco3_max_first_24,--This is bicarbonate but less number of null values
    lab_first_24.creatinine_min_first_24,
    lab_first_24.creatinine_max_first_24,
    lab_first_24.chloride_min_first_24,
    lab_first_24.chloride_max_first_24,
    lab_first_24.glucose_min_first_24,
    lab_first_24.glucose_max_first_24,
    --lab_first_24.hematocrit_min_first_24, --Probably collinear with hemoglobin and has more null values
    --lab_first_24.hematocrit_max_first_24, --Probably collinear with hemoglobin and has more null values
    lab_first_24.hemoglobin_min_first_24,
    lab_first_24.hemoglobin_max_first_24,
    lab_first_24.platelet_min_first_24,
    lab_first_24.platelet_max_first_24,
    lab_first_24.potassium_min_first_24,
    lab_first_24.potassium_max_first_24,
    lab_first_24.sodium_min_first_24,
    lab_first_24.sodium_max_first_24,
    lab_first_24.bun_min_first_24,
    lab_first_24.bun_max_first_24,
    lab_first_24.wbc_min_first_24,
    lab_first_24.wbc_max_first_24,
    lab_first_24.bands_min_first_24,
    lab_first_24.bands_max_first_24,
    lab_first_24.ptt_min_first_24,
    lab_first_24.ptt_max_first_24,
    lab_first_24.inr_min_first_24,
    lab_first_24.inr_max_first_24,
    lab_first_24.pt_min_first_24,
    lab_first_24.pt_max_first_24,
    --lab_first_24.lactate_min_first_24,
    --lab_first_24.lactate_max_first_24,
    --*additional feature Lactate that doesn't have enough values but could be useful 
    case when lab_first_24.lactate_min_first_24 is null then
        0
        when (lab_first_24.lactate_min_first_24>0 and lab_first_24.lactate_min_first_24<=2) then
        1
        when lab_first_24.lactate_min_first_24>2 then
        2
        else
        3
        end cat_min_lactate_first_24,

    case when lab_first_24.lactate_max_first_24 is null then
        0
        when (lab_first_24.lactate_max_first_24>0 and lab_first_24.lactate_max_first_24<=2) then
        1
        when lab_first_24.lactate_max_first_24>2 then
        2
        else
        3
        end cat_max_lactate_first_24,
    lab_last_24.BUN_min_last_24,
    lab_last_24.BUN_max_last_24,
    lab_last_24.calcium_min_last_24,
    lab_last_24.calcium_max_last_24,
    lab_last_24.creatinine_min_last_24,
    lab_last_24.creatinine_max_last_24,
    lab_last_24.glucose_min_last_24,
    lab_last_24.glucose_max_last_24,
    lab_last_24.bicarbonate_min_last_24,
    lab_last_24.bicarbonate_max_last_24,
    lab_last_24.hematocrit_min_last_24,
    lab_last_24.hematocrit_max_last_24,
    lab_last_24.hemoglobin_min_last_24,
    lab_last_24.hemoglobin_max_last_24,
    lab_last_24.platelets_min_last_24,
    lab_last_24.platelets_max_last_24,
    lab_last_24.potassium_min_last_24,
    lab_last_24.potassium_max_last_24,
    lab_last_24.sodium_min_last_24,
    lab_last_24.sodium_max_last_24,
    lab_last_24.wbc_min_last_24,
    lab_last_24.wbc_max_last_24,
    lab_last_24.albumin_min_last_24,
    lab_last_24.albumin_max_last_24,
    lab_last_24.bilirubin_min_last_24,
    lab_last_24.bilirubin_max_last_24,
    lab_last_24.alt_min_last_24,
    lab_last_24.alt_max_last_24,
    lab_last_24.ast_min_last_24,
    lab_last_24.ast_max_last_24,
    lab_last_24.alp_min_last_24,
    lab_last_24.alp_max_last24,
    lab_last_24.INR_min_last_24,
    lab_last_24.INR_max_last_24,
    lab_last_24.ptt_min_last_24,
    lab_last_24.ptt_max_last_24,
    --lab_last_24.lactate_min_last_24,
    --lab_last_24.lactate_max_last_24,
    --*additional feature Lactate that doesn't have enough values but could be useful 
    case when lab_last_24.lactate_min_last_24 is null then
        0
        when (lab_last_24.lactate_min_last_24>0 and lab_last_24.lactate_min_last_24<=2) then
        1
        when lab_last_24.lactate_min_last_24>2 then
        2
        else
        3
        end cat_min_lactate_last_24,

    case when lab_last_24.lactate_max_last_24 is null then
        0
        when (lab_last_24.lactate_max_last_24>0 and lab_last_24.lactate_max_last_24<=2) then
        1
        when lab_last_24.lactate_max_last_24>2 then
        2
        else
        3
        end cat_max_lactate_last_24,
    vitals_first_24.heartrate_min_first_24,
    vitals_first_24.heartrate_max_first_24,
    vitals_first_24.heartrate_avg_first_24,
    vitals_first_24.respiratoryrate_min_first_24,
    vitals_first_24.respiratoryrate_max_first_24,
    vitals_first_24.respiratoryrate_avg_first_24,
    vitals_first_24.spo2_min_first_24,
    vitals_first_24.spo2_max_first_24,
    vitals_first_24.spo2_avg_first_24,
   
    vitals_first_24.nibp_systolic_min_first_24,
    vitals_first_24.nibp_systolic_max_first_24,
    vitals_first_24.nibp_systolic_avg_first_24,
    vitals_first_24.nibp_diastolic_min_first_24,
    vitals_first_24.nibp_diastolic_max_first_24,
    vitals_first_24.nibp_diastolic_avg_first_24,
    vitals_first_24.nibp_mean_min_first_24,
    vitals_first_24.nibp_mean_max_first_24,
    vitals_first_24.nibp_mean_avg_first_24,
    
    vitals_first_24.temperature_min_first_24,
    vitals_first_24.temperature_max_first_24,
    vitals_first_24.temperature_avg_first_24,
    
    ifnull(case when (vitals_first_24.ibp_systolic_min_first_24 is not null or 
    vitals_first_24.ibp_systolic_max_first_24 is not null or 
    vitals_first_24.ibp_systolic_avg_first_24 is not null or 
    vitals_first_24.ibp_diastolic_min_first_24 is not null or 
    vitals_first_24.ibp_diastolic_max_first_24 is not null or 
    vitals_first_24.ibp_diastolic_avg_first_24 is not null or 
    vitals_first_24.ibp_mean_min_first_24 is not null or 
    vitals_first_24.ibp_mean_max_first_24 is not null or 
    vitals_first_24.ibp_mean_avg_first_24 is not null) then 1 end, 0) ibp_first_24,
    
    vitals_last_24.heartrate_min_last_24,
    vitals_last_24.heartrate_max_last_24,
    vitals_last_24.heartrate_avg_last_24,
    vitals_last_24.respiratoryrate_min_last_24,
    vitals_last_24.respiratoryrate_max_last_24,
    vitals_last_24.respiratoryrate_avg_last_24,
    vitals_last_24.spo2_min_last_24,
    vitals_last_24.spo2_max_last_24,
    vitals_last_24.spo2_avg_last_24,
    vitals_last_24.nibp_systolic_min_last_24,
    vitals_last_24.nibp_systolic_max_last_24,
    vitals_last_24.nibp_systolic_avg_last_24,
    vitals_last_24.nibp_diastolic_min_last_24,
    vitals_last_24.nibp_diastolic_max_last_24,
    vitals_last_24.nibp_diastolic_avg_last_24,
    vitals_last_24.nibp_mean_min_last_24,
    vitals_last_24.nibp_mean_max_last_24,
    vitals_last_24.nibp_mean_avg_last_24,
    vitals_last_24.temperature_min_last_24,
    vitals_last_24.temperature_max_last_24,
    vitals_last_24.temperature_avg_last_24,
    
    ifnull(case when (vitals_last_24.ibp_systolic_min_last_24 is not null or 
    vitals_last_24.ibp_systolic_max_last_24 is not null or 
    vitals_last_24.ibp_systolic_avg_last_24 is not null or 
    vitals_last_24.ibp_diastolic_min_last_24 is not null or 
    vitals_last_24.ibp_diastolic_max_last_24 is not null or 
    vitals_last_24.ibp_diastolic_avg_last_24 is not null or 
    vitals_last_24.ibp_mean_min_last_24 is not null or 
    vitals_last_24.ibp_mean_max_last_24 is not null or 
    vitals_last_24.ibp_mean_avg_last_24 is not null) then 1 end, 0) ibp_last_24,
    --cohort_vitals_other_first_24.*,
    --cohort_vitals_other_last_24,

    --co_morbidities
    co_mb.kidney_co_morbidities,
    co_mb.liver_co_morbidities,
    co_mb.stroke_co_morbidities,
    co_mb.CRD_co_morbidities,
    co_mb.heart_failure_co_morbidities,
    co_mb.hematologic_malignancy_co_morbidities,
    co_mb.diabetes_co_morbidities,
    co_mb.asthma_co_morbidities,
    --apache_groups
    apache_groups.apachedxgroup,
    --GCS
    gcs_last_24.gcs_min_last_24,
    gcs_last_24.gcs_max_last_24,
    gcs_last_24.gcs_avg_last_24,
    --
    gcs_first_24.gcs_min_first_24,
    gcs_first_24.gcs_max_first_24,
    gcs_first_24.gcs_avg_first_24,
    
    --creatinine
    --crt_first_24.creatinine_min_first_24,
    --crt_first_24.creatinine_max_first_24,
    crt_first_24.creatinine_avg_first_24,

    --crt_last_24.creatinine_min_last_24,
    --crt_last_24.creatinine_max_last_24,
    crt_last_24.creatinine_avg_last_24,

    --uo
    uo_first_24.outputtotal_max_first_24,
    uo_first_24.outputtotal_min_first_24,
    uo_first_24.outputtotal_avg_first_24,
    uo_first_24.urineoutput_max_first_24,
    uo_first_24.urineoutput_min_first_24,
    uo_first_24.urineoutput_avg_first_24,

    uo_last_24.outputtotal_max_last_24,
    uo_last_24.outputtotal_min_last_24,
    uo_last_24.outputtotal_avg_last_24,
    uo_last_24.urineoutput_max_last_24,
    uo_last_24.urineoutput_min_last_24,
    uo_last_24.urineoutput_avg_last_24,

    --vasopressor
    ifnull(vp_first_24.vasopressor_first_24,0) vasopressors_first_24,
    ifnull(vp_last_24.vasopressor_last_24,0) vasopressors_last_24,

    --bg
    bg_first_24.fio2_max_first_24,
    bg_first_24.fio2_min_first_24,
    bg_first_24.fio2_avg_first_24,
    
    bg_first_24.pao2_max_first_24,
    bg_first_24.pao2_min_first_24,
    bg_first_24.pao2_avg_first_24,
    
    bg_first_24.paco2_max_first_24,
    bg_first_24.paco2_min_first_24,
    bg_first_24.paco2_avg_first_24,
    bg_first_24.ph_max_first_24,
    bg_first_24.ph_min_first_24,
    bg_first_24.ph_avg_first_24,
    --bg_first_24.aniongap_max_first_24,
    --bg_first_24.aniongap_min_first_24,
    bg_first_24.aniongap_avg_first_24,
    --bg_first_24.basedeficit_max_first_24, >90% missing values, likely co-linear with pH/paCO2/HCO3 
    --bg_first_24.basedeficit_min_first_24, >90% missing values, likely co-linear with pH/paCO2/HCO3 
    --bg_first_24.basedeficit_avg_first_24, >90% missing values, likely co-linear with pH/paCO2/HCO3 
    bg_first_24.baseexcess_max_first_24,
    bg_first_24.baseexcess_min_first_24,
    bg_first_24.baseexcess_avg_first_24,
    bg_first_24.peep_max_first_24, --Positive End-Expiratory Pressure (PEEP) 
    bg_first_24.peep_min_first_24,
    bg_first_24.peep_avg_first_24,

    bg_last_24.fio2_max_last_24,
    bg_last_24.fio2_min_last_24,
    bg_last_24.fio2_avg_last_24,
    bg_last_24.pao2_max_last_24,
    bg_last_24.pao2_min_last_24,
    bg_last_24.pao2_avg_last_24,
    bg_last_24.paco2_max_last_24,
    bg_last_24.paco2_min_last_24,
    bg_last_24.paco2_avg_last_24,
    bg_last_24.ph_max_last_24,
    bg_last_24.ph_min_last_24,
    bg_last_24.ph_avg_last_24,
    bg_last_24.aniongap_max_last_24,
    bg_last_24.aniongap_min_last_24,
    bg_last_24.aniongap_avg_last_24,
    bg_last_24.basedeficit_max_last_24,
    bg_last_24.basedeficit_min_last_24,
    bg_last_24.basedeficit_avg_last_24,
    bg_last_24.baseexcess_max_last_24,
    bg_last_24.baseexcess_min_last_24,
    bg_last_24.baseexcess_avg_last_24,
    bg_last_24.peep_max_last_24,
    bg_last_24.peep_min_last_24,
    bg_last_24.peep_avg_last_24,
    --nutrition
    ifnull(nut_first_24.npo_first_24,0) npo_first_24,
    ifnull(nut_first_24.other_nutrition_first_24,0) other_nutrition_first_24,
    ifnull(nut_last_24.npo_last_24,0)  npo_last_24,
    ifnull(nut_last_24.other_nutrition_last_24,0) other_nutrition_last_24,
    --dialisis
    ifnull(dial_first_24.d_first_24,0) dialysis_first_24,
    ifnull(dial_last_24.d_last_24,0) dialysis_last_24,
    --ventilation
    ifnull(vent_last_24.mech_vent_last_24,0) mech_vent_last_24,
    ifnull(vent_last_24.NIV_last_24,0) NIV_last_24,
    ifnull(ven_first_24.mech_vent_first_24,0) mech_vent_first_24,
    ifnull(ven_first_24.NIV_first_24,0) NIV_first_24,
    --APACHE
    case when apachepredvar.bedcount = -1 then null else apachepredvar.bedcount end as bedcount_apache_pred_var,
    case when apachepredvar.admitSource = -1 then null else apachepredvar.admitSource end as  admitSource_apache_pred_var,
    case when apachepredvar.graftCount = -1 then null else apachepredvar.graftCount end as graftCount_apache_pred_var,
    --case when apachepredvar.meds = -1 then null else apachepredvar.meds end as meds_apache_pred_var,
    --case when apachepredvar.verbal = -1 then null else apachepredvar.verbal end as verbal_apache_pred_var,
    --case when apachepredvar.motor = -1 then null else  apachepredvar.motor end as motor_apache_pred_var,
    --case when apachepredvar.eyes = -1 then null else apachepredvar.eyes end as eyes_apache_pred_var,
    --apachepredvar.age age_apache_pred_var,
    --case when (apachepredvar.admitdiagnosis is null or apachepredvar.admitdiagnosis='') then 
    --    'Unknown'
    --    else
    --    admitdiagnosis
    --    end
    --    as admitdiagnosis_apache_pred_var,  
    --    as admitdiagnosis_apache_pred_var,  
    apachepredvar.thrombolytics thrombolytics_apache_pred_var,
    --apachepredvar.diedinhospital diedinhospital_apache_pred_var,
    apachepredvar.aids aids_apache_pred_var,
    apachepredvar.hepaticfailure hepaticfailure_apache_pred_var,
    apachepredvar.lymphoma lymphoma_apache_pred_var,
    apachepredvar.metastaticcancer metastaticcancer_apache_pred_var,
    apachepredvar.leukemia leukemia_apache_pred_var,
    apachepredvar.immunosuppression immunosuppression_apache_pred_var,
    apachepredvar.cirrhosis cirrhosis_apache_pred_var,
    apachepredvar.electivesurgery electivesurgery_apache_pred_var,
    apachepredvar.activetx activetx_apache_pred_var,
    --apachepredvar.readmit readmit_apache_pred_var,
    apachepredvar.ima ima_apache_pred_var,
    apachepredvar.midur midur_apache_pred_var,
    apachepredvar.ventday1 ventday1_apache_pred_var,
    apachepredvar.oobventday1 oobventday1_apache_pred_var,
    apachepredvar.oobintubday1 oobintubday1_apache_pred_var,
    apachepredvar.diabetes diabetes_apache_pred_var,
    --apachepredvar.managementsystem managementsystem_apache_pred_var,  --Not used according documentation
    --apachepredvar.var03hspxlos var03hspxlos_apache_pred_var, --Not used according documentation
    case when apachepredvar.pao2 = -1 then null else apachepredvar.pao2 end as pao2_apache_pred_var,
    case when apachepredvar.fio2 = -1 then null else apachepredvar.fio2 end as fio2_apache_pred_var,
    case when apachepredvar.ejectfx = -1 then null else apachepredvar.ejectfx end as ejectfx_apache_pred_var,
    case when apachepredvar.creatinine = -1 then null else apachepredvar.creatinine end as creatinine_apache_pred_var,
    --apachepredvar.dischargelocation dischargelocation_apache_pred_var,
    --case when apachepredvar.visitnumber = -1 then null else apachepredvar.visitnumber end as visitnumber_apache_pred_var,
    case when apachepredvar.amilocation = -1 then null else apachepredvar.amilocation end as amilocation_apache_pred_var, 
    case when apachepredvar.day1meds = -1 then null else apachepredvar.day1meds end as day1meds_apache_pred_var,
    case when apachepredvar.day1verbal = -1 then null else apachepredvar.day1verbal end as day1verbal_apache_pred_var,
    case when apachepredvar.day1motor = -1 then null else apachepredvar.day1motor end as day1motor_apache_pred_var,
    
    case when apachepredvar.day1eyes = -1 then null else apachepredvar.day1eyes end as  day1eyes_apache_pred_var,
    case when apachepredvar.day1pao2 = -1 then null else apachepredvar.day1pao2 end as  day1pao2_apache_pred_var,
    case when apachepredvar.day1fio2 = -1 then null else apachepredvar.day1fio2 end as  day1fio2_apache_pred_var,

    --APACHE IVa
    --case when (apache_IVa.physicianspeciality_APACHE_IVa is null or apache_IVa.physicianspeciality_APACHE_IVa='') then
    --    'unknown'
    --    else
    --    apache_IVa.physicianspeciality_APACHE_IVa
    --    end as
    --    physicianspeciality_APACHE_IVa, 
    --case when (apache_IVa.physicianinterventioncategory_APACHE_IVa is null or apache_IVa.physicianinterventioncategory_APACHE_IVa ='') then 
    --    'Unknown'
    --    else
    --    apache_IVa.physicianinterventioncategory_APACHE_IVa
    --    end physicianinterventioncategory_APACHE_IVa, 
    case when apache_IVa.acutephysiologyscore_APACHE_IVa = -1 then null else apache_IVa.acutephysiologyscore_APACHE_IVa end as acutephysiologyscore_APACHE_IVa,
    case when apache_IVa.apachescore_APACHE_IVa = -1 then null else apache_IVa.apachescore_APACHE_IVa end as apachescore_APACHE_IVa,
    case when apache_IVa.predictedicumortality_APACHE_IVa = -1  then null else 
    round(apache_IVa.predictedicumortality_APACHE_IVa, 4)  end as predictedicumortality_APACHE_IVa,
    case when apache_IVa.predictediculos_APACHE_IVa = -1 then null else 
    round(apache_IVa.predictediculos_APACHE_IVa, 2) end as predictediculos_APACHE_IVa,
    --apache_IVa.predictedhospitalmortality_APACHE_IVa,
    case when apache_IVa.predictedhospitallos_APACHE_IVa = -1 then null else 
    round(apache_IVa.predictedhospitallos_APACHE_IVa, 2) end as predictedhospitallos_APACHE_IVa,
    apache_IVa.preopmi_APACHE_IVa,
    apache_IVa.preopcardiaccath_APACHE_IVa,
    apache_IVa.ptcawithin24h_APACHE_IVa,
    round(apache_IVa.unabridgedunitlos_APACHE_IVa,2) unabridgedunitlos_APACHE_IVa,
    --apache_IVa.unabridgedhosplos_APACHE_IVa,
    round(apache_IVa.predventdays_APACHE_IVa, 2) predventdays_APACHE_IVa,
    
    --variables for calc.APACHE
    apache_var.intubated intubated_apache_var,
    apache_var.vent  vent_apache_var,
    apache_var.dialysis dialysis_apache_var,
    
    case when apache_var.eyes = -1 then null else apache_var.eyes end as eyes_apache_var,    
    case when apache_var.motor = -1 then null else apache_var.motor end as  motor_apache_var,
    case when apache_var.verbal = -1 then null else apache_var.verbal end as verbal_apache_var,    
    case when apache_var.meds = -1 then null else apache_var.meds end as meds_apache_var,    
    
    case when apache_var.urine = -1 then null else round(apache_var.urine,2) end as urine_apache_var,
    case when apache_var.wbc = -1 then null else apache_var.wbc end as wbc_apache_var,
    case when apache_var.temperature = -1 then null else apache_var.temperature end as  temperature_apache_var,
    case when apache_var.respiratoryrate = -1 then null else apache_var.respiratoryrate end as respiratoryrate_apache_var,
    case when apache_var.sodium = -1 then null else apache_var.sodium end as sodium_apache_var,
    case when apache_var.heartrate = -1 then null else apache_var.heartrate end as heartrate_apache_var,
    case when apache_var.meanbp = -1 then null else apache_var.meanbp end as meanbp_apache_var,
    case when apache_var.ph = -1 then null else apache_var.ph end as ph_apache_var,
    case when apache_var.hematocrit = -1 then null else apache_var.hematocrit end as hematocrit_apache_var,
    case when apache_var.creatinine = -1 then null else apache_var.creatinine end as creatinine_apache_var,
    case when apache_var.albumin = -1 then null else apache_var.albumin end as albumin_apache_var,
    case when apache_var.pao2 = -1 then null else apache_var.pao2 end as pao2_apache_var,
    case when apache_var.pco2 = -1 then null else apache_var.pco2 end as pco2_apache_var,
    case when apache_var.bun = -1 then null else apache_var.bun end as bun_apache_var,
    case when apache_var.glucose = -1 then null else apache_var.glucose end as glucose_apache_var,
    case when apache_var.bilirubin = -1 then null else apache_var.bilirubin end as bilirubin_apache_var,
    case when apache_var.fio2 = -1 then null else apache_var.fio2 end as fio2_apache_var,
    
    
    case when adm_elect.patientunitstayid is not null then
    1
    else
    0 
    end as elective_adm_diagnosis,  
    
    case when adm_elect_no.patientunitstayid is not null then
    1
    else
    0 
    end as not_elective_adm_diagnosis,  
    case when non_oper.patientunitstayid is not null then
    1
    else
    0 
    end as non_oper_adm_diag,  
    case when oper.patientunitstayid is not null then
    1
    else
    0 
    end as oper_adm_diag,
    
    ifnull(grp_adm_diag.sepsis_adm_diag,0) sepsis_adm_diag,
    ifnull(cardiovascular_adm_diag,0) cardiovascular_adm_diag,
    ifnull(respiratory_adm_diag,0) respiratory_adm_diag,
    ifnull(gastrointestinal_adm_diag,0) gastrointestinal_adm_diag,
    ifnull(neurologic_adm_diag,0) neurologic_adm_diag,
    ifnull(trauma_adm_diag,0) trauma_adm_diag,
    ifnull(other_adm_diag,0) other_adm_diag
    

    from `physionet-data.eicu_crd.patient` pat
    left join lab_first_24
        on pat.patientunitstayid = lab_first_24.patientunitstayid  
    left join lab_last_24
        on pat.patientunitstayid = lab_last_24.patientunitstayid 
    left join vitals_last_24
        on pat.patientunitstayid = vitals_last_24.patientunitstayid 
    left join vitals_first_24
        on pat.patientunitstayid = vitals_first_24.patientunitstayid 
    left join cohort_vitals_other_last_24
        on pat.patientunitstayid = cohort_vitals_other_last_24.patientunitstayid 
    left join cohort_vitals_other_first_24
        on pat.patientunitstayid = cohort_vitals_other_first_24.patientunitstayid 
    left join `physionet-data.eicu_crd.hospital` hosp
        on pat.hospitalid=hosp.hospitalid 
    left join co_morbidities co_mb
        on pat.patientunitstayid = co_mb.patientunitstayid 
    left join `physionet-data.eicu_crd_derived.apache_groups` apache_groups
        on pat.patientunitstayid =apache_groups.patientunitstayid
    left join gcs_last_24 gcs_last_24
        on pat.patientunitstayid = gcs_last_24.patientunitstayid
    left join gcs_first_24 gcs_first_24
        on pat.patientunitstayid = gcs_first_24.patientunitstayid
    left join creatinine_first_24 crt_first_24
        on pat.patientunitstayid = crt_first_24.patientunitstayid
    left join creatinine_last_24 crt_last_24
        on pat.patientunitstayid = crt_last_24.patientunitstayid
    left join urine_output_first_24 uo_first_24
        on pat.patientunitstayid = uo_first_24.patientunitstayid
    left join urine_output_last_24 uo_last_24
        on pat.patientunitstayid = uo_last_24.patientunitstayid
    left join vasopressor_first_24 vp_first_24
        on pat.patientunitstayid = vp_first_24.patientunitstayid
    left join  vasopressor_last_24 vp_last_24
        on pat.patientunitstayid = vp_last_24.patientunitstayid
    left join blood_gas_first_24 bg_first_24
        on pat.patientunitstayid = bg_first_24.patientunitstayid
    left join blood_gas_last_24 bg_last_24
        on pat.patientunitstayid = bg_last_24.patientunitstayid
    left join nutrition_first_24 nut_first_24
        on pat.patientunitstayid = nut_first_24.patientunitstayid
    left join nutrition_last_24 nut_last_24
        on pat.patientunitstayid = nut_last_24.patientunitstayid
    left join dialysis_first_24 dial_first_24
        on pat.patientunitstayid = dial_first_24.patientunitstayid
    left join dialysis_last_24 dial_last_24
        on pat.patientunitstayid = dial_last_24.patientunitstayid
    left join ventilation_last_24 vent_last_24
        on pat.patientunitstayid = vent_last_24.patientunitstayid
    left join ventilation_first_24 ven_first_24
        on pat.patientunitstayid = ven_first_24.patientunitstayid
    left join  `physionet-data.eicu_crd.apachepredvar` apachepredvar
        on pat.patientunitstayid = apachepredvar.patientunitstayid
    left join apache_IVa apache_IVa
        on pat.patientunitstayid = apache_IVa.patientunitstayid
    left join `physionet-data.eicu_crd.apacheapsvar` apache_var
        on pat.patientunitstayid = apache_var.patientunitstayid
    left join admint_diag_elective_yes adm_elect
        on pat.patientunitstayid = adm_elect.patientunitstayid
    left join admint_diag_elective_no adm_elect_no
        on pat.patientunitstayid = adm_elect_no.patientunitstayid
    left join non_operative_adm_diag non_oper
        on pat.patientunitstayid = non_oper.patientunitstayid
    left join operative_adm_diag oper
        on pat.patientunitstayid = oper.patientunitstayid
    left join group_of_adm_diag grp_adm_diag
        on pat.patientunitstayid = grp_adm_diag.patientunitstayid    
        

    where pat.unitstaytype in ('admit', 'readmit') --resolve problem with 0 diff.between admissions
    and pat.hospitaldischargeoffset>4 -- exclusion too short staying
    --exclusions:
    --1.count only first admission to icu
    and pat.unitvisitnumber=1 
    --2.age <18 + 98 patients without information about age
    and cast(replace(pat.age,'> 89','90') as int64) >= 18 
    and pat.age <> '' 
    --3.‘do not resuscitate’(dnr) and ‘comfort measures only’(cmo)at discharge
    and not exists (select 1
                    from `physionet-data.eicu_crd.careplangeneral` cplan   
                    where pat.patientunitstayid= cplan.patientunitstayid  and  cplan.cplitemvalue in ('Comfort measures only'))--)
