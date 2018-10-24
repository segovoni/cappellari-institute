USE [Corso2018]
GO


with cteNfs as
(
select  *,  
	postoLibero=row_number() over(partition by rownumber order by rownumber)
from [dbo].[RoomsAndSeats]
where taken=0
)
/*3a*/
, ctecnt as
(
select TOP (1000) *,
	diffSeatsCntlibero= seatnumber-postoLibero
from cteNfs
order by rownumber,SeatNumber
)

/**3b count**/
, cteSeats4Row as
(
select *, totPostiLiberiRow = count(ctecnt.diffSeatsCntlibero)  
	over(partition by ctecnt.rownumber,diffSeatsCntlibero order by ctecnt.rownumber)
from ctecnt
)
/** 3c ... dopo **/ 

, cteGrp as
(
select rownumber,totPostiLiberiRow--, GruppoPostoLibero=row_number() --over(partition by rownumber,totPostiLiberiRow order by rownumber)
from cteSeats4Row
group by rownumber, totPostiLiberiRow
)




INSERT INTO MyFreeSeats
           ([RoomID]
           ,[SeatID]
           ,[RowNumber]
           ,[SeatNumber]
           ,[Taken]
		   ,[postolibero]
		   ,[diffSeatsCntLibero]
		   ,[totPostiLiberiRow]
   
		   )




select roomid,seatid, cteSeats4Row.RowNumber , seatnumber,taken, postolibero,diffseatscntlibero, cteSeats4Row.totPostiLiberiRow
from cteSeats4Row inner join cteGrp 
			on cteSeats4Row.RowNumber = cteGrp.RowNumber 
				and cteSeats4Row.totPostiLiberiRow =cteGrp.totPostiLiberiRow

--select * from myfreeseats

