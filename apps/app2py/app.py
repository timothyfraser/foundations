"""from shiny import App, render, ui, reactive
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
app = App(app_ui, server)"""

# app_api_mode.py
from shiny import App, render, ui, reactive
import pandas as pd
import matplotlib.pyplot as plt
import requests

# Local CSV fallback
LOCAL_MTCARS_PATH = "mtcars.csv"

# API base (change to port your API actually uses, e.g. 8000 or 1234)
API_BASE = "http://127.0.0.1:8000"   # or "http://127.0.0.1:1234"

# Load local copy (used for fallback and to populate dropdowns)
mtcars_local = pd.read_csv(LOCAL_MTCARS_PATH)
if "model" not in mtcars_local.columns:
    mtcars_local = mtcars_local.reset_index().rename(columns={"index": "model"})
mtcars_local["cyl"] = mtcars_local["cyl"].astype(int)
mtcars_local["gear"] = mtcars_local["gear"].astype(int)

unique_cyl = sorted(mtcars_local["cyl"].unique())
unique_gear = sorted(mtcars_local["gear"].unique())

app_ui = ui.page_sidebar(
    ui.sidebar(
        ui.input_select("cyl", "Select number of cylinders:",
                        choices=[str(c) for c in unique_cyl], selected=str(unique_cyl[0])),
        ui.input_select("gear", "Select number of gears:",
                        choices=[str(g) for g in unique_gear], selected=str(unique_gear[0])),
        ui.tags.br(),
        ui.output_text("data_source")   # shows whether API or local used
    ),
    ui.card(
        ui.card_header("mtcars Data Explorer (API-capable)"),
        ui.output_text("row_count_text"),
        ui.output_plot("mpg_plot"),
        ui.tags.h4("Previous Row Count:"),
        ui.output_text("last_row_count")
    )
)

def server(input, output, session):
    last_count = reactive.Value(None)
    # whether last fetch used API or local
    last_source = reactive.Value("local")

    @reactive.Calc
    def filtered_data():
        cyl_val = int(input.cyl())
        gear_val = int(input.gear())

        # Try API first
        try:
            resp = requests.get(
                f"{API_BASE}/filter",
                params={"cyl": cyl_val, "gear": gear_val},
                timeout=3.0
            )
            resp.raise_for_status()
            data = resp.json()
            df = pd.DataFrame(data)
            # ensure types and columns when API returns empty list
            if df.empty:
                df = df.astype({})  # no-op but safe
            # If API returned rows, mark source
            last_source.set("api")
            return df
        except Exception:
            # fallback to local filtering
            last_source.set("local")
            return mtcars_local[(mtcars_local["cyl"] == cyl_val) & (mtcars_local["gear"] == gear_val)]

    @output
    @render.text
    def data_source():
        return f"Data source used: {last_source.get()}"

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
        fig, ax = plt.subplots(figsize=(6, 4))
        if len(df) == 0:
            ax.text(0.5, 0.5, "No data for selected filters", ha="center", va="center")
        else:
            # If DataFrame came from API it may already have 'hp' and 'mpg' columns
            ax.scatter(df["hp"], df["mpg"])
            ax.set_title("MPG vs Horsepower")
            ax.set_xlabel("Horsepower (hp)")
            ax.set_ylabel("Miles per Gallon (mpg)")
            ax.grid(True)
        fig.tight_layout()
        return fig

    @output
    @render.text
    def last_row_count():
        val = last_count.get()
        return "No data yet." if val is None else f"{val} rows"

app = App(app_ui, server)