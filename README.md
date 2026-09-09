# 🏦 Banking Data Analysis & Power BI Dashboard

An end-to-end banking data analysis and Business Intelligence project using SQL Server and Microsoft Power BI to analyse customer behaviour, account activity, transactions, loan risk, branch performance, card usage, fraud and customer support.

This project demonstrates how a large-scale relational banking dataset can be transformed into meaningful business insights using SQL analysis, data validation, Power BI data modelling, DAX calculations and interactive dashboards.

---

## 📌 Overview

The banking industry generates large volumes of data through customers, accounts, transactions, loans, cards, branches and customer support services. Analysing these interconnected datasets is essential for understanding customer behaviour, monitoring financial activity, identifying risk and improving business decision-making.

This project focuses on analysing a large-scale banking database containing **5.2M+ records** across multiple interconnected tables.

The project follows an end-to-end Business Intelligence workflow:

**Data Understanding → Business Problem Identification → KPI Identification → SQL Analysis → Data Validation → Power BI Data Modelling → DAX Development → Dashboard Development → Business Insights → Recommendations**

The final solution provides interactive dashboards for different banking business areas along with an Executive Dashboard for a consolidated management-level view.

---

## 🎯 Objectives

The main objectives of this project are:

- Analyse customer demographics, income and credit profiles.
- Understand customer distribution across different locations.
- Analyse account types, balances and account status.
- Study account opening trends and customer account ownership.
- Analyse transaction volume, value, type and channel.
- Evaluate loan portfolios and loan default behaviour.
- Analyse credit-risk segments and loan performance.
- Compare branch-level customers, balances, transactions and loan portfolios.
- Analyse card types, card status and card spending behaviour.
- Identify fraudulent card transactions.
- Analyse customer support tickets, issue types and resolution performance.
- Create meaningful KPIs using DAX.
- Develop interactive Power BI dashboards.
- Generate meaningful business insights and recommendations.
- Demonstrate an end-to-end SQL and Business Intelligence workflow.

---

## 📂 Dataset

The project uses a large-scale relational banking dataset containing **5.2M+ records**.

The database consists of multiple interconnected tables representing different banking entities.

| Table | Purpose | Important Fields |
|---|---|---|
| `customers` | Customer master information | customer_id, name, gender, city, state, annual_income, join_date, credit_score |
| `accounts` | Bank account information | account_id, customer_id, branch_id, account_type, balance, open_date, status |
| `branches` | Branch master information | branch_id, branch_name, city, state, opened_date, ifsc_code |
| `transactions` | Account transaction records | transaction_id, account_id, txn_date, txn_type, channel, amount |
| `loans` | Loan information | loan_id, customer_id, branch_id, loan_type, loan_amount, status, start_date |
| `loan_payments` | Loan repayment information | payment_id, loan_id, payment_date, amount_paid, principal_component, interest_component, late_payment_flag |
| `cards` | Card master information | card_id, customer_id, account_id, card_type, issue_date, expiry_date, credit_limit, status |
| `card_transactions` | Card transaction records | card_txn_id, card_id, txn_date, merchant_category, amount, is_fraud |
| `support_tickets` | Customer support information | ticket_id, customer_id, issue_type, status, date_opened, date_resolved, satisfaction_score |
| `employees` | Employee information | employee_id, name, branch_id, role, hire_date, salary |

### Dataset Scale

- 👥 Approximately **60K Customers**
- 🏦 Approximately **95K Accounts**
- 💰 Approximately **22K Loans**
- 💳 Approximately **65K Cards**
- 💸 Approximately **2M Account Transactions**
- 💳 Approximately **3M Card Transactions**
- 🎧 Approximately **25K Support Tickets**
- 🏢 Approximately **150 Branches**

---

## 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **SQL Server** | Database management and SQL analysis |
| **SQL** | Data exploration, transformation and analytical queries |
| **Power BI** | Interactive dashboard development |
| **DAX** | KPI measures and calculated columns |
| **Microsoft Excel** | Data inspection and supporting analysis |
| **CSV** | Source data format |
| **Power BI Data Model** | Table relationships and filter flow |
| **Date Table** | Time-based analysis |
| **Power BI Slicers** | Interactive filtering |
| **KPI Cards** | Key metric presentation |
| **GitHub** | Project version control and portfolio presentation |

---
## 🗄 Database Structure

The banking database follows a relational structure in which multiple tables are connected through primary keys and foreign keys.

The database contains interconnected entities representing customers, accounts, branches, transactions, loans, loan payments, cards, card transactions, support tickets and employees.

### Main relationship
Customers
   │
   ├── Accounts
   │      ├── Transactions
   │      └── Cards
   │             └── Card Transactions
   │
   ├── Loans
   │      └── Loan Payments
   │
   └── Support Tickets

Branches
   ├── Accounts
   ├── Loans
   └── Employees

## Business Problem Areas

The project was divided into eight major business problem areas.

| No. | Business Area        | Main Focus                                          |
| --: | -------------------- | --------------------------------------------------- |
|   1 | Customer Analysis    | Customer demographics, income, credit and geography |
|   2 | Account Analysis     | Account types, status, balances and ownership       |
|   3 | Transaction Analysis | Transaction volume, value, type, channel and trends |
|   4 | Loan & Risk Analysis | Loan portfolio, defaults and credit risk            |
|   5 | Branch Analysis      | Branch customers, balances, transactions and loans  |
|   6 | Card Analysis        | Card usage, spending and fraud                      |
|   7 | Support Analysis     | Tickets, issues, resolution and service performance |
|   8 | Executive Dashboard  | Consolidated management-level overview              |



## 🧮 SQL Analysis

SQL Server was used to analyse the banking database and generate business insights through querying, filtering, aggregation and table joins.

### Analysis Areas

- 👥 **Customer:** Demographics, income, credit score and geography
- 🏦 **Account:** Account types, status, balances and ownership
- 💸 **Transaction:** Volume, value, types, channels and trends
- 💰 **Loan:** Loan portfolio, types, status and defaults
- ⚠️ **Risk:** Default rate, credit segments and loan exposure
- 🏢 **Branch:** Customers, balances, transactions and loan portfolio
- 💳 **Card:** Card usage, spending and fraud
- 🎧 **Support:** Tickets, issues, resolution and satisfaction

### SQL Techniques

`SELECT` · `WHERE` · `GROUP BY` · `JOIN` · `CASE` · Aggregate Functions · Subqueries · CTEs · `ROW_NUMBER()` · `RANK()` · `LAG()` · `LEAD()` · Date Functions

### 📄 Complete SQL Queries

👉 [View SQL Queries](SQL/banking%20analysis%20project%20Query.sql)

### 📊 DAX Analysis

DAX was used in Power BI to create analytical measures and calculated columns required for dashboard KPIs and business analysis.

### Key DAX Measures
Total Customers
Total Accounts
Total Account Balance
Average Account Balance
Active Accounts
Total Transactions
Total Transaction Value
Average Transaction Amount
Total Loans
Total Loan Amount
Average Loan Amount
Default Rate
Total Branches
Total Cards
Active Cards
Total Card Transaction Value
Fraudulent Transactions
Fraud Percentage
Total Support Tickets
Average Resolution Days
Average Satisfaction Score

### Calculated Columns
The project also uses calculated columns such as:

Credit Segment
Fraud Status
Transaction Year
Support Year

### 📄 Complete DAX Measures
👉 [View DAX Measures](DAX/Banking%20analysis%20DAX%20measures.txt)

## 📈 Power BI Dashboard

An interactive **Power BI dashboard** was developed to analyse banking performance and generate business insights across eight key areas:

- 🏠 **Executive Dashboard** – Overall banking KPIs and insights
- 👥 **Customer Analysis** – Demographics, income and credit profile
- 🏦 **Account Analysis** – Accounts, balances and account status
- 💸 **Transaction Analysis** – Transaction volume, value and trends
- 💰 **Loan & Risk Analysis** – Loan portfolio, defaults and credit risk
- 🏢 **Branch Analysis** – Branch performance and financial activity
- 💳 **Card Analysis** – Card usage, spending and fraud
- 🎧 **Support Analysis** – Tickets, resolution and service performance

### Dashboard Features

- Interactive KPI cards
- Business-focused visualizations
- Interactive slicers and filters
- Cross-page navigation
- Consistent dashboard design
- Data-driven business insights
  
### 📸 Dashboard Screenshots

Click the links below to view the individual dashboard screenshots.
| Dashboard            | Screenshot                                                 |
| -------------------- | ---------------------------------------------------------- |
| Executive Dashboard  | [View Screenshot](Screenshots/1_Analysis%20-%20Executive%20page.PNG ) |
| Customer Analysis    | [View Screenshot](Screenshots/2_Analysis%20-%20customer%20page.PNG )  |
| Account Analysis     | [View Screenshot](Screenshots/3_Analysis%20-%20%20accounts%20page.PNG ) |
| Transaction Analysis | [View Screenshot](Screenshots/4_Analysis%20-%20Transaction%20page.PNG ) |
| Loan & Risk Analysis | [View Screenshot](Screenshots/5_Analysis%20-Loan%20%20%26%20Risk%20page.PNG)   |
| Branch Analysis      | [View Screenshot](Screenshots/6_Analysis%20-%20Branch%20page.PNG )      |
| Card Analysis        | [View Screenshot]( Screenshots/7_Analysis%20-Card%20page.PNG)        |
| Support Analysis     | [View Screenshot](  Screenshots/8_Analysis%20-support%20page.PNG)     |

## 🔑 Key Findings
### 👥 Customer Insights
Approximately 60K customers were analysed.
Maharashtra has the highest customer concentration among the analysed states.
Approximately 45% of customers belong to the Above 20L income group.
Customer analysis provides insights into income, geography and credit profiles.
### 🏦 Account Insights
Approximately 95K accounts were analysed.
Savings accounts hold the largest share of the total account balance.
Approximately 81K accounts are active.
Total account balance is approximately ₹4.35B.
Account-level analysis helps identify balance concentration and account preferences.
### 💸 Transaction Insights
Approximately 2M account transactions were analysed.
Total account transaction value is approximately ₹12.10B.
Average transaction amount is approximately ₹6.05K.
Transaction analysis provides insights into banking activity, transaction types and channels.
### 💰 Loan & Risk Insights
Approximately 22K loans were analysed.
Total loan portfolio is approximately ₹9.21B.
Average loan amount is approximately ₹418.85K.
Overall loan default rate is approximately 7.25%.
The Fair credit segment shows the highest default rate among the analysed credit segments.
### 🏢 Branch Insights
Approximately 150 branches were analysed.
Kochi and Bhopal show strong customer and transaction activity.
Kochi has the highest branch balance among the analysed branches.
Branch-level analysis helps compare customer concentration, balances, transactions and loan portfolios.
### 💳 Card Insights
Approximately 65K cards were analysed.
Approximately 57K cards are active.
Approximately 3M card transactions were analysed.
Approximately 14,954 fraudulent transactions were identified.
Fraudulent transactions represent approximately 0.50% of card transactions.
Card transaction analysis helps monitor spending patterns and potential fraud.
### 🎧 Support Insights
Approximately 25K support tickets were analysed.
Average resolution time is approximately 9.49 days.
Average satisfaction score is approximately 3.0/5.
Support analysis helps identify ticket volume and operational service performance.

## 🔄 Project Workflow

The complete project follows a structured Business Intelligence workflow.
Data Understanding
        ↓
Business Problem Identification
        ↓
KPI Identification
        ↓
SQL Analysis
        ↓
Data Validation
        ↓
Power BI Data Modelling
        ↓
DAX Development
        ↓
Dashboard Development
        ↓
Business Insights
        ↓
Recommendations

## ✅ Data Quality & Validation

Data quality checks were performed before dashboard development to ensure that the dataset was suitable for analysis.

### Validation Process
Duplicate checks
Null-value checks
Primary-key validation
Foreign-key validation
Relationship validation
Date-range validation
SQL result validation
Power BI measure validation
Relationship ambiguity checks

### ⚠️ Important Temporal Note

The transaction data ends on 30 June 2026.

Therefore, the year 2026 contains only January–June data and should not be interpreted as a complete-year decline when compared with previous years.

# 📊 Power BI Dashboard File

The complete Power BI .pbix file is hosted externally because the file size exceeds GitHub's standard repository file limit.

👉 [Download Power BI Dashboard.(pbix)](https://drive.google.com/file/d/12sh7geLjgABdrZXMKs-guiVfElVaQclJ/view?usp=sharing)

## 🏆 Project Outcomes

- Successfully analysed a **5.2M+ record banking dataset** using SQL Server and Power BI.
- Built and validated a **relational banking database** with connected tables and relationships.
- Performed analysis across **Customer, Account, Transaction, Loan & Risk, Branch, Card and Support** areas.
- Applied SQL techniques including **JOINs, Subqueries, CTEs and Window Functions** for business analysis.
- Developed **DAX measures and calculated columns** for KPIs and analytical calculations.
- Built an interactive **8-page Power BI dashboard** with KPIs, visualizations, slicers and navigation.
- Identified meaningful insights related to **customer behaviour, financial activity, loan risk, branch performance, card fraud and customer support**.
- Developed **business recommendations** based on the analytical findings.
- Demonstrated an end-to-end **Data Analytics & Business Intelligence workflow** from raw data to actionable insights.

## 👩‍💻 Author

Dhanushya R

Data Science | SQL | Power BI | DAX | Data Analytics

### 🔗 Project Resources
| Resource                 | Link                                                                   |
| ------------------------ | ---------------------------------------------------------------------- |
| 🧮 SQL Queries           | [View SQL Queries](SQL/banking%20analysis%20project%20Query.sql)       |
| 📊 DAX Measures          | [View DAX Measures](DAX/Banking%20analysis%20DAX%20measures.txt)       |
| 📚 Project Documentation | [View Project Documentation](Documentation/Banking_Project_Report.pdf) |
| 📈 Power BI Dashboard    | [Download Power BI Dashboard (.pbix)](https://drive.google.com/file/d/12sh7geLjgABdrZXMKs-guiVfElVaQclJ/view?usp=sharing))          |
