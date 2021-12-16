--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
select
case
when g.Grade > 7 then s.Name
else 'NULL'
end name,
g.Grade, s.Marks
from Students s
join Grades g
on s.marks between g.min_mark and g.max_mark
order by g.grade desc, name asc, s.marks asc;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
select
case when d.name is not NULL then d.name
else 'NULL'
end Dname,
case when p.name is not NULL then p.name
else 'NULL'
end Pname,
case when s.name is not NULL then s.name
else 'NULL'
end Sname,
case when a.name is not NULL then a.name
else 'NULL'
end Aname 
from 
(select name, row_number() OVER (PARTITION BY occupation ORDER BY name) n from OCCUPATIONS where occupation = 'Doctor') D
full join
(select name, row_number() OVER (PARTITION BY occupation ORDER BY name) n from OCCUPATIONS where occupation = 'Professor') P on d.n = p.n
full join 
(select name, row_number() OVER (PARTITION BY occupation ORDER BY name) n from OCCUPATIONS where occupation = 'Singer') S on p.n = s.n
full join
(select name, row_number() OVER (PARTITION BY occupation ORDER BY name) n from OCCUPATIONS where occupation = 'Actor') A on s.n = a.n;

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
select distinct CITY
from STATION
where left (city,1) not in ('A','E','I','O','U');

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
SELECT DISTINCT City 
FROM Station
WHERE City NOT LIKE '%a' AND City NOT LIKE '%e' AND City NOT LIKE '%i' AND City NOT LIKE '%o' AND City NOT LIKE '%u'
ORDER BY City;

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
SELECT DISTINCT City 
FROM Station 
WHERE (City NOT LIKE '%a' AND City NOT LIKE '%e' AND City NOT LIKE '%i' AND City NOT LIKE '%o' AND City NOT LIKE '%u')
OR (City NOT LIKE 'A%' AND City NOT LIKE 'E%' AND City NOT LIKE 'I%' AND City NOT LIKE 'O%' AND City NOT LIKE 'U%')
ORDER BY City;

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
SELECT DISTINCT City 
FROM Station 
WHERE (City NOT LIKE '%a' AND City NOT LIKE '%e' AND City NOT LIKE '%i' AND City NOT LIKE '%o' AND City NOT LIKE '%u')
AND (City NOT LIKE 'A%' AND City NOT LIKE 'E%' AND City NOT LIKE 'I%' AND City NOT LIKE 'O%' AND City NOT LIKE 'U%')
ORDER BY City;

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
SELECT NAME
FROM Employee
WHERE salary > 2000
AND months < 10
ORDER BY employee_id;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
Дубль task1  (lesson9)
