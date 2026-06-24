# Predictive Maintenance in the Gas Industry

Data-mining and reliability analysis of oil, gas, and electricity maintenance records — turning incident and reliability data (collected to standards such as **ISO 14224**) into actionable maintenance insight through forecasting, clustering, and regression.

## Overview

Computerized Maintenance Management Systems (CMMS) record the history of incidents
and equipment failures in a structured database. When this data is captured following
the oil-and-gas reliability data-collection standard **ISO 14224**, it becomes a unique,
region- and asset-specific resource: applying data mining and statistical modeling to it
yields operational insight that can be used to plan maintenance intelligently rather than
reactively.

This repository collects exploratory analysis and predictive modeling across three
domains of asset reliability data:

- **Electricity network maintenance** — feeder-level reliability indices (ENS / EENS, AF, ROCOF), forecasting and clustering of failure events.
- **Gas pipeline distribution (PHMSA)** — incident analysis of U.S. gas distribution data (causes, costs, releases, fatalities/injuries).
- **Oil pipeline accidents (2010–present)** — exploratory visualization of pipeline spill cost, location, operators, and causes.

The work is organized by sub-group/author folders, with parallel implementations of the
same techniques so methods can be cross-checked and compared.

## What's inside

```
.
├── Electricity Networks Maintenance/
│   └── Data Analysis Group/
│       ├── CODE.ipynb                       # SVR / Decision Tree / Random Forest regression (sklearn)
│       ├── Jahani/
│       │   ├── Data Preparation.ipynb       # Cleaning, Jalali→Gregorian dates, resampling
│       │   ├── Prepare_With_Dollar.py       # Helper utilities (parsing, resample, RMSE/MAPE, auto-ARIMA)
│       │   ├── ARIMAX.ipynb                  # Auto ARIMA / Auto SARIMA (pmdarima)
│       │   ├── SARIMAX ENS.ipynb            # Seasonal ARIMAX on ENS series (statsmodels)
│       │   ├── Daily Accident.ipynb         # Prophet forecasting of daily accident counts
│       │   ├── Poisson model.ipynb          # Poisson model for count/event data
│       │   ├── K-prototypes.ipynb           # K-prototypes clustering of mixed-type records (kmodes)
│       │   └── Hamid Jahani (Anova and Shapiro-vilk).R  # ANOVA + Shapiro–Wilk normality tests (R)
│       ├── Mehrpanah/                        # Visualization + ROCOF / Availability-Factor analysis
│       ├── Nadernezhad/                      # Additional analysis notebooks
│       └── parisaalirezaei/                  # ARIMA/SARIMA, Poisson, k-means, SVR, DT/RF, ANN (Keras),
│                                             #   Naive Bayes (R) on feeder data
├── Gas Pipeline Distribution (PHMSA)/
│   ├── PHMSA.ipynb                           # EDA: causes, costs, operators (pandas / seaborn)
│   └── Hamid Jahani.ipynb                    # Null handling + K-prototypes clustering of incidents
└── Oil Pipeline Accidents, 2010-Present/
    └── Hamid Jahani/
        └── oil-pipeline-spill-visualizations.ipynb  # Spill cost, mapping, operator/cause analysis (plotly)
```

> Note: many notebook and folder names contain spaces and parentheses, and some paths
> are long — clone on a filesystem that supports long paths (on Windows, enable
> `core.longpaths`).

## Methods / Approach

| Task | Technique | Tooling |
|------|-----------|---------|
| Time-series forecasting | Auto ARIMA / Auto SARIMA, Seasonal ARIMAX | `pmdarima`, `statsmodels` |
| Daily event forecasting | Prophet additive model | `fbprophet` |
| Event / count modeling | Poisson model | `numpy`, `pandas` |
| Clustering (mixed types) | K-prototypes | `kmodes` |
| Clustering (numeric) | K-means | `scikit-learn`, `mglearn` |
| Regression | SVR, Decision Tree, Random Forest | `scikit-learn` |
| Classification | Decision Tree, Random Forest, ANN, Naive Bayes | `scikit-learn`, `keras` / `tensorflow`, R `caret` |
| Statistical testing | ANOVA, Shapiro–Wilk normality test | R (`dplyr`, `ggplot2`) |
| EDA & visualization | Distributions, time trends, geospatial maps, missingness | `seaborn`, `matplotlib`, `plotnine`, `plotly` / `chart_studio`, `missingno`, `pandas_profiling`, `bokeh` |

Forecast accuracy in the time-series notebooks is evaluated with **RMSE** and **MAPE**
(see `Prepare_With_Dollar.py`). Dates in the Iranian datasets are handled with the Jalali
(Persian) calendar via `persiantools` / `jalali` and converted to Gregorian for modeling.

**Tech stack:** Python (pandas, NumPy, scikit-learn, statsmodels, pmdarima, fbprophet,
kmodes, Keras/TensorFlow, seaborn, plotnine, plotly) and R (caret, ggplot2, dplyr),
in Jupyter notebooks.

## How to run

These are research notebooks rather than a packaged application. To run them locally:

```bash
# clone (enable long paths on Windows)
git clone https://github.com/sheperd007/Predictive-maintenance-in-the-gas-industry.git
cd Predictive-maintenance-in-the-gas-industry

# create an environment
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate

# core dependencies used across the notebooks
pip install jupyter pandas numpy scikit-learn statsmodels pmdarima \
            kmodes seaborn matplotlib plotnine plotly missingno \
            persiantools

# optional, used by specific notebooks
pip install fbprophet pandas-profiling bokeh mglearn category_encoders \
            keras tensorflow chart_studio
```

Then launch Jupyter and open any notebook:

```bash
jupyter notebook
```

The R scripts (`*.R`) require R with `readxl`, `dplyr`, `ggplot2`, and `caret`.

> Input datasets are not bundled in this repository. Notebooks expect the corresponding
> reliability / incident data files (electricity feeder records, PHMSA gas distribution
> data, oil pipeline spill data) to be supplied locally; some scripts read from
> absolute paths or via a file picker and may need their paths adjusted.

## Data sources

- **ISO 14224** — international standard for collection and exchange of reliability and maintenance data for the petroleum, petrochemical, and natural gas industries.
- **PHMSA** — U.S. Pipeline and Hazardous Materials Safety Administration gas distribution incident data.
- **Oil pipeline accident data (2010–present)** — pipeline spill records (cost, location, operator, cause).
- **Electricity network reliability data** — feeder-level indices (ENS/EENS, AF, ROCOF) used for the electricity-maintenance analyses.

## Contributing

This is a collaborative, multi-author project. Each sub-group keeps its work in a folder
named after the group/member (e.g. the data-analysis group folders above); members
review and build on one another's notebooks.

## License

No license file is currently included in this repository; all rights remain with the
authors. Please contact the repository owner before reuse.
