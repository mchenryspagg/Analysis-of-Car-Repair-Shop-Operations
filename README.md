# A Comprehensive Analysis of a Car Repair Shop’s Operations Using SQL

## Table of contents

- [About](#about)
- [Project Overview](#project-overview)
  - [Objectives](#objectives)
  - [Deliverables](#deliverables)
- [Data](#data)
- [Links](#links)
- [Key Insights](#key-insights)
- [Recommendations](#recommendations)
- [Acknowledgements](#acknowledgements)

## About
This project provides a comprehensive data analysis of a car repair shop’s operations using MySQL, utilizing  an extended dataset of sales receipts. It examines various aspects such as customer spending habits, vehicle characteristics, job frequency, parts utilization, and financial metrics. The analysis identifies patterns and trends, offering actionable recommendations to optimize operations and enhance profitability. Key sections include data ingestion, preparation, and in-depth analysis of business questions, concluding with optimization strategies for success in the competitive automotive repair industry.

## Project Overview
Using extended data of the Car Repair Shop's Sales receipt that can be accessed [here](https://drive.google.com/drive/folders/1Cln8r2a9qNViOwa6Yo6X0vRwFkJ_Rkmj?usp=sharing), answer the following business questions using SQL:

### Objectives

1. **Data Ingestion and Preparation**
   - Import the provided CSV files into a relational database.
   - Ensure that the data is clean, properly formatted, and indexed for efficient querying.

2. **Data Analysis Tasks**

   - **Customer Analysis:**
     - Identify the top 5 customers who have spent the most on vehicle repairs and parts.
     - Determine the average spending of customers on repairs and parts.
     - Analyze the frequency of customer visits and identify any patterns.

   - **Vehicle Analysis:**
     - Calculate the average mileage of vehicles serviced.
     - Identify the most common vehicle makes and models brought in for service.
     - Analyze the distribution of vehicle ages and identify any trends in service requirements based on vehicle age.

   - **Job Performance Analysis:**
     - Determine the most common types of jobs performed and their frequency.
     - Calculate the total revenue generated from each type of job.
     - Identify the jobs with the highest and lowest average costs.

   - **Parts Usage Analysis:**
     - List the top 5 most frequently used parts and their total usage.
     - Calculate the average cost of parts used in repairs.
     - Determine the total revenue generated from parts sales.

   - **Financial Analysis:**
     - Calculate the total revenue generated from labor and parts for each month.
     - Determine the overall profitability of the repair shop.
     - Analyze the impact of sales tax on the total revenue.

3. **Optimization Recommendations**
   - Based on your analysis, provide actionable recommendations to optimize operations, such as:
     - Identifying underperforming services that may need improvement or marketing efforts.
     - Suggesting parts that should be kept in higher stock due to frequent usage.
     - Proposing customer loyalty programs for top-spending customers.
     - Recommending scheduling adjustments to better manage frequent job types.

### Deliverables

1. **Database Setup:**
   - A relational database containing the imported data from the CSV files.
   - SQL scripts used to create tables and import data.

2. **Analysis Report:**
   - A comprehensive report detailing your analysis, findings, and insights (add screenshots of your query results).
   - SQL queries used for data analysis.

3. **Visualizations:**
   - Graphs and charts illustrating key findings from your analysis.

  
## Data
- Direct Source: [Link](https://drive.google.com/drive/folders/1Cln8r2a9qNViOwa6Yo6X0vRwFkJ_Rkmj?usp=sharing)
- Downloaded:
  - [customer](./customer.csv)
  - [invoice](./invoice.csv)
  - [parts](./parts.csv)
  - [vehicle](./vehicle.csv)
  - [job](./job.csv)

    
## Links
- PDF Report showing the detailed report of the entire project and its deliverables - [Link](https://drive.google.com/file/d/1ldh_r66RXDlFUbvpuLJyBYAgYG7j5CRz/view?usp=sharing)
- Jupyter Notebook showing the entire analysis and visualizations made using SQL & Python libraries - [Link](https://github.com/mchenryspagg/An-Analysis-of-a-Car-Repair-Shop-Operations/blob/main/HNG%20Task%205b%20-%20Visualization%20of%20Trends%20%26%20Patterns.ipynb)


## Key Insights
- Top Customers: The top 5 customers by spending are Jennifer Robinson, David Wilson, Emily Brown, Michael Smith, and Sarah Johnson.
  
  ![image](https://github.com/user-attachments/assets/2c86d52d-631e-400b-8e8f-bfcd69cd2e43)

- Average Spending: Customers spend an average of CAD 378.00 on repairs and CAD 406.97 on parts.
  
- Vehicle Trends: Older vehicles (4-12 years) cost more to service, with higher expenses on parts.
  
  ![image](https://github.com/user-attachments/assets/d12a529c-faeb-4011-b448-c69e55c44ad7)

- Job Performance: The highest revenue-generating job is “Replace front CV Axel,” while “Replace air filter” has the lowest average cost.
  
  ![image](https://github.com/user-attachments/assets/0b5d4023-3f65-4622-a865-2e8836a3d70e)

- Parts Usage: “Wheel weights” and “Spark Plugs” are the most frequently used parts.
  
  ![image](https://github.com/user-attachments/assets/329a6544-eadf-4eab-8e19-30f38a7dfaa2)

- Financial Metrics: Total revenue from labor and parts in November 2023 was CAD 3924.87, with sales tax accounting for 8.7% of total revenue.
  
  ![image](https://github.com/user-attachments/assets/7d946181-27cd-4bac-b7a7-a98e752d8fa7)


## Recommendations
Here are the key recommendations from the analysis:

- **Identify Underperforming Services**: Analyze job types and frequencies to identify services that may need price adjustments or marketing efforts.
- **Parts Inventory Management**: Keep frequently used parts like "Wheel weights" and "Spark Plugs" in higher stock to ensure availability and reduce wait times.
- **Customer Loyalty Programs**: Implement rewards or discounts for top-spending customers to foster loyalty and repeat business.
- **Scheduling Adjustments**: Allocate more resources or staff for frequently performed jobs during peak hours to reduce wait times. 

These recommendations aim to optimize operations and enhance profitability for the car repair shop.


## Acknowledgements
This project is part of the project requirements necessary to graduate from Stage 5 at HNG 11 internship for the Data Analyst Track. Special appreciation to the organizers of the [HNG internship](https://hng.tech/internship), and to my esteemed team members in the data analyst track.
