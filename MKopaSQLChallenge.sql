#1.	Select all the male customers from outside Nairobi.
SELECT * FROM assessmentcustomers
WHERE Gender = 'Male' AND Town != 'Nairobi';

#2.	Select all the customers with an extra column containing the age they were when they joined. Name this column AgeWhenJoining.
SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining
FROM assessmentcustomers;

#3.	Using the table above, calculate the average customer age when joining. Use a sub-query, CTE or temporary table.
WITH customerage AS 
(SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining FROM assessmentcustomers)
SELECT AVG(AgeWhenJoining) FROM customerage;

#4.	Still using the same table, calculate the average, maximum and minimum customer age when joining per gender.
WITH customerage AS 
(SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining FROM assessmentcustomers)
SELECT Gender, AVG(AgeWhenJoining) AS Average, MAX(AgeWhenJoining) AS Maximum, MIN(AgeWhenJoining) AS Minimum FROM customerage
GROUP BY Gender;

#5.	Select the 100 customers who generated the most sales. Show their MartCustomerId, Town and the number of sales each of them generated.
SELECT assessmentcustomers.MartCustomerId, assessmentcustomers.Town, COUNT(assessmentsales.MartLoanId) AS Numberofsales FROM assessmentcustomers
LEFT JOIN assessmentsales ON assessmentcustomers.MartCustomerId = assessmentsales.MartCustomerId
GROUP BY assessmentcustomers.MartCustomerId
ORDER BY Numberofsales DESC 
LIMIT 100;

#6.	How many customers have no sale? Show only the number of customers.
SELECT COUNT(MartCustomerId) AS CustomersWithNoSales FROM assessmentcustomers
WHERE NOT EXISTS (SELECT MartCustomerId FROM assessmentsales WHERE assessmentcustomers.MartCustomerId = assessmentsales.MartCustomerId);

#7.	Select all the AssessmentSales table with an extra column that displays 1 when the ProductSubCategory is 'M-KOPA 4' and 0 for all the other ones. Call it IsMkopa4.
SELECT *, IF(ProductSubCategory = "M-KOPA 4" , 1 , 0) AS IsMkopa4 FROM assessmentsales;

#8.	Select all the AssessmentSales table with an extra column that shows the loan number for each customer:
-- 1 if it's the customer's first sale, 2 if it's the customer's second sale etc.
	#Call it SaleNumber.
 SELECT *, 
 DENSE_RANK() OVER (PARTITION BY MartCustomerId ORDER BY DateOfSale ASC) AS SaleNumber
 FROM assessmentsales;
 
 -- 9 For each customer's age category below (age today), provide the total outstanding balance and the total amount paid in on the 01/08/2018.
 -- The results must all be from a single query.
-- Under 30 years old
-- Between 30 and 49 years old
-- Over 50 years old
 SELECT 
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
GROUP BY AgeCategory;

 
 
 
