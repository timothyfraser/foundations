# plumber.R

# R script to read in a PUBLIC, VIEWABLE Google Sheet as CSV
# Only uses dplyr and readr (no authentication required)

# Load required packages
library(plumber, quietly = TRUE, warn.conflicts = FALSE)
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(readr, quietly = TRUE, warn.conflicts = FALSE)
library(httr2, quietly = TRUE, warn.conflicts = FALSE)    # For HTTP requests
library(jsonlite, quietly = TRUE, warn.conflicts = FALSE) # For working with JSON
library(knitr, quietly = TRUE, warn.conflicts = FALSE) # For creating markdown tables

#* @apiTitle REST API
#* @apiDescription REST API to read and analyze a PUBLIC, VIEWABLE Google Sheet as CSV

# Helper Functions ---------------------------

# Write a function to get the data from the google form
get_data = function(pumpid){
    # Load required packages
    require(dplyr, quietly = TRUE, warn.conflicts = FALSE)
    require(readr, quietly = TRUE, warn.conflicts = FALSE)

    # ---- Step 1: Define the CSV download link ----
    # This must be a public Google Sheet link, formatted as /export?format=csv
    path = "http://docs.google.com/spreadsheets/d/1k_4SZ-6achILnMD-tHU1PdrM7ppQgizJtyV4gf0b1wk/export?format=csv&gid=317348432"

    # ---- Step 2: Read the CSV from the URL ----
    df = read_csv(path)

    # ---- Step 3: Clean and View ----
    data = df %>%
    # rename columns
    select(timestamp = 1, type = 2, satisfaction = 3, failed = 4, date_failed = 5) %>%
    # remove any blank rows (eg. missing a timestamp)
    filter(!is.na(timestamp))


    # Available pump types
    pump_types <- c(
    "Medtronic MiniMed (600/700 series)",
    "Omnipod 5",
    "Omnipod DASH",
    "Tandem t:slim X2"
    )

    # Extract the pump types matching pumpid 1,2,3,4, etc.
    mypumps = pump_types[pumpid]

    # Filter the data to only include the specified pump types
    data = data %>% filter(type %in% mypumps)

    return(data)

}

# Write a function to get summary statistics from the data
get_stat = function(data){
    
    # Calculate average satisfaction by type of pump
    stat = data %>% 
        group_by( type ) %>% 
        summarize( 
            var = "satisfaction",
            mean = mean(satisfaction, na.rm = TRUE),
            sd = sd(satisfaction, na.rm = TRUE),
            n_records = n(),
            se = sd(satisfaction, na.rm = TRUE) / sqrt(n())
         )

    return(stat)

}

# Write a function to get a string blurb of the summary statistics table.
get_blurb = function(stat){

    library(knitr, quietly = TRUE, warn.conflicts = FALSE) # For creating markdown tables
    library(dplyr, quietly = TRUE, warn.conflicts = FALSE) # For pipeline

    # Output the summary statistics as a markdown table
    blurb = knitr::kable(stat, format = "markdown")
    # consolidate into one string with line breaks
    blurb = paste0(blurb, collapse = "\n")
    # Return the blurb
    return(blurb)

}

# Write a function to get a chat completion from the LLM
get_chat = function(blurb){
    
    # If you haven't already, install these packages...
    # install.packages(c("httr2", "jsonlite", "knitr"))

    # Load libraries
    require(httr2, quietly = TRUE, warn.conflicts = FALSE)    # For HTTP requests
    require(jsonlite, quietly = TRUE, warn.conflicts = FALSE) # For working with JSON
    require(knitr, quietly = TRUE, warn.conflicts = FALSE) # For creating markdown tables

    # Starting message
    cat("\n🚀 Sending LLM query in R...\n")

    # Design system prompt
    prompt_system = "You are a helpful assistant that summarizes customer satisfaction data regarding the use of common insulin pumps. Options include Medtronic MiniMed (600/700 series), Omnipod 5, Omnipod DASH, and Tandem t:slim X2. You will be given a summary of the data, and you will need to summarize the data in <200 words in a way that is easy to understand."

    # Design user prompt
    prompt_user = paste0("Summarize the following data: ", blurb)
    
    # Construct the request body as a list
    body <- list(
        model = "google/gemma-3-1b", # Model name
        messages = list(
            list(role = "system", content = prompt_system), # System prompt
            list(role = "user", content = prompt_user)        # User prompt
        ),
        temperature = 0.7,   # Sampling temperature
        max_tokens = -1,     # No token limit
        stream = FALSE       # Non-streaming response
    )

    # Build and send the POST request to the LM Studio REST API
    res <- request("http://localhost:1234/api/v0/chat/completions") %>%
        req_body_json(body) %>%   # Attach the JSON body
        req_method("POST") %>%   # Set HTTP method
        req_perform()             # Execute the request

    # Parse the response JSON
    response <- resp_body_json(res)

    # Extract the model's reply as a character string
    output = response$choices[[1]]$message$content

    # Closing message
    cat("\n✅ LLM query complete.")

    # Print the model's reply
    return(output)
}


# Endpoints ---------------------------------


#* @get /summary
#* @param pumpid:[int] The id number(s) for the type(s) of pump, as an integer vector
#* @response 200
#* @output list
function(pumpid){
    # Convert the pumpid parameter to an integer vector
    pumpid = as.integer(pumpid)

    # Acquire the data from the google form...
    data = get_data(pumpid = pumpid)

    # Calculate the summary statistics from the data
    stat = get_stat(data)
    
    # Get a string blurb of the summary statistics table.
    blurb = get_blurb(stat)

    # Get a chat completion from the LLM
    chat = get_chat(blurb)

    # Format the output as a list, containing the stat and chat
    output = list(stat = stat, chat = chat)
    
    # Return the output
    return(output)
}
