# Load the shiny package
library(shiny)
library(readr)
library(dplyr)

mtcars = read_csv("mtcars.csv")

# Define the UI
ui <- fluidPage(
  # App title
  titlePanel("mtcars Data Explorer"),

  # Sidebar layout with input and output definitions
  sidebarLayout(
    sidebarPanel(
      # Select input for number of cylinders
      selectInput(inputId = "cyl", label = "Select number of cylinders:",
                  choices = sort(unique(mtcars$cyl)),
                  selected = 4),
      
      # Select input for number of gears
      selectInput(inputId = "gear", label = "Select number of gears:",
                  choices = sort(unique(mtcars$gear)),
                  selected = 4)
    ),
    
    mainPanel(
      # Text output to display number of filtered rows
      textOutput("row_count_text"),
      
      # Plot output
      plotOutput("mpg_plot"),
      
      # Value box (custom) showing last row count (reactiveVal)
      h4("Previous Row Count:"),
      textOutput("last_row_count")
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  
  # Create a reactiveVal to store the last row count
  last_count <- reactiveVal(NA)
  
  # Define a reactive expression to filter mtcars based on inputs
  filtered_data <- reactive({
    # Subset the data based on selected inputs
    subset(mtcars, cyl == input$cyl & gear == input$gear)
  })
  
  # Render the text showing number of rows in filtered data
  output$row_count_text <- renderText({
    # Get the number of rows
    n <- nrow(filtered_data())
    
    # Update the last_count reactiveVal
    isolate({
      last_count(n)  # update the stored value
    })
    
    paste("Filtered data has", n, "rows.")
  })
  
  # Render a plot of mpg vs. hp for the filtered data
  output$mpg_plot <- renderPlot({
    data <- filtered_data()
    
    # Basic scatter plot
    plot(data$hp, data$mpg,
         main = "MPG vs Horsepower",
         xlab = "Horsepower (hp)",
         ylab = "Miles per Gallon (mpg)",
         col = "blue", pch = 19)
  })
  
  # Show previous value (reactiveVal)
  output$last_row_count <- renderText({
    val <- last_count()
    if (is.na(val)) {
      "No data yet."
    } else {
      paste(val, "rows")
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)