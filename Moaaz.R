#Intoducation ---------------

# Project Title: Public Health visualization of Chicago city.
# Description: This project aims to provide visualization for the healthcare authorities in Chicago city in the USA
#               by providing up to date visualization of the data with the ability to make comparison across different
#               areas of the city with just a button click thus promoting the ability to better allocate resources and 
#               research to the most required place.
# Author: Moaaz Elhadad.
# Date: 2024-02-06.
# Version: 1.0.

#installing pakages-------------
install.packages(c("ggplot2"   ,
                   "janitor"   ,
                   "shiny"     ,
                   "pacman"    , 
                   "tidyverse" ,
                   "rio"       ,
                   "here"      ,
                   "gtsummary" ,
                   "skimr"     ,
                   "dplyr"     ,
                   "rsconnect"))


#loading packages---------------------
pacman::p_load(rio      , 
               here     , 
               ggplot2  , 
               janitor  , 
               shiny    , 
               pacman   , 
               tidyverse,
               gtsummary, 
               skimr    ,
               dplyr    )



# importing the data -----------------
Chigaco_data <- import(here("public_health.csv"))

#cleaning the data ------------------
Chigaco_data_cleaned <- Chigaco_data %>%
  clean_names() %>%
  rename("Birth Weight"   = "low_birth_weight"                           ,
         "Fertility Rate" = "general_fertility_rate"                     ,
         "Prostate cancer" = "prostate_cancer_in_males"                  ,
         "Birth Rate" = "birth_rate"                                     , 
         "Prenatal Care" = "prenatal_care_beginning_in_first_trimester"  ,
         "Preterm Births" = "preterm_births"                             ,
         "Teen Birth" =  "teen_birth_rate"                               ,                          
         "Homocide" = "assault_homicide"                                 ,
         "Breast Cancer in Females" = "breast_cancer_in_females"         ,
         "Cancer in all sites" = "cancer_all_sites"                      ,
         "Colorectal cancer" = "colorectal_cancer"                       ,
         "Diabetes related Cancer" = "diabetes_related"                  ,
         "Firearm related Homocide" = "firearm_related"                  ,
         "Infant Mortality Rate" = "infant_mortality_rate"               ,
         "Lung Cancer" = "lung_cancer"                                   ,
         "Strockes and CVS" = "stroke_cerebrovascular_disease"           ,
         "Child Lead Level" =   "childhood_blood_lead_level_screening"   ,
         "Child Lead Poisining" = "childhood_lead_poisoning"             ,
         "Gonorrhea Females" =  "gonorrhea_females"                      ,
         "Gonorrhea Males" = "gonorrhea_males"                           ,
         "Tuberculosis T.B" =  "tuberculosis"                            ,
         "People below Poverty Level" =  "below_poverty_level"           ,
         "Crowded Housing" =  "crowded_housing"                          ,
         "Dependency" = "dependency"                                     ,
         "Education Level below High School" =  "no_high_school_diploma" ,
         "Income per Capita" = "per_capita_income"                       ,
         "Unemployment Rate" = "unemployment_rate"                       ) 

