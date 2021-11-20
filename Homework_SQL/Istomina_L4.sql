--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop).
--Вывести: model, maker, type
select model, maker, type
from public.product

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех,
--у кого цена вышей средней PC - "1", у остальных - "0"
select *,
case
	when price > (select avg(price) from pc) then 1
	else 0
end flag
from printer

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select name, class
from
(select name, class
from ships 
union all
select distinct ship, NULL as class
from Outcomes
where ship not in (select name from ships)
) as t1
where class is null

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
with rez as (select name, extract(year from date) as year from battles) --extract(year from date) функция обрезки года
select *
from rez
where year not in (select launched from ships)

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select distinct battle
from outcomes o 
where ship in
(select name
from ships
where class = 'Kongo')

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop)
--с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag
create view all_products_flag_300 as

select model, price,
case
	when price > 300 then 1
	else 0
end flag
from
(select model, price
from pc
union all
select model, price
from printer
union all
select model, price
from laptop
) as t1

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop)
-- с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag
create view all_products_flag_avg_price as

with t1 as
(select model, price
from pc
union all
select model, price
from printer
union all
select model, price
from laptop)

select model, price,
case
	when price > (select avg(price) from t1) then 1
	else 0
end flag
from t1

--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'.
--Вывести model
select pr.model
from printer pr
join product p
on pr.model = p.model 
where p.maker = 'A'
and price > (select avg(price)
			 from printer pr
			 join product p
			 on pr.model = p.model
			 where p.maker in ('D', 'C')
			 )

--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'.
--Вывести model
with t as 
(select l.model, price
from laptop l
join product pr
on l.model = pr.model
and maker = 'A'
union all
select pc.model, price
from pc
join product pr
on pc.model = pr.model
and maker = 'A'
union all
select printer.model, price
from printer
join product pr
on printer.model = pr.model
and maker = 'A')

select model
from t
where price > (select avg(price)
			 from printer pr
			 join product p
			 on pr.model = p.model
			 where p.maker in ('D', 'C')
			 )
			 
--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
select avg(price)
from
(select l.model, price
from laptop l
join product pr
on l.model = pr.model
and maker = 'A'
union
select pc.model, price
from pc
join product pr
on pc.model = pr.model
and maker = 'A'
union
select printer.model, price
from printer
join product pr
on printer.model = pr.model
and maker = 'A') as t1

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю.
--Во view: maker, count
create view count_products_by_makers as

select maker, count(*)
from
(select maker, l.model
from laptop l
join product pr
on l.model = pr.model
union
select maker, pc.model
from pc
join product pr
on pc.model = pr.model
union
select maker, printer.model
from printer
join product pr
on printer.model = pr.model
) as t1
group by maker

--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)


--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_updated as

select pr.*
from printer pr
join product p
on pr.model = p.model
where maker != 'D'

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя
--(название printer_updated_with_makers)
create view printer_updated_with_makers as

select pr.*, maker
from printer_updated pr
join product p
on pr.model = p.model

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes).
--Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
select count(*), class
from
(select name, class
from ships 
union all
select distinct ship, NULL as class
from Outcomes
where ship not in (select name from ships)
) as t1
--where class is not null
group by class

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)


--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag:
--если количество орудий больше или равно 9 - то 1, иначе 0
create table classes_with_flag as

select *,
case
	when numguns >= 9 then 1
	else 0
end flag
from classes

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)


--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".
select count (*)
from ships
where name like 'O%' or name like 'M%'

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
select count (*)
from ships
where LENGTH(name) - LENGTH(replace(name, ' ', '')) >= 1
--where name like '% %'

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
