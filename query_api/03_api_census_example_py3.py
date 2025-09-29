#!/usr/bin/env python3

import os
import sys
import requests
import pandas as pd


ACS_YEAR = "2022"
SURVEY = "acs/acs5"
STATE_FIPS = "36"  # New York
BASE_URL = f"https://api.census.gov/data/{ACS_YEAR}/{SURVEY}"


VARIABLES_MAP = {
    "total_population": "B01003_001",
    "Not_Hispanic_or_Latino_Population": "B03002_002",
    "Hispanic_or_Latino_Population": "B03002_012",
    "population_by_race_White": "B02001_002",
    "population_by_race_Black_or_African_American": "B02001_003",
    "population_by_race_American_Indian_and_Alaska_Native": "B02001_004",
    "population_by_race_Asian": "B02001_005",
    "population_by_race_Native_Hawaiian_and_Other_Pacific_Islander": "B02001_006",
    "median_income": "B19013_001",
    "population_by_gender_male": "B01001_002",
    "population_by_gender_female": "B01001_026",
    "White_alone_Not_Hispanic_or_Latino_Population": "B03002_003",
    "Black_or_African_American_Not_Hispanic_or_Latino_Population": "B03002_004",
    "American_Indian_and_Alaska_Not_Native_Hispanic_or_Latino_Population": "B03002_005",
    "Asian_Not_Hispanic_or_Latino_Population": "B03002_006",
    "Native_Hawaiian_and_Other_Pacific_Islander_Not_Latino_Population": "B03002_007",
    "Asian_Hispanic_or_Latino_Population": "B03002_016",
    "White_alone_Hispanic_or_Latino_Population": "B03002_013",
    "Black_or_African_American_Hispanic_or_Latino_Population": "B03002_014",
    "American_Indian_and_Alaska_Native_Hispanic_or_Latino_Population": "B03002_015",
    "Native_Hawaiian_and_Other_Pacific_Islander_Latino_Population": "B03002_017",
}


INCOME_VARS = [
    "B19001_002", "B19001_003", "B19001_004", "B19001_005",
    "B19001_006", "B19001_007", "B19001_008", "B19001_009", "B19001_010",
    "B19001_011", "B19001_012",
    "B19001_013",
    "B19001_014",
    "B19001_015",
    "B19001_016",
    "B19001_017",
]


AGE_VARS = [
    # Under 18 (Male: 003-006, Female: 027-030)
    "B01001_003", "B01001_004", "B01001_005", "B01001_006",
    "B01001_027", "B01001_028", "B01001_029", "B01001_030",
    # 18-34 (Male: 007-012, Female: 031-036)
    "B01001_007", "B01001_008", "B01001_009", "B01001_010", "B01001_011", "B01001_012",
    "B01001_031", "B01001_032", "B01001_033", "B01001_034", "B01001_035", "B01001_036",
    # 35-64 (Male: 013-019, Female: 037-043)
    "B01001_013", "B01001_014", "B01001_015", "B01001_016", "B01001_017", "B01001_018", "B01001_019",
    "B01001_037", "B01001_038", "B01001_039", "B01001_040", "B01001_041", "B01001_042", "B01001_043",
    # 65 and over (Male: 020-025, Female: 044-049)
    "B01001_020", "B01001_021", "B01001_022", "B01001_023", "B01001_024", "B01001_025",
    "B01001_044", "B01001_045", "B01001_046", "B01001_047", "B01001_048", "B01001_049",
]

HEADERS = {
    "Accept": "application/json",
    "User-Agent": "swathi-acs-script/1.0 (+https://example.com)"
}


def chunked(seq, size):
    """Yield successive slices from seq of length <= size."""
    for i in range(0, len(seq), size):
        yield seq[i:i + size]

def _request_json(params):
    # Debug
    print(f"Making request to: {BASE_URL}")
    print(f"Parameters: {params}")
    if "get" in params and "for" in params and "in" in params:
        full_url = f"{BASE_URL}?get={params['get']}&for={params['for']}&in={params['in']}&key={params.get('key','')[:10]}..."
        print(f"Full URL: {full_url}")

    try:
        resp = requests.get(BASE_URL, params=params, headers=HEADERS, timeout=120)
        resp.raise_for_status()
    except requests.exceptions.RequestException as e:
        raise RuntimeError(f"Request error: {e}")

    ctype = (resp.headers.get("Content-Type") or "").lower()
    if "application/json" not in ctype:
        text_preview = resp.text[:500]
        if "invalid key" in text_preview.lower():
            raise RuntimeError(
                "Census API returned an HTML 'Invalid Key' page. "
                "This can happen with long queries. We’ll retry in smaller chunks.\n"
                "If it persists on tiny queries too, recheck CENSUS_API_KEY."
            )
        raise RuntimeError(
            "Unexpected non-JSON response from Census API.\n"
            f"Content-Type: {ctype}\nPreview:\n{text_preview}"
        )

    try:
        return resp.json()
    except ValueError as e:
        raise RuntimeError(f"Failed to decode JSON: {e}\nPreview:\n{resp.text[:500]}")


def api_fetch_dataframe(var_codes, chunk_size=20):
    """
    Fetches variables with estimates+MOEs in chunks and returns the long (tidy) DataFrame.
    """
    api_key = require_api_key()

    # we’ll accumulate long-format rows for all chunks
    long_all = []

    for chunk in chunked(var_codes, chunk_size):
        params = {
            "get": build_get_params(chunk),  # NAME + Es + Ms
            "for": "county:*",
            "in": f"state:{STATE_FIPS}",
            "key": api_key,
        }
        data = _request_json(params)
        if not data or not isinstance(data, list) or not data[0]:
            raise RuntimeError("Empty or malformed JSON payload from Census API.")

        cols = data[0]
        rows = data[1:]
        df = pd.DataFrame(rows, columns=cols)
        df["GEOID"] = df["state"] + df["county"]

        # reshape to long using VARIABLES_MAP (only those present in this chunk)
        for pretty_name, code in VARIABLES_MAP.items():
            if code not in chunk:
                continue
            est_col = f"{code}E"
            moe_col = f"{code}M"
            if est_col in df.columns:
                sub = df[["GEOID", "NAME", est_col]].copy()
                sub.rename(columns={est_col: "estimate"}, inplace=True)
                sub["moe"] = pd.to_numeric(df.get(moe_col), errors="coerce") if moe_col in df.columns else None
                sub["variable"] = pretty_name
                sub["estimate"] = pd.to_numeric(sub["estimate"], errors="coerce")
                long_all.append(sub[["GEOID", "NAME", "variable", "estimate", "moe"]])

    if not long_all:
        # Fallback: nothing matched VARIABLES_MAP → return empty but valid structure
        return pd.DataFrame(columns=["GEOID", "NAME", "variable", "estimate", "moe"])

    # Concatenate all chunk results
    out = pd.concat(long_all, ignore_index=True)
    # Optional: drop duplicates in case of overlaps
    out = out.drop_duplicates(subset=["GEOID", "variable"], keep="last")
    return out


def api_fetch_wide(var_codes, chunk_size=20):
    """
    Fetches estimate (E) columns in chunks and left-joins them into one wide frame.
    """
    api_key = require_api_key()

    base_df = None
    for i, chunk in enumerate(chunked(var_codes, chunk_size)):
        params = {
            "get": ",".join(["NAME"] + [f"{v}E" for v in chunk]),
            "for": "county:*",
            "in": f"state:{STATE_FIPS}",
            "key": api_key,
        }
        data = _request_json(params)
        if not data or not isinstance(data, list) or not data[0]:
            raise RuntimeError("Empty or malformed JSON payload from Census API.")

        cols = data[0]
        rows = data[1:]
        df = pd.DataFrame(rows, columns=cols)
        df["GEOID"] = df["state"] + df["county"]

        # numeric conversion for this chunk
        for v in chunk:
            col = f"{v}E"
            if col in df.columns:
                df[col] = pd.to_numeric(df[col], errors="coerce")

        if base_df is None:
            base_df = df
        else:
            # Merge on stable keys. Keep NAME/state/county from the left (first chunk)
            keep_cols = ["GEOID", "state", "county"]
            value_cols = [c for c in df.columns if c not in keep_cols + ["NAME"]]
            base_df = base_df.merge(df[keep_cols + value_cols], on=keep_cols, how="left")

    if base_df is None:
        # Return an empty frame with expected minimal columns
        return pd.DataFrame(columns=["NAME", "state", "county", "GEOID"])

    return base_df

def require_api_key() -> str:
    api_key = os.getenv("CENSUS_API_KEY")
    if not api_key:
        sys.stderr.write("CENSUS_API_KEY environment variable is not set.\n")
        sys.stderr.write("Export it first, e.g.: export CENSUS_API_KEY=\"your_key\"\n")
        sys.exit(1)
    return api_key


def build_get_params(var_codes):
    var_es = [f"{v}E" for v in var_codes]
    var_ms = [f"{v}M" for v in var_codes]
    get_fields = ["NAME"] + var_es + var_ms
    return ",".join(get_fields)


def compute_income_summary(df_wide):
    # Sum brackets per county
    def sum_cols(cols):
        existing = [c for c in cols if c in df_wide.columns]
        return df_wide[existing].sum(axis=1, skipna=True)

    out = pd.DataFrame({
        "GEOID": df_wide["GEOID"],
        "NAME": df_wide["NAME"],
        "income_0_24999": sum_cols([f"B19001_{i:03d}E" for i in range(2, 6)]),
        "income_25000_49999": sum_cols([f"B19001_{i:03d}E" for i in range(6, 11)]),
        "income_50000_74999": sum_cols(["B19001_011E", "B19001_012E"]),
        "income_75000_99999": sum_cols(["B19001_013E"]),
        "income_100000_124999": sum_cols(["B19001_014E"]),
        "income_125000_149999": sum_cols(["B19001_015E"]),
        "income_150000_199999": sum_cols(["B19001_016E"]),
        "income_200000_or_more": sum_cols(["B19001_017E"]),
    })
    return out


def compute_age_summary(df_wide):
    def sum_cols(cols):
        existing = [c for c in cols if c in df_wide.columns]
        return df_wide[existing].sum(axis=1, skipna=True)

    out = pd.DataFrame({
        "GEOID": df_wide["GEOID"],
        "NAME": df_wide["NAME"],
        "age_under_18": sum_cols([
            "B01001_003E", "B01001_004E", "B01001_005E", "B01001_006E",
            "B01001_027E", "B01001_028E", "B01001_029E", "B01001_030E",
        ]),
        "age_18_34": sum_cols([
            "B01001_007E", "B01001_008E", "B01001_009E", "B01001_010E", "B01001_011E", "B01001_012E",
            "B01001_031E", "B01001_032E", "B01001_033E", "B01001_034E", "B01001_035E", "B01001_036E",
        ]),
        "age_35_64": sum_cols([
            "B01001_013E", "B01001_014E", "B01001_015E", "B01001_016E", "B01001_017E", "B01001_018E", "B01001_019E",
            "B01001_037E", "B01001_038E", "B01001_039E", "B01001_040E", "B01001_041E", "B01001_042E", "B01001_043E",
        ]),
        "age_65_and_over": sum_cols([
            "B01001_020E", "B01001_021E", "B01001_022E", "B01001_023E", "B01001_024E", "B01001_025E",
            "B01001_044E", "B01001_045E", "B01001_046E", "B01001_047E", "B01001_048E", "B01001_049E",
        ]),
    })
    return out


def main():
    # 1) General variables (long format with estimate/moe)
    ny_census_data = api_fetch_dataframe(list(VARIABLES_MAP.values()))

    # 2) Income wide fetch and summarize
    income_wide = api_fetch_wide(INCOME_VARS)
    income_summary = compute_income_summary(income_wide)

    # 3) Age wide fetch and summarize
    age_wide = api_fetch_wide(AGE_VARS)
    age_summary = compute_age_summary(age_wide)

    # Print previews similar to R output
    print(ny_census_data.head(50))
    print(income_summary.head(50))
    print(age_summary.head(50))

    # Save CSVs
    print("\n=== SAVING DATA AS CSV FILES ===")
    ny_census_data.to_csv("census_data_readable.csv", index=False)
    income_summary.to_csv("income_summary_readable.csv", index=False)
    age_summary.to_csv("age_summary_readable.csv", index=False)
    print("Saved: census_data_readable.csv, income_summary_readable.csv, age_summary_readable.csv")


if __name__ == "__main__":
    main()


