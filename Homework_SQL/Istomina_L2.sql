--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- ������� 1: ������� name, class �� ��������, ���������� ����� 1920
select name, class
from ships
where launched > 1920

-- ������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942
select name, class
from ships
where launched > 1920 and launched <= 1942
 
-- ������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class
select count (name), class
from ships
group by class

-- ������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)
select class, country
from classes
where bore >= 16

-- ������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.
select ship
from outcomes
where battle = 'North Atlantic'
and result = 'sunk'

-- ������� 6: ������� �������� (ship) ���������� ������������ �������
select ship
from outcomes
join battles
on battle = name
where result = 'sunk'
and date = (select max (date) from battles join outcomes on battle = name)

-- ������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������
select ship, class
from outcomes o
left join battles b
on battle = b.name
left join ships s
on o.ship = s.name
where result = 'sunk'
and date = (select max (date) from battles join outcomes on battle = name)

-- ������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class
select ship, class
from outcomes o
left join  classes
on ship = class
where bore >= 16
and result = 'sunk'

-- ������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class
select class
from classes
where country = 'USA'

-- ������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class
select name, c.class
from ships s
join classes c
on s.class = c.class
where country = 'USA'

-- ������� 20: ������� ������� ������ hd PC ������� �� ��� ��������������, ������� ��������� � ��������. �������: maker, ������� ������ HD.
select product.maker, avg(pc.hd)
from pc
join product
on product.model = pc.model
where product.maker in (select distinct maker from printer join product on product.model = printer.model)
group by product.maker
