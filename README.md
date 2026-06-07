# ListenBrainz Music Analytics Pipeline

An end-to-end data engineering pipeline built on Google BigQuery and dbt Cloud,
processing 5 million music listening records to deliver business insights.

## Architecture

Source (BigQuery Public Dataset)
  → Raw Layer (listenbrainz_raw)
  → Staging Layer (listenbrainz_staging)
  → Marts Layer / Star Schema (listenbrainz_dev)
  → Analytics (Google Colab + Python)

## Tech Stack

| Tool | Purpose |
|---|---|
| Google BigQuery | Data warehouse (EU region) |
| dbt Cloud | ELT transformations & testing |
| dbt_utils | Surrogate key generation |
| Python / Pandas | Data analysis |
| Matplotlib / Seaborn | Visualizations |
| Google Colab | Analysis environment |
| GitHub | Version control |

## Data Model

### Source
- `bigquery-public-data.listenbrainz.listens` — 1 table, EU region

### Star Schema
- `fact_listens` — 5M rows, one row per listening event
- `dim_user` — unique listeners
- `dim_artist` — artist metadata
- `dim_track` — track metadata
- `dim_date` — date/time dimensions (year, month, day, hour, day_of_week)

## Project Structure