select * from Worker

--1. Write a query to display all the first_name  in upper case
select upper(FIRST_name) as "Upper first_name" from Worker

--2. Write a querty to display unique department from workers table
select distinct(department)as "unique dept" from Worker

--3. Write an SQL query to print the first three characters of FIRST_NAME from Worker table
select left(FIRST_name,3) as "first 3 char" from Worker

-- 4.Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.

select CHARINDEX('a',FIRST_name) as "Pos of 'a'" from worker
where FIRST_name = 'Amitabh'

-- 5.Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length

select distinct(department)  as  "Unique Dep", len(department) as "Length Unique Dep"  from worker


-- 6.Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending
select * from worker 
order by FIRST_name asc,department desc;

--7. Write a query to get workers whose name are Vipul and Satish
select * from worker
where FIRST_name in ('Satish','Vipul')

--8. Write an SQL query to print details of the Workers whose FIRST_NAME contains 'a'
select * from worker
where FIRST_name like '%a%'

-- 9.Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets
select * from worker
where FIRST_name like '_____h'

--10. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000
select * from worker
where salary between 100000 and 500000


--11. Write an SQL query to print details of the Workers who have joined in Feb’2020
select * from worker
WHERE month(joining_date)=02 and year(joining_date)=2020 

--12. Write an SQL query to fetch the count of employees working in the department ‘Admin’
select count(*) as "working in the department Admin" from worker
where department='Admin'

-- 13.Write an SQL query to fetch the no. of workers for each department in the descending order
select department,count(*) as "working in the department" from worker
group by department

--14. Write a query to display workerrs who are manager (Admin)
select first_name,last_name, department from worker
where department='Admin'

--15. Write query to find duplicate rows title table
select worker_title,affected_from,count(*) as "No of times repeated" from title
group by  worker_title,affected_from
having count(*)>1

--16. Write an SQL query to show all workers who got the bonus along with bonus amount
select b.worker_ref_id,  sum(b.bonus_amount)as "Total  bonus"  from bonus as b inner join Worker  as w on b.worker_ref_id = worker_id
group by b.worker_ref_id

--17. Write a query to find employees in worker table that do not exist in bonus table (ie did not get bonus)
select distinct w.first_name, w.last_name from worker as w inner join bonus as b on b.worker_ref_id != worker_id

--18. Write a query to find the highest 2 salaries
select  top 2 * from worker
order by salary desc

--19. Find 2nd highest without using TOP or LIMIT
with salaryrank as
(select first_name,salary, DENSE_RANK() over (order by salary desc)  as "ranker" from worker)

select * from salaryrank
where ranker = 2

--20. Find people who have the same salary

select w1.first_name,w1.salary 
from worker w1
join worker w2 
on w1.salary=w2.salary 
where w1.worker_id <> w2.worker_id



--21. Write a query to fetch 1st 50% records without using Top
select * from 
(
  select worker_id,first_name,salary, ROW_NUMBER() OVER(order by worker_id) as row_num,
  count(*) over() as total_rows 
  from worker)
  as row_table
where row_num <= ceiling(0.5 *total_rows)

--22. Write a query to select a department with more than 3 people in worker table
select count(first_name),department from worker
group by department
having count(first_name)>3

--23 Write a query to select 1st and last row of a worker table
select worker_id,department from 
(select worker_id,department,
	ROW_NUMBER() over (order by worker_id) as rownumasc,
	ROW_NUMBER() over (order by worker_id desc) as rownumdesc
	from worker) as numberrows
where rownumasc = 1 or rownumdesc=1


--24. Write a query to select last 5 entries from worker table
select top 5 worker_id ,first_name ,department from worker
order by worker_id desc

--25. Write a query to select people with highest salary in each group
select top 5 worker_id ,first_name ,salary from worker
order by salary desc

--26. Write a query to fetch departments along with the total salaries paid for each of them
select department, sum(salary) as totalsalpaid from worker
group by department

--27. Write a query to fetch the names of workers who earn the highest salary
select first_name,salary from worker
where salary= (select max(salary) from worker)















