#libraries
#install.packages("plyr")
library(plyr)
library(dplyr)
# read files
readm_num_var<-read.csv(file='eICU_readmission_280122.csv')
# create two subgroups:readm/noreadm 
#for numerical var
no_readmission<-subset(readm_num_var, label_30days==0)
readmission<-subset(readm_num_var, label_30days==1)

#column for t-test

col_names_ttest<-c('gcs_min_last_24','gcs_max_last_24','gcs_avg_last_24','gcs_min_first_24','gcs_max_first_24','gcs_avg_first_24','creatinine_avg_first_24','creatinine_avg_last_24','outputtotal_max_first_24','outputtotal_min_first_24','outputtotal_avg_first_24','urineoutput_max_first_24','urineoutput_min_first_24','urineoutput_avg_first_24','outputtotal_max_last_24','outputtotal_min_last_24','outputtotal_avg_last_24','urineoutput_max_last_24','urineoutput_min_last_24','urineoutput_avg_last_24','fio2_max_first_24','fio2_min_first_24','fio2_avg_first_24','pao2_max_first_24','pao2_min_first_24','pao2_avg_first_24','paco2_max_first_24','paco2_min_first_24','paco2_avg_first_24','ph_max_first_24','ph_min_first_24','ph_avg_first_24','aniongap_avg_first_24','baseexcess_max_first_24','baseexcess_min_first_24','baseexcess_avg_first_24','peep_max_first_24','peep_min_first_24','peep_avg_first_24','fio2_max_last_24','fio2_min_last_24','fio2_avg_last_24','pao2_max_last_24','pao2_min_last_24','pao2_avg_last_24','paco2_max_last_24','paco2_min_last_24','paco2_avg_last_24','ph_max_last_24','ph_min_last_24','ph_avg_last_24','aniongap_max_last_24','aniongap_min_last_24','aniongap_avg_last_24','basedeficit_max_last_24','basedeficit_min_last_24','basedeficit_avg_last_24','baseexcess_max_last_24','baseexcess_min_last_24','baseexcess_avg_last_24','peep_max_last_24','peep_min_last_24','peep_avg_last_24','bedcount_apache_pred_var','admitSource_apache_pred_var','graftCount_apache_pred_var','meds_apache_pred_var','verbal_apache_pred_var','motor_apache_pred_var','eyes_apache_pred_var','age_apache_pred_var','pao2_apache_pred_var','fio2_apache_pred_var','ejectfx_apache_pred_var','creatinine_apache_pred_var','amilocation_apache_pred_var','day1verbal_apache_pred_var','day1motor_apache_pred_var','day1eyes_apache_pred_var','day1pao2_apache_pred_var','day1fio2_apache_pred_var','acutephysiologyscore_APACHE_IVa','apachescore_APACHE_IVa','predictedicumortality_APACHE_IVa','predictediculos_APACHE_IVa','predictedhospitallos_APACHE_IVa','unabridgedunitlos_APACHE_IVa','predventdays_APACHE_IVa','eyes_apache_var','motor_apache_var','verbal_apache_var','urine_apache_var','wbc_apache_var','temperature_apache_var','respiratoryrate_apache_var','sodium_apache_var','heartrate_apache_var','meanbp_apache_var','ph_apache_var','hematocrit_apache_var','creatinine_apache_var','albumin_apache_var','pao2_apache_var','pco2_apache_var','bun_apache_var','glucose_apache_var','bilirubin_apache_var','fio2_apache_var'
)
#results
results_ttest_eICU_num_features<-ldply(
  col_names_ttest,
  function(colname)
  {p_val_ttest=t.test(readm_num_var[[colname]]~readm_num_var$label_30days)$p.value
  p_val_wilcox=wilcox.test(readm_num_var[[colname]]~readm_num_var$label_30days)$p.value
  #statistic for readmitted subgroup
  mean_readm = mean(readmission[[colname]], na.rm=TRUE)
  median_readm = median(readmission[[colname]], na.rm=TRUE)
  sd_readm = sd(readmission[[colname]], na.rm=TRUE)
  #statistic for not readmitted subgroup
  mean_not_readm = mean(no_readmission[[colname]], na.rm=TRUE)
  median_not_readm = median(no_readmission[[colname]], na.rm=TRUE)
  sd_not_readm = sd(no_readmission[[colname]], na.rm=TRUE)
  #dataframe
  return(data.frame(colname=colname, 
                    mean_readm=mean_readm, 
                    median_readm=median_readm,
                    sd_readm=sd_readm,
                    mean_not_readm=mean_not_readm,
                    median_not_readm=median_not_readm,
                    sd_not_readm=sd_not_readm,
                    p_val_ttest=p_val_ttest,
                    p_val_wilcox=p_val_wilcox))
  }
)

write.csv(results_ttest_eICU_num_features,'C:\\Users\\fedyu\\Desktop\\UoM\\Semester_summer\\Readmissions\\2801_2022\\readm_t_test_eICU.csv')


col_names_chisq<-c('ibp_first_24','ibp_last_24','kidney_co_morbidities','liver_co_morbidities','stroke_co_morbidities','CRD_co_morbidities','heart_failure_co_morbidities','hematologic_malignancy_co_morbidities','diabetes_co_morbidities','asthma_co_morbidities','vasopressors_first_24','vasopressors_last_24','npo_first_24','other_nutrition_first_24','npo_last_24','other_nutrition_last_24','dialysis_first_24','dialysis_last_24','mech_vent_last_24','NIV_last_24','mech_vent_first_24','NIV_first_24','meds_apache_pred_var','thrombolytics_apache_pred_var','aids_apache_pred_var','hepaticfailure_apache_pred_var','lymphoma_apache_pred_var','metastaticcancer_apache_pred_var','leukemia_apache_pred_var','immunosuppression_apache_pred_var','cirrhosis_apache_pred_var','electivesurgery_apache_pred_var','activetx_apache_pred_var','ima_apache_pred_var','midur_apache_pred_var','ventday1_apache_pred_var','oobventday1_apache_pred_var','oobintubday1_apache_pred_var','diabetes_apache_pred_var','day1meds_apache_pred_var','preopmi_APACHE_IVa','preopcardiaccath_APACHE_IVa','ptcawithin24h_APACHE_IVa','intubated_apache_var','vent_apache_var','dialysis_apache_var','meds_apache_var','elective_adm_diagnosis','not_elective_adm_diagnosis','non_oper_adm_diag','oper_adm_diag','sepsis_adm_diag','cardiovascular_adm_diag','respiratory_adm_diag','gastrointestinal_adm_diag','neurologic_adm_diag','trauma_adm_diag','other_adm_diag')

results_chisq_eICU<-ldply(
  col_names_chisq,
  function(colname)
  {
    p_val=chisq.test(readm_num_var[[colname]],readm_num_var$label_30days)$p.value
    
    perc_readm = (sum(na.omit(readmission[[colname]]))/length(na.omit(readmission[[colname]])) )*100
    perc_no_ream = (sum(na.omit(no_readmission[[colname]]))/length(na.omit(no_readmission[[colname]])) )*100
    abs_num_readm = sum(na.omit(readmission[[colname]]))
    abs_num_no_readm =sum(na.omit(no_readmission[[colname]]))
    return(data.frame(colname=colname,
                      perc_readm=round(perc_readm,2), 
                      abs_num_readm=abs_num_readm,
                      perc_no_ream=round(perc_no_ream,2),
                      abs_num_no_readm=abs_num_no_readm,
                      p_val=p_val
    ))
  }
)

write.csv(results_chisq_eICU,'C:\\Users\\fedyu\\Desktop\\UoM\\Semester_summer\\Readmissions\\2801_2022\\readm_chisq_eICU.csv')

