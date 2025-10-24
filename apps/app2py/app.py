from shiny import App, render, ui, reactive
import pandas as pd
import matplotlib.pyplot as plt

# Load the mtcars dataset
mtcars = pd.read_csv("mtcars.csv")

# Add row names as a column if needed
mtcars.reset_index(drop=True, inplace=True)

# Unique sorted values for dropdowns
unique_cyl = sorted(mtcars["cyl"].unique())
unique_gear = sorted(mtcars["gear"].unique())

# Shiny UI
app_ui = ui.page_sidebar(
    ui.sidebar(
        ui.input_select("cyl", "Select number of cylinders:",
                        choices=[str(c) for c in unique_cyl], selected="4"),
        ui.input_select("gear", "Select number of gears:",
                        choices=[str(g) for g in unique_gear], selected="4")
    ),
    ui.card(
        ui.card_header("mtcars Data Explorer"),
        ui.output_text("row_count_text"),
        ui.output_plot("mpg_plot"),
        ui.tags.h4("Previous Row Count:"),
        ui.output_text("last_row_count")
    )
)

# Server logic
def server(input, output, session):
    last_count = reactive.Value(None)

    @reactive.calc
    def filtered_data():
        cyl_val = int(input.cyl())
        gear_val = int(input.gear())
        return mtcars[(mtcars["cyl"] == cyl_val) & (mtcars["gear"] == gear_val)]

    @output
    @render.text
    def row_count_text():
        df = filtered_data()
        n = len(df)
        last_count.set(n)
        return f"Filtered data has {n} rows."

    @output
    @render.plot
    def mpg_plot():
        df = filtered_data()
        plt.figure(figsize=(5, 4))
        plt.scatter(df["hp"], df["mpg"], color="orange")
        plt.title("MPG vs Horsepower")
        plt.xlabel("Horsepower (hp)")
        plt.ylabel("Miles per Gallon (mpg)")
        plt.grid(True)

    @output
    @render.text
    def last_row_count():
        val = last_count.get()
        return "No data yet." if val is None else f"{val} rows"

# App object
app = App(app_ui, server)