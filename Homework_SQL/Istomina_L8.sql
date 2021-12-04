--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
select Department, Employee, salary
from (
select d.name as Department, e.name as Employee, e.salary,
dense_rank () OVER (PARTITION BY d.name ORDER BY salary desc) AS total
from employee as e
join department as d
on e.departmentId = d.id) as t
where total <=3

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
SELECT member_name, status, sum(unit_price*amount) as costs
FROM FamilyMembers
INNER JOIN Payments
on member_id=family_member
WHERE date BETWEEN '2005-01-01'and '2005-12-31'
GROUP BY member_name, status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
SELECT name
FROM (select name, count(name) as kol
FROM Passenger
GROUP BY name) as t
WHERE kol > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
SELECT COUNT(first_name) as count
FROM Student
WHERE first_name = 'Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
SELECT SUM(count) as count
FROM (
SELECT classroom, COUNT(classroom) as count
FROM Schedule
WHERE date = '2019-09-02'
GROUP BY classroom) as t

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
дубль task4  (lesson8)

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
SELECT FLOOR(AVG((YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)))) AS age
FROM FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
SELECT good_type_name, sum(unit_price*amount) as costs
FROM GoodTypes as t
JOIN Goods as g
on t.good_type_id = g.type
JOIN Payments as p
on g.good_id = p.good
WHERE date BETWEEN '2005-01-01'and '2005-12-31'
GROUP BY good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
SELECT MIN((YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5))) AS "year"
FROM Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
SELECT MAX((YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5))) AS max_year
FROM Student as s
JOIN Student_in_class as c
on s.id = c.Student
JOIN Class
on c.class = class.id
WHERE class.name like '%10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
SELECT status, member_name, sum(unit_price*amount) as costs
FROM FamilyMembers as f
JOIN Payments as p
ON f.member_id = p.family_member
JOIN Goods as g
ON p.good = g.good_id
JOIN GoodTypes as t
ON g.type = t.good_type_id
WHERE good_type_name = 'entertainment'
GROUP BY status, member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
SELECT company, COUNT(t.id) as kol
FROM Company as c
JOIN Trip as t
on c.id = t.Company
GROUP BY company

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
SELECT classroom
FROM (
SELECT classroom,
dense_rank () OVER (ORDER BY kol desc) AS total
FROM (
SELECT classroom, COUNT(classroom) as kol
FROM Schedule
GROUP BY classroom) as t
) as t1
WHERE total = 1

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
SELECT last_name
FROM Teacher as t
JOIN Schedule as s 
ON t.id = s.teacher
JOIN Subject as su 
ON s.subject = su.id
WHERE su.name = 'Physical Culture'
ORDER BY last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
SELECT CONCAT(last_name, '.', LEFT (first_name, 1), '.', LEFT (middle_name, 1), '.') as name
FROM Student
ORDER BY name
