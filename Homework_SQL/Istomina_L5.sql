--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов
--(не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц
create view pages_all_products as

select *,
row_number () OVER (partition by page ORDER BY code) AS place
from
(
select *,
ntile (3) OVER (ORDER BY code) as page
from laptop l
) as a

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение
--всех товаров по типу устройства. Вывод: производитель, тип, процент (%)
create view distribution_by_type as

select *, (count(*) OVER (PARTITION BY type)*100/(select count(*) from product)) as percent
from product

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму.
-- Пример https://plotly.com/python/histograms/


--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов
create table ships_two_words as

select *
from ships
where LENGTH(name) - LENGTH(replace(name, ' ', '')) >= 1

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"
select *
from
(select name, class
from ships 
union all
select distinct ship, NULL as class
from outcomes
where ship not in (select name from ships)
) as a
where class is null
and name like 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C'
--и три самых дорогих (через оконные функции). Вывести model
with t as 
(select maker, l.model, price
from laptop l
join product pr
on l.model = pr.model
and maker = 'A'
union all
select maker, pc.model, price
from pc
join product pr
on pc.model = pr.model
and maker = 'A'
union all
select maker, printer.model, price
from printer
join product pr
on printer.model = pr.model
and maker = 'A')

select model
from
(
	select *,
	row_number (*) OVER (ORDER BY price desc) as top
	from t
	where price > (select avg(price)
			 	from printer pr
			 	join product p
			 	on pr.model = p.model
			 	where p.maker = 'D' --нет производителя принтеров 'C', взяла среднее по 'D'
			 	)
) as tt
where top <= 3
