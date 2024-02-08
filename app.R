
install.packages("pacman")
pacman::p_load(rio, here, ggplot2, janitor, shiny, tidyverse, gtsummary, skimr, dplyr)

source("Moaaz.R") 


# Import data
Chigaco_data <- import(here("public_health.csv"))

# Clean the data
Chigaco_data_cleaned <- Chigaco_data %>%
  clean_names() %>%
  rename("Birth weight"   = "low_birth_weight"                           ,
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


# Introduction text
introduction_text <- "
# Project Title: Public Health Visualization of Chicago City
# Description: This project aims to provide visualization for the healthcare authorities in Chicago city in the USA
#               by providing up-to-date visualization of the data with the ability to make comparisons across different
#               areas of the city with just a button click, thus promoting the ability to better allocate resources and 
#               research to the most required place.
# Author: Moaaz Elhadad.
# Date: 2024-02-06.
# Version: 1.0.
"

#shiny ------------------

# Define UI
ui <- fluidPage(
  titlePanel("Variable Viewer by Community Area"),
  sidebarLayout(
    sidebarPanel(
      selectInput("selected_variable", "Select Variable", choices = names(Chigaco_data_cleaned), selected = "per_capita_income"),
      selectInput("selected_areas", "Select Community Areas", choices = unique(Chigaco_data_cleaned$community_area_name), multiple = TRUE)
    ),
    mainPanel(
      plotOutput("selected_plot")
    )
  )
)

# Define server

# Define server
server <- function(input, output) {
  
  # Reactive function to filter data based on selected areas
  selected_data <- reactive({
    subset(Chigaco_data_cleaned, community_area_name %in% input$selected_areas)
  })
  
  # Render selected plot based on user input
  output$selected_plot <- renderPlot({
    ggplot(selected_data(), aes(x = reorder(community_area_name, -get(input$selected_variable)), y = get(input$selected_variable))) +
      geom_bar(stat = "identity", fill = "#69b3a2") +
      labs(title = paste("Bar Plot of", input$selected_variable, "by Community Area"),
           x = "Community Area",
           y = input$selected_variable) +
      theme(axis.text.x = element_text(angle = 70, hjust = 1))
  })
}


# Run the Shiny app
shinyApp(ui, server)


