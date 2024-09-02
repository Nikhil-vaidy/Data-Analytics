								/******1. Write a stored procedure that accepts the month and year as inputs and 
								prints the ordernumber, orderdate and status of the orders placed in that month.*****/ 

delimiter //

create procedure Order_Status(in order_year int, order_month int)

begin

select orderNumber, orderDate, status, comments
from orders
where year (orderDate)= order_year and month (orderDate)= order_month;

end//

call order_status(2005, 3);


					/*****2. Write a stored procedure to insert a record into the cancellations table for all cancelled orders.******/

												/****a.	Create a table called cancellations with the following fields
												id (primary key), 
													customernumber (foreign key - Table customers), 
												ordernumber (foreign key - Table Orders), 
												comments
												All values except id should be taken from the order table.****/

create table cancellations(
ID int primary key ,
customernumber int,
foreign key(customernumber) references customers(customernumber),
ordernumber int,
foreign key (ordernumber) references orders(ordernumber),
comments varchar(500)
);

insert into cancellations(ID,ordernumber,customernumber,comments)
values(1,10167,448,"customer called to cancel. "),
           (2,10179,496,"customer cancelled due to urgent budgeting issue."),
           (3,10248,131,"order was mistakenly placed."),
           (4,10253,201,"customer disputed the order and we agreed to cancel it."),
           (5,10260,357,"customer heard complaints from their customers and called to cancel this order."),
           (6,10262,141,"this customer found a better offer from one of our competitors.");
           
           
          /**** 3. a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments]
							if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
							if amount > 50000 Platinum****/

delimiter //
create procedure getcustomerstatus(in pcustomernumber int,out pcustomerstatus varchar(20))
begin
declare credit  decimal;


select creditlimit into credit
from customers
where customernumber = pcustomernumber;
if
credit > 5000 then
set pcustomerstatus ="platinum";

elseif
credit between 2500 and 5000 then
set pcustomerstatus = "Gold";

else set pcustomerstatus ="silver";
end if;
end //

call getcustomerstatus(103,@status);
select @status as purchase_status;



				/*****b. Write a query that displays customerNumber, customername and purchase_status from customers table.*****/

select customernumber,customername,@status as purchase_status
from customers;


			/****4. Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. 
			Note: Both tables - movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above.****/

delimiter //
create trigger trigger_onupdate
after update
on movies
for each row
begin
   update rentals
   set movieid=id
   where movieid=new.id;
end //

delimiter //
create trigger trigger_ondelete
after delete
on movies
for each row

begin
   delete from rentals
   where movieid 
   not in (select distinct id from mvoies);

   end //


				/****5. Select the first name of the employee who gets the third highest salary. [table: employee]****/

select Fname from employee
order by salary desc
limit 1;



/****6. Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1. [table: employee]*****/

SELECT Dense_RANK() OVER(order by salary desc) AS Ranking,
empid,fname,lname,deptno,salary
 FROM employee;






