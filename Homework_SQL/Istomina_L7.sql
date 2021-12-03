--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
select email from
(
  select email, count(email) as kol
  from person
  group by email
) as t1
where kol > 1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select t.name as employee
from employee as t 
join employee as t1
on t.managerId = t1.id
and t.salary > t1.salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
select score,
dense_rank () over (order by score desc) as "rank"
from scores

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select firstName, lastName, city, state
from person as p
left join address as a
on p.personid = a.personid