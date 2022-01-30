#libraries
#install.packages("plyr")
library(plyr)
library(dplyr)
# read files
readm_num_var<-read.csv(file='eICU_numerical_var.csv')
readm_bool_var<-read.csv(file='eICU_boolean_var.csv')
#colnames(readm_bool_var)
# create two subgroups:readm/noreadm 
#for numerical var
no_readmission<-subset(readm_num_var, label_30days==0)
readmission<-subset(readm_num_var, label_30days==1)

#column for t-test
col_names_ttest<-c("BMI" ,"age", "apachescore_APACHE_IVa", "los_icu", "los_hosp" )
#results
results_ttest_eICU<-ldply(
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
                    mean_readm=round(mean_readm,2), 
                    median_readm=round(median_readm,2),
                    sd_readm=round(sd_readm,2),
                    mean_not_readm=round(mean_not_readm,2),
                    median_not_readm=round(median_not_readm,2),
                    sd_not_readm=round(sd_not_readm,2),
                    p_val_ttest=p_val_ttest,
                    p_val_wilcox=p_val_wilcox))
  }
)

#t.test(readm_num_var$actualhospitallos~readm_num_var$label_30days)

#columns for chisq.test

no_readmission_bool<-subset(readm_bool_var, label_30days==0)
readmission_bool<-subset(readm_bool_var, label_30days==1)

#columns exclusin: 'x' and 'y' must have at least 2 levels:
#"admsource_RR","admsource_DirectAdmit", "admsource_unknown"


col_names_chisq<-c("gender_female","gender_male","cardiovascular_adm_diag", "neurologic_adm_diag"
                   ,"gastrointestinal_adm_diag", "trauma_adm_diag", "respiratory_adm_diag", "other_adm_diag"
                   ,"utype_Med_Surg_ICU","utype_Cardiac_ICU","utype_CCU_CTICU","utype_SICU","utype_Neuro_ICU"
                   ,"utype_MICU","utype_CSICU","utype_CTICU","numbed_100_249","numbed_less_100","numbed_250_499"
                   ,"numbed_unknown","numbed_500_or_more","teachingstatus","admsource_ICU" ,"admsource_Ope_Room"
                   ,"admsource_ED","admsource_other","mech_vent_first_24" ,"vasopressors_first_24","dialysis_first_24"
                   ,"mortality","discharge_home","discharge_SNF","discharge_other_hosp","discharge_rehab"
                   ,"discharge_nurs_home","discharge_other_extern")

results_chisq_eICU<-ldply(
  col_names_chisq,
  function(colname)
  {
    p_val=chisq.test(readm_bool_var[[colname]],readm_bool_var$label_30days)$p.value
  
    perc_readm = (sum(na.omit(readmission_bool[[colname]]))/length(na.omit(readmission_bool[[colname]])) )*100
    perc_no_ream = (sum(na.omit(no_readmission_bool[[colname]]))/length(na.omit(no_readmission_bool[[colname]])) )*100
    abs_num_readm = sum(na.omit(readmission_bool[[colname]]))
    abs_num_no_readm =sum(na.omit(no_readmission_bool[[colname]]))
    return(data.frame(colname=colname,
                      perc_readm=round(perc_readm,2), 
                      abs_num_readm=abs_num_readm,
                      perc_no_ream=round(perc_no_ream,2),
                      abs_num_no_readm=abs_num_no_readm,
                      p_val=p_val
                      ))
    }
)

write.csv(results_chisq_eICU,'C:\\Users\\fedyu\\Desktop\\UoM\\Semester_summer\\Readmissions\\R_scripts\\results_chisq_eICU.csv')
write.csv(results_ttest_eICU,'C:\\Users\\fedyu\\Desktop\\UoM\\Semester_summer\\Readmissions\\R_scripts\\results_ttest_eICU.csv')