# 📊 Dublin Economic Resilience Analysis (1998–2025)

## 🌟 Project Overview
This project evaluates the labor market dynamics of Dublin against the Irish national average. By building a customized ETL pipeline and a relational database, I identified historical trends and the "Performance Gap" between the capital city and the national economy.



## 🛠️ Technical Stack
* **Python (Pandas & Matplotlib):** Used for data cleaning (ETL) and trend visualization.
* **SQL (MySQL):** Used for advanced time-series analysis, Window Functions, and Reporting Views.

## 📈 Key Visualizations

### 1. National vs. Dublin Comparison
This chart compares the core unemployment rates, showing Dublin's historical stability.
![Comparison](images/unemployment_comparison.png)

### 2. The 1-Year Moving Average
Smoothed data using SQL Window Functions to identify long-term economic directions.
![Trend](images/moving_average_trend.png)

### 3. Year-over-Year Job Growth
Visualizing net job creation in Dublin using the SQL `LAG()` function.
![Growth](images/job_growth_yoy.png)

### 4. The Performance Gap
Highlighting periods where Dublin outperformed (Green) or underperformed (Red) the national average.
![Gap](images/performance_gap.png)

## 🧠 Advanced SQL Skills Demonstrated
* **Window Functions:** Calculating rolling averages and comparative benchmarks.
* **CTEs (Common Table Expressions):** Managing complex, multi-stage queries.
* **Database Views:** Creating a `view_dublin_economic_health` for production-ready reporting.



## 💡 Business Insights
1. **The Shield:** Dublin’s unemployment was consistently ~1% lower than the national average during the 2008 recovery.
2. **The 2020 Shift:** The pandemic was the first recorded event where Dublin's unemployment spiked higher than the national average due to the city's reliance on the service sector.

## 🚀 How to Run
1. Clone this repository.
2. Run `scripts/data_cleaning_viz.py` to generate the latest charts.
3. Import `data/dublin_unemployment_CLEAN.csv` into your MySQL instance and run the scripts in `sql/`.
