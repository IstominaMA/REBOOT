--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop).
--�������: model, maker, type
select model, maker, type
from public.product

--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���,
--� ���� ���� ����� ������� PC - "1", � ��������� - "0"
select *,
case
	when price > (select avg(price) from pc) then 1
	else 0
end flag
from printer

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)
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
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.
with rez as (select name, extract(year from date) as year from battles) --extract(year from date) ������� ������� ����
select *
from rez
where year not in (select launched from ships)

--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select distinct battle
from outcomes o 
where ship in
(select name
from ships
where class = 'Kongo')

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop)
--� ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop)
-- � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'.
--������� model
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
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'.
--������� model
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
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)
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
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������.
--�� view: maker, count
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
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)


--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'
create table printer_updated as

select pr.*
from printer pr
join product p
on pr.model = p.model
where maker != 'D'

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� �������������
--(�������� printer_updated_with_makers)
create view printer_updated_with_makers as

select pr.*, maker
from printer_updated pr
join product p
on pr.model = p.model

--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes).
--�� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)
create view sunk_ships_by_classes as

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
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)


--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag:
--���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0
create table classes_with_flag as

select *,
case
	when numguns >= 9 then 1
	else 0
end flag
from classes

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)
select country, count(class) as count_class
from classes
group by country

--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".
select count (*)
from ships
where name like 'O%' or name like 'M%'

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.
select count (*)
from ships
where LENGTH(name) - LENGTH(replace(name, ' ', '')) >= 1
--where name like '% %'

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
select launched as year, count(*)
from ships
group by year