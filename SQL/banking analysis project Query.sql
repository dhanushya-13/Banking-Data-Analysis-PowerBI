
use BankingDB
go

select count(*) as customer_count
from customers;

select count(*) as account_count
from accounts;

select count(*) as cards_count
from cards;

select count(*) as card_transaction_count
from card_transactions;

select count(*) as employee_count
from employees;

select count(*) as loan_count
from loans;

select count(*) as loan_payment_count
from loan_payments;

select count(*) as transaction_count
from transactions;

select count(*) as branch_count
from branches;

select count(*) as support_tickets_count
from support_tickets;

--understand the data

select distinct account_type
from accounts;

select distinct status
from accounts;

select distinct txn_type
from transactions;

select distinct channel
from transactions;

select distinct loan_type
from loans;

select distinct status
from loans;

--Understand the date range

select min(txn_date) as first_transaction,
       max(txn_date) as last_transaction
from transactions;

select min(start_date) as first_loan,
       max(start_date) as last_loan
from loans;


select min(payment_date) as first_payment,
       max(payment_date) as last_payment
from loan_payments;


select min(open_date) as first_account,
       max(open_date) as last_account
from accounts;


select min(join_date) as first_customer,
       max(join_date) as last_customer
from customers;

select min(issue_date) as first_issue_card,
       max(issue_date) as last_issue_card
from cards;

--frequently value occurs

select account_type, count(*) as account_count
from accounts
group by account_type
order by account_count desc;

select status, count(*) AS account_count
from accounts
group by status
order by account_count desc;

select txn_type, count(*) AS transaction_count
from transactions
group by txn_type
order by transaction_count desc;

select channel, count(*) AS transaction_count
from transactions
group by channel
order by transaction_count desc;

--customers have at least one account
select count(distinct customer_id) as customer_with_accounts
from accounts;

--customers have loans
select count(distinct customer_id) as customer_with_loans
from loans;

--customers have cards
select count(distinct customer_id) as customer_with_cards
from cards;

--accounts have transactions
select count(distinct account_id) as customer_with_accounts
from accounts;

--loans have payment records
select count(distinct loan_id) as customer_with_loan
from loans;

 ---DATA QUALITY & VALIDATION CHECKS
 
select count(*) as missing_income
from customers
where annual_income is null;

select customer_id, count(*)as duplicate_count
from customers
group by customer_id
having count(*) > 1;

select count(*) as orphan_accounts
from accounts a
left join customers c
    ON a.customer_id = c.customer_id
where c.customer_id is null;

select count(*) as invalid_balance
from accounts
where balance < 0;

--business analysis 

-- module 1 : customer analysis

--How many customers does the bank have? 
select count(*) as total_customers
from customers;

--Which states have the most customers?
select * from customers;

select state ,count(distinct customer_id) as total_customers
from customers
group by state
order by total_customers desc;

--How are customers distributed by income?
select
case 
    when annual_income < 500000 then 'below 5lakh'
    when annual_income < 1000000 then ' 5 - 10lakh'
    when annual_income < 2000000 then '10 - 20 5lakh'
    when annual_income < 5000000 then '20 - 50lakh'
    else 'above 50 lakh'
end as income_distribution ,
count(customer_id) as customer_count
from customers 
group by case 
    when annual_income < 500000 then 'below 5lakh'
    when annual_income < 1000000 then ' 5 - 10lakh'
    when annual_income < 2000000 then '10 - 20 5lakh'
    when annual_income < 5000000 then '20 - 50lakh'
    else 'above 50 lakh'
end 
order by income_distribution desc;

--What is the average credit score?
select * from customers

select avg(credit_score) as average_credit_score
from customers;

--How are customers joining over time?
select year(join_date) as join_year,
count(customer_id) as customer_count
from customers 
group by year(join_date )
order by join_year;

---Which customers have the highest annual income?
select top 10 customer_id,name,annual_income
from customers
order by annual_income desc;

---Are high-income customers concentrated in particular locations?
with high_income_customers as
(
select customer_id,name,state,annual_income
from customers
where annual_income >
        (select avg(cast(annual_income as decimal(18,2))) from customers)
)
select state,count(customer_id )as high_income_customers,
             avg(annual_income) as avg_high_income
from high_income_customers
group by state 
order by high_income_customers desc;

---Highest-credit-score customers
select top 20 customer_id,name,credit_score
from customers
order by credit_score desc;

--Which occupations have higher-income customers?
select occupation,
count(customer_id) as customer_count,
avg(cast(annual_income as decimal(18,2))) as avg_high_income
from customers
group by occupation
order by avg_high_income desc;

---module 2 : account analysis

--Which account types are most popular?
select * from accounts;
select account_type,
    count( customer_id) as customer_count
from accounts
group by account_type
order by customer_count desc;

--Which account types hold the highest balances?
select account_type,sum(balance) as total_balance
from accounts
group by account_type
order by total_balance desc;

--How many accounts are Active, Dormant and Closed?
select status,count(distinct  account_id) as accounts_count
from accounts
group by status
order by accounts_count desc;

---What is the total account balance?
select sum(balance) as total_account_balance
from accounts

--Which customers maintain multiple accounts?
select c.customer_id,c.name, count(a.account_id) as number_of_accounts
from customers c
inner join accounts a
on c.customer_id = a.customer_id
group by c.customer_id,c.name
having count(a.account_id) >=2
order by count(a.account_id) desc;
 
--Which branches manage the highest account balances?
select * from accounts;
select * from branches;

select b.branch_name, sum(a.balance)as total_balance
from accounts a
inner join branches b
on a.branch_id = b.branch_id
group by branch_name
order by total_balance desc; 

---How has account opening changed over time?
select year(open_date) as opened_year,
count(account_id ) as number_of_accounts
from accounts
group by  year(open_date)
order by opened_year;

---module 3: transaction analysis

--What is the total transaction value?
select* from transactions;

select sum(amount) as total_transaction_value
from transactions;

--What is the transaction volume?
select count(transaction_id)as transaction_volume
from transactions;

--Which transaction types are most common?
select txn_type ,count(account_id) as number_of_accounts
from transactions
group by txn_type
order by number_of_accounts desc;

--Which channels are most frequently used?
select channel,count(account_id) as number_of_accounts
from transactions
group by channel
order by number_of_accounts desc;

--How do deposits compare with withdrawals?
select txn_type, sum(amount) as total_amount
from transactions
where txn_type in ('deposit','withdrawal')
group by txn_type
order by  total_amount desc;

--How frequently are deposits and withdrawals happening?
select txn_type, sum(amount) as total_amount,
count(transaction_id) as transaction_volume
from transactions
where txn_type in ('deposit','withdrawal')
group by txn_type
order by  total_amount desc;

--Which months have the highest transaction activity?
select year(txn_date) as transaction_year,
       MONTH(txn_date) as transaction_month,
       count(transaction_id) as transaction_volume,
       sum(amount) as transaction_value
from transactions
group by year(txn_date) ,MONTH(txn_date)
order by transaction_volume desc;

--Which customers have the highest transaction activity?
select top 15 c.customer_id,c.name,sum(amount)as transaction_value,
count(t.transaction_id) as transaction_volume
from accounts a
inner join transactions t
on a.account_id = t.account_id
inner join customers c
on a.customer_id = c.customer_id
group by c.customer_id,c.name
order by transaction_value desc

--Which branches generate the highest transaction value?
select * from branches;

select top 10 b.branch_name,b.state,sum(t.amount) as transaction_value
from accounts a
inner join branches b
on a.branch_id = b.branch_id
inner join transactions t
on a.account_id =t.account_id
group by b.branch_name,b.state
order by transaction_value desc; 

--module 4:loan analysis

--What is the total loan amount?
select * from loans

select sum(loan_amount) as total_loan_amount
from loans;

--Which loan types are most common?
select loan_type,count(loan_id) as number_of_loans
from loans
group by loan_type
order by number_of_loans desc;

--Which loan types have the highest value?
select loan_type,sum(loan_amount) as total_loan_amount
from loans
group by loan_type
order by total_loan_amount desc;

--How many loans are Active, Closed, Defaulted and Written Off?
select status,count(loan_id) as number_of_loans
from loans
group by status
order by number_of_loans desc

---What is the average loan amount?
select avg(loan_amount) as average_loan_amount
from loans

--Which states have the highest loan exposure?
select c.state,
sum(loan_amount)as total_loan_amount,
count(loan_id) as no_of_loans
from loans l
inner join customers c
on l.customer_id = c.customer_id
group by c.state
order by total_loan_amount desc;

--How are loan payments progressing?
select* from loan_payments

select year(payment_date) as  payment_year,
       count(payment_id) as no_of_payments,
       sum(amount_paid) as total_amount_paid,
       sum(principal_component) as total_principal_paid,
       sum(interest_component) as total_interest_paid,
       sum
       (case
            when late_payment_flag = 1 then 1 
            else 0 
        end) as late_payments
from loan_payments
group by year(payment_date)
order by  payment_year;

--How has lending changed over time?
select year(start_date) as loan_year,
    count(loan_id) as number_of_loans,
    sum(loan_amount) as total_loan_amount,
    Avg(loan_amount) as average_loan_amount
from loans
group by YEAR(start_date)
order by loan_year;

--module 5 : risk analysis

--What percentage of loans are defaulted?
select count(loan_id) as num_of_loans,
       count(case when status = 'defaulted'then 1 end)as defaulted_loans,
round(count(case when status = 'defaulted'then 1 end) * 100.00/count(loan_id),2) as defaulted_loan_percentage
from loans;

--Which loan types have the highest default rate?
select*from loans

select loan_type,count(loan_id) as num_of_loans,
       count(case when status = 'defaulted'then 1 end)as defaulted_loans,
round(count(case when status = 'defaulted'then 1 end) * 100.00/count(loan_id),2) as defaulted_loan_percentage
from loans
group by loan_type
order by defaulted_loan_percentage desc;

--Which states have higher default rates?
select c.state,count(l.loan_id) as num_of_loans,
       count(case when l.status = 'defaulted'then 1 end)as defaulted_loans,
round(count(case when l.status = 'defaulted'then 1 end) * 100.00/count(l.loan_id),2) as defaulted_loan_percentage
from loans l
inner join customers c
on l.customer_id = c.customer_id
group by c.state
order by defaulted_loan_percentage desc;

--How much money is associated with defaulted loans?
select count(loan_id) as num_of_loans,
       sum(loan_amount) as total_defaulted_loans,
       avg(loan_amount)as average_defaulted_loans
from loans
where status = 'defaulted'

--How much has been written off?
select count(status) as written_off_accounts
from loans
where status = 'written off'

--Which customers have poor credit scores?
select * from customers

select customer_id,name,credit_score   
from customers
where credit_score < 599
order by credit_score;

--Are low-credit-score customers associated with higher loan risk?
select case
          when c.credit_score < 599 then 'poor'
          when c.credit_score <700 then 'good'
          when c.credit_score < 800 then 'fair'
          else 'excellent'
     end as credit_score_segmentation,
     count(case when l.status = 'defaulted'then 1 end)as defaulted_loans,
round(count(case when l.status = 'defaulted'then 1 end) * 100.00/count(l.loan_id),2) as defaulted_rate
from loans l
inner join customers c
on l.customer_id = c.customer_id
group by case
          when c.credit_score < 599 then 'poor'
          when c.credit_score <700 then 'good'
          when c.credit_score < 800 then 'fair'
          else 'excellent'
     end
order by defaulted_rate desc

--Are there unusual/fraudulent card transactions?
select * from card_transactions
select 
    count(card_txn_id) as total_card_transactions,
    count(case when is_fraud = 1 then 1 end) as fraudulent_transactions,
    round(count(case when is_fraud = 1 then 1 end) * 100.0 / count(card_txn_id),2) as fraud_percentage
from card_transactions;

--How are late loan payments distributed?
select
    year(payment_date) as payment_year,
    count(payment_id) as total_payments,
    count(case when late_payment_flag = 1 then 1 end) as late_payments,
   round ( count(case when late_payment_flag = 1 then 1 end) * 100.0 / count(payment_id),  2) as late_payment_percentage
from loan_payments
GROUP BY year(payment_date)
ORDER BY payment_year;

--module 6:branch analysis

--Which branches have the most customers?
select * from branches;

select b.branch_name,
      count(distinct c.customer_id) as number_of_customers
from accounts a
inner join branches b
on a.branch_id = b.branch_id
inner join customers c
on a.customer_id = c.customer_id
group by branch_name
order by number_of_customers desc;

--Which branches manage the highest account balances?
select * from accounts

select top 15 b.branch_name,sum(a.balance) as total_balance
from accounts a
inner join branches b
on a.branch_id = b.branch_id
group by b.branch_name
order by total_balance desc;

--Which branches generate the most transactions?
select * from transactions

select b.branch_name,count(t.transaction_id) as no_of_transactions
from accounts a
inner join transactions t
on a.account_id = t.account_id
inner join branches b
on a.branch_id = b.branch_id
group by b.branch_name
order by no_of_transactions desc;

--Which branches have the highest loan portfolio?
select * from loans

select b.branch_name,sum(l.loan_amount) as total_loan_amount
from branches b
inner join loans l
on b.branch_id = l.branch_id
group by b.branch_name
order by total_loan_amount desc;

--Which branches have the highest number of accounts?
select b.branch_name,count(a.account_id) as num_of_account
from accounts a
inner join branches b
on a.branch_id = b.branch_id
group by b.branch_name
order by num_of_account desc;

--How do branches rank against each other?
select b.branch_name,count(distinct c.customer_id) as no_of_customer,
    rank()over ( order by count(distinct c.customer_id) desc) as branch_rank
from accounts a
inner join customers c
on a.customer_id = c.customer_id
inner join branches b
on a.branch_id = b.branch_id
group by b.branch_name

--Which states have the strongest branch performance?
select * from accounts

select c.state,
      count(distinct c.customer_id) as num_of_customers,
      count(distinct a.account_id) as num_of_accounts,
      sum(balance) as total_balance
from accounts a
inner join branches b
on a.branch_id = b.branch_id
inner join customers c
on a.customer_id = c.customer_id
group by c.state,b.branch_name
order by total_balance desc;

--module 7 : card analysis

--How many cards have been issued?
select * from cards

select count(distinct card_id) as num_of_cards
from cards;

--Which card types are most popular?
select card_type,count(distinct card_id) as no_of_cards
from cards
group by card_type
order by no_of_cards desc;

--How many cards are active/inactive?
select status ,
      count(distinct card_id) as num_of_cards
from cards
group by status
order by num_of_cards desc;

--What is the total card transaction value?
select * from card_transactions

select sum(amount) as total_card_transaction_value
from card_transactions;

--Which channels are used for card transactions?
select * from transactions
select * from card_transactions

select merchant_category,
      count(distinct card_txn_id) as number_of_card_transactions
from card_transactions
group by merchant_category
order by number_of_card_transactions desc;

--What is the monthly card spending trend?
select year(txn_date) as transaction_year,
       month(txn_date) as transaction_month,
       sum(amount) as total_amoount
from card_transactions 
group by year(txn_date),month(txn_date)
order by total_amoount desc;

--Which customers have the highest card activity?
select top 15 c.customer_id,c.name,
    count(ct.card_txn_id) as card_transaction_count
from customers c
inner join cards ca
    on c.customer_id = ca.customer_id
inner join card_transactions ct
    on ca.card_id = ct.card_id
group by  c.customer_id,c.name
order by card_transaction_count desc;

--Are there suspicious/fraudulent card transactions?
select count(card_txn_id) as total_card_transactions,
    count(case when is_fraud = 1 then 1 end) as fraudulent_transactions,
    round( count(case  when is_fraud = 1 then 1  end) * 100.0 / count(card_txn_id),2 ) as fraud_percentage
from card_transactions;

--module 8: supprotive analysis

--How many support tickets were raised?
 select * from support_tickets

 select count(distinct ticket_id) as number_of_support_tickets
 from support_tickets

 --Which issue types are most common?
 select issue_type,
       count(distinct ticket_id)as number_of_support_tickets
from support_tickets
group by issue_type 
order by number_of_support_tickets desc;

--How many tickets are Open, Pending and Resolved?
select status,count(distinct ticket_id) as num_of_support_tickets
from support_tickets
group by status
order by num_of_support_tickets desc;

--Which branches/customers generate more tickets?
select b.branch_name,count(distinct s.customer_id) as no_of_customers,
      count(distinct ticket_id) as num_of_support_tickets
from accounts a
inner join support_tickets s
on a.customer_id = s.customer_id
inner join branches b
on b.branch_id = a.branch_id
group by b.branch_name
order by num_of_support_tickets desc;

select top 15 s.customer_id,c.name,
    count(distinct s.ticket_id) as num_of_support_tickets
from support_tickets s
inner join customers c
on s.customer_id = c.customer_id
group by s.customer_id, c.name
order by num_of_support_tickets desc;
 
 --How long does ticket resolution take?
 select ticket_id,
      datediff (day, date_opened,date_resolved) as resolution_days
from support_tickets
where date_resolved is not null
order by resolution_days desc;

--average resolution takes
select avg (cast (datediff (day,date_opened,date_resolved) as decimal(18,2))) as avg_resolution_days
from support_tickets
where date_resolved is not null;

--compare resolution time by issue type
select issue_type,
       count(distinct ticket_id) as num_of_tickets,
       avg(cast(datediff(day,date_opened,date_resolved) as decimal(10,2))) as avg_resolution_days
from support_tickets
where date_resolved is not null
group by issue_type
order by avg_resolution_days desc;

--What is the customer satisfaction level?
select count(satisfaction_score) AS rated_tickets,
      avg(satisfaction_score) as avg_satisfaction_level
from support_tickets
where satisfaction_score is not null

--Has support volume increased over time?
select year(date_opened) as opened_year,month(date_opened) as opened_month,
      count(distinct ticket_id) as no_of_tickets
from support_tickets
group by year(date_opened),month(date_opened)
order by opened_year,opened_month;

--Which issues have the lowest satisfaction?
select issue_type,
      avg(satisfaction_score) as avg_satisfaction_score
from support_tickets
where satisfaction_score is not null
group by issue_type
order by avg_satisfaction_score;

--result validation

--Customer validation
-- Total customers
SELECT COUNT(DISTINCT customer_id)
FROM customers;

-- Credit score range
SELECT
    MIN(credit_score) AS min_credit_score,
    MAX(credit_score) AS max_credit_score,
    AVG(credit_score) AS avg_credit_score
FROM customers;

--account validation

-- Total accounts
SELECT COUNT(DISTINCT account_id)
FROM accounts;

-- Account status totals
SELECT
    status,
    COUNT(DISTINCT account_id) AS number_of_accounts
FROM accounts
GROUP BY status;

--loan validation

-- Total loans
SELECT COUNT(DISTINCT loan_id)
FROM loans;

-- Loan status totals
SELECT
    status,
    COUNT(DISTINCT loan_id) AS number_of_loans
FROM loans
GROUP BY status;

--transaction validation

-- Transaction count and total value
SELECT
    COUNT(DISTINCT transaction_id) AS transaction_volume,
    SUM(amount) AS transaction_value
FROM transactions;

--support validation

-- Total tickets
SELECT COUNT(DISTINCT ticket_id)
FROM support_tickets;

-- Ticket status distribution
SELECT
    status,
    COUNT(DISTINCT ticket_id) AS ticket_count
FROM support_tickets
GROUP BY status;

--validate module 1
-- 1. Credit score range
SELECT
    MIN(credit_score) AS min_credit_score,
    MAX(credit_score) AS max_credit_score,
    AVG(credit_score) AS avg_credit_score
FROM customers;

-- 2. Income range
SELECT
    MIN(annual_income) AS min_income,
    MAX(annual_income) AS max_income,
    AVG(annual_income) AS avg_income
FROM customers;

-- 3. Total customers by joining year
SELECT
    YEAR(join_date) AS join_year,
    COUNT(DISTINCT customer_id) AS customer_count
FROM customers
GROUP BY YEAR(join_date)
ORDER BY join_year;

SELECT 
    MIN(txn_date) AS min_date,
    MAX(txn_date) AS max_date,
    SUM(amount) AS total_transaction_value
FROM transactions
WHERE YEAR(txn_date) = 2026;
