# app.py

# API application run in FastAPI with Python. Expects to be run from apps/api2py working directory

# Install relevant packages in terminal if necessary
# !pip install fastapi pydantic typing pandas 

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
import pandas as pd

app = FastAPI()

# CORS setup (optional if hosting locally)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # allow all for dev
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load mtcars dataset (with model names as column)
mtcars = pd.read_csv("mtcars.csv")
mtcars["model"] = mtcars["model"] if "model" in mtcars.columns else mtcars.index.astype(str)

@app.get("/filter")
def filter_mtcars(cyl: int, gear: int):
    df = mtcars[(mtcars["cyl"] == cyl) & (mtcars["gear"] == gear)].reset_index(drop=True)
    return df.to_dict(orient="records")