Eco Essentials: Modern Enterprise Data Warehouse Project

Overview
This project involved the end-to-end design and implementation of an Enterprise Data Warehouse for a fictitious company, Eco Essentials. Its objective was to transition raw transactional and marketing data into a centralized, easily queryable dimensional model to enhance reporting capabilities and identify sales trends, especially as they related to a set of marketing campaigns.

Business Problem
Eco Essentials leadership required the following:
* Analysis of the Sales Process, including key performance indicators (KPIs) across different regions, and the identification of sales trends over time.

* Tracking of Marketing Campaign Performance to determine which campaigns drove the most revenue.

Architecture and Tech
This project utilizes cloud-based data  to perform Extract, Load, and Transform (ELT) processes:
* Data Sources: Amazon RDS PostgreSQL, Amazon S3
* Data Ingestion (EL): Fivetran
* Data Warehouse: Snowflake
* Data Transformation: dbt (Data Build Tool)
* Data Visualization: Tableau

Data Sources
The data pipeline integrates two distinct sources:
* Transactional Database: Online purchase data stored in a PostgreSQL database hosted on Amazon RDS.
* Marketing Events: Salesforce Marketing Cloud email events stored as CSV files in an AWS S3 Bucket.

Data Modeling
The data was modeled using Kimball's dimensional modeling techniques.
* Bus Matrix and Star Schema: Identified the above key business processes, with declared grain.
* Enterprise Integration: The two distinct star schemas were combined into a single, cohesive data warehouse utilizing conformed dimensions.
* Surrogate Keys: Generated utilizing hashes to link dimension and fact tables.

Data Pipeline
* Extract and Load: Configured Fivetran connectors to incrementally extract data from PostgreSQL and S3, landing the raw data securely into staging schemas within Snowflake.
* Transform: Developed dbt models to clean, stage, and transform the raw data into our final fact and dimension tables.
* Data Quality and Testing: Implemented data quality checks using dbt's built-in testing framework. Tests include the following:
unique
not_null
accepted_values
relationships (for referential integrity)
* Scheduling: The pipeline is fully automated. Fivetran syncs are scheduled every 24 hours, followed by a daily dbt job run that rebuilds the dimensional models and runs all.

Analytics and Visualization
To answer Eco Essentials' core business questions, the final dimensional model was connected directly to Tableau via a live Snowflake connection.

Core Business Questions Recap:
* Campaign ROI: Which marketing campaigns generated the highest revenue for Eco Essentials?
* Geographic Performance: How do key performance indicators, such as total revenue and conversion rates, break down by state?
* Trends: What are the historical trends for sales volume and marketing campaigns over time?

The final deliverable includes a Tableau dashboard tailored for Eco Essentials leadership, highlighting the answers to these business questions.


Repository Structure:
* The /models directory contains all dbt transformations, including staging, dimensions, and facts.
* The /tests directory showcases the data quality constraints applied to the models.
