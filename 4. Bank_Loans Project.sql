SELECT *
FROM bank_loan_data;

## UPDATING DATA TYPES
ALTER TABLE bank_loan_data
MODIFY COLUMN issue_date DATE;
ALTER TABLE bank_loan_data
MODIFY COLUMN last_credit_pull_date DATE;
ALTER TABLE bank_loan_data
MODIFY COLUMN last_payment_date DATE;
ALTER TABLE bank_loan_data
MODIFY COLUMN next_payment_date DATE;

##SUMMARY DASHBOARD##
#1. TOTAL LOAN APPLICATIONS
SELECT COUNT(id) AS Total_Loan_App
FROM bank_loan_data;

#2. TOTAL FUNDED AMOUNT
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data;

#3. TOTAL AMOUNT RECEIVED
SELECT SUM(total_payment) AS Total_Amount_Rec
FROM bank_loan_data;

#4. AVERAGE INTEREST RATE
SELECT ROUND(AVG(int_rate) * 100,2) AS Avg_Int_Rate
FROM bank_loan_data;

#5. AVERAGE DEBT-TO-INCOME RATIO
SELECT ROUND(AVG(dti) * 100,2) AS Avg_DTI
FROM bank_loan_data;

#6. GOOD VS BAD LOANS APPLICATIONS PERCENTAGE
SELECT 
ROUND((COUNT(CASE WHEN loan_status = "Fully Paid" OR loan_status = "Current" THEN id END) * 100)
/
COUNT(id),2) AS Good_Loan_Perc
FROM bank_loan_data;

SELECT 
ROUND((COUNT(CASE WHEN loan_status = "Charged Off" THEN id END) * 100)
/
COUNT(id),2) AS Bad_Loan_Perc
FROM bank_loan_data;

#7. GOOD VS BAD LOAN APPLICATIONS
SELECT COUNT(id) AS Good_Loan_App
FROM bank_loan_data
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

SELECT COUNT(id) AS Bad_Loan_App
FROM bank_loan_data
WHERE loan_status = "Charged Off";

#8. GOOD VS BAD LOAN FUNDED AMOUNT
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = "Charged Off";

#9. GOOD VS BAD LOAN TOTAL RECEIVED AMOUNT
SELECT SUM(total_payment) AS Good_Loan_Received_Amount
FROM bank_loan_data
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

SELECT SUM(total_payment) AS Bad_Loan_Received_Amount
FROM bank_loan_data
WHERE loan_status = "Charged Off";

#10. LOAN STATUS GRID VIEW
SELECT loan_status,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	ROUND(AVG(int_rate * 100),2) Interest_Rate,
	ROUND(AVG(dti * 100),2) AS DTI
FROM bank_loan_data
GROUP BY loan_status;

##OVERVIEW DASHBOARD##
#1. MONTHLY TRENDS BY ISSUE DATE
SELECT
	MONTH(issue_date) AS Month_Number,
	MONTHNAME(issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_App,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

#2. REGIONAL ANALYSIS BY STATE
SELECT
	address_state,
    COUNT(id) AS Total_Loan_App,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

#3. LOAN TERM ANALYSIS
SELECT
	term,
    COUNT(id) AS Total_Loan_App,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

#4. EMPLOYEE LENGHT ANALYSIS
SELECT
	emp_length,
    COUNT(id) AS Total_Loan_App,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

#5. LOAN PURPOSE BREAKDOWN
SELECT
	purpose,
    COUNT(id) AS Total_Loan_App,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

#6. HOME OWNERSHIP ANALYSIS
SELECT
	home_ownership,
    COUNT(id) AS Total_Loan_App,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;