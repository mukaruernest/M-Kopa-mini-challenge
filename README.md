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

**Q1. Select all the male customers from outside Nairobi.**
  ``` SQL
  SELECT * FROM assessmentcustomers
  WHERE Gender = 'Male' AND Town != 'Nairobi';
  ```
Results

<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1">MartCustomerId</th>
<th title="Field #2">Gender</th>
<th title="Field #3">Town</th>
<th title="Field #4">DateOfBirth</th>
<th title="Field #5">JoiningDate</th>
</tr></thead>
<tbody><tr>
<td align="right">981683</td>
<td>Male</td>
<td>Kilifi</td>
<td>1993-01-01 00:00:00</td>
<td>2018-07-05 07:06:40</td>
</tr>
<tr>
<td align="right">955015</td>
<td>Male</td>
<td>Kakamega</td>
<td>1992-03-07 00:00:00</td>
<td>2018-03-23 11:30:17</td>
</tr>
<tr>
<td align="right">952475</td>
<td>Male</td>
<td>Meru</td>
<td>1953-01-01 00:00:00</td>
<td>2018-03-14 06:58:08</td>
</tr>
</tbody></table>




**Q2. Select all the customers with an extra column containing the age they were when they joined. Name this column AgeWhenJoining.**
Select all the customers with an extra column containing the age they were when they joined. Name this column AgeWhenJoining.
  ```SQL
  SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining
  FROM assessmentcustomers;
  ```
Results 
<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1">MartCustomerId</th>
<th title="Field #2">Gender</th>
<th title="Field #3">Town</th>
<th title="Field #4">DateOfBirth</th>
<th title="Field #5">JoiningDate</th>
<th title="Field #6">AgeWhenJoining</th>
</tr></thead>
<tbody><tr>
<td align="right">935816</td>
<td>Female</td>
<td>Marsabit</td>
<td>1966-01-01 00:00:00</td>
<td>2018-01-13 12:54:53</td>
<td>52</td>
</tr>
<tr>
<td align="right">936167</td>
<td>Female</td>
<td>Migori</td>
<td>1959-01-01 00:00:00</td>
<td>2018-01-15 07:55:46</td>
<td>59</td>
</tr>
<tr>
<td align="right">952475</td>
<td>Male</td>
<td>Meru</td>
<td>1953-01-01 00:00:00</td>
<td>2018-03-14 06:58:08</td>
<td>65</td>
</tr>
<tr>
<td align="right">955015</td>
<td>Male</td>
<td>Kakamega</td>
<td>1992-03-07 00:00:00</td>
<td>2018-03-23 11:30:17</td>
<td>26</td>
</tr>
<tr>
<td align="right">963022</td>
<td>Female</td>
<td>Trans Nzoia</td>
<td>1980-01-01 00:00:00</td>
<td>2018-04-21 07:19:01</td>
<td>38</td>
</tr>
<tr>
<td align="right">981683</td>
<td>Male</td>
<td>Kilifi</td>
<td>1993-01-01 00:00:00</td>
<td>2018-07-05 07:06:40</td>
<td>25</td>
</tr>
</tbody></table>

**Q3. Using the table above, calculate the average customer age when joining. Use a sub-query, CTE or temporary table.**
```SQL
WITH customerage AS 
(SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining FROM assessmentcustomers)
SELECT AVG(AgeWhenJoining) FROM customerage;
```
Results
<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1">AverageCustomerAge</th>
</tr></thead>
<tbody><tr>
<td align="centre">44.1667</td>
</tr>
</tbody></table>

**Q4. Still using the same table, calculate the average, maximum and minimum customer age when joining per gender.**
```SQL
WITH customerage AS 
(SELECT *, YEAR(JoiningDate) - YEAR(DateofBirth) AS AgeWhenJoining FROM assessmentcustomers)
SELECT Gender, AVG(AgeWhenJoining) AS Average, MAX(AgeWhenJoining) AS Maximum, MIN(AgeWhenJoining) AS Minimum FROM customerage
GROUP BY Gender;
```
Results
<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1">Gender</th>
<th title="Field #2">AverageAge</th>
<th title="Field #3">MaximumAge</th>
<th title="Field #4">MiniumAge</th>
</tr></thead>
<tbody><tr>
<td>Female</td>
<td align="right">49</td>
<td align="right">59</td>
<td align="right">38</td>
</tr>
<tr>
<td>Male</td>
<td align="right">38</td>
<td align="right">65</td>
<td align="right">25</td>
</tr>
</tbody></table>

**Q5. Select the 100 customers who generated the most sales. Show their MartCustomerId, Town and the number of sales each of them generated.**
```SQL
SELECT assessmentcustomers.MartCustomerId, assessmentcustomers.Town, COUNT(assessmentsales.MartLoanId) AS Numberofsales FROM assessmentcustomers
LEFT JOIN assessmentsales ON assessmentcustomers.MartCustomerId = assessmentsales.MartCustomerId
GROUP BY assessmentcustomers.MartCustomerId
ORDER BY Numberofsales DESC 
LIMIT 100;
```
Results
<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1">MartCustomerId</th>
<th title="Field #2">Town</th>
<th title="Field #3">Numberofsales</th>
</tr></thead>
<tbody><tr>
<td align="right">935816</td>
<td>Marsabit</td>
<td>0</td>
</tr>
<tr>
<td align="right">936167</td>
<td>Migori</td>
<td>0</td>
</tr>
<tr>
<td align="right">952475</td>
<td>Meru</td>
<td>0</td>
</tr>
<tr>
<td align="right">955015</td>
<td>Kakamega</td>
<td>0</td>
</tr>
<tr>
<td align="right">963022</td>
<td>Trans Nzoia</td>
<td>0</td>
</tr>
<tr>
<td align="right">981683</td>
<td>Kilifi</td>
<td>0</td>
</tr>
</tbody></table>

**Q6. How many customers have no sale? Show only the number of customers.**
```SQL
SELECT COUNT(MartCustomerId) AS CustomersWithNoSales FROM assessmentcustomers
WHERE NOT EXISTS (SELECT MartCustomerId FROM assessmentsales WHERE assessmentcustomers.MartCustomerId = assessmentsales.MartCustomerId);
```
Results
<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1">CustomersWithNoSales</th>
</tr></thead>
<tbody><tr>
<td>6</td>
</tr>
</tbody></table>

**Q7. Select all the AssessmentSales table with an extra column that displays 1 when the ProductSubCategory is 'M-KOPA 4' and 0 for all the other ones. Call it IsMkopa4.**
```SQL
 SELECT *, 
 DENSE_RANK() OVER (PARTITION BY MartCustomerId ORDER BY DateOfSale ASC) AS SaleNumber
 FROM assessmentsales;
```
Results
<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1">MartCustomerId</th>
<th title="Field #2">MartLoanId</th>
<th title="Field #3">DateOfSale</th>
<th title="Field #4">ProductCategory</th>
<th title="Field #5">ProductSubCategory</th>
<th title="Field #6">IsMkopa4</th>
</tr></thead>
<tbody><tr>
<td align="right">939037</td>
<td align="right"> 5040249</td>
<td> 2018-01-24 00:00:00</td>
<td> MK Starter</td>
<td> M-KOPA 4 Starter</td>
<td> 0</td>
</tr>
<tr>
<td align="right">953935</td>
<td align="right"> 5603865</td>
<td> 2018-03-20 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 0</td>
</tr>
<tr>
<td align="right">956589</td>
<td align="right"> 5612579</td>
<td> 2018-03-29 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 0</td>
</tr>
<tr>
<td align="right">960948</td>
<td align="right"> 5624226</td>
<td> 2018-04-13 00:00:00</td>
<td> MK-Classic</td>
<td> M-KOPA 5</td>
<td> 0</td>
</tr>
<tr>
<td align="right">966788</td>
<td align="right"> 5642449</td>
<td> 2018-05-08 00:00:00</td>
<td> MK Clasic</td>
<td> M-KOPA 5</td>
<td> 0</td>
</tr>
<tr>
<td align="right">953935</td>
<td align="right"> 5704876</td>
<td> 2018-04-20 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 0</td>
</tr>
<tr>
<td align="right">1000927</td>
<td align="right"> 5742532</td>
<td> 2018-09-01 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 0</td>
</tr>
<tr>
<td align="right">956589</td>
<td align="right"> 6714976</td>
<td> 2018-04-29 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 0</td>
</tr>
</tbody></table>

**Q8. Select all the AssessmentSales table with an extra column that shows the loan number for each customer: 1 if it's the customer's first sale, 2 if it's the customer's second sale etc.
	#Call it SaleNumber.
```SQL
 SELECT *, 
 DENSE_RANK() OVER (PARTITION BY MartCustomerId ORDER BY DateOfSale ASC) AS SaleNumber
 FROM assessmentsales;
```
Results
<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1"># MartCustomerId</th>
<th title="Field #2">MartLoanId</th>
<th title="Field #3">DateOfSale</th>
<th title="Field #4">ProductCategory</th>
<th title="Field #5">ProductSubCategory</th>
<th title="Field #6">SaleNumber</th>
</tr></thead>
<tbody><tr>
<td align="right">939037</td>
<td align="right"> 5040249</td>
<td> 2018-01-24 00:00:00</td>
<td> MK Starter</td>
<td> M-KOPA 4 Starter</td>
<td> 1</td>
</tr>
<tr>
<td align="right">953935</td>
<td align="right"> 5603865</td>
<td> 2018-03-20 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 1</td>
</tr>
<tr>
<td align="right">953935</td>
<td align="right"> 5704876</td>
<td> 2018-04-20 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 2</td>
</tr>
<tr>
<td align="right">956589</td>
<td align="right"> 5612579</td>
<td> 2018-03-29 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 1</td>
</tr>
<tr>
<td align="right">956589</td>
<td align="right"> 6714976</td>
<td> 2018-04-29 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 2</td>
</tr>
<tr>
<td align="right">960948</td>
<td align="right"> 5624226</td>
<td> 2018-04-13 00:00:00</td>
<td> MK-Classic</td>
<td> M-KOPA 5</td>
<td> 1</td>
</tr>
<tr>
<td align="right">966788</td>
<td align="right"> 5642449</td>
<td> 2018-05-08 00:00:00</td>
<td> MK Clasic</td>
<td> M-KOPA 5</td>
<td> 1</td>
</tr>
<tr>
<td align="right">1000927</td>
<td align="right"> 5742532</td>
<td> 2018-09-01 00:00:00</td>
<td> MK TV</td>
<td> M-KOPA 500</td>
<td> 1</td>
</tr>
</tbody></table>

**Q9. For each customer's age category below (age today), provide the total outstanding balance and the total amount paid in on the 01/08/2018. The results must all be from a single query.**

**- Under 30 years old**

**-  Between 30 and 49 years old**

**- Over 50 years old**
```SQL
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
```

Results
<table class="table table-bordered table-hover table-condensed">
<thead><tr><th title="Field #1">AgeCategory</th>
<th title="Field #2">Outstandingbalance</th>
<th title="Field #3">SumPaidInToDate</th>
</tr></thead>
<tbody></tbody></table>

