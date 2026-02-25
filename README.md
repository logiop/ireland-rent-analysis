# 🇮🇪 Irish Rental Market Analysis 2020–2025

**Mapping the Housing Crisis: Regional Trends Across All 26 Counties**

[![R](https://img.shields.io/badge/R-4.0+-blue.svg)](https://www.r-project.org/)
[![ggplot2](https://img.shields.io/badge/ggplot2-tidyverse-green.svg)](#)
[![RMarkdown](https://img.shields.io/badge/R%20Markdown-HTML%2FPDF-orange.svg)](#)
[![Data](https://img.shields.io/badge/Data-26%20counties-lightblue.svg)](#-data-source)
[![Status](https://img.shields.io/badge/Status-Complete-brightgreen.svg)](#)
[![License](https://img.shields.io/badge/License-CC0-lightgrey.svg)](#-data-source)

---

## 🎯 The Problem

Ireland faces a **severe housing affordability crisis**:
- Rental prices have surged **30-45%** in 5 years
- Regional disparities mask the full picture
- Policy makers lack granular, county-level trend data
- Renters need insight into market direction to make informed decisions

**This analysis answers**:
- Which counties are most affected by rising rents?
- What are the year-on-year trends?
- Are there regional patterns or outliers?

---

## 🔍 Approach

### Data & Methodology
- **Dataset**: Irish rental prices aggregated by county (2020–2025)
- **Geographic Scope**: All 26 Irish counties
- **Time Period**: 6 years of annual data
- **Data Granularity**: County-level aggregates from government housing data

### Analysis Methods
1. **Time Series Analysis**: Track rental evolution across 6-year period
2. **Regional Comparison**: Identify fastest-growing & most stable counties
3. **Trend Visualization**: Line charts highlighting top performers & outliers
4. **Percentage Change Calculation**: Year-on-year growth rates by county

### Tools & Technologies
- **Language**: R (tidyverse, ggplot2)
- **Format**: R Markdown with HTML/PDF output
- **Visualization**: ggplot2 for professional graphics
- **Data Processing**: dplyr for data manipulation

---

## 📈 Key Findings

### Market Overview
- **Highest Average Rent**: Dublin City (€1,200-1,400/month)
- **Lowest Average Rent**: Rural counties (€400-600/month)
- **Average Growth Rate**: 6-8% annually across most counties
- **Hardest Hit**: Dublin (city center), Cork, Galway

### Trend Patterns
1. **Urban vs Rural Divide**: Capital and major cities show 2-3x higher rents
2. **Accelerating Growth**: Year-on-year growth rates **increasing** 2023-2025
3. **No Relief**: No counties show declining rental trends
4. **Commuter Impact**: Counties near Dublin show outsized growth

### Top 10 Rentals by County (2024-2025)
| Rank | County | Avg Rent | 5-Yr Growth |
|------|--------|----------|------------|
| 1 | Dublin | €1,350 | +42% |
| 2 | Dun Laoghaire-Rathdown | €1,200 | +38% |
| 3 | Fingal | €1,100 | +35% |
| 4 | Cork | €850 | +32% |
| 5 | Galway | €800 | +30% |
| 6 | Wicklow | €750 | +28% |
| 7 | Kildare | €720 | +26% |
| 8 | Limerick | €680 | +24% |
| 9 | Waterford | €620 | +22% |
| 10 | Kilkenny | €580 | +20% |

---

## 🚀 How to Run

### Prerequisites
```bash
R 4.0+
RStudio (optional but recommended)
```

### Required R Packages
```r
library(ggplot2)      # Visualization
library(dplyr)        # Data manipulation
library(tidyr)        # Data cleaning
library(forcats)      # Factor handling
library(knitr)        # Report generation
library(scales)       # Formatting
```

### Installation & Execution

```bash
# Clone the repository
git clone https://github.com/logiop/ireland-rent-analysis.git
cd ireland-rent-analysis

# Option 1: Open in RStudio
# File → Open Project → Select ireland-rent-analysis folder
# Then: Open irish_rent_final.Rmd
# Click "Knit" button to generate HTML/PDF report
```

```r
# Option 2: Command line R
# From R console:
rmarkdown::render("irish_rent_final.Rmd", output_format = "html_document")
# or
rmarkdown::render("irish_rent_final.Rmd", output_format = "pdf_document")
```

### Project Structure
```
ireland-rent-analysis/
├── irish_rent_final.Rmd              # Main analysis document (start here!)
├── irish_rent_by_county.csv          # Source dataset
├── linkedin_carousel.R               # LinkedIn visualization script
├── linkedin_carousel.pdf             # Social media graphics
├── .gitignore
└── README.md                         # This file
```

---

## 📊 Data Source

**Source**: Irish Government Housing Data / CSO (Central Statistics Office)
**Geographic Coverage**: All 26 counties
**Time Period**: 2020–2025 (6 years)
**Data Type**: Annual county-level aggregates
**Availability**: Public domain

### Dataset Characteristics
- **Format**: CSV with county name, year, rent amount (€/month)
- **Missing Data**: Minimal; handled via aggregation
- **Validation**: Cross-checked against CSO official reports

---

## 🎨 Visualizations

The analysis includes:
- **Trend line chart**: Top 10 counties rental evolution (2020–2025)
- **Regional comparison**: All 26 counties on single chart
- **Growth rate chart**: Percentage change by county
- **Heatmap**: Temporal patterns across provinces

---

## 🛠️ Technologies

| Tool | Purpose |
|------|---------|
| **R** | Statistical analysis & data processing |
| **ggplot2** | Publication-quality visualizations |
| **dplyr** | Data transformation & aggregation |
| **R Markdown** | Reproducible report generation |
| **RStudio** | Interactive development environment |

---

## 💡 Key Insights for Stakeholders

### For Renters
- Dublin remains unaffordable; regional alternatives showing similar trends
- Long-term outlook: expect 5-8% annual increases
- Early action (moving to slower-growth counties) saves significantly

### For Policy Makers
- Housing supply crisis evident in all regions
- Urban-rural divide widening
- Intervention urgently needed to moderate growth

### For Investors
- Rental yields remain positive despite price growth
- Commuter belt counties offer opportunity
- Dublin market approaching saturation

---

## 💼 Project Context

**Data literacy project** analyzing Ireland's housing crisis through statistical analysis. Demonstrates ability to:
- Work with government datasets
- Produce reproducible analyses (R Markdown)
- Create professional visualizations
- Communicate complex trends to diverse audiences
- Understand policy-relevant metrics

---

## 📬 Contact & Links

- **LinkedIn**: [Giorgio Vernarecci](https://www.linkedin.com/in/giorgio-vernarecci-4b5a8a23b)
- **GitHub**: [@logiop](https://github.com/logiop)
- **Portfolio**: See other data projects at github.com/logiop

---

*Last updated: February 2025*
*Data covers 26 Irish counties over 6-year period (2020–2025)*
