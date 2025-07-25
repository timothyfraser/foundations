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
                  choices = sort(unique(mtcars$cyl)), selected = 4),
      selectInput("gear", "Select number of gears:",
                  choices = sort(unique(mtcars$gear)), selected = 4)
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
    
    # Make GET request and parse JSON
    res <- httr::GET(url)
    stop_for_status(res)
    content <- content(res, as = "text", encoding = "UTF-8")
    fromJSON(content)
  })
  
  # Render text showing number of rows
  output$row_count_text <- renderText({
    df <- filtered_data()
    n <- nrow(df)
    isolate(last_count(n))  # update stored value
    paste("Filtered data has", n, "rows.")
  })
  
  # Render scatterplot
  output$mpg_plot <- renderPlot({
    df <- filtered_data()
    plot(df$hp, df$mpg,
         main = "MPG vs Horsepower",
         xlab = "Horsepower (hp)",
         ylab = "Miles per Gallon (mpg)",
         col = "darkgreen", pch = 19)
  })
  
  # Render last count
  output$last_row_count <- renderText({
    val <- last_count()
    if (is.na(val)) "No data yet." else paste(val, "rows")
  })
}

# Run the app
shinyApp(ui = ui, server = server)