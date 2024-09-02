																#********SET 2********#
                                                                
							/*******1. select all employees in department 10 whose salary is greater than 3000. [table: employee]*******/

  select fname, lname, deptno, salary as Greater_salary
  from employee
  having Greater_salary >= 3000
  order by Greater_salary desc;
  
  
											/*****  2. The grading of students based on the marks they have obtained is done as follows:

											40 to 50 -> Second Class
												50 to 60 -> First Class
												60 to 80 -> First Class
												80 to 100 -> Distinctions
											a. How many students have graduated with first class?
											b. How many students have obtained distinction? [table: students] *****/

										/****a. How many students have graduated with first class?****/

Select count(*) as Graduated_Frist_Class 
from students 
where marks between 50 and  80; #13


										/*****b. How many students have obtained distinction?*****/

Select count(*) as Distinction_Class 
from students 
where marks between 80 and 100; #11



/*****3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]******/

select distinct id,city 
from station
WHERE MOD(id, 2) = 0
order by id;

# 2nd pattern

SELECT DISTINCT city ,id
FROM station
WHERE id%2=0;


/*****4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, write a query to find the value of N-N1 from station.
[table: station]*****/

select ((select count(city) as result1 from station)-(select count(distinct city)
       as result1)) as Final_Result
       
       from station;#30
       
       
select (count(city)-count(distinct city)) as result 
from station;#30


												/****5. Answer the following****/
                                                
/****5.a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.****/

SELECT DISTINCT city 
FROM STATION 
WHERE city LIKE 'a%' OR city LIKE 'e%' OR city LIKE 'i%' OR city LIKE 'o%' OR city LIKE 'u%'
order by city;

SELECT DISTINCT(CITY)
FROM STATION 
WHERE SUBSTR(CITY, 1, 1) IN ('A', 'E', 'I', 'O', 'U');

/*****b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.****/

SELECT DISTINCT city 
FROM station 
WHERE city REGEXP '^[aeiou].*[aeiou]$'
order by city;

/****c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.****/

SELECT DISTINCT city 
FROM STATION 
WHERE city NOT LIKE 'a%' AND  city NOT LIKE 'e%' AND city NOT LIKE 'i%' AND city NOT LIKE 'o%' AND city NOT LIKE 'u%'
order by city;

/****d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.*****/

SELECT DISTINCT city 
FROM station 
WHERE city REGEXP '[^aeiouAEIOU]|[^aeiouAEIOU]$'
ORDER BY city;

/*******6. Write a query that prints a list of employee names having a salary greater than $2000 per month who have been employed for less than 36 months. 
													Sort your result by descending order of salary. *****/                                                    

SELECT *
FROM Emp 
WHERE Salary >=2000
  AND hire_Date >= DATE_SUB(CURRENT_DATE, INTERVAL 36 MONTH)
ORDER BY emp_no ASC;


							/***** 7. How much money does the company spend every month on salaries for each department?? [table: employee]******/
                            
																		/*****Expected Result
																		----------------------
																		+--------+--------------+
																		| deptno | total_salary |
																		+--------+--------------+
																		|     10 |     20700.00 |
																		|     20 |     12300.00 |
																		|     30 |      1675.00 |
																		+--------+--------------+
																		3 rows in set (0.002 sec)******/
                                                                        
select deptno as DeptNo,sum(salary) as total_Salary
from employee
group by deptno;

								   /****8. How many cities in the CITY table have a Population larger than 100000. [table: city]****/              

select count(*)
from city
where population >=100000; #11

select  name, district, population 
from city
where population >=100000;


											/*****9. What is the total population of California? [table: city]*****/
                                            
SELECT SUM(population) as Population_Of_California
FROM city
WHERE district = "California";
                 
									 /****10. What is the average population of the districts in each country? [table: city]*****/   

select countrycode, avg(population) as AVerage_Population
from city
where countrycode in('JPN', 'USA', 'NLD')
group by countrycode;
                                   
                                   
                                   
      /**** 11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers] ****/
      
SELECT 
C.customerNumber,
O.orderNumber,
C.customerName,
O.status,
O.comments

FROM customers C
INNER JOIN orders O
USING(customerNumber)
where status="Disputed"
GROUP BY C.customerNumber
order by C.customerNumber;
 