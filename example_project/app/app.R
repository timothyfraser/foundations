# app.R

# Minimal Shiny App for Insulin Pump Data

# IMPORTANT: Change the working directory path below to match your system
# Replace "/Users/ginayp/foundations/example_project/app" with your actual path to this folder
setwd("example_project/api")

library(shiny)
library(httr)
library(jsonlite)

# Available pump types
pump_types <- c(
  "Medtronic MiniMed (600/700 series)" = 1,
  "Omnipod 5" = 2,
  "Omnipod DASH" = 3,
  "Tandem t:slim X2" = 4
)

# UI
ui <- fluidPage(
  titlePanel("Insulin Pump Data Analysis"),
  
  # Checkbox input for pump types
  checkboxGroupInput(
    inputId = "pumpid", 
    label = "Select Pump Types:",
    choices = pump_types,
    selected = pump_types[1]),
  
  # Table output
  h4("Data Table:"),
  tableOutput("data_table"),
  
  # Text output box for summary results
  h4("Summary Analysis:"),
  verbatimTextOutput("summary_text")
)

# Server
server <- function(input, output, session) {
  
  # Reactive function to fetch data from API
  api_data = reactive({
    print("Fetching data from API...")
    req(input$pumpid)
    
    # Testing value
    input = list(pumpid = 1)
    
    # Create URL with selected pump types
    pump_params <- paste(input$pumpid, collapse = "&pumptype=")

    url = paste0("http://localhost:8001/summary?pumpid=", pump_params)
    
    # Make GET request
    res = httr::GET(url)
    # Extract the content as a JSON object    
    content = jsonlite::fromJSON(content(res, as = "text", encoding = "UTF-8"))
  # Return the content
    content
  })
  
  # Render data table (placeholder - would need separate endpoint for raw data)
  output$data_table <- renderTable({
    print("Rendering table...")

    req(api_data())

    data = api_data()
    values = data$stat # return the stat dataframe
    print(values) # print the values to the console
    values
  })
  
  # Render summary text from API
  output$summary_text <- renderText({
    print("Rendering summary text...")

    req(api_data())
    
    data = api_data()
    values = data$chat # return the chat string
    print(values) # print the values to the console
    values
  }) 
}

# Run the app on port 8001
shinyApp(ui = ui, server = server, options = list(port = 8001))