# M-Kopa-mini-challenge
SQL Test From M-kopa 
Tables 
AssessmentCustomers

![image](https://user-images.githubusercontent.com/10958742/123120438-fa7c8680-d44c-11eb-86d5-c7a9b3d0e67f.png)

AssessmentSales

![image](https://user-images.githubusercontent.com/10958742/123120502-09fbcf80-d44d-11eb-999a-77d7d859fb2f.png)

AssessmentDailyLoanInfo

__NB: A loan is created for each sale. This table includes the outstanding balance and the total amount paid for each loan every day after the sale is made._

![image](https://user-images.githubusercontent.com/10958742/123120523-0f591a00-d44d-11eb-9c6f-6c79cb6e167c.png)

**QUESTIONS**
1. Select all the male customers from outside Nairobi.
2. Select all the customers with an extra column containing the age they were when they joined. Name this column AgeWhenJoining.
3. Using the table above, calculate the average customer age when joining. Use a sub-query, CTE or temporary table.
4. Still using the same table, calculate the average, maximum and minimum customer age when joining per gender.
5. Select the 100 customers who generated the most sales. Show their MartCustomerId, Town and the number of sales each of them generated.
6. How many customers have no sale? Show only the number of customers.
7. Select all the AssessmentSales table with an extra column that displays 1 when the ProductSubCategory is 'M-KOPA 4' and 0 for all the other ones. Call it IsMkopa4.
8. Select all the AssessmentSales table with an extra column that shows the loan number for each customer: 1 if it's the customer's first sale, 2 if it's the customer's second sale etc. Call it SaleNumber.
9. For each customer's age category below (age today), provide the total outstanding balance and the total amount paid in on the 01/08/2018. The results must all be from a single query.
- Under 30 years old
-  Between 30 and 49 years old
- Over 50 years old

**ANSWERS**
**Select all the male customers from outside Nairobi.**

`SELECT * FROM assessmentcustomers
WHERE Gender = 'Male' AND Town != 'Nairobi';`

**Select all the customers with an extra column containing the age they were when they joined. Name this column AgeWhenJoining.**

`SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining

FROM assessmentcustomers;`

**Using the table above, calculate the average customer age when joining. Use a sub-query, CTE or temporary table.**

`WITH customerage AS 

(SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining FROM assessmentcustomers)

SELECT AVG(AgeWhenJoining) FROM customerage;`

**Still using the same table, calculate the average, maximum and minimum customer age when joining per gender.**

`WITH customerage AS 

(SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining FROM assessmentcustomers)

SELECT Gender, AVG(AgeWhenJoining) AS Average, MAX(AgeWhenJoining) AS Maximum, MIN(AgeWhenJoining) AS Minimum FROM customerage

GROUP BY Gender;`

**Select the 100 customers who generated the most sales. Show their MartCustomerId, Town and the number of sales each of them generated.**

`SELECT assessmentcustomers.MartCustomerId, assessmentcustomers.Town, COUNT(assessmentsales.MartLoanId) AS Numberofsales FROM assessmentcustomers

LEFT JOIN assessmentsales ON assessmentcustomers.MartCustomerId = assessmentsales.MartCustomerId

GROUP BY assessmentcustomers.MartCustomerId

ORDER BY Numberofsales DESC 

LIMIT 100;`

**How many customers have no sale? Show only the number of customers.**

`SELECT COUNT(MartCustomerId) AS CustomersWithNoSales FROM assessmentcustomers

WHERE NOT EXISTS (SELECT MartCustomerId FROM assessmentsales WHERE assessmentcustomers.MartCustomerId = assessmentsales.MartCustomerId);`

**Select all the AssessmentSales table with an extra column that displays 1 when the ProductSubCategory is 'M-KOPA 4' and 0 for all the other ones. Call it IsMkopa4.**

` SELECT *, 

 DENSE_RANK() OVER (PARTITION BY MartCustomerId ORDER BY DateOfSale ASC) AS SaleNumber
 
 FROM assessmentsales;`

**For each customer's age category below (age today), provide the total outstanding balance and the total amount paid in on the 01/08/2018. The results must all be from a single query.
- Under 30 years old
-  Between 30 and 49 years old
- Over 50 years old**
- 
` SELECT 

    (CASE
    
        WHEN YEAR(NOW()) - YEAR(DateOfBirth) < 30 THEN 'UnderThirty'
        
        WHEN YEAR(NOW()) - YEAR(DateOfBirth) BETWEEN 30 AND 49 THEN 'Betweenthirtyandforty'
        
        ELSE 'overfiftyyears'
        
    END) AS AgeCategory,
    
    assessmentdailyloaninfo.Outstandingbalance,
    
    assessmentdailyloaninfo.SumPaidInToDate
    
FROM

    assessmentcustomers
    
        LEFT JOIN
        
    assessmentsales ON assessmentcustomers.MartCustomerId = assessmentsales.MartCustomerId
    
        LEFT JOIN
        
    assessmentdailyloaninfo ON assessmentsales.MartLoanId = assessmentdailyloaninfo.MartLoanId
    
WHERE

    ActivityDate = '2018-08-01'
    
GROUP BY AgeCategory;`
