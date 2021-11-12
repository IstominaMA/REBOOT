--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
select name, class
from ships
where launched > 1920

-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
select name, class
from ships
where launched > 1920 and launched <= 1942
 
-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
select count (name), class
from ships
group by class

-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
select class, country
from classes
where bore >= 16

-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
select ship
from outcomes
where battle = 'North Atlantic'
and result = 'sunk'

-- Задание 6: Вывести название (ship) последнего потопленного корабля
select ship
from outcomes
join battles
on battle = name
where result = 'sunk'
and date = (select max (date) from battles join outcomes on battle = name)

-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
select ship, class
from outcomes o
left join battles b
on battle = b.name
left join ships s
on o.ship = s.name
where result = 'sunk'
and date = (select max (date) from battles join outcomes on battle = name)

-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
select ship, class
from outcomes o
left join  classes
on ship = class
where bore >= 16
and result = 'sunk'

-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
select class
from classes
where country = 'USA'

-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
select name, c.class
from ships s
join classes c
on s.class = c.class
where country = 'USA'

-- Задание 20: Найдите средний размер hd PC каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.
select product.maker, avg(pc.hd)
from pc
join product
on product.model = pc.model
where product.maker in (select distinct maker from printer join product on product.model = printer.model)
group by product.maker
