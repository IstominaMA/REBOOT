--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������.
--�������: ����� � ����� ����������� ��������.
with sunk as (
select class, count(class) as col
from outcomes o
left join ships s 
on s.name = o.ship
where result = 'sunk'
group by class)
select distinct c.class,
case 
	when col is NULL then 0
	else col
end col
from classes c
left join sunk u
on c.class = u.class

--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������.
--���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.
select ships.class, min(ships.launched)
from classes 
join ships
on classes.class = ships.class 
group by ships.class

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.
with col as (
select class, count(class) as col
from ships s
group by class)
select c.class, count(c.class) as kol
from classes c
left join ships s
on c.class = s.class
left join outcomes o
on s.name = o.ship
left join col cc
on c.class = cc.class
where result = 'sunk'
and col >= 3
group by c.class

--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� �������������
--(������ ������� �� ������� Outcomes).
select name
from (
select o.ship as name, numguns, displacement
from outcomes o
join classes c
on o.ship = c.class
UNION
select s.name as name, numguns, displacement
from ships s
join classes c
on s.class = c.class
) as t1
join
(select max(numguns) as maxguns, displacement
from outcomes o 
join classes c 
on o.ship = c.class
group by displacement
UNION
select max(numguns) as maxguns, displacement
from ships s
join classes c
on s.class = c.class
group by displacement
) as t2
on t1.numguns = t2.maxguns
and t1.displacement = t2.displacement

--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM
--� � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker
with t as(
select p.maker, min(ram) as minram, max(speed) as maxspeed
from pc
join product p
on pc.model = p.model
join
(select p.maker, min(ram) as minram
from pc
join product p
on pc.model = p.model
group by p.maker
) as t1
on t1.maker = p.maker
and t1.minram = minram 
group by p.maker
)

select distinct p.maker
from printer pr
join product p
on pr.model = p.model
where p.maker in (select maker from t)
