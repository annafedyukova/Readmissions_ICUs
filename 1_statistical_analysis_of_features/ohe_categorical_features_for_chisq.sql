SELECT 

label_72,
label_48,
label_7days,
label_30days,

case when gender='Male' then 1 else 0 end gender,

case when hospitaladmitsource='Emergency Department'then 1 else 0 end hospitaladmitsource_ED,
case when hospitaladmitsource='Recovery'then 1 else 0 end hospitaladmitsource_Recovery,
case when hospitaladmitsource='ICU'then 1 else 0 end hospitaladmitsource_ICU,
case when hospitaladmitsource='Operating Room'then 1 else 0 end hospitaladmitsource_Operating_Room,
case when hospitaladmitsource='Other'then 1 else 0 end hospitaladmitsource_Other,
case when hospitaladmitsource='Unknown'then 1 else 0 end hospitaladmitsource_Unknown,

case when unittype='Med-Surg ICU'then 1 else 0 end unittype_Med_Surg_ICU,
case when unittype='Cardiac ICU'then 1 else 0 end unittype_Cardiac_ICU,
case when unittype='CCU-CTICU'then 1 else 0 end unittype_CCU_CTICU,
case when unittype='SICU'then 1 else 0 end unittype_SICU,
case when unittype='Neuro ICU'then 1 else 0 end unittype_Neuro_ICU,
case when unittype='MICU'then 1 else 0 end unittype_MICU,
case when unittype='CSICU'then 1 else 0 end unittype_CSICU,
case when unittype='CTICU'then 1 else 0 end unittype_CTICU,
--hospitalid,--contants 208 hosp

case when numbedscategory='100 - 249'then 1 else 0 end numbedscategory_100_249,
case when numbedscategory='<100'then 1 else 0 end numbedscategory_100_and_less,
case when numbedscategory='250 - 499'then 1 else 0 end numbedscategory_250_499,
case when numbedscategory='>= 500'then 1 else 0 end numbedscategory_500_and_more,
case when numbedscategory='Unknown'then 1 else 0 end numbedscategory_Unknown,

case when cat_min_lactate_first_24=0 then 1 else 0 end cat_min_lactate_first_24_0,
case when cat_min_lactate_first_24=1 then 1 else 0 end cat_min_lactate_first_24_1,
case when cat_min_lactate_first_24=2 then 1 else 0 end cat_min_lactate_first_24_2,

case when cat_max_lactate_first_24=0 then 1 else 0 end cat_max_lactate_first_24_0,
case when cat_max_lactate_first_24=1 then 1 else 0 end cat_max_lactate_first_24_1,
case when cat_max_lactate_first_24=2 then 1 else 0 end cat_max_lactate_first_24_2,

case when cat_max_lactate_first_24=0 then 1 else 0 end cat_max_lactate_first_24_0,
case when cat_max_lactate_first_24=1 then 1 else 0 end cat_max_lactate_first_24_1,
case when cat_max_lactate_first_24=2 then 1 else 0 end cat_max_lactate_first_24_2,

case when cat_min_lactate_last_24=0 then 1 else 0 end cat_min_lactate_last_24_0,
case when cat_min_lactate_last_24=1 then 1 else 0 end cat_min_lactate_last_24_1,
case when cat_min_lactate_last_24=2 then 1 else 0 end cat_min_lactate_last_24_2,

case when cat_max_lactate_last_24=0 then 1 else 0 end cat_max_lactate_last_24_0,
case when cat_max_lactate_last_24=1 then 1 else 0 end cat_max_lactate_last_24_1,
case when cat_max_lactate_last_24=2 then 1 else 0 end cat_max_lactate_last_24_2,

case when apachedxgroup='Other' then 1 else 0 end apachedxgroup_Other,
case when apachedxgroup='PNA' then 1 else 0 end apachedxgroup_PNA,
case when apachedxgroup='Sepsis' then 1 else 0 end apachedxgroup_Sepsis,
case when apachedxgroup='ValveDz' then 1 else 0 end apachedxgroup_ValveDz,
case when apachedxgroup='RespMedOther' then 1 else 0 end apachedxgroup_RespMedOther,
case when apachedxgroup='CHF' then 1 else 0 end apachedxgroup_CHF,
case when apachedxgroup='CardiacArrest' then 1 else 0 end apachedxgroup_CardiacArrest,
case when apachedxgroup='ARF' then 1 else 0 end apachedxgroup_ARF,
case when apachedxgroup='Overdose' then 1 else 0 end apachedxgroup_Overdose,
case when apachedxgroup='Asthma-Emphys' then 1 else 0 end apachedxgroup_Asthma_Emphys,
case when apachedxgroup='ACS' then 1 else 0 end apachedxgroup_ACS,
case when apachedxgroup='Coma' then 1 else 0 end apachedxgroup_Coma,
case when apachedxgroup='Neuro' then 1 else 0 end apachedxgroup_Neuro,
case when apachedxgroup='DKA' then 1 else 0 end apachedxgroup_DKA,
case when apachedxgroup='CABG' then 1 else 0 end apachedxgroup_CABG,
case when apachedxgroup='GIBleed' then 1 else 0 end apachedxgroup_GIBleed,
case when apachedxgroup='ChestPainUnknown' then 1 else 0 end apachedxgroup_ChestPainUnknown,
case when apachedxgroup='CVOther' then 1 else 0 end apachedxgroup_CVOther,
case when apachedxgroup='Trauma' then 1 else 0 end apachedxgroup_Trauma,
case when apachedxgroup='GIObstruction' then 1 else 0 end apachedxgroup_GIObstruction,
case when apachedxgroup='CVA' then 1 else 0 end apachedxgroup_CVA,

case when visitnumber_apache_pred_var=1 then 1 else 0 end visitnumber_apache_pred_var,



FROM `learned-vortex-290901.readmissons.readmission_cohort_checked_features` 

