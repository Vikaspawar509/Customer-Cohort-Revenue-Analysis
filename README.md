# Customer-Cohort-Revenue-Analysis
This project focuses on analyzing customer behavior, revenue trends, and retention patterns using SQL on an e-commerce dataset.  The goal is to extract meaningful business insights such as customer lifetime value, repeat purchase behavior, and cohort-based retention.

---

## Objective
- Analyze revenue trends over time  
- Identify high-value customers  
- Measure customer retention and churn  
- Perform cohort-based analysis  
- Evaluate month-over-month revenue growth  

---

## Dataset
Brazilian E-Commerce Public Dataset (Olist)  
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce  

---

## Tools & Techniques
- SQL (MySQL)
- Joins and Aggregations
- Common Table Expressions (CTEs)
- Window Functions
- Date Functions

---

## Analysis Performed

### Revenue Analysis
- Total revenue calculation  
- Monthly revenue trend  
- Top products by revenue  
- Top customers by spending  

### Customer Analysis
- Repeat vs one-time customers  
- Average orders per customer  
- Customer Lifetime Value (CLV)  

### Retention Analysis
- Monthly customer retention rate  
- Identification of non-returning customers  

### Cohort Analysis
- Customer segmentation based on first purchase month  
- Retention tracking across cohorts  

### Advanced Analysis
- Customer ranking using window functions  
- Running total of revenue  
- Month-over-month revenue growth  

---

## Key Insights
- A small group of customers contributes a significant portion of total revenue  
- A large percentage of customers make only one purchase  
- Customer retention declines after the initial purchase period  
- Repeat customers drive long-term revenue  
- Revenue trends vary across months, indicating seasonal patterns  

---

## Project Structure
```
ecommerce-customer-analytics-project
│
├── dataset_link.txt
├── SQL_Analysis
│   ├── 01_data_exploration.sql
│   ├── 02_revenue_analysis.sql
│   ├── 03_customer_analysis.sql
│   ├── 04_retention_analysis.sql
│   ├── 05_cohort_analysis.sql
│   ├── 06_advanced_analysis.sql
│
├── insights.md
└── README.md
```

---

## How to Use
1. Download the dataset from the link provided  
2. Import the data into MySQL  
3. Execute SQL scripts from the SQL_Analysis folder  
4. Review outputs and insights  

---

## Conclusion
This project demonstrates end-to-end data analysis using SQL, covering data exploration, revenue analysis, customer behavior, and retention modeling.  
It highlights how SQL can be used to generate actionable insights for business decision-making.
