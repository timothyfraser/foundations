# IMPORTANT: Change the working directory path below to match your system
# Replace "/Users/ginayp/foundations/apps/app2r" with your actual path to this folder
setwd("/Users/ginayp/foundations/apps/app2r")

# app.R
library(shiny)
library(httr)
library(jsonlite)

# UI
ui <- fluidPage(
  titlePanel("mtcars via Plumber API"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("cyl", "Select number of cylinders:",
                  choices = c(4, 6, 8), selected = 4),
      selectInput("gear", "Select number of gears:",
                  choices = c(3, 4, 5), selected = 4)
    ),
    
    mainPanel(
      textOutput("row_count_text"),
      plotOutput("mpg_plot"),
      h4("Previous Row Count:"),
      textOutput("last_row_count")
    )
  )
)

# Server
server <- function(input, output, session) {
  # Reactive value to store previous row count
  last_count <- reactiveVal(NA)
  
  # Reactive function to fetch filtered data from plumber
  filtered_data <- reactive({
    req(input$cyl, input$gear)
    url <- sprintf("http://localhost:8000/filter?cyl=%s&gear=%s", input$cyl, input$gear)
    
    tryCatch({
      # Make GET request and parse JSON
      res <- httr::GET(url)
      stop_for_status(res)
      content <- content(res, as = "text", encoding = "UTF-8")
      
      # Parse JSON response
      df <- fromJSON(content, simplifyDataFrame = TRUE)
      
      # Debug: print the structure
      cat("API Response structure:\n")
      print(str(df))
      cat("API Response content:\n")
      print(df)
      
      # Ensure it's a data frame
      if (is.data.frame(df)) {
        return(df)
      } else if (is.list(df) && length(df) > 0) {
        # Convert list to data frame
        return(as.data.frame(df))
      } else {
        # Return empty data frame if no data
        return(data.frame())
      }
    }, error = function(e) {
      cat("Error in API call:", e$message, "\n")
      # Return empty data frame on error
      return(data.frame())
    })
  })
  
  # Render text showing number of rows
  output$row_count_text <- renderText({
    df <- filtered_data()
    if (nrow(df) > 0) {
      n <- nrow(df)
      isolate(last_count(n))  # update stored value
      paste("Filtered data has", n, "rows.")
    } else {
      isolate(last_count(0))  # update stored value
      "No data found for the selected criteria."
    }
  })
  
  # Render scatterplot
  output$mpg_plot <- renderPlot({
    df <- filtered_data()
    if (nrow(df) > 0 && "hp" %in% colnames(df) && "mpg" %in% colnames(df)) {
      plot(df$hp, df$mpg,
           main = "MPG vs Horsepower",
           xlab = "Horsepower (hp)",
           ylab = "Miles per Gallon (mpg)",
           col = "darkgreen", pch = 19)
    } else {
      plot(1, 1, type = "n", main = "No data to display", 
           xlab = "Horsepower (hp)", ylab = "Miles per Gallon (mpg)")
    }
  })
  
  # Render last count
  output$last_row_count <- renderText({
    val <- last_count()
    if (is.na(val) || is.null(val)) "No data yet." else paste(val, "rows")
  })
}

# Run the app
shinyApp(ui = ui, server = server)