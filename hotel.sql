
-- Data Cleaning & Analysis

-- merging tabes into single commom table

select  * into  dbo.hotel
 from [dbo].[2018]
union
select * from [dbo].[2019]
union
select * from [dbo].[2020]

--- Checking Overall count After combining the tables
select count(*) from dbo.hotel
-- Checking the records after Combining 3 tables 
select * from dbo.hotel

-- Changing Date field to mm-dd-yyyy format

alter table dbo.hotel
alter column  [reservation_status_date] nvarchar(20)

update  dbo.hotel
set [reservation_status_date]= 

case when [reservation_status_date] like '%-%'
then format(cast ([reservation_status_date] as date),'MM-dd-yyyy')
else null
end

alter table dbo.hotel
alter column  [reservation_status_date] date

---------- view  other tableds
select * from 
[dbo].[market_segment]

select * from 
[dbo].[meal_cost]


--Using joins  Creating a common table ...

select a.*,b.Discount,c.Cost from dbo.hotel a
join
[dbo].[market_segment] b
on a.market_segment=b.market_segment
join
[dbo].[meal_cost] c
on a.meal=c.meal
--------- creating new clmns for total price &Total_Nights  with adr,discount clmns
alter table dbo.hotel
add  Total_Price float

alter table dbo.hotel
add  Total_Nights  int
-- --------- updating  new clmns for total price with adr,discount clmns
;with cte as(
select a.*,b.Discount,c.Cost from dbo.hotel a
join
[dbo].[market_segment] b
on a.market_segment=b.market_segment
join
[dbo].[meal_cost] c
on a.meal=c.meal
)

update  h
set Total_Price=  c.adr*c.discount 
from dbo.hotel h
join cte c
on h.adr=c.adr
and h.arrival_date_day_of_month=c.arrival_date_day_of_month
and h.company=c.company
and h.country=c.country
and h.hotel=c.hotel

-- --------- updating  new clmns for total nights with stays_in_week_nights & stays_in_weekend_nights  clmns
;with cte as(
select a.*,b.Discount,c.Cost from dbo.hotel a
join
[dbo].[market_segment] b
on a.market_segment=b.market_segment
join
[dbo].[meal_cost] c
on a.meal=c.meal
)

update  h
set Total_Nights=  c.stays_in_week_nights+c.stays_in_weekend_nights 
from dbo.hotel h
join cte c
on h.adr=c.adr
and h.arrival_date_day_of_month=c.arrival_date_day_of_month
and h.company=c.company
and h.country=c.country
and h.hotel=c.hotel

--- view creation 
create view Hotel_Data as

select a.*,b.Discount,c.Cost from dbo.hotel a
join
[dbo].[market_segment] b
on a.market_segment=b.market_segment
join
[dbo].[meal_cost] c
on a.meal=c.meal




